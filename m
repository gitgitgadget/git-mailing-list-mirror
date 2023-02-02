Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C52CC05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:45:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjBBJpe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:45:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232592AbjBBJpQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:45:16 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409D886A3
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:44:40 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q10so1130371wrm.4
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xCWK+Xm9Mtj9MO/xbb4s4t9AAmgjyiKyjYIn2zcujpg=;
        b=qHnMHTUV1budSIWD//+gsWX5VIOrqC78ZBuOevNMCRcCVrjxR2yVJyKkxhcCdZsZmo
         LC2G1f4XTy7VbdkI7uYACq1ZJOjij8YU6AeXSy3pe6LTw15iqG5aZaJtF3LbP88kbyjr
         iRm4RZ+wLjlEMuZXEeym15JZsQOnQt0SCDnKQCNPb161k8qiEySq/QE6kBTKkRLL/skD
         g0DP3LObMNnsCd/6MfPvk/wWCP7jR8kdsUUwRO3jUrJ78qN6OdJfuMgAQZ5sVMpoI/gU
         MJZPHzqSUC0p67QRUGkl/QDK96t/DnN9Yi+xbZObkKWjDBMBrcA3rDjU88v7VT+9o87R
         Q7QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xCWK+Xm9Mtj9MO/xbb4s4t9AAmgjyiKyjYIn2zcujpg=;
        b=36x3r9G1miZRAGd2r3nhMwbrkf0q/9G4tRlyNqorretS2PW5o6X2ZOJj3wZ4rqza9a
         SGq8qLgvzia8YaXtKZF2efp77dse9zYPCGeJ9s4ezlR1S67CmTbShDL6x2A+loOT0ARL
         RRC0z5zWZ6XEsq/4b84P0nVAWl/ichenVRPmVYsUPZhC4AW6s5QizisPl3ZC7aUWGMru
         bz3oxXZn/RvE4tFaccf/NEAeg6sPn1bSisYukH2O1At07LNOJSy5fcUDxPHz6LqtMGCb
         msQYgcms93kY30X3BVHQw5VoAABzyns6dxbFPStQrCCwqKuQmKRnEKFqLZEVL9bhsc+3
         7Fhg==
X-Gm-Message-State: AO0yUKUlXgzk3QsSAf2CM4l1c4q9y7tfyfZcLFt926jwMZQi2SZbWpJD
        mQTcAXcxPW8GE/4ucNGlLzOPOiga8gvEG07u
X-Google-Smtp-Source: AK7set/gC6+fpTuqb63crQMn60Jx/5P00kZxxmJGRiMn6BcgXQ2K6DuYZl6arNRyRPPcbCqYCIxboA==
X-Received: by 2002:a5d:47a2:0:b0:2bf:b5bd:8f60 with SMTP id 2-20020a5d47a2000000b002bfb5bd8f60mr4384307wrb.61.1675331068127;
        Thu, 02 Feb 2023 01:44:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19487938wrx.115.2023.02.02.01.44.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:44:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] imap-send: remove old --no-curl codepath
Date:   Thu,  2 Feb 2023 10:44:16 +0100
Message-Id: <patch-v2-5.6-17c75e6381a-20230202T093706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In the preceding the "--curl" codepath was made mandatory, so now we
won't use the OpenSSL implementation codepaths in imap-send.c except
for "imap.tunnel".

So let's follow-up and delete the code on that path which was specific
to the "imap.host" mode.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 imap-send.c | 127 +++++++---------------------------------------------
 1 file changed, 16 insertions(+), 111 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9d7cb22285d..9712a8d4f93 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -197,14 +197,7 @@ static void socket_perror(const char *func, struct imap_socket *sock, int ret)
 	}
 }
 
-#ifdef NO_OPENSSL
-static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int verify)
-{
-	fprintf(stderr, "SSL requested but SSL support not compiled in\n");
-	return -1;
-}
-
-#else
+#ifndef NO_OPENSSL
 
 static int host_matches(const char *host, const char *pattern)
 {
@@ -253,7 +246,7 @@ static int verify_hostname(X509 *cert, const char *hostname)
 		     cname, hostname);
 }
 
-static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int verify)
+static int ssl_socket_connect(struct imap_socket *sock, int verify)
 {
 #if (OPENSSL_VERSION_NUMBER >= 0x10000000L)
 	const SSL_METHOD *meth;
@@ -279,8 +272,7 @@ static int ssl_socket_connect(struct imap_socket *sock, int use_tls_only, int ve
 		return -1;
 	}
 
-	if (use_tls_only)
-		SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3);
+	SSL_CTX_set_options(ctx, SSL_OP_NO_SSLv2 | SSL_OP_NO_SSLv3);
 
 	if (verify)
 		SSL_CTX_set_verify(ctx, SSL_VERIFY_PEER, NULL);
@@ -944,7 +936,8 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 	struct imap_store *ctx;
 	struct imap *imap;
 	char *arg, *rsp;
-	int s = -1, preauth;
+	int preauth;
+	struct child_process tunnel = CHILD_PROCESS_INIT;
 
 	CALLOC_ARRAY(ctx, 1);
 
@@ -953,107 +946,19 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 	imap->in_progress_append = &imap->in_progress;
 
 	/* open connection to IMAP server */
+	imap_info("Starting tunnel '%s'... ", srvc->tunnel);
 
-	if (srvc->tunnel) {
-		struct child_process tunnel = CHILD_PROCESS_INIT;
-
-		imap_info("Starting tunnel '%s'... ", srvc->tunnel);
-
-		strvec_push(&tunnel.args, srvc->tunnel);
-		tunnel.use_shell = 1;
-		tunnel.in = -1;
-		tunnel.out = -1;
-		if (start_command(&tunnel))
-			die("cannot start proxy %s", srvc->tunnel);
-
-		imap->buf.sock.fd[0] = tunnel.out;
-		imap->buf.sock.fd[1] = tunnel.in;
-
-		imap_info("ok\n");
-	} else {
-#ifndef NO_IPV6
-		struct addrinfo hints, *ai0, *ai;
-		int gai;
-		char portstr[6];
-
-		xsnprintf(portstr, sizeof(portstr), "%d", srvc->port);
-
-		memset(&hints, 0, sizeof(hints));
-		hints.ai_socktype = SOCK_STREAM;
-		hints.ai_protocol = IPPROTO_TCP;
-
-		imap_info("Resolving %s... ", srvc->host);
-		gai = getaddrinfo(srvc->host, portstr, &hints, &ai);
-		if (gai) {
-			fprintf(stderr, "getaddrinfo: %s\n", gai_strerror(gai));
-			goto bail;
-		}
-		imap_info("ok\n");
-
-		for (ai0 = ai; ai; ai = ai->ai_next) {
-			char addr[NI_MAXHOST];
-
-			s = socket(ai->ai_family, ai->ai_socktype,
-				   ai->ai_protocol);
-			if (s < 0)
-				continue;
+	strvec_push(&tunnel.args, srvc->tunnel);
+	tunnel.use_shell = 1;
+	tunnel.in = -1;
+	tunnel.out = -1;
+	if (start_command(&tunnel))
+		die("cannot start proxy %s", srvc->tunnel);
 
-			getnameinfo(ai->ai_addr, ai->ai_addrlen, addr,
-				    sizeof(addr), NULL, 0, NI_NUMERICHOST);
-			imap_info("Connecting to [%s]:%s... ", addr, portstr);
+	imap->buf.sock.fd[0] = tunnel.out;
+	imap->buf.sock.fd[1] = tunnel.in;
 
-			if (connect(s, ai->ai_addr, ai->ai_addrlen) < 0) {
-				close(s);
-				s = -1;
-				perror("connect");
-				continue;
-			}
-
-			break;
-		}
-		freeaddrinfo(ai0);
-#else /* NO_IPV6 */
-		struct hostent *he;
-		struct sockaddr_in addr;
-
-		memset(&addr, 0, sizeof(addr));
-		addr.sin_port = htons(srvc->port);
-		addr.sin_family = AF_INET;
-
-		imap_info("Resolving %s... ", srvc->host);
-		he = gethostbyname(srvc->host);
-		if (!he) {
-			perror("gethostbyname");
-			goto bail;
-		}
-		imap_info("ok\n");
-
-		addr.sin_addr.s_addr = *((int *) he->h_addr_list[0]);
-
-		s = socket(PF_INET, SOCK_STREAM, 0);
-
-		imap_info("Connecting to %s:%hu... ", inet_ntoa(addr.sin_addr), ntohs(addr.sin_port));
-		if (connect(s, (struct sockaddr *)&addr, sizeof(addr))) {
-			close(s);
-			s = -1;
-			perror("connect");
-		}
-#endif
-		if (s < 0) {
-			fputs("Error: unable to connect to server.\n", stderr);
-			goto bail;
-		}
-
-		imap->buf.sock.fd[0] = s;
-		imap->buf.sock.fd[1] = dup(s);
-
-		if (srvc->use_ssl &&
-		    ssl_socket_connect(&imap->buf.sock, 0, srvc->ssl_verify)) {
-			close(s);
-			goto bail;
-		}
-		imap_info("ok\n");
-	}
+	imap_info("ok\n");
 
 	/* read the greeting string */
 	if (buffer_gets(&imap->buf, &rsp)) {
@@ -1081,7 +986,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 		if (!srvc->use_ssl && CAP(STARTTLS)) {
 			if (imap_exec(ctx, NULL, "STARTTLS") != RESP_OK)
 				goto bail;
-			if (ssl_socket_connect(&imap->buf.sock, 1,
+			if (ssl_socket_connect(&imap->buf.sock,
 					       srvc->ssl_verify))
 				goto bail;
 			/* capabilities may have changed, so get the new capabilities */
-- 
2.39.1.1392.g63e6d408230

