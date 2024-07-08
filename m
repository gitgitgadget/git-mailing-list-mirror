Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D29114F9DF
	for <git@vger.kernel.org>; Mon,  8 Jul 2024 22:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720479142; cv=none; b=Q21puiNKfPkZ2JjU7kc0CYkGaMRJENxCKdMk3p6BYfG7odAad7hhynJADeyQkjgMT4uZdGMlub4oCncWxltV6G7GN1/mIOczHqFI3r7ETJHGuFAg0WPFjmIAvZQLV4XTKtBAlGoITbmp236uXTo1zvG55aGtYPcyg1Z2yPszGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720479142; c=relaxed/simple;
	bh=LDhv5kJKLqfDOiLzZBCwTbkfk7QyL4+sJkCwUo1pIm8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dgKBnFTTQ+r7UEhCc3XqxxQD178qYqxBAD8vuZ/zVZRPj6Fg8m8ZjYGh6TL0J0mJleyIUUdbuIWaAe/j33fo0+NK/Jvlrrr7fQIjtg1yB+DXqZ12c6Bq0PepnnU/2S4dLCUQ6r7L6TXsWhBquQeCathsUvc5uDegxEs3pKQ1l6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=EyMgD15l; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="EyMgD15l"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id CE3D724618;
	Mon,  8 Jul 2024 18:52:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LDhv5kJKLqfDOiLzZBCwTbkfk7QyL4+sJkCwUo
	1pIm8=; b=EyMgD15lKAy200IqF0KOVh3KFhbv3WW87nZnJW4tbMTP9BilSGk3EP
	mXlk9CeAqs0+ZEuQQvVEswVJTeIlfW0+XGBW/wbw8f7vpGNCO4JEK/SC5KhGtL2+
	Sf6VKXw/3dKlOXrWLNaH8I/bqT8zw/fV3JqNgeBGdTMYdsxKg6DyM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id C718824617;
	Mon,  8 Jul 2024 18:52:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.219.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3B84B24615;
	Mon,  8 Jul 2024 18:52:13 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,  jltobler@gmail.com,
  chriscool@tuxfamily.org
Subject: Re* [PATCH 7/8] ci: run style check on GitHub and GitLab
In-Reply-To: <xmqqr0c3hkjs.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	08 Jul 2024 10:15:35 -0700")
References: <20240708092317.267915-1-karthik.188@gmail.com>
	<20240708092317.267915-8-karthik.188@gmail.com>
	<xmqqr0c3hkjs.fsf@gitster.g>
Date: Mon, 08 Jul 2024 15:52:11 -0700
Message-ID: <xmqqwmlvcx9g.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B751FD9E-3D7C-11EF-841B-965B910A682E-77302942!pb-smtp2.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> I think the consensus from the last discussion we had was to allow
> scripts that rely on bash-isms to say "#!/usr/bin/env bash" because
> we know /bin/sh can legitimately be not bash and we assume bash may
> not be installed as /bin/bash.

Let's do this before we forget.

------- >8 ------------- >8 ------------- >8 -------
Subject: [PATCH] ci: unify bash calling convention

Under ci/ hierarchy, we run scripts under either "sh" (any Bourne
compatible POSIX shell would work) or specifically "bash" (as they
require features from bash, e.g., $(parameter/pattern/string}
expansion).  As we have the CI envionment under our control, we can
expect that /bin/sh will always be fine to run the scripts that only
require Bourne, but we may not know where "bash" gets installed
depending on distros.

So let's make sure we start these scripts with either one of these:

	#!/bin/sh
	#!/usr/bin/env bash

Yes, the latter has to assume that everybody installs "env" at that
path and not as /bin/env or /usr/local/bin/env, but this currently
is the best we could do.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 ci/check-directional-formatting.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ci/check-directional-formatting.bash b/ci/check-directional-formatting.bash
index e6211b141a..3cbbb7030e 100755
--- a/ci/check-directional-formatting.bash
+++ b/ci/check-directional-formatting.bash
@@ -1,4 +1,4 @@
-#!/bin/bash
+#!/usr/bin/env bash
 
 # This script verifies that the non-binary files tracked in the Git index do
 # not contain any Unicode directional formatting: such formatting could be used
-- 
2.45.2-924-g22c02b0a17

