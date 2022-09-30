Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D5F9C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 18:10:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbiI3SKC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 14:10:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232211AbiI3SJB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 14:09:01 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E87B51E5558
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id ay36so3415057wmb.0
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 11:08:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Wmly40VpupFZUaOrFo1PufDJpPrEM7Y9smZU3q82L7o=;
        b=MRsPFBvYbgoAuY+EyUIYlWRhA8VyKoKyoRdudHb6lVL4qU6MQu8fINeoxdEL92lKey
         ZESlYY8q1eknykXhfOqlE76IRWhFscqJYuFQ0i3hJjDw5swwXW+8IlUEJpUwZhGM9NMJ
         u9mHEv2BdX2J9tU55so0jyTraLNzwRkemzxzEY+fl6LC0Wu0I3QJWb+U2DDmHaZMRjHi
         ERD41xLFveUil0UsiCqNk9RGKPJlwYWqnwCT/RvaYtlKQxpERnuujPF3OxlzyGSPBiBh
         zkZAC2wMTEgVi5NqRfRgi/FMaHTZJdlDu3DpE1OLNzraGIErOKBmB7G9Euh/BywCA/5W
         gabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Wmly40VpupFZUaOrFo1PufDJpPrEM7Y9smZU3q82L7o=;
        b=E+Fzl3jrWL17XIBEdXrbsiLg3UCS1EdId0R/qlEZ37Xws08uWCOxLiqiBs1C/D2sG1
         CAgsfi5u8/evMiNrEIt8Z8r5ipnSxkAAsugpS5x4Mqnsc+PNSXYVCcrEy197OZIllnQu
         L6h9SJGrx2umoobxiiGihF8pF6k6GaLlL0hQvPT2eBRhPASOgmOFujWFkGTUPg7FBMdW
         JcY8sRnldhLJLM8jwegB+3BfUedj8zvDFa++JQcVAmJZhRUXra4MyOMpKRhv8gFoWAfZ
         QlWYid4c6LwSpqnXsH1zjWz7uQwDqRQ87YqC8qbfNYgeZlQabUGxKUL+xt1/1+so1kM8
         CYQA==
X-Gm-Message-State: ACrzQf2r8SXA6AN1mQCD4ALe5vNOWsEirWvN59576M2WW/1f8MGlRvvT
        Zy9UdhvMayW6JRIQR3CF4BppqjKA0/QOcA==
X-Google-Smtp-Source: AMsMyM7uzX0zwQp1Do+qoT42xPaqEACO5hBL9ji/CZoQkBxMFAsoUcScnEAZWcnr1TsGQ7KWxGXcaQ==
X-Received: by 2002:a05:600c:3781:b0:3a6:804a:afc with SMTP id o1-20020a05600c378100b003a6804a0afcmr14736631wmr.27.1664561333767;
        Fri, 30 Sep 2022 11:08:53 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h9-20020a1c2109000000b003b4fac020c8sm7102703wmh.16.2022.09.30.11.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 11:08:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/36] doc txt & -h consistency: correct padding around "[]()"
Date:   Fri, 30 Sep 2022 20:07:37 +0200
Message-Id: <patch-v3-14.36-a29af2dcc4f-20220930T180415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc2.935.g6b421ae1592
In-Reply-To: <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
References: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com> <cover-v3-00.36-00000000000-20220930T180414Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The whitespace padding of alternatives should be of the form "[-f |
--force]" not "[-f|--force]". Likewise we should not have padding
before the first option, so "(--all | <pack-filename>...)" is correct,
not "( --all | <pack-filename>... )".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-diff-files.txt     | 2 +-
 Documentation/git-hash-object.txt    | 2 +-
 Documentation/git-merge-base.txt     | 4 ++--
 Documentation/git-pack-redundant.txt | 2 +-
 Documentation/git-prune-packed.txt   | 2 +-
 Documentation/git-rerere.txt         | 2 +-
 Documentation/git-send-pack.txt      | 2 +-
 Documentation/git-show-branch.txt    | 4 ++--
 Documentation/git-show-ref.txt       | 4 ++--
 Documentation/git-var.txt            | 2 +-
 Documentation/git-verify-pack.txt    | 2 +-
 builtin/bugreport.c                  | 2 +-
 builtin/commit-graph.c               | 2 +-
 builtin/diagnose.c                   | 2 +-
 builtin/sparse-checkout.c            | 2 +-
 15 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-diff-files.txt b/Documentation/git-diff-files.txt
index bf1febb9ae7..591e3801b7b 100644
--- a/Documentation/git-diff-files.txt
+++ b/Documentation/git-diff-files.txt
@@ -9,7 +9,7 @@ git-diff-files - Compares files in the working tree and the index
 SYNOPSIS
 --------
 [verse]
-'git diff-files' [-q] [-0|-1|-2|-3|-c|--cc] [<common-diff-options>] [<path>...]
+'git diff-files' [-q] [-0 | -1 | -2 | -3 | -c | --cc] [<common-diff-options>] [<path>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-hash-object.txt b/Documentation/git-hash-object.txt
index 58670ef12f7..472b5bb995b 100644
--- a/Documentation/git-hash-object.txt
+++ b/Documentation/git-hash-object.txt
@@ -9,7 +9,7 @@ git-hash-object - Compute object ID and optionally creates a blob from a file
 SYNOPSIS
 --------
 [verse]
-'git hash-object' [-t <type>] [-w] [--path=<file>|--no-filters]
+'git hash-object' [-t <type>] [-w] [--path=<file> | --no-filters]
 		[--stdin [--literally]] [--] <file>...
 'git hash-object' [-t <type>] [-w] --stdin-paths [--no-filters]
 
diff --git a/Documentation/git-merge-base.txt b/Documentation/git-merge-base.txt
index 2d944e0851f..b01ba3d3565 100644
--- a/Documentation/git-merge-base.txt
+++ b/Documentation/git-merge-base.txt
@@ -9,8 +9,8 @@ git-merge-base - Find as good common ancestors as possible for a merge
 SYNOPSIS
 --------
 [verse]
-'git merge-base' [-a|--all] <commit> <commit>...
-'git merge-base' [-a|--all] --octopus <commit>...
+'git merge-base' [-a | --all] <commit> <commit>...
+'git merge-base' [-a | --all] --octopus <commit>...
 'git merge-base' --is-ancestor <commit> <commit>
 'git merge-base' --independent <commit>...
 'git merge-base' --fork-point <ref> [<commit>]
diff --git a/Documentation/git-pack-redundant.txt b/Documentation/git-pack-redundant.txt
index ee7034b5e52..dda80a740c8 100644
--- a/Documentation/git-pack-redundant.txt
+++ b/Documentation/git-pack-redundant.txt
@@ -9,7 +9,7 @@ git-pack-redundant - Find redundant pack files
 SYNOPSIS
 --------
 [verse]
-'git pack-redundant' [ --verbose ] [ --alt-odb ] ( --all | <pack-filename>... )
+'git pack-redundant' [--verbose] [--alt-odb] (--all | <pack-filename>...)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-prune-packed.txt b/Documentation/git-prune-packed.txt
index 9fed59a3172..844d6f808a0 100644
--- a/Documentation/git-prune-packed.txt
+++ b/Documentation/git-prune-packed.txt
@@ -9,7 +9,7 @@ git-prune-packed - Remove extra objects that are already in pack files
 SYNOPSIS
 --------
 [verse]
-'git prune-packed' [-n|--dry-run] [-q|--quiet]
+'git prune-packed' [-n | --dry-run] [-q | --quiet]
 
 
 DESCRIPTION
diff --git a/Documentation/git-rerere.txt b/Documentation/git-rerere.txt
index 4b613d4140c..9d0e6f53e7e 100644
--- a/Documentation/git-rerere.txt
+++ b/Documentation/git-rerere.txt
@@ -8,7 +8,7 @@ git-rerere - Reuse recorded resolution of conflicted merges
 SYNOPSIS
 --------
 [verse]
-'git rerere' [clear|forget <pathspec>|diff|remaining|status|gc]
+'git rerere' [clear | forget <pathspec> | diff | remaining | status | gc]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-send-pack.txt b/Documentation/git-send-pack.txt
index be41f119740..e0c71623432 100644
--- a/Documentation/git-send-pack.txt
+++ b/Documentation/git-send-pack.txt
@@ -11,7 +11,7 @@ SYNOPSIS
 [verse]
 'git send-pack' [--dry-run] [--force] [--receive-pack=<git-receive-pack>]
 		[--verbose] [--thin] [--atomic]
-		[--[no-]signed|--signed=(true|false|if-asked)]
+		[--[no-]signed | --signed=(true|false|if-asked)]
 		[<host>:]<directory> (--all | <ref>...)
 
 DESCRIPTION
diff --git a/Documentation/git-show-branch.txt b/Documentation/git-show-branch.txt
index e5ec6b467f9..71f608b1ff1 100644
--- a/Documentation/git-show-branch.txt
+++ b/Documentation/git-show-branch.txt
@@ -8,12 +8,12 @@ git-show-branch - Show branches and their commits
 SYNOPSIS
 --------
 [verse]
-'git show-branch' [-a|--all] [-r|--remotes] [--topo-order | --date-order]
+'git show-branch' [-a | --all] [-r | --remotes] [--topo-order | --date-order]
 		[--current] [--color[=<when>] | --no-color] [--sparse]
 		[--more=<n> | --list | --independent | --merge-base]
 		[--no-name | --sha1-name] [--topics]
 		[(<rev> | <glob>)...]
-'git show-branch' (-g|--reflog)[=<n>[,<base>]] [--list] [<ref>]
+'git show-branch' (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-ref.txt
index ab4d271925d..d1d56f68b43 100644
--- a/Documentation/git-show-ref.txt
+++ b/Documentation/git-show-ref.txt
@@ -8,8 +8,8 @@ git-show-ref - List references in a local repository
 SYNOPSIS
 --------
 [verse]
-'git show-ref' [-q|--quiet] [--verify] [--head] [-d|--dereference]
-	     [-s|--hash[=<n>]] [--abbrev[=<n>]] [--tags]
+'git show-ref' [-q | --quiet] [--verify] [--head] [-d | --dereference]
+	     [-s | --hash[=<n>]] [--abbrev[=<n>]] [--tags]
 	     [--heads] [--] [<pattern>...]
 'git show-ref' --exclude-existing[=<pattern>]
 
diff --git a/Documentation/git-var.txt b/Documentation/git-var.txt
index 387cc1b9142..6aa521fab23 100644
--- a/Documentation/git-var.txt
+++ b/Documentation/git-var.txt
@@ -9,7 +9,7 @@ git-var - Show a Git logical variable
 SYNOPSIS
 --------
 [verse]
-'git var' ( -l | <variable> )
+'git var' (-l | <variable>)
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-verify-pack.txt b/Documentation/git-verify-pack.txt
index 61ca6d04c20..b8720dce8ab 100644
--- a/Documentation/git-verify-pack.txt
+++ b/Documentation/git-verify-pack.txt
@@ -9,7 +9,7 @@ git-verify-pack - Validate packed Git archive files
 SYNOPSIS
 --------
 [verse]
-'git verify-pack' [-v|--verbose] [-s|--stat-only] [--] <pack>.idx ...
+'git verify-pack' [-v | --verbose] [-s | --stat-only] [--] <pack>.idx...
 
 
 DESCRIPTION
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index bb138161943..61d93383f51 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -60,7 +60,7 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [(-o|--output-directory) <file>] [(-s|--suffix) <format>]\n"
+	N_("git bugreport [(-o | --output-directory) <file>] [(-s | --suffix) <format>]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index cd346f95f08..13cbb75ca28 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -14,7 +14,7 @@
 
 #define BUILTIN_COMMIT_GRAPH_WRITE_USAGE \
 	N_("git commit-graph write [--object-dir <objdir>] [--append]\n" \
-	   "                       [--split[=<strategy>]] [--reachable|--stdin-packs|--stdin-commits]\n" \
+	   "                       [--split[=<strategy>]] [--reachable | --stdin-packs | --stdin-commits]\n" \
 	   "                       [--changed-paths] [--[no-]max-new-filters <n>] [--[no-]progress]\n" \
 	   "                       <split options>")
 
diff --git a/builtin/diagnose.c b/builtin/diagnose.c
index 474de9ec647..d52015c67a4 100644
--- a/builtin/diagnose.c
+++ b/builtin/diagnose.c
@@ -3,7 +3,7 @@
 #include "diagnose.h"
 
 static const char * const diagnose_usage[] = {
-	N_("git diagnose [(-o|--output-directory) <path>] [(-s|--suffix) <format>]\n"
+	N_("git diagnose [(-o | --output-directory) <path>] [(-s | --suffix) <format>]\n"
 	   "             [--mode=<mode>]"),
 	NULL
 };
diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 287716db68e..aac0f708e42 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -20,7 +20,7 @@
 static const char *empty_base = "";
 
 static char const * const builtin_sparse_checkout_usage[] = {
-	N_("git sparse-checkout (init|list|set|add|reapply|disable) <options>"),
+	N_("git sparse-checkout (init | list | set | add | reapply | disable) <options>"),
 	NULL
 };
 
-- 
2.38.0.rc2.935.g6b421ae1592

