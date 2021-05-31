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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40A54C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23CC8610A6
	for <git@archiver.kernel.org>; Mon, 31 May 2021 19:33:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbhEaTej (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 15:34:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231994AbhEaTea (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 15:34:30 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 927AFC06174A
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:48 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id w127so13197899oig.12
        for <git@vger.kernel.org>; Mon, 31 May 2021 12:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B+BCF3IT0nEFbKTMJPcLmTGSY9/Y47S32otMkyAq6Bo=;
        b=fWBwaa7bW07LDOjcd+YhZdH9HEagaBJ02pxICxZH4ease3cqiXZBWfeBx5ZEcFHQAE
         CZtvRQ91FE1hqtmmqUQyCfa3GJwb+LAX1SkTMrra/2g9Q0ZaKC4fexnyjrEDnK9bRzoV
         VskNctCx+3KhE8JtlRB7KkPTkOJcaAq4Dq7kCuc6qZGsNvAC211sK0fs0kyPd+YeN3Mx
         fFwXnWaf9/OoQ2ayN1Iu5Nz2V22pr52zpC8T5eb5OnZPcewZAf9arf5lU8tq0Iu4F9gr
         zA1hLDEejyXKWqPJjhnJxXq/ECAgXG+RvjFAZxnYdrrtoSf9mzD41tE2AlzmE04QjUaR
         kCxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B+BCF3IT0nEFbKTMJPcLmTGSY9/Y47S32otMkyAq6Bo=;
        b=AHVf2p7XJH2uCHoppmS1BtpaNDXoJwG5gijAhkS27leoEAY5wcMJdvR9JYPuaaIcvO
         GNs6Q2d5N1uHD2Cj6DUNY2R+vP9ajAvUQEwa9hqrpyeTI2GM3yEUcsmAbWdFUOy2SlE2
         2Jtk7A843klrCDROHzxUvBygK73qLdaxzFd/X4JxS3z6NKhbZ4YNzrD6geieicNpBe9+
         z6nuvdWjJBNMLccXor2wOc+zaJFDcnLVgOR7Ffg1F9q1eYbn8lj35MkwXa9Zgh++TD96
         NAsQl3rXguQLWbGVRANkjVgcfXUj9kV21gGeb57RHeu7nmuGTZxJsstlM/I5p//xeBuf
         PUYQ==
X-Gm-Message-State: AOAM530HD8NTOcOYXUPG+283J4qukcd9ZLQmu+0UxFolwlxQvC0UA7Wp
        MfYb3sY1uqubPXSmftZUymnGWryNBccPwg==
X-Google-Smtp-Source: ABdhPJzeypQ8ls6LQlHQN2oL+vivHesmXVQEm2Fs19Ghb/z7OsxUpcO2kuyXAZ+m5uLSnwHMXc/j4A==
X-Received: by 2002:aca:c488:: with SMTP id u130mr15192266oif.0.1622489567778;
        Mon, 31 May 2021 12:32:47 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id x11sm3252561otr.36.2021.05.31.12.32.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 12:32:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 4/7] push: reorganize setup_push_simple()
Date:   Mon, 31 May 2021 14:32:34 -0500
Message-Id: <20210531193237.216726-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.rc0
In-Reply-To: <20210531193237.216726-1-felipe.contreras@gmail.com>
References: <20210531193237.216726-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simply move the code around and remove dead code. In particular the
'!same_remote' conditional is a no-op since that part of the code is the
same_remote leg of the conditional beforehand.

No functional changes.

Suggestions-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/push.c | 29 ++++++++++++-----------------
 1 file changed, 12 insertions(+), 17 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 6a620a90e3..972d8e1cfd 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -225,13 +225,14 @@ static void setup_push_current(struct remote *remote, struct branch *branch)
 
 static void setup_push_simple(struct remote *remote, struct branch *branch, int same_remote)
 {
+	const char *dst;
+
+	if (!branch)
+		die(_(message_detached_head_die), remote->name);
+
 	if (!same_remote) {
-		if (!branch)
-			die(_(message_detached_head_die), remote->name);
-		refspec_appendf(&rs, "%s:%s", branch->refname, branch->refname);
+		dst = branch->refname;
 	} else {
-		if (!branch)
-			die(_(message_detached_head_die), remote->name);
 		if (!branch->merge_nr || !branch->merge || !branch->remote_name)
 			die(_("The current branch %s has no upstream branch.\n"
 			    "To push the current branch and set the remote as upstream, use\n"
@@ -243,20 +244,14 @@ static void setup_push_simple(struct remote *remote, struct branch *branch, int
 		if (branch->merge_nr != 1)
 			die(_("The current branch %s has multiple upstream branches, "
 			    "refusing to push."), branch->name);
-		if (!same_remote)
-			die(_("You are pushing to remote '%s', which is not the upstream of\n"
-			      "your current branch '%s', without telling me what to push\n"
-			      "to update which remote branch."),
-			    remote->name, branch->name);
-
-		if (1) {
-			/* Additional safety */
-			if (strcmp(branch->refname, branch->merge[0]->src))
-				die_push_simple(branch, remote);
-		}
 
-		refspec_appendf(&rs, "%s:%s", branch->refname, branch->merge[0]->src);
+		/* Additional safety */
+		if (strcmp(branch->refname, branch->merge[0]->src))
+			die_push_simple(branch, remote);
+
+		dst = branch->merge[0]->src;
 	}
+	refspec_appendf(&rs, "%s:%s", branch->refname, dst);
 }
 
 static int is_same_remote(struct remote *remote)
-- 
2.32.0.rc0

