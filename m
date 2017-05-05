Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6D98207FF
	for <e@80x24.org>; Fri,  5 May 2017 14:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753241AbdEEO5a (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 10:57:30 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34640 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752607AbdEEO51 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 10:57:27 -0400
Received: by mail-wm0-f68.google.com with SMTP id z129so1856127wmb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 07:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ymYHqOPgixc3HhFK+okwUS4ymhhkumLKFsNwNOvPZLk=;
        b=T+e1tSUzWUfM5sWy/Nn4kGyAaUeFRLao1l0crgtj0ksasLusU2Xko6+QtCbf81Lv3/
         cvgpV9OiWrvEzH0YCyHH2cemCmTA2bXKRl+S4Y/sOdjd992/WiFmPfX2DYwu81pcGDlh
         aN1YBugzAKP8yca8CLffsd4e7Jk863sxC4p1LnnwJDbQcBdMFMuB3zXBPAwolPlru8hP
         QwYe8c6aH42b8tXhaGjdH+cmfZL32lk1bLk1V0zwlfuPtLmAcZbX6XxomlW3m2Owxxqv
         hbgF1u48lC+AQAfGSh8cGSHIZTMkWF/C1bm40fqy0zs9z3NMz9hxuxEoidY9+sMGzRb8
         yq6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ymYHqOPgixc3HhFK+okwUS4ymhhkumLKFsNwNOvPZLk=;
        b=Alhf+AdItUmEZSTCsiy+1VNfThTCtHm7IXfCrLJg97y50hU1Cx8mOCePI6+C2YHxLc
         QD5zTvstDyjEWHB3EY/L/Xe6WKHSuXea4KXcKkJ8Mh/J8FMqw7GmvebC2WnOrBdUPK/S
         uv5/nkYigwT+DArYsaOUO1GFIh9IG6alfsO153h7oO7Ju7ufS8OP1LOD4Ba8cwLvja+F
         WA3hzPOa8yG/MV2eH2yBeE74eGmx0BScktMzGXZRvUQHCdOzmXp7UKo/N5n4accchjCh
         rnpA79Z/eK8sqW2q5DZGlCrDeIJp8Jdm5YqcVkBEn9EcbAaiS2Z/D1v7zLWAtZu0Huka
         BZAQ==
X-Gm-Message-State: AN3rC/54TUT2xapA9FV94VB4WD5+8dBBcDqhZPRJUC5fN8hfPJLIv1Oo
        YEy92Si3VCHEkQ==
X-Received: by 10.28.37.71 with SMTP id l68mr5920250wml.108.1493996245175;
        Fri, 05 May 2017 07:57:25 -0700 (PDT)
Received: from christian-Latitude-E6330.booking.pcln.com ([185.24.142.26])
        by smtp.gmail.com with ESMTPSA id k4sm1994431wmf.12.2017.05.05.07.57.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 May 2017 07:57:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Cc:     Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>
Subject: [PATCH 1/2] split-index: add and use unshare_split_index()
Date:   Fri,  5 May 2017 16:57:12 +0200
Message-Id: <20170505145713.8837-2-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.13.0.rc1.83.g83955d3ecd.dirty
In-Reply-To: <20170505145713.8837-1-chriscool@tuxfamily.org>
References: <20170505145713.8837-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>

When split-index is being used, we have two cache_entry arrays in
index_state->cache[] and index_state->split_index->base->cache[].

index_state->cache[] may share the same entries with base->cache[] so
we can quickly determine what entries are shared. This makes memory
management tricky, we can't free base->cache[] until we know
index_state->cache[] does not point to any of those entries.

unshare_split_index() is added for this purpose, to find shared
entries and either duplicate them in index_state->cache[], or discard
them. Either way it should be safe to free base->cache[] after
unshare_split_index().

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 read-cache.c  | 10 ++--------
 split-index.c | 57 ++++++++++++++++++++++++++++++++++++++++++++-------------
 split-index.h |  1 +
 3 files changed, 47 insertions(+), 21 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 0d0081a11b..8da84ae2d1 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1877,15 +1877,9 @@ int discard_index(struct index_state *istate)
 {
 	int i;
 
-	for (i = 0; i < istate->cache_nr; i++) {
-		if (istate->cache[i]->index &&
-		    istate->split_index &&
-		    istate->split_index->base &&
-		    istate->cache[i]->index <= istate->split_index->base->cache_nr &&
-		    istate->cache[i] == istate->split_index->base->cache[istate->cache[i]->index - 1])
-			continue;
+	unshare_split_index(istate, 1);
+	for (i = 0; i < istate->cache_nr; i++)
 		free(istate->cache[i]);
-	}
 	resolve_undo_clear_index(istate);
 	istate->cache_nr = 0;
 	istate->cache_changed = 0;
diff --git a/split-index.c b/split-index.c
index f519e60f87..49bd197f71 100644
--- a/split-index.c
+++ b/split-index.c
@@ -73,10 +73,17 @@ void move_cache_to_base_index(struct index_state *istate)
 	int i;
 
 	/*
-	 * do not delete old si->base, its index entries may be shared
-	 * with istate->cache[]. Accept a bit of leaking here because
-	 * this code is only used by short-lived update-index.
+	 * If "si" is shared with another index_state (e.g. by
+	 * unpack-trees code), we will need to duplicate split_index
+	 * struct. It's not happening now though, luckily.
 	 */
+	assert(si->refcount <= 1);
+
+	unshare_split_index(istate, 0);
+	if (si->base) {
+		discard_index(si->base);
+		free(si->base);
+	}
 	si->base = xcalloc(1, sizeof(*si->base));
 	si->base->version = istate->version;
 	/* zero timestamp disables racy test in ce_write_index() */
@@ -275,11 +282,41 @@ void finish_writing_split_index(struct index_state *istate)
 	istate->cache_nr = si->saved_cache_nr;
 }
 
+void unshare_split_index(struct index_state *istate, int discard)
+{
+	struct split_index *si = istate->split_index;
+	int i;
+
+	if (!si || !si->base)
+		return;
+
+	for (i = 0; i < istate->cache_nr; i++) {
+		struct cache_entry *ce = istate->cache[i];
+		struct cache_entry *new = NULL;
+
+		if (!ce->index ||
+		    ce->index > si->base->cache_nr ||
+		    ce != si->base->cache[ce->index - 1])
+			continue;
+
+		if (!discard) {
+			int len = ce_namelen(ce);
+			new = xcalloc(1, cache_entry_size(len));
+			copy_cache_entry(new, ce);
+			memcpy(new->name, ce->name, len);
+			new->index = 0;
+		}
+		istate->cache[i] = new;
+	}
+}
+
+
 void discard_split_index(struct index_state *istate)
 {
 	struct split_index *si = istate->split_index;
 	if (!si)
 		return;
+	unshare_split_index(istate, 0);
 	istate->split_index = NULL;
 	si->refcount--;
 	if (si->refcount)
@@ -328,14 +365,8 @@ void add_split_index(struct index_state *istate)
 
 void remove_split_index(struct index_state *istate)
 {
-	if (istate->split_index) {
-		/*
-		 * can't discard_split_index(&the_index); because that
-		 * will destroy split_index->base->cache[], which may
-		 * be shared with the_index.cache[]. So yeah we're
-		 * leaking a bit here.
-		 */
-		istate->split_index = NULL;
-		istate->cache_changed |= SOMETHING_CHANGED;
-	}
+	if (!istate->split_index)
+		return;
+	discard_split_index(istate);
+	istate->cache_changed |= SOMETHING_CHANGED;
 }
diff --git a/split-index.h b/split-index.h
index df91c1bda8..65c0f09b2b 100644
--- a/split-index.h
+++ b/split-index.h
@@ -33,5 +33,6 @@ void finish_writing_split_index(struct index_state *istate);
 void discard_split_index(struct index_state *istate);
 void add_split_index(struct index_state *istate);
 void remove_split_index(struct index_state *istate);
+void unshare_split_index(struct index_state *istate, int discard);
 
 #endif
-- 
2.13.0.rc1.83.g83955d3ecd.dirty

