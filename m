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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3FE8C4361B
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F2720702
	for <git@archiver.kernel.org>; Tue, 15 Dec 2020 08:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727633AbgLOIrE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 03:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgLOIrD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 03:47:03 -0500
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8731BC0617A6
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:23 -0800 (PST)
Received: by mail-oi1-x241.google.com with SMTP id f132so22497827oib.12
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 00:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZHFmxjQaoPxg9Bw0aqjYCzyRsQtdoz95gXOxQnZESo8=;
        b=AYYTfKlhIIAF2P85Yx0seJNu0JVc1cOwUqmV0ECt86pJJ6/EAUbAx+egxEIivo/UgF
         mWN49iYkL4N4P7X1StAl+V2S74R23QYC9aPK0U3VM1JG17ONMhNhcxXe01KdNDiyDFJW
         M0IBZKX0GTR/+vPXouZ4GrtbLfOwHdZt6cONMJZOctgddHCzWUueXndbbJWydn6nqdcq
         +hO6kVXefUl2dUFigOK+oxMxlptH2v0JIfg4EWVU+0CeVqUfywc/OYPp8mdMK2z6UzME
         5O4JAemWtuK9ljv2hd3KoRuWCNujPzZ069qB1ML5lAO2JNvPJtlZZNTvZr+MtMPmioAH
         Z4SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZHFmxjQaoPxg9Bw0aqjYCzyRsQtdoz95gXOxQnZESo8=;
        b=ecf2yONesKY0X1y+dARAJ0v5OyoFw6mDQbpK+yUZCr1A6YX/7NRpROnyLCgQuq1AJG
         NG68KfX3stus1xPOiMD++yaPERJZCF5pM4oXuiDcD1IiXQC/SX8UJN6uZO/0pWDJgJou
         NJw6XLPjnsbJYpf0qV4uNn65zMjg644QY1QFkB4ShJTJFSYOC/9LIijUQE8ljUZDJXHm
         9N0mbJU8Re6kw7e3TIHPgszCv6emPKzal/zGB6oLpO3AaI3Q4Xt3CC7ofkfwSuiFm5JH
         dlzme5svKv3UmvXsBSPUBXwfYT92AtZ9hn8+49ML8iqVgWIxKjTMifb+m0aAO8ozWJG9
         jd1w==
X-Gm-Message-State: AOAM531D1OIsTmyLy2rOgTEHp+TFjZM2TgTM0s9A6dBSdyKZ1czuix4d
        nkcEkOqIlQ/y2EFEXHurDcoOJNFnu0KZjA==
X-Google-Smtp-Source: ABdhPJx/J9k+VSN8hv0yMswvZ2RzGNJnp8dNnZpVRXGKBHV2HG1SylqAwkddAGZvLdXmbxRiN+/kfw==
X-Received: by 2002:aca:c3c3:: with SMTP id t186mr21005146oif.53.1608021982733;
        Tue, 15 Dec 2020 00:46:22 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id u85sm158841oif.57.2020.12.15.00.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 00:46:22 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC/PATCH 1/3] doc: pull: explain what is a fast-forward
Date:   Tue, 15 Dec 2020 02:46:17 -0600
Message-Id: <20201215084619.1631180-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201215084619.1631180-1-felipe.contreras@gmail.com>
References: <20201215084619.1631180-1-felipe.contreras@gmail.com>
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
 Documentation/git-pull.txt | 38 +++++++++++++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index 5c3fb67c01..e89d391b3b 100644
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
+options, which are either merge, or rebase. However, by default it will
+continue doing a merge.
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
-- 
2.29.2

