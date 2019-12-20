Return-Path: <SRS0=PG55=2K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EB0CC2D0D4
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2DB6C206D3
	for <git@archiver.kernel.org>; Fri, 20 Dec 2019 17:10:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqkbXbXK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbfLTRKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Dec 2019 12:10:06 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:43944 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727465AbfLTRKA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Dec 2019 12:10:00 -0500
Received: by mail-ed1-f68.google.com with SMTP id dc19so8928582edb.10
        for <git@vger.kernel.org>; Fri, 20 Dec 2019 09:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+4oVHBnhLP3pwB87CreOJWy9LLN4V/boH7Oiy8l2MPc=;
        b=GqkbXbXK4isctBGmqSvDjcNuCC/m6RI78AMH4L2BxclXqrGrud6CS03XUAdeh7Mm5Q
         8m26Ht6SLiAd2EJ+J01St8A562dHas1QnSNCILIqXU9fhtrr9jcZ0IXNy42C7jSMTBXK
         EcwfO6WSwqXyEavoE9SEMa3++/ni4bo3WU/m8ml+WmbY8qBDI18/jBE4EigdZh3HqeuV
         NkuT6ZvXAPFEDzJCVRe2zKh/R4Ysc34A42K45pZkrUNBLVmqghZ3XL/KhLLSAjdEZ11E
         ukLLlTdfkRVVUq2qDkxNXeo99zuXyCdYpeMnL+6VBCS/vmXyMBd6VKA6IHqV2R4HvKUo
         l5Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+4oVHBnhLP3pwB87CreOJWy9LLN4V/boH7Oiy8l2MPc=;
        b=bCJUuiH66FNA0Uq73EZFwL8IjplpYNDydCqddTapnR+rZEjJAAfA7vvWwJqq7BQtcj
         QAzxKVEwqTZqHXYxnahQkoaPu5/NgotUJ1tPOjzazB6/GL+glopA+9Dodd4PD5bZ7Sq0
         srqEiANPn+dvVDFPqLMyfOF/6f7tOzX3okNBW7IgeHXvGjIxRe7ohypcbAZ4pfCIF31H
         yusOJqZ1kkqTWyYiMmjW2Nxx5QOooVLqO0++pvDij/eRUBu5kzODZzM9bc5aAkLTCcRd
         9wS/v41E29LI3DWdS8yMW5l2npE/ZC7HsOFo7VfeWc0eCAmAe623k86r8rmJm4TBQT5r
         2I3A==
X-Gm-Message-State: APjAAAU05BZkyc8n+tpUQrcpwuUfTWl32vqXQKCWFIM2P1ht6aJf7v45
        geEo132DzTW6qTNpJcvjmlFU0w6M
X-Google-Smtp-Source: APXvYqz6wxRPl5riu4oN68My0CMX/YLg8P67CeC2BzrV4cg8itRbqPcxsUpBfoHrYzaZ2M4132S9Ew==
X-Received: by 2002:a17:906:ce2e:: with SMTP id sd14mr17480052ejb.190.1576861798154;
        Fri, 20 Dec 2019 09:09:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z25sm1014259edr.25.2019.12.20.09.09.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Dec 2019 09:09:57 -0800 (PST)
Message-Id: <1c3f8ba328982e633e1431eba3fabcb230821ddc.1576861788.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Dec 2019 17:09:44 +0000
Subject: [PATCH 11/15] contrib: change the prompt for am-based rebases
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The prompt for am-based rebases was REBASE, while for interactive-based
rebases was REBASE-i.  A while ago, we switched merge-based rebases from
using REBASE-m to REBASE-i via re-implementing the merge backend based
on the interactive backend.  We will soon be changing the default rebase
backend to the interactive one, meaning the default prompt will be
REBASE-i rather than REBASE.  We have also noted in the documentation
that currently am-specific options will be implemented in the
interactive backend, and even the --am flag may eventually imply an
interactive-based rebase.  As such, change the prompt for an am-based
rebase from REBASE to REBASE-a.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-prompt.sh | 2 +-
 t/t9903-bash-prompt.sh           | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 1d510cd47b..3c81099d60 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -440,7 +440,7 @@ __git_ps1 ()
 			__git_eread "$g/rebase-apply/last" total
 			if [ -f "$g/rebase-apply/rebasing" ]; then
 				__git_eread "$g/rebase-apply/head-name" b
-				r="|REBASE"
+				r="|REBASE-a"
 			elif [ -f "$g/rebase-apply/applying" ]; then
 				r="|AM"
 			else
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index 88bc733ad6..8da5b1aee2 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -189,11 +189,11 @@ test_expect_success 'prompt - rebase merge' '
 	test_cmp expected "$actual"
 '
 
-test_expect_success 'prompt - rebase' '
-	printf " (b2|REBASE 1/3)" >expected &&
+test_expect_success 'prompt - rebase am' '
+	printf " (b2|REBASE-a 1/3)" >expected &&
 	git checkout b2 &&
 	test_when_finished "git checkout master" &&
-	test_must_fail git rebase b1 b2 &&
+	test_must_fail git rebase --am b1 b2 &&
 	test_when_finished "git rebase --abort" &&
 	__git_ps1 >"$actual" &&
 	test_cmp expected "$actual"
-- 
gitgitgadget

