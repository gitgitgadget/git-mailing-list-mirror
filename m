Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 857EC1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 23:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751589AbcIGXg4 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 19:36:56 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:34998 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbcIGXgz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 19:36:55 -0400
Received: by mail-pa0-f50.google.com with SMTP id b2so10824408pat.2
        for <git@vger.kernel.org>; Wed, 07 Sep 2016 16:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=KkTzRe+3r8GRPJghsblHMYbSaWWplHsncj/gMzRS91M=;
        b=RAfPG9J+oboD2lx6O0xqvTAX8kmSespOn3JiFyALA2I/sYX5FA2EMK53lpxG+ZEZs/
         fq2WE39VJfSDyYgPgmMq3n8xgq9jFjFcMUp5hmmqjZnD6lEgnadiBHGSW54DofypE9uG
         AaH8TiUiDl8GB2mnFUBwO8FmpdYRwVeWN1Kf1nmVxi2y1tcCPRb5bZeDUbXfyz1uEwKL
         sYrdLBHua0W5Bfv4zr/19++Y1wdmuNCpDwLyYAEJuV7HCl+20h5SwhzkeM90PQY5T0jN
         I1JmNyy+G+8/+cBB6m7XLXpvz0ztACvOf483W0xV9ZbuOWEoJHN6lyb8E7g4ngKHsWXm
         o4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=KkTzRe+3r8GRPJghsblHMYbSaWWplHsncj/gMzRS91M=;
        b=jwynVrGgMuvxlQDGRreibJ+tfdUG29b0CTxRWHqAgdpRRUgOjxg/kT5CoYHaGwMZSf
         kGoo3fxP8k43zDwaj3ZZ41Vthe3EE8J2YGj/yIhu4nFiI6X6H1f3V4H0kwz0Luqu/x7X
         Gp6Ce8PBw5UIcNZHa1a9vEC3p5kWhkws8pFSbnqhPyYA+eCyAySBm7o74Gar9z1Uakp9
         xRiR11rKqmojX2J21CQPCZ23u8OteyvjkoF5tP0GBav/refrl1bkI30cSlaHuZiHk1sq
         OUOqeVdIfAnYo2nxn9yXyokzJF3UR4mX0HKpKoIltecWGFir8vGbOBzrsZwBYcyooDKv
         ixgQ==
X-Gm-Message-State: AE9vXwOpyau3lvqC2Ph8C64Jlg6hvCC5+ElZpig1+qVsZplI6H3w00G0TbwBxnwjjrH0dsaQ
X-Received: by 10.66.25.8 with SMTP id y8mr86483801paf.64.1473291413857;
        Wed, 07 Sep 2016 16:36:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f111:face:c1e2:bcdc])
        by smtp.gmail.com with ESMTPSA id l74sm23306267pfi.95.2016.09.07.16.36.53
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 07 Sep 2016 16:36:53 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 1/3] diff.c: use diff_options directly
Date:   Wed,  7 Sep 2016 16:36:44 -0700
Message-Id: <20160907233648.5162-2-sbeller@google.com>
X-Mailer: git-send-email 2.10.0.2.g0676c79.dirty
In-Reply-To: <20160907233648.5162-1-sbeller@google.com>
References: <20160907233648.5162-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The value of `ecbdata->opt` is accessible via the short variable `o`
already, so let's use that instead.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/diff.c b/diff.c
index 534c12e..4a6501c 100644
--- a/diff.c
+++ b/diff.c
@@ -1217,7 +1217,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	const char *line_prefix = diff_line_prefix(o);
 
 	if (ecbdata->header) {
-		fprintf(ecbdata->opt->file, "%s", ecbdata->header->buf);
+		fprintf(o->file, "%s", ecbdata->header->buf);
 		strbuf_reset(ecbdata->header);
 		ecbdata->header = NULL;
 	}
@@ -1229,9 +1229,9 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		name_a_tab = strchr(ecbdata->label_path[0], ' ') ? "\t" : "";
 		name_b_tab = strchr(ecbdata->label_path[1], ' ') ? "\t" : "";
 
-		fprintf(ecbdata->opt->file, "%s%s--- %s%s%s\n",
+		fprintf(o->file, "%s%s--- %s%s%s\n",
 			line_prefix, meta, ecbdata->label_path[0], reset, name_a_tab);
-		fprintf(ecbdata->opt->file, "%s%s+++ %s%s%s\n",
+		fprintf(o->file, "%s%s+++ %s%s%s\n",
 			line_prefix, meta, ecbdata->label_path[1], reset, name_b_tab);
 		ecbdata->label_path[0] = ecbdata->label_path[1] = NULL;
 	}
@@ -1249,15 +1249,15 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		find_lno(line, ecbdata);
 		emit_hunk_header(ecbdata, line, len);
 		if (line[len-1] != '\n')
-			putc('\n', ecbdata->opt->file);
+			putc('\n', o->file);
 		return;
 	}
 
 	if (len < 1) {
-		emit_line(ecbdata->opt, reset, reset, line, len);
+		emit_line(o, reset, reset, line, len);
 		if (ecbdata->diff_words
 		    && ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN)
-			fputs("~\n", ecbdata->opt->file);
+			fputs("~\n", o->file);
 		return;
 	}
 
@@ -1282,8 +1282,8 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 		}
 		diff_words_flush(ecbdata);
 		if (ecbdata->diff_words->type == DIFF_WORDS_PORCELAIN) {
-			emit_line(ecbdata->opt, context, reset, line, len);
-			fputs("~\n", ecbdata->opt->file);
+			emit_line(o, context, reset, line, len);
+			fputs("~\n", o->file);
 		} else {
 			/*
 			 * Skip the prefix character, if any.  With
@@ -1294,7 +1294,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 			      line++;
 			      len--;
 			}
-			emit_line(ecbdata->opt, context, reset, line, len);
+			emit_line(o, context, reset, line, len);
 		}
 		return;
 	}
@@ -1316,8 +1316,7 @@ static void fn_out_consume(void *priv, char *line, unsigned long len)
 	default:
 		/* incomplete line at the end */
 		ecbdata->lno_in_preimage++;
-		emit_line(ecbdata->opt,
-			  diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
+		emit_line(o, diff_get_color(ecbdata->color_diff, DIFF_CONTEXT),
 			  reset, line, len);
 		break;
 	}
-- 
2.10.0.2.g0676c79.dirty

