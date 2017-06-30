Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5396A202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752484AbdF3AHj (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:07:39 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:34294 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752107AbdF3AHh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:37 -0400
Received: by mail-pg0-f49.google.com with SMTP id t186so55415608pgb.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jj5x3EumxnRYZC+c4Z8UVT7eT5zlcupbZZXmx/kSec8=;
        b=wTX/o3SVQdPNdSHbrUyj56fRKSkI6Wj3UVKrcmmOmYi26UBU721rrz9X7Gwo6AQvXM
         3Aw9qQhqva/CvkzTJQ6MnebYiTKnRlTi04O8RO2DRBU84tfmjK4DolFCfwsvKXBhme+D
         4HarY8I89/S0jalrUx3Rt5NNquMo+Y1/44xBM68Vj5nJ7PqwMbZQaDK2eGXXghpiok57
         OY3lsvIHxmEjfNvsLeUZa1Q8tV7mgnostATqznR+6bu0Tq8OUSJ/DQ7P3QkcvbceHGM/
         0KVv9Y31zVhj9zOlE2poc/TNW0ohW3Txd+8Fe+SGjmQLzu3eOf/3rtc3NbbXl0w5Wx+t
         La3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jj5x3EumxnRYZC+c4Z8UVT7eT5zlcupbZZXmx/kSec8=;
        b=dvnphpri1YHp17wM7bz+T2wN3B+WH0ud4YXDyNPyw/svNbqBsdPB3LZPcn+Qs98HK8
         wyR9ZgjaGY0JQZRjvFsHRZIq83hnUi0mOEdXYyeMQbJ11YkktXiOyMgXESYTBcOaMaf8
         fs5wq0uZTTGMmgWc3m1m+pToa89JvdQ25GGnqPJ1/EEUxh46Ryzxx1OynbuHoy8lfrON
         OLg6FLdOYEgp78PYy+U4e4S2NjG/9k9dimEoYrCsyVEhzpkDLT9ub6kNaR2YHPjkMQ+2
         Ft1nkT1N2dG0aXP5sz2cO3pgvRI+DkVCGrDoJNe7p0rJKoymMHtaBp20yj0s+QBKpNU6
         TFIQ==
X-Gm-Message-State: AKS2vOyNLVyio/CS40b93snqMJU33WwgZim5yL2XCYoHNflGp8pQr0zD
        alCE2Kbbf8R8M4GG
X-Received: by 10.84.254.11 with SMTP id b11mr20981263plm.209.1498781251298;
        Thu, 29 Jun 2017 17:07:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id a187sm10330991pgc.37.2017.06.29.17.07.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 06/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
Date:   Thu, 29 Jun 2017 17:06:51 -0700
Message-Id: <20170630000710.10601-7-sbeller@google.com>
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
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index 75b996c4cf..6e48a129ed 100644
--- a/diff.c
+++ b/diff.c
@@ -561,6 +561,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
@@ -570,6 +571,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 {
 	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
+		emit_line(o, "", "", line, len);
+		break;
 	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -705,8 +709,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
-
-	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	emit_diff_symbol(ecbdata->opt,
+			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
-- 
2.13.0.31.g9b732c453e

