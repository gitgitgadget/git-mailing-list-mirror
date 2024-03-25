Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E44C6F506
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711403391; cv=none; b=YO0fPsAQQyEzDf7tY5A1994f5QNdw4Mf4FAqLdvB4BB9TN0txozeanXRjFJv9LDRqlHEncoaB7pbU/2vYcJiS/gUMx4fDKZRQNcjMDmbwuGm4g3LhEfxt1GcX1ryxWbFD/Oi8Db3fejIE8Zo/w/feZDCl3y//Nm+eFggzgISQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711403391; c=relaxed/simple;
	bh=H758bzMaRKngObvIQkwO72Y/N1xx2Bu1d44EHxg+sA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JleUtS347BUTpJ40qx+DLmaiu5wEa4fzJCBu1ovpPHjiz00E9f08qCS4B/sC87BCzRgeIuxBtBjHKf3YK04ZF/M9Q6xtc7WyIyIba8MO72o0QCyMLtpUhHbdSfj8vNpy2UxWj2W6lY3be9Og/VHesYPCTJhUYm3WOsyK04yRJ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=tEKRvNpR; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="tEKRvNpR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4D1A21E9307;
	Mon, 25 Mar 2024 17:49:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=H758bzMaRKngObvIQkwO72Y/N1xx2Bu1d44EHx
	g+sA8=; b=tEKRvNpR/skyrLVbiTOodUEXauLFHmFPoQ5b1II6ostCKWvZh4C+On
	GfuxmdHPktMkGKhtucU/j387Y0AiRhkpqCQaT2cyLN2wLPCsjiaJL0B85+E00Xii
	1ou6PZqxDVIMvhvHTMMKmc2i7Y0P2Xcse+ErBD0COZ5JOyPuriF9s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 442B81E9306;
	Mon, 25 Mar 2024 17:49:48 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AAFE11E9305;
	Mon, 25 Mar 2024 17:49:47 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Peter Krefting <peter@softwolves.pp.se>
Cc: "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>,
  git@vger.kernel.org
Subject: Re: bisect does not respect 'log.date'
In-Reply-To: <25d716fa-bd32-4ff0-20f2-05ff51750911@softwolves.pp.se> (Peter
	Krefting's message of "Mon, 25 Mar 2024 21:27:30 +0100 (CET)")
References: <645c8253-f1ef-410f-8284-7d6c8b6db601@siemens.com>
	<xmqq7ci6c7mn.fsf@gitster.g>
	<4e2b22fb-7496-4f67-a89f-9fcbffc73a1a@siemens.com>
	<25d716fa-bd32-4ff0-20f2-05ff51750911@softwolves.pp.se>
Date: Mon, 25 Mar 2024 14:49:46 -0700
Message-ID: <xmqq1q7ygex1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 996D3D80-EAF1-11EE-8804-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Peter Krefting <peter@softwolves.pp.se> writes:

> The question is what is the correct way of fixing this; is it to make
> "git diff-tree --pretty" respect the "log.date" option, or to make

The "diff-tree" and other "plumbing" commands deliberately ignore
configuration and the point of doing so is to make sure their output
are stable without getting affected by the end-user configuration.

> "git bisect" pass a --date pate parameter to the invocation of it?

If we were to change how "bisect" reports the date of the commit,
this is a more reasonable route to go.

Are you sure that nobody is driving "git bisect" from a script and
scraping the output in such a way that a change in the output format
would break such a script?  I would say it is unlikely (they may be
scraping the output to find a commit by looking for 40-hex string,
though) that it would cause such a breakage.

But stepping back a bit.

If "git bisect" were written in the more modern era, I am reasonably
sure that it wouldn't have used "git diff-tree" when reporting the
"first bad commit".  It would have used "git show" instead, which is
at the Porcelain level and will pay attention to the configuration
variables.  Instead of focusing too narrowly on the log.date option,
that would only tweak the date format, it may be a more fruitful way
to invest brainwaves in to consider the feasibility of switching to
use "git show" there.

