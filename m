Received: from mail-gateway-shared11.cyon.net (mail-gateway-shared11.cyon.net [194.126.200.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A885B47DD5E
	for <git@vger.kernel.org>; Sat, 17 Oct 2026 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.126.200.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792231824; cv=none; b=cxENrQCQuMmBRimfD333Ia6+zyTrLfKeRtYp2yDk21tgTA75LkVSGQu58fYgRGNLrljmp3eBIR78KBc/iVdnnWeOPduYOWov1/jg4WdpiA1/vTJXZF1Q4MxQY+hnuOozCyrgbiuiGiIDUEdKeifZhTHbyFxu2O9TDpungeqvzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792231824; c=relaxed/simple;
	bh=wecnm+4sgBPC7s4C2bcCkKsOZI6BiBP8MeT/fKnRbAs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uGAORBRujAukquyBtDKZWmTlHWmpdT0cBdPr7hPwCKksnfb3xgQwrx95OLeSmiRes6TTt8MQYWPgz++0rSoxaTilLEbVSLwkeHOLWQ76yzWa0RWhXPwzt/NN7IN5JFU27mrhIR40mzuSC0h7S0dddwiV3Rtyua/zZDJjGN5lhzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li; spf=pass smtp.mailfrom=drbeat.li; arc=none smtp.client-ip=194.126.200.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=drbeat.li
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=drbeat.li
Received: from s019.cyon.net ([149.126.4.28])
	by mail-gateway-shared11.cyon.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim)
	(envelope-from <ig@drbeat.li>)
	id 1xI1Me-007OUn-2T
	for git@vger.kernel.org;
	Sat, 17 Oct 2026 12:10:10 +0200
Received: from [10.20.10.51] (port=58740 helo=mail.cyon.ch)
	by s019.cyon.net with esmtpa (Exim 4.100.1)
	(envelope-from <ig@drbeat.li>)
	id 1xI1Md-0000000DUom-1bWM;
	Sat, 17 Oct 2026 12:10:03 +0200
Received: by oh4.internal (Postfix, from userid 1000)
	id 0648440051; Sat, 17 Oct 2026 12:10:03 +0200 (CEST)
From: Beat Bolli <dev+git@drbeat.li>
To: git@vger.kernel.org
Cc: Xiangfei Ding <xfding@google.com>,
	Aniket Gupta <aniketgupta3001@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Beat Bolli <dev+git@drbeat.li>
Subject: [PATCH v3 1/3] imap-send: use the recommended TLS_method()
Date: Sat, 17 Oct 2026 12:09:54 +0200
Message-ID: <20261017100956.529225-1-dev+git@drbeat.li>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261012203057.969878-1-dev+git@drbeat.li>
References: <20261012203057.969878-1-dev+git@drbeat.li>
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
TLS_method() is the recommended function[1].

Let's use the current function, lest a reader of the code thinks we
don't support current TLS versions.

[1]: https://docs.openssl.org/master/man3/SSL_CTX_new/#history

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

