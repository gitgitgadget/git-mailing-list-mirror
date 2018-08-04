Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A961208E9
	for <e@80x24.org>; Sat,  4 Aug 2018 01:53:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732206AbeHDDwY (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 23:52:24 -0400
Received: from mail-ua0-f202.google.com ([209.85.217.202]:51985 "EHLO
        mail-ua0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732190AbeHDDwY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 23:52:24 -0400
Received: by mail-ua0-f202.google.com with SMTP id m26-v6so3909656uaq.18
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 18:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=919mwTY2O7vfZxgAkX5fbh7aesm6Y5AAjBYt7GcEcXo=;
        b=q3NBLzURlIOUDd1UDifP39jmQmS1BZUP37dgPBns/NGl2m+dy0T5AUnwRHZCTIj62m
         ivf8SzupNga7ULrx2TgJEn4qDX/fuZTCtjM7MlbTjpGXlP6CX75uSklgcVsC+BQ/pmNw
         ptagS9rwAkq5+o9BNp4r6MwG6wP3HY2mUoVnuTTKYspvs6Q1FsbpPVd7gaUKIlXkmc+d
         kQQ24ghMVLNgsZO6Ii/Di/x448b1OBlAms3V/WApfPyhNfCmXR870ja0ma5ymMKEP1ut
         C1DkfCFL3yv7A6+SiBpiQYF4UYsAOuPdHv6ETIrCct9Nh1hg3MfGf9Dmxus2/dc30fwA
         l4kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=919mwTY2O7vfZxgAkX5fbh7aesm6Y5AAjBYt7GcEcXo=;
        b=e876kvmCwT9vqivRg9nPyVmZSSP/5dta7SIjJhF6UzTMK3N8Ak1sm+gL18Y9F7dj7G
         7RgNMj7/fDHItJcVzKvVKuD/tUZ8WHcASWwi41Q+Sx8oBAlJ8F3yRm8bbHg9X4w9dOLb
         Ecu4TiyhUbETzTa3ht/pEwl4pXDH702pF/uf+WyBx/L9YtQkXLmAncvE2gy/rZndR3mt
         TFTrQIbcB+weRu5S8W25EY/0ErnmNojoGEFcakl5zRTip/axdq/+tcU+gVZHDN/tMlbW
         Vidyz0wOJVCNGYKsnl1khbxcvx4aO/cW3Es8heUjYDmGzA5JzbvK2U1ipZgJLtPvNvYL
         CwBA==
X-Gm-Message-State: AOUpUlFwSipaoghKbbt6ctV9/pccb0iPKkjWL5qxCtoFp2uMtsNWUN/m
        wjbd3HuyuFV5o5ON2M5lnhTjjLYvdUzZnuU8SeWfzVxfwHIF44x6USSk6GXJlljJfIwZnHQQ6SA
        dR05iPxRgUIdOdjgHEC8z1fq7VmnOqrSAHzIvUaj4zTDaaw/9nxNn1lhzunM7
X-Google-Smtp-Source: AAOMgpcWhoIPFOOLb2qXAuuxHjEh+mglCRCqFZ+jlgvt4MrSX337lWGrbJ992aayo0pzjypC5I8bb+sN0mui
X-Received: by 2002:a9f:3aca:: with SMTP id q10-v6mr4586845uag.31.1533347615918;
 Fri, 03 Aug 2018 18:53:35 -0700 (PDT)
Date:   Fri,  3 Aug 2018 18:53:16 -0700
In-Reply-To: <20180804015317.182683-1-sbeller@google.com>
Message-Id: <20180804015317.182683-7-sbeller@google.com>
Mime-Version: 1.0
References: <20180804015317.182683-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.597.ga71716f1ad-goog
Subject: [PATCH 6/7] diff.c: factor determine_line_color out of emit_diff_symbol_from_struct
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Factoring out code that determines color for both the new and old code
even saves some lines, though minuscule. However we introduce an offset
computation in the color array.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 88 +++++++++++++++++++++++++++++-----------------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/diff.c b/diff.c
index d3829c7d086..56bab011df7 100644
--- a/diff.c
+++ b/diff.c
@@ -1028,6 +1028,48 @@ static void emit_line_ws_markup(struct diff_options *o,
 	}
 }
 
+static const char *determine_line_color(struct diff_options *o,
+					struct emitted_diff_symbol *eds)
+{
+	const char *set;
+	unsigned flags = eds->flags;
+
+	/*
+	 * To have these offsets work, we need to keep
+	 * DIFF_FILE_OLD_MOVED{_ALT, _ALT_DIM, DIM, _}
+	 * in the same order as their _NEW_ equivalents; we do not need
+	 * to care about DIFF_FILE_{NEW, OLD} and their relations to others.
+	 */
+	const int off = (eds->s == DIFF_SYMBOL_PLUS) ?
+		DIFF_FILE_NEW_MOVED - DIFF_FILE_OLD_MOVED : 0;
+
+	switch (flags & (DIFF_SYMBOL_MOVED_LINE |
+			 DIFF_SYMBOL_MOVED_LINE_ALT |
+			 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
+	case DIFF_SYMBOL_MOVED_LINE |
+	     DIFF_SYMBOL_MOVED_LINE_ALT |
+	     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
+		set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT_DIM + off);
+		break;
+	case DIFF_SYMBOL_MOVED_LINE |
+	     DIFF_SYMBOL_MOVED_LINE_ALT:
+		set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT + off);
+		break;
+	case DIFF_SYMBOL_MOVED_LINE |
+	     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
+		set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_DIM + off);
+		break;
+	case DIFF_SYMBOL_MOVED_LINE:
+		set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED + off);
+		break;
+	default:
+		set = (eds->s == DIFF_SYMBOL_PLUS) ?
+			diff_get_color_opt(o, DIFF_FILE_NEW):
+			diff_get_color_opt(o, DIFF_FILE_OLD);
+	}
+	return set;
+}
+
 static void emit_diff_symbol_from_struct(struct diff_options *o,
 					 struct emitted_diff_symbol *eds)
 {
@@ -1089,28 +1131,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				    flags & (DIFF_SYMBOL_CONTENT_WS_MASK), 0);
 		break;
 	case DIFF_SYMBOL_PLUS:
-		switch (flags & (DIFF_SYMBOL_MOVED_LINE |
-				 DIFF_SYMBOL_MOVED_LINE_ALT |
-				 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
-		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ALT |
-		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
-			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_ALT_DIM);
-			break;
-		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ALT:
-			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_ALT);
-			break;
-		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
-			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED_DIM);
-			break;
-		case DIFF_SYMBOL_MOVED_LINE:
-			set = diff_get_color_opt(o, DIFF_FILE_NEW_MOVED);
-			break;
-		default:
-			set = diff_get_color_opt(o, DIFF_FILE_NEW);
-		}
+		set = determine_line_color(o, eds);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		if (!o->flags.dual_color_diffed_diffs)
 			set_sign = NULL;
@@ -1136,28 +1157,7 @@ static void emit_diff_symbol_from_struct(struct diff_options *o,
 				    flags & DIFF_SYMBOL_CONTENT_BLANK_LINE_EOF);
 		break;
 	case DIFF_SYMBOL_MINUS:
-		switch (flags & (DIFF_SYMBOL_MOVED_LINE |
-				 DIFF_SYMBOL_MOVED_LINE_ALT |
-				 DIFF_SYMBOL_MOVED_LINE_UNINTERESTING)) {
-		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ALT |
-		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
-			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT_DIM);
-			break;
-		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_ALT:
-			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_ALT);
-			break;
-		case DIFF_SYMBOL_MOVED_LINE |
-		     DIFF_SYMBOL_MOVED_LINE_UNINTERESTING:
-			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED_DIM);
-			break;
-		case DIFF_SYMBOL_MOVED_LINE:
-			set = diff_get_color_opt(o, DIFF_FILE_OLD_MOVED);
-			break;
-		default:
-			set = diff_get_color_opt(o, DIFF_FILE_OLD);
-		}
+		set = determine_line_color(o, eds);
 		reset = diff_get_color_opt(o, DIFF_RESET);
 		if (!o->flags.dual_color_diffed_diffs)
 			set_sign = NULL;
-- 
2.18.0.597.ga71716f1ad-goog

