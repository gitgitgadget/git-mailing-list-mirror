Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE3FC432C3
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A809D6510E
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238162AbhCPPxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231684AbhCPPww (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:52:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E9F3C06174A
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:52 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id f22-20020a7bc8d60000b029010c024a1407so1748182wml.2
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6T/mQ34byf3L1EwgB9VIViPWZHfszFl1Xxt4IsCa9YA=;
        b=ABnsh4WEVtpIUUYKFV9//ozrPrE6g4+H9BXZao48TxA2J6qhrjf1gQB178vJCA00g4
         74FTFh9t5EcwcboPNWY/BXpYBad++cBv9GYaYltfdjwH3lMRQqp4idSqT1WAuUjQxBJU
         5EaHS8JNkOQX4YMI9MIsw5kQfiMZPnW+f1Efp17Q9OifosslG4Oyhc9jM0U1IDaADmHL
         h6g26hGH7AIbK8lC/l0xxUY0+tgD8QLjBSCuLh2h8O5FfnQXaiBVfN3c1KlD4kvU9uT7
         zu+8HBm6kfaqiOIhjSzPuaSxB7gXc8HHvU0Qjre0GFU7sAIyYmS19XLur5Im22k8aRkp
         QZrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6T/mQ34byf3L1EwgB9VIViPWZHfszFl1Xxt4IsCa9YA=;
        b=C0UEZ/2XdxQuwKtphauTqUG8nd2f8/cRfzLtUFb5OQZGihOqSHt/WK+L1wYsQvHO+w
         4OxWA0gQGD4xbIYl3FO8c99W5ziULliSx4jbfJoIeFJ0GRJ/ZRYHg5UkjntXK8GdOvQs
         vWNfAyY98tnnJ2FgCmyzjjW01S/7IOtRGyqM6IV4ZZIyE6vVZBcU1oiNXxxUHjK7KBgT
         Z/y03NMyQkEOLFukUxal+yfWXRsBThc+jkAajwycD45bfTOKWFxbxacA8PDvW0R0A01W
         bva1Hw57AHhrGaYNo/CwJTIEORGUnXjFG/JrXxPzouc3LdBtodLK3uDDs0sHdyMg8v55
         WQBQ==
X-Gm-Message-State: AOAM530W03OAAIZaxTvuyjsX+d2HsgaT9pjjbgQ1LQXACTmvmLsbiE7B
        D4yJwNjegr4cms9x6JXlrw+e6RfoMOWfKA==
X-Google-Smtp-Source: ABdhPJyXmt4DkURuiBElzqlu5ItXiHlG8UPAas1lWKkfY2IkWIN0GvO3HlP5uL4IcDhp0mY3sv5q/A==
X-Received: by 2002:a1c:c282:: with SMTP id s124mr271907wmf.99.1615909970346;
        Tue, 16 Mar 2021 08:52:50 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm22224228wro.53.2021.03.16.08.52.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:52:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/9] ls-files: don't needlessly pass around stage variable
Date:   Tue, 16 Mar 2021 16:52:38 +0100
Message-Id: <20210316155244.28328-4-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
References: <20210315234344.28427-1-avarab@gmail.com>
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
index a445862281..74d572a3e4 100644
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
2.31.0.256.gf0ddda3145

