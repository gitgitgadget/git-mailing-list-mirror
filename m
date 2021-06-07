Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E975C47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:58:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6835961003
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 16:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbhFGRAA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 13:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230250AbhFGQ77 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 12:59:59 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B742C061766
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 09:57:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z8so18392853wrp.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 09:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MnAvzeYdtATK/6fNagSayGNr+zypeWHQqkfM1++nxHM=;
        b=ZPLv4CVFLIYx8fnT0k+21YaeV3+hKoNffEm/XbgXIDNmN5EUl148dQR6SHWg8wgLF3
         DpB2h/shsO6qKnowvDxDC2tr+9Aya5sy727yux5eYKz3WdkoBihGhKL1oveXS5ppNXKv
         dJNV+5CN5/Nkt0ZWjanQsVzyPB3hzkJUdZdgt+E/KvEFT+vvQczFw+Xb7UjIe/ulcVgW
         GMrB697KXxgwr8+hbR+8g96bnbO1g7UhLaw/H6ngek4lnndS56WAn33cgIht++mQ6e+a
         xIprRFgdrFygWaaNctqIszrkW0mL5eXLWUvIWA7io4oAeu2aAFu35YG9toLGpgj0viWG
         DTZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MnAvzeYdtATK/6fNagSayGNr+zypeWHQqkfM1++nxHM=;
        b=kSh//VYil5r0dPBqvPCsxrjXArT+2UY6IVxRIV0My+II3LEVBC6sadFBidXyHoUtju
         0wi7vTiXtmnTLDHRRtz199ajrBe90J3csYDTLETmUxRwGIpuJtC1ejq1I1cpdkbKrHzi
         qavSZRUSGfm8Bzc8jjH0mvlowp5zIc8eed0nnfAqkI0AoHcjy8QusA58wN+i7g/bV0DT
         VTIpq6tfx4SpdyfI/IHwkL4fuMmFdCl6NnX2brhPvK1eB3npan6WCkSuzD1055thCgvv
         53ZanzYyIqj5PHpxh9cwLrCaKyP0yNWq/gFyTXzfFQ8hkFX4hnuiAKGtZtoJIllG/qWU
         pCMQ==
X-Gm-Message-State: AOAM533nqs19jM3uKBuoKi1c2iBVZx7OF4MdO1m2Kg5CkInJmsvh4b5w
        Aw2LNoz0QpPE7XVZrdu4eM98fCDW9R4=
X-Google-Smtp-Source: ABdhPJzCs6bbi2OAqdoc7yJ8U22QfL1UJy8Bf/hKVdV8goTVxVud4+OQyuTdtOAo+ZN60VKBHibfBQ==
X-Received: by 2002:a05:6000:1447:: with SMTP id v7mr17956014wrx.252.1623085071099;
        Mon, 07 Jun 2021 09:57:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o18sm62586wmq.23.2021.06.07.09.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 09:57:50 -0700 (PDT)
Message-Id: <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.975.git.1623085069.gitgitgadget@gmail.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 07 Jun 2021 16:57:45 +0000
Subject: [PATCH 1/4] Documentation: use singular they when appropriate
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, stolee@gmail.com,
        jrnieder@gmail.com, emilyshaffer@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

There are several instances in our documentation where we refer to an
anonymous user as "a contributor" or "an integrator" or similar. To
avoid repeating this role, pronouns are used. Previous examples
chose a gender for this user, using "he/him" or "she/her" arbitrarily.

Replace these uses with "they/them" to ensure that these documentation
examples apply to all potential users without exception.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/SubmittingPatches               |  2 +-
 Documentation/git-push.txt                    |  4 +-
 .../using-signed-tag-in-pull-request.txt      | 38 +++++++++----------
 Documentation/user-manual.txt                 |  2 +-
 4 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 55287d72e0ef..b518d3157f70 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -373,7 +373,7 @@ If you like, you can put extra tags at the end:
 . `Acked-by:` says that the person who is more familiar with the area
   the patch attempts to modify liked the patch.
 . `Reviewed-by:`, unlike the other tags, can only be offered by the
-  reviewer and means that she is completely satisfied that the patch
+  reviewer and means that they are completely satisfied that the patch
   is ready for application.  It is usually offered only after a
   detailed review.
 . `Tested-by:` is used to indicate that the person applied the patch
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index a953c7c38790..2f25aa3a291b 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -244,8 +244,8 @@ Imagine that you have to rebase what you have already published.
 You will have to bypass the "must fast-forward" rule in order to
 replace the history you originally published with the rebased history.
 If somebody else built on top of your original history while you are
-rebasing, the tip of the branch at the remote may advance with her
-commit, and blindly pushing with `--force` will lose her work.
+rebasing, the tip of the branch at the remote may advance with their
+commit, and blindly pushing with `--force` will lose their work.
 +
 This option allows you to say that you expect the history you are
 updating is what you rebased and want to replace. If the remote ref
diff --git a/Documentation/howto/using-signed-tag-in-pull-request.txt b/Documentation/howto/using-signed-tag-in-pull-request.txt
index bbf040eda8af..e9ad0b4ff8e0 100644
--- a/Documentation/howto/using-signed-tag-in-pull-request.txt
+++ b/Documentation/howto/using-signed-tag-in-pull-request.txt
@@ -1,8 +1,8 @@
 From: Junio C Hamano <gitster@pobox.com>
 Date: Tue, 17 Jan 2011 13:00:00 -0800
 Subject: Using signed tag in pull requests
-Abstract: Beginning v1.7.9, a contributor can push a signed tag to her
- publishing repository and ask her integrator to pull it. This assures the
+Abstract: Beginning v1.7.9, a contributor can push a signed tag to their
+ publishing repository and ask their integrator to pull it. This assures the
  integrator that the pulled history is authentic and allows others to
  later validate it.
 Content-type: text/asciidoc
@@ -11,9 +11,9 @@ How to use a signed tag in pull requests
 ========================================
 
 A typical distributed workflow using Git is for a contributor to fork a
-project, build on it, publish the result to her public repository, and ask
-the "upstream" person (often the owner of the project where she forked
-from) to pull from her public repository. Requesting such a "pull" is made
+project, build on it, publish the result to their public repository, and ask
+the "upstream" person (often the owner of the project where they forked
+from) to pull from their public repository. Requesting such a "pull" is made
 easy by the `git request-pull` command.
 
 Earlier, a typical pull request may have started like this:
@@ -32,7 +32,7 @@ followed by a shortlog of the changes and a diffstat.
 
 The request was for a branch name (e.g. `for-xyzzy`) in the public
 repository of the contributor, and even though it stated where the
-contributor forked her work from, the message did not say anything about
+contributor forked their work from, the message did not say anything about
 the commit to expect at the tip of the for-xyzzy branch. If the site that
 hosts the public repository of the contributor cannot be fully trusted, it
 was unnecessarily hard to make sure what was pulled by the integrator was
@@ -57,7 +57,7 @@ integrator, using Git v1.7.9 or later.
 A contributor or a lieutenant
 -----------------------------
 
-After preparing her work to be pulled, the contributor uses `git tag -s`
+After preparing their work to be pulled, the contributor uses `git tag -s`
 to create a signed tag:
 
 ------------
@@ -73,7 +73,7 @@ to justify why it is worthwhile for the integrator to pull it, as this
 message will eventually become part of the final history after the
 integrator responds to the pull request (as we will see later).
 
-Then she pushes the tag out to her public repository:
+Then they push the tag out to their public repository:
 
 ------------
  $ git push example.com:/git/froboz.git/ +frotz-for-xyzzy
@@ -94,10 +94,10 @@ The contributor then prepares a message to request a "pull":
 
 The arguments are:
 
-. the version of the integrator's commit the contributor based her work on;
-. the URL of the repository, to which the contributor has pushed what she
-  wants to get pulled; and
-. the name of the tag the contributor wants to get pulled (earlier, she could
+. the version of the integrator's commit the contributor based their work on;
+. the URL of the repository, to which the contributor has pushed what they
+  want to get pulled; and
+. the name of the tag the contributor wants to get pulled (earlier, they could
   write only a branch name here).
 
 The resulting msg.txt file begins like so:
@@ -130,7 +130,7 @@ command, the reader should notice that:
 
 The latter is why the contributor would want to justify why pulling her
 work is worthwhile when creating the signed tag.  The contributor then
-opens her favorite MUA, reads msg.txt, edits and sends it to her upstream
+opens their favorite MUA, reads msg.txt, edits and sends it to their upstream
 integrator.
 
 
@@ -163,20 +163,20 @@ In the editor, the integrator will see something like this:
 
 Notice that the message recorded in the signed tag "Completed frotz
 feature" appears here, and again that is why it is important for the
-contributor to explain her work well when creating the signed tag.
+contributor to explain their work well when creating the signed tag.
 
 As usual, the lines commented with `#` are stripped out. The resulting
 commit records the signed tag used for this validation in a hidden field
 so that it can later be used by others to audit the history. There is no
-need for the integrator to keep a separate copy of the tag in his
+need for the integrator to keep a separate copy of the tag in their
 repository (i.e. `git tag -l` won't list the `frotz-for-xyzzy` tag in the
-above example), and there is no need to publish the tag to his public
+above example), and there is no need to publish the tag to their public
 repository, either.
 
-After the integrator responds to the pull request and her work becomes
+After the integrator responds to the pull request and their work becomes
 part of the permanent history, the contributor can remove the tag from
-her public repository, if she chooses, in order to keep the tag namespace
-of her public repository clean, with:
+their public repository, if they choose, in order to keep the tag namespace
+of their public repository clean, with:
 
 ------------
  $ git push example.com:/git/froboz.git :frotz-for-xyzzy
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index f9e54b867417..4fe9be117c4a 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -2792,7 +2792,7 @@ A fast-forward looks something like this:
 
 In some cases it is possible that the new head will *not* actually be
 a descendant of the old head.  For example, the developer may have
-realized she made a serious mistake, and decided to backtrack,
+realized they made a serious mistake, and decided to backtrack,
 resulting in a situation like:
 
 ................................................
-- 
gitgitgadget

