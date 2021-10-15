Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F185C433FE
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 02:05:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F46C610D1
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 02:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234861AbhJOCIE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Oct 2021 22:08:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234754AbhJOCHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Oct 2021 22:07:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB22C061753
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 19:05:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id e12so23683149wra.4
        for <git@vger.kernel.org>; Thu, 14 Oct 2021 19:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HrMLCXmiVfaIC93xva10yOz7RZPQRWnwxMIxhESKK/s=;
        b=YuXNNrgLLOTJfGfM/sAdOjeiLzzFAHrl6IvhzcdWr3gRchqHQh9+gWjdy4WIS8wqBi
         iXiyQz0f5m82WjRULFWkS7mCwR+8Ou4zya8dE/mRUV4vrJKRVODJ20Wf2u+EGVhjEo4i
         k1rEeplJJ5V6hA1mehr4mvSNTf1V4rFV3en4bMbzOpqoADFSgzWXXB+xXA0Ygqen1QSa
         r0zcFBAWah7/lbsF2HxHOZoQfCRJ/m52pQrPk+7PpMZL/rWCnHvCMmxKuqayTs7tmXCL
         x6ADYOw9kokOVhhshf6PtKPmRXk+FxXmZULaNHzB7u3qQmjwZLjywBn697xb5R1ym6RI
         K9Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HrMLCXmiVfaIC93xva10yOz7RZPQRWnwxMIxhESKK/s=;
        b=rR+HSYyBsQhTDnbpcyc0rDX0z/1CFySJTZG2uaRqGmCN4lQtT8kvDV5qZCUKIIfXiJ
         pK95VGPkxgfPb+Qq8oW01FTx8AIHPrUV+X2FNHs/+jQiYLlxSUhrZeusCBNur9JOeDCU
         4lHJAjFKy66q60GAfFFBRLuy3Ht5KPFSCprWYYwAFbJ5seYcIM8mIE4dinD6pBVZhTK2
         3RirZ1jRg+t0TGzorWaJupI027VUq/JVyR/29rZ1FdEkLdp8pVLrLc6UgOBIcbxhWj/K
         fh2d9zPntLyXNlWLquk+kIj+d8pQSvJbX/5hl3U3V41Y5fZWozVaN+D2/PWD7XGmLaYt
         f+mA==
X-Gm-Message-State: AOAM531F4tT7ZKRhKA2+lGHCUSQXf2HxjA78gfZngPiVbuNMY4lYrMsS
        dBGUtzC8wmrvNWwhUnl6IQHiphC1U5/Pbg==
X-Google-Smtp-Source: ABdhPJxSL/0vikp50DfU+mhTCQk3XfCX8EGioEhL/T9pU9v6bYPPpD4U9meUlbiHz2IgR3Dnov36yg==
X-Received: by 2002:a05:6000:550:: with SMTP id b16mr11265037wrf.297.1634263538840;
        Thu, 14 Oct 2021 19:05:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p18sm3742990wrn.41.2021.10.14.19.05.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 19:05:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Todd Zullinger <tmz@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] git(1) docs: create a "Git file and wire formats" section
Date:   Fri, 15 Oct 2021 04:05:20 +0200
Message-Id: <patch-2.2-5e80ee09523-20211015T020351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20211015T020351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a new "Git file and wire formats" section in the main "git(1)"
manual page and start moving the documentation that now lives in
"Documentation/technical/*.git" over to it. This compliments the newly
added and adjacent "User-facing file formats" section.

This makes the technical documentation more accessible and
discoverable. Before this we wouldn't install it by default, and had
no ability to build man page versions of them. The links to them from
our existing documentation link to the generated HTML version of these
docs.

So let's start moving those over, starting with just the
"bundle-format.txt" documentation added in 7378ec90e1c (doc: describe
Git bundle format, 2020-02-07). We'll now have a new
gitformat-bundle(5) man page.

Unfortunately the syntax of the current Documentation/technical/*.txt
is not the same (when it comes to section headings etc.) as our
Documentation/*.txt documentation, so change the relevant bits of
syntax as we're moving this over.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/Makefile                        |  3 +-
 Documentation/git-bundle.txt                  | 12 +++--
 Documentation/git.txt                         |  8 ++++
 ...bundle-format.txt => gitformat-bundle.txt} | 44 ++++++++++++++++---
 Documentation/lint-man-section-order.perl     |  3 ++
 builtin/help.c                                |  8 ++++
 command-list.txt                              |  5 +++
 help.c                                        | 11 +++++
 help.h                                        |  1 +
 9 files changed, 83 insertions(+), 12 deletions(-)
 rename Documentation/{technical/bundle-format.txt => gitformat-bundle.txt} (78%)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 8efed2e23e1..cc4761df82e 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -21,6 +21,7 @@ MAN1_TXT += gitweb.txt
 
 # man5 / man7 guides (note: new guides should also be added to command-list.txt)
 MAN5_TXT += gitattributes.txt
+MAN5_TXT += gitformat-bundle.txt
 MAN5_TXT += githooks.txt
 MAN5_TXT += gitignore.txt
 MAN5_TXT += gitmailmap.txt
@@ -90,7 +91,6 @@ SP_ARTICLES += $(API_DOCS)
 TECH_DOCS += MyFirstContribution
 TECH_DOCS += MyFirstObjectWalk
 TECH_DOCS += SubmittingPatches
-TECH_DOCS += technical/bundle-format
 TECH_DOCS += technical/hash-function-transition
 TECH_DOCS += technical/http-protocol
 TECH_DOCS += technical/index-format
@@ -312,6 +312,7 @@ cmds_txt = cmds-ancillaryinterrogators.txt \
 	cmds-synchelpers.txt \
 	cmds-guide.txt \
 	cmds-userformats.txt \
+	cmds-gitformats.txt \
 	cmds-purehelpers.txt \
 	cmds-foreignscminterface.txt
 
diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.txt
index 71b5ecabd1f..cc3c32f5c0d 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -56,10 +56,9 @@ using "thin packs" bundles created using exclusions are smaller in
 size. That they're "thin" under the hood is merely noted here as a
 curiosity, and as a reference to other documentation
 
-See link:technical/bundle-format.html[the `bundle-format`
-documentation] for more details and the discussion of "thin pack" in
-link:technical/pack-format.html[the pack format documentation] for
-further details.
+See linkgit:gitformat-bundle[5] for more details and the discussion of
+"thin pack" in link:technical/pack-format.html[the pack format
+documentation] for further details.
 
 OPTIONS
 -------
@@ -334,6 +333,11 @@ You can also see what references it offers:
 $ git ls-remote mybundle
 ----------------
 
+FILE FORMAT
+-----------
+
+See linkgit:gitformat-bundle[5].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 823977595c5..0c77475d7a0 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -345,6 +345,14 @@ edit. These can also be listed with 'git help --user-formats'.
 
 include::cmds-userformats.txt[]
 
+Git file and wire formats
+-------------------------
+
+This documentation discusses the file and wire formats that git itself
+uses. These can also be listed with 'git help --git-formats'.
+
+include::cmds-gitformats.txt[]
+
 Configuration Mechanism
 -----------------------
 
diff --git a/Documentation/technical/bundle-format.txt b/Documentation/gitformat-bundle.txt
similarity index 78%
rename from Documentation/technical/bundle-format.txt
rename to Documentation/gitformat-bundle.txt
index bac558d049a..3aa2242eb9d 100644
--- a/Documentation/technical/bundle-format.txt
+++ b/Documentation/gitformat-bundle.txt
@@ -1,11 +1,33 @@
-= Git bundle v2 format
+gitformat-bundle(5)
+===================
 
-The Git bundle format is a format that represents both refs and Git objects.
+NAME
+----
+gitformat-bundle - The bundle file format
+
+
+SYNOPSIS
+--------
+[verse]
+*.bundle
+*.bdl
+
+DESCRIPTION
+-----------
+
+The Git bundle format is a format that represents both refs and Git
+objects. A bundle is a header in a format similar to
+linkgit:git-show-ref[1] followed by a pack in *.pack format.
 
-== Format
+The format is created and read by the linkgit:git-bundle[1] command,
+and supported by e.g. linkgit:git-fetch[1] and linkgit:git-clone[1].
+
+
+FORMAT
+------
 
 We will use ABNF notation to define the Git bundle format. See
-protocol-common.txt for the details.
+link:technical/protocol-common.html for the details.
 
 A v2 bundle looks like this:
 
@@ -36,7 +58,9 @@ value        = *(%01-09 / %0b-FF)
 pack         = ... ; packfile
 ----
 
-== Semantics
+
+SEMANTICS
+---------
 
 A Git bundle consists of several parts.
 
@@ -62,15 +86,21 @@ In the bundle format, there can be a comment following a prerequisite obj-id.
 This is a comment and it has no specific meaning. The writer of the bundle MAY
 put any string here. The reader of the bundle MUST ignore the comment.
 
-=== Note on the shallow clone and a Git bundle
+Note on the shallow clone and a Git bundle
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Note that the prerequisites does not represent a shallow-clone boundary. The
 semantics of the prerequisites and the shallow-clone boundaries are different,
 and the Git bundle v2 format cannot represent a shallow clone repository.
 
-== Capabilities
+CAPABILITIES
+------------
 
 Because there is no opportunity for negotiation, unknown capabilities cause 'git
 bundle' to abort.  The only known capability is `object-format`, which specifies
 the hash algorithm in use, and can take the same values as the
 `extensions.objectFormat` configuration value.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Documentation/lint-man-section-order.perl b/Documentation/lint-man-section-order.perl
index b05f9156dd9..81f04b6f3a2 100755
--- a/Documentation/lint-man-section-order.perl
+++ b/Documentation/lint-man-section-order.perl
@@ -32,6 +32,9 @@
 		'SEE ALSO' => {
 			order => $order++,
 		},
+		'FILE FORMAT' => {
+			order => $order++,
+		},
 		'GIT' => {
 			required => 1,
 			order => $order++,
diff --git a/builtin/help.c b/builtin/help.c
index 5e842ea5a26..54ff30a0d37 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -44,6 +44,7 @@ static enum help_action {
 	HELP_ACTION_GUIDES,
 	HELP_ACTION_CONFIG,
 	HELP_ACTION_USER_FORMATS,
+	HELP_ACTION_GIT_FORMATS,
 	HELP_ACTION_CONFIG_FOR_COMPLETION,
 	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
 } cmd_mode;
@@ -67,6 +68,8 @@ static struct option builtin_help_options[] = {
 		    HELP_ACTION_GUIDES),
 	OPT_CMDMODE(0, "user-formats", &cmd_mode, N_("print list of user-facing file formats"),
 		    HELP_ACTION_USER_FORMATS),
+	OPT_CMDMODE(0, "git-formats", &cmd_mode, N_("print list of Git's own file and network formats"),
+		    HELP_ACTION_GIT_FORMATS),
 	OPT_CMDMODE('c', "config", &cmd_mode, N_("print all configuration variable names"),
 		    HELP_ACTION_CONFIG),
 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
@@ -83,6 +86,7 @@ static const char * const builtin_help_usage[] = {
 	N_("git help [-g|--guides]"),
 	N_("git help [-c|--config]"),
 	N_("git help [--user-formats]"),
+	N_("git help [--git-formats]"),
 	NULL
 };
 
@@ -621,6 +625,10 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		no_extra_argc(argc);
 		list_user_formats_help();
 		return 0;
+	case HELP_ACTION_GIT_FORMATS:
+		no_extra_argc(argc);
+		list_git_formats_help();
+		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
 		no_extra_argc(argc);
 		list_config_help(SHOW_CONFIG_SECTIONS);
diff --git a/command-list.txt b/command-list.txt
index 5732ea437a8..3cf09b9d9eb 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -47,6 +47,10 @@
 # .mailmap etc. files lives in man section 5. These entries can only
 # have the "userformats" attribute and nothing else.
 #
+# Git's own file and network formats such as documentation for the
+# *.bundle format lives in mn section 5. These entries can only have
+# the "gitformats" attribute and nothing else.
+#
 ### command list (do not change this line, also do not change alignment)
 # command name                          category [category] [category]
 git-add                                 mainporcelain           worktree
@@ -210,6 +214,7 @@ githooks                                userformats
 gitignore                               userformats
 gitmailmap                              userformats
 gitmodules                              userformats
+gitformat-bundle                        gitformats
 gitnamespaces                           guide
 gitremote-helpers                       guide
 gitrepository-layout                    userformats
diff --git a/help.c b/help.c
index a7b5c909056..7b97867cb96 100644
--- a/help.c
+++ b/help.c
@@ -38,6 +38,7 @@ static struct category_description main_categories[] = {
 	{ CAT_synchingrepositories, N_("Low-level Commands / Syncing Repositories") },
 	{ CAT_purehelpers, N_("Low-level Commands / Internal Helpers") },
 	{ CAT_userformats, N_("User-facing file formats") },
+	{ CAT_gitformats, N_("Internal file- and wire formats formats") },
 	{ 0, NULL }
 };
 
@@ -433,6 +434,16 @@ void list_user_formats_help(void)
 	putchar('\n');
 }
 
+void list_git_formats_help(void)
+{
+	struct category_description catdesc[] = {
+		{ CAT_gitformats, N_("Git's internal file and network formats are:") },
+		{ 0, NULL }
+	};
+	print_cmd_by_category(catdesc, NULL);
+	putchar('\n');
+}
+
 static int get_alias(const char *var, const char *value, void *data)
 {
 	struct string_list *list = data;
diff --git a/help.h b/help.h
index d01908078dc..1075235f367 100644
--- a/help.h
+++ b/help.h
@@ -23,6 +23,7 @@ void list_common_cmds_help(void);
 void list_all_cmds_help(void);
 void list_guides_help(void);
 void list_user_formats_help(void);
+void list_git_formats_help(void);
 
 void list_all_main_cmds(struct string_list *list);
 void list_all_other_cmds(struct string_list *list);
-- 
2.33.1.1338.g20da966911a

