Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E21982023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752891AbdEQC7Z (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:25 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:36788 "EHLO
        mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbdEQC7S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:18 -0400
Received: by mail-pf0-f169.google.com with SMTP id m17so89826147pfg.3
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=POwHsPANOvoDqBoBvCNihEc+XhRCqurZSJnT5uKBwsY=;
        b=qHz9m4I8j1Sz6LSZwi9JRlsstMUNTdBOa+CgsjWwuBROO/OVnmluIdkfTS6QCuSVhQ
         N8qoiWDKOG1Q/c5BYTXR+4msrayBf2cuFoX/mRiLdW0ZwzZ6v+AHcd8qPeQEouTU2HzU
         gYeNZgkzT1NTQxcF8dNVzcyuIkqwZOPEKdBhcGzVQ58z/Fhn3Yfsii4M1Xl751/vQeuD
         9DzILTxmR9Q679qIN+9HwwXyHNs6BtVoJf+f5vAXGVog+Gk/A9ia+CP4FZRlLnYM2bDf
         oHUTcbD1IQ305KFF+riBiTMhZBzjwFaLTs2uhNoPj8Bl3myid+60n1sZc7/BD7eRbPGM
         PYwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=POwHsPANOvoDqBoBvCNihEc+XhRCqurZSJnT5uKBwsY=;
        b=s1qGHIW8Tf2lJYKOWXW+8c4T5hoyEqrp0aRcc19WWKW9PvZoTGw91oWR+M+nk8i2i1
         yGe+NEccQfxIWATuF3bBy3lI5YWTV4vWgqdFIpva+wU0FGjWTBLS7STB0L+RxRqMUkca
         3VeFMRrBAFdSJr+KGRw3//St7yUWunhS6Gn+1VvtFnUTO828nsLlkM5yaOYNkd+Qm1Az
         1H0fvsF+SyEs+Ppy7+LJZjHnwE3F/fG086J8PhUUKqE+Zk7QbBVXIXI6g+DB6jqtaYhp
         NwgLEW2c5K/8NPFqbC5gACEWkdVEdrUUNyzV+nDxmbxxBnKKK9Fox0yvazQjisbJ07PM
         mAYg==
X-Gm-Message-State: AODbwcBJoIH77fr2bNjrYr1O5QDKptItQRwhbLPtjqxTcu+5rIJPK9tZ
        /kj6HuaJrM4GorDs
X-Received: by 10.99.151.9 with SMTP id n9mr1319953pge.199.1494989957490;
        Tue, 16 May 2017 19:59:17 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id w67sm678271pfi.2.2017.05.16.19.59.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:16 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 11/20] diff.c: convert emit_rewrite_lines to use emit_line_*
Date:   Tue, 16 May 2017 19:58:48 -0700
Message-Id: <20170517025857.32320-12-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

This covers emit_rewrite_lines.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 3dda9f3c8e..690794aeb8 100644
--- a/diff.c
+++ b/diff.c
@@ -722,15 +722,25 @@ static void add_line_count(struct strbuf *out, int count)
 static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
-	const char *endp = NULL;
-	static const char *nneof = " No newline at end of file\n";
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
+	struct strbuf sb = STRBUF_INIT;
 
 	while (0 < size) {
 		int len;
 
-		endp = memchr(data, '\n', size);
-		len = endp ? (endp - data + 1) : size;
+		const char *endp = memchr(data, '\n', size);
+		if (endp)
+			len = endp - data + 1;
+		else {
+			while (0 < size) {
+				strbuf_addch(&sb, *data);
+				size -= len;
+				data += len;
+			}
+			strbuf_addch(&sb, '\n');
+			data = sb.buf;
+			len = sb.len;
+		}
 		if (prefix != '+') {
 			ecb->lno_in_preimage++;
 			emit_del_line(reset, ecb, data, len);
@@ -741,12 +751,13 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
+	if (sb.len) {
+		static const char *nneof = "\\ No newline at end of file\n";
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
-		emit_line(ecb->opt, context, reset, 1, '\\',
-			  nneof, strlen(nneof));
+		emit_line(ecb->opt, context, reset, 1, 0,
+			    nneof, strlen(nneof));
+		strbuf_release(&sb);
 	}
 }
 
-- 
2.13.0.18.g7d86cc8ba0

