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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 722C2C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3531123B88
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726230AbgLRVLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:11:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgLRVLK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:11:10 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 785F0C06138C
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:30 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id b24so3274506otj.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:10:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fqdgFuw3AE+7gvHj7goBAP/wOSj/ige0wAsPlIa238o=;
        b=CBJYOGx51bOxY3c+0rOq5S5Us4q7DZIHsz7z20MbWBQedQH2w8oeabfDtCBUOXgmIe
         lwxPb9y+3Hiv9OSoEq3j95OJLjIv5eSOpJqNeyhr+DgXfYAcBXxMS6sYrzTjgfV93aXi
         10/4IBqNkcjt2WCnaveIFZtRyTBlsT6GfiO7STNU4j9s3VMdk4rF0jMlwz6huVmI2Hhx
         rGkyQ1mB0RMTMwL+DWUgbXC6dQFx5Ob3LZBtXqtzZd7d6+kYU+fIIHOg1bIyy+zNBAyy
         FlVHKXj8sf/xzCxB7HSbcLMoVm5nl3ukE+wTNgfp4ODAyuCAcmfbK3Ip1HrSc/8U/Z6u
         57QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fqdgFuw3AE+7gvHj7goBAP/wOSj/ige0wAsPlIa238o=;
        b=PlcrshvIewBdzYQ/jqagiBzWXsLvG1d44AVsUhTnYoPKF9xeUQ9fX3Wt4WKcKSXw43
         nV/uI23QiqsKh6CkTvWmWET1NE4ySTi+acYW0TYhtTAwD5/6wwNEDa1q0ykhzqLnmJco
         8QQkFQgfovZ2ohzGCdq1n9q03WkJ4K1FONWKd/85+VNPW7Vpl5fnR/z/wpJCDpd00ycY
         KOa2il4ZHeMBoDhWd56nTfDBdX2UqLUbUIHk5//XukpPFi1p6fUhjlZ3GsYmv2GQ+axH
         /Rs8SYJcpxeoSDjygmE2eTQnAPxXhIRYSFIXE5jEKKWk6CB02DWbVdJl+dCa7eK1VPjM
         Jt3Q==
X-Gm-Message-State: AOAM532GiBEpbHY/ZWz8au7YEnP/dfYVtnOunxmZCjeQ5+iU6uQZTEDq
        oIETn9jIANzaxnav+LN47mo8sUA5elTppA==
X-Google-Smtp-Source: ABdhPJzXYkdBjPat9Yob4cnSpcOb67bTCjD8N3/88Cm0qgAsLfYGMJJiFxsPs9Am5V8HGAI9hFNJmQ==
X-Received: by 2002:a05:6830:1d71:: with SMTP id l17mr4309905oti.269.1608325829669;
        Fri, 18 Dec 2020 13:10:29 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id z189sm2005218oia.28.2020.12.18.13.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:10:29 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 01/13] doc: pull: explain what is a fast-forward
Date:   Fri, 18 Dec 2020 15:10:14 -0600
Message-Id: <20201218211026.1937168-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.30.0.rc0
In-Reply-To: <20201218211026.1937168-1-felipe.contreras@gmail.com>
References: <20201218211026.1937168-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We want users to know what is a fast-forward in order to understand the
default warning.

Let's expand the explanation in order to cover both the simple, and the
complex cases with as much detail as possible.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt | 41 ++++++++++++++++++++++++++++++++------
 1 file changed, 35 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..142df1c4a1 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -41,16 +41,41 @@ Assume the following history exists and the current branch is
 ------------
 	  A---B---C master on origin
 	 /
-    D---E---F---G master
+    D---E master
 	^
 	origin/master in your repository
 ------------
 
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
-until its current commit (`C`) on top of `master` and record the
-result in a new commit along with the names of the two parent commits
-and a log message from the user describing the changes.
+until its current commit (`C`) on top of `master`.
+
+After the remote changes have been synchronized, the local `master` will
+be fast-forwarded to the same commit as the remote one, therefore
+creating a linear history.
+
+------------
+    D---E---A---B---C master, origin/master
+------------
+
+However, a non-fast-forward case looks very different:
+
+------------
+	  A---B---C origin/master
+	 /
+    D---E---F---G master
+------------
+
+If there are additional changes in the local `master`, it's
+not possible to fast-forward, so a decision must be made how to
+synchronize the local, and remote brances.
+
+In these situations `git pull` will warn you about your possible
+options, which are either merge (`--no-rebase`), or rebase (`--rebase`).
+However, by default it will continue doing a merge.
+
+A merge will create a new commit with two parent commits (`G` and `C`)
+and a log message describing the changes, which you can edit.
 
 ------------
 	  A---B---C origin/master
@@ -58,8 +83,11 @@ and a log message from the user describing the changes.
     D---E---F---G---H master
 ------------
 
+Once the merge commit is created (`H`), your local `master` branch has
+incorporated the changes of the remote `master` branch.
+
 See linkgit:git-merge[1] for details, including how conflicts
-are presented and handled.
+are presented and handled, and also linkgit:git-rebase[1].
 
 In Git 1.7.0 or later, to cancel a conflicting merge, use
 `git reset --merge`.  *Warning*: In older versions of Git, running 'git pull'
@@ -248,7 +276,8 @@ version.
 
 SEE ALSO
 --------
-linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-config[1]
+linkgit:git-fetch[1], linkgit:git-merge[1], linkgit:git-rebase[1],
+linkgit:git-config[1]
 
 GIT
 ---
-- 
2.30.0.rc0

