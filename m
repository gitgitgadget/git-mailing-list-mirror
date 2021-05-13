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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 653E1C433ED
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4895A613CA
	for <git@archiver.kernel.org>; Thu, 13 May 2021 18:18:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbhEMSTg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 May 2021 14:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbhEMST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 May 2021 14:19:27 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB2EC06174A
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:17 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id w15so34819412ljo.10
        for <git@vger.kernel.org>; Thu, 13 May 2021 11:18:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=MwYdhQUMKM80wPh7YuwuNf+VaOf3JJj67pkQcNVle6s=;
        b=LHAUYi1+0ori0ucZ5xjtuvra/PIoqFFKh03dXoxJz/Ki2NT+NuArYtVfYSTGTnmbQR
         kWnJ9yBjjanPQmQ4g0hXYJS8T4+mgaAsyV1uoH76HLYKsrmSEo912Ovpfua2H6BYfocg
         4LpYkW0FfyUQ2wu/6rfVUpH82i3G+zQaOFqRfGIJLCRSbXGBMTfudww+RfYmWqg0D0R+
         G51SwLDUCJ8zijmWscSTKLEIp/xJUw+zK/aoJQDdkwXOB+IBIVSVkhAnhdwUGyiW9PQ3
         qyUHXTxVhIUBpf/hlZklOJtIZrfzMmkk7Z4yNxzSvxu8DWJhskCPar/c5MRzoZhv6+r2
         NFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MwYdhQUMKM80wPh7YuwuNf+VaOf3JJj67pkQcNVle6s=;
        b=MthqiK1RkkbwtUCvyv7nvLkfg4KR7X2+B9j5E25NbFx7Aec/UBFOSx8mtOSocXOvu5
         hxXz9eWvG/9+QABo9FP7CjmCBwYMkmrZDda+QMx2/UU3d+fVpnA3dDXTHyrV0tPc5M2G
         rDmKUTo+HAQgBgZFQwQVtWyPiktyJ6+Pdi4018uTNSnWxbyvcUFIWWRcJjrZ45t5lQI9
         XcPmU9iCl5lNaPAFE16OPlYklPxqrFVLatf1S2LJcWoEJOvMpv4MxuUBfKSXBIkdvrxL
         CpJXuDMV/xQAkwPCjqJ6s+KYkXOf5RQ4gNsRyypA9obl0ngjJyqiAtgKKJy8cBIY/Eoy
         0yDg==
X-Gm-Message-State: AOAM530BEAK4wdNX4Cc+JfTnnc4fyYN1lFejZiRi8361qrMu3KMAWXvL
        gV9+bVKnCnaCCo9Y1jWvPtLxFwlyZU0=
X-Google-Smtp-Source: ABdhPJyCYpfN8dYCFBgo2XSarVvyR23ilELorS+IBw3QcxRjp2z4tDMU0DS0pgtEdHZL7cXgYwFwHQ==
X-Received: by 2002:a2e:9e57:: with SMTP id g23mr16268445ljk.123.1620929895787;
        Thu, 13 May 2021 11:18:15 -0700 (PDT)
Received: from localhost.localdomain (81-231-136-235-no600.tbcn.telia.com. [81.231.136.235])
        by smtp.gmail.com with ESMTPSA id v8sm554153ljn.17.2021.05.13.11.18.14
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 May 2021 11:18:15 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 5/6] git-svn.txt: change verse to listing block
Date:   Thu, 13 May 2021 20:17:44 +0200
Message-Id: <96c5a7ce800b37306274a6725ad44582fefb06a8.1620928059.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.31.1.751.gd2f1c929bd
In-Reply-To: <cover.1620928059.git.martin.agren@gmail.com>
References: <cover.1620928059.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Unlike AsciiDoc, Asciidoctor seems to leave out an empty line after a verse
in a list continuation:

  allow only certain refs.

       config key: svn-remote.<name>.ignore-refs
  If the ignore-refs configuration key is ...

We could probably convince Asciidoctor do this differently, but thinking
about it, there's no real reason for a "verse" here. We might as well
use a listing block.

This is the only place in our documentation that uses this "config key:
foo.bar" construction. We could rework it into prose ("This option
overrides the foo.bar configuration, which defaults to baz."). Right
now, let's just solve the immediate issue of the missing empty line when
we use Asciidoctor to generate the manpage.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git-svn.txt | 45 ++++++++++++++++++++++++++-------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index d5776ffcfd..4e62dc37e7 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -148,8 +148,9 @@ the same local time zone.
 	`^refs/remotes/origin/(?!tags/wanted-tag|wanted-branch).*$`
 	can be used to allow only certain refs.
 +
-[verse]
+------------
 config key: svn-remote.<name>.ignore-refs
+------------
 +
 If the ignore-refs configuration key is set, and the command-line
 option is also given, both regular expressions will be used.
@@ -161,8 +162,9 @@ option is also given, both regular expressions will be used.
 	(including automatic fetches due to 'clone', 'dcommit',
 	'rebase', etc) on a given repository.
 +
-[verse]
+------------
 config key: svn-remote.<name>.ignore-paths
+------------
 +
 If the ignore-paths configuration key is set, and the command-line
 option is also given, both regular expressions will be used.
@@ -191,8 +193,9 @@ Skip "branches" and "tags" of first level directories;;
 	'rebase', etc) on a given repository. `--ignore-paths` takes
 	precedence over `--include-paths`.
 +
-[verse]
+------------
 config key: svn-remote.<name>.include-paths
+------------
 
 --log-window-size=<n>;;
 	Fetch <n> log entries per request when scanning Subversion history.
@@ -267,9 +270,10 @@ Use of 'dcommit' is preferred to 'set-tree' (below).
 	reused if a user is later given access to an alternate transport
 	method (e.g. `svn+ssh://` or `https://`) for commit.
 +
-[verse]
+------------
 config key: svn-remote.<name>.commiturl
 config key: svn.commiturl (overwrites all svn-remote.<name>.commiturl options)
+------------
 +
 Note that the SVN URL of the commiturl config key includes the SVN branch.
 If you rather want to set the commit URL for an entire SVN repository use
@@ -286,8 +290,9 @@ discouraged.
 	branches, use a single space character between the branches
 	(`--mergeinfo="/branches/foo:1-10 /branches/bar:3,5-6,8"`)
 +
-[verse]
+------------
 config key: svn.pushmergeinfo
+------------
 +
 This option will cause git-svn to attempt to automatically populate the
 svn:mergeinfo property in the SVN repository when possible. Currently, this can
@@ -548,9 +553,10 @@ Assume you have local changes in "master", but you need to refetch "r2".
 Fix the ignore-paths or SVN permissions problem that caused "r2" to
 be incomplete in the first place.  Then:
 +
-[verse]
+------------
 git svn reset -r2 -p
 git svn fetch
+------------
 +
 ------------
     r1---r2'--r3' remotes/git-svn
@@ -562,8 +568,9 @@ Then fixup "master" with 'git rebase'.
 Do NOT use 'git merge' or your history will not be compatible with a
 future 'dcommit'!
 +
-[verse]
+------------
 git rebase --onto remotes/git-svn A^ master
+------------
 +
 ------------
     r1---r2'--r3' remotes/git-svn
@@ -608,8 +615,9 @@ removed by default if there are no files left in them.  Git
 cannot version empty directories.  Enabling this flag will make
 the commit to SVN act like Git.
 +
-[verse]
+------------
 config key: svn.rmdir
+------------
 
 -e::
 --edit::
@@ -619,8 +627,9 @@ Edit the commit message before committing to SVN.  This is off by
 default for objects that are commits, and forced on when committing
 tree objects.
 +
-[verse]
+------------
 config key: svn.edit
+------------
 
 -l<num>::
 --find-copies-harder::
@@ -629,9 +638,10 @@ config key: svn.edit
 They are both passed directly to 'git diff-tree'; see
 linkgit:git-diff-tree[1] for more information.
 +
-[verse]
+------------
 config key: svn.l
 config key: svn.findcopiesharder
+------------
 
 -A<filename>::
 --authors-file=<filename>::
@@ -648,8 +658,9 @@ will abort operation. The user will then have to add the
 appropriate entry.  Re-running the previous 'git svn' command
 after the authors-file is modified should continue operation.
 +
-[verse]
+------------
 config key: svn.authorsfile
+------------
 
 --authors-prog=<filename>::
 	If this option is specified, for each SVN committer name that
@@ -664,8 +675,9 @@ relative to the current directory for 'init' and 'clone' and relative
 to the root of the working tree for 'fetch'. If 'filename' is
 not found, it is searched like any other command in '$PATH'.
 +
-[verse]
+------------
 config key: svn.authorsProg
+------------
 
 -q::
 --quiet::
@@ -704,8 +716,9 @@ creating the branch or tag.
 	'dcommit' operations), look for the first `From:` line or `Signed-off-by` trailer
 	in the log message and use that as the author string.
 +
-[verse]
+------------
 config key: svn.useLogAuthor
+------------
 
 --add-author-from::
 	When committing to svn from Git (as part of 'set-tree' or 'dcommit'
@@ -714,8 +727,9 @@ config key: svn.useLogAuthor
 	Git commit's author string.  If you use this, then `--use-log-author`
 	will retrieve a valid author string for all commits.
 +
-[verse]
+------------
 config key: svn.addAuthorFrom
+------------
 
 ADVANCED OPTIONS
 ----------------
@@ -749,8 +763,9 @@ ADVANCED OPTIONS
 	process. This feature is enabled by default, use
 	--no-follow-parent to disable it.
 +
-[verse]
+------------
 config key: svn.followparent
+------------
 
 CONFIG FILE-ONLY OPTIONS
 ------------------------
-- 
2.31.1.751.gd2f1c929bd

