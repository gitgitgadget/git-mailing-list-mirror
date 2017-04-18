Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAA74201C2
	for <e@80x24.org>; Tue, 18 Apr 2017 19:16:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757519AbdDRTQI (ORCPT <rfc822;e@80x24.org>);
        Tue, 18 Apr 2017 15:16:08 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33395 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1757470AbdDRTQF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2017 15:16:05 -0400
Received: by mail-wm0-f65.google.com with SMTP id o81so1154849wmb.0
        for <git@vger.kernel.org>; Tue, 18 Apr 2017 12:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TxLptxZIdp9pX4xx3FjgjcitdZpuAGY83/I3bs/8eiU=;
        b=VctleN1Ek3mmnPArotaBdgjTw9OVVyn+yPa9OBGb6a/Qt08mb0qgBzYBIKNHC2ihhC
         d0+Y1KNqh6Lo3KGX3mEDIks4Ampz1YPqZNfC4K+GUsWkBvtoCG6cBgllP9qX4f9s3Hlw
         XqWhhtErn7COKrSp2orDJ3BrPiDB5VzLIBe9l51dOGsOraLYhoKGfTIhtqL5XoAf+1IN
         oS719KTrG6FIyccFg78U/NmsiuRZcbvdrLkL2LSWgZ+AiqiYRwK+OGWl9IOy8PN3TItD
         w2dAyl/JiuPiKFh+Ctdx73ywsCC490HlSpeKfzrqSJm85XJhcC3o9N3QC5ejm71ElzhV
         GlBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TxLptxZIdp9pX4xx3FjgjcitdZpuAGY83/I3bs/8eiU=;
        b=LLwfdNmZtWiFHuLFoeWiFcNjkvS6Vfp1B6qzbF6osucyFqkMjrUKP56MaOL3oyLXHz
         BnD3G2ML9QrUIUpmQFRKjqXCZjDuKqFYm2rfMIXk16iodQHLWF3FhS4NHYsgz9CqMDJm
         Ke9CAUxEnq2Xz03wHYToyq07CmTLeAO9Fa1mGK2Sh++avHC56J8x/oTYFg11H4qahplL
         L+TPw1osUe0+pndteD6gw6udfo5nsKQuZ70YKopgw8iU+9JH7STwIBLTOdNa3BNCkbMV
         ZRbVX45qUk+GphvzE619lvWdpoEEK0MYPenNNWGAr6sOnFzpY0yZ018Tc2wQa6OTOi+U
         nLGw==
X-Gm-Message-State: AN3rC/7xn1KIm9y5DHc6X952gJP4uTghSzX7CgQwF2H6naomC6lvN0vi
        +pJsdG7Gh4JYuS6CzFM=
X-Received: by 10.28.109.3 with SMTP id i3mr14763947wmc.121.1492542963431;
        Tue, 18 Apr 2017 12:16:03 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id p197sm530482wmb.34.2017.04.18.12.16.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Apr 2017 12:16:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] clone: add a --no-tags option to clone without tags
Date:   Tue, 18 Apr 2017 19:15:53 +0000
Message-Id: <20170418191553.15464-1-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
References: <CACBZZX584QwjphGfEgTn2V9P0yVkYSxfE1_Gp96bno8186SDyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --no-tags option to "git clone" to clone without tags. Currently
there's no easy way to clone a repository and end up with just a
"master" branch via --single-branch, or track all branches and no
tags. Now --no-tags can be added to "git clone" with or without
--single-branch to clone a repository without tags.

Before this the only way of doing this was either by manually tweaking
the config in a fresh repository:

    git init git &&
    cat >git/.git/config <<EOF &&
    [remote "origin"]
        url = git@github.com:git/git.git
        tagOpt = --no-tags
        fetch = +refs/heads/master:refs/remotes/origin/master
    [branch "master"]
        remote = origin
        merge = refs/heads/master
    EOF
    cd git &&
    git pull

Which requires hardcoding the "master" name, which may not be the same
branch, or alternatively by setting tagOpt=--no-tags right after
cloning & deleting any existing tags:

    git clone --single-branch git@github.com:git/git.git &&
    cd git &&
    git config remote.origin.tagOpt --no-tags &&
    git tag -l | xargs git tag -d

Which of course was also subtly buggy if --branch was pointed at a
tag, leaving the user in a detached head:

    git clone --single-branch --branch v2.12.0 git@github.com:git/git.git &&
    cd git &&
    git config remote.origin.tagOpt --no-tags &&
    git tag -l | xargs git tag -d

Now all this complexity becomes the much simpler:

    git clone --single-branch --no-tags git@github.com:git/git.git

Or in the case of cloning a single tag "branch":

    git clone --single-branch --branch v2.12.0 --no-tags git@github.com:git/git.git

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

On Fri, Apr 14, 2017 at 11:28 PM, Ævar Arnfjörð Bjarmason <avarab@gmail.com> wrote:
> As far as I can tell the only way to clone a given upstream repo,
> which has an unknown main branch name without any tags is:
>
>     git clone --single-branch <url> <repo> &&
>     cd <repo> &&
>     git tag -d $(git tag -l) &&
>     git config remote.origin.tagOpt --no-tags
>
> Is there really nothing like:
>
>     git clone --single-branch --no-tags <url> <repo>
>
> ?
>
> I suppose this can be done with the usual 'git init`, set the config &
> then fetch dance, but in that case what part of 'git remote' or
> friends exposes finding the remote "main" ref as --single-branch does?

Here's a patch which implements this. It works, and I think it makes
sense for inclusion. It would be logical to follow this up with a
--no-tags-submodules similar to --no-shallow-submodules, but I ran out
of time.

 Documentation/git-clone.txt | 12 +++++++-
 builtin/clone.c             | 13 ++++++--
 t/t5612-clone-refspec.sh    | 73 +++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 93 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 30052cce49..ef78e6dcc6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	  [-l] [-s] [--no-hardlinks] [-q] [-n] [--bare] [--mirror]
 	  [-o <name>] [-b <name>] [-u <upload-pack>] [--reference <repository>]
 	  [--dissociate] [--separate-git-dir <git dir>]
-	  [--depth <depth>] [--[no-]single-branch]
+	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules] [--[no-]shallow-submodules]
 	  [--jobs <n>] [--] <repository> [<directory>]
 
@@ -215,6 +215,16 @@ objects from the source repository into a pack in the cloned repository.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
+--no-tags::
+	Don't clone any tags, and set `remote.origin.tagOpt=--no-tags`
+	in the config, ensuring that future `git pull` and `git fetch`
+	operations won't fetch any tags.
++
+Can be used in conjunction with `--single-branch` to clone & maintain
+a branch with no references other than a single cloned branch. This is
+useful e.g. to maintain minimal clones of the default branch of some
+repository for search indexing.
+
 --recurse-submodules[=<pathspec]::
 	After the clone is created, initialize and clone submodules
 	within based on the provided pathspec.  If no pathspec is
diff --git a/builtin/clone.c b/builtin/clone.c
index 32c5843563..96908a4cd7 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -40,6 +40,7 @@ static const char * const builtin_clone_usage[] = {
 
 static int option_no_checkout, option_bare, option_mirror, option_single_branch = -1;
 static int option_local = -1, option_no_hardlinks, option_shared;
+static int option_no_tags;
 static int option_shallow_submodules;
 static int deepen;
 static char *option_template, *option_depth, *option_since;
@@ -120,6 +121,8 @@ static struct option builtin_clone_options[] = {
 			N_("deepen history of shallow clone, excluding rev")),
 	OPT_BOOL(0, "single-branch", &option_single_branch,
 		    N_("clone only one branch, HEAD or --branch")),
+	OPT_BOOL_NONEG(0, "no-tags", &option_no_tags,
+		       N_("don't clone any tags, and set remote.<name>.tagOpt=--no-tags")),
 	OPT_BOOL(0, "shallow-submodules", &option_shallow_submodules,
 		    N_("any cloned submodules will be shallow")),
 	OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
@@ -563,7 +566,7 @@ static struct ref *wanted_peer_refs(const struct ref *refs,
 	} else
 		get_fetch_map(refs, refspec, &tail, 0);
 
-	if (!option_mirror && !option_single_branch)
+	if (!option_mirror && !option_single_branch && !option_no_tags)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
 
 	return local_refs;
@@ -652,7 +655,7 @@ static void update_remote_refs(const struct ref *refs,
 
 	if (refs) {
 		write_remote_refs(mapped_refs);
-		if (option_single_branch)
+		if (option_single_branch && !option_no_tags)
 			write_followtags(refs, msg);
 	}
 
@@ -1035,6 +1038,12 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	git_config_set(key.buf, repo);
 	strbuf_reset(&key);
 
+	if (option_no_tags) {
+		strbuf_addf(&key, "remote.%s.tagOpt", option_origin);
+		git_config_set(key.buf, "--no-tags");
+		strbuf_reset(&key);
+	}
+
 	if (option_required_reference.nr || option_optional_reference.nr)
 		setup_reference();
 
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 7ace2535c8..83317805a8 100755
--- a/t/t5612-clone-refspec.sh
+++ b/t/t5612-clone-refspec.sh
@@ -17,13 +17,20 @@ test_expect_success 'setup' '
 	echo four >file &&
 	git commit -a -m four &&
 	git checkout master &&
+	git tag five &&
 
 	# default clone
 	git clone . dir_all &&
 
+	# default clone --no-tags
+	git clone --no-tags . dir_all_no_tags &&
+
 	# default --single that follows HEAD=master
 	git clone --single-branch . dir_master &&
 
+	# default --single that follows HEAD=master with no tags
+	git clone --single-branch --no-tags . dir_master_no_tags &&
+
 	# default --single that follows HEAD=side
 	git checkout side &&
 	git clone --single-branch . dir_side &&
@@ -45,6 +52,9 @@ test_expect_success 'setup' '
 	# explicit --single with tag
 	git clone --single-branch --branch two . dir_tag &&
 
+	# explicit --single with tag and --no-tags
+	git clone --single-branch --no-tags --branch two . dir_tag_no_tags &&
+
 	# advance both "master" and "side" branches
 	git checkout side &&
 	echo five >file &&
@@ -75,7 +85,17 @@ test_expect_success 'by default no tags will be kept updated' '
 		git for-each-ref refs/tags >../actual
 	) &&
 	git for-each-ref refs/tags >expect &&
-	test_must_fail test_cmp expect actual
+	test_must_fail test_cmp expect actual &&
+	test_line_count = 2 actual
+'
+
+test_expect_success 'clone with --no-tags' '
+	(
+		cd dir_all_no_tags && git fetch &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	>expect &&
+	test_cmp expect actual
 '
 
 test_expect_success '--single-branch while HEAD pointing at master' '
@@ -87,7 +107,46 @@ test_expect_success '--single-branch while HEAD pointing at master' '
 	) &&
 	# only follow master
 	git for-each-ref refs/heads/master >expect &&
-	test_cmp expect actual
+	# get & check latest tags
+	test_cmp expect actual &&
+	(
+		cd dir_master &&
+		git fetch --tags &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	git for-each-ref refs/tags >expect &&
+	test_cmp expect actual &&
+	test_line_count = 2 actual
+'
+
+test_expect_success '--single-branch while HEAD pointing at master and --no-tags' '
+	(
+		cd dir_master_no_tags && git fetch &&
+		git for-each-ref refs/remotes/origin |
+		sed -e "/HEAD$/d" \
+		    -e "s|/remotes/origin/|/heads/|" >../actual
+	) &&
+	# only follow master
+	git for-each-ref refs/heads/master >expect &&
+	test_cmp expect actual &&
+	# get tags (noop)
+	(
+		cd dir_master_no_tags &&
+		git fetch &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	>expect &&
+	test_cmp expect actual &&
+	test_line_count = 0 actual &&
+	# get tags with --tags overrides tagOpt
+	(
+		cd dir_master_no_tags &&
+		git fetch --tags &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	git for-each-ref refs/tags >expect &&
+	test_cmp expect actual &&
+	test_line_count = 2 actual
 '
 
 test_expect_success '--single-branch while HEAD pointing at side' '
@@ -123,6 +182,16 @@ test_expect_success '--single-branch with explicit --branch with tag fetches upd
 	test_cmp expect actual
 '
 
+test_expect_success '--single-branch with explicit --branch with tag fetches updated tag despite --no-tags' '
+	(
+		cd dir_tag_no_tags && git fetch &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	git for-each-ref refs/tags/two >expect &&
+	test_cmp expect actual &&
+	test_line_count = 1 actual
+'
+
 test_expect_success '--single-branch with --mirror' '
 	(
 		cd dir_mirror && git fetch &&
-- 
2.11.0

