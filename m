Return-Path: <SRS0=iBdC=IG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A49C433E9
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2F965151
	for <git@archiver.kernel.org>; Mon,  8 Mar 2021 02:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231364AbhCHCWT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 21:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbhCHCWE (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 21:22:04 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37D13C06174A
        for <git@vger.kernel.org>; Sun,  7 Mar 2021 18:22:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id p7so5753492eju.6
        for <git@vger.kernel.org>; Sun, 07 Mar 2021 18:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPKfvej6w7tTutDJz8cAOO04Knc3C1maiRIg6hg7wGc=;
        b=uDACk7vOeMq+RxpqH+eYm1R3EX7RP0GKLtMZCcU2LyE492yV1Ra6jISUhcESAMccHE
         mL5BRXubcxrP2eTzf6Xc/lhYQRGsubK3fKPmcfGEkStpEj2Pb/KKS3MxhUtADenKtg5y
         D7aJl+j4kBNQW4nAAXuLDk4OPEYCfkQpc2lFR+VzfXLbn3C0uY+naG5CIvFMkWFoiYRC
         sykm50KWEM0olg6jsiQ9WjB0EiGwvn+dj3SCcT/CDHWl/roRDRhgpcw27GKGXaD+1qrj
         V8DXpxF+HKAnIc/UJ7QKADmHvMwcGdUj6x+kTPLRzFXO6Age2pyzQ2R4FJqm7QwOOAkj
         SNIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPKfvej6w7tTutDJz8cAOO04Knc3C1maiRIg6hg7wGc=;
        b=mgqlVNNLWgdFnYtWelEJQYEOjMtXkACAdBKl0FSNv1lgXEM8Y3KZLwiLC21FFCODS0
         vRIFSJokd9f0Nbo2NGMWUDHfbEc51fOtVq+0H+3mfoAugDhCxuAz3T0+dhWtg7XYWCpW
         2/8wksyf99QvZTfOPnngJ5flXz2PDgumNG4cSjRKVC8CxQI3BOp+zgD1DTLxmnTYr1wg
         cbnclETgoKX+Gp1x5askkWa2EKvXyM3or0nUkmYFc796jS29c5p0g6m9jO5mh9gigV/X
         PBXVAFs1511DQD0Bb/m4t4b1jgnJKbUtDxwpo66TVHO6yNVwwhsbI4d6FYD4Cm88aqM8
         7oZA==
X-Gm-Message-State: AOAM530i8F27OcVflVSn+dXiUY+LEBzFy3TA5IQGHPMxzayIKx5TVJJG
        +UwZqAPCdgI4TzPf7sdDlpIhrqYMZZUy3A==
X-Google-Smtp-Source: ABdhPJylRAvMC8LJqjOabjcWJqjDQykCQsuWC8ucDHeUCIq8ysU0wWYq9Isy4sHX8YpC4CDi+APHBg==
X-Received: by 2002:a17:907:20c7:: with SMTP id qq7mr12455973ejb.528.1615170122748;
        Sun, 07 Mar 2021 18:22:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id dg26sm6264995edb.88.2021.03.07.18.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Mar 2021 18:22:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 3/6] ls-files: don't needlessly pass around stage variable
Date:   Mon,  8 Mar 2021 03:21:35 +0100
Message-Id: <20210308022138.28166-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210306193458.20633-1-avarab@gmail.com>
References: <20210306193458.20633-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Now that read_tree() has been moved to ls-files.c we can get rid of
the stage != 1 case that'll never happen.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-files.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index a4458622813..74d572a3e4a 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -470,21 +470,12 @@ static int read_one_entry_quick(const struct object_id *oid, struct strbuf *base
 }
 
 
-static int read_tree(struct repository *r, struct tree *tree, int stage,
+static int read_tree(struct repository *r, struct tree *tree,
 		     struct pathspec *match, struct index_state *istate)
 {
 	read_tree_fn_t fn = NULL;
 	int i, err;
 
-	/*
-	 * Currently the only existing callers of this function all
-	 * call it with stage=1 and after making sure there is nothing
-	 * at that stage; we could always use read_one_entry_quick().
-	 *
-	 * But when we decide to straighten out git-read-tree not to
-	 * use unpack_trees() in some cases, this will probably start
-	 * to matter.
-	 */
 
 	/*
 	 * See if we have cache entry at the stage.  If so,
@@ -493,13 +484,13 @@ static int read_tree(struct repository *r, struct tree *tree, int stage,
 	 */
 	for (i = 0; !fn && i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (ce_stage(ce) == stage)
+		if (ce_stage(ce) == 1)
 			fn = read_one_entry;
 	}
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(r, tree, "", 0, stage, match, fn, istate);
+	err = read_tree_recursive(r, tree, "", 0, 1, match, fn, istate);
 	if (fn == read_one_entry || err)
 		return err;
 
@@ -549,7 +540,7 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree(the_repository, tree, 1, &pathspec, istate))
+	if (read_tree(the_repository, tree, &pathspec, istate))
 		die("unable to read tree entries %s", tree_name);
 
 	for (i = 0; i < istate->cache_nr; i++) {
-- 
2.31.0.rc0.126.g04f22c5b82

