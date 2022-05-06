Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1975C433F5
	for <git@archiver.kernel.org>; Fri,  6 May 2022 18:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237489AbiEFSeO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 May 2022 14:34:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiEFSd6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 May 2022 14:33:58 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3D846B0B
        for <git@vger.kernel.org>; Fri,  6 May 2022 11:30:14 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id b19so11073523wrh.11
        for <git@vger.kernel.org>; Fri, 06 May 2022 11:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=N2sk49JicELUN7nxQs8Oc9F+gr3wbuaEv3hxhrLHc0g=;
        b=P3Jg4HHwZ7TwSffDCnD3gglxGfw38NL3/S1YjJ/DncjaDMJLtPPfqWuQvGvQziigG1
         93zkU/SVNtGkNxMAg9Otm9Rb8NlcU24y8tYgFmvlyJdlMEOWqKNSEgmgobblwdmmM/mG
         30QH8fFLq7/1Ebn0v4RntN6az86M0XjRxUNS3N8yxuV1i+4qHfKXnpb+MTtG0E7g4fvw
         dwAldIvBzujmxnbEANNmPafoVNKiWJQIMbdrebxsx4t8HYgMXEo0iVIISC120Kwk0aoX
         5Ug++qy0UV4c3L0offFj0cl2xR5FycndYOicm2woG9jVrKIumAs5JvMwMG9m6tGyp4HU
         nLMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=N2sk49JicELUN7nxQs8Oc9F+gr3wbuaEv3hxhrLHc0g=;
        b=JXKxyPPmmYCWxwWm4xfMCgeJK0Rk9PNiVLSqORe84T4uMREMwOXCbkEPi/E6si7vzL
         Fitr/sflSQABoYjIz53qSpwxpLZLoTOCZtnTvFZzDUmsb88+szsvWQmdOdOnPZ+f4sWF
         1Z+Gt2gJI67m6MjkL/ctlk4X9OdGhkG5LWrjBJh30BbtGdUfxD1EhCLj69g98ZtKHF+8
         S5v0b7mo5Xy6TIYPms9lwpUwto6Pv/Gbt7xe+/CIcM+VAF5FFZrIjWXTiySJ4x7vlqhe
         k1OPvF/EEoU4CAbp+KqySD+SNCa70JFRdhAidRiQ7B1cVVAQP1mX+SqqXWjI6+zdK6SH
         8diw==
X-Gm-Message-State: AOAM532de19XOF6+XxNpJtljgDNmAsxdHY2wat8tVQGpG+5HwK5QXaRM
        O4tdi5R0sHy78sFeJxc1WZpNElVwEtQ=
X-Google-Smtp-Source: ABdhPJw41S/E4l3b/U5blaOfrHrgMnxzZulyJkKJkH1/JHhjITrjXka8mk7GS415umy2cm83k/qDJA==
X-Received: by 2002:a5d:508c:0:b0:20c:55c4:5418 with SMTP id a12-20020a5d508c000000b0020c55c45418mr3770281wrt.147.1651861812349;
        Fri, 06 May 2022 11:30:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s1-20020adfecc1000000b0020c5253d8e6sm4221430wro.50.2022.05.06.11.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 May 2022 11:30:11 -0700 (PDT)
Message-Id: <pull.1261.git.git.1651861810633.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 06 May 2022 18:30:10 +0000
Subject: [PATCH] [RFC] setup.c: make bare repo discovery optional
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Add a config variable, `safe.barerepository`, that tells Git whether or
not to recognize bare repositories when it is trying to discover the
repository. This only affects repository discovery, thus it has no
effect if discovery was not done (e.g. `--git-dir` was passed).

This is motivated by the fact that some workflows don't use bare
repositories at all, and users may prefer to opt out of bare repository
discovery altogether:

- An easy assumption for a user to make is that Git commands run
  anywhere inside a repository's working tree will use the same
  repository. However, if the working tree contains a bare repository
  below the root-level (".git" is preferred at the root-level), any
  operations inside that bare repository use the bare repository
  instead.

  In the worst case, attackers can use this confusion to trick users
  into running arbitrary code (see [1] for a deeper discussion). But
  even in benign situations (e.g. a user renames ".git/" to ".git.old/"
  and commits it for archival purposes), disabling bare repository
  discovery can be a simpler mode of operation (e.g. because the user
  doesn't actually want to use ".git.old/") [2].

- Git won't "accidentally" recognize a directory that wasn't meant to be
  a bare repository, but happens to resemble one. While such accidents
  are probably very rare in practice, this lets users reduce the chance
  to zero.

This config is designed to be used like an allow-list, but it is not yet
clear what a good format for this allow-list would be. As such, this
patch limits the config value to a tri-state of [true|false|unset]:

- [*|(unset)] recognize all bare repositories (like Git does today)
- (empty) recognize no bare repositories

and leaves the full format to be determined later.

[1]: https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
[2]: I don't personally know anyone who does this as part of their
normal workflow, but a cursory search on GitHub suggests that there is a
not insubstantial number of people who munge ".git" in order to store
its contents.

https://github.com/search?l=&o=desc&p=1&q=ref+size%3A%3C1000+filename%3AHEAD&s=indexed&type=Code
(aka search for the text "ref", size:<1000, filename:HEAD)

Signed-off-by: Glen Choo <chooglen@google.com>
---
    RFC setup.c: make bare repo discovery optional
    
    (Forgive the non-standard RFC tag, I haven't figured out how to send as
    RFC using GGG. I also didn't realize that /preview would also respect
    CC...)
    
    = Description
    
    A relatively easy win that came out of the discussions around embedded
    bare repos [1], is to just let users opt-out of discovering bare repos.
    This patch does exactly that, by adding a 'boolean' config variable,
    safe.barerepository.
    
    safe.barerepository is presented to users as an allow-list of
    directories that Git will recognize as a bare repository during the
    repository discovery process (much like safe.directory), but this patch
    only implements (and permits) boolean behavior (i.e. on, off and unset).
    Hopefully, this gives us some room to discuss and experiment with
    possible formats.
    
    Thanks to Taylor for suggesting the allow-list idea :)
    
    I think the core concept of letting users toggle bare repo discovery is
    solid, but I'm sending this as RFC for the following reasons:
    
     * I don't love the name safe.barerepository, because it feels like Git
       is saying that bare repos are unsafe and consequently, that bare repo
       users are behaving unsafely. On the other hand, this is quite similar
       to safe.directory in a few respects, so it might make sense for the
       naming to reflect that.
    
     * The *-gcc CI jobs don't pass. I haven't discerned any kind of pattern
       yet.
    
    = How this relates to embedded bare repos
    
    This does not change the default behavior (i.e. Git will still discover
    all bare repos by default) because that would be catastrophic for bare
    repo users [2]. As such, this patch isn't intended to solve the problem
    of embedded bare repos for all users once and for all, but I think it
    does improve the our stance on the matter:
    
     * In the short-term, users who know they won't need bare repos (or
       those who are willing to set GIT_DIR for all of their bare repos) can
       opt-in to a safer, easier to reason about mode of operation.
    
     * In the longer-term, we might identify a usable-enough default that we
       can give opt-out protection that works for the vast majority of
       users.
    
    = Other questions/Concerns
    
     * Maybe it's more informative for the user if we die() (or warn()) when
       we find a bare repo instead of silently ignoring it?
    
     * I wonder if it makes sense to separate the toggle for bare repo
       discovery and the allow-list of bare repositories. Something like
       core.barediscovery or discovery.barerepository has a lot less baggage
       than safe.*, and boolean enable/disable is a lot simpler, but this
       isn't good from an extensibility perspective.
    
     * Is there any reason why safe.barerepository shouldn't use the same
       format as (its obvious inspiration) safe.directory?
    
     * Are the docs clear enough? I found those hard to put into words, so
       I'd especially appreciate wording suggestions :)
    
    = Future work
    
     * Like safe.directory, safe.barerepository is only read from system and
       global config. I anticipate that this is too restrictive; there has
       already been some discussion of adding a GIT_SAFE_DIRECTORIES
       environment variable for safe.directory [3], and it would be useful
       to have the same thing for safe.barerepository.
    
    [1]
    https://lore.kernel.org/git/kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com
    [2] In https://lore.kernel.org/git/xmqqh76ucdg6.fsf@gitster.g, Junio
    experimented with switching off bare repo discovery altogether and
    relying solely on GIT_DIR. The resulting fallout was deemed too big to
    be feasible. [3] https://lore.kernel.org/git/xmqqee1il09v.fsf@gitster.g/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1261%2Fchooglen%2Fsetup%2Fdisable-bare-repo-config-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1261/chooglen/setup/disable-bare-repo-config-v1
Pull-Request: https://github.com/git/git/pull/1261

 Documentation/config/safe.txt | 24 +++++++++++++++
 setup.c                       | 36 ++++++++++++++++++++++-
 t/t1510-repo-setup.sh         | 55 +++++++++++++++++++++++++++++++++++
 3 files changed, 114 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/safe.txt b/Documentation/config/safe.txt
index 6d764fe0ccf..02032251ffd 100644
--- a/Documentation/config/safe.txt
+++ b/Documentation/config/safe.txt
@@ -1,3 +1,27 @@
+safe.barerepository::
+	This config entry specifies directories that Git can recognize as
+	a bare repository when looking for the repository (aka repository
+	discovery). This has no effect if repository discovery is not
+	performed e.g. the path to the repository is set via `--git-dir`
+	(see linkgit:git[1]).
++
+It is recommended that you set this value so that Git will only use the bare
+repositories you intend it to. This prevents certain types of security and
+non-security problems, such as:
+
+* `git clone`-ing a repository containing a maliciously bare repository
+  inside it.
+* Git recognizing a directory that isn't mean to be a bare repository,
+  but happens to look like one.
++
+The currently supported values are `*` (Git recognizes all bare
+repositories) and the empty value (Git never recognizes bare repositories).
+Defaults to `*`.
++
+This config setting is only respected when specified in a system or global
+config, not when it is specified in a repository config or via the command
+line option `-c safe.barerepository=<path>`.
+
 safe.directory::
 	These config entries specify Git-tracked directories that are
 	considered safe even if they are owned by someone other than the
diff --git a/setup.c b/setup.c
index a7b36f3ffbf..9b5dd877273 100644
--- a/setup.c
+++ b/setup.c
@@ -1133,6 +1133,40 @@ static int ensure_valid_ownership(const char *path)
 	return data.is_safe;
 }
 
+/*
+ * This is similar to safe_directory_data, but only supports true/false.
+ */
+struct safe_bare_repository_data {
+	int is_safe;
+};
+
+static int safe_bare_repository_cb(const char *key, const char *value, void *d)
+{
+	struct safe_bare_repository_data *data = d;
+
+	if (strcmp(key, "safe.barerepository"))
+		return 0;
+
+	if (!value || !strcmp(value, "*")) {
+		data->is_safe = 1;
+		return 0;
+	}
+	if (!*value) {
+		data->is_safe = 0;
+		return 0;
+	}
+	return -1;
+}
+
+static int should_detect_bare(void)
+{
+	struct safe_bare_repository_data data;
+
+	read_very_early_config(safe_bare_repository_cb, &data);
+
+	return data.is_safe;
+}
+
 enum discovery_result {
 	GIT_DIR_NONE = 0,
 	GIT_DIR_EXPLICIT,
@@ -1238,7 +1272,7 @@ static enum discovery_result setup_git_directory_gently_1(struct strbuf *dir,
 			return GIT_DIR_DISCOVERED;
 		}
 
-		if (is_git_directory(dir->buf)) {
+		if (should_detect_bare() && is_git_directory(dir->buf)) {
 			if (!ensure_valid_ownership(dir->buf))
 				return GIT_DIR_INVALID_OWNERSHIP;
 			strbuf_addstr(gitdir, ".");
diff --git a/t/t1510-repo-setup.sh b/t/t1510-repo-setup.sh
index 591505a39c0..3ce8f776921 100755
--- a/t/t1510-repo-setup.sh
+++ b/t/t1510-repo-setup.sh
@@ -541,6 +541,61 @@ test_expect_success '#16e: bareness preserved by --bare' '
 	)
 '
 
+# Test the tri-state of [(unset)|""|"*"].
+test_expect_success '#16f: bare repo in worktree' '
+	test_when_finished "git config --global --unset safe.barerepository" &&
+	setup_repo 16f unset "" unset &&
+
+	git init --bare 16f/default/bare &&
+	git init --bare 16f/default/bare/bare &&
+	try_case 16f/default/bare unset unset \
+		. "(null)" "$here/16f/default/bare" "(null)" &&
+	try_case 16f/default/bare/bare unset unset \
+		. "(null)" "$here/16f/default/bare/bare" "(null)" &&
+
+	git config --global safe.barerepository "*" &&
+	git init --bare 16f/all/bare &&
+	git init --bare 16f/all/bare/bare &&
+	try_case 16f/all/bare unset unset \
+		. "(null)" "$here/16f/all/bare" "(null)" &&
+	try_case 16f/all/bare/bare unset unset \
+		. "(null)" "$here/16f/all/bare/bare" "(null)" &&
+
+	git config --global safe.barerepository "" &&
+	git init --bare 16f/never/bare &&
+	git init --bare 16f/never/bare/bare &&
+	try_case 16f/never/bare unset unset \
+		".git" "$here/16f" "$here/16f" "never/bare/" &&
+	try_case 16f/never/bare/bare unset unset \
+		".git" "$here/16f" "$here/16f" "never/bare/bare/"
+'
+
+test_expect_success '#16g: inside .git with safe.barerepository' '
+	test_when_finished "git config --global --unset safe.barerepository" &&
+
+	# Omit the "default" case; it is covered by 16a.
+
+	git config --global safe.barerepository "*" &&
+	setup_repo 16g/all unset "" unset &&
+	mkdir -p 16g/all/.git/wt/sub &&
+	try_case 16g/all/.git unset unset \
+		. "(null)" "$here/16g/all/.git" "(null)" &&
+	try_case 16g/all/.git/wt unset unset \
+		"$here/16g/all/.git" "(null)" "$here/16g/all/.git/wt" "(null)" &&
+	try_case 16g/all/.git/wt/sub unset unset \
+		"$here/16g/all/.git" "(null)" "$here/16g/all/.git/wt/sub" "(null)" &&
+
+	git config --global safe.barerepository "" &&
+	setup_repo 16g/never unset "" unset &&
+	mkdir -p 16g/never/.git/wt/sub &&
+	try_case 16g/never/.git unset unset \
+		".git" "$here/16g/never" "$here/16g/never" ".git/" &&
+	try_case 16g/never/.git/wt unset unset \
+		".git" "$here/16g/never" "$here/16g/never" ".git/wt/" &&
+	try_case 16g/never/.git/wt/sub unset unset \
+		".git" "$here/16g/never" "$here/16g/never" ".git/wt/sub/"
+'
+
 test_expect_success '#17: GIT_WORK_TREE without explicit GIT_DIR is accepted (bare case)' '
 	# Just like #16.
 	setup_repo 17a unset "" true &&

base-commit: 0f828332d5ac36fc63b7d8202652efa152809856
-- 
gitgitgadget
