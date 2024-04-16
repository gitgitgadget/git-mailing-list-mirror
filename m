Received: from web23.osl1.nordkapp.net (web23.osl1.nordkapp.net [185.114.57.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC2B21CF8A
	for <git@vger.kernel.org>; Tue, 16 Apr 2024 19:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.114.57.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297227; cv=none; b=fJXEQP+Xi+MJHOEoEvrMjaExto9XHL3Kkw3ek5vtbK8uS6Ny058XBhEa6N9OIE2xm6xv4+r8IdkUXFmx7Efg8fEUaqARKVBKhq/EZS4vKLFGZqcVOT6gGBO1Fus4HMsTisi7zweokMe+j56s1efE0f0tUrQYuH4zaZNl+6ZkBIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297227; c=relaxed/simple;
	bh=8ZXFsaUTzgDoBnZIGqVcUZCJrg/NleBQzzrT/xt/J/c=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=ka7xWhWj4ksWoDQNyKbb6rcisZS59tU95eIBQ1fJKi9k+el3IA+HFe7qRvXCvU5Dkg623w+FQR5vwzcPvw4WCJTd21o0ee9isD5txi0yShZPtLOWCHDwJ1o4zaTBQlvKN5YO1q2xi5h/yPoMQ06Agnw+qA2Ho5sHc14EKuNSyfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se; spf=pass smtp.mailfrom=softwolves.pp.se; dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b=kxTxcUqA; arc=none smtp.client-ip=185.114.57.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=softwolves.pp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=softwolves.pp.se header.i=@softwolves.pp.se header.b="kxTxcUqA"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=softwolves.pp.se; s=x; h=Content-Type:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=T2zB1GgcOckLmM3NzpmFTXnaGSkFtXWxXwURu8K+GiQ=; b=kxTxcUqAmX38AZFkMTQIxvjaSY
	oX+jZhhAMpCOnxwj8tGKDKDXpki/cCG7RRnf0IGJjEwB+3LQejUsNCnIeAHYqivy9D3UWOOxyOf5A
	nV5d/u5zHrODJf8Aq2VjmbV4wXhNBYmtPU0XOFxOD2mtufYuD06LMniPThctofVz80XGAzInq70oJ
	YH0HYH62EWUaGDMzplVL4FyGUplGtZnvusCR6kSXCKWlIhEunkWv1ui1hXG9dgxAfLYN73/R0CxbO
	X9r2Q3sAKbwzM8dI58M2U+Idgio10z+7zsJ3CrHnnofjbsM7yGZ6Tf+PfDOfD6Q6CNwFywP8Ypqum
	q7sn2EuQ==;
Received: from mail01.osl1.nordkapp.net ([185.114.57.50]:40810 helo=mail.nordhost.no)
	by web23.osl1.nordkapp.net with esmtps  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <peter@softwolves.pp.se>)
	id 1rwos8-0000000DCxm-2kif;
	Tue, 16 Apr 2024 21:53:40 +0200
Date: Tue, 16 Apr 2024 20:53:40 +0100 (CET)
From: Peter Krefting <peter@softwolves.pp.se>
To: Junio C Hamano <gitster@pobox.com>
cc: Christian Couder <christian.couder@gmail.com>, Jeff King <peff@peff.net>, 
    git@vger.kernel.org, 
    "Osipov, Michael (IN IT IN)" <michael.osipov@innomotics.com>, 
    Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] bisect: Honor log.date
In-Reply-To: <xmqq8r1dfh65.fsf@gitster.g>
Message-ID: <4f0456c0-e926-ee60-4e14-6b8ed80d2ace@softwolves.pp.se>
References: <3ec4ec15-8889-913a-1184-72e55a1e0432@softwolves.pp.se> <xmqqh6gni1ur.fsf@gitster.g> <5ea0837f-2668-028d-4094-c9400e92fceb@softwolves.pp.se> <xmqq7chif1pu.fsf@gitster.g> <20240401023225.GA2639800@coredump.intra.peff.net>
 <CAP8UFD0W7PUHTg2NwuVkQJik2+HqTDF6KRZZ8tA_dW7-YZtsbQ@mail.gmail.com> <xmqq8r1dfh65.fsf@gitster.g>
X-Warning: Junk / bulk email will be reported
X-Rating: This message is not to be eaten by humans
Organization: /universe/earth/europe/norway/oslo
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Relay-Host: 185.114.57.50
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus

Junio C Hamano:

> then the codepath we are changing from using diff-tree to show can 
> do something like:
>
> 	struct git_global_state state = GIT_GLOBAL_STATE_INIT;
> 	struct strvec args = STRVEC_INIT;
>
>        strvec_pushl(&args, ...);
>        cmd__show(&state, args.nr , args.v);
>
> and expect that cmd__show() will do the _right thing_, right?

In this particular case, calling "git show" is really the last thing 
we want to do; so if we can move the cleanup that happens after it 
(that ends the bisect), it should be able to just take over the 
current process with a call to show, without needing to re-exec.

And calling back to the libification question, I would see this part 
of the bisect command to be something that would run *on top of* the 
library (with possibly an API to poke bad/good states into it), so I 
don't think that objection holds for this particular case.

-- 
\\// Peter - http://www.softwolves.pp.se/
