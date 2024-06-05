Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479B61373
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 21:43:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717623795; cv=none; b=lziR9Ub7f3TfZcXVhELExODs5L5qFF7XnlcIGzkkOgToo1vOCks8dbJGuTU9KPleuTRE4idAOqdWHYVImqrlADtpT+aaYkEKf+XVA9DvSMUBc3oDROww/+dXz/Ff0rLefvYQG3m7ZYWpOf9qR2TvhRGrA7Lv3k7O2+mY3LAWrJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717623795; c=relaxed/simple;
	bh=gfqjhj0JM1QZ9Ipx7+G/FsCi8qreuUVZI/lkxhNQxK8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=umeHnAXNYbA23BHWoAXwXFBl043U41IkXHHjiZSSv3i+HRUcHzv8aTU4ub0EofU6nVADXGXXnMeoXwe8Q/Ug5O5x2qYnIeZhQAk3lD/ot2MQWGbaUvTLVyzzr3AbLu3UJ5tT/ezpckJ8lzttu+lFmk9QduNtUkjhJI263i15dd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mJq0vl/A; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mJq0vl/A"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B519227D69;
	Wed,  5 Jun 2024 17:43:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=gfqjhj0JM1QZ9Ipx7+G/FsCi8qreuUVZI/lkxh
	NQxK8=; b=mJq0vl/AHTlqEOGEwfmXGGoMraHaM5iHXhupJjk5da+Bc7h6LPH/CQ
	7A39RQfgA+3sif6biuIjjfdAzS65ETtfjspjRAUrxm1j6TlNUwBLtnUR71/iAl51
	669PvW9uuiaddr2m7pUY7CpmaTAwz6gFNG5PRb0d/spZYOr5n4U7Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 775B027D68;
	Wed,  5 Jun 2024 17:43:06 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7C6D727D67;
	Wed,  5 Jun 2024 17:43:05 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>,  Taylor Blau <me@ttaylorr.com>,
  Jeff King <peff@peff.net>,  John Cai <johncai86@gmail.com>,  Dhruva
 Krishnamurthy <dhruvakm@gmail.com>
Subject: [PATCH] attr.tree: HEAD:.gitattributes is no longer the default in
 a bare repo
In-Reply-To: <xmqqzft6aozg.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Fri, 03 May 2024 08:34:27 -0700")
References: <CAKOHPAn1btewYTdLYWpW+fOaXMY+JQZsLCQxUSwoUqnnFN_ohA@mail.gmail.com>
	<20240501220030.GA1442509@coredump.intra.peff.net>
	<ZjLfcCxjLq4o7hpw@nand.local> <ZjPOd83r+tkmsv3o@nand.local>
	<xmqqfrv0ds7f.fsf@gitster.g> <ZjPTlrMdpI+jXxyW@nand.local>
	<CAOLa=ZRe6eWJ_ZyH+HRq=6Lh0-xZ=1X2Z2f3HW4+EVXNquaDTQ@mail.gmail.com>
	<xmqqbk5ndiqk.fsf@gitster.g>
	<CAKOHPA==xgRBLXmyURkdZ9X4LqQoBHYy=XD0Q_KTQHbK54DOFg@mail.gmail.com>
	<xmqqzft6aozg.fsf_-_@gitster.g>
Date: Wed, 05 Jun 2024 14:43:03 -0700
Message-ID: <xmqqa5jzqd5k.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 97727E0C-2384-11EF-9A4E-B84BEB2EC81B-77302942!pb-smtp1.pobox.com

51441e64 (stop using HEAD for attributes in bare repository by
default, 2024-05-03) has addressed a recent performance regression
by partially reverting a topic that was merged at 26dd307c (Merge
branch 'jc/attr-tree-config', 2023-10-30).  But it forgot to update
the documentation to remove the mention of a special case in bare
repositories.

Let's update the document before the update hits the next release.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/attr.txt | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git c/Documentation/config/attr.txt w/Documentation/config/attr.txt
index 1a482d6af2..c4a5857993 100644
--- c/Documentation/config/attr.txt
+++ w/Documentation/config/attr.txt
@@ -1,7 +1,6 @@
 attr.tree::
 	A reference to a tree in the repository from which to read attributes,
-	instead of the `.gitattributes` file in the working tree. In a bare
-	repository, this defaults to `HEAD:.gitattributes`. If the value does
-	not resolve to a valid tree object, an empty tree is used instead.
+	instead of the `.gitattributes` file in the working tree. If the value
+	does not resolve to a valid tree object, an empty tree is used instead.
 	When the `GIT_ATTR_SOURCE` environment variable or `--attr-source`
 	command line option are used, this configuration variable has no effect.
