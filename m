Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C71FC433E6
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 349FA650BC
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbhCFTf3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:35:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbhCFTfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:35:16 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE335C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:35:15 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id j2so6575579wrx.9
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:35:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IPKfvej6w7tTutDJz8cAOO04Knc3C1maiRIg6hg7wGc=;
        b=j5Gcu35wZGaBt6dj4xcF4Zfjob5BzV7TNBDVbi0isvm2moEOSkdDNC5lzpZ1NrC9CD
         ZshiGA0WYhafeU4etKQ12AhUooxgd/GHWRRtjwdDASqxg9lvhPcJhdP40TnU2mlTvDr5
         C0KdBabpYLyb+wBJN+jvJz6dLeUy7ghUbMXh+tKDvsUQvzL/c38iM3zQZ+hX7oYqijCO
         Pe0QYgzh1DckAWhDhCxSS+sxA/8EoqJ8xTDSsTMssnMVVwhebWE1R7Do7/a3gmJal1sW
         aTVXBH3cK7OswOHHqDT/YJtxIDxU05ANdcoQjgiRA894eZtF9fA0RRolMjVCV3AyNBHa
         7ikg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IPKfvej6w7tTutDJz8cAOO04Knc3C1maiRIg6hg7wGc=;
        b=q3rZL94Y7VVn9WfIiZI8oktk0NP5iDc1CQ6WIjkapZYAIQTgJVUgdGTidt67Zc30m5
         u1AiwD5Q7oWb+F0wvD83i5xOhFmNVUYt4c1KLvTgeIRJ+SgmykJ0y/P7+TcxqNnJaJ5W
         ONDct5sgAPIjv6PhS0zOAsHAPnsIcz5AKC+L3TNhww2G87p14Wf/g0HEVTFFRumuR9Vq
         yHx0pqJhH17V8XeOyPh1ETUukV7vL3BPfTb9j7DSvcOjbMICDDBV5ZVA1YLMX8/aMv1V
         k4b69EWdYaiC88uqatuEEXAcRM1/SZKNbr6m4wLz/OvzFKEcpQg+sxeuSIedLcAz0qn5
         wzyQ==
X-Gm-Message-State: AOAM531JSViOpbZV8hRM5T256G1oLm6d8gJbhV4SFEnYA/fsvXc1UtSE
        C5+4bNekeraq84REpZ+/ZhaYAqfE3KZ/VQ==
X-Google-Smtp-Source: ABdhPJxUGaqixtZ1DrOqgERJIoNqZmIMNP/SNRPc49dUAiQCbZtoQfMObl79Ch0Grsfo1s117uXYLg==
X-Received: by 2002:adf:f144:: with SMTP id y4mr15401414wro.408.1615059314382;
        Sat, 06 Mar 2021 11:35:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a5sm9951578wrs.35.2021.03.06.11.35.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:35:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/7] ls-files: don't needlessly pass around stage variable
Date:   Sat,  6 Mar 2021 20:34:53 +0100
Message-Id: <20210306193458.20633-3-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
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

