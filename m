Received: from defaultvalue.org (defaultvalue.org [45.33.119.55])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8A6200127
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 22:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.33.119.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754431807; cv=none; b=T3YQhcz154QSAv9oSC+v04Z9oYLLiinUUHodSJ5u6DhAD9LC/xErskOnEghullVSSKuujZgGP7L722aDaX3xKxu8euNS3tZ4+ACSaUEWALODRk/hZkUszHpsxv2LDJTi4zcdVNiMnOfZIBxq33dCN0hkhlkbzWdV+AHX0FAjdM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754431807; c=relaxed/simple;
	bh=ONQ7XrKPEyIY5pClX1XhBA/atmYndEG7c5pjBtXgBlU=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Bn+sLzW/D7DuMHEFsYWLsio4Iyss8lOVinhwUyi/lDNMzdh1KWO/XT/0sQIfDR0MFlQkYgIIPiO2diIR8s78NKppFFP34+kFF+GmK3mQu67SGWYDLjqeEtjb+pPwTj/0A+mJNu5YTAdXe9LHf4AgwL8p0HChvTqVtbDgDK7daKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=defaultvalue.org; spf=pass smtp.mailfrom=defaultvalue.org; arc=none smtp.client-ip=45.33.119.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=defaultvalue.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=defaultvalue.org
Received: from trouble.defaultvalue.org (localhost [127.0.0.1])
	(Authenticated sender: rlb@defaultvalue.org)
	by defaultvalue.org (Postfix) with ESMTPSA id 7149F201B1
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 17:10:04 -0500 (CDT)
Received: by trouble.defaultvalue.org (Postfix, from userid 1000)
	id F0EE014E154; Tue, 05 Aug 2025 17:10:03 -0500 (CDT)
From: Rob Browning <rlb@defaultvalue.org>
To: git@vger.kernel.org
Subject: Re: cat-file --batch-command info performance problem
In-Reply-To: <871ppp1n33.fsf@trouble.defaultvalue.org>
References: <871ppp1n33.fsf@trouble.defaultvalue.org>
Date: Tue, 05 Aug 2025 17:10:03 -0500
Message-ID: <87v7n1zah0.fsf@trouble.defaultvalue.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Rob Browning <rlb@defaultvalue.org> writes:

> While doing some testing before a bup release, I ran in to a performance
> problem that I've narrowed down to git (2.47.2) cat-file --batch-command
> (currently, bup often relies on git cat-file).
>
> I can reproduce the problem with a ~125GB (~3M object) repository on
> an external SSD and a system with 16GB RAM via "git --batch-command <
> fetch-oids" where fetch-oids contains 8k "info HASH" commands.

Just after sending this, I thought to wonder whether the issue might
somehow be with the hardware/driver/etc. (that particular drive is an
nvme ssd in an external usb-3 case), and while I'm not testing the exact
same repository (it's a slightly larger, related one), preliminary
results suggest cat-file behaves much more reasonably with an internal
nvme drive, i.e. it starts slow, gets faster, and ends up repeatably at
37k hashes/sec after the second run.

So I'll probably test a bit more, but while I'd be quite interested in
the cause, it seems likely my solution should just be to replace that
hardware.

-- 
Rob Browning
rlb @defaultvalue.org and @debian.org
GPG as of 2011-07-10 E6A9 DA3C C9FD 1FF8 C676 D2C4 C0F0 39E9 ED1B 597A
GPG as of 2002-11-03 14DD 432F AE39 534D B592 F9A0 25C8 D377 8C7E 73A4
