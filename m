Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7EFA6200E0
	for <e@80x24.org>; Mon, 26 Dec 2016 10:22:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755396AbcLZKWn (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Dec 2016 05:22:43 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35715 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754877AbcLZKWh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Dec 2016 05:22:37 -0500
Received: by mail-wm0-f68.google.com with SMTP id l2so26995074wml.2
        for <git@vger.kernel.org>; Mon, 26 Dec 2016 02:22:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HPU9zpJ02f+3yAsQ6+22thJTdIhyPLgRbMHAt2a4LSo=;
        b=dRkY/Zg+EAFLEVlCaI3RUf4LSokXrdGlFBhs7Lg0KTRBsKrl/E8ITod25Mmmi2tsaq
         AXu8w3vN/ByPJ3avh1So1eLnsCHP5G2G4XBuMG3sRezxcbO7WwTXcmJOSzVvstP5Uii3
         vmTfP0Q/qyleg0V99/jAG1ejXExd+RNZnmZaXaSQ4TFQ4fw8uuPAz/xq2NZ9NYzqYj8u
         426Trupm9fCJtS3aBP2uhrHY/bmatZP2L5Q27yCq3STwCxO060iR9x+CDS4I5ckvIk6T
         yCeXsfl4qtRortuNQ5JPTM389JvH8JCCCpKH9woYNvau9JHKwUaOlkqKQbbq0eokTZ7M
         KYRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HPU9zpJ02f+3yAsQ6+22thJTdIhyPLgRbMHAt2a4LSo=;
        b=caSTVDVUi9bOQordzs3hDiKGJZTwqzeGli8vQ72xrAadnx+nR62RzsUbyWQCSlQAcj
         PJuUdHLPyW/gtbcKmHK8RY2LZT99KZbI4/K2ja2+y8GtozmxAbAKHkThW5DvkkU+9Lf3
         6HnKFyksqFzis/IPQl0tTEYL1ZAexJ23PJvK2Ci8BeLMyWng1kD9sBqKxwTNLZywAWqG
         0nojnk+1z6A1aWaGCCReVjm7JI50rRX8lzE5grSlnsG+ioz00BcqtNTJ8sFH0/rusqI0
         RhQFs+pF2zDkN+fb0gXenqM6SopSR62dH9CDTVNeU0TrP1o6VxuFysIAHTHATEY+O8SX
         8/Zg==
X-Gm-Message-State: AIkVDXJF/mCEAQqNRuzRmQTJgGWFUSmn+LHSx1O8QlNPLRCYgSTRkcWg1xulBllhpGJ/sg==
X-Received: by 10.28.6.203 with SMTP id 194mr22137773wmg.16.1482747756152;
        Mon, 26 Dec 2016 02:22:36 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id kp5sm54259010wjb.8.2016.12.26.02.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 26 Dec 2016 02:22:35 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 03/21] split-index: add {add,remove}_split_index() functions
Date:   Mon, 26 Dec 2016 11:22:04 +0100
Message-Id: <20161226102222.17150-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.209.gda91e66374.dirty
In-Reply-To: <20161226102222.17150-1-chriscool@tuxfamily.org>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Also use the functions in cmd_update_index() in
builtin/update-index.c.

These functions will be used in a following commit to tweak
our use of the split-index feature depending on the setting
of a configuration variable.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 18 ++++++------------
 split-index.c          | 22 ++++++++++++++++++++++
 split-index.h          |  2 ++
 3 files changed, 30 insertions(+), 12 deletions(-)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index d530e89368..24fdadfa4b 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1099,18 +1099,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 	}
 
 	if (split_index > 0) {
-		init_split_index(&the_index);
-		the_index.cache_changed |= SPLIT_INDEX_ORDERED;
-	} else if (!split_index && the_index.split_index) {
-		/*
-		 * can't discard_split_index(&the_index); because that
-		 * will destroy split_index->base->cache[], which may
-		 * be shared with the_index.cache[]. So yeah we're
-		 * leaking a bit here.
-		 */
-		the_index.split_index = NULL;
-		the_index.cache_changed |= SOMETHING_CHANGED;
-	}
+		if (the_index.split_index)
+			the_index.cache_changed |= SPLIT_INDEX_ORDERED;
+		else
+			add_split_index(&the_index);
+	} else if (!split_index)
+		remove_split_index(&the_index);
 
 	switch (untracked_cache) {
 	case UC_UNSPECIFIED:
diff --git a/split-index.c b/split-index.c
index 615f4cac05..f519e60f87 100644
--- a/split-index.c
+++ b/split-index.c
@@ -317,3 +317,25 @@ void replace_index_entry_in_base(struct index_state *istate,
 		istate->split_index->base->cache[new->index - 1] = new;
 	}
 }
+
+void add_split_index(struct index_state *istate)
+{
+	if (!istate->split_index) {
+		init_split_index(istate);
+		istate->cache_changed |= SPLIT_INDEX_ORDERED;
+	}
+}
+
+void remove_split_index(struct index_state *istate)
+{
+	if (istate->split_index) {
+		/*
+		 * can't discard_split_index(&the_index); because that
+		 * will destroy split_index->base->cache[], which may
+		 * be shared with the_index.cache[]. So yeah we're
+		 * leaking a bit here.
+		 */
+		istate->split_index = NULL;
+		istate->cache_changed |= SOMETHING_CHANGED;
+	}
+}
diff --git a/split-index.h b/split-index.h
index c1324f521a..df91c1bda8 100644
--- a/split-index.h
+++ b/split-index.h
@@ -31,5 +31,7 @@ void merge_base_index(struct index_state *istate);
 void prepare_to_write_split_index(struct index_state *istate);
 void finish_writing_split_index(struct index_state *istate);
 void discard_split_index(struct index_state *istate);
+void add_split_index(struct index_state *istate);
+void remove_split_index(struct index_state *istate);
 
 #endif
-- 
2.11.0.209.gda91e66374.dirty

