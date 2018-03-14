Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B79D51F404
	for <e@80x24.org>; Wed, 14 Mar 2018 18:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752609AbeCNScp (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Mar 2018 14:32:45 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:47040 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752330AbeCNScn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Mar 2018 14:32:43 -0400
Received: by mail-vk0-f73.google.com with SMTP id u84so2685109vke.13
        for <git@vger.kernel.org>; Wed, 14 Mar 2018 11:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=0WGJkxP899yiRgcibmJlszkdBRLO0nypPsCz7WqsSiU=;
        b=ksaW16+10AEorh9208wzlQnscBxvC9PyvbAoZV8QvyAF/cuJcl0EM6rchl6WJIUvWf
         ojGccTL9FMKLCSFVayMVF66JI25KyTB5Y90M8vl83SkJujvzVIM6mOmTLLNYwFE4nbvK
         /mWp+InUgqr8oaHn6yKSHaGXuL4k3VFkWO+j1HVJJqxCT/zZK/Q19FxkEaNYIWKVTf7v
         tUOjbSdP6v9+CymYRRIUyVvXhvJzhhWlYYvBAvd9TG4ePtMvUlbzkomZGtumdAaLDwf/
         QZ+wcHvJpyVjdLFrUdyHPzgEvKJjqlVZ7h0cSbZLeP6JRZsNXJnMWuWfwQieYJKWDcXW
         99QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=0WGJkxP899yiRgcibmJlszkdBRLO0nypPsCz7WqsSiU=;
        b=FLQbXGuZdQSkb4MGaY7Km1w/2apm9uTBYeehft6Bdg+aitM4ymRQHeZw63DZSPsvgH
         fH49xmHmUEqx6DjvE1SpkLuzEdxLwxJ9BYzVqktWUDWXpo5e6gtMUYdHLntleIr2ftNf
         mymWxIzVcSM0NmSorX5HWLRaGhGoSIn6TfLL8oqDMC0CTpQ/aToVUdpojthiG8jnAJWL
         rDA0kT7T8IPnYufBcxV9eT6384jVCVWskCMBmVMbLjiM8CgOxB0qxzKO+0bdzBVz/ySD
         uQmbB07SNVaZnRcuO8vCjYZ8v89ePn6OeCnWPT9/UJK3QQ1LaabYxvXEqj1buAhFT9QK
         Ybgw==
X-Gm-Message-State: AElRT7EI370qnKGkKmxzmq1HSHhVadZzkpN9viUcUiDarfb76Qcijjiq
        ewXiQGR62gUXjTACJL52hw/QDbHs8WDo5cVfMFPh3So0GugRcO4Eo6mDOup70FHNtQV3KFSpIrR
        NlG2EbT7zsJqxomWssUT+N/0M3+NE1RQeuu3S2EWOZMkDWObGqu+Vr/Vz+A==
X-Google-Smtp-Source: AG47ELvtVbL5nVWOHsAOt+8k8pkzAe56qiXGdfyDpk4OZnjv3bB+syMNsyrNT90D4HFBTWqaLMZYsvegy/g=
MIME-Version: 1.0
X-Received: by 10.176.80.144 with SMTP id c16mr2384952uaa.19.1521052362941;
 Wed, 14 Mar 2018 11:32:42 -0700 (PDT)
Date:   Wed, 14 Mar 2018 11:31:48 -0700
In-Reply-To: <20180314183213.223440-1-bmwill@google.com>
Message-Id: <20180314183213.223440-12-bmwill@google.com>
References: <20180314183213.223440-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.2.804.g6dcf76e118-goog
Subject: [PATCH v5 11/35] test-pkt-line: introduce a packet-line test helper
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

