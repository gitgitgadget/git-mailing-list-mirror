Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2780CC74A5B
	for <git@archiver.kernel.org>; Sun, 26 Mar 2023 22:33:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbjCZWde (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Mar 2023 18:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjCZWdd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Mar 2023 18:33:33 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E35BB7
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id m6-20020a05600c3b0600b003ee6e324b19so4077029wms.1
        for <git@vger.kernel.org>; Sun, 26 Mar 2023 15:33:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679870009;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j57P/WfSTCKB9tc8adZCFsCizHoqldcjpkxjP0CpWrU=;
        b=N9ye3rLkKlF/7/q24jxZTJRdEkL6z1rlx78uFNlTEi86tXoqgLHwHcUDn9TQx6rM86
         r6SMwVYx7aybRXAbcLE/6QEBvK0vqBEtx5e+7mfdg3slCLJnfXJEq1O9lxCqs2Qmozu4
         NVLMt4FmDSTclYVvuJpzCvkBZGM7FabuPTNVC86ITR9Gv2sTZe5sbXJ6l52aWIILyy95
         d9eDoeis3TmBr+IlTqgPKJ3+fXewTFQiauQEgbp51pnRoRnEhASKZpWgGdmZ9hP5xGbY
         k0w0jQ8w7pB/keDmkyvp+QKxz4p9haXjYKvNCymsy7z2SZwJpYhjrGV6LUQ1gp05A3yR
         yCSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679870009;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:from:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j57P/WfSTCKB9tc8adZCFsCizHoqldcjpkxjP0CpWrU=;
        b=WwAvdKYymK/tcGizNb6UAuN9AO+FEI6gZknSQEpDoR5kFLTKGu0A8jtrNnXfv9OwQM
         ZGkb572xpUIw/0x+010Kt42THInDCG7UnMrFTr9Sp1AxTyOJf8AnRr8lDxL+fl6N4TVK
         6EshpbT97wAQIaw+nsp0btahESNI4wMbMzYAImvCT1Qb2E99r5vkpYerZlqWHCPBlmwa
         5LbxNX6agpoaUS4/u4JGKIeKRBKWZz2MfKSKcdTCIFjuWXq1U6p1ftHgh26twmWwzkBB
         LpM+fFDyhs+Il6CfPXdi8FN8XX8f8pefunoZzkNRltMxDAzI+EfPP+GtI9HGBylkdJTx
         /+Fw==
X-Gm-Message-State: AO0yUKVNVdHbVNNgLn/EVs0n8SGAH2Rhgzv0C7+A6Oca0n3SMfkroZDK
        3jQZWbgMhXmF91flSppcF1A=
X-Google-Smtp-Source: AK7set9ZYeGSrOAaebef2Gpu3rV6yF71i18CFTEvh9P6mVnJAdx4unsvg9AdvWAm3lVGIP7Xi30Rjg==
X-Received: by 2002:a7b:cbd2:0:b0:3ed:2619:6485 with SMTP id n18-20020a7bcbd2000000b003ed26196485mr8157378wmi.3.1679870009087;
        Sun, 26 Mar 2023 15:33:29 -0700 (PDT)
Received: from [192.168.2.52] (96.red-88-14-208.dynamicip.rima-tde.net. [88.14.208.96])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d590f000000b002cfec8b7f89sm23634693wrd.77.2023.03.26.15.33.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Mar 2023 15:33:28 -0700 (PDT)
Subject: [PATCH v5 4/5] branch: rename orphan branches in any worktree
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <34a58449-4f2e-66ef-ea01-119186aebd23@gmail.com>
 <2193a4ed-b263-068e-92f8-847dcb053f8c@gmail.com>
 <139555f1-21ab-d987-a58e-c7f04ce222d3@gmail.com>
 <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Message-ID: <cc4cf795-5424-c56b-aaec-2032cb969152@gmail.com>
Date:   Mon, 27 Mar 2023 00:33:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f8e6447e-5cd3-98fa-f567-39e1c60dacb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In cfaff3aac (branch -m: allow renaming a yet-unborn branch, 2020-12-13)
we added support for renaming an orphan branch when that branch is
checked out in the current worktree.

Let's also allow renaming an orphan branch checked out in a worktree
different than the current one.

Signed-off-by: Rubén Justo <rjusto@gmail.com>
---
 builtin/branch.c  |  6 ++++--
 t/t3200-branch.sh | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 90dcbb0c6e..a93b9fc0ab 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -539,6 +539,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 }
 
 #define IS_HEAD 1
+#define IS_ORPHAN 2
 
 static void copy_or_rename_branch(const char *oldname, const char *newname, int copy, int force)
 {
@@ -565,6 +566,8 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 
 		if (wt->head_ref && !strcmp(oldref.buf, wt->head_ref)) {
 			oldref_usage |= IS_HEAD;
+			if (is_null_oid(&wt->head_oid))
+				oldref_usage |= IS_ORPHAN;
 			break;
 		}
 	}
@@ -599,8 +602,7 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 		strbuf_addf(&logmsg, "Branch: renamed %s to %s",
 			    oldref.buf, newref.buf);
 
-	if (!copy &&
-	    (!head || strcmp(oldname, head) || !is_null_oid(&head_oid)) &&
+	if (!copy && !(oldref_usage & IS_ORPHAN) &&
 	    rename_ref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch rename failed"));
 	if (copy && copy_existing_ref(oldref.buf, newref.buf, logmsg.buf))
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 7abd938e15..98b6c8ac34 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -298,6 +298,20 @@ test_expect_success 'git branch -M and -C fail on detached HEAD' '
 	test_cmp expect err
 '
 
+test_expect_success 'git branch -m should work with orphan branches' '
+	test_when_finished git checkout - &&
+	test_when_finished git worktree remove -f wt &&
+	git worktree add wt --detach &&
+	# rename orphan in another worktreee
+	git -C wt checkout --orphan orphan-foo-wt &&
+	git branch -m orphan-foo-wt orphan-bar-wt &&
+	test orphan-bar-wt=$(git -C orphan-worktree branch --show-current) &&
+	# rename orphan in the current worktree
+	git checkout --orphan orphan-foo &&
+	git branch -m orphan-foo orphan-bar &&
+	test orphan-bar=$(git branch --show-current)
+'
+
 test_expect_success 'git branch -d on orphan HEAD (merged)' '
 	test_when_finished git checkout main &&
 	git checkout --orphan orphan &&
-- 
2.39.2
