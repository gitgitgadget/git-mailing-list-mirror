Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F23101F516
	for <e@80x24.org>; Mon, 25 Jun 2018 18:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965012AbeFYSxl (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 14:53:41 -0400
Received: from mail-yw0-f202.google.com ([209.85.161.202]:51851 "EHLO
        mail-yw0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964861AbeFYSxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 14:53:39 -0400
Received: by mail-yw0-f202.google.com with SMTP id q66-v6so10856149ywc.18
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=YxPHppMxmdEG9nGmLsfoDlKYX/fd24foZCD78c5CFB8=;
        b=Q4l/jTBIOg7VsMW3WmSH0ylfxVUkkeZdtc9sqXprFHQwZZgmXnIaVcovaEq1pMDrBn
         6+2yjBr1kLiIOEHhRw6Ru4bdlyHBvBXLHzu1uzgeVoPV1bTWcy2Ekh4I5v/1OMuJMWUm
         JBRR/ChJkC0OCmfnd1l1ef8FPh9Jh3iSa9xjprV+S43Gk9HOulOVK2FmgFdWPu2cbnMb
         WaPcAIUF1g4CfTXH7kWTeRBCu/2FyZXZ9VJIBkr8Fw9Tk84nnws9YZ2RiAgcMgofm7Ly
         hUt/fv++0mEtiT36m6E57DmciJtTYqdfetid3tdonWKiy2S8UQtpl0BiqV2X92EyDxzI
         /CKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=YxPHppMxmdEG9nGmLsfoDlKYX/fd24foZCD78c5CFB8=;
        b=HaoLCmJtyH49Hyzthd5FdvsjuWwEYR8KzUQ3DHBppKXpEQUwZihd4d/lozhWljV6iG
         bDKi1e95oDCRZxH6ofQPnzDbXdffL4FimcHh8T6tI6BP9U11ti9IJHY3k4nR8lrSplqO
         jwrwsOI6wtbE2JLLYYTlZ0LiAoChWG+ALUQjxqXx9dgg9jsWcCGTvNUGQP4YuhZCKqnU
         /yQVFTRvB+6/qYI54dz3Q2FL3s1XV2zGxYmLhCl9kQ7GmNfrqpkpD4CizSx7tV45g3gN
         XxV4/fV4dlsmWVaZ2VgYNVShvXd/bQIQ6m0tzhl+lT9Z0vlTiCjWwyEDIHnTS/EH9nGR
         1aOw==
X-Gm-Message-State: APt69E0dtP8eDzVAbiXTjDb5zgR0Ly3wfyL1EWTfxKAmoH2pE80RbV30
        MVKo/6k+fnC8WsjDYXmvujFp3XKBn+0wYF0YQDDLmQggeemChoLJaWCEKzAXDWZBKniN0VMpYU7
        Cf20xBihrytQnQsbUBB2Vue67vqHtPkATW3xU5iZNbl2iTTqigFrhsPaX8g==
X-Google-Smtp-Source: AAOMgpdDuDHW4zNITZsjyNIngpejuiGT0EMgzRu+qMvQ1I69JP1iRISAos3mzngzi4JFwOdkOJe6VesOieA=
MIME-Version: 1.0
X-Received: by 2002:a81:3489:: with SMTP id b131-v6mr934401ywa.155.1529952819247;
 Mon, 25 Jun 2018 11:53:39 -0700 (PDT)
Date:   Mon, 25 Jun 2018 11:53:25 -0700
In-Reply-To: <20180625185332.164142-1-bmwill@google.com>
Message-Id: <20180625185332.164142-2-bmwill@google.com>
References: <20180620213235.10952-1-bmwill@google.com> <20180625185332.164142-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v4 1/8] test-pkt-line: add unpack-sideband subcommand
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jonathantanmy@google.com, gitster@pobox.com, sbeller@google.com,
        jrnieder@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an 'unpack-sideband' subcommand to the test-pkt-line helper to
enable unpacking packet line data sent multiplexed using a sideband.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/helper/test-pkt-line.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 0f19e53c7..30775f986 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,3 +1,4 @@
+#include "cache.h"
 #include "pkt-line.h"
 
 static void pack_line(const char *line)
@@ -48,6 +49,36 @@ static void unpack(void)
 	}
 }
 
+static void unpack_sideband(void)
+{
+	struct packet_reader reader;
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_CHOMP_NEWLINE);
+
+	while (packet_reader_read(&reader) != PACKET_READ_EOF) {
+		int band;
+		int fd;
+
+		switch (reader.status) {
+		case PACKET_READ_EOF:
+			break;
+		case PACKET_READ_NORMAL:
+			band = reader.line[0] & 0xff;
+			if (band < 1 || band > 2)
+				die("unexpected side band %d", band);
+			fd = band;
+
+			write_or_die(fd, reader.line + 1, reader.pktlen - 1);
+			break;
+		case PACKET_READ_FLUSH:
+			return;
+		case PACKET_READ_DELIM:
+			break;
+		}
+	}
+}
+
 int cmd_main(int argc, const char **argv)
 {
 	if (argc < 2)
@@ -57,6 +88,8 @@ int cmd_main(int argc, const char **argv)
 		pack(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
+	else if (!strcmp(argv[1], "unpack-sideband"))
+		unpack_sideband();
 	else
 		die("invalid argument '%s'", argv[1]);
 
-- 
2.18.0.rc2.346.g013aa6912e-goog

