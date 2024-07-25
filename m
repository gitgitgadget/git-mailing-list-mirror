Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4AA9199E9F
	for <git@vger.kernel.org>; Thu, 25 Jul 2024 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721928455; cv=none; b=T6aiGAVlaxMh/IwVzit62lHER1O2oBMh5l8t3LPpIZXTGeynYULEH/XCFIxBL1lrRfoBorB0NcuHZLjUmjl86srHdqo9LVFZJBuODOBcE9z5N4x2DKW+9aGZBFsBNvzlDO8s0vJSJf70zfuMlm8h4ZRFmAF4rAulkXTbvmxOqdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721928455; c=relaxed/simple;
	bh=COdESij+63hB5Cg/FGIbRZrg3XUmEGf12DD7l9BiI4Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=p/Dk/IAxQQutWwkDLHC+3mrSXgCC+XR8ZtnFSpSH9eyHEsQBB0WwIu1WyyRLTIQ8jvA0P+rsK9QRvxo4SgOKsKOq8vVRS6ifWUuFqSycJnJGss9zsuv2rJ7jp2phAo2R62wQUp0v3rya2GsN0vsDSfiaSTxrQnua6krFJEIiE7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=mlkcVK+5; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="mlkcVK+5"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 2E61E29B3A;
	Thu, 25 Jul 2024 13:27:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=C
	OdESij+63hB5Cg/FGIbRZrg3XUmEGf12DD7l9BiI4Y=; b=mlkcVK+501i42Anr/
	M5r8bvDYuWpo5J2zXMRKjg1JeLhxCuPGU2fyZHj6PndBk8ZFNC5baXku0/cH7/VD
	zBNXqFQptrUXEZvYxeUzVokOa5tMMNqcxQTXAPV6zGlt6U7u6OFaWll65ZXkCCci
	dD2BFOP5aRjpY14R47ZR1M/i1w=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 27BBE29B39;
	Thu, 25 Jul 2024 13:27:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A939329B37;
	Thu, 25 Jul 2024 13:27:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH] doc: difference in location to apply is "offset", not "fuzz"
Date: Thu, 25 Jul 2024 10:27:29 -0700
Message-ID: <xmqqplr1fkla.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 2BD58E34-4AAB-11EF-BD9E-9625FCCAB05B-77302942!pb-smtp21.pobox.com

The documentation to "git rebase" says that the line numbers (in the
rebased change) may not exactly be the same as the line numbers the
change gets replayed on top of the new base, but uses a wrong noun
"fuzz".  It should have said "offset".

They are both terms of art.  "fuzz" is about context lines not
exactly matching.  "offset" is about the difference in the location
that a change was taken from the original and the change gets
replayed on the target.  "offset" is often inevitable and part of
normal life.  "fuzz" on the other hand is often a sign of trouble
(and indeed "Git" refuses to apply a change with "fuzz", except
there are options to be fuzzy about whitespaces).

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-rebase.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git c/Documentation/git-rebase.txt w/Documentation/git-rebase.txt
index 74df345f9e..b18cdbc023 100644
--- c/Documentation/git-rebase.txt
+++ w/Documentation/git-rebase.txt
@@ -737,7 +737,7 @@ The 'apply' backend works by creating a sequence of patches (by calling
 `format-patch` internally), and then applying the patches in sequence
 (calling `am` internally).  Patches are composed of multiple hunks,
 each with line numbers, a context region, and the actual changes.  The
-line numbers have to be taken with some fuzz, since the other side
+line numbers have to be taken with some offset, since the other side
 will likely have inserted or deleted lines earlier in the file.  The
 context region is meant to help find how to adjust the line numbers in
 order to apply the changes to the right lines.  However, if multiple
