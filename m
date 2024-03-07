Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBCD12F58D
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.209.179.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709826027; cv=none; b=NQN5MoLq5DFmX6oLeCVn/Huqp8epw/J8SnTYRfYe1sEIeqqFEDX37hJENCqssp/LBrmH7sVN2rtQoy+1gyTpkFIP7wYUQ7+Q0EqytTA932ZILHEZh2F5J2uUakGvkOgSVWqPlI+8vyIEZma8wIoGBgqs6CF8YoSkTfcbc1wMLPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709826027; c=relaxed/simple;
	bh=Al32CZCaakZ20ey82sjzPoMc2bnPM5752aauRw8vHL8=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=J+7jLr5ejs4d3kj9Ltn5WW5TKo4TeKOz4Qc4OVmC6KblK9qRYWqkWYjv47jONSiP0ruOUzNGtxOM53Qt37sa1buVYRXMmUElqtmtMYAhcXOuj/hiY3dJekmbkgi2I0F62Y4yFqJX+WozU7vCTALU5rnso0nQA0MIP+pl/fYstPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com; spf=pass smtp.mailfrom=nexbridge.com; arc=none smtp.client-ip=185.209.179.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexbridge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nexbridge.com
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
	(authenticated bits=0)
	by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 427FeANI235220
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 15:40:10 GMT
Reply-To: <rsbecker@nexbridge.com>
From: <rsbecker@nexbridge.com>
To: "'Ralph Seichter'" <github@seichter.de>,
        "'Junio C Hamano'" <gitster@pobox.com>
Cc: <gitgitgadget@gmail.com>, <git@vger.kernel.org>
References: <pull.1681.git.1709532018372.gitgitgadget@gmail.com> <xmqqttljtkn4.fsf@gitster.g> <2560952c-4495-4a71-9497-aa40032e1d2b@seichter.de> <xmqqplw6nsuz.fsf@gitster.g> <098101da7096$cd773d40$6865b7c0$@nexbridge.com> <87h6higj1a.fsf@ra.horus-it.com>
In-Reply-To: <87h6higj1a.fsf@ra.horus-it.com>
Subject: RE: [PATCH] Allow git-config to append a comment
Date: Thu, 7 Mar 2024 10:40:04 -0500
Organization: Nexbridge Inc.
Message-ID: <09c501da70a5$bd2f4f40$378dedc0$@nexbridge.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQFlUIbffV0Kx6ugRLQuqCoXSigUjAHnrHP3AasKI1AB66HTSgJrw1ovAr6wp+exwWKZAA==

On Thursday, March 7, 2024 10:26 AM, Ralph Seichter wrote:
>* rsbecker@nexbridge.com:
>
>> While comments are permitted in .gitconfig files, I am not 100% sure
>> that all stakeholders, particularly those who parse .gitconfig files
>> in their own scripts outside of git - sure, it is their own
>> responsibility, but this might be unexpected.
>
>Comments are nothing new, and humans have added far crazier comments to
their Git config in the past. The patch ensures that a '#'
>precedes the comments added using git-config, which is not guaranteed to
happen when Joe Random User manually edits config files.
>
>I think that anybody incapable of reliably dealing with comments in config
files would already have fallen flat on his/her nose,
>regardless of how those comments were made.
>
>> I worry that this might unintentionally introduce incompatibilities
>> into repository configurations.
>
>Do you have an example?

No example. This is a comment on "potential" changes to data that scripts
around git for automation purposes might use. My purpose is just to
highlight, for the purpose of reviewing the change, that there may be
unintended impacts, that's all. It may be useful to include comments in the
change notices and documentation pages that using this capability may impact
scripting. When a user manually puts in a comment, any breakages in their
scripts are 100% their issue. With git config moving comments around,
responsibility shifts to git - a.k.a., unintended consequences. I am not
asking that this change not happen - it is a good thing, but ensuring that
we communicate that this may cause breakages if external programs/scripts
read .gitconfig would be helpful. This also would need to be coordinated
with the libification efforts at some point.

