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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDADDC433ED
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:30:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 927FD613BE
	for <git@archiver.kernel.org>; Thu,  6 May 2021 06:30:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232085AbhEFGbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 02:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbhEFGbu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 02:31:50 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F56DC061574
        for <git@vger.kernel.org>; Wed,  5 May 2021 23:30:53 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id gj14so2794660pjb.5
        for <git@vger.kernel.org>; Wed, 05 May 2021 23:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Pw21w6MsiF4+N0uhlm7DQI1j93rKduhG5GUXFrCdmc=;
        b=UfIR+8lfpwN0cxq9TC2q9h7Egya2V/M1t7QAxry5Z84N/lfAjfkykhB3ArZyiTQYUl
         hu/uM85LzfzJFdYHyELFpCIvCWLALqvV5aOGRljs/2BZvUt8I1VgoD+DGf5vnoIWisok
         yIbflnJJU6JEk7tvOEqPVF6cdouZRdKxGed7+TeSZejR929Dhcu4tdVy7b63PVqczQiq
         RatghSqcXvcGqchr0f26dl2N/x9dj5kBt5/CV01TnNGmtEbv8W24vAhAP3r16xQRiWFJ
         6/CdzFkoRZ3k+3Eb9pL9lPhi/eG3v91xuX/acotuLYnToGMoTwHqrzh/em8vY1GEc4qE
         KBAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Pw21w6MsiF4+N0uhlm7DQI1j93rKduhG5GUXFrCdmc=;
        b=ShqBtedP801iYw9DGvC+sTOKvlaSNbULmCwkjA3DC41Go5DLBItVkNhtqk7On8ZeyC
         YADsPoikR/T1ihFZwme6laMNdVRYQHWqu4WPd8PsvZFEEZ7xKNnIhHCvma3RmF7oJFWc
         i8+xAmJ6xs5dY1AlukmSj+C5FQGF3XIKfCAftY328HR84hobya8zCQZ47t89OxT/mdCm
         4btYq1bNq78HNbJohtsEY0eEHHcTL+G76DnPWduiSiXTWjDn1M0nEqZIVCRhm0n5WMh0
         ZH/iiWDgdm3Ud0Ie1AcP4RA+PRXNeRlLVLaGDwMDZ8QFaex5Vr77wgKc946xJC/kwaEu
         UqVA==
X-Gm-Message-State: AOAM532C6hG56e930CrzcLAFAln3o3o7C3bHhHa0T/f+D5sfW1UTDJR7
        HWhyjlBW8N+XDFrTqih7A88=
X-Google-Smtp-Source: ABdhPJwz+U9QEX6XEAb0O+TRfmrakPx+nS3O9IdcePexkDtVhsaphb26t64TEifMU5ytTip5auHsuw==
X-Received: by 2002:a17:902:d386:b029:ee:bf5f:c037 with SMTP id e6-20020a170902d386b02900eebf5fc037mr2808890pld.31.1620282652771;
        Wed, 05 May 2021 23:30:52 -0700 (PDT)
Received: from localhost.localdomain ([47.89.83.80])
        by smtp.gmail.com with ESMTPSA id f201sm1067458pfa.133.2021.05.05.23.30.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 May 2021 23:30:52 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     gitgitgadget@gmail.com
Cc:     dyroneteng@gmail.com, git@vger.kernel.org
Subject: [PATCH 1/1] clone: document partial clone section
Date:   Thu,  6 May 2021 14:30:46 +0800
Message-Id: <20210506063046.23353-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com>
References: <pull.745.v5.git.git.1614695133486.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 Documentation/git-clone.txt | 69 +++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index c898310099..15495675a8 100644
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
 
-- 
2.31.1

