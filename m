Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D064C4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:13:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7447960F92
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:13:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbhIALOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhIALN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:13:56 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86021C061760
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:12:59 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id b6so3858503wrh.10
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=saP5m1yaPfDo9N1o2iyHUVZIaQcNMlqgxPy+yOsjRhU=;
        b=mdAz1wUB/q27oEUEgai3CldobCnw2S81dpYi8xnD4yBSj4fadIzt8z9cyeSNUX7W/A
         eGfU8isL/+/+Mwf/q3Q2semjkBoPS1RjSWtdozLJBSgM8Kgd12prPoFGJOLs3wzxKf2t
         nfJD5HQydE2Ou7IfF9pUyQIpYEagnKk07vj8T4bD7y3vPUBQEl+yGYhR58b7+epLPig5
         GzSdNiA8K8fd1AxDNyjX7Fvuk6TxxmyzH8cQp7BF+K5e9g7DjDaJo0m9VPa9gOg7iVrk
         epn2w7C65z5XoOfBUiPeI1gFvqS2ZcMZraA3NjzJvNdRdKBokyib0tCci7ptQQ8ooXA2
         7p/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=saP5m1yaPfDo9N1o2iyHUVZIaQcNMlqgxPy+yOsjRhU=;
        b=IXsslgd+wKTM0E1T6Sb274uLnuV2R4HXL8Bj9wFsIl8cSUXGK/PqLj2wqKdQ2n/yEe
         JcC4Pe4e/TcMozYsdhfJIemUlYqX3CsHCVMypcrVo0zTOT2Y8lehZYkX3z7BHX6lCenP
         pjj1SlCBpAZGgQ/ElxjlpfP5a0bTvrrfTJ6i05OAlyWmh9/eJPjZNuuy1+jvXTfw5Jad
         a4GTfyaRujvwY6X4AnGhZWZ1zXG2khQl2/9v4ZQE/yvdVNQ0+wu/Qg9qMEnxRsgYk99r
         dpqHBx6wZ1+SC8/1ubxP/OEnrppACH9PhG//2q1OMX3x2OIm+pbc+XVU1VDZ5s9CVFZw
         jhPg==
X-Gm-Message-State: AOAM530xLAAY/7hs7TbDX72GslIgSEqcO0O2b9uIGoKFW8POMCOhpKZQ
        keil7zml369V/n28vFzyXa7+A+SUxhmHqw==
X-Google-Smtp-Source: ABdhPJycGC70ALroiRXxkq8EPWQ0a+KewjvmCoD0pMZRFs0+IMe1Ynpwr2v68bm23VvTj3N7sdCpmQ==
X-Received: by 2002:a05:6000:1244:: with SMTP id j4mr22289624wrx.335.1630494777952;
        Wed, 01 Sep 2021 04:12:57 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u25sm5151499wmj.10.2021.09.01.04.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:12:57 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] built-ins: "properly" align continued usage output
Date:   Wed,  1 Sep 2021 13:12:54 +0200
Message-Id: <patch-1.2-ccc024c414f-20210901T110917Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.807.gf14ecf9c2e9
In-Reply-To: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
References: <cover-0.2-00000000000-20210901T110917Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's "fix" various "git <cmd> -h" output by "properly" aligning the
output in cases where we continue usage output after a "\n". The "fix"
and "properly" scare quotes are because this actually makes things
worse in some cases, because e.g. in the case of "git tag -h" the
"\t\t" effectively works around how parse-options.c aligns this
output.

But two wrongs don't make a right, let's "fix" this by making it worse
temporarily, in anticipating of improving parse-options.c to handle
this alignment.

The issue is that we should have whitespace corresponding to the
length of the command name here, e.g. in the case of "git ls-remote"
it should be 14 characters, or the length of ""git ls-remote
". Instead we had 21 characters in builtin/ls-remote.c, those extra 7
characters are the length of "usage: " (and also " or:"). So in the C
locale the resulting output aligns nicely:

    $ git ls-remote -h
    usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
                         [-q | --quiet] [--exit-code] [--get-url]
                         [--symref] [<repository> [<refs>...]]

But that's fragile, we might not be under the C locale. We really
should have parse-options.c itself add this padding. In a subsequent
commit I'll make it do that.

In the case of "tag" and "show-branch" and "stash save" the output was
not properly aligned, although in the "git tag" case it was
near-enough (aligned with the "-" in "git tag -l") to look good,
assuming C locale & a tab-width of 8. In any case, let's align this in
a way that looks obviously correct when looking at the source itself,
and then improve parse-options.c itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/ls-remote.c   | 4 ++--
 builtin/show-branch.c | 6 +++---
 builtin/stash.c       | 2 +-
 builtin/tag.c         | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/ls-remote.c b/builtin/ls-remote.c
index 1794548c711..ef9036974ce 100644
--- a/builtin/ls-remote.c
+++ b/builtin/ls-remote.c
@@ -7,8 +7,8 @@
 
 static const char * const ls_remote_usage[] = {
 	N_("git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]\n"
-	   "                     [-q | --quiet] [--exit-code] [--get-url]\n"
-	   "                     [--symref] [<repository> [<refs>...]]"),
+	   "              [-q | --quiet] [--exit-code] [--get-url]\n"
+	   "              [--symref] [<repository> [<refs>...]]"),
 	NULL
 };
 
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d77ce7aeb38..a82cd1534fc 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -11,9 +11,9 @@
 
 static const char* show_branch_usage[] = {
     N_("git show-branch [-a | --all] [-r | --remotes] [--topo-order | --date-order]\n"
-       "		[--current] [--color[=<when>] | --no-color] [--sparse]\n"
-       "		[--more=<n> | --list | --independent | --merge-base]\n"
-       "		[--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
+       "                [--current] [--color[=<when>] | --no-color] [--sparse]\n"
+       "                [--more=<n> | --list | --independent | --merge-base]\n"
+       "                [--no-name | --sha1-name] [--topics] [(<rev> | <glob>)...]"),
     N_("git show-branch (-g | --reflog)[=<n>[,<base>]] [--list] [<ref>]"),
     NULL
 };
diff --git a/builtin/stash.c b/builtin/stash.c
index 8f42360ca91..45b19007d7c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -85,7 +85,7 @@ static const char * const git_stash_push_usage[] = {
 
 static const char * const git_stash_save_usage[] = {
 	N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
-	   "          [-u|--include-untracked] [-a|--all] [<message>]"),
+	   "               [-u|--include-untracked] [-a|--all] [<message>]"),
 	NULL
 };
 
diff --git a/builtin/tag.c b/builtin/tag.c
index 452558ec957..9b1165d2a4e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -26,7 +26,7 @@ static const char * const git_tag_usage[] = {
 		"\t\t<tagname> [<head>]"),
 	N_("git tag -d <tagname>..."),
 	N_("git tag -l [-n[<num>]] [--contains <commit>] [--no-contains <commit>] [--points-at <object>]\n"
-		"\t\t[--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
+	   "        [--format=<format>] [--merged <commit>] [--no-merged <commit>] [<pattern>...]"),
 	N_("git tag -v [--format=<format>] <tagname>..."),
 	NULL
 };
-- 
2.33.0.807.gf14ecf9c2e9

