Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A38D520281
	for <e@80x24.org>; Tue, 26 Sep 2017 23:57:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032787AbdIZX47 (ORCPT <rfc822;e@80x24.org>);
        Tue, 26 Sep 2017 19:56:59 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:44032 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032779AbdIZX44 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 Sep 2017 19:56:56 -0400
Received: by mail-pg0-f48.google.com with SMTP id j16so6782035pga.1
        for <git@vger.kernel.org>; Tue, 26 Sep 2017 16:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=RjmdUG4bpuMmOKrXLu28Dqd6JBQ3k851F30/eZa5EbU=;
        b=mixMweah+wdhuRnFLlI7Zlxk2o2AeQVTafdXgYl0/pOGtWkH+6VXFVuLuMQcaiclMU
         DkJmZuWyZ6FIWbkq4bOzs4pJoUaS0yKeUhz02HQeipHHQf0QZibXq5GEOFfeLVF0c3Cp
         kA8mUdVPbusF6MrsXnPySlueJR239ax0dZFGK5DNsucQ4NktLbz+BGakI9Y2+M4U0wky
         nX2aWkSoGs6EnBEvVCsFIEM5Ise1EOlKFd8tFKVEB+fyPkpuAtiCyS9t/dbqh+SJ68sI
         fRTK0NidwJVmmbBqillxohwDJwf0KnSchIDXqpM2c+rAQiZXhA93MEL/N6ctuEq7HWXt
         vpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=RjmdUG4bpuMmOKrXLu28Dqd6JBQ3k851F30/eZa5EbU=;
        b=ozQxO7xd1eEP2c754KHEfLQl5ImoaPhiaRynoUcxJrvxSyum2UVI/zaNwzcgy/YuNC
         e5VdX3UQqcd2UwhlbfSlI17zV+5CTE8SWDLJfWG9S1tNbd0GuOaoPqbQHl+sLQiLaegH
         UBenqnwiGmx+FJg1E5cmq/kUOc+Gzl6WHYcWN+jmO9K+PXwkYiPTkBReBn/pUgZQEdTO
         CeD4exmoOs+3nO2PBLV/yqC7PfxFcnVWBwfmZWcR4zsbFIXHMwB5i7pUawv+oHCuG8wK
         PiGGfnmUf1DwTPaxLtQjgKE5jKOCkSZLR3M/J0TD4xc0ZESBXHTXvCalyE7lAu8dsmpI
         4doA==
X-Gm-Message-State: AHPjjUidtl4trmOLq/5cTdVS3msKtuFKnxdCBFSJhBhaKsJU2ZmkBgTN
        bPlEVlJ6+SMqn4Cn/PZBwa9nv7Xw5cw=
X-Google-Smtp-Source: AOwi7QBVGW4qq7nWSA3t39Vx9VmvWfDv6aQqAzZ0idEbHga9Pp8Y0wQUYet5mVHKXnvXu0r9vUT5qA==
X-Received: by 10.84.131.67 with SMTP id 61mr12076951pld.418.1506470215500;
        Tue, 26 Sep 2017 16:56:55 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id j2sm18071699pgn.26.2017.09.26.16.56.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 26 Sep 2017 16:56:54 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     bturner@atlassian.com, git@jeffhostetler.com, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 6/9] connect: teach client to recognize v1 server response
Date:   Tue, 26 Sep 2017 16:56:24 -0700
Message-Id: <20170926235627.79606-7-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.992.g2c7b836f3a-goog
In-Reply-To: <20170926235627.79606-1-bmwill@google.com>
References: <20170913215448.84674-1-bmwill@google.com>
 <20170926235627.79606-1-bmwill@google.com>
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
index 8e2e276b6..1805debf3 100644
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
+		case protocol_v1:
+			return 1;
+		case protocol_v0:
+			return 0;
+		default:
+			die("server is speaking an unknown protocol");
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
2.14.1.992.g2c7b836f3a-goog

