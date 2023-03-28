Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 052BEC76196
	for <git@archiver.kernel.org>; Tue, 28 Mar 2023 13:59:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232838AbjC1N7P (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Mar 2023 09:59:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjC1N7N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2023 09:59:13 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E3A13E
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:12 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id s13so7004341wmr.4
        for <git@vger.kernel.org>; Tue, 28 Mar 2023 06:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680011950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MdO/p0lSJqT0FHnrc8vFv6NqmCwZMQsBluyzssOfWtw=;
        b=kP0gcfLBvYQp2+ydf3YhmGXttFMOEHzGVw1h4cuw1H6YhfxeEQjngioWO9/HYeY20k
         /64POiYJ7q1K8/ZgexPxBvJg0vzN+CtHBb/vQBn/nWMpjWzRHqMPeeFFuY+ZvmzUi/g+
         YHg+9tl9jm34CG+5202K+3TLJxNPorNa4efIe2//Xky8cN95TINTdeeY0ZsZGlMokTWg
         qWP/CaC1q24LDYip13EWNRfPghmJpuwPY4NFVvzHFIxOteseir3ygcafx19LVETYyfBR
         0DHdFKFt2NeXIy9zJARVf9WLJYlgk20b/klbSvmM3tSAz+RoYhG+fPkwwu0IajdRwwmI
         3gnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680011950;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MdO/p0lSJqT0FHnrc8vFv6NqmCwZMQsBluyzssOfWtw=;
        b=WMcGkZZFRu+Yvji8sasUFgBswrrr+aBLy5mI7r2ozYUz3YNCuyfjb3Z02901XC4EAZ
         SCp8Ajje1nXI2pVs0EKxNzfhGp5O6m40paYOfR8LeaJQAFCRNdM2QfEDyzZoMmAWhtun
         Cp1RW81XXMqda5VbrBNWNcCRh5+GBiTMGlEgmQot2sVi5Hm5I4elenC30MXzAwh9kpKE
         22Y0mH5r7acJ5ejx2ya61fbbQlazb7p8ZmtaNRmkAyaeIgNryYnIhQHUiLEnQWstPbXu
         BlmteH/gylSjLBGWTi/wVVP/I1cKDq1S70UlYGX+ZH8yMqpmF2nrxQaJ4GF6xcEWKcZ3
         rH7Q==
X-Gm-Message-State: AO0yUKUl1A/PgwnnSvjnmsEG8Oqa0mNxSEjTcBl9EwUxFAqcYwe0PetZ
        KyuLZDXwOYfTzH2Q9Ttim31MGKkBNF4HhQ==
X-Google-Smtp-Source: AK7set898DAwdkE70/aFP0cuxHfxK3i3RfJOMZkG2zoOCc3K1vbHz+BsP3MVKr0CbLXSOLIokRnoyA==
X-Received: by 2002:a7b:ce8a:0:b0:3ea:d620:570a with SMTP id q10-20020a7bce8a000000b003ead620570amr12425929wmj.38.1680011949876;
        Tue, 28 Mar 2023 06:59:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q7-20020a05600c46c700b003ede2c59a54sm6252268wmo.37.2023.03.28.06.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Mar 2023 06:59:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/17] cocci: remove "the_repository" wrapper macros
Date:   Tue, 28 Mar 2023 15:58:41 +0200
Message-Id: <cover-v2-00.17-00000000000-20230328T110946Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v2 of the removal of "the_repository" wrapper macros and adjacent
cleanups. The v1 subject for this said "the_index", sorry!

See v1 [1] for a more general overview. The changes since v1 are
trivial & best skimmed from the range-diff, just a rebasing,
clarification in a commit message, and a typo fix, thanks all!

As before this has a trivial conflict with "seen", but this time
around the conflict is different, but it's trivially solved as before,
the remerge-diff was:
	
	diff --git a/cache.h b/cache.h
	remerge CONFLICT (content): Merge conflict in cache.h
	index 25e002c488b..82d7b112b4e 100644
	--- a/cache.h
	+++ b/cache.h
	@@ -711,31 +711,6 @@ extern int quote_path_fully;
	  */
	 const char *repo_find_unique_abbrev(struct repository *r, const struct object_id *oid, int len);
	 int repo_find_unique_abbrev_r(struct repository *r, char *hex, const struct object_id *oid, int len);
	-<<<<<<< 9f4013b4b9d (libs: use "struct repository *" argument, not "the_repository")
	-
	-/* set default permissions by passing mode arguments to open(2) */
	-int git_mkstemps_mode(char *pattern, int suffix_len, int mode);
	-int git_mkstemp_mode(char *pattern, int mode);
	-
	-/*
	- * NOTE NOTE NOTE!!
	- *
	- * PERM_UMASK, OLD_PERM_GROUP and OLD_PERM_EVERYBODY enumerations must
	- * not be changed. Old repositories have core.sharedrepository written in
	- * numeric format, and therefore these values are preserved for compatibility
	- * reasons.
	- */
	-enum sharedrepo {
	-	PERM_UMASK          = 0,
	-	OLD_PERM_GROUP      = 1,
	-	OLD_PERM_EVERYBODY  = 2,
	-	PERM_GROUP          = 0660,
	-	PERM_EVERYBODY      = 0664
	-};
	-int git_config_perm(const char *var, const char *value);
	-int adjust_shared_perm(const char *path);
	-=======
	->>>>>>> 2bb680d6bbd (Merge branch 'kh/commentchar-config-error-message' into seen)
	 
	 /*
	  * Create the directory containing the named path, using care to be
	@@ -925,11 +900,6 @@ int repo_interpret_branch_name(struct repository *r,
	 			       const char *str, int len,
	 			       struct strbuf *buf,
	 			       const struct interpret_branch_name_options *options);
	-<<<<<<< 9f4013b4b9d (libs: use "struct repository *" argument, not "the_repository")
	-
	-int validate_headref(const char *ref);
	-=======
	->>>>>>> 2bb680d6bbd (Merge branch 'kh/commentchar-config-error-message' into seen)
	 
	 int base_name_compare(const char *name1, size_t len1, int mode1,
	 		      const char *name2, size_t len2, int mode2);
Branch & CI for this at:
https://github.com/avar/git/tree/avar/cocci-the-repository-from-pending-2

1. https://lore.kernel.org/git/cover-00.17-00000000000-20230317T152724Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (17):
  cocci: remove dead rule from "the_repository.pending.cocci"
  cocci: fix incorrect & verbose "the_repository" rules
  cocci: sort "the_repository" rules by header
  cocci: add missing "the_repository" macros to "pending"
  cocci: apply the "cache.h" part of "the_repository.pending"
  cocci: apply the "commit-reach.h" part of "the_repository.pending"
  cocci: apply the "commit.h" part of "the_repository.pending"
  cocci: apply the "diff.h" part of "the_repository.pending"
  cocci: apply the "object-store.h" part of "the_repository.pending"
  cocci: apply the "pretty.h" part of "the_repository.pending"
  cocci: apply the "packfile.h" part of "the_repository.pending"
  cocci: apply the "promisor-remote.h" part of "the_repository.pending"
  cocci: apply the "refs.h" part of "the_repository.pending"
  cocci: apply the "rerere.h" part of "the_repository.pending"
  cocci: apply the "revision.h" part of "the_repository.pending"
  post-cocci: adjust comments for recent repo_* migration
  libs: use "struct repository *" argument, not "the_repository"

 add-interactive.c                             |   2 +-
 add-patch.c                                   |   2 +-
 apply.c                                       |  13 +-
 archive.c                                     |  12 +-
 bisect.c                                      |  11 +-
 blame.c                                       |  15 +-
 branch.c                                      |   7 +-
 builtin/am.c                                  |  23 +--
 builtin/bisect.c                              |  33 ++--
 builtin/blame.c                               |  15 +-
 builtin/branch.c                              |   9 +-
 builtin/cat-file.c                            |  25 +--
 builtin/checkout.c                            |  35 ++--
 builtin/clone.c                               |   6 +-
 builtin/commit-tree.c                         |   4 +-
 builtin/commit.c                              |  29 ++--
 builtin/describe.c                            |   9 +-
 builtin/diff.c                                |   3 +-
 builtin/difftool.c                            |   3 +-
 builtin/fast-export.c                         |  12 +-
 builtin/fast-import.c                         |  17 +-
 builtin/fetch.c                               |  21 +--
 builtin/fsck.c                                |   2 +-
 builtin/gc.c                                  |   8 +-
 builtin/grep.c                                |   6 +-
 builtin/index-pack.c                          |  11 +-
 builtin/log.c                                 |  30 ++--
 builtin/ls-files.c                            |   4 +-
 builtin/ls-tree.c                             |   9 +-
 builtin/merge-base.c                          |   9 +-
 builtin/merge-recursive.c                     |   6 +-
 builtin/merge-tree.c                          |  18 ++-
 builtin/merge.c                               |  23 +--
 builtin/mktag.c                               |   3 +-
 builtin/name-rev.c                            |  11 +-
 builtin/notes.c                               |  34 ++--
 builtin/pack-objects.c                        |  24 ++-
 builtin/prune.c                               |   2 +-
 builtin/pull.c                                |   4 +-
 builtin/range-diff.c                          |  12 +-
 builtin/read-tree.c                           |   2 +-
 builtin/rebase.c                              |  21 +--
 builtin/receive-pack.c                        |  14 +-
 builtin/remote.c                              |   2 +-
 builtin/repack.c                              |   2 +-
 builtin/replace.c                             |  20 +--
 builtin/reset.c                               |  22 +--
 builtin/rev-list.c                            |   2 +-
 builtin/rev-parse.c                           |  18 ++-
 builtin/rm.c                                  |   2 +-
 builtin/shortlog.c                            |  13 +-
 builtin/show-branch.c                         |  19 +--
 builtin/show-ref.c                            |   6 +-
 builtin/sparse-checkout.c                     |   2 +-
 builtin/stash.c                               |  26 +--
 builtin/submodule--helper.c                   |   6 +-
 builtin/tag.c                                 |  10 +-
 builtin/unpack-file.c                         |   4 +-
 builtin/unpack-objects.c                      |   5 +-
 builtin/update-ref.c                          |   8 +-
 builtin/verify-commit.c                       |   2 +-
 builtin/verify-tag.c                          |   2 +-
 builtin/worktree.c                            |   8 +-
 bulk-checkin.c                                |   2 +-
 bundle.c                                      |   5 +-
 cache-tree.c                                  |  16 +-
 cache.h                                       |  19 +--
 checkout.c                                    |   2 +-
 combine-diff.c                                |   8 +-
 commit-graph.c                                |   4 +-
 commit-reach.c                                |  21 +--
 commit-reach.h                                |   9 --
 commit.c                                      |  44 ++---
 commit.h                                      |  22 +--
 connected.c                                   |   4 +-
 contrib/coccinelle/the_repository.cocci       | 123 ++++++++++++++
 .../coccinelle/the_repository.pending.cocci   | 128 ---------------
 delta-islands.c                               |   5 +-
 diff-lib.c                                    |   2 +-
 diff.c                                        |   6 +-
 diff.h                                        |   5 +-
 diffcore-break.c                              |   2 +-
 diffcore-rename.c                             |   4 +-
 dir.c                                         |   2 +-
 entry.c                                       |   3 +-
 fetch-pack.c                                  |   8 +-
 fmt-merge-msg.c                               |  15 +-
 fsck.c                                        |   6 +-
 http-push.c                                   |  16 +-
 http-walker.c                                 |   4 +-
 list-objects-filter-options.c                 |   7 +-
 list-objects.c                                |  20 ++-
 log-tree.c                                    |  28 ++--
 mailmap.c                                     |   4 +-
 match-trees.c                                 |   4 +-
 merge-blobs.c                                 |   6 +-
 merge-ort.c                                   |   6 +-
 merge-recursive.c                             |   9 +-
 negotiator/default.c                          |   6 +-
 negotiator/skipping.c                         |   2 +-
 notes-cache.c                                 |   5 +-
 notes-merge.c                                 |  11 +-
 notes-utils.c                                 |   2 +-
 notes.c                                       |  18 ++-
 object-file.c                                 |   4 +-
 object-name.c                                 |  19 ++-
 object-store.h                                |  11 +-
 pack-bitmap-write.c                           |   3 +-
 packfile.c                                    |   2 +-
 packfile.h                                    |   1 -
 parse-options-cb.c                            |   8 +-
 pretty.c                                      |  10 +-
 pretty.h                                      |   4 -
 promisor-remote.h                             |  15 --
 range-diff.c                                  |  12 +-
 read-cache.c                                  |   9 +-
 rebase-interactive.c                          |   2 +-
 ref-filter.c                                  |   8 +-
 reflog.c                                      |   7 +-
 refs.c                                        |   2 +-
 refs.h                                        |   6 -
 remote.c                                      |  15 +-
 rerere.c                                      |   5 +-
 rerere.h                                      |   3 -
 reset.c                                       |   4 +-
 revision.c                                    |  27 ++--
 revision.h                                    |   3 -
 send-pack.c                                   |   6 +-
 sequencer.c                                   | 150 ++++++++++--------
 shallow.c                                     |  21 +--
 strbuf.h                                      |   6 +-
 submodule-config.c                            |   5 +-
 submodule.c                                   |   8 +-
 t/helper/test-fast-rebase.c                   |  19 ++-
 t/helper/test-match-trees.c                   |   4 +-
 t/helper/test-oidmap.c                        |   6 +-
 t/helper/test-reach.c                         |  12 +-
 t/helper/test-revision-walking.c              |   3 +-
 t/helper/test-submodule-config.c              |   2 +-
 tag.c                                         |   9 +-
 transport-helper.c                            |   2 +-
 transport.c                                   |   3 +-
 tree.c                                        |   5 +-
 unpack-trees.c                                |   2 +-
 upload-pack.c                                 |   8 +-
 walker.c                                      |   6 +-
 wt-status.c                                   |  21 +--
 xdiff-interface.c                             |   2 +-
 148 files changed, 958 insertions(+), 873 deletions(-)
 create mode 100644 contrib/coccinelle/the_repository.cocci
 delete mode 100644 contrib/coccinelle/the_repository.pending.cocci

Range-diff against v1:
 1:  c167bde3c0c !  1:  e1e27490d60 cocci: remove dead rule from "the_repository.pending.cocci"
    @@ Commit message
         cocci: remove dead rule from "the_repository.pending.cocci"
     
         The "parse_commit_gently" macro went away in [1], so we don't need to
    -    carry his for its migration.
    +    carry this for its migration.
     
         1. ea3f7e598c8 (revision: use repository from rev_info when parsing
            commits, 2020-06-23)
 2:  1b1fc5d41f5 =  2:  5ac9d5b8905 cocci: fix incorrect & verbose "the_repository" rules
 3:  34c6b8afd6c !  3:  a3fcd19d744 cocci: sort "the_repository" rules by header
    @@ Commit message
         rules. This will make subsequent commits easier to follow, as we'll be
         applying these rules on a header-by-header basis.
     
    +    Once we've fully applied "the_repository.pending.cocci" we'll keep
    +    this rules around for a while in "the_repository.cocci", to help any
    +    outstanding topics and out-of-tree code to resolve textual or semantic
    +    conflicts with these changes, but eventually we'll remove the
    +    "the_repository.cocci" as a follow-up.
    +
    +    So even if some of these functions are subsequently moved and/or split
    +    into other or new headers there's no risk of this becoming stale, if
    +    and when that happens the we should be removing these rules anyway.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## contrib/coccinelle/the_repository.pending.cocci ##
 4:  4b62e9a35a9 =  4:  af8bdc2adec cocci: add missing "the_repository" macros to "pending"
 5:  36eae891341 !  5:  3e721fa5db0 cocci: apply the "cache.h" part of "the_repository.pending"
    @@ cache.h: void *read_object_with_reference(struct repository *r,
     -#define peel_to_type(name, namelen, obj, type) \
     -	repo_peel_to_type(the_repository, name, namelen, obj, type)
      
    - #define IDENT_STRICT	       1
    - #define IDENT_NO_DATE	       2
    + const char *git_editor(void);
    + const char *git_sequence_editor(void);
     
      ## checkout.c ##
     @@ checkout.c: static int check_tracking_name(struct remote *remote, void *cb_data)
 6:  b06ea9861fd =  6:  0f24a57b50b cocci: apply the "commit-reach.h" part of "the_repository.pending"
 7:  2e9cf3ca378 !  7:  7d64ace3551 cocci: apply the "commit.h" part of "the_repository.pending"
    @@ commit.h: void repo_unuse_commit_buffer(struct repository *r,
      
      /*
     @@ commit.h: void free_commit_list(struct commit_list *list);
    + 
      struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
      
    - int has_non_ascii(const char *text);
     -const char *logmsg_reencode(const struct commit *commit,
     -			    char **commit_encoding,
     -			    const char *output_encoding);
 8:  6c5f4861471 =  8:  f442e7b9acc cocci: apply the "diff.h" part of "the_repository.pending"
 9:  893684f135b =  9:  1866d473f1b cocci: apply the "object-store.h" part of "the_repository.pending"
10:  c4bf81a2892 = 10:  10e05c56231 cocci: apply the "pretty.h" part of "the_repository.pending"
11:  8cfc1c18878 = 11:  13955394126 cocci: apply the "packfile.h" part of "the_repository.pending"
12:  abd237009f9 = 12:  8336b0321a8 cocci: apply the "promisor-remote.h" part of "the_repository.pending"
13:  aae743233ab = 13:  a08d7f8eccf cocci: apply the "refs.h" part of "the_repository.pending"
14:  fb281b1ecdd = 14:  3d59dfe4186 cocci: apply the "rerere.h" part of "the_repository.pending"
15:  c8ff241844a = 15:  b7561c87ba5 cocci: apply the "revision.h" part of "the_repository.pending"
16:  86e24add191 = 16:  f947bb69dee post-cocci: adjust comments for recent repo_* migration
17:  6f86a34bf8b = 17:  9f4013b4b9d libs: use "struct repository *" argument, not "the_repository"
-- 
2.40.0.rc1.1034.g5867a1b10c5

