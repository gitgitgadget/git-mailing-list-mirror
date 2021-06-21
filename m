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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A641C49EAF
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:54:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DF9F2611CE
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 17:54:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232864AbhFUR4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 13:56:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231877AbhFURzJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 13:55:09 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C22FC0611C3
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:52:38 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id s23so20783703oiw.9
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 10:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/ntO3xV4Jej1nnbMr5CU7BnvPHVQs5mctUyuwYN6R+8=;
        b=rfhCyZgFaeFnfdLr5zMOAXwMUr75RxxKH4zrRrIYqVerXzuXNFhpR1s6RjP3yjrTDf
         vs0E/Pyd87z7epwTLy0qoWudRaaWMqhVtiF9V2j2cxgv+ckuKa2B0wBsvMZ7GUTKckMv
         bMDlwAXbsZ5d7vDxnTo4nuVPbUbcAJ9Yu9rAgfXXxHVUJhwlOCjmRc/Q0qYvvoAc2PGN
         unf6xtvrlwpZSKu28hyWELJfojF8EId/S+xdK11b/B4nP2sLWS5VYOq6GVxOtlOdyW+p
         CftOAx7600gkju7oPtHjFDTcg8l4S12Tmf1Tc17L6tecG3EyrcI4u0KWg65XUJOOwQHU
         RaCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/ntO3xV4Jej1nnbMr5CU7BnvPHVQs5mctUyuwYN6R+8=;
        b=gUz6Y5ONzQQiUGCjBXOy//LHd7htep1G6getxhphtSbEERSTQ8+xjcgvJQArfVJe3V
         tQ+kVHb0C+P20Ax5WXqZFFaFQEZnj44NjF2XWMjev/zYZAJSQch75hZ2r0D173oVjGhJ
         yRbTTU+K8kT1ditPbosTlMqWmo9fgcLiIE6eFiOy4UDhPoDpi2zwp5twOIBhUQLS3v0a
         NTnXvfxuXWdVQcFgYEvUuVeFnCPp6CcM9YQLpwzlSCc2OR8D+SiXy/UiNstAwZKxEAom
         ewOcapxXblYczL+91r02Mwy2+y9cs8pUH1VGcO6s5q2VKHZIsJI5QCmGOEwvJmTI1KuA
         QMKA==
X-Gm-Message-State: AOAM533L8sAuinZ9eTiA2NbAhPBLUOT74eKrbj/skq+33oGK0a/EbvCc
        47H2gVGSkwTlz3xuIwebRhSISm9fF0uQHw==
X-Google-Smtp-Source: ABdhPJxV79T2rWVY9zSrespw1sjyXfW7lZ3kCLmJ7O68XtKGbKP8+dsGOnex7lXBGIoMG6dgoWCxcw==
X-Received: by 2002:a05:6808:15a0:: with SMTP id t32mr26739979oiw.90.1624297957811;
        Mon, 21 Jun 2021 10:52:37 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id s3sm3605378oiw.29.2021.06.21.10.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 10:52:37 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] doc: pull: explain what is a fast-forward
Date:   Mon, 21 Jun 2021 12:52:33 -0500
Message-Id: <20210621175234.1079004-2-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210621175234.1079004-1-felipe.contreras@gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
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

