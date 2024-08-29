Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2A151B1D41
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 18:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724956064; cv=none; b=SPbOa6hPjvDiF+eSDulTKEbVNCFbid3iX9HdsM6Bb8zD8UN333ucN21rbyZlpOY5WEG5mH1Xbhu9dXZhLJR4M2iJq5FU3Q7vscd/7dFu4sSVZRMej/WTx61k//qeVCdDKSZ77PvXzKNAbo1pAEkfBI3A3a9paO2+aNqtW1UqB7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724956064; c=relaxed/simple;
	bh=HlG+WkLkWghzg5v9E/Fm4JxwpuymfGl5JvJqyybowes=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HOYiAWcZQaXChJOQfWkzXS4338MEOY83etWPMUXH5GqgXbh7xltn2Swb4IIS6r8DOOrtXoNCn7odG98ShSyVxJZsxKMl966XHzB+Cxk25u82m6/th3gfJpWF856XCGS/BRJtpyztv+iNm6kutlEcdCqdRBowbyyYQSg1dth4tXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=u97MsUtv; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="u97MsUtv"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 01D8E24362;
	Thu, 29 Aug 2024 14:27:42 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HlG+WkLkWghzg5v9E/Fm4JxwpuymfGl5JvJqyy
	bowes=; b=u97MsUtvbJJNPI2BN4wKLfD/uriH1dvIzzlw/P6SQ3UJ2JFOsc/nM1
	3UnxPu8RZQ4RbmJW4j2N4FUwzvsNTGh8AAbKgz1djuC/9s6UIgLNITHgkuRnYYEb
	vC5+vgsX4PrNlN62gJbOF4jy8ja2iisxIDdolIz79i5wQURfkY0mI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id EEE0A24361;
	Thu, 29 Aug 2024 14:27:41 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6588524360;
	Thu, 29 Aug 2024 14:27:40 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: [PATCH 9/6] git-compat-util: guard definition of MAYBE_UNUSED with
 __GNUC__
In-Reply-To: <xmqq4j73w5up.fsf_-_@gitster.g> (Junio C. Hamano's message of
	"Thu, 29 Aug 2024 11:18:06 -0700")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
	<xmqqbk1cz69c.fsf@gitster.g>
	<20240829040215.GA4054823@coredump.intra.peff.net>
	<xmqqseunxtks.fsf_-_@gitster.g>
	<20240829175215.GA415423@coredump.intra.peff.net>
	<xmqq8qwfw6e9.fsf@gitster.g> <xmqq4j73w5up.fsf_-_@gitster.g>
Date: Thu, 29 Aug 2024 11:27:39 -0700
Message-ID: <xmqqttf3uquc.fsf_-_@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 5FDB12E0-6634-11EF-8174-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Just like we only define UNUSED macro when __GNUC__ is defined,
and fall back to an empty definition otherwise, we should do the
same for MAYBE_UNUSED.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * Before I forget that we have discussed this, just as a
   documentation (read: this is not a patch to be applied).

   I think this only matters when a compiler satisfies all three
   traits:

   - does not define __GNUC__
   - does have its own __attribute__() macro
   - barfs on __attribute__((__unused__))

   Otherwise we will define __attribute__(x) away to empty to cause
   no harm.

   Since we have survived without complaints without such a guard
   for quite some time, it may be a sign that no compiler that knows
   __attribute__() that people ever tried to compile Git with barfs
   with __attribute__((__unused__)).  I dunno.

 git-compat-util.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index e4a306dd56..74ed581b5d 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -673,7 +673,11 @@ static inline int git_has_dir_sep(const char *path)
  * would give a warning in a compilation where it is unused.  In such
  * a case, MAYBE_UNUSED is the appropriate annotation to use.
  */
+#ifdef __GNUC__
 #define MAYBE_UNUSED __attribute__((__unused__))
+#else
+#define MAYBE_UNUSED
+#endif
 
 #include "compat/bswap.h"
 
-- 
2.46.0-563-gaeb9b172ce

