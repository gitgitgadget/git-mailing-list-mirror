Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DD79C433DF
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBCDF20657
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 20:52:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PN1Zd6AJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2409041AbgJPUwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 16:52:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408932AbgJPUwm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 16:52:42 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2624FC0613D3
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:52:42 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m62so3661734ybb.6
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 13:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=JxpME0l3M7SwGpZHKqs3ftcYpKUSjuNgNtUBE/V8JUg=;
        b=PN1Zd6AJKSWuC+lqq+01HRlJppXwF6v5rBNrgCcbMS4FTKgJAj9bBlXzkbr+0F6an8
         v4TyYMr3ykFtuWRhkVf9J/47lQK58ezmDMV0ypXrSfAbVgCzqWa50Knvxxxq6JYErXZi
         4DbC/Rz1F2xe10dDqfF6HFUrZk+wx/NLtV0EhNEQ4jNUS5oQl6DlnRSsHrFewEM7d4m1
         GIPig5kWd2Ntp6nuCOTcv4WRlBqxTArYdyGAJ+EzSLlwUU2x8M9cxDgiziIJLdXboJvD
         npgZLox6BBWDRn0Q0ZyrOodwUcgmiGNArOh6coUQK/9jKfS8g5Z6J4pu/orvqUz+QMQZ
         7Evw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JxpME0l3M7SwGpZHKqs3ftcYpKUSjuNgNtUBE/V8JUg=;
        b=JDfjDFXeOAoq9caMc2bisGy2xtMnSeAWk/6uL/dCow743+zGZbKkvnCJQewTu0XtTL
         wFS22WAKcLsODh82VuE6zoZfUweg1CZ5oiZqMWwbFwqEPIKg4Rt7dDdsregZrMCzfGfq
         WuFq0fSyKSWnYKNUyjniiBstTdKWqs1p5FAEtJEFi8TXTfRdZvh7jcuUk3C18feCq26D
         tmoOsmb3KldGPyS7A8FaXqzwLs5ZUeOqMQcju2i8QhK99SdO1X8vmMiSH5TiSpm4aStf
         nZjIvKALOJVOR47xbC/xMj6OWCtmwsIlddSmRoov/WYzq40/e4PrbjeWnzavUuAKVrnw
         xZzg==
X-Gm-Message-State: AOAM530hXpkERYxFlVC+JIUZTBaujfbbkWhkMG31ZrSyxSb4uQHCFJov
        t6aRgJYspuhiSSEJbLXR4O5VXbe1hF58iwSEPMRdAGIfGqVheHMKkuglsUR3gZOmyEAEospD/o5
        1qUZeqA0LJREWgwLt3tKnZ4QUjFJm3kjsyseDtiAAjZt4O8Di5dbOB8VIupNQUKjOQ0tWsbjWIg
        ==
X-Google-Smtp-Source: ABdhPJx7PhA/zhmigTVnyqGvTNPlNZJ0eCYucfQvhFE1mrGIWBtXwixe6tw5+cHqhVBHnw3eOnIA8fkYZkuDMibrbao=
Sender: "emilyshaffer via sendgmr" 
        <emilyshaffer@podkayne.svl.corp.google.com>
X-Received: from podkayne.svl.corp.google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
 (user=emilyshaffer job=sendgmr) by 2002:a25:b8c9:: with SMTP id
 g9mr7131281ybm.431.1602881561280; Fri, 16 Oct 2020 13:52:41 -0700 (PDT)
Date:   Fri, 16 Oct 2020 13:52:32 -0700
In-Reply-To: <20201016205232.2546562-1-emilyshaffer@google.com>
Message-Id: <20201016205232.2546562-3-emilyshaffer@google.com>
Mime-Version: 1.0
References: <20201016205232.2546562-1-emilyshaffer@google.com>
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH 2/2] docs: demonstrate difference between 'am' and 'apply'
From:   Emily Shaffer <emilyshaffer@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some users skimmed past the note in 'git help apply' mentioning 'git
am' and weren't sure how to retain commit details. An example
illustrating the difference between the two shows this information in
another way, so users who prefer to be shown rather than told can
discover the difference too.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
---

Notes:
    In this change, I wasn't sure about a few things:
    
    - Should the comments on the snippets live outside of the blockquote instead?
    - Should 'git reset' be included in the snippets, so that users don't try to
      paste without thinking?
    - Should the example go underneath the options list?
    
    Anyway, we got internal feedback that the description in 'git help am' wasn't
    very noticeable. I'm not sure I agree, but it's true that some folks grok
    examples more easily than they grok prose, so we figured it probably couldn't
    hurt to provide both.
    
     - Emily

 Documentation/git-am.txt    | 58 +++++++++++++++++++++++++++++++++++++
 Documentation/git-apply.txt | 55 +++++++++++++++++++++++++++++++++++
 2 files changed, 113 insertions(+)

diff --git a/Documentation/git-am.txt b/Documentation/git-am.txt
index 38c0852139..e64f3f10e3 100644
--- a/Documentation/git-am.txt
+++ b/Documentation/git-am.txt
@@ -24,6 +24,64 @@ Splits mail messages in a mailbox into commit log message,
 authorship information and patches, and applies them to the
 current branch.
 
+This command applies patches as commits. Use linkgit:git-apply[1] to apply
+patches to the worktree without creating commits.
+
+EXAMPLE
+-------
+....
+# our sample patch, generated with 'git format-patch'
+$ cat ~/0001-README-add-more-text.patch
+From f9e01d7538c9d58b48500732b4f98f40f6ad845e Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Fri, 16 Oct 2020 13:14:42 -0700
+Subject: [PATCH] README: add more text
+
+Some additional context.
+
+Signed-off-by: A U Thor <author@example.com>
+---
+ README | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/README b/README
+index cd08755..cfdf4e7 100644
+--- a/README
++++ b/README
+@@ -1 +1 @@
+-Hello world!
++Hello world! This is an example.
+--
+2.29.0.rc1.297.gfa9743e501
+
+# use 'git am' to create a new commit with details from the patch
+$ git status
+On branch main
+nothing to commit, working tree clean
+$ git am ~/0001-README-add-more-text.patch
+Applying: README: add more text
+$ git status
+On branch main
+nothing to commit, working tree clean
+$ git log --oneline
+dd6a400 (HEAD -> main) README: add more text
+90b59fb base commit
+
+# use 'git apply' to apply to the worktree without creating a commit.
+$ git status
+On branch main
+nothing to commit, working tree clean
+$ git apply ~/0001-README-add-more-text.patch
+$ git status
+On branch main
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git restore <file>..." to discard changes in working directory)
+	modified:   README
+
+no changes added to commit (use "git add" and/or "git commit -a")
+....
+
 OPTIONS
 -------
 (<mbox>|<Maildir>)...::
diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index 91d9a8601c..38e9d8f713 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -32,6 +32,61 @@ This command applies the patch but does not create a commit.  Use
 linkgit:git-am[1] to create commits from patches generated by
 linkgit:git-format-patch[1] and/or received by email.
 
+EXAMPLE
+-------
+....
+# our sample patch, generated with 'git format-patch'
+$ cat ~/0001-README-add-more-text.patch
+From f9e01d7538c9d58b48500732b4f98f40f6ad845e Mon Sep 17 00:00:00 2001
+From: A U Thor <author@example.com>
+Date: Fri, 16 Oct 2020 13:14:42 -0700
+Subject: [PATCH] README: add more text
+
+Some additional context.
+
+Signed-off-by: A U Thor <author@example.com>
+---
+ README | 2 +-
+ 1 file changed, 1 insertion(+), 1 deletion(-)
+
+diff --git a/README b/README
+index cd08755..cfdf4e7 100644
+--- a/README
++++ b/README
+@@ -1 +1 @@
+-Hello world!
++Hello world! This is an example.
+--
+2.29.0.rc1.297.gfa9743e501
+
+# use 'git apply' to apply to the worktree without creating a commit.
+$ git status
+On branch main
+nothing to commit, working tree clean
+$ git apply ~/0001-README-add-more-text.patch
+$ git status
+On branch main
+Changes not staged for commit:
+  (use "git add <file>..." to update what will be committed)
+  (use "git restore <file>..." to discard changes in working directory)
+	modified:   README
+
+no changes added to commit (use "git add" and/or "git commit -a")
+
+# use 'git am' to create a new commit with details from the patch
+$ git status
+On branch main
+nothing to commit, working tree clean
+$ git am ~/0001-README-add-more-text.patch
+Applying: README: add more text
+$ git status
+On branch main
+nothing to commit, working tree clean
+$ git log --oneline
+dd6a400 (HEAD -> main) README: add more text
+90b59fb base commit
+....
+
 OPTIONS
 -------
 <patch>...::
-- 
2.28.0.rc0.142.g3c755180ce-goog

