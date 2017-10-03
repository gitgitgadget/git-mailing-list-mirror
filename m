Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6633D2036C
	for <e@80x24.org>; Tue,  3 Oct 2017 20:16:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751684AbdJCUQS (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Oct 2017 16:16:18 -0400
Received: from mail-pg0-f54.google.com ([74.125.83.54]:54524 "EHLO
        mail-pg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751441AbdJCUPd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2017 16:15:33 -0400
Received: by mail-pg0-f54.google.com with SMTP id c137so5316783pga.11
        for <git@vger.kernel.org>; Tue, 03 Oct 2017 13:15:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g5gEI0osxon/0/VgD4nahRkw2LseSRF8GbqEQzX/N2w=;
        b=o/W1d7tNPoTNeb1l6sWCvCP+eMJSzSU8vXduri+n2DkxKb9huaS5K/YIVUJ2YnWfuB
         rDCf+OCvSF8ykt8TSxb/ZBP0pSi2b2jS7rrmv3N0dk0Ix7sQUGJsR457iVbfWIVm/gm8
         4khgIVaXL0tpZTBqgbviHisfPPAx2eOIUxC+2tukZeBp3eaEfR5vFh6qxzfUoBSYBWjI
         N56isMpDhXeBVO4rxtS5mq7NBky87Y5+1KwI+BwgGcjmTim8yR2YiUbv5r32RHEYDqGC
         rohdnn/785xT/rB2x/n79m6s64QrOHjxpm6PsHo76dMQDVY9FIrantu9u3Iscn2wz4k3
         5Tkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g5gEI0osxon/0/VgD4nahRkw2LseSRF8GbqEQzX/N2w=;
        b=bYEPbwqYMChOr8vX2yWeBFQfxd6kQzLxujzKOOChv20AOWKmdLFZQbPo+MajYyj+L7
         ixcOl84m5R8psNzlGJZyaF4nwZhzgIpc/LVvs+sOtYRlX3/PSrZZx5FptitvDit4twmb
         AvY0HK+G0AZ4gs0iqf2Qsa8ZXyyrMPo0uTQQTYxvX7EopFv2Rjv6FTXlifw8VsXCAbgE
         lUCla4dnl3QZPPvbzmdVDWEerrh+WuUYHxaEi78C3kqtLcXbQeE6ULh67Tz8n5CGpLmU
         w0XKYc+uMSGEV7LiycrLwKTvSlHlNOwPqYgBZEgs3JJVbZqxH9fsFVLzceAHlv0Qfthy
         e7wQ==
X-Gm-Message-State: AMCzsaVLA0UJUfFq84WhhvKUhNKBciGZ6ierHgrCn5Sndm/BUY2K95mj
        tE+pe8xDq1hLLycubiUXtlDFbg7X9lw=
X-Google-Smtp-Source: AOwi7QBSlzIFxDFC5S7Q5H6Mjk9jvL0Ej/lD7baFsQ8XZscYyhYvuYZM3aG51hwlcny5T0sbsftY+Q==
X-Received: by 10.159.245.143 with SMTP id a15mr13130272pls.93.1507061732872;
        Tue, 03 Oct 2017 13:15:32 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id 184sm3846262pfd.88.2017.10.03.13.15.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 03 Oct 2017 13:15:31 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v3 06/10] connect: teach client to recognize v1 server response
Date:   Tue,  3 Oct 2017 13:15:03 -0700
Message-Id: <20171003201507.3589-7-bmwill@google.com>
X-Mailer: git-send-email 2.14.2.920.gcf0c67979c-goog
In-Reply-To: <20171003201507.3589-1-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach a client to recognize that a server understands protocol v1 by
looking at the first pkt-line the server sends in response.  This is
done by looking for the response "version 1" send by upload-pack or
receive-pack.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 connect.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/connect.c b/connect.c
index 8e2e276b6..a5e708a61 100644
--- a/connect.c
+++ b/connect.c
@@ -12,6 +12,7 @@
 #include "sha1-array.h"
 #include "transport.h"
 #include "strbuf.h"
+#include "protocol.h"
 
 static char *server_capabilities;
 static const char *parse_feature_value(const char *, const char *, int *);
@@ -129,9 +130,23 @@ static int read_remote_ref(int in, char **src_buf, size_t *src_len,
 	return len;
 }
 
-#define EXPECTING_FIRST_REF 0
-#define EXPECTING_REF 1
-#define EXPECTING_SHALLOW 2
+#define EXPECTING_PROTOCOL_VERSION 0
+#define EXPECTING_FIRST_REF 1
+#define EXPECTING_REF 2
+#define EXPECTING_SHALLOW 3
+
+/* Returns 1 if packet_buffer is a protocol version pkt-line, 0 otherwise. */
+static int process_protocol_version(void)
+{
+	switch (determine_protocol_version_client(packet_buffer)) {
+	case protocol_v1:
+		return 1;
+	case protocol_v0:
+		return 0;
+	default:
+		die("server is speaking an unknown protocol");
+	}
+}
 
 static void process_capabilities(int *len)
 {
@@ -224,12 +239,19 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 	 */
 	int responded = 0;
 	int len;
-	int state = EXPECTING_FIRST_REF;
+	int state = EXPECTING_PROTOCOL_VERSION;
 
 	*list = NULL;
 
 	while ((len = read_remote_ref(in, &src_buf, &src_len, &responded))) {
 		switch (state) {
+		case EXPECTING_PROTOCOL_VERSION:
+			if (process_protocol_version()) {
+				state = EXPECTING_FIRST_REF;
+				break;
+			}
+			state = EXPECTING_FIRST_REF;
+			/* fallthrough */
 		case EXPECTING_FIRST_REF:
 			process_capabilities(&len);
 			if (process_dummy_ref()) {
-- 
2.14.2.920.gcf0c67979c-goog

