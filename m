Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 992683DABF9
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 20:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711398637; cv=none; b=NX2NcflOohuGeXRn95YVV+v/r4j/bCsv6DIwWlww+67D0H1Gy05YWFLR/r8d+1NIsSwl97cBFOD7HynACG3XEVKDqXfPxK45GlMOUoFPdy4T9qDBjDQzLy7pFAMzn9e1EMZeduux/Zxc1Jtv3xjl/UhEw3538GC9Axyx3V7Wgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711398637; c=relaxed/simple;
	bh=D38fzxfdP3l+peC7A8WVT/T/2TeCpK6l9fAeoY4CPyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eXIKffFNjpdyduVQXOZfCp38c6TZ5YuKHTZ1I7DyfaoBc6ynI3s/az3b3/LIJnrCI9uLOVcx5IYQqhD4Px+/MLAaSiYBxXrgL3USKV5k1S3aAgXrmqE4ssVKcYJ3bzVmktj5yokMjNLzCz5tvpG1iKDiijEYFI2/rBKGkxQ1hns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KFnOkHV6; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KFnOkHV6"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 64F421E9F08;
	Mon, 25 Mar 2024 16:30:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=D38fzxfdP3l+peC7A8WVT/T/2TeCpK6l9fAeoY
	4CPyM=; b=KFnOkHV65zPaI3JvcccxemkEJw1s9jvMRDEziTh0KpOthbEqOonbE0
	iqUrg4am9dqBBvduqNpY++gfF0KfwJubxbQLPvxa0vKplJdEGH125XjO8Hbh0F0b
	bQYpOhKx7vFk4FxrNMnSDuwnDODs+yt7KZxQTuwBJFifwo3s1GI6w=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 5B7CA1E9F07;
	Mon, 25 Mar 2024 16:30:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD0F41E9F06;
	Mon, 25 Mar 2024 16:30:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/11] midx-write: initial commit
In-Reply-To: <ffa8ba18de8be68eb8dbb1e17b5bf8800f564505.1711387439.git.me@ttaylorr.com>
	(Taylor Blau's message of "Mon, 25 Mar 2024 13:24:18 -0400")
References: <cover.1711387439.git.me@ttaylorr.com>
	<ffa8ba18de8be68eb8dbb1e17b5bf8800f564505.1711387439.git.me@ttaylorr.com>
Date: Mon, 25 Mar 2024 13:30:32 -0700
Message-ID: <xmqq1q7yjbpz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 87DDB41A-EAE6-11EE-87FC-25B3960A682E-77302942!pb-smtp2.pobox.com

Taylor Blau <me@ttaylorr.com> writes:

> Introduce a new empty midx-write.c source file. Similar to the
> relationship between "pack-bitmap.c" and "pack-bitmap-write.c", this
> source file will hold code that is specific to writing MIDX files as
> opposed to reading them (the latter will remain in midx.c).
>
> This is a preparatory step which will reduce the overall size of midx.c
> and make it easier to read as we prepare for future changes to that file
> (outside the immediate scope of this series).
>
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> ---
>  Makefile     | 1 +
>  midx-write.c | 2 ++
>  2 files changed, 3 insertions(+)
>  create mode 100644 midx-write.c
>
> diff --git a/Makefile b/Makefile
> index 4e255c81f2..cf44a964c0 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1072,6 +1072,7 @@ LIB_OBJS += merge-ort-wrappers.o
>  LIB_OBJS += merge-recursive.o
>  LIB_OBJS += merge.o
>  LIB_OBJS += midx.o
> +LIB_OBJS += midx-write.o
>  LIB_OBJS += name-hash.o
>  LIB_OBJS += negotiator/default.o
>  LIB_OBJS += negotiator/noop.o
> diff --git a/midx-write.c b/midx-write.c
> new file mode 100644
> index 0000000000..214179d308
> --- /dev/null
> +++ b/midx-write.c
> @@ -0,0 +1,2 @@
> +#include "git-compat-util.h"
> +#include "midx.h"

I noticed that "nm midx-write.o" after this step gives us nothing.
A source that produces absolutely nothing may not successfully
compile everywhere.  It is unlikely we will stop the series at this
step and it won't break bisection, though.

I do not quite see why the first 3 patches need to be split this
way, rather than being done as a single step.  Is it making the
review any simpler?
