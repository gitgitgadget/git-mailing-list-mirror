Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E5301F404
	for <e@80x24.org>; Wed, 12 Sep 2018 05:35:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbeILKik (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 06:38:40 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:52673 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726412AbeILKik (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 06:38:40 -0400
Received: by mail-io0-f202.google.com with SMTP id q20-v6so731852iod.19
        for <git@vger.kernel.org>; Tue, 11 Sep 2018 22:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=IHLxS4eMXxQw61VL6+yOdkd1SBJvUnvugKBMTIcGv8w=;
        b=eH+DRMldXEBkPSGYsQz/6tEEYFf+Cj4smYMFqIW+0/mu3Wz05BCk64cdA4qdAvMGBg
         NLthF+iyUahCp2DeqUGgXl731fSKGh4lMO+wTND1eQeHcelCgs5+C5JJVI52lnVHjwpb
         HZJ9SfoQj0WAdyQL5RhF1BrP888DYY6E8tuycWe8SrgIdFyt3xbYodr9l0nTTxJVUw19
         Gz4Xnlq+OEeEv+KDj1bhelXx6zaTHgnMRPI+glqkyRDElgp+/BRRUiowHTJT1jmwVqsw
         k1k3nRugWbxfEz6yfFXDsGw7RG84O7cPYL5HpTLP5nj0vqNz26yLMkR9BDH58hUQsyPf
         iu7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=IHLxS4eMXxQw61VL6+yOdkd1SBJvUnvugKBMTIcGv8w=;
        b=GzC1j3Sn5UhMma2hfy+6QjKuyCASs64LFTX3lXCuWwjCrwV7GddCJRpYZPe0PaayH6
         RvQz4ZPXUUX523/7JtGJUCBinrWRNlYTwlFRJ5nVSFhri6u70rmqaOgzQ4WlNMwkI2vK
         Upvd6PnSKFzUC5IHIKUb1AWUaZepcf9zJmmi/O5FHjZGA2lSmY/H2XZqhZ87ku0ybuTG
         kmEpW905OFKlkv2MVtCq4xcAfpWmO0G8Ft78/JPWpV0qXuJNmhdANbl2Q17Nq+kRpLpb
         E0U/fzKJuK4j+QrMDeQOl3dyZjMBbbEMx2qDXyzoKTx8ToFe4aFW8X6WNFBSAciv2QEr
         6HcA==
X-Gm-Message-State: APzg51Dqs/+RM0trx81YpTPx7Fk7RGaZh6M6lCLUR+9T7g69W3jEFUSH
        ie4hEuxnL8Ld4XDI9v/sJD0yswFtUBOMITdSIeR5n904TypuRJ3424rAmcrqzK/luZr7AGlP5oj
        OeIYy9bUdrwVGmq8H7K3jQ4389brVzlE2pC+pbAxkvX3wrkjqt+mMKItvqFnu51U=
X-Google-Smtp-Source: ANB0VdYwtu6tYUjkZykPD3xCPCMwwQwxxncUq6i8rY2VC4QXiWpyQQnMaBOmqjfvXxAcmqJlNpH4Nxyz5vjCuA==
X-Received: by 2002:a6b:de0e:: with SMTP id v14-v6mr127329iog.34.1536730549994;
 Tue, 11 Sep 2018 22:35:49 -0700 (PDT)
Date:   Tue, 11 Sep 2018 22:35:17 -0700
In-Reply-To: <20180912053519.31085-1-steadmon@google.com>
Message-Id: <20180912053519.31085-2-steadmon@google.com>
Mime-Version: 1.0
References: <20180912053519.31085-1-steadmon@google.com>
X-Mailer: git-send-email 2.19.0.397.gdd90340f6a-goog
Subject: [PATCH 1/3] archive: use packet_reader for communications
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, l.s.r@web.de,
        sandals@crustytoothpaste.net, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Using packet_reader will simplify version detection and capability
handling, which will make implementation of protocol v2 support in
git-archive easier.

Signed-off-by: Josh Steadmon <steadmon@google.com>
---
 builtin/archive.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/builtin/archive.c b/builtin/archive.c
index e74f67539..e54fc39ad 100644
--- a/builtin/archive.c
+++ b/builtin/archive.c
@@ -27,10 +27,11 @@ static int run_remote_archiver(int argc, const char **argv,
 			       const char *remote, const char *exec,
 			       const char *name_hint)
 {
-	char *buf;
 	int fd[2], i, rv;
 	struct transport *transport;
 	struct remote *_remote;
+	struct packet_reader reader;
+	enum packet_read_status status;
 
 	_remote = remote_get(remote);
 	if (!_remote->url[0])
@@ -38,6 +39,8 @@ static int run_remote_archiver(int argc, const char **argv,
 	transport = transport_get(_remote, _remote->url[0]);
 	transport_connect(transport, "git-upload-archive", exec, fd);
 
+	packet_reader_init(&reader, fd[0], NULL, 0, PACKET_READ_CHOMP_NEWLINE);
+
 	/*
 	 * Inject a fake --format field at the beginning of the
 	 * arguments, with the format inferred from our output
@@ -53,18 +56,20 @@ static int run_remote_archiver(int argc, const char **argv,
 		packet_write_fmt(fd[1], "argument %s\n", argv[i]);
 	packet_flush(fd[1]);
 
-	buf = packet_read_line(fd[0], NULL);
-	if (!buf)
+	status = packet_reader_read(&reader);
+
+	if (status == PACKET_READ_FLUSH)
 		die(_("git archive: expected ACK/NAK, got a flush packet"));
-	if (strcmp(buf, "ACK")) {
-		if (starts_with(buf, "NACK "))
-			die(_("git archive: NACK %s"), buf + 5);
-		if (starts_with(buf, "ERR "))
-			die(_("remote error: %s"), buf + 4);
+	if (strcmp(reader.buffer, "ACK")) {
+		if (starts_with(reader.buffer, "NACK "))
+			die(_("git archive: NACK %s"), reader.buffer + 5);
+		if (starts_with(reader.buffer, "ERR "))
+			die(_("remote error: %s"), reader.buffer + 4);
 		die(_("git archive: protocol error"));
 	}
 
-	if (packet_read_line(fd[0], NULL))
+	status = packet_reader_read(&reader);
+	if (status != PACKET_READ_FLUSH)
 		die(_("git archive: expected a flush"));
 
 	/* Now, start reading from fd[0] and spit it out to stdout */
-- 
2.19.0.397.gdd90340f6a-goog

