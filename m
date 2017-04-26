Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 90318207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 23:13:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1032528AbdDZXM7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 19:12:59 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:33566 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1032526AbdDZXM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 19:12:56 -0400
Received: by mail-wr0-f194.google.com with SMTP id w50so1882302wrc.0
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 16:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqAmQQ6QJN3msJYXYTF5AEYL1r8JPHRlgR/hT0acFiw=;
        b=HuaNsr5ckxErfNz6+MMwYzCwtBENM3EGtEJOBNnPQcYUGhqQZqVAZRyrrbI6nITH6I
         pVEFlo7ZuPh5Gnj439ylj91ASsjAlVFVw4aqX0D6hauCU+90kZoHRBoia3HJuOsLvMAc
         F+nLdpNJ0W+gyd6bHwNc1MOokdhJHWWT8MM7J9op3itmwI0wrFx9hgut5LMz37pM2b0K
         5H5zgXUXK0vr9qNhMN15R684bS98kR7f/gYewhLUrrOELatAXT99JYWUNMG6f51YaTaz
         LM1hOBl9Deu3UdBor3FLjktvungP6HoYxvXY3tvcVY9EkPsdleU5Z4vi7v4IOPtlxGAf
         +ynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqAmQQ6QJN3msJYXYTF5AEYL1r8JPHRlgR/hT0acFiw=;
        b=fTjsKCvJY+u1EnYgn1a//tLVFtpuZMTwwhAhEmwTZdKuF/dn75O0Cr3sHNXH44nS3v
         PuOGTdh8UCbqec86v/AiQZUXNr4ka+q6nC8ThZPtL7AtToSldRJ1kf+JGTL8N+D6LD9X
         Nq5XhsWZJ/ahSxWRLgsN98FVwCeZbWBtewjS38ReoeWT9CnNJA4UCgT5bzD9fE2PQYjJ
         1dQUfCIFdjAz/3DJKw7k1ay2a+snZwENb+YSbx2fQJrTNb6epWS+LpnKLfAAQeGEQqzK
         sKbF0Dh9BtgBPC5mnxa0n2UWssWaEPAlOndQ80y1rXbYGTwkb7Dn5rsrUEhxMVaGo0eP
         DMtA==
X-Gm-Message-State: AN3rC/40M4/1x8mZcLyRazdua7Yk4az94WqBCs/9oqs2w7Nw44dZNmu1
        vkaDNkQXNdyaSw==
X-Received: by 10.223.130.104 with SMTP id 95mr1403466wrb.150.1493248375262;
        Wed, 26 Apr 2017 16:12:55 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id 133sm1053097wms.22.2017.04.26.16.12.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Apr 2017 16:12:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/5] clone: add a --no-tags option to clone without tags
Date:   Wed, 26 Apr 2017 23:12:33 +0000
Message-Id: <20170426231236.27219-3-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170426231236.27219-1-avarab@gmail.com>
References: <20170426231236.27219-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a --no-tags option to clone without fetching any tags.

Without this change there's no easy way to clone a repository without
also fetching its tags.

When supplying --single-branch the primary remote branch will be
cloned, but in addition tags will be followed & retrieved. Now
--no-tags can be added --single-branch to clone a repository without
tags, and which only tracks a single upstream branch.

This option works without --single-branch as well, and will do a
normal clone but not fetch any tags.

Many git commands pay some fixed overhead as a function of the number
of references. E.g. creating ~40k tags in linux.git will cause a
command like `git log -1 >/dev/null` to run in over a second instead
of in a matter of milliseconds, in addition numerous other things will
slow down, e.g. "git log <TAB>" with the bash completion will slowly
show ~40k references instead of 1.

The user might want to avoid all of that overhead to simply use a
repository like that to browse the "master" branch, or something like
a CI tool might want to keep that one branch up-to-date without caring
about any other references.

Without this change the only way of accomplishing this was either by
manually tweaking the config in a fresh repository:

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

Which requires hardcoding the "master" name, which may not be the main
--single-branch would have retrieved, or alternatively by setting
tagOpt=--no-tags right after cloning & deleting any existing tags:

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
 Documentation/git-clone.txt            | 14 ++++++-
 builtin/clone.c                        | 13 +++++-
 contrib/completion/git-completion.bash |  1 +
 t/t5612-clone-refspec.sh               | 76 +++++++++++++++++++++++++++++++++-
 4 files changed, 99 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 30052cce49..83c8e9b394 100644
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
 
@@ -215,6 +215,18 @@ objects from the source repository into a pack in the cloned repository.
 	branch when `--single-branch` clone was made, no remote-tracking
 	branch is created.
 
+--no-tags::
+	Don't clone any tags, and set
+	`remote.<remote>.tagOpt=--no-tags` in the config, ensuring
+	that future `git pull` and `git fetch` operations won't follow
+	any tags. Subsequent explicit tag fetches will still work,
+	(see linkgit:git-fetch[1]).
++
+Can be used in conjunction with `--single-branch` to clone and
+maintain a branch with no references other than a single cloned
+branch. This is useful e.g. to maintain minimal clones of the default
+branch of some repository for search indexing.
+
 --recurse-submodules[=<pathspec]::
 	After the clone is created, initialize and clone submodules
 	within based on the provided pathspec.  If no pathspec is
diff --git a/builtin/clone.c b/builtin/clone.c
index de85b85254..05f52d6f2b 100644
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
+	OPT_BOOL(0, "no-tags", &option_no_tags,
+		 N_("don't clone any tags, and make later fetches not to follow them")),
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
 
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 1150164d5c..6da997cf42 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1309,6 +1309,7 @@ _git_clone ()
 			--template=
 			--depth
 			--single-branch
+			--no-tags
 			--branch
 			--recurse-submodules
 			--no-single-branch
diff --git a/t/t5612-clone-refspec.sh b/t/t5612-clone-refspec.sh
index 97c847fab6..fac5a73851 100755
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
@@ -77,7 +87,18 @@ test_expect_success 'by default no tags will be kept updated' '
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
+		cd dir_all_no_tags &&
+		git fetch &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	>expect &&
+	test_cmp expect actual
 '
 
 test_expect_success '--single-branch while HEAD pointing at master' '
@@ -90,7 +111,47 @@ test_expect_success '--single-branch while HEAD pointing at master' '
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
+		cd dir_master_no_tags &&
+		git fetch &&
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
@@ -129,6 +190,17 @@ test_expect_success '--single-branch with explicit --branch with tag fetches upd
 	test_cmp expect actual
 '
 
+test_expect_success '--single-branch with explicit --branch with tag fetches updated tag despite --no-tags' '
+	(
+		cd dir_tag_no_tags &&
+		git fetch &&
+		git for-each-ref refs/tags >../actual
+	) &&
+	git for-each-ref refs/tags/two >expect &&
+	test_cmp expect actual &&
+	test_line_count = 1 actual
+'
+
 test_expect_success '--single-branch with --mirror' '
 	(
 		cd dir_mirror &&
-- 
2.11.0

