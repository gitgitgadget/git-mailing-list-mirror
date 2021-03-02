Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A88C433E9
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CA6564F2D
	for <git@archiver.kernel.org>; Tue,  2 Mar 2021 15:28:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578657AbhCBP0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Mar 2021 10:26:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377871AbhCBO0w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Mar 2021 09:26:52 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47D7EC06178C
        for <git@vger.kernel.org>; Tue,  2 Mar 2021 06:25:37 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id o2so2436902wme.5
        for <git@vger.kernel.org>; Tue, 02 Mar 2021 06:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sjal/H8mN6vP3Wmi6iEZLJDw1CoVWNEjUqRc5UxJH8E=;
        b=eIp8hCQre6CrfxKEwHgWR68AtMnmYl1k1sAgu5G5nsHPvRw8yfv43U1aOhAPWHT9jN
         7O6FT7MNxAlQDcprmZXfCcMkJZ0FVR17NqHs12u6puvYi6yilDZvEh2I61zUYlUTtT5B
         j207RdHIKMdNAJgqTcdHgBq8XmFmBHDzkMahbNXWPbRl8I12Ip3aRXtsRM1/VbqIxzeL
         pYo+uckZ9SW67Jq3INaKnLNkZPIwDlxMsb6EYiXSfYi8u9+tIvmP5NTVZqW5+RDKg6oC
         DObG/0RRUiguXP8g/WaLaWzy82wrT9WJ/nkqtThw3j3aVe/XDmuKbPuzfEEbFy6FcDCQ
         5FTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sjal/H8mN6vP3Wmi6iEZLJDw1CoVWNEjUqRc5UxJH8E=;
        b=aeUrQTLTHI3vbjub/gaGVSBj8IrQQHuwSQi6RWuyFQJJsebZxjQcEgBxL71RQjXhaT
         yrLo/j8JROe3g/uXyuqrL7EjHAqMWGbsEjAhmALMA6oeMYbE4biinXyzCOCBjOxLYCCn
         UzLwRpzNt1WYkxPefvK8GfxueinhBcsCF5On9XLgFgcRZpdECLtwivBlXqTN6V+4iTfv
         02QfDBAULScsu76xJhXgFzMkXSWpex4c11PdUX/92982J6CFXgz3QKxobWS3A41BWaJv
         vTJ7O9/ujcqVv23gI3m2LGXivvOR1ScwE/oBNC5/qMS9V262WuT/ZwgCbANT/J9DVQf/
         aXMw==
X-Gm-Message-State: AOAM530ifKwfRGamX7QopnxqPYBOGrxaUuD8Vi2MxuHDhFkPXhTaYwa0
        9sc2/W+ExqZc7/64b1MJ96tcaOUh92Y=
X-Google-Smtp-Source: ABdhPJzUUYHvqRNO14dOJc2BwS+0Wlqi6jdkYXKAVns9lDMu+QapqtQRusJbQ6MIrAalt1t3rXYlCQ==
X-Received: by 2002:a1c:a306:: with SMTP id m6mr4136688wme.13.1614695135153;
        Tue, 02 Mar 2021 06:25:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q15sm28874103wrr.58.2021.03.02.06.25.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Mar 2021 06:25:34 -0800 (PST)
Message-Id: <pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com>
In-Reply-To: <pull.745.v4.git.git.1614244436547.gitgitgadget@gmail.com>
References: <pull.745.v4.git.git.1614244436547.gitgitgadget@gmail.com>
From:   "Teng Long via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 02 Mar 2021 14:25:32 +0000
Subject: [PATCH v5] clone: document partial clone section
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Teng Long <dyroneteng@gmail.com>,
        Dyrone Teng <dyroneteng@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Dyrone Teng <dyroneteng@gmail.com>

Partial clones are created using 'git clone', but there is no related
help information in the git-clone documentation during a period. Add
a relevant section to help users understand what partial clones are
and how they differ from normal clones.

The section briefly introduces the applicable scenarios and some
precautions of partial clone. If users want to know more about its
technical design and other details, users can view the link of
git-partial-clone(7) according to the guidelines in the section.

Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
    clone: document partial clone section
    
    cc: Philippe Blain levraiphilippeblain@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-745%2Fdyrone%2Fmaster-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-745/dyrone/master-v5
Pull-Request: https://github.com/git/git/pull/745

Range-diff vs v4:

 1:  6d543cc11378 ! 1:  681c5dcb7904 clone: document partial clone section
     @@
       ## Metadata ##
     -Author: Teng Long <dyroneteng@gmail.com>
     +Author: Dyrone Teng <dyroneteng@gmail.com>
      
       ## Commit message ##
          clone: document partial clone section
      
          Partial clones are created using 'git clone', but there is no related
     -    help information in the git-clone documentation. Add a relevant section
     -    to help users understand what partial clones are and how they differ
     -    from normal clones.
     +    help information in the git-clone documentation during a period. Add
     +    a relevant section to help users understand what partial clones are
     +    and how they differ from normal clones.
      
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
