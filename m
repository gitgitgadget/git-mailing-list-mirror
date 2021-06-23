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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECCAEC48BDF
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:48:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2111611CE
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 00:48:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbhFWAum (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 20:50:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbhFWAum (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 20:50:42 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DB6BC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:48:25 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id v22-20020a0568301416b029044e2d8e855eso289061otp.8
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 17:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ntO3xV4Jej1nnbMr5CU7BnvPHVQs5mctUyuwYN6R+8=;
        b=ZdgmB1XAfgNtOi8LGW+55+F1sT09S7TjF8Wdz4gnmQ4vzLQJuMrNR9hV15UY03OGNP
         0VJ2TL1tF6rpq/S7vXhLa8+Szy8XCPUlTVSkUCtYlSI80hcm7shx/95+rvln6eD/rGoW
         oxkOQ1vtvN5Bq4ygpLQklOigrevkg1VzjrAIxxxUwuPTza0DuCVuypSgk14gt/Tq+huX
         s5WIqHhHVmJc9wPUml7sQzvJ5nGu9FoxURwg+dMdiD2g7v6bcvBXz5KzQGZAZuCqrMdK
         HJWYGIft21pfryjt5yhiMzLNe4OB4CDVjOPccfby1i4v9VaHt4xmy1/sZ+DkDUBetxqT
         PM5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ntO3xV4Jej1nnbMr5CU7BnvPHVQs5mctUyuwYN6R+8=;
        b=ToJBLjilSQmg3bUjjnVASZl8DNgt72ZsYlWfDcYTv5+ha+V4OJowJj3M4yj6qd5q5U
         j1cT6KQGgQTtnFvTyzbdd0rlbOUdLcuSs7TH/Tw9GPGIivTDLbaP1tvreZnzOmMeXlFJ
         iLrMge2hL1Q0IMLsPRELNfIZbhnBpTlA1yDErUWlr1729yeBsZWgZlLqmh5uUBkl3gD2
         px64i1B6vYlMSfEvQ17m2mP07y2gnLXjKYRMpAcbgsmJrsBDYoWTRh7gNBG/fk+lRijV
         akKzH5YR4tYx6dHPlffEMWalvfrC1tjVQp5Qj5PnaNGHJKzoIAhQueHd95g1CYkRz4bH
         Y2Xg==
X-Gm-Message-State: AOAM532bbw/JSPI+OYYtrmyRLyK4kMkX4jES6NAyHI5SDF0a1658kDTz
        sOdBE7Sa68/iKqCaMA15aAlnuPDTx5Daeg==
X-Google-Smtp-Source: ABdhPJxUoyj1r8Cfxpu1mtu0Q7WVtZYKatYAGZyS7MsinEtAjaixeAu3zRgLZi9i3f6YFslBh35L7Q==
X-Received: by 2002:a9d:6c88:: with SMTP id c8mr5344591otr.238.1624409304763;
        Tue, 22 Jun 2021 17:48:24 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id h17sm841551oop.21.2021.06.22.17.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 17:48:24 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 1/2] doc: pull: explain what is a fast-forward
Date:   Tue, 22 Jun 2021 19:48:14 -0500
Message-Id: <20210623004815.1807-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210623004815.1807-1-felipe.contreras@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210623004815.1807-1-felipe.contreras@gmail.com>
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
2.32.0

