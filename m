Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4542C1F5FB
	for <e@80x24.org>; Mon, 27 Feb 2017 18:02:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbdB0SCF (ORCPT <rfc822;e@80x24.org>);
        Mon, 27 Feb 2017 13:02:05 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:34153 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751392AbdB0SCD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2017 13:02:03 -0500
Received: by mail-wr0-f196.google.com with SMTP id u48so1365042wrc.1
        for <git@vger.kernel.org>; Mon, 27 Feb 2017 10:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Tko1npUUtViToZ4mjQ1DVsA1quyQKfNae1AwJ6XKGUk=;
        b=KKyjSJo0T9okPnerPgURqbVnfLTee3BRu+OJS7qt5R+O7eV20kBteH+mimKzdrDSEB
         hBVxVpCXME4UtDf3huO48Iwqhga9E6aTv/C6p7qHr1SGmr6lRxpnVF1FBou81ah3Ba/X
         bnUbkbY9Zxl2/nBMvt6Jw32BKCju0iTg4lhchA2v/VpIBgodhOeLDi9xcXYuhQdNjRD7
         jCS243npryhfSgdOQTyxQvDxSOIMyiOoZgkdyePolZklrXqeLNDkyzwngJS9Jb1EzRdw
         +77TVDxEYRNgQMW22HsEqQMBOzQEBJsdtotL/Xv3LolYOGRgWcAS9qWsJrrMJBhLLl0p
         qvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Tko1npUUtViToZ4mjQ1DVsA1quyQKfNae1AwJ6XKGUk=;
        b=qc79jSnCYfnsrpDTmIDw3rEM1Vd0CtQ3d2npRRx59RdeHPqpeeEVuAzYH7SXjRQsIC
         6XWF9rMVyDA++QGGurNzREUR2IlLsO0X8xo6qa4W6ZmYHs6NdU7FKt+QXiPDmEOSfoE2
         721/W4mRp7QeuHhOPCs/uNU5Z+ptvfkp/PjHoPTsKKyvuC/C7Yu6PeGw4Nnywrnyoxr0
         s9cr72O333Jt0/4jnvnLo9rpyenuPISHM4ekbNXbF2GnnhknsO3osJuFF9Mty6Dl+6Mh
         mOeXiVfr8iZo+ulILus0MRNnCg10YZy2/9LgZbXhGOHCznUInbOY4vhSCOVG+lmuBjIT
         7ZRw==
X-Gm-Message-State: AMke39lmpZZgKiD4zZL9tnhzd1CSJt+v4e0W7KhJYgzMnusiixB1P8AMqhZBQHdRaWJMyQ==
X-Received: by 10.223.129.74 with SMTP id 68mr14706303wrm.183.1488218442741;
        Mon, 27 Feb 2017 10:00:42 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id e73sm15226798wmi.32.2017.02.27.10.00.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Feb 2017 10:00:41 -0800 (PST)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v4 04/22] split-index: add {add,remove}_split_index() functions
Date:   Mon, 27 Feb 2017 19:00:01 +0100
Message-Id: <20170227180019.18666-5-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.12.0.22.g0672473d40
In-Reply-To: <20170227180019.18666-1-chriscool@tuxfamily.org>
References: <20170227180019.18666-1-chriscool@tuxfamily.org>
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
2.12.0.22.g0672473d40

