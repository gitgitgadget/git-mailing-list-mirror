Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A701A1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 23:06:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729997AbeGPXfl (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:35:41 -0400
Received: from mail-yb0-f202.google.com ([209.85.213.202]:43486 "EHLO
        mail-yb0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbeGPXfl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:35:41 -0400
Received: by mail-yb0-f202.google.com with SMTP id a14-v6so33736193ybl.10
        for <git@vger.kernel.org>; Mon, 16 Jul 2018 16:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=StW8LVomGoV/FGT+QgkqQvXJuoojLUwIreL+kEzJR4E=;
        b=nV6CuDq1IMlxOuSwIM49rwC1tKfBDqudgq3jXvSVnwr61BNWLtLJQIiQVeSdKhjH8p
         ZRHZ4IUqw9W6B205ydu+bPBNQQb+KsDkq1UfkAkwihKcmafwAi++mB/5eCm09thLZhAI
         cw4O0pvtFJKd01ENytEGC+lT5wOB4yNZHDiPr3uGAhuDa78bLTw4mi3jN2lCaFv5s1n3
         LrbUoqG1YOo/5AdJAQF4Bqakd/OvKYZytGctQw0Ak/jGdaRc8WCTbjyXtb7slkjW/Fa4
         a0RCLTYHB3azEBqmZyDZv7b6Lh9D7K529r6QhGjI/FiD54oCEyRDEf1jnBAiFzd5QapV
         JywQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=StW8LVomGoV/FGT+QgkqQvXJuoojLUwIreL+kEzJR4E=;
        b=A3mURwFzJxwuUciHjcwDKTOyP1a2HrFNs/NBuUifyzTjOM+MTd9UJviC7h4i28K6zh
         wJGQSK9/x6he83Akp8hY9FXsk22pZhYuDOLJJsuhlblZbBKxhD2zsS0XkB5+gVbnSFmI
         8k9lH2dngCwg0SayJo09RGjHXRSjUDlvrfqLXs3h3xqcjv8aVw0R6zT4baVOtcZAS2DL
         GDGb8wa8n7tmDlhH4HdWONwOsSvPB7IvFtDpDDDFfCopwW1aBgWCShodTiVN8pGrDFnZ
         AMC7BvlCKJbKl9kaFRzM7Bq2G2gkjTpVFlF29hxZOfYVIFHMUdnl9OgvfQLZ03iVuKEE
         JnVw==
X-Gm-Message-State: AOUpUlG5s0Qkp+BfV8uuoZnE+U7mWxwKaGxPQVSP392sROjKK0dniWlB
        kZUWk1zXUK2od/bQY1ixk7J4rvVSww7PX8HIoVgXa+EToIrVrKpfgnAV0DR8V1S39guH9IYl70x
        a81ni0GrUY5TjSIi9hS/hcO9t99x4dwaj8yMCx+ulNPoFGxQPSkC5QIZAJv8C
X-Google-Smtp-Source: AAOMgpcZevJsHbyKe+xDUqxpVBA2IwITIzrRno6o89u+PxhR8sBhO7aB0Sl6SJqZ6TIU6uoSAzjnU6knLm10
MIME-Version: 1.0
X-Received: by 2002:a25:bec8:: with SMTP id k8-v6mr6087402ybm.18.1531782366113;
 Mon, 16 Jul 2018 16:06:06 -0700 (PDT)
Date:   Mon, 16 Jul 2018 16:05:41 -0700
In-Reply-To: <20180716230542.81372-1-sbeller@google.com>
Message-Id: <20180716230542.81372-9-sbeller@google.com>
References: <20180716230542.81372-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 8/9] diff.c: factor advance_or_nullify out of mark_color_as_moved
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This moves the part of code that checks if we're still in a block
into its own function.  We'll need a different approach on advancing
the blocks in a later patch, so having it as a separate function will
prove useful.

While at it rename the variable `p` to `prev` to indicate that it refers
to the previous line. This is as pmb[i] was assigned in the last iteration
of the outmost for loop.

Further rename `pnext` to `cur` to indicate that this should match up with
the current line of the outmost for loop.

Also replace the advancement of pmb[i] to reuse `cur` instead of
using `p->next` (which is how the name for pnext could be explained.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 70eeb40c5fd..4963819e530 100644
--- a/diff.c
+++ b/diff.c
@@ -801,6 +801,25 @@ static void add_lines_to_move_detection(struct diff_options *o,
 	}
 }
 
+static void pmb_advance_or_null(struct diff_options *o,
+				struct moved_entry *match,
+				struct hashmap *hm,
+				struct moved_entry **pmb,
+				int pmb_nr)
+{
+	int i;
+	for (i = 0; i < pmb_nr; i++) {
+		struct moved_entry *prev = pmb[i];
+		struct moved_entry *cur = (prev && prev->next_line) ?
+				prev->next_line : NULL;
+		if (cur && !hm->cmpfn(o, cur, match, NULL)) {
+			pmb[i] = cur;
+		} else {
+			pmb[i] = NULL;
+		}
+	}
+}
+
 static int shrink_potential_moved_blocks(struct moved_entry **pmb,
 					 int pmb_nr)
 {
@@ -875,7 +894,6 @@ static void mark_color_as_moved(struct diff_options *o,
 		struct moved_entry *key;
 		struct moved_entry *match = NULL;
 		struct emitted_diff_symbol *l = &o->emitted_symbols->buf[n];
-		int i;
 
 		switch (l->s) {
 		case DIFF_SYMBOL_PLUS:
@@ -906,17 +924,7 @@ static void mark_color_as_moved(struct diff_options *o,
 		if (o->color_moved == COLOR_MOVED_PLAIN)
 			continue;
 
-		/* Check any potential block runs, advance each or nullify */
-		for (i = 0; i < pmb_nr; i++) {
-			struct moved_entry *p = pmb[i];
-			struct moved_entry *pnext = (p && p->next_line) ?
-					p->next_line : NULL;
-			if (pnext && !hm->cmpfn(o, pnext, match, NULL)) {
-				pmb[i] = p->next_line;
-			} else {
-				pmb[i] = NULL;
-			}
-		}
+		pmb_advance_or_null(o, match, hm, pmb, pmb_nr);
 
 		pmb_nr = shrink_potential_moved_blocks(pmb, pmb_nr);
 
-- 
2.18.0.203.gfac676dfb9-goog

