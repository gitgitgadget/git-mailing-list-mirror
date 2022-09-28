Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 575EFC04A95
	for <git@archiver.kernel.org>; Wed, 28 Sep 2022 08:40:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbiI1Iko (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Sep 2022 04:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbiI1Ijy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Sep 2022 04:39:54 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D8D35A2DE
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r7so18658286wrm.2
        for <git@vger.kernel.org>; Wed, 28 Sep 2022 01:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=zNDJ8nTDlxJ7F2oj6cbKK1FrMd+4kNI56KABL0gHFxI=;
        b=SCmstlWAcXFix1Jl0CUjVPVO05dY97pjA46WzdAtkCnt/0Y5hdI0kPh6CyWqjQZuL8
         nl5Hpj6CVMuj/ASW7Lk+r8qxVfRx2SQ2Bynlq1ngT6XMUmHv43My4JBe8zFKdhUaPds5
         dkprB/c5QHDZFWbgqNsaA+7rAOuT4Kj/8vt07VVnjhqXCgx0+iM2cvx03ou9qaUaij2P
         M640I0G5w6sp5/0uIKP6j/AWN9GpMAaliJPaGEjqePqUYyjvJqMLbQLutfMN0YBMpMEK
         KBSgty19i0JSUkmXueCxRmWv7aI/19gZvlQU8ZhUX0zfUdgYOqkHd+yorfzsl7wOxvng
         C6Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=zNDJ8nTDlxJ7F2oj6cbKK1FrMd+4kNI56KABL0gHFxI=;
        b=nF6JNyMunIiYlTGGW55/CbLrxSYUzAhcnsmjO7loEibebn8bOVMsBRSDl8Lz56gXxr
         oTZvjls/4s32/+2PSdWgNVR5jTIVkTv6THxSa48+brXhdnpmINPPZmDt2Hp7ZDbdd77v
         ZwlTYSRz7jI50qqTrJEHJE8Zc0tutOLQPOd5rfpyIuKcwapbgqrhy3QOHDUOyqx7fMP1
         IcwL+OuHYmDOHtvgqxS6XSEjSPb7wOPw3cR8SsaORU51t9KvK0HCbqhteVprob4p/OLq
         Ep7HThBQ+fH382XDodwk1ICj8j8ejGp7ZuVUR3xobgbp3fWrcWKMUn5V0NPl/DC4+It6
         r6Ng==
X-Gm-Message-State: ACrzQf28eRnFYqrsWscyAsWvogDSdoZBjx9/dI7oK3HnVa5JfCyD9O/x
        RkO6ONG0PHu7fD+3nykK5GWapONu+N+jVQ==
X-Google-Smtp-Source: AMsMyM69ta6/nFlZ+DWow3zacstNGQrVHAcp9rySuKmnezML8r+yiW7NLdSXT1Nbqgc74XE8O4QM5w==
X-Received: by 2002:a05:6000:1d83:b0:22c:aa0a:12 with SMTP id bk3-20020a0560001d8300b0022caa0a0012mr8202087wrb.471.1664354389591;
        Wed, 28 Sep 2022 01:39:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 26-20020a05600c229a00b003b31fc77407sm1075026wmf.30.2022.09.28.01.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 01:39:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Victoria Dye <vdye@github.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 13/35] doc txt & -h consistency: correct padding around "[]()"
Date:   Wed, 28 Sep 2022 10:39:08 +0200
Message-Id: <patch-v2-13.35-5f421314536-20220928T082458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.rc1.925.gb61c5ccd7da
In-Reply-To: <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com> <cover-v2-00.35-00000000000-20220928T082458Z-avarab@gmail.com>
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
 Documentation/git-merge-base.txt     | 4 ++--
 Documentation/git-pack-redundant.txt | 2 +-
 Documentation/git-prune-packed.txt   | 2 +-
 Documentation/git-rerere.txt         | 2 +-
 Documentation/git-show-branch.txt    | 4 ++--
 Documentation/git-show-ref.txt       | 4 ++--
 Documentation/git-var.txt            | 2 +-
 Documentation/git-verify-pack.txt    | 2 +-
 builtin/bugreport.c                  | 2 +-
 builtin/diagnose.c                   | 2 +-
 builtin/sparse-checkout.c            | 2 +-
 12 files changed, 15 insertions(+), 15 deletions(-)

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
2.38.0.rc1.925.gb61c5ccd7da

