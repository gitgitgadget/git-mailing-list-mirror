Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 125C1C433F5
	for <git@archiver.kernel.org>; Fri, 25 Mar 2022 17:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiCYRaa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Mar 2022 13:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243380AbiCYR3P (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Mar 2022 13:29:15 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E8FFD6C7
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:38 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id lr4so8292400ejb.11
        for <git@vger.kernel.org>; Fri, 25 Mar 2022 10:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UDpsj3sFSATo/6CVvfi0L//28yttnLwqwVOYXtNJlBY=;
        b=Am9nkt0yPS23fUYrFnSjQvJC6SkcpJZxtF95D3TeyoFkGU7yNalE0Old6aH7d1UvEN
         3CRwmJ63tN40FdszpUaKarnUzZAAVwyYRiZkYDl0zZSDmjR32TT1whHAbJOxMX/p4BIL
         HC11V1IvaSqNNjwNVYP7dF3SMHOE7660AVmdje+v6TZeow9KGr1ABPWstHnwnMv0bPGI
         vBFp6NZGerve1uKgEqJLn5UBGhcaJzUJpHzEdHoLQw3SfFnaLyyCiSxDgropL+EUKweV
         na2JGzbeQzWDPTKt5DX4VJErwDuZ+/4IeQjxkiYligUj2/TTSVNMEBgVYEWS4PjVB2m5
         4JPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UDpsj3sFSATo/6CVvfi0L//28yttnLwqwVOYXtNJlBY=;
        b=nFSCnTfrrCCuEIe5rwC+3yUmt2Wn/OuefdTTnkFIpcQHtCCUmKC8Gqa+GRBgPCGe3z
         MXkJXcxXmMjTyUx162mEROH3tlhln06YgBRkiG1/CfaoponcnoAeQYNMUaDxwmuFIsGH
         HEsIXiUKywBrbbk4ujCgv1iQx0gkbp/s557cWGBbxTkh8955g2tSqidcx8QyHXA1wnlG
         6GzQbPvTRa34aNeqYRAJbZI6zAJEdMm+4NwjiTx7923jDJd8sJSafw1PrjuQ3RfJy2p6
         YIeOwtHXW7913WjxsiMOS4X4lGtZlLPV41/bID408XNw8BF9FOrSt33YSZRRUj3ZF790
         pcaQ==
X-Gm-Message-State: AOAM530i6aLaUHvu5OYAHvSldVJGlf+x4Tq98c7xdXT4ESm2uugrZ0f+
        QKN24YZSb0u34BmOJKFD6bVs8e0O67/mzg==
X-Google-Smtp-Source: ABdhPJyxd42b0pIJsxaf4m02q6GuiHmhh/1gkfP0UlMc2nHS4Ib/qKzfVccMxadpLDuCUXgQI7CuzA==
X-Received: by 2002:adf:912f:0:b0:204:3be:1a5b with SMTP id j44-20020adf912f000000b0020403be1a5bmr10663437wrj.467.1648228795847;
        Fri, 25 Mar 2022 10:19:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p16-20020a5d6390000000b00203ffebddf3sm7554165wru.99.2022.03.25.10.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 10:19:55 -0700 (PDT)
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
Subject: [PATCH v3 26/27] revisions API: have release_revisions() release "topo_walk_info"
Date:   Fri, 25 Mar 2022 18:18:50 +0100
Message-Id: <patch-v3-26.27-5efc0ae58ed-20220325T171340Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1509.ge4eeb5bd39e
In-Reply-To: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
References: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com> <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
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
index 49668012ed1..cff1c2c6021 100644
--- a/revision.c
+++ b/revision.c
@@ -2950,6 +2950,8 @@ static void release_revisions_mailmap(struct string_list *mailmap)
 	free(mailmap);
 }
 
+static void release_revisions_topo_walk_info(struct topo_walk_info *info);
+
 void release_revisions(struct rev_info *revs)
 {
 	release_revisions_commit_list(revs);
@@ -2963,6 +2965,7 @@ void release_revisions(struct rev_info *revs)
 	free_grep_patterns(&revs->grep_filter);
 	diff_free(&revs->pruning);
 	reflog_walk_info_release(revs->reflog_info);
+	release_revisions_topo_walk_info(revs->topo_walk_info);
 }
 
 static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
@@ -3475,17 +3478,22 @@ static void compute_indegrees_to_depth(struct rev_info *revs,
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
2.35.1.1509.ge4eeb5bd39e

