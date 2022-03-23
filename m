Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5165C433FE
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbiCWUfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344774AbiCWUee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:34 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E318CDBE
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:46 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u16so3788347wru.4
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O7Px77fXQ/tKc+ndRFpADgatrNr3n7PhTB3o/AK/mpg=;
        b=nislVLHHNdwk6C+0ER879WlcCHwD3QURPy53CEYglwR0pXVigQxTXBNkpwp3k4dsoY
         adVzNp2PWUnXHOo+j5cS2T4b+a0PZi8sL1EpH7X5nYaNGvH/MYR5D/PG9BXuhzh0sKN3
         9kKVLl7tvhgT7fnKdzREmFtsPvtME/TeMVZjoaUxw6hKh9PXkviJHjBMydCtZBaaLLS4
         tSZ6gUgxZV80ytXd1rrwf5qYZJ0zPLjy3PO5pSVNJwLBmhlP5MTsRazEGrD13F7O+/8F
         ivpTl89memeAOPEzfAK2/XTKVW0ZShx4wz3lXdXe1J5pynamtortxD2DiyiUo7G7Q0pI
         spiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O7Px77fXQ/tKc+ndRFpADgatrNr3n7PhTB3o/AK/mpg=;
        b=zAJ7bCBhF7hTfCjQ6crA7UZmokNSmOU1UNY2ODyz3sp0sfrFJnxpOKVVP4QTozDiDz
         +tYCoJg2k0/AWMmN+Gz61HJmskcuKDCnjbFPDN1j+FTWOkZVI3uyqJzA7g8s5/Gdlrto
         UtjRsMbLImrXM+Y0kjXTFr1jM6zYX7rgRyz0uQdA7RenDIzYQS2PeL/lPBg+oQOTFDsp
         XFThbSv8MXrquY8N8HmasSMZw4UPfBayjC3fVmcyWKHBUK46VMdWolMWsA0Ns+b25SJB
         ZUXpeX+rHPDoExkl5BHXRnjeXcski+WXQ1f3d1iYeS1740FaRkcubwRG8Jp9egzAiZxV
         mzMg==
X-Gm-Message-State: AOAM531/ucVxXM0hVzJ3UeJDFZp/E/tM+T9MruRLOfg3NtGmssiAnlUQ
        uPnqAB/kPPQnnWiI+XFDNFpz0BYjN2DGOA==
X-Google-Smtp-Source: ABdhPJxejYFBJ+H7X91ljslrKsu3j7EYYv3LaZsDSKryRjWkRbVGsEX5v4h6yLT0lEhWo8736sSQdA==
X-Received: by 2002:adf:ef86:0:b0:203:f8f5:efab with SMTP id d6-20020adfef86000000b00203f8f5efabmr1554174wro.671.1648067565120;
        Wed, 23 Mar 2022 13:32:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:44 -0700 (PDT)
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
Subject: [PATCH v2 21/27] revisions API: have release_revisions() release "prune_data"
Date:   Wed, 23 Mar 2022 21:32:11 +0100
Message-Id: <patch-v2-21.27-f98d473f08e-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the the release_revisions() function so that it frees the
"prune_data" in the "struct ref_info". This means that any code that
calls "release_revisions()" already can get rid of adjacent calls to
clear_pathspec().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 add-interactive.c | 2 --
 builtin/add.c     | 1 -
 builtin/stash.c   | 2 --
 diff-lib.c        | 1 -
 revision.c        | 1 +
 wt-status.c       | 2 --
 6 files changed, 1 insertion(+), 8 deletions(-)

diff --git a/add-interactive.c b/add-interactive.c
index 54cdfc82017..6047e8f6489 100644
--- a/add-interactive.c
+++ b/add-interactive.c
@@ -568,8 +568,6 @@ static int get_modified_files(struct repository *r,
 			run_diff_files(&rev, 0);
 		}
 
-		if (ps)
-			clear_pathspec(&rev.prune_data);
 		release_revisions(&rev);
 	}
 	hashmap_clear_and_free(&s.file_map, struct pathname_entry, ent);
diff --git a/builtin/add.c b/builtin/add.c
index 115a26ea633..fc729e14c17 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -142,7 +142,6 @@ int add_files_to_cache(const char *prefix,
 	rev.diffopt.flags.override_submodule_config = 1;
 	rev.max_count = 0; /* do not compare unmerged paths with stage #2 */
 	run_diff_files(&rev, DIFF_RACY_IS_MODIFIED);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return !!data.add_errors;
 }
diff --git a/builtin/stash.c b/builtin/stash.c
index 878eaf2e125..ac83d7f8af4 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1060,7 +1060,6 @@ static int check_changes_tracked_files(const struct pathspec *ps)
 	}
 
 done:
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	return ret;
 }
@@ -1272,7 +1271,6 @@ static int stash_working_tree(struct stash_info *info, const struct pathspec *ps
 
 done:
 	discard_index(&istate);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 	strbuf_release(&diff_output);
 	remove_path(stash_index_path.buf);
diff --git a/diff-lib.c b/diff-lib.c
index 0f16281253f..298265e5b54 100644
--- a/diff-lib.c
+++ b/diff-lib.c
@@ -641,7 +641,6 @@ int do_diff_cache(const struct object_id *tree_oid, struct diff_options *opt)
 
 	if (diff_cache(&revs, tree_oid, NULL, 1))
 		exit(128);
-	clear_pathspec(&revs.prune_data);
 	release_revisions(&revs);
 	return 0;
 }
diff --git a/revision.c b/revision.c
index eefb188d05e..0f9ded78f5b 100644
--- a/revision.c
+++ b/revision.c
@@ -2960,6 +2960,7 @@ void release_revisions(struct rev_info *revs)
 	object_array_clear(&revs->pending);
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
+	clear_pathspec(&revs->prune_data);
 	release_revisions_mailmap(revs->mailmap);
 	free_grep_patterns(&revs->grep_filter);
 }
diff --git a/wt-status.c b/wt-status.c
index a14fad1e03a..61e0c1022f5 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -616,7 +616,6 @@ static void wt_status_collect_changes_worktree(struct wt_status *s)
 	rev.diffopt.rename_score = s->rename_score >= 0 ? s->rename_score : rev.diffopt.rename_score;
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_files(&rev, 0);
-	clear_pathspec(&rev.prune_data);
 	release_revisions(&rev);
 }
 
@@ -664,7 +663,6 @@ static void wt_status_collect_changes_index(struct wt_status *s)
 	copy_pathspec(&rev.prune_data, &s->pathspec);
 	run_diff_index(&rev, 1);
 	release_revisions(&rev);
-	clear_pathspec(&rev.prune_data);
 }
 
 static int add_file_to_list(const struct object_id *oid,
-- 
2.35.1.1452.ga7cfc89151f

