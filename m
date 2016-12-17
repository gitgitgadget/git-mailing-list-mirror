Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866BE1FF76
	for <e@80x24.org>; Sat, 17 Dec 2016 14:56:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757298AbcLQO4M (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Dec 2016 09:56:12 -0500
Received: from mail-wj0-f193.google.com ([209.85.210.193]:33738 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756968AbcLQO4I (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2016 09:56:08 -0500
Received: by mail-wj0-f193.google.com with SMTP id kp2so18014875wjc.0
        for <git@vger.kernel.org>; Sat, 17 Dec 2016 06:56:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=g6FY71BYu4vOribQAOAdUnc83XOzm6DBAUFi2LB68pA=;
        b=uSKvUVHQuDHgYX7z2yD34xbh6lH2Yie7wq0cPcam3n4t58E/z3J1WtItneq7Tf61uA
         228JDSC5jntfLOEKMvKbK/pJRWkvpec1XEnSlg22WFfNs42VYaBCzJnoT2R0mIWNq5fv
         1/uZNugddV7Ptv286P52iwcFzdrfooJ6AIMwmGeRpbiTKXYgdzrzDrQyruH64gjbojwF
         bs6JrKX3e4fMcgRqSg1kXMLWr/V4ZRzazyKyQeWT8WDogBHHpgd1HTm1tQXsXNnO4mD5
         BdrBIh7yPRZ2WGs4uADH6G+ZoCPf5qVn8cy4qf+6lPjXeCMdF7VOlRZkx43COl4ksZvg
         J41Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=g6FY71BYu4vOribQAOAdUnc83XOzm6DBAUFi2LB68pA=;
        b=iIdMFi5QJ/aKkaMzYpTSyB2N45o94HpneDoNkTFTEhwoYLG6q7WCvTICruTufVaUO8
         fxoq2Zepk4+VzhuR0fPaMYOiEtSIML7rHORjApoYqvJhHh7oOliZr6icg/rDQbITOvqK
         d00NoPCvxd4RmEJbCN9cdXXH1tLIQjD9/kMlw3cVm2pPwGZvIyg0p/YWYHz98zFPaJyf
         Th1UhD9UUJ8wcVcrWyCLIyOowHxna4a6zOzBf1L7w2QCQHNPx4NxDRLwWoR0sNUxRxie
         WVKw95sVc8F6XhvVMDOrXoZlLs2dHeEvj1XcnVKnX5kK/RcCJXjdLFsYv+67ErYuEsyf
         ODOQ==
X-Gm-Message-State: AIkVDXI2aAWc8pJkBkmPAp6nSNc7XEaiGyO4anANddx14RbyojADzBfgmnYI7XXczf/0eQ==
X-Received: by 10.194.0.229 with SMTP id 5mr8272992wjh.55.1481986566493;
        Sat, 17 Dec 2016 06:56:06 -0800 (PST)
Received: from localhost.localdomain (85.198.126.78.rev.sfr.net. [78.126.198.85])
        by smtp.gmail.com with ESMTPSA id y4sm11823449wjp.0.2016.12.17.06.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 17 Dec 2016 06:56:05 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 03/21] split-index: add {add,remove}_split_index() functions
Date:   Sat, 17 Dec 2016 15:55:29 +0100
Message-Id: <20161217145547.11748-4-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.11.0.49.g2414764.dirty
In-Reply-To: <20161217145547.11748-1-chriscool@tuxfamily.org>
References: <20161217145547.11748-1-chriscool@tuxfamily.org>
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
index f3f07e7f1c..b75ea037dd 100644
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
2.11.0.49.g2414764.dirty

