Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9508F1F404
	for <e@80x24.org>; Wed,  7 Feb 2018 01:13:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932215AbeBGBNo (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Feb 2018 20:13:44 -0500
Received: from mail-ot0-f201.google.com ([74.125.82.201]:44513 "EHLO
        mail-ot0-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932199AbeBGBNl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Feb 2018 20:13:41 -0500
Received: by mail-ot0-f201.google.com with SMTP id g33so2128446oth.11
        for <git@vger.kernel.org>; Tue, 06 Feb 2018 17:13:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=Xfcn/JEp26t1nhIyrAR+Tljl/UPuux0azZF2DlwFDh0=;
        b=jEHOqUGrznPbZ9DynJKs8/0fx5y98pRQYgHcwUN9mKlCaqKd1ANUJWGnMELTtdBDmW
         GMjwBWA8swK7j5AOaNgksvYTAgmHRDjnpHKG0ygCqA6LGlOxzy5ut3KKiStXSjZwhqtG
         nybPXv7Fw7hjqFRhr0GKgoSY5XaXJqFmEIJ34O3TGC6cgyujIQHyLKqthxHSfanhOYTt
         uipfqbFjH3Uwq6jmYc2IMgvspo4IIg4bnMb/VW1npEXAtoUxTtQhdLLEsLUsuTRzt7YV
         +f2TsrbKrHKjWydiQ2qRNN38dpcJURfM6GjkRuYUEIEAO6T+cFH6FzR/Nf8oulY4G0ms
         SFvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=Xfcn/JEp26t1nhIyrAR+Tljl/UPuux0azZF2DlwFDh0=;
        b=TafzpKXI2fFZlgvBp/6DU2GvRAcxyDnMNN+iJI1ZtEjhdBP6Tly3d5ej8O00hEo+A0
         lk/03iTaMBYVmlQAhsYFE5LWdrPd7Ryt+zrLIrMrnkH3ywZ5kRxtt+EmXmK25tVqSkT1
         CT/dmfjj+qVWkIGfiaDYtTEF+Nc94EbSIzSOBGHVlDunpJDyR3FwqUBTNNINUkUqjpDS
         gmockUfy+VlIAkWjgLnk/kc7We8o3CZMykM8zuUz04LCW1DVTasFZGE1peeftcaohsF8
         UaCJcvx7G4FkXRFSakPmHHBfxw4E6KdydMyofDxX/8f3wgubdMwpaj4J0XlYkOnyDmj/
         TYyg==
X-Gm-Message-State: APf1xPAjiOkOF6s4MgJG2KewxwC049MgS1mKuzBM2y2Or2osrGwxbNWr
        AXY9YlF5EGjrxPSWG+uvk8HORz6lnK2T9LCUkA6xBfd2nJBKk8Gz+Q4pew22/oTVxZMscf71H5W
        DpwrzEpzQN9XCTN45/E2GYJjjwQ1Kwdlo8MXrhzIxANvx6K454nhqe6goKA==
X-Google-Smtp-Source: AH8x226ofl4kHc0T+YTRtL2xEvG9dPI/OWnBer3nZ0w/sSZWVNPrslI2tDU61JmkDscIK+sdHMxMN9g1Vks=
MIME-Version: 1.0
X-Received: by 10.157.38.8 with SMTP id a8mr2299243otb.87.1517966020922; Tue,
 06 Feb 2018 17:13:40 -0800 (PST)
Date:   Tue,  6 Feb 2018 17:12:48 -0800
In-Reply-To: <20180207011312.189834-1-bmwill@google.com>
Message-Id: <20180207011312.189834-12-bmwill@google.com>
References: <20180125235838.138135-1-bmwill@google.com> <20180207011312.189834-1-bmwill@google.com>
X-Mailer: git-send-email 2.16.0.rc1.238.g530d649a79-goog
Subject: [PATCH v3 11/35] test-pkt-line: introduce a packet-line test helper
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, peff@peff.net, gitster@pobox.com,
        jrnieder@gmail.com, stolee@gmail.com, git@jeffhostetler.com,
        pclouds@gmail.com, Brandon Williams <bmwill@google.com>
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
 t/helper/test-pkt-line.c | 64 ++++++++++++++++++++++++++++++++++++++++++++++++
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
2.16.0.rc1.238.g530d649a79-goog

