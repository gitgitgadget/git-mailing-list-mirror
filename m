Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B97B2207DF
	for <e@80x24.org>; Tue, 13 Sep 2016 04:46:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752098AbcIMEqX (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 00:46:23 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:35999 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751135AbcIMEqU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 00:46:20 -0400
Received: by mail-pf0-f180.google.com with SMTP id 128so59452868pfb.3
        for <git@vger.kernel.org>; Mon, 12 Sep 2016 21:46:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Spmr6C0rHCmcrGr21yThPLjenC88PKRPuwsg2/pQUlA=;
        b=WIeOJT8VmYBHTtZREYcNRp/SLhbEgLY3mlhHo3V71zLetFX0wvHVDNVn6zKIlojlGi
         TAjGCXQsML80mIEvYQ4OnR/KXRSdz7men5wZiugk4Q/5o9vvAGQH6IaLD+Bqnla35XeL
         TfhMuoGiNAwKDwYvWnNynsgSmBJ/RYgynckcUS4PWGIgTf1V07O6SOqoZ0a8Wvt8MT5i
         +fCBavg3OtJ7fNTcOG1oGhwYxxwjI86Cny2tyQPqhLEl6kz0o6GgIm8wjX4OgbYEpjnU
         30v3/+OCqr8xEHv3MIY5OUT9UusI9cxI/v8OLDjOnOtoBzqU772+1lADE+o2gEOHPFP4
         HXwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Spmr6C0rHCmcrGr21yThPLjenC88PKRPuwsg2/pQUlA=;
        b=Zsydus+Yh+eSVbEI2BhOghB+m0JH2sMAy5sGXOYaCQO8YK+QWbBJXYK8ExCwhdc6pA
         p2sCyO3ktrgHl9WKQ8afyBO640xGO007HQxy60BiEyF6WW7QBR2Y2mQ5KEim2twulEXQ
         uVi1NA5UPubLHIT+9zsK2yXnI9HIALbXOkYVzwJ1G4LLxzss/rb6psb6uyNDQ0OzX/D5
         HTEoev6LgabllBxnBYFn9ZqF/rYf2ieJkXAm8mXEl/g+OtsI4dcbpqIXys+RGI5Cp5L8
         haJ1M32QbOPHBmGrPuQk3XkjlVqw8LXmSHl29eMwwklBQ6lVqBEl4ng26g5/q2iw8r5a
         UlJQ==
X-Gm-Message-State: AE9vXwOCLJslHVo/PrpFpk+DyYBU7n6BoWlWtjrRJ1pfP7V6kZcfAT5jU+7ijULc7wyGdxJc
X-Received: by 10.98.102.17 with SMTP id a17mr40076625pfc.65.1473741980015;
        Mon, 12 Sep 2016 21:46:20 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:ddae:e087:e1a2:ba54])
        by smtp.gmail.com with ESMTPSA id g90sm27782057pfe.96.2016.09.12.21.46.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Sep 2016 21:46:19 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, peff@peff.net, chriscool@tuxfamily.org
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [RFC/PATCH 02/17] diff: emit_{add, del, context}_line to increase {pre,post}image line count
Date:   Mon, 12 Sep 2016 21:45:58 -0700
Message-Id: <20160913044613.1037-3-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.21.g1da280f.dirty
In-Reply-To: <20160913044613.1037-1-sbeller@google.com>
References: <20160913044613.1037-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

At all call sites of emit_{add, del, context}_line we increment the line
count, so move it into the respective functions to make the code at the
calling site a bit clearer.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/diff.c b/diff.c
index aa50b2d..156c2aa 100644
--- a/diff.c
+++ b/diff.c
@@ -536,6 +536,7 @@ static void emit_add_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	ecbdata->lno_in_postimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_FILE_NEW, WSEH_NEW, '+');
 }
@@ -544,6 +545,7 @@ static void emit_del_line(const char *reset,
 			  struct emit_callback *ecbdata,
 			  const char *line, int len)
 {
+	ecbdata->lno_in_preimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_FILE_OLD, WSEH_OLD, '-');
 }
@@ -552,6 +554,8 @@ static void emit_context_line(const char *reset,
 			      struct emit_callback *ecbdata,
 			      const char *line, int len)
 {
+	ecbdata->lno_in_postimage++;
+	ecbdata->lno_in_preimage++;
 	emit_line_checked(reset, ecbdata, line, len,
 			  DIFF_CONTEXT, WSEH_CONTEXT, ' ');
 }
@@ -662,13 +666,10 @@ static void emit_rewrite_lines(struct emit_callback *ecb,
 
 		endp = memchr(data, '\n', size);
 		len = endp ? (endp - data + 1) : size;
-		if (prefix != '+') {
-			ecb->lno_in_preimage++;
+		if (prefix != '+')
 			emit_del_line(reset, ecb, data, len);
-		} else {
-			ecb->lno_in_postimage++;
+		else
 			emit_add_line(reset, ecb, data, len);
-		}
 		size -= len;
 		data += len;
 	}
@@ -1293,16 +1294,12 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 
 	switch (line[0]) {
 	case '+':
-		ecbdata->lno_in_postimage++;
 		emit_add_line(reset, ecbdata, line + 1, len - 1);
 		break;
 	case '-':
-		ecbdata->lno_in_preimage++;
 		emit_del_line(reset, ecbdata, line + 1, len - 1);
 		break;
 	case ' ':
-		ecbdata->lno_in_postimage++;
-		ecbdata->lno_in_preimage++;
 		emit_context_line(reset, ecbdata, line + 1, len - 1);
 		break;
 	default:
-- 
2.10.0.21.g1da280f.dirty

