Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7636B13D2BB
	for <git@vger.kernel.org>; Sat, 17 Aug 2024 08:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723882892; cv=none; b=KyiWGpNx7y+qeQ9tz+er6BtAXfEu3cTH9uYTFFs5oYs0e3NY+ZH5JxYioq/YsnDH5p4H333F8rfzKWDFCmSmYnpeUETxvco/Cn3Ukrm0uRXeyumn/PsITfJs+ZPma/mjODiEV5ye3gar4lxl4oN2zg2wMsZcAJ8pUOCNj3UgraA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723882892; c=relaxed/simple;
	bh=Q+Dgufsx3wduSWkFtV0HF6ozt9Zhy4eUHvfoyEzUGpo=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MnfTMkTV6bJHKcBNOmCGILPOOZ8moXGhJczKTuOjOATfXTGPzHUA2Wc/QY2WtzXaNYFOfTAueei5ur2SSpaoIlU2qeX1CjW4kLNcS4p2oB0jwN2T0x7vMnFqr5qQzRtqXxt/IIOHwZDXFKOHGXGuanQYc2G/rpm0IxjbVfskEGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 24670 invoked by uid 109); 17 Aug 2024 08:21:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sat, 17 Aug 2024 08:21:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27929 invoked by uid 111); 17 Aug 2024 08:21:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 17 Aug 2024 04:21:33 -0400
Authentication-Results: peff.net; auth=none
Date: Sat, 17 Aug 2024 04:21:27 -0400
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: [PATCH 01/15] imap-send: mark unused parameter in
 ssl_socket_connect() fallback
Message-ID: <20240817082127.GA10287@coredump.intra.peff.net>
References: <20240817082101.GA6761@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240817082101.GA6761@coredump.intra.peff.net>

Commit cea1ff7f1f (imap-send: drop global `imap_server_conf` variable,
2024-06-07) added an imap_server_conf parameter to several functions.
But when compiled with NO_OPENSSL, the ssl_socket_connect() fallback
just returns immediately, so its parameters all need to be annotated to
avoid triggering -Wunused-parameter.

Signed-off-by: Jeff King <peff@peff.net>
---
 imap-send.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/imap-send.c b/imap-send.c
index 01404e5047..3551908de6 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -190,7 +190,7 @@ static void socket_perror(const char *func, struct imap_socket *sock, int ret)
 
 #ifdef NO_OPENSSL
 static int ssl_socket_connect(struct imap_socket *sock UNUSED,
-			      const struct imap_server_conf *cfg,
+			      const struct imap_server_conf *cfg UNUSED,
 			      int use_tls_only UNUSED)
 {
 	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
-- 
2.46.0.585.gd6679c16d8

