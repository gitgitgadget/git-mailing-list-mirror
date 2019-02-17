Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 264DB1F453
	for <e@80x24.org>; Sun, 17 Feb 2019 10:10:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfBQKJ7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Feb 2019 05:09:59 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:41583 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbfBQKJ7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Feb 2019 05:09:59 -0500
Received: by mail-pl1-f196.google.com with SMTP id y5so1699196plk.8
        for <git@vger.kernel.org>; Sun, 17 Feb 2019 02:09:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xVaTyVSFyaD6wwIKP1+wDytu21O4LfW3MiqUfTnB9S8=;
        b=fpa92lAdB4I39zxe6rj3iu899z8dIT3WLgGCeOYxIgAwwtIlo9EERmhoALWz/juNOg
         vorOVVENiTcCpeCez9qfW5pC7HXDWYi5dtxf/fbbLfyqqle2TBCOHEsWyTBvfGptO0CK
         ip2ojHLBNg5AhF3C29VehuffI5gSKezxli2NGqmnHGhZYf7P0Pbc8YSsRfkRD2WMKpDd
         5zNIKY7DN67w/Mn5gLjOtLqHZvK1b6my5VLCHGeowb8G/l3QbjiIQQKbh7VCWZx2zp7Q
         hC0KGWIsRV6xEEj+VFrZvnVPoY4oo9zjTS0gKChP9disRynQ4jyQlrc0lBncsqjxJxjX
         miyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xVaTyVSFyaD6wwIKP1+wDytu21O4LfW3MiqUfTnB9S8=;
        b=XagJMnEnfKE0Mi9y2pv80sa2OP7kyt3DbxKbLFrVJ+7sYpDbaQ1U3GNgj1RxIB+TO4
         5HtZM9BItk5f5xlomy45e222pPikMjklHDYIciGyA7CwO+WiYXl34IRbZgWwzv/TCwKJ
         ud19IUACSmaTTdF/MdtM1VZoGTmLc3bflleczZSVsM0LEm/Bo4uW8qRf9YLcwhj0MIrf
         EI7LPHd8WRjdEgW4dCAZhRhf2nSD/j3TGeiD9PpkxOAJKH81fdJcTlQPSOKg1qmCyhdl
         Xdwy2+JTkIgc8ldnC/ssIGl/QNHhBzAJHDvF0Zvr8k8f4g84vitb1E8oRFXaWrPdmZvR
         ZQ0Q==
X-Gm-Message-State: AHQUAuaDG3ZONcIlXhpvhfXc2D93EQdTKfuU5ckMspzePzTYlwerJ4zg
        3uLRl2kqE58ckXMQSzVYTfSySH3a
X-Google-Smtp-Source: AHgI3IbtLp7NiutNBewqYHfLPbKDQt01l2GMcHPFXFNAgQB0ekvldWjjZ/wUWJz++phPDTw/vMN8kw==
X-Received: by 2002:a17:902:e711:: with SMTP id co17mr5366023plb.171.1550398198540;
        Sun, 17 Feb 2019 02:09:58 -0800 (PST)
Received: from ash ([115.72.21.220])
        by smtp.gmail.com with ESMTPSA id i2sm13131164pgl.53.2019.02.17.02.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Feb 2019 02:09:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Sun, 17 Feb 2019 17:09:54 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 09/31] commit.c: add repo_get_commit_tree()
Date:   Sun, 17 Feb 2019 17:08:51 +0700
Message-Id: <20190217100913.4127-10-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.rc0.328.g0e39304f8d
In-Reply-To: <20190217100913.4127-1-pclouds@gmail.com>
References: <20190217100913.4127-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.c | 5 +++--
 commit.h | 3 ++-
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/commit.c b/commit.c
index a5333c7ac6..f0a5506f04 100644
--- a/commit.c
+++ b/commit.c
@@ -340,7 +340,8 @@ void free_commit_buffer(struct parsed_object_pool *pool, struct commit *commit)
 	}
 }
 
-struct tree *get_commit_tree(const struct commit *commit)
+struct tree *repo_get_commit_tree(struct repository *r,
+				  const struct commit *commit)
 {
 	if (commit->maybe_tree || !commit->object.parsed)
 		return commit->maybe_tree;
@@ -348,7 +349,7 @@ struct tree *get_commit_tree(const struct commit *commit)
 	if (commit->graph_pos == COMMIT_NOT_FROM_GRAPH)
 		BUG("commit has NULL tree, but was not loaded from commit-graph");
 
-	return get_commit_tree_in_graph(the_repository, commit);
+	return get_commit_tree_in_graph(r, commit);
 }
 
 struct object_id *get_commit_tree_oid(const struct commit *commit)
diff --git a/commit.h b/commit.h
index 42728c2906..b576201be8 100644
--- a/commit.h
+++ b/commit.h
@@ -143,7 +143,8 @@ void repo_unuse_commit_buffer(struct repository *r,
  */
 void free_commit_buffer(struct parsed_object_pool *pool, struct commit *);
 
-struct tree *get_commit_tree(const struct commit *);
+struct tree *repo_get_commit_tree(struct repository *, const struct commit *);
+#define get_commit_tree(c) repo_get_commit_tree(the_repository, c)
 struct object_id *get_commit_tree_oid(const struct commit *);
 
 /*
-- 
2.21.0.rc0.328.g0e39304f8d

