Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA2C148825
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 05:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724907609; cv=none; b=ZpxDYzT1pfd9/B9xiCx93gVr8enSuvgqqJ5pZ6V4NnmMbg0EVABMCGJeGbF15aselNzzSxn99UTwYHtRj9UROCnjTahkD+zuA2YOouSz1WUmjM4u6/rni+3b8iIStWIW4abOS1HsqXXaFK4LYP91/y4JbXcltz2hWp5GA30ZgO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724907609; c=relaxed/simple;
	bh=lOT8WaUJn1DHrO0m00ZNQPBBMp46F7wA+3vshdRGN7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZNsFYPG25oatYuSqYBoXFsG81IP5kLFOAmOteDEubu3pOkGqnqPfuiDLfMK5qM268XR8aMa97RkU9Ql9RS7ci5UYhZO4YUdSOAUsDiBFfICUiv1A+l5BKOIHG49YbspWaIQdo/TXCXt13fcKXnaWUukdRwPjc7vzuy0INi2cvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=JfqcyuJY; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JfqcyuJY"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 946E62CAE0;
	Thu, 29 Aug 2024 01:00:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lOT8WaUJn1DHrO0m00ZNQPBBMp46F7wA+3vshd
	RGN7A=; b=JfqcyuJYF3P+66+iLFL/94AQ0jMVByXKnH6siGg0CIt6BiB37fGLVF
	cNIYCf88BSj8XsZH3mmqoyV3uBGc1We8YBkVIejkRNJU+oCQ51DPv7LkxOjUeaWK
	DlC2ly2Ufglkr+jzQm4OuOWjlnl1gikskHB7RByxTpiFGvy2Qvksw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 658062CAD3;
	Thu, 29 Aug 2024 01:00:00 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8FAD72CACA;
	Thu, 29 Aug 2024 00:59:59 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: shejialuo <shejialuo@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 0/4] add ref content check for files backend
In-Reply-To: <20240829040215.GA4054823@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 29 Aug 2024 00:02:15 -0400")
References: <ZsIMc6cJ-kzMzW_8@ArchLinux> <Zs348uXMBdCuwF-2@ArchLinux>
	<xmqqbk1cz69c.fsf@gitster.g>
	<20240829040215.GA4054823@coredump.intra.peff.net>
Date: Wed, 28 Aug 2024 21:59:58 -0700
Message-ID: <xmqq5xrjzzxt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 8AF3A968-65C3-11EF-ADB2-9B0F950A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> As an aside, I wonder if we should consider deprecating and eventually
> dropping support for core.prefersymlinkrefs. I can't think of a reason
> anybody would want to use it, and of course it makes no sense as we move
> on to alternate backends like reftables.

Yup.  Perhaps add an entry or two to BreakingChanges document?

 Documentation/BreakingChanges.txt | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git c/Documentation/BreakingChanges.txt w/Documentation/BreakingChanges.txt
index 0532bfcf7f..2a85740f3c 100644
--- c/Documentation/BreakingChanges.txt
+++ w/Documentation/BreakingChanges.txt
@@ -115,6 +115,12 @@ info/grafts as outdated, 2014-03-05) and will be removed.
 +
 Cf. <20140304174806.GA11561@sigill.intra.peff.net>.
 
+* Support for core.prefersymlinkrefs will be dropped.  Support for
+  existing repositories that use symbolic links to represent a
+  symbolic ref may or may not be dropped.
++
+Cf. <20240829040215.GA4054823@coredump.intra.peff.net>
+
 == Superseded features that will not be deprecated
 
 Some features have gained newer replacements that aim to improve the design in
