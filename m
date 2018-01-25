Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CAB0A1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 00:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751896AbeAZAAI (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Jan 2018 19:00:08 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:54274 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751785AbeAYX7J (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jan 2018 18:59:09 -0500
Received: by mail-ot0-f201.google.com with SMTP id 40so5942911otv.21
        for <git@vger.kernel.org>; Thu, 25 Jan 2018 15:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=ybX2C6MmZe9YXsk6+c+lfBdyV6S5/85qibacLA2yCe8=;
        b=cc49sobim3Jc4nusI8tDUR6Vvd9Ylbgxt7TnCDBBAEJGc+wGqb2g4ARdBh5cJGwmCD
         kzhPn0yg6/nIelx8tIsjPxo9vVJgk6UREQ2Nl/KtjGVq8yeh7mSnRxZjfDbJChcBsu0e
         P0xXa01vv2TVSg/fnmSRujuI1lHl7ScJ1sOzRr0gFLqKOuzLwi7E4DF9mt+yqGGjEkDa
         PPb7xIC3ZBgWHv0rJk/WjW3IAA1/U7VBCTp7YgwvyVm/JZ8AMHkewOV8tW00CXZq30oM
         rk6E1vRIgPhgk9Im7WE1UoFo0TpQu6zDfIF8426NvUzv8he0x6ubWjETxQUfe+NRFuP5
         ihbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=ybX2C6MmZe9YXsk6+c+lfBdyV6S5/85qibacLA2yCe8=;
        b=kyu+JBESSB3EgQYosuR0dH1T0fnXxxzWrt5aM+d5lJ8SYApCsYErSoIzkxbIAM7arY
         IcN1p1XIsl5smbhhLGzuTkQDgJ/YFOVxhODxwdplg1aYxauOaYPdjVUz1K4NSt4J33wf
         eHxtUezfukiIANxjDGpAzWI8lZX0G7+da1Zw6jTz8+HegH4Z2kvip2dPRYQdpC0LZ7ZO
         1aPASrZ/jJ+QI6cguC6Ia6y8dXrLE6+io1l4NYZU+kp5S6kGjsiaL+VRkzj1ePulIxtD
         /SeNcSASQBfL82oOmF0eHjTWcBnzKF7ESHgPHqJ4Jz9O/W6oxlqQlRb19K/lFxXexJPR
         wzNg==
X-Gm-Message-State: AKwxytdOOJXjqaBHnUnv6v9nRwmRbp+9bhQq537ADkv3Ic+AvaplxXNa
        5wBW7cjSeIYRmXQkQ+pYM+h5NQM8wEVVgRgtdrlhl8jJjTweBtHo8h0RRx3rBfd4+H8T4AeX8Fp
        dzTwT6RAquqHYadvSecRFlkdX9p93w0/dvPLxbaywKHjU/DJoKcTQHpFfyg==
X-Google-Smtp-Source: AH8x224rmY8Jt1vP+PiwdOuvnl0dKm+ZDhFewzPBA/08xUPky+03wofBtD8kcspkmyWQIUrre9wL8L/zshQ=
MIME-Version: 1.0
X-Received: by 10.157.95.130 with SMTP id g2mr3346924oti.73.1516924748725;
 Thu, 25 Jan 2018 15:59:08 -0800 (PST)
Date:   Thu, 25 Jan 2018 15:58:22 -0800
In-Reply-To: <20180125235838.138135-1-bmwill@google.com>
Message-Id: <20180125235838.138135-12-bmwill@google.com>
References: <20180103001828.205012-1-bmwill@google.com> <20180125235838.138135-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v2 11/27] test-pkt-line: introduce a packet-line test helper
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, peff@peff.net,
        philipoakley@iee.org, stolee@gmail.com, jrnieder@gmail.com,
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
 t/helper/test-pkt-line.c | 62 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 63 insertions(+)
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
index 000000000..5df32b4cb
--- /dev/null
+++ b/t/helper/test-pkt-line.c
@@ -0,0 +1,62 @@
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
+
+	return 0;
+}
-- 
2.16.0.rc1.238.g530d649a79-goog

