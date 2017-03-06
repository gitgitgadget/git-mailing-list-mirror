Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5BF521FBEC
	for <e@80x24.org>; Mon,  6 Mar 2017 09:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754224AbdCFJwY (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Mar 2017 04:52:24 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:32905 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754191AbdCFJwK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Mar 2017 04:52:10 -0500
Received: by mail-wr0-f196.google.com with SMTP id g10so20968182wrg.0
        for <git@vger.kernel.org>; Mon, 06 Mar 2017 01:52:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+hxPGCicRrm2RpyX4A8WgrnVvTMTjVGl7bmIOP4mPHA=;
        b=RArkFsIOytGwyrDofBi4LgFlI6MCKedp0Nlr+pbYLI75oJSd/arGFGL/TPZJYwg9ZP
         qawcsm+UTCr/eC6SavX38CjsQ2TEXv8m/Nl9CSv4InQqqLOQIuM9RgMNTCzLEq7i8IDE
         xrYrp0XEfDm8VprggBhV9nKiYv4eSnwi5KADrZJBB2HSh1+eiRjKv+OxOr1If2X4ynBm
         ii/RJHuPgediEWV9XzTeDatM8NuFvBpu7s0BfplJymazJ8Ny9auXPPNBzwukU4HlnC/U
         tL5fVzJq3KoraYCYPSJgs+8wIEC7Vdm36/D+qzAFCkpLLlUdzyCy02gCrEVt/RNuDuDN
         Hr7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+hxPGCicRrm2RpyX4A8WgrnVvTMTjVGl7bmIOP4mPHA=;
        b=V2v2AQxns9h0o+3a9tO4IimVcv5Y0cLW5yqD28AYnWuRkEoKR+18vyzfsMcRMx3z8Y
         yw4/9DDJWuzAKiIgatWoVauRRg6V8M5FG6mTAOC/xoGjlfd6lkLDSvGvhs8Pt0/uEBH/
         XyEanKH3R2wEamdLmhdpo7QIFVqbcEuYhZe/fJG1jYtdLyepXeWyQEPPIgmm10yZmxwk
         xHO0qttf6/NUbryVWlBOv2/Emi/2JXFSWyrN/EH6Jb5nHxGtaU5STNs9i0hJl+nXX0Yw
         bDZQyktWiwTdvohvL+VYll8pqBtr0tYITL1EPYRtYGyntoHqzWct7y0KRG+mq1Dnl2jj
         qgLg==
X-Gm-Message-State: AMke39nGzOLFLtbHaX0aCIWXtYxTKzBP85zPVaVvjeQNoA0E9d33tTyNOwc5siiv+fZfEA==
X-Received: by 10.223.171.15 with SMTP id q15mr12894490wrc.38.1488793342743;
        Mon, 06 Mar 2017 01:42:22 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id 191sm14144086wmo.21.2017.03.06.01.42.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 06 Mar 2017 01:42:21 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v5 04/22] split-index: add {add,remove}_split_index() functions
Date:   Mon,  6 Mar 2017 10:41:45 +0100
Message-Id: <20170306094203.28250-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.206.g74921e51d6.dirty
In-Reply-To: <20170306094203.28250-1-chriscool@tuxfamily.org>
References: <20170306094203.28250-1-chriscool@tuxfamily.org>
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
2.12.0.206.g74921e51d6.dirty

