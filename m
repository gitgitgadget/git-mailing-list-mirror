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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B26DBC2BB9A
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 83C052339E
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 22:28:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgLPW2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 17:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgLPW2q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 17:28:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 686E9C0617A6
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id y23so3886424wmi.1
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 14:28:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=sZLeDXab7ZO7knCKdxuePUrJnPaUNRdkZysvWS/dsHc=;
        b=O26A+SZCC4yY9VmVoxXNWAe36iTTGLn8UzmBxcyvhCc+x4svY1ZcE9Sz2nKocds+j1
         22zJbXTN7QgUczeMBzlbMSZoNWK6AAxYRrIIVnsFpzn0MQSzDYihRKVEMKPK7BjcnhtZ
         cplNwjXZYB+P8TNXTr941Tjl6M08cy6H1FUFz1fEO+X54SOIQoiKuUoGCaBELlEh5UyI
         JlIPmazf+Uz71Ly0iN/biLJoMgeAXGSFlLF/D0GFiEDBi3aR/2B3jTpjvQ20CEeVdPT3
         JPPGFTAFp+tJC4wNfGG0FywkePRQJUV6uNxbUcQOKwh9R5JuywMjM2SEWt5LJ9kvCyk+
         W3nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=sZLeDXab7ZO7knCKdxuePUrJnPaUNRdkZysvWS/dsHc=;
        b=RTkFAaSDiIgbIR8qnl3KSr+jqU1DsDnAaRl2b7kaENiXtSGajtOa9b9UT6SKsokIkm
         mct72auxArUYlgyUCyccmtqa5CkAPj0870yUFsXpFihPmjJQ7s3bit6Cm4qatbETRJvV
         M/yL09lpU0b4ek36MpTpjt4Pezz9095GmIK3zBepn8hf4izR3b6HbdYDVppnLYRFl3jl
         fr3nDmTXNs9RNAAIwzuDQImW4z+g3Wj8gHVjev7mvkY33X2S8v+MmX3YIqj2FmzwhGz5
         JAVZBs0YjI7vBaOwJ8jfXN4dx6b98ObC7e/zIAv4KbVq9otfANI4ipnUD0VAl6BLCYg9
         ieQQ==
X-Gm-Message-State: AOAM533ZDc7U/H4ET30D7BpxV9/AGgMFGS9xH/kGhJL4YstyDXr1C0QA
        cNLtHQzCPEW1oRaOWLrOIYT/e9aYgEw=
X-Google-Smtp-Source: ABdhPJzkB6PcDtizC05CVh2PtITywfm4usqvNaEXSb1VZBriE1r9gVV7J5zhabcPyiZdseXd7y6ohg==
X-Received: by 2002:a1c:9d16:: with SMTP id g22mr5366943wme.140.1608157684937;
        Wed, 16 Dec 2020 14:28:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s8sm4662616wrn.33.2020.12.16.14.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 14:28:04 -0800 (PST)
Message-Id: <9052faeabe62d9ba1b9bceae0c0f7b1809bd1b60.1608157683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
References: <pull.814.v4.git.1608150919.gitgitgadget@gmail.com>
        <pull.814.v5.git.1608157682.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 16 Dec 2020 22:27:59 +0000
Subject: [PATCH v5 1/4] commit: move reverse_commit_list() from
 merge-recursive
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 commit.c          | 11 +++++++++++
 commit.h          |  3 +++
 merge-recursive.c | 11 -----------
 3 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/commit.c b/commit.c
index f53429c0ac3..dc08a47b073 100644
--- a/commit.c
+++ b/commit.c
@@ -563,6 +563,17 @@ struct commit_list *copy_commit_list(struct commit_list *list)
 	return head;
 }
 
+struct commit_list *reverse_commit_list(struct commit_list *list)
+{
+	struct commit_list *next = NULL, *current, *backup;
+	for (current = list; current; current = backup) {
+		backup = current->next;
+		current->next = next;
+		next = current;
+	}
+	return next;
+}
+
 void free_commit_list(struct commit_list *list)
 {
 	while (list)
diff --git a/commit.h b/commit.h
index 5467786c7be..3e9139a0004 100644
--- a/commit.h
+++ b/commit.h
@@ -177,6 +177,9 @@ void commit_list_sort_by_date(struct commit_list **list);
 /* Shallow copy of the input list */
 struct commit_list *copy_commit_list(struct commit_list *list);
 
+/* Modify list in-place to reverse it, returning new head; list will be tail */
+struct commit_list *reverse_commit_list(struct commit_list *list);
+
 void free_commit_list(struct commit_list *list);
 
 struct rev_info; /* in revision.h, it circularly uses enum cmit_fmt */
diff --git a/merge-recursive.c b/merge-recursive.c
index f736a0f6323..b052974f191 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3517,17 +3517,6 @@ static int merge_trees_internal(struct merge_options *opt,
 	return clean;
 }
 
-static struct commit_list *reverse_commit_list(struct commit_list *list)
-{
-	struct commit_list *next = NULL, *current, *backup;
-	for (current = list; current; current = backup) {
-		backup = current->next;
-		current->next = next;
-		next = current;
-	}
-	return next;
-}
-
 /*
  * Merge the commits h1 and h2, returning a flag (int) indicating the
  * cleanness of the merge.  Also, if opt->priv->call_depth, create a
-- 
gitgitgadget

