Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A08C4320E
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FBF2610A1
	for <git@archiver.kernel.org>; Thu,  2 Sep 2021 16:01:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346070AbhIBQCY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Sep 2021 12:02:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346051AbhIBQCX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Sep 2021 12:02:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A532C061575
        for <git@vger.kernel.org>; Thu,  2 Sep 2021 09:01:24 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso1822145wmc.5
        for <git@vger.kernel.org>; Thu, 02 Sep 2021 09:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RtUsyAeUJ/k3K/euNY0PPsbF71kIwpn8u21Z004kHhI=;
        b=d8FRVNa0MZ3aeF6uppFFkrVfddc4cdbthjQ8mZoqYEtpGtTBkq8i4wo0rS/Dzbnr6D
         hBtfuSV6sYO3EeiHutbFG0GryCAi+IdGzkfmAAJII1LCwPaF2bP5QZf2VSFj4wFcZZmk
         zzffVbw2gZa7/tn2PMLtx7QQ+Lkw1y8caq+uE2z4UDXjja916lMtyicdLS2C9uruVrIP
         KZ/civ8V+DN/zT4blTBNIilqT93cYQF7TL/6VFUgb1iKcZ5toZEpK7yFOzxIDEq67Ku2
         d0H6gULN2RiYGvWFyBeDPe7Rbtx8c/3E02AEVBwhQj7dla58rmWk/QZGLjvlMCae5dVD
         x8Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RtUsyAeUJ/k3K/euNY0PPsbF71kIwpn8u21Z004kHhI=;
        b=Bsqmv0nXaSYi5XYBOFRNSe8HWtPQZxOgkSmkSYGhhM9vxO5GKDTS04JpUpN6jVPMes
         b2k1tj7u+/BLp/BY5FzQGVe5G55oFBBCAXmc3edXndcRPI1QjCJruz/Juf1rQ3/GLgbh
         56zHW/c7Vs4NVZxjF+TcNBJm6maAJppgCVQTl9HREWwLcSqT5fG1u6C8/eccAOKMTPWi
         nvzOaWLqFF15Yvmo1537KAdP7sVvIOug8Cfriw6KXc8cbyq3kAxCDDiduYT5q0RHGCzO
         viyuDbbIJHlLoyu4QyTaFKZW9AFvsDEupiqEZH2uPDilbsXCuOH4AT0wtsXDWe4jocn1
         ZrQw==
X-Gm-Message-State: AOAM532C83JWPtNjWzkqfFhd916CrOjnB38fNIE68+fux5V4B/4AzCVB
        1ZxegkjFPauNl5BYdir2zZZt2eeGPL6DYQ==
X-Google-Smtp-Source: ABdhPJy42zVvB4MYk4nbuWsBY8ewrT2hx6lI/fs9zfV6+h1msQ16LRY1qo8FrehwsRGESaguROtLBQ==
X-Received: by 2002:a7b:c097:: with SMTP id r23mr3956492wmh.114.1630598482761;
        Thu, 02 Sep 2021 09:01:22 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u26sm2403215wrd.32.2021.09.02.09.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 09:01:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Wong <e@80x24.org>, Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/9] git-sh-setup: remove unused set_reflog_action() function
Date:   Thu,  2 Sep 2021 18:01:08 +0200
Message-Id: <patch-1.9-2e3ed8061d5-20210902T155758Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.814.gb82868f05f3
In-Reply-To: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
References: <cover-0.9-00000000000-20210902T155758Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the set_reflog_action() function last used in the
git-legacy-rebase.sh script removed in d03ebd411c6 (rebase: remove the
rebase.useBuiltin setting, 2019-03-18).

When the documentation I'm removing from git.txt was added in
c3e2d18996e (setup_reflog_action: document the rules for using
GIT_REFLOG_ACTION, 2013-06-19) we had git-pull.sh, git-am.sh and
git-rebase.sh using this in-tree, an addition to various example
scripts later removed in 49eb8d39c78 (Remove contrib/examples/*,
2018-03-25).

Since this part of the documentation was aimed at those writing
scripts in git.git we're long past the point where we should remove
it, this still leaves the description of the GIT_REFLOG_ACTION
variable.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-sh-setup.txt |  7 ------
 Documentation/git.txt          |  4 ----
 git-sh-setup.sh                | 42 ----------------------------------
 3 files changed, 53 deletions(-)

diff --git a/Documentation/git-sh-setup.txt b/Documentation/git-sh-setup.txt
index 8632612c31d..1ae15905492 100644
--- a/Documentation/git-sh-setup.txt
+++ b/Documentation/git-sh-setup.txt
@@ -40,13 +40,6 @@ die::
 usage::
 	die with the usage message.
 
-set_reflog_action::
-	Set `GIT_REFLOG_ACTION` environment to a given string (typically
-	the name of the program) unless it is already set.  Whenever
-	the script runs a `git` command that updates refs, a reflog
-	entry is created using the value of this string to leave the
-	record of what command updated the ref.
-
 git_editor::
 	runs an editor of user's choice (GIT_EDITOR, core.editor, VISUAL or
 	EDITOR) on a given file, but error out if no editor is specified
diff --git a/Documentation/git.txt b/Documentation/git.txt
index 6dd241ef838..38bc1403313 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -857,10 +857,6 @@ for full details.
 	track of the reason why the ref was updated (which is
 	typically the name of the high-level command that updated
 	the ref), in addition to the old and new values of the ref.
-	A scripted Porcelain command can use set_reflog_action
-	helper function in `git-sh-setup` to set its name to this
-	variable when it is invoked as the top level command by the
-	end user, to be recorded in the body of the reflog.
 
 `GIT_REF_PARANOIA`::
 	If set to `1`, include broken or badly named refs when iterating
diff --git a/git-sh-setup.sh b/git-sh-setup.sh
index 10d97641856..ee6935ca455 100644
--- a/git-sh-setup.sh
+++ b/git-sh-setup.sh
@@ -106,48 +106,6 @@ $LONG_USAGE")"
 	esac
 fi
 
-# Set the name of the end-user facing command in the reflog when the
-# script may update refs.  When GIT_REFLOG_ACTION is already set, this
-# will not overwrite it, so that a scripted Porcelain (e.g. "git
-# rebase") can set it to its own name (e.g. "rebase") and then call
-# another scripted Porcelain (e.g. "git am") and a call to this
-# function in the latter will keep the name of the end-user facing
-# program (e.g. "rebase") in GIT_REFLOG_ACTION, ensuring whatever it
-# does will be record as actions done as part of the end-user facing
-# operation (e.g. "rebase").
-#
-# NOTE NOTE NOTE: consequently, after assigning a specific message to
-# GIT_REFLOG_ACTION when calling a "git" command to record a custom
-# reflog message, do not leave that custom value in GIT_REFLOG_ACTION,
-# after you are done.  Other callers of "git" commands that rely on
-# writing the default "program name" in reflog expect the variable to
-# contain the value set by this function.
-#
-# To use a custom reflog message, do either one of these three:
-#
-# (a) use a single-shot export form:
-#     GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: preparing frotz" \
-#         git command-that-updates-a-ref
-#
-# (b) save the original away and restore:
-#     SAVED_ACTION=$GIT_REFLOG_ACTION
-#     GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: preparing frotz"
-#     git command-that-updates-a-ref
-#     GIT_REFLOG_ACITON=$SAVED_ACTION
-#
-# (c) assign the variable in a subshell:
-#     (
-#         GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: preparing frotz"
-#         git command-that-updates-a-ref
-#     )
-set_reflog_action() {
-	if [ -z "${GIT_REFLOG_ACTION:+set}" ]
-	then
-		GIT_REFLOG_ACTION="$*"
-		export GIT_REFLOG_ACTION
-	fi
-}
-
 git_editor() {
 	if test -z "${GIT_EDITOR:+set}"
 	then
-- 
2.33.0.814.gb82868f05f3

