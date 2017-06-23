Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 99E342082E
	for <e@80x24.org>; Fri, 23 Jun 2017 01:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754071AbdFWB3i (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Jun 2017 21:29:38 -0400
Received: from mail-pg0-f48.google.com ([74.125.83.48]:36462 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753833AbdFWB3g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2017 21:29:36 -0400
Received: by mail-pg0-f48.google.com with SMTP id u62so14977126pgb.3
        for <git@vger.kernel.org>; Thu, 22 Jun 2017 18:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f9Sqp44U0fykBIhB7SqjJi+qi2ncCUw1hnqSA2AC/0Y=;
        b=GIDn9wsOnkPriW72kzn5EQE150BYyuT46/IyXzYbsJPuBUCwVAOR/mGnx0WamXZgJe
         n58dbhb3W4mQ+YdWirbFa9kdS8xZW9bFNzrwG9i6rwP7uYTGyiLaEm48kH/OjbTPLzDg
         LG771CvNG/k2zSpSnCt97ax2RvwZisglthp+kavgCVk5alBEmRjS+BxMWgSOoHfVQ/GJ
         eXaIyVMma3hDhxvAq7ANwoYAluH3ZH3db8jvrStjjvgFyDE4CJk7FGyACLHHjNDu/Oa8
         qnO5hqD6SgBsWHEapLeLZzpTC1GlX2YgpHxNTqYfVETxNycklVuY8zmkTS+hgYCa/xeZ
         N/zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=f9Sqp44U0fykBIhB7SqjJi+qi2ncCUw1hnqSA2AC/0Y=;
        b=pPxnIcsSi7jTbwBWtrujWiYAV8RGrQ+4KBYTim/cHwyOwx6nVDbdv2GvKTZxIeE6YJ
         fJuY1pYH0/wreQJAfmije3RuRtYdup2V6XHULmSycVy/Ogu7gDhLTVNnpr/BdkQxEXKZ
         QV/agL0oaVZbCbe3tn00G+aRRkDriRF0qJk3n99LG2gMEK3YkYQZ+gpevXwsVbnXNy8N
         lmR2PTJ44Gu4hKcjSGuZmHaIpHTKnjgVjmhRteEGZ/Cmh/J7DPtRO7hoC9WwKN0MRELs
         glBEzBU+5u71bBvUTkZWa6sJYtvWU3vdor49QJHQ0MfLICx5r/4OePwhg4NaGjfTrkMZ
         V0Yw==
X-Gm-Message-State: AKS2vOzfGo/VplrBDjOfjkY1M21bkh2BHUUXtwQUuOqN8fuMJ6DDpxkg
        0VCoyRgdcQHvYMN6U6mleg==
X-Received: by 10.99.138.76 with SMTP id y73mr5568414pgd.203.1498181375992;
        Thu, 22 Jun 2017 18:29:35 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:54b:7db6:84cb:995a])
        by smtp.gmail.com with ESMTPSA id z13sm6240628pfk.99.2017.06.22.18.29.35
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 22 Jun 2017 18:29:35 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCHv2 06/25] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_FRAGINFO
Date:   Thu, 22 Jun 2017 18:29:00 -0700
Message-Id: <20170623012919.28693-7-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170623012919.28693-1-sbeller@google.com>
References: <20170620024816.20021-1-sbeller@google.com>
 <20170623012919.28693-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/diff.c b/diff.c
index c550f75195..16818fa571 100644
--- a/diff.c
+++ b/diff.c
@@ -560,6 +560,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 }
 
 enum diff_symbol {
+	DIFF_SYMBOL_CONTEXT_FRAGINFO,
 	DIFF_SYMBOL_CONTEXT_MARKER,
 	DIFF_SYMBOL_SEPARATOR
 };
@@ -569,6 +570,9 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 {
 	const char *context, *reset;
 	switch (s) {
+	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
+		emit_line(o, "", "", line, len);
+		break;
 	case DIFF_SYMBOL_CONTEXT_MARKER:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
@@ -704,8 +708,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 
 	strbuf_add(&msgbuf, line + len, org_len - len);
 	strbuf_complete_line(&msgbuf);
-
-	emit_line(ecbdata->opt, "", "", msgbuf.buf, msgbuf.len);
+	emit_diff_symbol(ecbdata->opt,
+			 DIFF_SYMBOL_CONTEXT_FRAGINFO, msgbuf.buf, msgbuf.len);
 	strbuf_release(&msgbuf);
 }
 
-- 
2.12.2.575.gb14f27f917

