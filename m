Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F101FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751971AbdFTCtd (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:49:33 -0400
Received: from mail-pg0-f44.google.com ([74.125.83.44]:35022 "EHLO
        mail-pg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751191AbdFTCsm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:42 -0400
Received: by mail-pg0-f44.google.com with SMTP id 132so22941098pgb.2
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h5HHA3yTmtanl4RWOQotqwci+dfSftrO0rKmefw3eOg=;
        b=QvrPXgb3U5JXH1Di6RDAIQfje7Gal4oc8YAc86TWFuUloh+mZYcB62VIVXCFfNOpr+
         DRzQyHxfzdcIXJgI8hdbz0lEEDAy+BG/tGVgqPojl6wdro9TOd/Xb8IhL4qWXEnDbR8U
         Q2dtjJL+CHeJ7HoPbeJcNcdTl6vKqigcPRZlFOcxinX2bgygHfPnI8G+hoygouaVzdfa
         4hDTY0g+tSeDmjwO2NiLvo4lOGeogkeHpc5//xom4Aju5EfuaEyCruv7QbrPbdK66lkb
         xu6Sf7Knoc6HUTSrxvoufpmWZzuRrwITze1m2cY9UEq+Z/tTl2hVHdlo8BulIdxl4bdi
         CFkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h5HHA3yTmtanl4RWOQotqwci+dfSftrO0rKmefw3eOg=;
        b=bMuV6KqcI4r2TySrTafmBlK/8PnAMlZ6KO7zkgPWv9MN2YyeSeciEYxlqj/FBgRmDB
         Cxr0/wtkoNFqLyfS3gn0qtVKtodSZfBIhGY9zf29ToCjIB+m+qRnaLclaP77sdk1Fyqy
         NzyUzITkW+ErzDAPyI8NiMuNkB4FKYB40CHUHmueNePg7sNSkcMDao0ASpMjWoeI0tRw
         PGf4JK//Iwd587kf7n6C98dopGyyZRp3uY25q4bLa1rl5+HXwMlhwi6gUvP5H8Mmp5Bo
         toPlQfmFUIgaaMN0twP4FdI1CMKl+SHBkJAxZRNOm5fe5W319lGCdKgFUHHqvRAGTmg/
         bynQ==
X-Gm-Message-State: AKS2vOzJjnzmz00RANVWzGVj+jmmQ7ems0zHkbtGA6Ybe44Nf9XKXo4q
        uLDRovuX6pb6aKe15CM3RA==
X-Received: by 10.98.7.11 with SMTP id b11mr28802273pfd.188.1497926911267;
        Mon, 19 Jun 2017 19:48:31 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id b3sm22817180pfg.47.2017.06.19.19.48.30
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:30 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 05/26] diff.c: emit_diff_symbol learns DIFF_SYMBOL_CONTEXT_MARKER
Date:   Mon, 19 Jun 2017 19:47:55 -0700
Message-Id: <20170620024816.20021-6-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index 89466018e5..3af07fa659 100644
--- a/diff.c
+++ b/diff.c
@@ -561,17 +561,24 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 
 enum diff_symbol {
 	DIFF_SYMBOL_SEPARATOR,
+	DIFF_SYMBOL_CONTEXT_MARKER,
 };
 
 static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 			     const char *line, int len)
 {
+	const char *context, *reset;
 	switch (s) {
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
 			diff_line_prefix(o),
 			o->line_termination);
 		break;
+	case DIFF_SYMBOL_CONTEXT_MARKER:
+		context = diff_get_color_opt(o, DIFF_CONTEXT);
+		reset = diff_get_color_opt(o, DIFF_RESET);
+		emit_line(o, context, reset, line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
@@ -661,7 +668,8 @@ static void emit_hunk_header(struct emit_callback *ecbdata,
 	if (len < 10 ||
 	    memcmp(line, atat, 2) ||
 	    !(ep = memmem(line + 2, len - 2, atat, 2))) {
-		emit_line(ecbdata->opt, context, reset, line, len);
+		emit_diff_symbol(ecbdata->opt,
+				 DIFF_SYMBOL_CONTEXT_MARKER, line, len);
 		return;
 	}
 	ep += 2; /* skip over @@ */
-- 
2.12.2.575.gb14f27f917

