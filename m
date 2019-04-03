Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 51C6020248
	for <e@80x24.org>; Wed,  3 Apr 2019 11:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbfDCLgD (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Apr 2019 07:36:03 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:34499 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725941AbfDCLgD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Apr 2019 07:36:03 -0400
Received: by mail-pf1-f195.google.com with SMTP id b3so8023365pfd.1
        for <git@vger.kernel.org>; Wed, 03 Apr 2019 04:36:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D/Adi1r61sibAZ06FAoFtOkjnokXL4vXDquRsCSKByU=;
        b=a/ZrNOp/y5823DKdvffo09NRn76Kv+JSnRIm5i14SMg84Rk2qawGnKNoxnH/cOndys
         T/MnViKFWu/DEGHImF/YK4NcEJcXPME5cMvg0vIUnyLxMQtXvyQ5vmAa0FXZ4rvb1Wpj
         KUBFAgeux2sgf1BPeKtk5/Io08sGVMZhqGY8fiQ9xQARmhOSo6MVQdFDDIgcx4aBtTkW
         T69f1j8nHjxQfFe5/4NIUCDtP17QGEgyg1a2ntEvNR4Ke8jYEKczuxIgy9mJTxEwyIBR
         uiUye1pF3xB7rxPrpx0QOo1BwVtGcbpaLA2bO07pAaQKodXdJHIdWV5ym9e/Hs5IeRCx
         Go1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D/Adi1r61sibAZ06FAoFtOkjnokXL4vXDquRsCSKByU=;
        b=hnSilQaPs2gcsnsK/NO5PrGfjTnDLqRkKHCorSVtHXgHOF5m5oECMUrI/fX5RqUxU5
         uIGhVA5nyXhg6hz1hHS+HUXoySBUSJwA+AlNHkQYD9IImPJXxSUTIQA68P74r25EF2kR
         +O2P93tCtNG/QVW/fUgxv0LL9wsybqnApNrczsgRf3HkaNdYZfdE2i5+gPef/PbWR4Xr
         PjKlJYH48Q8CCEo7qNEtGmlSCGOzEisbHLzHOhMN1JXpTCfxVweDWNFs4dbUC7RS+mXk
         GAa4z1W+goPikASSc7kLcdt0se/eF8FmEXvg2ha+7bwG2NJTh0JcZNoUaR8WsH079CmN
         3f1g==
X-Gm-Message-State: APjAAAXT92ZYTCqMJP5uUq6tb8uE52CxzvIPXbJR9Tztkho6ITfyFw2c
        O5EYumKO2RSVvDJInT4dNOc=
X-Google-Smtp-Source: APXvYqz36pa8Inl8IQUHusp+3dJ7bWVScmGkogfdq++u/OGMMJu8oBOJNa9VZBfPHwW3pQIF1FUc8A==
X-Received: by 2002:a63:3d4c:: with SMTP id k73mr55812737pga.154.1554291362501;
        Wed, 03 Apr 2019 04:36:02 -0700 (PDT)
Received: from ash ([27.75.136.26])
        by smtp.gmail.com with ESMTPSA id d3sm24241332pfn.113.2019.04.03.04.35.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Apr 2019 04:36:01 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 03 Apr 2019 18:35:57 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, stefanbeller@gmail.com,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 10/32] commit.c: add repo_get_commit_tree()
Date:   Wed,  3 Apr 2019 18:34:35 +0700
Message-Id: <20190403113457.20399-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.21.0.479.g47ac719cd3
In-Reply-To: <20190403113457.20399-1-pclouds@gmail.com>
References: <20190330111927.18645-1-pclouds@gmail.com>
 <20190403113457.20399-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 commit.c                        | 5 +++--
 commit.h                        | 3 ++-
 contrib/coccinelle/commit.cocci | 4 ++--
 3 files changed, 7 insertions(+), 5 deletions(-)

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
diff --git a/contrib/coccinelle/commit.cocci b/contrib/coccinelle/commit.cocci
index c49aa558f0..f5bc639981 100644
--- a/contrib/coccinelle/commit.cocci
+++ b/contrib/coccinelle/commit.cocci
@@ -12,12 +12,12 @@ expression c;
 
 // These excluded functions must access c->maybe_tree direcly.
 @@
-identifier f !~ "^(get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
+identifier f !~ "^(repo_get_commit_tree|get_commit_tree_in_graph_one|load_tree_for_commit)$";
 expression c;
 @@
   f(...) {<...
 - c->maybe_tree
-+ get_commit_tree(c)
++ repo_get_commit_tree(the_repository, c)
   ...>}
 
 @@
-- 
2.21.0.479.g47ac719cd3

