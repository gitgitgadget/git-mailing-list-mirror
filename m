Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB391C61DA4
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbjBBJpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbjBBJpP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:45:15 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7398C88CF9
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:44:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a2so846165wrd.6
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:44:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lOE+hk1BdpdFrxkt5hnQhDOoVqsysLPJSROMXBQdPyw=;
        b=W9WSnPRaEJjUIrxYJP2gnXRGvp+buXwoMVR2MNCGwGe6Ut7DCEfGs2lotgn0pbSU1B
         qEeAd1/7IJWsc+itjIy2TKkKaadsw817ErFcB5CO0R2ZM7PcAvnZPFqMqZRmjtYDJAce
         ifW+vVs8tG21HAdjsRFzOp7mNILjZpXA5M8hRiwCqciXdCqNEJSz3qI4b4/x0o0CPp9E
         oRDWDOA7quncrryJS3BMe95JZNbBHx3e2WLKwhU4NIGlwyFgdnWUy2W+KdmBvrnsNip6
         dKl4cT4WbcTzF2Fr8noUb7Q8ZxNRyKOkhJNQtK9L4tPW/L/7KCKzpcOCzEhzEWQGZPu+
         j+Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lOE+hk1BdpdFrxkt5hnQhDOoVqsysLPJSROMXBQdPyw=;
        b=3T0WPxkPpK0RCt52lwRKdEhxMcwysBJfU+tymIe4wrBCJAqxoozxaNCF5hcEkfqBhN
         8QTEpIMYTYsAtWy3eO8vYC8hQhTYHYstY8jpzd4XRPxCkHy8eNcnFLgjKd7TGVaGCjIe
         sKBDoWIIWW+17WaFD35l1JInjeQFQdmWfkxDwhF5gNDXF4PK0n7WO34pMZSlrNJybmDA
         pCUbkX3sR6bSg6SH9DXtW7mXVQJ/BjHLRyjhnfHcvOKsDsYx0MOztF46jkJZS7B+mkm7
         g6MsB1RFTrwmgIuH6cbB6rNlunH7G0+GLkpPdXvNm6U9/dVYJsg75VAoPaHVqmi5fSAl
         W7Yg==
X-Gm-Message-State: AO0yUKWcDCg1D15Zc5B37oJtV7XkI6ymzMKUYdjtX0grtsBpCGxqEpYw
        TVhGLwY2PxdjlfPqbgjI2fJDzqG/G94NjAdf
X-Google-Smtp-Source: AK7set+0yA9buz5YpQ+HN+EV0zTfFjbqu3SH+jT+OrS2j9BpbLPw3uGzgFXrz5BXvLgiKraNlGT8Qg==
X-Received: by 2002:a05:6000:1c15:b0:2bf:b27f:c9b3 with SMTP id ba21-20020a0560001c1500b002bfb27fc9b3mr6005248wrb.32.1675331069130;
        Thu, 02 Feb 2023 01:44:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b14-20020a05600010ce00b0029e1aa67fd2sm19487938wrx.115.2023.02.02.01.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:44:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] imap-send: correctly report "host" when using "tunnel"
Date:   Thu,  2 Feb 2023 10:44:17 +0100
Message-Id: <patch-v2-6.6-686febb8cdc-20230202T093706Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
References: <patch-1.1-3bea1312322-20230201T225915Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20230202T093706Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Before [1] we'd force the "imap.host" to be set, even if the
"imap.tunnel" was set, and then proceed to not use the "host" for
establishing a connection, as we'd use the tunneling command.

However, we'd still use the "imap.host" if it was set as the "host"
field given to the credential helper, and in messages that were shared
with the non-tunnel mode, until a preceding commit made these OpenSSL
codepaths tunnel-only.

Let's always give "host=tunnel" to the credential helper when in the
"imap.tunnel" mode, and rephrase the relevant messages to indicate
that we're tunneling. This changes the existing behavior, but that
behavior was emergent and didn't make much sense. If we were using
"imap.tunnel" the value in "imap.host" might be entirely unrelated to
the host we're tunneling to. Let's not pretend to know more than we do
in that case.

1. 34b5cd1fe9f (Don't force imap.host to be set when imap.tunnel is
   set, 2008-04-22)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 imap-send.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/imap-send.c b/imap-send.c
index 9712a8d4f93..24b30c143a7 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -917,7 +917,7 @@ static void server_fill_credential(struct imap_server_conf *srvc, struct credent
 		return;
 
 	cred->protocol = xstrdup(srvc->use_ssl ? "imaps" : "imap");
-	cred->host = xstrdup(srvc->host);
+	cred->host = xstrdup(srvc->tunnel ? "tunnel" : srvc->host);
 
 	cred->username = xstrdup_or_null(srvc->user);
 	cred->password = xstrdup_or_null(srvc->pass);
@@ -1004,7 +1004,7 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 				if (!CAP(AUTH_CRAM_MD5)) {
 					fprintf(stderr, "You specified "
 						"CRAM-MD5 as authentication method, "
-						"but %s doesn't support it.\n", srvc->host);
+						"but tunnel doesn't support it.\n");
 					goto bail;
 				}
 				/* CRAM-MD5 */
@@ -1021,8 +1021,8 @@ static struct imap_store *imap_open_store(struct imap_server_conf *srvc, const c
 			}
 		} else {
 			if (CAP(NOLOGIN)) {
-				fprintf(stderr, "Skipping account %s@%s, server forbids LOGIN\n",
-					srvc->user, srvc->host);
+				fprintf(stderr, "Skipping account %s, server forbids LOGIN\n",
+					srvc->user);
 				goto bail;
 			}
 			if (!imap->buf.sock.ssl)
@@ -1434,12 +1434,9 @@ int cmd_main(int argc, const char **argv)
 		fprintf(stderr, "no imap store specified\n");
 		return 1;
 	}
-	if (!server.host) {
-		if (!server.tunnel) {
-			fprintf(stderr, "no imap host specified\n");
-			return 1;
-		}
-		server.host = "tunnel";
+	if (!server.host && !server.tunnel) {
+		fprintf(stderr, "no imap host specified\n");
+		return 1;
 	}
 
 	/* read the messages */
-- 
2.39.1.1392.g63e6d408230

