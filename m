Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3EE7E201CF
	for <e@80x24.org>; Thu, 18 May 2017 19:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932420AbdERTjC (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 May 2017 15:39:02 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35092 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754540AbdERTiC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 May 2017 15:38:02 -0400
Received: by mail-pg0-f44.google.com with SMTP id q125so27305699pgq.2
        for <git@vger.kernel.org>; Thu, 18 May 2017 12:38:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=1VYl0LKCXZhD4cm8kVbfUD9vWfWZb6QMdTIExNHn0+A=;
        b=l6pb48uQKHgztrT9YDPhOkDgp7uE73C7OwAAaD5aKAMB7XZPcapDytvTIvECd970do
         mgdDlQFd5fMnbNGAtjNSL6MVZbMJQLjgiK8Qxhtm+N4MhQ2GDTdW1N+KbzqTzFinLJ02
         s+LHhsbMlGpdrXnAEdYQ859S2x9VhL+sqMJoFc/xkRc8pl6dmggUdSt/c4jqFDJ7qZ85
         qX31852CnmAdfQdnXiXn6+ZaEK4UpehEV5FjTKTb2Ueu8yvI1F3gUgYPDtE7KtZQwpcN
         63v4zJfflKLIZ331qoITQKiWZE5c3oRk75fwE3u89AclX/AR9O3D3MFKAKqppCpcnXjU
         edGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=1VYl0LKCXZhD4cm8kVbfUD9vWfWZb6QMdTIExNHn0+A=;
        b=pwULPSyffWW1t5wT6STCQZRgMsQ3c8q57pNCxXstPhB1RNSSNRZF3Un7K6mqUUro9N
         z9RmzuAAU5zpfAupqPmjautMGcTcD0MfdKLGftVzNHSJ5BI7lvgk22swhFXuQN0E1X79
         5dQJLZcFiI5Eg4Ks1cklDbSnKhAW5QL/G7cBYeQbgrFv8d6HxJbr5XMj2cAMtJG6d1Np
         QwICgKFePtvAghGIq4hlxMexU5KsT+ymBxexMgwZZejP5xgPRlY69/IdMetDHtwj/9t2
         H6rPhaUOf3vTIuGYw+KFXFblHeNK56cmDDnSlr2WNFS/2RrsAx4sTzAhTckANB9u725E
         iX+g==
X-Gm-Message-State: AODbwcBpn49WJRW6px1a3hs9hpkBFfo6JOmUukWwzPr9SOXmFH7wsrKC
        vX52XAVMt65SC50J4b/Q+g==
X-Received: by 10.84.160.197 with SMTP id v5mr6825896plg.30.1495136282005;
        Thu, 18 May 2017 12:38:02 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:7013:588c:5765:703d])
        by smtp.gmail.com with ESMTPSA id 204sm5614254pfu.19.2017.05.18.12.38.01
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 18 May 2017 12:38:01 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net
Subject: [PATCHv3 06/20] diff.c: emit_line_0 takes parameter whether to output line prefix
Date:   Thu, 18 May 2017 12:37:32 -0700
Message-Id: <20170518193746.486-7-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170518193746.486-1-sbeller@google.com>
References: <20170517025857.32320-1-sbeller@google.com>
 <20170518193746.486-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In later patches we'll make extensive use of emit_line_0, as we'd want
to funnel all output through this function such that we can add buffering
there.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index 6c1886d495..25735f03d2 100644
--- a/diff.c
+++ b/diff.c
@@ -517,12 +517,13 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o, const char *set, const char *reset,
-			int sign, const char *line, int len)
+			int add_line_prefix, int sign, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	FILE *file = o->file;
 
-	fputs(diff_line_prefix(o), file);
+	if (add_line_prefix)
+		fputs(diff_line_prefix(o), file);
 
 	has_trailing_newline = (len > 0 && line[len-1] == '\n');
 	if (has_trailing_newline)
@@ -549,7 +550,7 @@ static void emit_line_0(struct diff_options *o, const char *set, const char *res
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, reset, 0, line, len);
+	emit_line_0(o, set, reset, 1, 0, line, len);
 }
 
 static int new_blank_line_at_eof(struct emit_callback *ecbdata, const char *line, int len)
@@ -580,13 +581,13 @@ static void emit_line_checked(const char *reset,
 	}
 
 	if (!ws)
-		emit_line_0(ecbdata->opt, set, reset, sign, line, len);
+		emit_line_0(ecbdata->opt, set, reset, 1, sign, line, len);
 	else if (sign == '+' && new_blank_line_at_eof(ecbdata, line, len))
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(ecbdata->opt, ws, reset, sign, line, len);
+		emit_line_0(ecbdata->opt, ws, reset, 1, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(ecbdata->opt, set, reset, sign, "", 0);
+		emit_line_0(ecbdata->opt, set, reset, 1, sign, "", 0);
 		ws_check_emit(line, len, ecbdata->ws_rule,
 			      ecbdata->opt->file, set, reset, ws);
 	}
@@ -735,7 +736,7 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 		const char *context = diff_get_color(ecb->color_diff,
 						     DIFF_CONTEXT);
 		putc('\n', ecb->opt->file);
-		emit_line_0(ecb->opt, context, reset, '\\',
+		emit_line_0(ecb->opt, context, reset, 1, '\\',
 			    nneof, strlen(nneof));
 	}
 }
-- 
2.13.0.18.g7d86cc8ba0

