Received: from mail-gateway-shared15.cyon.net (mail-gateway-shared15.cyon.net [194.126.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011035C693
	for <git@vger.kernel.org>; Mon,  7 Sep 2026 21:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788815760; cv=none; b=uDDRd7X13LxIW5c48mLaxSMsjoSNr9q5aUocOpN6w7OEi6vBfYbE7EX8i05zwEyM35/lDidUBfXwDf1BqCY9/i05K8Jjgsv6AkBZ1AscLhgM7wX39nkTXSNZM3oVzkBrQciqbubjI+yTPQ2jVS98dEWTUrLNdHg6Jl+3xs71818=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788815760; c=relaxed/simple;
	bh=IO0HCEb1gfBkqxdLFGOZQy6rmIePtw3AbL+bIMYjunA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhAo0QGsJH2QqHPoiftPPCgM5NZrLGKk34afAWef2qCnYl2Dm00EDe2YxBA4wkU+mrUKs2sj/8EUt8Ck0ilJ+0B6b5Eilyjb8sQ3d+Z3G1MOUEfxo9DBHnK4GnvwF5YRg9ND6TUcDwfGTykzhVabUHNO9epuWlTxxYl1U7PIbRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared15.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdm-00ASmd-0F
	for git@vger.kernel.org;
	Mon, 07 Sep 2026 23:12:35 +0200
Received: from [10.20.10.53] (port=26742 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.99.4)
	(envelope-from <ig@drbeat.li>)
	id 1x3gdg-00000005Wd7-3wWL;
	Mon, 07 Sep 2026 23:12:28 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id AC3BD4007B; Mon, 07 Sep 2026 23:12:28 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Oswald Buddenhagen <ossi@kde.org>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH 0/3] imap-send: future proofing and two correctness fixes
Date: Mon,  7 Sep 2026 23:12:07 +0200
Message-ID: <20260907211210.2621693-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - s019.cyon.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - drbeat.li
X-Get-Message-Sender-Via: s019.cyon.net: authenticated_id: ig@drbeat.li
X-Authenticated-Sender: s019.cyon.net: ig@drbeat.li

Hi!

Patch 1 future-proofs against a renamed ASN1_STRING function.

Patch 2 fixes an incorrect assumption about NUL-termination of
ASN1_STRINGs.

Patch 3 only checks the certificate subject common name if no DNS
subject alternative names are available, as defined by RFC 6125.


Beat Bolli (3):
  imap-send: prepare for OpenSSL 4.1
  imap-send: don't expect an ASN1_STRING to be NUL-terminated
  imap-send: only check the CN if no SAN DNS names are present

 imap-send.c | 33 ++++++++++++++++++++++++---------
 1 file changed, 24 insertions(+), 9 deletions(-)

-- 
2.53.0

