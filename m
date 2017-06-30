Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3F1D9202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdF3AHr (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:47 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35639 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751710AbdF3AHi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:38 -0400
Received: by mail-pf0-f173.google.com with SMTP id c73so58094934pfk.2
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=gIoTZtAiyZKiIQ5V8CTyOrTgFbsDn7OEWnz1ZDQkBbg=;
        b=NmH9wotEY0eK59aO22hei4e82N+13u0R8ju/ihyafyl/tWX45nN3/k6Ots1sZxgqoy
         AYCC/jYtYBJk4XqW8yYXzpQww3AqfvE+P0xAXt0e/tCJLm8pz3qlpOAXhJ9GRM2hQGo5
         nagval4aiiEpocSDGQyrpUoDrJOg11RLRvOyaouGA+J8Qr4wz38T4uW+joeFGrXoouQu
         oJHkhzoEB6n4d42bxNJtyv+0atZ8N/2CDbGywQxKiAs8JL4TFY5MOoiLRda3enM4iktd
         w7e7eKiuNftI/k8kl+omRlN8hR+rO21524ibFoCJhXuwuL7zHE5uQZPuvVTQivW25Et4
         Y0EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=gIoTZtAiyZKiIQ5V8CTyOrTgFbsDn7OEWnz1ZDQkBbg=;
        b=myF61i7zJ4kW0E/IABQQaaq67xX8BcVy8vzSVWPz/YQrrjCc7hQZVT1p/GIj4A5+Wz
         nYzewTwwinXlv5WbEwYyUAsy1X5tL5vBLhXRzS8SIHi4+Cr5AZmJjUxMbtLPBvYpifKE
         guHHe8fbWFCnlptooeMCW1wok/zjDDvfN3XOuT6dTtHDO8VBcv+hUHNM6F46ivfwdjsf
         Ti2W5ASFWyyp+0WeWXgFZa981dFzWqyCd5x0Oy9OARlpAolh9NuFO8LzsgdT1/FQBt4y
         OGtep8oGJzJrcET8LoAjGhyl2/BA//f6RhYof4T0nH7cff8gS5oluAUbMoVaa/O+3IFv
         bzeg==
X-Gm-Message-State: AKS2vOz+mde2oES3P8PiwPrz3OirZV5XnFwDjKdRipku9Pz2dAU8TI2q
        TDNtz29NL6/JOG5IKHMWYQ==
X-Received: by 10.98.34.152 with SMTP id p24mr19393760pfj.158.1498781252476;
        Thu, 29 Jun 2017 17:07:32 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id h123sm10786007pgc.36.2017.06.29.17.07.31
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:31 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 07/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_NO_LF_EOF
Date:   Thu, 29 Jun 2017 17:06:52 -0700
Message-Id: <20170630000710.10601-8-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/diff.c b/diff.c
index 6e48a129ed..488096b757 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_NO_LF_EOF,
 	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
@@ -569,8 +570,16 @@ enum diff_symbol {
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_NO_LF_EOF:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		putc('\n', o->file);
+		emit_line_0(o, context, reset, '\\',
+			    nneof, strlen(nneof));
+		break;
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
 		break;
@@ -751,7 +760,6 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 			       int prefix, const char *data, int size)
 {
 	const char *endp = NULL;
-	static const char *nneof = " No newline at end of file\n";
 	const char *reset = diff_get_color(ecb->color_diff, DIFF_RESET);
 
 	while (0 < size) {
@@ -769,13 +777,8 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		size -= len;
 		data += len;
 	}
-	if (!endp) {
-		const char *context = diff_get_color(ecb->color_diff,
-						     DIFF_CONTEXT);
-		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, '\\',
-			    nneof, strlen(nneof));
-	}
+	if (!endp)
+		emit_diff_symbol(ecb->opt, DIFF_SYMBOL_NO_LF_EOF, NULL, 0);
 }
 
 static void emit_rewrite_diff(const char *name_a,
-- 
2.13.0.31.g9b732c453e

