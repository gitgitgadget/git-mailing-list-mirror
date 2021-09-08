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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 300EFC433F5
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 122A060555
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 01:43:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346951AbhIHBpA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 21:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346851AbhIHBo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 21:44:56 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BA02C06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 18:43:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id z9-20020a7bc149000000b002e8861aff59so341123wmi.0
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 18:43:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pyp3qAMf8e8cfZ5TT1yj3l5tVqRBPMrlSGBm6ukHeSk=;
        b=IsQj3UfdfbvKgm6GMDio3bGtN34VssRyPeF5CnHcDBxZcTP8XWC+7n8iICfDkVY5kv
         UoLWPkooSnwwZlIZDbCjH1HXtEFq8OvqDgSrL48FvQvF3rTTB4uGX+BqjfUsmEFUFwft
         vDVdvJ1aN5RaEIGhkUexYUO2n8FW/6VOaDegbbltGvU4dLQ6ZNjS7Dtd5v5a7W0uKaG7
         po1zG0svZonHNE2WHFBXGDHzxI8M7fFwc++sbghPj7LUSwh9Vk3tR15/EPVlqXwyhOX+
         AGVBGEPqD1WDr5Te7wJdnN2GFjCcWrRGFSbZoUe+WVNAaY9YOyn5+25J6bMgPiiBf7rc
         PkTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pyp3qAMf8e8cfZ5TT1yj3l5tVqRBPMrlSGBm6ukHeSk=;
        b=Oo62y5juNYmVfDHzbs8QYZEZyJwJ5pmCXMMZz6TnSke/ZziFCT7urTBzVgPWsGkhoD
         1F/t1nKp9fIFCapDCmkFgZcAv5gYyXsnIUSfg5xPE4DMHVvtfW5ADZQ3ODoprK6DnwY3
         I7D37as6iaEZVL1Znm+zOj5H/MTZ8v+kjV8lNagW7g+boCi5XkYk45vvMGf/9ll/RHBd
         wPmiBCOTM+sqWldbkb8GPIUVhgCrt9yqp2BgBQndzvFag49X5Gf5SrpS565Vo2oDpSo0
         fdX4rrzF8WTnfwsah+IomwFDLrJmdHCgw2R+VZ1kFGW3ShyPiFqH146rvUP9Tlbdlfwc
         +6CQ==
X-Gm-Message-State: AOAM530TVLs2hIRO82SNMGHyDOamZAjnYv9l1bILJz5D0bvkFIJ/HxWJ
        oJ3FDUUMW8C9+5JAu7Povj8+gQpgclM=
X-Google-Smtp-Source: ABdhPJzSe7PkSevkvPYuyYw/R96GtVs7NFwW2loWdKs+oixK5/13V5ZG3lZb/d8fk4nGyUZGaH6zlQ==
X-Received: by 2002:a05:600c:4848:: with SMTP id j8mr1006758wmo.13.1631065428200;
        Tue, 07 Sep 2021 18:43:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x9sm544713wmi.30.2021.09.07.18.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 18:43:47 -0700 (PDT)
Message-Id: <bc66a6ae75d03858f48634612bb60062cc78f5eb.1631065427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
References: <pull.1086.git.git.1631065426.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Sep 2021 01:43:44 +0000
Subject: [PATCH 1/3] t3903: document a pair of directory/file bugs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t3903-stash.sh | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/t/t3903-stash.sh b/t/t3903-stash.sh
index 873aa56e359..0727a494aa4 100755
--- a/t/t3903-stash.sh
+++ b/t/t3903-stash.sh
@@ -1307,4 +1307,42 @@ test_expect_success 'stash -c stash.useBuiltin=false warning ' '
 	test_must_be_empty err
 '
 
+test_expect_failure 'git stash succeeds despite directory/file change' '
+	test_create_repo directory_file_switch_v1 &&
+	(
+		cd directory_file_switch_v1 &&
+		test_commit init &&
+
+		test_write_lines this file has some words >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		git rm filler &&
+		mkdir filler &&
+		echo contents >filler/file &&
+		cp filler/file expect &&
+		git stash push
+	)
+'
+
+test_expect_failure 'git stash can pop directory/file saved changes' '
+	test_create_repo directory_file_switch_v2 &&
+	(
+		cd directory_file_switch_v2 &&
+		test_commit init &&
+
+		test_write_lines this file has some words >filler &&
+		git add filler &&
+		git commit -m filler &&
+
+		git rm filler &&
+		mkdir filler &&
+		echo contents >filler/file &&
+		cp filler/file expect &&
+		git stash push --include-untracked &&
+		git stash apply --index &&
+		test_cmp expect filler/file
+	)
+'
+
 test_done
-- 
gitgitgadget

