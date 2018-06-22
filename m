Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AEFE1F516
	for <e@80x24.org>; Fri, 22 Jun 2018 01:58:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934314AbeFVB54 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Jun 2018 21:57:56 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:54500 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934292AbeFVB5y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jun 2018 21:57:54 -0400
Received: by mail-vk0-f73.google.com with SMTP id h1-v6so2046405vke.21
        for <git@vger.kernel.org>; Thu, 21 Jun 2018 18:57:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=TN/Fjhh5jtvrOeP6+5iQnVlf+LrEfDadRyl5to9HG/U=;
        b=T62FtWsAyCYwaN1sA8oH6aAv8xIVgJ+6uf4I2WLO40BXRsE8BlDnjrxk/r37f2cOFj
         eM3Pz4Os5rVOkW1Mxycyl1o+K6KLlQRZRO5HI6Gf5wlh+0/rcuaCij+n8g5xTpYGj5Sy
         kQpRpBo5/MYsA2lkd0UYaF3WGZfl2+rqkd5G1MOvkof3N+ow+f0/JLN+efSQ3TWfNG1X
         vx4JVfNe90wyUcUvwYlr3NG/dU/Myfi5yElq6g5aM3nDgS3/DP+8Azs6zsBjt4Jam5Pt
         +IijkGqi1KHvis/bUIVRw6/LCb6gTFLGR0IDnOcQQlB27VDyaHYZ3XLR1t4P0iDkotAC
         uSjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=TN/Fjhh5jtvrOeP6+5iQnVlf+LrEfDadRyl5to9HG/U=;
        b=ezv9NeXh5ek3SP14zoqZl3FURf2aRmGez1+8KXm2epIoqSkb1dsSnxb7D2eM+0mTLw
         jFPfVCAKrjQRYcxmUXIoN6A3uYLJbXVMjxA8dhcpKykqgWjrM6jfCqYt92zaUjwkzSMp
         pNJQG+FEcA1Ppywe5yG2lVM+LAcDzBF2orPqt6YCRkK+EZkiNXg5JVC8mWo08EDgnHjG
         4v/uiED+BVSgjDYxKzdf1+8537O7gZccGDCCk81cXFUhPul/KEFPnwj3Da5ExXRB7ppR
         VEAr+TGxYv6waS87Aqaumqm+3rPnDwDPRWsM1xd9WnzutKZtgYAyOTe8r/Y+wAKeFkw3
         X+1w==
X-Gm-Message-State: APt69E2MQnCwfcwAw5HZ+WRTNVlVQ502m+Mp7hOrXI0FksjPEV8U832k
        05bSdWCDilabVEN/ZhRru2Y6Gyc4WZsc
X-Google-Smtp-Source: ADUXVKIVqXeCgzFijgFMSLGX97GAq3gR8mBLOaRDlcUTbS1oMXjgg9s9n86YGqAyEauAHePHNb3Y1nyZvGs8
MIME-Version: 1.0
X-Received: by 2002:a9f:21b4:: with SMTP id 49-v6mr12076401uac.16.1529632673923;
 Thu, 21 Jun 2018 18:57:53 -0700 (PDT)
Date:   Thu, 21 Jun 2018 18:57:24 -0700
In-Reply-To: <20180622015725.219575-1-sbeller@google.com>
Message-Id: <20180622015725.219575-8-sbeller@google.com>
References: <20180622015725.219575-1-sbeller@google.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: [PATCH v3 7/8] diff.c: factor advance_or_nullify out of mark_color_as_moved
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     git@vger.kernel.org, jacob.keller@gmail.com,
        jonathantanmy@google.com, simon@ruderich.org
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
---
 diff.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/diff.c b/diff.c
index 6c523bafddf..040b46545e5 100644
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
2.18.0.rc2.346.g013aa6912e-goog

