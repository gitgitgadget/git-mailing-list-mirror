Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 990D71F597
	for <e@80x24.org>; Sat, 28 Jul 2018 03:05:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbeG1E3z (ORCPT <rfc822;e@80x24.org>);
        Sat, 28 Jul 2018 00:29:55 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:40502 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbeG1E3y (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 28 Jul 2018 00:29:54 -0400
Received: by mail-ua0-f202.google.com with SMTP id y3-v6so2169763uao.7
        for <git@vger.kernel.org>; Fri, 27 Jul 2018 20:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uVmyIBQ/xVGXHNcqJOMgAf6Qvb9gTYAtSr5irHmYzhw=;
        b=pIG8LEnwgXMbpJSH3b5MAMydZzfM87jfuYwjwK8P1bUfueRAwsd/piaB2TF3saX4aQ
         E9nnAA45d0SkpV9C4txOUjxPo/3gq61w2XD/6mTO+1bwWcKPMNMm6iPXU32vBPJPjlcr
         VpVn7I3mo8/nYIF90fP2Z1uidRZv6LyXpszOCqctS81qqDxicpEHE8DzMi/eZsRBlIV1
         ATZgKHBCy01235Z7mKozjPBLaLn++ShHa7yiXJb2lR8nmhSR3WDqXm6S5AOJwlz8T8d8
         E6lOCMp530wWGrOKDMD9Tjf+ZAjDOty2aSwRLnVVn6jVKeNBCR6IB60EcSRN9poGbTFE
         0Oaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uVmyIBQ/xVGXHNcqJOMgAf6Qvb9gTYAtSr5irHmYzhw=;
        b=uL3GM3bIBO+5+Oira7sp+ZUFS+zcGbOSq/vVseKoDqkZj/24GwZmrJn2sBS1h8QyUx
         rD819y2RB47sHIaTUw1HiNZ2RNo7fKhQGalKe2QoKh5dIbg6Idu3wmEkYjWH1TTNJpeZ
         3t/NrnBZ5QUFz/QN2pvcb+sUiITwxI1OLiKK60I3dZ1S7YTip+7TVvtP3/qhjDYI9spu
         s87gkHz6iSanI5gDb/yJ+HS6uJB1f1lMuLKusbwB88mJd+SJbW1OsFiQ2QzCkuvcVtBq
         67dII3MbeUzxRJpRSm4paxNGVFhJu+8lwSE/MLEEFuCoicqGZkFdhrPrQSWnEW7BxB4f
         zRNg==
X-Gm-Message-State: AOUpUlEMeMxwm8xSkkYhspdjuGl9gWbFNkHDmWxYk2W6/1eu2jpS/BoQ
        08SDWM7sap4hqqzstgO4XwPXrYhE8sFO87CHtfvEFsRkPgeO/VjXc1yUc0K3OCtlGvSlO8xH/D8
        RliQsu9Y6w9TENG0EfldLqnoDLCgwSWmoxSmgTYNs/miJQ8lPKwH5eCd4n74+
X-Google-Smtp-Source: AAOMgpf0qyj+2uIXdHzbiiZM36aNTb+gATdQSv4dmSpdSM/F46V4/XsOT9P+R3MDbJ4N8WyyfIeoPVi3pyb2
X-Received: by 2002:a1f:aa8f:: with SMTP id t137-v6mr4183217vke.106.1532747109098;
 Fri, 27 Jul 2018 20:05:09 -0700 (PDT)
Date:   Fri, 27 Jul 2018 20:04:47 -0700
In-Reply-To: <20180728030448.192177-1-sbeller@google.com>
Message-Id: <20180728030448.192177-8-sbeller@google.com>
Mime-Version: 1.0
References: <20180728030448.192177-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3-goog
Subject: [PATCH 7/8] diff.c: compute reverse locally in emit_line_0
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/diff.c b/diff.c
index fdad7ffdd77..f565a2c0c2b 100644
--- a/diff.c
+++ b/diff.c
@@ -576,11 +576,12 @@ static void check_blank_at_eof(mmfile_t *mf1, mmfile_t *mf2,
 }
 
 static void emit_line_0(struct diff_options *o,
-			const char *set_sign, const char *set, unsigned reverse, const char *reset,
+			const char *set_sign, const char *set, const char *reset,
 			int first, const char *line, int len)
 {
 	int has_trailing_newline, has_trailing_carriage_return;
 	int nofirst;
+	int reverse = !!set && !!set_sign;
 	FILE *file = o->file;
 
 	fputs(diff_line_prefix(o), file);
@@ -625,7 +626,7 @@ static void emit_line_0(struct diff_options *o,
 static void emit_line(struct diff_options *o, const char *set, const char *reset,
 		      const char *line, int len)
 {
-	emit_line_0(o, set, NULL, 0, reset, line[0], line+1, len-1);
+	emit_line_0(o, set, NULL, reset, line[0], line+1, len-1);
 }
 
 enum diff_symbol {
@@ -998,15 +999,15 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 
 	if (!ws && !set_sign)
-		emit_line_0(o, set, NULL, 0, reset, sign, line, len);
+		emit_line_0(o, set, NULL, reset, sign, line, len);
 	else if (!ws) {
-		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, line, len);
+		emit_line_0(o, set_sign, set, reset, sign, line, len);
 	} else if (blank_at_eof)
 		/* Blank line at EOF - paint '+' as well */
-		emit_line_0(o, ws, NULL, 0, reset, sign, line, len);
+		emit_line_0(o, ws, NULL, reset, sign, line, len);
 	else {
 		/* Emit just the prefix, then the rest. */
-		emit_line_0(o, set_sign, set, !!set_sign, reset, sign, "", 0);
+		emit_line_0(o, set_sign, set, reset, sign, "", 0);
 		ws_check_emit(line, len, ws_rule,
 			      o->file, set, reset, ws);
 	}
@@ -1029,7 +1030,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		putc('\n', o->file);
-		emit_line_0(o, context, NULL, 0, reset, '\\',
+		emit_line_0(o, context, NULL, reset, '\\',
 			    nneof, strlen(nneof));
 		break;
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
-- 
2.18.0.345.g5c9ce644c3-goog

