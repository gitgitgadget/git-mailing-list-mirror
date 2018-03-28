Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FCCF1F404
	for <e@80x24.org>; Wed, 28 Mar 2018 13:09:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753098AbeC1NJw (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Mar 2018 09:09:52 -0400
Received: from siwi.pair.com ([209.68.5.199]:32947 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752447AbeC1NJw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Mar 2018 09:09:52 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 37D233F4054;
        Wed, 28 Mar 2018 09:09:51 -0400 (EDT)
Received: from jeffhost-ubuntu.reddog.microsoft.com (unknown [65.55.188.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 6879F3F4045;
        Wed, 28 Mar 2018 09:09:50 -0400 (EDT)
From:   git@jeffhostetler.com
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, peff@peff.net, wink@saville.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: [PATCH v6] json-writer: fixups for V5
Date:   Wed, 28 Mar 2018 13:09:40 +0000
Message-Id: <20180328130940.44223-1-git@jeffhostetler.com>
X-Mailer: git-send-email 2.9.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff Hostetler <jeffhost@microsoft.com>

Please squash this onto the top of jh/json-writer.

Fix leading whitespace in t0019 using tricked suggested by Junio.
Fix unnecessary cast for intmax_t suggested by Wink.

Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
---
 json-writer.c          |  4 ++--
 t/t0019-json-writer.sh | 36 ++++++++++++++++++------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/json-writer.c b/json-writer.c
index 1b49158..dbfcf70 100644
--- a/json-writer.c
+++ b/json-writer.c
@@ -165,7 +165,7 @@ void jw_object_string(struct json_writer *jw, const char *key, const char *value
 void jw_object_intmax(struct json_writer *jw, const char *key, intmax_t value)
 {
 	object_common(jw, key);
-	strbuf_addf(&jw->json, "%"PRIdMAX, (intmax_t)value);
+	strbuf_addf(&jw->json, "%"PRIdMAX, value);
 }
 
 void jw_object_double(struct json_writer *jw, const char *key, int precision,
@@ -303,7 +303,7 @@ void jw_array_string(struct json_writer *jw, const char *value)
 void jw_array_intmax(struct json_writer *jw, intmax_t value)
 {
 	array_common(jw);
-	strbuf_addf(&jw->json, "%"PRIdMAX, (intmax_t)value);
+	strbuf_addf(&jw->json, "%"PRIdMAX, value);
 }
 
 void jw_array_double(struct json_writer *jw, int precision, double value)
diff --git a/t/t0019-json-writer.sh b/t/t0019-json-writer.sh
index a04c055..bd6d474 100755
--- a/t/t0019-json-writer.sh
+++ b/t/t0019-json-writer.sh
@@ -166,24 +166,24 @@ test_expect_success 'nested inline object and array 2' '
 '
 
 test_expect_success 'pretty nested inline object and array 2' '
-	cat >expect <<EOF &&
-{
-  "a": "abc",
-  "b": 42,
-  "sub1": {
-    "c": 3.14,
-    "d": true,
-    "sub2": [
-      false,
-      {
-        "g": 0,
-        "h": 1
-      },
-      null
-    ]
-  }
-}
-EOF
+	sed -e "s/^|//" >expect <<-\EOF &&
+	|{
+	|  "a": "abc",
+	|  "b": 42,
+	|  "sub1": {
+	|    "c": 3.14,
+	|    "d": true,
+	|    "sub2": [
+	|      false,
+	|      {
+	|        "g": 0,
+	|        "h": 1
+	|      },
+	|      null
+	|    ]
+	|  }
+	|}
+	EOF
 	test-json-writer >actual \
 		--pretty \
 		@object \
-- 
2.9.3

