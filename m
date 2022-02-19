Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 812AEC433F5
	for <git@archiver.kernel.org>; Sat, 19 Feb 2022 16:44:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242660AbiBSQpK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 19 Feb 2022 11:45:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:58476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236675AbiBSQpI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 19 Feb 2022 11:45:08 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B155F4DD
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:48 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id k1so19647831wrd.8
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 08:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JSZkH8spsd3eOj9Hd2Qm1nhM4qLmUd5kviFpi7XUFrI=;
        b=B6Se/66XGNI+RfxCr2FLR9Ja6PvApFw4F3+3N7e7w5pskXWv2/sjMla2f/kfEvcrXS
         izq8sF4r3ErFk4s0EkF7/ZUGHEj2vRqCcvl+hFcqpeynBeQU42HTlIZXkVovhrugbKVK
         hm+2gwIzPvXlSrrLsK5VB20iyw0bjdn+2tfPphtSoNE6W6t1FRpaUigHYL2ct/gdshoe
         eJmtDLtJvNPl2Cw5Lt2hDSkRu2na/hpn+GXNEe8NujzUMrH9+/ndHT6zLF4cfuhqtpJC
         LjQtwUm0srZ0hU0QpdEOx8smepuyT6XLomth0FKN76a9Ksqy2+HBS/oPCQxtcwQViXkr
         GmUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JSZkH8spsd3eOj9Hd2Qm1nhM4qLmUd5kviFpi7XUFrI=;
        b=V9MTU+F+W6QLCIXFDsyeT/BUwKluRpztlfC2aWSz9aSPD8BMh8Fawbyv5AMCY1rH8G
         HPlscOvKi23kAN+VAU6KyBr0JRFZsdRhSfv/e3IpseJ9qkHlP6ehn7TaF2kR/k+s4Quo
         VSHD/txZziR85AsaeiTsE1zh3ir5HWtHDIlzDvcFHoJE28X3rViDqNJVx7pw9FDsjUzq
         eLf2uiPXgSKpeKDLxC3o0/3hsh2PTLNq0G/j2BtAbzonAl58kZzMFRIx5e14bCLC1Tfr
         E+/n9LiZq2xYX8tshj8QhJLXKgClVkp9THRKazm4pn3jUE48FmNSIUDOI1VVfFca5xVK
         cBjg==
X-Gm-Message-State: AOAM533oCWdQRuQ867tbr+NSuij1Rr6gy5LTSwp6ZxT550K/rlRUipC2
        MCpU9pvzRSxWQRp6LqVdHUXBi2pTmjc=
X-Google-Smtp-Source: ABdhPJxrvUa0/l/Msob/Yi+GB0bw7c3zM4alGgai110DUvZarjbQZaNRxjenLcCtOlKSxBMhmY8egg==
X-Received: by 2002:a5d:6da8:0:b0:1e3:3e4c:24a7 with SMTP id u8-20020a5d6da8000000b001e33e4c24a7mr9811655wrs.673.1645289087070;
        Sat, 19 Feb 2022 08:44:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g10sm20670989wri.91.2022.02.19.08.44.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 08:44:46 -0800 (PST)
Message-Id: <pull.1118.v5.git.1645289086.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
References: <pull.1118.v4.git.1645080889.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 19 Feb 2022 16:44:40 +0000
Subject: [PATCH v5 0/5] sparse checkout: fix a few bugs and check argument validity for set/add
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

== Maintainer notes ==

Note: There is a small textual and small semantic conflict with
ds/sparse-checkout-requires-per-worktree-config in seen. I included the diff
with the correct resolution near the end of this cover letter. If you'd
prefer I rebased on top of ds/sparse-chckout-requires-per-worktree-config,
let me know.

== Overview ==

This series continues attempts to make sparse-checkouts more user friendly.
A quick overview:

 * Patches 1-2 fix existing bugs from en/sparse-checkout-set (i.e. in
   v2.35.0)
 * Patch 3 fixes sparse-checkout-from-subdirectories-ignores-"prefix" (see
   https://lore.kernel.org/git/29f0410e-6dfa-2e86-394d-b1fb735e7608@gmail.com/),
   in cone mode. Since we'll get nasty surprises whether we use or don't use
   "prefix" for non-cone mode, simply throw an error if set/add subcommands
   of sparse-checkout are run from a subdirectory.
 * Patches 4-5 check positional arguments to set/add and provide
   errors/warnings for very likely mistakes. It also adds a --skip-checks
   flag for overridding in case you have a very unusual situation.

== Update history ==

Changes since v4:

 * have --skip-checks enable running from a subdirectory in non-cone mode
 * make sure new die() messages are marked for translation (and using single
   quotes instead of double)

Changes since v3:

 * Use strpbrk() instead of multiple strchr(), fix commit message relative
   to backslashes.

Changes since v2:

 * Dropped patch 5
 * Added Stolee's Reviewed-by

Changes since v1:

 * Dropped the commit changing cone-mode to default (patch 7, which will be
   split into multiple patches and submitted as a separate series)
 * Removed the RFC label
 * Decided to error out when running set/add with paths from a subdirectory
   in non-cone mode, and added tests
 * Changed the warning for non-cone mode with individual files to point out
   that the user is likely trying to select an individual file, but should
   likely add a leading slash to ensure that is what happens
 * Fixed typos, removed unnecessary condition checks

== Conflict resolution ==

Patch to resolve textual and semantic conflict with
ds/sparse-checkout-requires-per-worktree-config:

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
remerge CONFLICT (content): Merge conflict in t/t1091-sparse-checkout-builtin.sh
index 3c6adeb885..3a95d2996d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -275,24 +275,8 @@ test_expect_success 'sparse-index enabled and disabled' '
     diff -u sparse full | tail -n +3 >actual &&
     test_cmp expect actual &&
 
-<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<< 286c22e5ec (sparse-checkout: reject arguments in cone-mode that look like patterns)
     git -C repo config --list >config &&
-    ! grep index.sparse config
-|||||||||||||||||||||||||||||||| 89bece5c8c
-        diff -u sparse full | tail -n +3 >actual &&
-        test_cmp expect actual &&
-
-        git -C repo config --list >config &&
-        ! grep index.sparse config
-    )
-================================
-        diff -u sparse full | tail -n +3 >actual &&
-        test_cmp expect actual &&
-
-        git -C repo config --list >config &&
-        test_cmp_config -C repo false index.sparse
-    )
->>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>> 3ce1138272 (config: make git_configset_get_string_tmp() private)
+    test_cmp_config -C repo false index.sparse
 '
 
 test_expect_success 'cone mode: init and set' '
@@ -532,6 +516,7 @@ test_expect_success 'reapply can handle config options' '
     cat >expect <<-\EOF &&
     core.sparsecheckout=true
     core.sparsecheckoutcone=true
+    index.sparse=false
     EOF
     test_cmp expect actual &&
 
@@ -539,6 +524,8 @@ test_expect_success 'reapply can handle config options' '
     git -C repo config --worktree --list >actual &&
     cat >expect <<-\EOF &&
     core.sparsecheckout=true
+    core.sparsecheckoutcone=false
+    index.sparse=false
     EOF
     test_cmp expect actual &&


== CCs ==

Elijah Newren (5):
  sparse-checkout: correct reapply's handling of options
  sparse-checkout: correctly set non-cone mode when expected
  sparse-checkout: pay attention to prefix for {set, add}
  sparse-checkout: error or warn when given individual files
  sparse-checkout: reject arguments in cone-mode that look like patterns

 builtin/sparse-checkout.c          | 78 +++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 87 +++++++++++++++++++++++++++++-
 2 files changed, 158 insertions(+), 7 deletions(-)


base-commit: b80121027d1247a0754b3cc46897fee75c050b44
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1118%2Fnewren%2Fsparse-checkout-default-and-arg-validity-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1118/newren/sparse-checkout-default-and-arg-validity-v5
Pull-Request: https://github.com/gitgitgadget/git/pull/1118

Range-diff vs v4:

 1:  5215b7f7179 = 1:  5215b7f7179 sparse-checkout: correct reapply's handling of options
 2:  0c2ab523e74 = 2:  0c2ab523e74 sparse-checkout: correctly set non-cone mode when expected
 3:  e68b0a37ff3 ! 3:  06cf71bfca4 sparse-checkout: pay attention to prefix for {set, add}
     @@ builtin/sparse-checkout.c: static int modify_pattern_list(int argc, const char *
      +	if (!argc)
      +		return;
      +
     -+	if (prefix && *prefix) {
     ++	if (prefix && *prefix && core_sparse_checkout_cone) {
      +		/*
      +		 * The args are not pathspecs, so unfortunately we
      +		 * cannot imitate how cmd_add() uses parse_pathspec().
     @@ builtin/sparse-checkout.c: static int modify_pattern_list(int argc, const char *
      +		int i;
      +		int prefix_len = strlen(prefix);
      +
     -+		if (!core_sparse_checkout_cone)
     -+			die("please run from the toplevel directory in non-cone mode");
     -+
      +		for (i = 0; i < argc; i++)
      +			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
      +	}
     ++
     ++	if (prefix && *prefix && !core_sparse_checkout_cone)
     ++		die(_("please run from the toplevel directory in non-cone mode"));
     ++
      +}
      +
       static char const * const builtin_sparse_checkout_add_usage[] = {
 4:  1fdebc1953f ! 4:  78bf6016687 sparse-checkout: error or warn when given individual files
     @@ Commit message
          in any directory.  Thus users will likely want to prefix any paths they
          specify with a leading '/' character; warn users if the patterns they
          specify exactly name a file because it means they are likely missing
     -    such a missing leading slash.
     +    such a leading slash.
      
          Reviewed-by: Derrick Stolee <derrickstolee@github.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
      -		int i;
       		int prefix_len = strlen(prefix);
       
     - 		if (!core_sparse_checkout_cone)
     -@@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **argv, const char *prefix)
       		for (i = 0; i < argc; i++)
       			argv[i] = prefix_path(prefix, prefix_len, argv[i]);
       	}
     -+
     + 
      +	if (skip_checks)
      +		return;
      +
     + 	if (prefix && *prefix && !core_sparse_checkout_cone)
     + 		die(_("please run from the toplevel directory in non-cone mode"));
     + 
      +	for (i = 0; i < argc; i++) {
      +		struct cache_entry *ce;
      +		struct index_state *index = the_repository->index;
     @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **arg
      +			continue;
      +
      +		if (core_sparse_checkout_cone)
     -+			die(_("\"%s\" is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
     ++			die(_("'%s' is not a directory; to treat it as a directory anyway, rerun with --skip-checks"), argv[i]);
      +		else
     -+			warning(_("pass a leading slash before paths such as \"%s\" if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
     ++			warning(_("pass a leading slash before paths such as '%s' if you want a single file (see NON-CONE PROBLEMS in the git-sparse-checkout manual)."), argv[i]);
      +	}
       }
       
 5:  d68682c25c4 ! 5:  53183d07502 sparse-checkout: reject arguments in cone-mode that look like patterns
     @@ Commit message
      
       ## builtin/sparse-checkout.c ##
      @@ builtin/sparse-checkout.c: static void sanitize_paths(int argc, const char **argv,
     - 	if (skip_checks)
     - 		return;
     + 	if (prefix && *prefix && !core_sparse_checkout_cone)
     + 		die(_("please run from the toplevel directory in non-cone mode"));
       
      +	if (core_sparse_checkout_cone) {
      +		for (i = 0; i < argc; i++) {

-- 
gitgitgadget
