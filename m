Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DFF205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 11:27:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935604AbdAJL1m (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 06:27:42 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:35084 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935165AbdAJL1l (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 06:27:41 -0500
Received: by mail-pf0-f196.google.com with SMTP id f144so9679426pfa.2
        for <git@vger.kernel.org>; Tue, 10 Jan 2017 03:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zmTFpEQvhshoUnsuDeCzuOLwPsW0AVWPsUslWqVJhUg=;
        b=oT6Kc52EravINFZzlFnfWrrjzwbz+KgDS4zdE22PWG0z27tGwsyoW0EoFLri8Q3wD5
         NJGdt5rZDHTY1SBp/L4YCIPqorjOa8Vwct24NhwnHHTzV+YhSOkZp508UEqSSty9apbb
         muUumHpxKGoaBLYwTme2YAV2SNGDZ4iDUCRB1gdjLQY3n//l6uMhk3H38FmJT9Z8GyED
         /TtXtz2KntZ35Kh938/Q4XmwaOpS79FDLsTtbxPG+mRngZViFjWEJbaSDO8H6RBE0NFX
         k9JnQD4NU2SAaXu+cLaZKO/k1a/NPD0G5jQU3I5NFD3oPXWw7FIxpXotuBOpZSoJk6Q1
         l8eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zmTFpEQvhshoUnsuDeCzuOLwPsW0AVWPsUslWqVJhUg=;
        b=dTZB/v/iqWY8U3ICzbUr+yp0KtUelwt7qOFq96ElTFUIod50+K6mtdB0nXNN5Ayg2E
         S69UT+VSRMbma3IAaM8IOuCHiLgT8bWqIf7PsMfL5PKpi1jWR+KIPVXAFYWZAn+6AprD
         qCDLwRBJAFMLkL3fe8BpAbEy0vSBDeTR4eVKiuI46xnqO3bmYruizAbj38GqArHU8vfw
         oFhVCZzMnA2hgQWdgssTo55hcG9P4q7e6QUnAkurmRJk54RxDNrH+So4t6s8xiF5cpKU
         vBcGZ9xrmxl0NyEbkFtN+Ni0xrmRmFxkQYEwP072Mw0ptA3PRVB4wXu4dqhX11hLVtKr
         Q4Yw==
X-Gm-Message-State: AIkVDXKQxoWxf9mVseZ6eLCNWO2NZPDJmXt4WQFrNCBaTqBfVBOPL0B7T7LvTnp8uBFIBw==
X-Received: by 10.99.112.13 with SMTP id l13mr3411559pgc.7.1484047660337;
        Tue, 10 Jan 2017 03:27:40 -0800 (PST)
Received: from ash ([115.73.174.142])
        by smtp.gmail.com with ESMTPSA id o68sm4940539pfb.42.2017.01.10.03.27.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jan 2017 03:27:39 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 10 Jan 2017 18:27:34 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, git@drmicha.warpmail.net,
        Jens.Lehmann@web.de, larsxschneider@gmail.com, sbeller@google.com,
        mhagger@alum.mit.edu, max@max630.net,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 1/4] config: read per-worktree config files
Date:   Tue, 10 Jan 2017 18:25:21 +0700
Message-Id: <20170110112524.12870-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20170110112524.12870-1-pclouds@gmail.com>
References: <20170110112524.12870-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new repo extension is added, worktreeConfig. When it is present:

 - Repository config reading by default includes $GIT_DIR/config _and_
   $GIT_DIR/config.worktree. "config" file remains shared in multiple
   worktree setup.

 - The special treatment for core.bare and core.worktree, to stay
   effective only in main worktree, is gone. These config files are
   supposed to be in config.worktree.

This extension is most useful in multiple worktree setup because you
now have an option to store per-worktree config (which is either
.git/config.worktree for main worktree, or
.git/worktrees/xx/config.worktree for linked ones).

This extension can be used in single worktree mode, even though it's
pretty much useless (but this can happen after you remove all linked
worktrees and move back to single worktree).

"git config" reads from both "config" and "config.worktree" by default
(i.e. without either --user, --file...) when this extension is
present. Default writes (not implemented in this patch) still go to
"config", not "config.worktree". A new option --worktree is added for
that (*).

Since a new repo extension is introduced, existing git binaries should
refuse to access to the repo (both from main and linked worktrees). So
they will not misread the config file (i.e. skip the config.worktree
part). They may still accidentally write to the config file anyway if
they use with "git config --file <path>".

This design places a bet on the assumption that the majority of config
variables are shared so it is the default mode. A safer move would be
default writes go to per-worktree file, so that accidental changes are
isolated.

(*) "git config --worktree" points back to "config" file when this
    extension is not present so that it works in any setup.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/config.txt               | 11 +++++++++--
 Documentation/git-config.txt           |  4 ++++
 Documentation/git-worktree.txt         | 31 +++++++++++++++++++++++++++++++
 Documentation/gitrepository-layout.txt |  8 ++++++++
 cache.h                                |  2 ++
 config.c                               |  7 +++++++
 environment.c                          |  1 +
 setup.c                                |  5 ++++-
 8 files changed, 66 insertions(+), 3 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 30cb946..c508386 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -2,8 +2,9 @@ CONFIGURATION FILE
 ------------------
 
 The Git configuration file contains a number of variables that affect
-the Git commands' behavior. The `.git/config` file in each repository
-is used to store the configuration for that repository, and
+the Git commands' behavior. The files `.git/config` and optionally
+`config.worktree` (see `extensions.worktreeConfig` below) are each
+repository is used to store the configuration for that repository, and
 `$HOME/.gitconfig` is used to store a per-user configuration as
 fallback values for the `.git/config` file. The file `/etc/gitconfig`
 can be used to store a system-wide default configuration.
@@ -264,6 +265,12 @@ advice.*::
 		show directions on how to proceed from the current state.
 --
 
+extensions.worktreeConfig::
+	If set, by default "git config" reads from both "config" and
+	"config.worktree" file in that order. In multiple working
+	directory mode, "config" file is shared while
+	"config.worktree" is per-working directory.
+
 core.fileMode::
 	Tells Git if the executable bit of files in the working tree
 	is to be honored.
diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 83f86b9..806873c 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -253,6 +253,10 @@ $XDG_CONFIG_HOME/git/config::
 $GIT_DIR/config::
 	Repository specific configuration file.
 
+$GIT_DIR/config.worktree::
+	This is optional and is only searched when
+	`extensions.worktreeConfig` is present in $GIT_DIR/config.
+
 If no further options are given, all reading options will read all of these
 files that are available. If the global or the system-wide configuration
 file are not available they will be ignored. If the repository configuration
diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
index e257c19..329a673 100644
--- a/Documentation/git-worktree.txt
+++ b/Documentation/git-worktree.txt
@@ -136,6 +136,37 @@ working trees, it can be used to identify worktrees. For example if
 you only have two working trees, at "/abc/def/ghi" and "/abc/def/ggg",
 then "ghi" or "def/ghi" is enough to point to the former working tree.
 
+CONFIGURATION FILE
+------------------
+By default, the repository "config" file is shared across all working
+directories. If the config variables `core.bare` or `core.worktree`
+are already present in the config file, they will be applied to the
+main working directory only.
+
+In order to have configuration specific to working directories, you
+can turn on "worktreeConfig" extension, e.g.:
+
+------------
+$ git config extensions.worktreeConfig true
+------------
+
+In this mode, specific configuration stays in the path pointed by `git
+rev-parse --git-path config.worktree`. You can add or update
+configuration in this file with `git config --worktree`. Git before
+version 2.13 will refuse to access repositories with this extension.
+
+Note that in this file, the exception for `core.bare` and
+`core.worktree` is gone. If you have them before, you need to move
+them to the `config.worktree` of the main working directory. You may
+also take this opportunity to move other configuration that you do not
+want to share to all working directories:
+
+ - `core.worktree` and `core.bare` should never be shared
+
+ - `core.sparseCheckout` is recommended per working directory, unless
+   you are sure you always use sparse checkout for all working
+   directories.
+
 DETAILS
 -------
 Each linked working tree has a private sub-directory in the repository's
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index a5f99cb..fee2557 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -143,6 +143,11 @@ config::
 	if $GIT_COMMON_DIR is set and "$GIT_COMMON_DIR/config" will be
 	used instead.
 
+config.worktree::
+	Working directory specific configuration file for the main
+	working directory in multiple working directory setup (see
+	linkgit:git-worktree[1]).
+
 branches::
 	A slightly deprecated way to store shorthands to be used
 	to specify a URL to 'git fetch', 'git pull' and 'git push'.
@@ -276,6 +281,9 @@ worktrees/<id>/link::
 	file. It is used to detect if the linked repository is
 	manually removed.
 
+worktrees/<id>/config.worktree::
+	Working directory specific configuration file.
+
 SEE ALSO
 --------
 linkgit:git-init[1],
diff --git a/cache.h b/cache.h
index a50a61a..c621a35 100644
--- a/cache.h
+++ b/cache.h
@@ -777,10 +777,12 @@ extern int grafts_replace_parents;
 #define GIT_REPO_VERSION 0
 #define GIT_REPO_VERSION_READ 1
 extern int repository_format_precious_objects;
+extern int repository_format_worktree_config;
 
 struct repository_format {
 	int version;
 	int precious_objects;
+	int worktree_config;
 	int is_bare;
 	char *work_tree;
 	struct string_list unknown_extensions;
diff --git a/config.c b/config.c
index 83fdecb..a461e68 100644
--- a/config.c
+++ b/config.c
@@ -1307,6 +1307,13 @@ static int do_git_config_sequence(config_fn_t fn, void *data)
 	if (repo_config && !access_or_die(repo_config, R_OK, 0))
 		ret += git_config_from_file(fn, repo_config, data);
 
+	if (repository_format_worktree_config) {
+		char *path = git_pathdup("config.worktree");
+		if (!access_or_die(path, R_OK, 0))
+			ret += git_config_from_file(fn, path, data);
+		free(path);
+	}
+
 	current_parsing_scope = CONFIG_SCOPE_CMDLINE;
 	if (git_config_from_parameters(fn, data) < 0)
 		die(_("unable to parse command-line config"));
diff --git a/environment.c b/environment.c
index 0935ec6..df1be15 100644
--- a/environment.c
+++ b/environment.c
@@ -26,6 +26,7 @@ int warn_ambiguous_refs = 1;
 int warn_on_object_refname_ambiguity = 1;
 int ref_paranoia = -1;
 int repository_format_precious_objects;
+int repository_format_worktree_config;
 const char *git_commit_encoding;
 const char *git_log_output_encoding;
 const char *apply_default_whitespace;
diff --git a/setup.c b/setup.c
index fe572b8..69efe45 100644
--- a/setup.c
+++ b/setup.c
@@ -389,6 +389,8 @@ static int check_repo_format(const char *var, const char *value, void *vdata)
 			;
 		else if (!strcmp(ext, "preciousobjects"))
 			data->precious_objects = git_config_bool(var, value);
+		else if (!strcmp(ext, "worktreeconfig"))
+			data->worktree_config = git_config_bool(var, value);
 		else
 			string_list_append(&data->unknown_extensions, ext);
 	} else if (strcmp(var, "core.bare") == 0) {
@@ -432,8 +434,9 @@ static int check_repository_format_gently(const char *gitdir, int *nongit_ok)
 	}
 
 	repository_format_precious_objects = candidate.precious_objects;
+	repository_format_worktree_config = candidate.worktree_config;
 	string_list_clear(&candidate.unknown_extensions, 0);
-	if (!has_common) {
+	if (!has_common || repository_format_worktree_config) {
 		if (candidate.is_bare != -1) {
 			is_bare_repository_cfg = candidate.is_bare;
 			if (is_bare_repository_cfg == 1)
-- 
2.8.2.524.g6ff3d78

