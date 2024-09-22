Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67D60632
	for <git@vger.kernel.org>; Sun, 22 Sep 2024 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727023704; cv=none; b=sk5LnpFO0idIsTflKWs1vfcbYV528N52K+j4rQM6oh86zmKWxcKivuiFZh1vw5sOE2/f/GxGTzpe7KUAkjBQWJFc6lXc0z2chzIYP7Prpl0PsP98W6GKuwKpHuez/3V+yYeOFYaLLVAY1ewXMhKAzLPnufzdbc1L2GvoTU1iAZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727023704; c=relaxed/simple;
	bh=RSAcrwXwJsy3OZc/QEyimm3F9wVRRtXw8eRryiPm724=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eMvtpzXoFeKBSLI50/iuRgeM6ELOP5VZVrdyUdOS0sZkKA+GQISH/OMOQGAJG6dAGVpFXhyavxne4E6+0fbCM9YActXPNIMi8DSH8PSjHcXvyM1no/C8eynFJgleZD1flyv+GNw34dBprW/JYEFj/8bPZsCfm+OLANeqNQx+7fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=lWEvQZaq; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="lWEvQZaq"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 0BE3D3D2B9;
	Sun, 22 Sep 2024 12:48:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=RSAcrwXwJsy3OZc/QEyimm3F9wVRRtXw8eRryi
	Pm724=; b=lWEvQZaqSrS52sEWDs0J9EP8pDynsi6fIzL2P6iTXKGO/sfxAB8rdQ
	zojHH+yQAAgikXNoshwAcyOaIHqv2NSb281rzWOg/yLFIe9wk1qyRm5Y9Hpl7r4m
	BA93zUfMz2n0inQw4r+BCvXQv2U3bTosDFWLbtsVzNsOGLpzX5dzg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 02BDB3D2B8;
	Sun, 22 Sep 2024 12:48:22 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6AABB3D2B7;
	Sun, 22 Sep 2024 12:48:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH v4 3/5] ref: add more strict checks for regular refs
In-Reply-To: <ZvAyf8Uy6R33mUda@ArchLinux> (shejialuo@gmail.com's message of
	"Sun, 22 Sep 2024 23:06:39 +0800")
References: <ZuRzCyjQFilGhj8j@ArchLinux> <ZuRzxyjAI3tp4uLK@ArchLinux>
	<xmqqr09gbvku.fsf@gitster.g> <ZvAyf8Uy6R33mUda@ArchLinux>
Date: Sun, 22 Sep 2024 09:48:20 -0700
Message-ID: <xmqqcykv8wiz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 79F1EDC6-7902-11EF-B83B-9B0F950A682E-77302942!pb-smtp2.pobox.com

shejialuo <shejialuo@gmail.com> writes:

> I agree with you here, I use way too general words to describe what
> happens. I will improve this. Actually, I feel hard to find words for
> "MSG_REF_MISSING_NEWLINE". I think we should say:
>
> 	LF should be at the end of the file.

Giving a human-readable message when we have an enum can be done at
a lot higher layer with the current way the fsck_report_ref()
function is used (i.e. in that function, not by its callers).

That is what I meant by "misdesigned"---if one message enum always
corresponds to one human-readable message, there is not much point
in forcing callers to supply both, is there?
