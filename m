Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 780521F404
	for <e@80x24.org>; Wed, 28 Feb 2018 23:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964991AbeB1XXt (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Feb 2018 18:23:49 -0500
Received: from mail-vk0-f74.google.com ([209.85.213.74]:49824 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964986AbeB1XXq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Feb 2018 18:23:46 -0500
Received: by mail-vk0-f74.google.com with SMTP id d1so2275116vke.16
        for <git@vger.kernel.org>; Wed, 28 Feb 2018 15:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=dWeqm8J7NhpZfxBjL9Mtz2ImlX/rppiXcb1MGiPAUb0=;
        b=PIW215ltZlqooxE8yboYjzVT+kd2AWnvXtFzYVc8UDNoRkPyc4D4PfSx8LeYIsOcOM
         YeWwSN5NMS6aU3+s2Wz05Q0Tw/KdiW8NH4kwzXtMEULmi1YVuT744+/VcmomkYX0Wx+c
         DPL1SQW4YGGKJBaY+xg8H5LaCY5PtJ2iGD+9lwrdqtmwT/i6b66FPWKoKxi9GddSkHXo
         7w9HJaKhyRobOwwQ9+BMdpuMaHH2z7mUXCZrqhCbKKbuIiFcqEZLbl4K4GYbOn1bQfFH
         UrV0VUaxDj+BZ2UzcikQuLz7ySnC9zDmMowspxbGdJ36ViKuVUGvXz5/ysqD1WnATlrH
         FYkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=dWeqm8J7NhpZfxBjL9Mtz2ImlX/rppiXcb1MGiPAUb0=;
        b=V0C/R3LWBOXZwJ38pPRydXP0Z2wU6Jr6qprF3mXbD5hjEisc5eSmMzoVxAjuxRlszY
         CnRPY7UhuMJ7f2DdBDERP4/OlVvg56w80BESDbr41AuFZrBX1YZL08dBtIv3aMWUzto5
         WjoKrB9NQfbldnqx/15+XPtRyMu2GzsmdEOyg7FGZXDvBLWR4VuacTPLK51PNc6UWSFQ
         zk6t1x21eZB8uXR2B+ZhB1edAwFlnZ7N6tSt8t7k0VUteauWjB5upNUF3yC3jnvIqOqu
         7fJm5Ig9+RXsxNo0eSIJ+beEE4XgCyKQvRwVyEpsv/YWlD8AR7W4ZhtyGvVcGo4OAx+z
         rmHQ==
X-Gm-Message-State: APf1xPD4qU1nBYJl43pZSmIXK5nHhoFo2ty7Cn5q3PQtJMcz9nirD+yL
        SekHaUAzUX6gb+n8Wa126WnSfgcWbLwHilkEatfVk3qRkI6nTpyloHhHiRlSx5YTv0Xz2SozSfj
        eZ4wxL29AOUU8Qw2ddEO3GJE8oYcJ+p/PEtzxRC+1Do9DsSA7LxokpYikUg==
X-Google-Smtp-Source: AG47ELuzHdy3QqhDaI1bg2ZajGoZ+1fsYNqxX2H+AV5L/dcJv5ob4/sJ/0CXCP5Oo15EvGNWRd4WISdkbW4=
MIME-Version: 1.0
X-Received: by 10.176.49.69 with SMTP id e5mr9207900uam.93.1519860226076; Wed,
 28 Feb 2018 15:23:46 -0800 (PST)
Date:   Wed, 28 Feb 2018 15:22:28 -0800
In-Reply-To: <20180228232252.102167-1-bmwill@google.com>
Message-Id: <20180228232252.102167-12-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com> <20180228232252.102167-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.1.107.gffe1b9127
Subject: [PATCH v4 11/35] test-pkt-line: introduce a packet-line test helper
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce a packet-line test helper which can either pack or unpack an
input stream into packet-lines and writes out the result to stdout.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 Makefile                 |  1 +
 t/helper/test-pkt-line.c | 64 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)
 create mode 100644 t/helper/test-pkt-line.c

diff --git a/Makefile b/Makefile
index b7ccc05fa..3b849c060 100644
--- a/Makefile
+++ b/Makefile
@@ -669,6 +669,7 @@ TEST_PROGRAMS_NEED_X += test-mktemp
 TEST_PROGRAMS_NEED_X += test-online-cpus
 TEST_PROGRAMS_NEED_X += test-parse-options
 TEST_PROGRAMS_NEED_X += test-path-utils
+TEST_PROGRAMS_NEED_X += test-pkt-line
 TEST_PROGRAMS_NEED_X += test-prio-queue
 TEST_PROGRAMS_NEED_X += test-read-cache
 TEST_PROGRAMS_NEED_X += test-write-cache
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
new file mode 100644
index 000000000..0f19e53c7
--- /dev/null
+++ b/t/helper/test-pkt-line.c
@@ -0,0 +1,64 @@
+#include "pkt-line.h"
+
+static void pack_line(const char *line)
+{
+	if (!strcmp(line, "0000") || !strcmp(line, "0000\n"))
+		packet_flush(1);
+	else if (!strcmp(line, "0001") || !strcmp(line, "0001\n"))
+		packet_delim(1);
+	else
+		packet_write_fmt(1, "%s", line);
+}
+
+static void pack(int argc, const char **argv)
+{
+	if (argc) { /* read from argv */
+		int i;
+		for (i = 0; i < argc; i++)
+			pack_line(argv[i]);
+	} else { /* read from stdin */
+		char line[LARGE_PACKET_MAX];
+		while (fgets(line, sizeof(line), stdin)) {
+			pack_line(line);
+		}
+	}
+}
+
+static void unpack(void)
+{
+	struct packet_reader reader;
+	packet_reader_init(&reader, 0, NULL, 0,
+			   PACKET_READ_GENTLE_ON_EOF |
+			   PACKET_READ_CHOMP_NEWLINE);
+
+	while (packet_reader_read(&reader) != PACKET_READ_EOF) {
+		switch (reader.status) {
+		case PACKET_READ_EOF:
+			break;
+		case PACKET_READ_NORMAL:
+			printf("%s\n", reader.line);
+			break;
+		case PACKET_READ_FLUSH:
+			printf("0000\n");
+			break;
+		case PACKET_READ_DELIM:
+			printf("0001\n");
+			break;
+		}
+	}
+}
+
+int cmd_main(int argc, const char **argv)
+{
+	if (argc < 2)
+		die("too few arguments");
+
+	if (!strcmp(argv[1], "pack"))
+		pack(argc - 2, argv + 2);
+	else if (!strcmp(argv[1], "unpack"))
+		unpack();
+	else
+		die("invalid argument '%s'", argv[1]);
+
+	return 0;
+}
-- 
2.16.2.395.g2e18187dfd-goog

