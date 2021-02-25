Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4A08C433E0
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 09:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61F4264F35
	for <git@archiver.kernel.org>; Thu, 25 Feb 2021 09:17:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhBYJRN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Feb 2021 04:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236332AbhBYJOk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Feb 2021 04:14:40 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5299DC061756
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 01:13:59 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id i7so4569766wmb.0
        for <git@vger.kernel.org>; Thu, 25 Feb 2021 01:13:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=R5aP3q8lcYK1lJW/SDG4umudpmTtC7tXJnCNWijW9RU=;
        b=IHKe9NsRoESZjdnuN+/eRdImJNKkq05pGrECFnPRjGoeyM7d5Z9Y3++ZoUA75n3quw
         r1zaGAb2hSWRRXZfnRqnj1z/VXyg18HEs2ucvCN3TufKosppiwIMt9bZ17S8shUH+h2G
         07rhkro9hJS2aLvFOJBdcH5v9J6uKw67cIO0MwBFZkPPCb6cMENoW7OCMsV0is9OjqvE
         +C0ZyLEDP3XFkPfcB6ouhqzktSwzwUXTfd9UEL0p42qseEI9RkocLB8a02Gq5ZZopkJP
         z11xVOPclTC75PLntgg/qAjWVgRR3nLJnkcafJ/72Xfjg3OirLbgrSJBeHy+g6R3QWzJ
         rPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=R5aP3q8lcYK1lJW/SDG4umudpmTtC7tXJnCNWijW9RU=;
        b=rvOX7bLAkj6QdyHweFnQZcruACcAC4tDcBuCQvtfgCaws45nb37PXmvLuEdhQeRa/k
         ktZ4ZbuylJklHQ0KzYfQz6QpIGD0dGBcA8PVehEiKrfb8UhMxwxEU/jN2YqcH8m0gOo2
         79llcsv1I3ZL7VmB3T9D3sNMQ42tB+1ZlLqDEwLF37B7H9Je3eK+C+m8lBWe5TZ+tIC/
         IvIjhYKfPgkF5nTi+i8lPOTgcCnG9p6xxQ0OY/D2gdV/51XbWbCGXqugGV97IBmEQptD
         YPzBx+q6kQh9D3AjFgOL+U93Mai2WLQmC0jWQlwH5MOeXfHNgmCyUZ/HHlGeSZnZMboe
         LFwg==
X-Gm-Message-State: AOAM533dcOp9kW2+TKV9cWKq9te72UN0YWhaBV+eJbu8Vru5MRAYekaI
        NB4xJGx9P0cz6RCHPkYbCHJz3E1dLB0=
X-Google-Smtp-Source: ABdhPJxFHwK1Wgt5vqprEIi9Q8T2JKJ6XiRDkFpXQUyt/iTZR7YGDZQPQ5QDRqBa+d1TK8/TjwcSYg==
X-Received: by 2002:a05:600c:4ec6:: with SMTP id g6mr2219618wmq.72.1614244438069;
        Thu, 25 Feb 2021 01:13:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a1sm7667912wrx.95.2021.02.25.01.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Feb 2021 01:13:57 -0800 (PST)
Message-Id: <pull.745.v4.git.git.1614244436547.gitgitgadget@gmail.com>
In-Reply-To: <pull.745.v3.git.git.1603768321361.gitgitgadget@gmail.com>
References: <pull.745.v3.git.git.1603768321361.gitgitgadget@gmail.com>
From:   "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Feb 2021 09:13:56 +0000
Subject: [PATCH v4] clone: document partial clone section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Teng Long <dyroneteng@gmail.com>,
        Teng Long <dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Partial clones are created using 'git clone', but there is no related
help information in the git-clone documentation. Add a relevant section
to help users understand what partial clones are and how they differ
from normal clones.

The section briefly introduces the applicable scenarios and some
precautions of partial clone. If users want to know more about its
technical design and other details, users can view the link of
git-partial-clone(7) according to the guidelines in the section.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
    clone: document partial clone section
    
    Partial clones are created using 'git clone', but there is no related
    help information in the git-clone documentation during a period. Add a
    relevant section to help users understand what partial clones are and
    how they differ from normal clones.
    
    The section briefly introduces the applicable scenarios and some
    precautions of partial clone. If users want to know more about its
    technical design and other details, users can view the link of
    git-partial-clone(7) according to the guidelines in the section.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v4
Pull-Request: https://github.com/git/git/pull/745

Range-diff vs v3:

 1:  681c5dcb7904 ! 1:  6d543cc11378 clone: document partial clone section
     @@
       ## Metadata ##
     -Author: Dyrone Teng <dyroneteng@gmail.com>
     +Author: Teng Long <dyroneteng@gmail.com>
      
       ## Commit message ##
          clone: document partial clone section
      
          Partial clones are created using 'git clone', but there is no related
     -    help information in the git-clone documentation during a period. Add
     -    a relevant section to help users understand what partial clones are
     -    and how they differ from normal clones.
     +    help information in the git-clone documentation. Add a relevant section
     +    to help users understand what partial clones are and how they differ
     +    from normal clones.
      
          The section briefly introduces the applicable scenarios and some
          precautions of partial clone. If users want to know more about its


 Documentation/git-clone.txt | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c89831009989..15495675a8ce 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -308,6 +308,75 @@ or `--mirror` is given)
 	for `host.xz:foo/.git`).  Cloning into an existing directory
 	is only allowed if the directory is empty.
 
+Partial Clone
+-------------
+
+By default, `git clone` will download every reachable object, including
+every version of every file in the history of the repository. The **partial clone**
+feature allows Git to transfer fewer objects and request them from the
+remote only when they are needed, so some reachable objects can be
+omitted from the initial `git clone` and subsequent `git fetch`
+operations. In this way, a partial clone can reduce the network traffic
+costs and disk space usage when git is working under a large repository.
+
+To use the partial clone feature, you can run `git clone` with the 
+`--filter=<filter-spec>` option. If the repository has a deep history
+and you don't want to download any blobs, the form `filter=blob:none`
+will omit all the blobs. If the repository has some large blobs and you
+want to prevent some large blobs being downloaded by an appropriate
+threshold, the form `--filter=blob:limit=<n>[kmg]` omits blobs larger
+than n bytes or units (see linkgit:git-rev-list[1]).
+
+When using a partial clone, Git will request missing objects from the
+remote(s) when necessary. Several commands that do not involve a request
+over a network may now trigger these requests.
+
+For example, The <repository> contains two branches which names 'master'
+and 'topic. Then, we clone the repository by
+
+    $ git clone --filter=blob:none --no-checkout <repository>
+
+With the `--filter=blob:none` option Git will omit all the blobs and
+the `--no-checkout` option Git will not perform a checkout of HEAD
+after the clone is complete. Then, we check out the remote tracking
+'topic' branch by
+
+    $ git checkout -b topic origin/topic 
+
+The output looks like
+
+------------
+    remote: Enumerating objects: 1, done.
+    remote: Counting objects: 100% (1/1), done.
+    remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0
+    Receiving objects: 100% (1/1), 43 bytes | 43.00 KiB/s, done.
+    Branch 'topic' set up to track remote branch 'topic' from 'origin'.
+    Switched to a new branch 'topic'
+------------
+
+The output is a bit surprising but it shows how partial clone works.
+When we check out the branch 'topic' Git will request the missing blobs
+because they are needed. Then, We can switch back to branch 'master' by
+
+    $ git checkout master
+
+This time the output looks like
+
+------------
+    Switched to branch 'master'
+    Your branch is up to date with 'origin/master'.
+------------
+
+It shows that when we switch back to the previous location, the checkout
+is done without a download because the repository has all the blobs that
+were downloaded previously.
+
+`git log` may also make a surprise with partial clones. `git log
+--<path>` will not cause downloads with the blob filters, because it's
+only reading commits. `git log -p -- <path>` will download blobs to
+generate the patch output and git log --raw will download all blobs
+that changed at recent commits in order to compute renames.
+
 :git-clone: 1
 include::urls.txt[]
 

base-commit: e1cfff676549cdcd702cbac105468723ef2722f4
-- 
gitgitgadget
