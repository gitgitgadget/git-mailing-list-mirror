Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793198902;
	b=gdjzjLvgryJBMlAURstag8n5dymbb6kkVguUliHQKxRmjwrv4YYxaNxUu85wVYOxq4wr
	 OAxIW/pEaBsiPrU2STEP3qYusOcYlfEha9eZdDhEGXie6U6pBi90e3ERmJGqGUXFpNhEH
	 kFVKF23P46FEjK2kYNuINVoSz/ML9Or1V28yWQcS8EwHGEnjzL9gp0hBeJibpU2Zyr5oS
	 rSWgMH+BxcEoo2tSm9ZnrEakQJg0Ehrb8UoE0DDO5/kZaHLL1nUs8xBzJzu04VKo8wqU8
	 XXeD7qwoOdt3f08UN6iPnUbolkBLNfglitDlPqTwIOfakk11gcL2kfVe4ShziIIGi2g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793198902;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=34X3XmbEV734Bn1cc+Pc8mXOnWqX/WEBVu8zSTx/uK8=;
	b=dClUBievOdfTHpfdh7rFk+025IXI+OSB9tH4zwZjXmNnQdLLcV7hs4yxI5cS+SKWgctm
	 IxuKM57FgUFqql1T61qBCj5UYycneSZgIHSCEBIYL6JAsFcOImJHH6DqxXPdMTe4bjtxE
	 o3C1B3VH4SrnTcEJu6/y+bButtR+qdmdi9nZv/e+sY6lQgLzsg6t+CWcXsBhZGQ9T+jS4
	 9hSt72txcDVhcTYaUZv5toRgPDwz9HdV9IIktuF90ZZHD3dyk+n4fqg2I0sCfuXYu98W8
	 vTUsY/WHuqg7/WNnUQI/YsNbQKM4KV+R+SVFTca9HJCHpzdAlyYWIqQWP1EbJMvdS6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GPSLk0ut;
	arc=none smtp.remote-ip=220.197.31.4
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D95606A31E
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 14:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D95606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=GPSLk0ut
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=34
	X3XmbEV734Bn1cc+Pc8mXOnWqX/WEBVu8zSTx/uK8=; b=GPSLk0uthYXS9MMsse
	xGlk/G/K3TBy7vawisemorpbHexqhV0HJaV5XAHioRdovhbUTSCgZOvSGoeySdi6
	/GlNydOiXPw+xBJiULcbzKgJX18kakDxuIAXVIFETHu5Y6v+I+iWeAPlCOQ6NaOn
	0MTiP0P6xUWGbEG51D/mC9qYs=
Received: from mbp-home.softshell-mine.ts.net (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3f3UIC+JqHJrUDQ--.28271S2;
	Wed, 28 Oct 2026 22:47:36 +0800 (CST)
From: ian4hu <hu2008yinxiang@163.com>
To: phillip.wood123@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	hu2008yinxiang@163.com,
	peff@peff.net,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same signal
Date: Wed, 28 Oct 2026 22:47:35 +0800
Message-ID: <20261028144736.121433-1-hu2008yinxiang@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <3f939144-d4b3-4bc5-aaea-16422450d638@gmail.com>
References: <3f939144-d4b3-4bc5-aaea-16422450d638@gmail.com>
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Post: <mailto:git@vger.kernel.org>
List-Help: <mailto:git+help@vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
List-Owner: <mailto:git+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3f3UIC+JqHJrUDQ--.28271S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXF18uw17tF17ur1Duw15Jwb_yoW5Gr1DpF
	Z8Ka4Ykr1kur4vvF9rCw48Ga4rCw48GFWUCry5K3yFv398Wwnakr97ta15Za45Crn3W3Wj
	vrW0gr98Cw4DtFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0JUw4SOUUUUU=
X-CM-SenderInfo: dkxsiigy1l05pldqwqqrwthudrp/xtbC7ggYsWriCwhyNAAA3C

Hi Phillip,

Thanks for the review.  I agree with both halves of your mail, and
I think the difference between the two approaches is worth spelling
out.

What I sent only repairs the aftermath.  It leaves the corrupted
state reachable and merely turns the wedge into the normal death, so
it is small and inert on the legitimate paths, but it is a band-aid
and, frankly, a bit dirty: it heals a state that should never have
been entered, and by the time it heals it the two threads have
already run the handler's close()/unlink() cleanup concurrently.

I did first try the serializing route.  My earlier attempt
(https://github.com/gitgitgadget/git/pull/2262, never sent to the
list) took a per-signal spinlock around the push/pop update, with
the signal blocked while the lock is held.  That keeps
signals[sig].n and the installed disposition consistent under any
interleaving, so the corrupt state cannot be constructed at all,
and it also protects sigchain_push/pop called from worker threads.
I dropped it because of the edges:

  - two threads can still run the handler body concurrently; the
    lock only makes the unwind atomic, it does not serialize the
    cleanup itself;
  - the POSIX corner is awkward: sigprocmask() is unspecified in a
    multithreaded process, pthread_sigmask() is not
    async-signal-safe, and taking the lock in a handler needs one
    of them;
  - a thread that dies inside the critical section leaves the lock
    held and the next delivery spins forever, trading a hang for a
    hang;
  - the Windows branch needs its own InterlockedExchange path that
    cannot be exercised in CI here.

So the question I would like your guidance on: do you consider a
locked/serialized chain a complete fix for what you described, or
does this have to be prevented at the thread level - block the
signals when a thread is spawned, and use sigaction() for the
chain?  My own reading is that serializing is a complete fix for
the chain state but not for the handler bodies, so if the latter is
what you want, your suggestion is the way to go and the lock does
not buy much beyond it.

If you prefer the thread-level fix, I am happy to build it: a
git_pthread_create() wrapper that blocks SIGINT/SIGHUP/SIGTERM/
SIGQUIT around pthread_create() - leaving SIGPIPE alone, since it is
a synchronous signal and blocking it in workers turns deaths into
EPIPE - plus a sigaction()-based chain that masks all signals while
a handler runs.  I would then drop this patch, or keep it as a
separate last-resort series if you think the belt and braces are
worth it.

Thanks,
ian4hu

