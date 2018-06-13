Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5AB221F403
	for <e@80x24.org>; Wed, 13 Jun 2018 21:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935815AbeFMVje (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Jun 2018 17:39:34 -0400
Received: from mail-io0-f202.google.com ([209.85.223.202]:34799 "EHLO
        mail-io0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935384AbeFMVjc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jun 2018 17:39:32 -0400
Received: by mail-io0-f202.google.com with SMTP id x23-v6so3216607iob.1
        for <git@vger.kernel.org>; Wed, 13 Jun 2018 14:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=wzFVAowre/IJb77uZb8AuJac6m71olQAALfj4tYl3XQ=;
        b=jypqtmoFXYHpTy+58iJip8TODuSDye+hen+mS+QrVrsx4CjyVWBH2MtmJHqvruWbpS
         qTBnbDxssajPIQnSc8e8SHCDm7ztqtrhAj0uxlO5zxZ9oYB3WhuyphMbSBDdcTn+dbj9
         eusBgxo6udDvJpW2TT1KbSYlyCiOtO3Yo6qCJQBnA2imw147qjD12ydLFOnCdMAHCT1h
         1zw6aLFCD4dXjpsVtr7CCHDRaJmTedSzzdswQg9aYlh91xUvpoJYYDFJ9KpnaJp33WVo
         9QnzdZHRPEkcktG7bJmOi3sCYqq1HJyh2IyVqnCMIVpzsAlFNCKGsUILlX1odawdMPc0
         LMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=wzFVAowre/IJb77uZb8AuJac6m71olQAALfj4tYl3XQ=;
        b=RHaidRMjP8Ly2k01iuPm+c3hfR0MwhJvab9daO6PPYi3xOit/U0JXC7mHRiNAyCHcA
         lJEPqPbYmng5g+PNtTT+8xshbBq5ucwMPRqkcwlJr+jGmzh6lE4bLp6g5BIiEU1ud9Lq
         wd5JUnwZ6enpXXgRA15lUK9N1bJ/4n+78NXrxvoP6UUZ0LIOIKKMWoHzxIIbv01oMruA
         e3z5t3z3JinSpZtMccYWzmZG5FIh7zbCVIo29Ftq3xVBq7mT6+72Y8tU2WM27qqisfES
         ZfrbiEhB4tu0KH2oS+lJsAXcjU8kIaFDCwaPAapPidRngV5w8pwWgSm78ZoQZedWkW9X
         2Klw==
X-Gm-Message-State: APt69E3ZANjGZPtkQ/x54A0r6n0qi1pNBKSRgK5fNFVU53zXSrapziHv
        dackhPp1cMs1/EcVdOOcya1YCKp3t3z7lNKMue3onICOLkMJ3urFzhuGupH+mtrqKyoRD2uOx0L
        k9IEraFEwTrmqS9NZIFNw807kWrAuwoFzatcDbv42/EaaSn2hm/L2K1kYSQ==
X-Google-Smtp-Source: ADUXVKKVJg8yyW/TK4qznHMazx8qdVFOh038VV/m9xGQwvxvU78eskQcqowZd2Ved/kl72ckpVtrI14pKiQ=
MIME-Version: 1.0
X-Received: by 2002:a24:7614:: with SMTP id z20-v6mr2976779itb.48.1528925971773;
 Wed, 13 Jun 2018 14:39:31 -0700 (PDT)
Date:   Wed, 13 Jun 2018 14:39:18 -0700
In-Reply-To: <20180613213925.10560-1-bmwill@google.com>
Message-Id: <20180613213925.10560-2-bmwill@google.com>
References: <20180605175144.4225-1-bmwill@google.com> <20180613213925.10560-1-bmwill@google.com>
X-Mailer: git-send-email 2.18.0.rc1.242.g61856ae69a-goog
Subject: [PATCH v2 1/8] test-pkt-line: add unpack-sideband subcommand
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, ramsay@ramsayjones.plus.com,
        Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add an 'unpack-sideband' subcommand to the test-pkt-line helper to
enable unpacking packet line data sent multiplexed using a sideband.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/helper/test-pkt-line.c | 37 +++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index 0f19e53c7..2a55ffff1 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,3 +1,4 @@
+#include "cache.h"
 #include "pkt-line.h"
 
 static void pack_line(const char *line)
@@ -48,6 +49,40 @@ static void unpack(void)
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
+			if (band == 1)
+				fd = 1;
+			else
+				fd = 2;
+
+			write_or_die(fd, reader.line+1, reader.pktlen-1);
+
+			if (band == 3)
+				die("sind-band error");
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
@@ -57,6 +92,8 @@ int cmd_main(int argc, const char **argv)
 		pack(argc - 2, argv + 2);
 	else if (!strcmp(argv[1], "unpack"))
 		unpack();
+	else if (!strcmp(argv[1], "unpack-sideband"))
+		unpack_sideband();
 	else
 		die("invalid argument '%s'", argv[1]);
 
-- 
2.18.0.rc1.242.g61856ae69a-goog

