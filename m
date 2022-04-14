Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61AE5C433F5
	for <git@archiver.kernel.org>; Thu, 14 Apr 2022 05:57:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239953AbiDNF7X (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Apr 2022 01:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234212AbiDNF7U (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Apr 2022 01:59:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A3034BBD
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:56:55 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id u3so5441049wrg.3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 22:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HJiNirn+4kjk8KZLleAcQP7bod9PGHDVNmpwWMZAfTI=;
        b=aAlImNB4dXDo3y5vAkwk1OZRROZqjM2hN4qVEAu8bNfTLGQIpE/xeS0Z5z6pN+HgF8
         BhlKluui0TxBAWYgpiAme/876m30t0WblQ04xYRSsaBkI2Wg9WRfxbkb74/zdABEm/3T
         L50iTAtsmDYYnjPsKWGm6Eiayv16VgU/eDy6hMg9FByhOxzSbmT/FqEv1mZHWVebVn5q
         C1yeRRpY11PqkkVmcLOOg+iy3KNwfQq861UePZ6f2OBClKAfZk5/2hHUyN/5iWYueWGa
         wXUy8BXJt0ZENAZAelods3kM9swWZ5vjReGw/sEa7cwo9oX2aQeyoJCljNkXXjXlIGkQ
         wNeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HJiNirn+4kjk8KZLleAcQP7bod9PGHDVNmpwWMZAfTI=;
        b=uaa4KWdatP9e9cyyoS/gCet02RZrnowO1vlbZ10qHi8vWzdC/OMVFlVMANddr4lnoD
         +edvpnRcqAaguHWGWb4YzYMapx02b5mo09U2T0jO+3bUq3YsPCg/rdIlrfQ5kceBQTx4
         Zh+NSU/aRcRioUVzG/w3triZVliF2DdvgIxNfbKywaQ1sIxQBYiFF56xJrrQrpDGt9Dj
         XKoZJy8bBciM6JhY1jsbuziu9elh0X2+g5sb7qhBF9YRdovEAfw+Uwxeif2bMqcKmktx
         enIlrrT8s/2efHjA42deUGTLYveJpOccnnMPAZVQNfIBBblYSu3HKweuuyeWvD7BXAmN
         SHQw==
X-Gm-Message-State: AOAM532kFVVgQGtkka8mvXhoujEfWiEfLPQvE/WOwbtq9Sxx8ETEFfmc
        vNYmVHNuyhkV7JsuWuIOkFE6QszpcczZNg==
X-Google-Smtp-Source: ABdhPJwrTXRXkfv5BThhBdjTnXobGUA+uwrWsd269JuxOLxiSn94jw3H0W3z9im7HURglZdODlZfgA==
X-Received: by 2002:a05:6000:1d89:b0:205:e6d5:c571 with SMTP id bk9-20020a0560001d8900b00205e6d5c571mr750353wrb.594.1649915813322;
        Wed, 13 Apr 2022 22:56:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2-20020a05600c4f0200b0038e8fb63293sm960453wmq.22.2022.04.13.22.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 22:56:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 26/27] revisions API: have release_revisions() release "topo_walk_info"
Date:   Thu, 14 Apr 2022 07:56:39 +0200
Message-Id: <patch-v6-26.27-f0cedadbb94-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
index 307f41e8891..0107ac1077a 100644
--- a/revision.c
+++ b/revision.c
@@ -2943,6 +2943,8 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 	free(mailmap);
 }
 
+static void release_revisions_topo_walk_info(struct topo_walk_info *info);
+
 void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
@@ -2956,6 +2958,7 @@ void release_revisions(struct rev_info *revs)
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
+	release_revisions_topo_walk_info(revs->topo_walk_info);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3468,17 +3471,22 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
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
2.36.0.rc2.843.g193535c2aa7

