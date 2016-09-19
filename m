Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D98CA207DF
	for <e@80x24.org>; Mon, 19 Sep 2016 21:09:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbcISVJJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Sep 2016 17:09:09 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:33094 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752315AbcISVJH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2016 17:09:07 -0400
Received: by mail-pf0-f180.google.com with SMTP id 21so43928929pfy.0
        for <git@vger.kernel.org>; Mon, 19 Sep 2016 14:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=kbEtZJlISeum4XXCTjuKiF195pmvM6RmwmwoQCv0XUo=;
        b=QHmxpwnrsivOPJwnCEA4n6Srvxlailx4/fhVnilafmyOcwEtp9KflYixaKx5BjLQr6
         gq3eiLZ+T0/f4X1ibR0/gzNv3Q9tG19g8/VXOOHXPhNjFZGoKbXTY8aLZVw670GRlgT3
         zT3P71dYQkV8XqDWabkSixDVVjn99obh6s0k1R7U7iAfPOwEREwe7K8ElmDjkFXIk0Pe
         VQXcXhAlqMFt4uwkrpC2s5fJN3Fxr/9u3xH30Z12ncqHjwJTQIX9fxKzWO7eaucplGRG
         vSFs0T4r6S8L7fx67+VSZ9lB5F/hqzaFOzWN5vgsRsfbpi6O3m0lhTkh1Hut/CP5P+1m
         rpNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=kbEtZJlISeum4XXCTjuKiF195pmvM6RmwmwoQCv0XUo=;
        b=RoLiHOahS0WqBa8HU1oPJNZ8HVzx/BjA5eZMIcnH9cWH0530qWOfv2giyHvuxW5Cl1
         tLYG2q/Wi3N4xUaLXIouVYeSjIT1RbfeGjzREeLnDBDhsL53KFNGIQAiWtP7afnLKt1d
         sutwCRjZ2Fe9+F2yAhX5gtzk+BbRIOaEAlgpCmiGwkPGMNw7crZcNU6Gw0mbF7ilnqhx
         XIB5oSqvNazDtJo6Uxd9GPq9NHFSXsDjBd3Fwxo1CgaXTccsy+f5jrJfJNGZGopM1ayx
         NFup6iijn02uYTxRHvNgzgmpkjpqu7iaa6QGsw+wH40XsaFc+tkI+CSYgqJvJi4q1bww
         aSJA==
X-Gm-Message-State: AE9vXwOqXl7Q7DZpz8IBoxEbgqYuQllLPtrnt+/xHsUb0Zg2YmS5tCEunBIodUOJtUgxCGd+
X-Received: by 10.98.205.66 with SMTP id o63mr49678146pfg.37.1474319346538;
        Mon, 19 Sep 2016 14:09:06 -0700 (PDT)
Received: from twelve2.mtv.corp.google.com ([100.96.238.21])
        by smtp.gmail.com with ESMTPSA id q14sm54484171pfg.63.2016.09.19.14.09.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Sep 2016 14:09:05 -0700 (PDT)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com,
        peff@peff.net
Subject: [PATCH v2 2/4] mailinfo: refactor to support utf8 decode attempts
Date:   Mon, 19 Sep 2016 14:08:51 -0700
Message-Id: <e882f6395d1079037843e6e5b632c0010e1f4cdf.1474319086.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.10.0.rc2.20.g5b18e70
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
In-Reply-To: <cover.1474319086.git.jonathantanmy@google.com>
References: <cover.1474319086.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

mailinfo.c currently has a convert_to_utf8 function that overrides its
argument and prints an error message when the decoding fails. Refactor
it, creating another function that does not override anything and does
not print an error message when the decoding fails. This is to be used
by a subsequent patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 mailinfo.c | 42 +++++++++++++++++++++++++++++++++---------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/mailinfo.c b/mailinfo.c
index 0c4738a..aadad09 100644
--- a/mailinfo.c
+++ b/mailinfo.c
@@ -340,23 +340,47 @@ static struct strbuf *decode_b_segment(const struct strbuf *b_seg)
 	return out;
 }
 
+/*
+ * Attempts to convert line into UTF-8.
+ *
+ * This differs from convert_to_utf8 in that no inputs are overridden, and that
+ * conversion non-success is not considered an error case - mi->input_error is
+ * not set, and no error message is printed.
+ *
+ * If the conversion is unnecessary, returns 1 and stores NULL in result.
+ *
+ * If the conversion is successful, returns 1 and stores the converted string
+ * in result.
+ *
+ * If the conversion is unsuccessful, returns 0 and stores NULL in result.
+ */
+static int try_convert_to_utf8(const struct mailinfo *mi, const char *line,
+			       const char *charset, char **result)
+{
+	if (!mi->metainfo_charset || !charset || !*charset ||
+	    same_encoding(mi->metainfo_charset, charset)) {
+		*result = NULL;
+		return 1;
+	}
+
+	*result = reencode_string(line, mi->metainfo_charset, charset);
+	return !!*result;
+}
+
+/*
+ * Converts line into UTF-8, setting mi->input_error to -1 upon failure.
+ */
 static int convert_to_utf8(struct mailinfo *mi,
 			   struct strbuf *line, const char *charset)
 {
 	char *out;
-
-	if (!mi->metainfo_charset || !charset || !*charset)
-		return 0;
-
-	if (same_encoding(mi->metainfo_charset, charset))
-		return 0;
-	out = reencode_string(line->buf, mi->metainfo_charset, charset);
-	if (!out) {
+	if (!try_convert_to_utf8(mi, line->buf, charset, &out)) {
 		mi->input_error = -1;
 		return error("cannot convert from %s to %s",
 			     charset, mi->metainfo_charset);
 	}
-	strbuf_attach(line, out, strlen(out), strlen(out));
+	if (out)
+		strbuf_attach(line, out, strlen(out), strlen(out));
 	return 0;
 }
 
-- 
2.10.0.rc2.20.g5b18e70

