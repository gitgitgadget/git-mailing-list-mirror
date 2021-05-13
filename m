Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB1DC43460
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79589613CA
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbhEMSTl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhEMSTd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:19:33 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BECC061574
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:20 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 131so9439518ljj.3
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=uifB8NJeojaeK+nDmSVKQhtY0qawzOshRrAWtqB0FD8=;
        b=ns8Z2ODQFzkk/cuekNI4kTjwUpQVwLHCw8oKwqTuZzGjwxIilhnl0ZKLhG4Tiw4wwx
         Sqp45Ygomj+yS5zadDrSBvgz/96jHJ0W28XoAUaTqc4EQm9MdwDhOTPLIneairRxW2Zj
         8jvCnSnqWuMUUYMT8Mvfeg3tq9YPDZrESAD9YPbKat3oMjQ1oJ+IuQIfTJ+ls/4bhwoG
         cavDFTwrz8Arz/8dV6KdCwmKM3W4ER7EiEpGMQqa9CmJbumAdKILJLtRq59es56ZEJfm
         ykCRonw1QdoJOascobTRWcUJrx7+9+AApg6OJlr+hcO8hejSl41h55TfUQxn1yYGdii0
         SILw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uifB8NJeojaeK+nDmSVKQhtY0qawzOshRrAWtqB0FD8=;
        b=E8ITfL25Pd6NHRF5cdUB0IEwNJnA889jd1TPQrwfU2PZThJmA+VYAVn10RTM3v8WDa
         2NlnGpg5QDPyaFTFVQhwDTZsWTmhbOPrmYFac6HupW0hzH+q+cFWkUnGVRAS4dDgtze1
         5cXg+pi+zNN4OBqugNvoRKRY30vRGH3sKKtPYWKs1AN+up7V1UKN+x+XJK44yfIx2rO8
         Jmk/+LENnA3E4cDV3Dmc122Siwo1uZhgB9Y+vPUGD+5olpY739WSq1sTAlqKyXQGwewP
         3vO+a+SyERqG5sxW8D+jR2qGBSYMncpXU/Vq9Y2v/yv/15t8nDAubuIOG6tloIp6hDzS
         mJRA==
X-Gm-Message-State: AOAM532THDIUTu9tdYq9wKuUdsp6tuL5Fn6XG3yaFEmRz1KGjdCDftaz
        /zS3rO/KDQzNHrHh9fT84Y0QeA6c1vg=
X-Google-Smtp-Source: ABdhPJytbe/tB/KBRxikSmWM0v+Lo8fB0NVhqPelBzP2f7IgJIHBxApFOLz6mbM/ecS4vzwqaOnxJw==
X-Received: by 2002:a2e:9806:: with SMTP id a6mr17880966ljj.214.1620929898656;
        Thu, 13 May 2021 11:18:18 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id v8sm554153ljn.17.2021.05.13.11.18.17
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:18:18 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 6/6] Doc: use two backticks for monospace, not backtick+apostrophe
Date:   Thu, 13 May 2021 20:17:45 +0200
Message-Id: <f0af6c8f6aeb765a2670cc6c097059c591cdcedc.1620928059.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a few places, we wrap the name of an --option or an ENV_VARIABLE in
backtick+apostrophe rather than backtick+backtick. Switch to using
two backticks, as per the coding guidelines.

As an added bonus to rendering these as monospace, we will have them
render the same with AsciiDoc and Asciidoctor. The `quoted' way ends up
as ‘quoted’ vs “quoted”.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/config/diff.txt      | 2 +-
 Documentation/git-check-ignore.txt | 2 +-
 Documentation/git-describe.txt     | 2 +-
 Documentation/git-svn.txt          | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index 2d3331f55c..eda0c452d1 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -69,7 +69,7 @@ diff.interHunkContext::
 diff.external::
 	If this config variable is set, diff generation is not
 	performed using the internal diff machinery, but using the
-	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF'
+	given command.  Can be overridden with the `GIT_EXTERNAL_DIFF`
 	environment variable.  The command is called with parameters
 	as described under "git Diffs" in linkgit:git[1].  Note: if
 	you want to use an external diff program only on a subset of
diff --git a/Documentation/git-check-ignore.txt b/Documentation/git-check-ignore.txt
index 0c3924a63d..ab97ee9d50 100644
--- a/Documentation/git-check-ignore.txt
+++ b/Documentation/git-check-ignore.txt
@@ -21,7 +21,7 @@ input files to the exclude mechanism) and output the path if it is
 excluded.
 
 By default, tracked files are not shown at all since they are not
-subject to exclude rules; but see `--no-index'.
+subject to exclude rules; but see `--no-index`.
 
 OPTIONS
 -------
diff --git a/Documentation/git-describe.txt b/Documentation/git-describe.txt
index a88f6ae2c6..adbbb8907f 100644
--- a/Documentation/git-describe.txt
+++ b/Documentation/git-describe.txt
@@ -44,7 +44,7 @@ OPTIONS
 	HEAD".  If the working tree has local modification "-dirty"
 	is appended to it.  If a repository is corrupt and Git
 	cannot determine if there is local modification, Git will
-	error out, unless `--broken' is given, which appends
+	error out, unless `--broken` is given, which appends
 	the suffix "-broken" instead.
 
 --all::
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 4e62dc37e7..2491ed47a6 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -361,7 +361,7 @@ where <name> is the name of the SVN repository as specified by the -R option to
 	This should make it easy to look up svn log messages when svn
 	users refer to -r/--revision numbers.
 +
-The following features from `svn log' are supported:
+The following features from `svn log` are supported:
 +
 --
 -r <n>[:<n>];;
@@ -397,7 +397,7 @@ Any other arguments are passed directly to 'git log'
 'blame'::
 	Show what revision and author last modified each line of a file. The
 	output of this mode is format-compatible with the output of
-	`svn blame' by default. Like the SVN blame command,
+	`svn blame` by default. Like the SVN blame command,
 	local uncommitted changes in the working tree are ignored;
 	the version of the file in the HEAD revision is annotated. Unknown
 	arguments are passed directly to 'git blame'.
@@ -482,7 +482,7 @@ denotes such an object, or it is requested by invoking an editor (see
 
 'info'::
 	Shows information about a file or directory similar to what
-	`svn info' provides.  Does not currently support a -r/--revision
+	`svn info` provides.  Does not currently support a -r/--revision
 	argument.  Use the --url option to output only the value of the
 	'URL:' field.
 
-- 
2.31.1.751.gd2f1c929bd

