Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B0E720229
	for <e@80x24.org>; Sun, 23 Oct 2016 09:27:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756295AbcJWJ1V (ORCPT <rfc822;e@80x24.org>);
        Sun, 23 Oct 2016 05:27:21 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32826 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752642AbcJWJ1O (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Oct 2016 05:27:14 -0400
Received: by mail-wm0-f67.google.com with SMTP id d128so5248745wmf.0
        for <git@vger.kernel.org>; Sun, 23 Oct 2016 02:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YWzezEyNy8rG0jEqsqsDxtZeWnivyM3B13FCVaht3vo=;
        b=kwcalpkWxS8P8U3OtMcTJf7f6Yk0pfEbhg8/oGh44cNhb+fer62lIlLiXur/KWju4a
         GoZhctR1FyAiSCVMHc3G14Afc3sqZ3joz+O3sUNE7m4yC9Fg5BZu9G+fSM4AbfDPOfFh
         s2wl6IqXCeHo9AmNVZbhKX/+E1QfarjsxDlPtgi2ENiFLTq4ug4LWU+pAB/Kz80teRga
         Q7kPxz0TgyZUQRU9HSLsgTv0y216GTy2GGffxDYnBxuq4FLoa7Wl4eoYOVzs9E8DYhWA
         rzrQj037gJIguGOkTqOak0ziDpgETLbGImrE87YVUeIrcHZdHNxaCssrg8needMRRrCu
         KkbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=YWzezEyNy8rG0jEqsqsDxtZeWnivyM3B13FCVaht3vo=;
        b=eBEbANwXsr3Jf2eIUX0o5hfRvIgN4XXIUUOVCJfxIpLpRQW6/BeM2iw5gxcUYrMCVM
         MnsK0GkR0QN42xIsNWcC1Pjk8zxTtuc4PfsP3oOOHqZJebvypzKF/SSWNMzLX17ePuiF
         HBDTWpKxE6M6mModRv7QkbQL0WI44wIcKI6p9B1ggCRoZYAXY68oVvuyoaCMD/dukxtP
         l9H0YVLa79Z0/7WTs0cikWTDLP0umM7p8xqKajAfsE6zP70HPwqV2TIKVf94EzqhXRds
         ZnwzODR/+fL7ctYb1C0z6SQrF8ZD2lnoIbiPsVInXhVR0vDTzFqguZs5rAhfrJK8yJ0L
         2+gA==
X-Gm-Message-State: AA6/9Rk/vQOjsPMb+c+kdUNQ9CBPOr7pHGeeV+3lwmAAyy8qKAYmcVM5X86/Yb5hq80w7Q==
X-Received: by 10.28.7.198 with SMTP id 189mr18133480wmh.65.1477214833213;
        Sun, 23 Oct 2016 02:27:13 -0700 (PDT)
Received: from localhost.localdomain (183.187.113.78.rev.sfr.net. [78.113.187.183])
        by smtp.gmail.com with ESMTPSA id x138sm8257569wme.14.2016.10.23.02.27.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 23 Oct 2016 02:27:12 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v1 03/19] split-index: add {add,remove}_split_index() functions
Date:   Sun, 23 Oct 2016 11:26:32 +0200
Message-Id: <20161023092648.12086-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.10.1.462.g7e1e03a
In-Reply-To: <20161023092648.12086-1-chriscool@tuxfamily.org>
References: <20161023092648.12086-1-chriscool@tuxfamily.org>
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
index f3f07e7..b75ea03 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1098,18 +1098,12 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
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
index 615f4ca..f519e60 100644
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
index c1324f5..df91c1b 100644
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
2.10.1.462.g7e1e03a

