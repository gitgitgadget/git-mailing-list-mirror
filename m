Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13424E06F0
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 20:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791837073; cv=none; b=A0nURwxvwVtSM+5PJjdmUviyaCNiWGKkmiqrNWsfM03SkN4g1jGaRqNDC4yFT6ibcBJCI1wqlWqIAfRxubxxEZL+40rK0lJ46eAdiy5qxsAc4U816Xz4KoPPbuzOwtFdenE/lBln4BfodWBtBOkmzLv5ohMkm9yoJbnRYX5Jfq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791837073; c=relaxed/simple;
	bh=USvttmY/J5yt22zG37wBN7bgEvUi3nFJdn7otaplfRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tfCQsgqpl0yRoqeNfmDf2m6IhONTjkJYHPeb+eeqRYuf4n5+DPEe2PCG6BRpjlu0XMN0B9/2WYF5G8ptA7w910R6yRFkeKzEm6yviWcFaagGXKAGOi9h75yfTjhMbaEmXcUM/LBWIugis85t1OqAKkCm2l/KJGK8DrIMSgTjbLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1xGMfp-000lJY-1I
	for git@vger.kernel.org;
	Mon, 12 Oct 2026 22:31:08 +0200
Received: from [10.20.10.54] (port=65398 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <ig@drbeat.li>)
	id 1xGMfl-0000000Dic0-1YrG;
	Mon, 12 Oct 2026 22:31:00 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id D6E5C40610; Mon, 12 Oct 2026 22:30:59 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v2 1/2] imap-send: use the recommended TLS_method()
Date: Mon, 12 Oct 2026 22:30:56 +0200
Message-ID: <20261012203057.969878-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907211210.2621693-1-dev+git@drbeat.li>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
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

SSLv23_method() has been deprecated since OpenSSL 1.1.0, and
TLS_method() is the recommended function.

Signed-off-by: Beat Bolli <dev+git@drbeat.li>
---
 imap-send.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index bf1d2cf74d..9f21705d77 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -298,9 +298,9 @@ static int ssl_socket_connect(struct imap_socket *sock,
 	SSL_library_init();
 	SSL_load_error_strings();
 
-	meth = SSLv23_method();
+	meth = TLS_method();
 	if (!meth) {
-		ssl_socket_perror("SSLv23_method");
+		ssl_socket_perror("TLS_method");
 		return -1;
 	}
 
-- 
2.53.0

