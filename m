Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3BC3B1F404
	for <e@80x24.org>; Thu, 15 Mar 2018 17:32:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752522AbeCORcQ (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Mar 2018 13:32:16 -0400
Received: from mail-ua0-f201.google.com ([209.85.217.201]:41038 "EHLO
        mail-ua0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752515AbeCORcO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Mar 2018 13:32:14 -0400
Received: by mail-ua0-f201.google.com with SMTP id w9so4588650uae.8
        for <git@vger.kernel.org>; Thu, 15 Mar 2018 10:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0WGJkxP899yiRgcibmJlszkdBRLO0nypPsCz7WqsSiU=;
        b=k0VQFBmoFfL13hmqDuPdfC90PYOOE3NGsRnjYWA2y/HeoDsGsYR7Nh5oYUCa2nTmIJ
         8hcPlhUkfjt/cNEpuHoLg7iv3pR7IJwrbZ8jaG6MYsxUP84/I3JciQ1cUZtQmJaTrQwC
         wJyl7VQYGxzlPQ0ovcYTL6S3QtWXYxwm9p9T8q+at5Ej7w43qfFJivwKwvM8K+jl6eLY
         hWli6PNAJdM/PYxMSw34vvqVi8xviQxXuyTodL5ZhvfHMuYPLIDWCmx17dK+raGiPbFs
         mVgR8sQm1FlmRy6y6KPnlhrEPO8RgfQZykZtPqhCBaFbQwi16RfEGrXpRSYIbFgCR9P8
         cIgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0WGJkxP899yiRgcibmJlszkdBRLO0nypPsCz7WqsSiU=;
        b=smT3ePM58lbapq1I3cQK8VkC+SwaffzQI/w6gk3VuxA8/9GwD0JhCNGUxrB7y4r5Pr
         8eezq8oUrO8ckuKyR9wrk0BUMI9tM6izS6BGTj1qFPQLYO6ms25nBhPmjnNlmslJ2sLS
         H9CEcjqCvkVbDmPmb0LXbWPkVX7EzFM5ZIyedODkDI6hDW3NFK02T/rIwbABEFdELqPv
         tjx5l5Dke9zUq4rBbhx5KuAAg3K7VfmlAarnLEb1pj4s5Gt3br+VZlde6YeSkDUPUONu
         MiZcyxww5F58UbPZl+k1py125CZ4K+1usetCx+Am6gBUDPyBBPKsmXdqOCqWGDSYMIPX
         MULA==
X-Gm-Message-State: AElRT7GDB5b79JjFIlo1V3GmKVjqDzIGmDf2jMdF7cfssIAqdoDPP/lO
        yHPlPQpX8beCMshdvN2IeYohAXLZt24D8aJyE0KT2SA7Z0UOe3xPvW1bCTQPOfRu5DSrmnfUPlz
        mA7XcE9p/3RCgBg6M0alClAHyNrt3pYOTc66baaDIrJvmr8RSbqiiEelbBA==
X-Google-Smtp-Source: AG47ELvmsh9qdq9F23YWelM4Ee0zpt9melzeRp3toBaQpEm6VC+pw0YIIy1N8pthcsTgnKwPh48V995zcII=
MIME-Version: 1.0
X-Received: by 10.176.80.144 with SMTP id c16mr3938147uaa.19.1521135133477;
 Thu, 15 Mar 2018 10:32:13 -0700 (PDT)
Date:   Thu, 15 Mar 2018 10:31:18 -0700
In-Reply-To: <20180315173142.176023-1-bmwill@google.com>
Message-Id: <20180315173142.176023-12-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com> <20180315173142.176023-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v6 11/35] test-pkt-line: introduce a packet-line test helper
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     git@jeffhostetler.com, gitster@pobox.com, jrnieder@gmail.com,
        pclouds@gmail.com, peff@peff.net, sbeller@google.com,
        stolee@gmail.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
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
index b7ccc05fac..3b849c0607 100644
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
index 0000000000..0f19e53c75
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
2.16.2.804.g6dcf76e118-goog

