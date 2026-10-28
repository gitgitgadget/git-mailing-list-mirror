Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=117.135.210.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793194714;
	b=qtAp2E8XPoaeHXm4hDqjh/bNbZ4SKbpj73GejgDom/vHP9Pc457cVWCuaU7xtDFDyrIb
	 tuQStpEOTFXudFFCqc0HSD8+mRWPyKXNGz7CdwRSDf5HxxMhE0gh7W9XiS1qTe24ZLRl9
	 FgsUxtP7GnpZFRTqKQCHrPdJPTI5Cz1dvjP/qRs166f3zHlboEQdtiHrv4Nvy9Caw8ZJU
	 6wxMSa3yNk05JmJXMnx6bWSxdmNAlf1ShTpiRYcokqegcM9nDLQ9vCFMSbH6VmpgmLVBe
	 980+HwwZxT+KjMxWj6ltmttQtXGjFdY222duPfMsvF4UAXTmIt7ORJI7KJTLfA3AWUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793194714;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-CM-TRANSID:X-Coremail-Antispam:
	 X-Originating-IP:X-CM-SenderInfo;
	bh=EBW2Cqxuc828EJJqiEKCFcHud6D/8KT3HhClpO93lc4=;
	b=tw25ufkKdcUuJ1OCn0CtJgQFxNVrO8CQIborH+XxnthTUc6cIKF7/L2Ql0pyiVz+KUTM
	 JZtYoMrkX/m8ktTx10BaG04sMg9vf2ikC8Rwuuu/e6nEeaIIbXMkCB+W6KCGy6twg9Fsd
	 jxdR2NjaYR7FIQg0sQNPzWAx8Jwag+nQtF6oE7in7yWdkUCJdWjMXtoecYi8sOM1+qVxd
	 NIKkmlgN4GTq3bzXmrtfvBu9Q37egZWQx0FnMIqkm0og7yGVF/hJQDZkPRSVPrmg2Dttn
	 wiQZbjmBbSBgLN2edRL2vwqKpyk6ndDbO8rMhm46b9+zAbolpQm96p2N8wMUuYt/U4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NQneX6fH;
	arc=none smtp.remote-ip=117.135.210.5
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F806606A333
	for <git@vger.kernel.org>; Wed, 28 Oct 2026 13:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2F806606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=NQneX6fH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=EB
	W2Cqxuc828EJJqiEKCFcHud6D/8KT3HhClpO93lc4=; b=NQneX6fHrFq5LU07VP
	bbdlhCTzwYMW8wAXyJr/0q4C7B3LGcmBLrwz4PV8Iqb7FPgo2pUWHdRd8mLnOmP8
	uodAB1fnrLBx2rfqsGapQR51cgMQTy9EJJpped0n0b2Ss5M63AmY4I04Bm3W17Rk
	E4xHjEfbIitGiNOde48r4t7jE=
Received: from ian-MacBookPro.softshell-mine.ts.net (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD3l8O2+uFqF6nxDQ--.17041S2;
	Wed, 28 Oct 2026 21:38:04 +0800 (CST)
From: ian4hu <hu2008yinxiang@163.com>
To: git@vger.kernel.org
Cc: ian4hu <hu2008yinxiang@163.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH] sigchain: recover from concurrent double-pops of the same signal
Date: Wed, 28 Oct 2026 21:37:54 +0800
Message-ID: <20261028133755.112476-1-hu2008yinxiang@163.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <pull.2263.git.1792154272296.gitgitgadget@gmail.com>
References: <pull.2263.git.1792154272296.gitgitgadget@gmail.com>
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
X-CM-TRANSID:_____wD3l8O2+uFqF6nxDQ--.17041S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtry7XFW3XF1xJw4kZFW3GFg_yoWkCrc_Za
	4rArn2yw4kXwsxZw4fKr4DuFWkGanY9F18J34kXr1akry5Z3srWrWvvryxuw1UCa9Iyr98
	WrsIq34fGa4a9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7VUjKsUJUUUUU==
X-CM-SenderInfo: dkxsiigy1l05pldqwqqrwthudrp/xtbC7hwBmmrh+rzg7gAA3q

Hi,

Gentle ping on this one.  It is queued in 'seen' as
iy/sigchain-recover-concurrent-pops, and the latest "What's cooking"
marks it as "Needs review".

A short recap: when two copies of the same signal reach two threads
nearly at the same time, the concurrent sigchain_pop() calls in the
handlers can unwind the chain by two levels instead of one, leaving
the process spinning in a handler that keeps re-raising the signal.
This is reachable with "git clone --depth 1" over ssh receiving two
SIGTERMs in quick succession, and only SIGKILL gets rid of the
process.

The patch leaves the push/pop fast path alone and only teaches the
"n < 1" guard in sigchain_pop() to fall back to the pre-chain
disposition, so the stuck handler's raise() terminates the process
just as a single delivery would.

Peff, I have Cc'ed you since you wrote the sigchain code.  I would
appreciate your thoughts on whether this "repair after the fact"
approach is acceptable, or whether you would rather see the chain
mutation serialized instead.  I also have a version that uses a
per-signal spinlock around push/pop, and can send it if that is
preferred.

Thanks,
ian4hu

