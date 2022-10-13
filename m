Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96908C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 15:40:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbiJMPk3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 11:40:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbiJMPkJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 11:40:09 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03E88167C3
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id r13so3414678wrj.11
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 08:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fqFiShE7/bVajseF06askWQVpp1yf/ii9gf/7KB2aL0=;
        b=AbGS9Lc0Gpi2/KJhoVlBHGl/THmFnwRFBYx79JNo9puNxtXY9XDFOKZsmi8BqbX3Jw
         OG6xUjWrTjO1t8Z1moKgxJFy1ZjvVZvXYhA3E0IFelVBd4ZTxj4L7JnSehthdYVSjL76
         yt+ePBITZxZj4vm4/Ggb0KAtLWkrN05jVkkKPYa1yv4NfZraepfoanuW8tOUaLqA9/ih
         /gqPBvb5O80skAG8qc02kp+CuMgsMlv6wukgqr/H8qL113tm9bgpf8Eu4scnVg0KUPJ1
         X62u0y45NCmaf6nOB9oWVl2mAdveEvNKeHamkKMARyfmx/wlzugRJoLvKZPoiUNcGgNR
         h/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fqFiShE7/bVajseF06askWQVpp1yf/ii9gf/7KB2aL0=;
        b=TT+PEBanIprbSAIGPHeff5j3Gu09ICBP/JWdBmD7Jz8Ls87vB6dXzPa41vWeX9Afs/
         ufN1X9N9q7tXguXfu7mllX8mkb59TkgmBrqnm4Ug95V/7v+QIaDJ757ShEvNADHIPPUa
         cZ0pYdp+m3yhYhlOfqgd3IWC+2FVkmOZf7aMlG+Exjl7wNQh7SbbDMUXekrDRbOkcxXU
         Wk3dMrZF07jhmskpGwWF1RLOkE4SvBJgHOwh7aOrrl82tM+Hc0+pUbaLCicJtqTg6P99
         tzg+EDfTVnxuOpQ9DMVPaUMgkAcH4gTWEWPMPkp65qKnbI9DaLXFmT35RnJ9+Tb1b+ko
         yRgw==
X-Gm-Message-State: ACrzQf2WYT+oH4LAfUcUsO51pbx/saVQyFP7Z22+qVuOxnih8vFiRSK3
        SiPwa+4oErjTJFuK0W/Gp53BQ70VSTv57w==
X-Google-Smtp-Source: AMsMyM7KcoYvBWFXTMH5TGy2JrsIFQ5tv8z0Vo+5rGy7B260jVo+YUVznxFk8pmndSOZ+Ql6r7GBuQ==
X-Received: by 2002:a05:6000:61b:b0:231:1b8:172 with SMTP id bn27-20020a056000061b00b0023101b80172mr423662wrb.372.1665675586294;
        Thu, 13 Oct 2022 08:39:46 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id da12-20020a056000408c00b0022a3a887ceasm2258130wrb.49.2022.10.13.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Oct 2022 08:39:45 -0700 (PDT)
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
Subject: [PATCH v5 12/34] doc txt & -h consistency: correct padding around "[]()"
Date:   Thu, 13 Oct 2022 17:39:06 +0200
Message-Id: <patch-v5-12.34-f5bd52cb103-20221013T153626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1085.gb7e61c3016c
In-Reply-To: <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
References: <cover-v3-00.34-00000000000-20221004T131009Z-avarab@gmail.com> <cover-v5-00.34-00000000000-20221013T153625Z-avarab@gmail.com>
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
2.38.0.1085.gb7e61c3016c

