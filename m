Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1457C433EF
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344795AbiCWUfY (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344801AbiCWUe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:59 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B328E1B7
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:51 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id t11so3783425wrm.5
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=T/ZOoKWgUhpw/FzKiH/NOk5LTgyT+ulONzXd17XfJ2o=;
        b=SxOrQtMy9ZL8b1k/0N1ZvtxilcI0dhRv8uK4uyPBctodERu82iX7U6O6pnm8VVETBm
         fUBtroNBKqj5cPJ1Hdljcd5KJUvIiwIPd85Vgno6Hw6PbgPgCWVWdQdSPYGmxRJLgmrs
         VvIu7Xf3kSRHgL9vifBT7KAWR/XXFsh55oY1TW8Xhmp8jRIcy4aNpXG2HcnJQ0WE7ByI
         vmhFBlLl/+t/jfNtgJf4+T0IdGa1RR0WeM52EUwIJsymctWEl1vat6B0OI5kYsr7K1Zk
         nZh0auc0mmlJ/ddJqb3z3sfQvr4VwcTZOxWKy7yRm/oqKV4UHorbDU1al+A6W1dG3KPX
         ulkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T/ZOoKWgUhpw/FzKiH/NOk5LTgyT+ulONzXd17XfJ2o=;
        b=YuHnuV79kzhlvdRytMtdFPzV041GRNJbth4TiWjruSPDAVYQaMouL7Gts2pb/69k88
         4q0BqDuGlOUNSEc/lqWXZZb+Lrq6Y4O7BtZ1W75fSl3nFuU+DMoeahFHsZYaCsqjjnGy
         7HbUEE4OT63CN2BrzxPJWD6wnHOaOCI7MNsfpx2FOXIXHJXEytZ7W8XVALnHmPkLApjq
         SdopD6krzO8GFVgOGHoda8NKr20e7w494TfBZcX7ONCamideuTIWlD38hYrGN9qKHSuy
         EChZ/HR0ocv8swxnnAC/Wb3tM9bcIk3fj+KhGyiufq4ahEzdbh4Z5MS+SxqpGqa6mtkI
         649g==
X-Gm-Message-State: AOAM532/Cbku/gPOfdBnY6vaynuITyxOR+dxLn5IxN8C14kbeI9y59BK
        KTPI2sGr0LuXayFaOA1Ll16N1uPn+FKMIQ==
X-Google-Smtp-Source: ABdhPJyZ/Kmqei3ytRoPv9AgvuwRX7UQ7e5lg/X5aY+WwpVLCMf36BONLQ07I6gbwxjMh0GuSV9crQ==
X-Received: by 2002:a05:6000:1561:b0:204:1ba3:3b8b with SMTP id 1-20020a056000156100b002041ba33b8bmr1468919wrz.325.1648067569726;
        Wed, 23 Mar 2022 13:32:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:49 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 26/27] revisions API: have release_revisions() release "topo_walk_info"
Date:   Wed, 23 Mar 2022 21:32:16 +0100
Message-Id: <patch-v2-26.27-644d1b54afe-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the existing reset_topo_walk() into a thin wrapper for a
release_revisions_topo_walk_info() + resetting the member to "NULL",
and call release_revisions_topo_walk_info() from release_revisions().

This fixes memory leaks that have been with us ever since
"topo_walk_info" was added to revision.[ch] in
f0d9cc4196a (revision.c: begin refactoring --topo-order logic,
2018-11-01).

Due to various other leaks this makes no tests pass in their entirety,
but e.g. before this running this on git.git:

    ./git -P log --pretty=tformat:"%P   %H | %s" --parents --full-history --topo-order -3 -- README.md

Would report under SANITIZE=leak:

    SUMMARY: LeakSanitizer: 531064 byte(s) leaked in 6 allocation(s).

Now we'll free all of that memory.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/revision.c b/revision.c
index 62dddeeeab5..ab570ac754c 100644
--- a/revision.c
+++ b/revision.c
@@ -2952,6 +2952,8 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 	free(mailmap);
 }
 
+static void release_revisions_topo_walk_info(struct topo_walk_info *info);
+
 void release_revisions(struct rev_info *revs)
 {
 	if (!revs)
@@ -2967,6 +2969,7 @@ void release_revisions(struct rev_info *revs)
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
+	release_revisions_topo_walk_info(revs->topo_walk_info);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3479,17 +3482,22 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
 		indegree_walk_step(revs);
 }
 
-static void reset_topo_walk(struct rev_info *revs)
+static void release_revisions_topo_walk_info(struct topo_walk_info *info)
 {
-	struct topo_walk_info *info = revs->topo_walk_info;
-
+	if (!info)
+		return;
 	clear_prio_queue(&info->explore_queue);
 	clear_prio_queue(&info->indegree_queue);
 	clear_prio_queue(&info->topo_queue);
 	clear_indegree_slab(&info->indegree);
 	clear_author_date_slab(&info->author_date);
+	free(info);
+}
 
-	FREE_AND_NULL(revs->topo_walk_info);
+static void reset_topo_walk(struct rev_info *revs)
+{
+	release_revisions_topo_walk_info(revs->topo_walk_info);
+	revs->topo_walk_info = NULL;
 }
 
 static void init_topo_walk(struct rev_info *revs)
-- 
2.35.1.1452.ga7cfc89151f

