Return-Path: <SRS0=U/aV=EE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34C8CC55179
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:48:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B97C220838
	for <git@archiver.kernel.org>; Thu, 29 Oct 2020 12:48:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mqv/Pezl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbgJ2Mse (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Oct 2020 08:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725355AbgJ2Mse (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Oct 2020 08:48:34 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2871C0613D2
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:48:33 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w23so2217587wmi.4
        for <git@vger.kernel.org>; Thu, 29 Oct 2020 05:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rBVOrUu3qUPW+MGXF7YSilNpKDz7BD3krvYE0IO59gE=;
        b=Mqv/PezlevPeGy78XjrsxWzudCpRsHXYdmmpliOaFiMNQrejh+7fWzuTnmKn7GGrD9
         RLSNXDa87kvbnCGwNvti9qWbiv7mM2UBQFhOOISYZrEfMAbe3zPFi5gK1YPMwop92tye
         ctB7iH2epqcRAkuZMsWSHiHyUFKqgtV4C5IOk5YrtKov0iO0HQ9k+xdsK1X1HLKZ6n/N
         RIJ5ZOhHpy/aUCrbmtX/vz2zAn+9b2wv68xeLTVnshP0p7mwIQ9ec50/6JOqv768xm8H
         tEl+NG3kQzriVXWmqoPnjFIIIQZ4aNS+X9LYpWCohWk+/yBg90u/F990CpB8K577ASXg
         6V3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rBVOrUu3qUPW+MGXF7YSilNpKDz7BD3krvYE0IO59gE=;
        b=ksR0K5cn2d0zZwX0Qn+CkfKTgIZ16vnFfvMb0Gt57i6mAQDf42guKyCqv7tL1rfLyA
         A5C082E0Fx3s9I9PFNRPPCEqEoJJcfDEY3BokI5xQXXH6epR6T9pmL6D4CwyBB3asN/a
         L9upx8z/l1rbA739so9LAWHHO65uVFjx+Y9VAuFrNPPWWwMP534MgwaWSo+GADYoD5B0
         iexSWtQPBTKFlMsm0voaDQKj4zFeTPVdRfJFdFkW0EiRQBJa8ZnyrI0Tiyzy4MzItgJS
         RlXj34qOxZCr1qZGEdkp2/z3jDsXyzfiyTehvEYG+qT2OH0kFIg2XnACc4kYUQ8t5Ogm
         1+xA==
X-Gm-Message-State: AOAM532YJw1iF+hzVNfZ3ysmJh3zRT6IQAmyXHZgyJV+Olp2xKVGANyw
        EJdC3VVK66LuOxXUXR+VTqSU8CyPpK0=
X-Google-Smtp-Source: ABdhPJxwMWnmCRKAT61jEs7l52Hir8O4aIVO/1cHolyoW7PkJU+5P9YrcBTPBGmGxj/GxvRJJgG+Lg==
X-Received: by 2002:a1c:20d0:: with SMTP id g199mr2285268wmg.68.1603975712548;
        Thu, 29 Oct 2020 05:48:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 26sm4159517wmk.42.2020.10.29.05.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 05:48:32 -0700 (PDT)
Message-Id: <f536fee69565402f6a74e9746c7d06c49814e0c5.1603975709.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.576.v5.git.1603975709.gitgitgadget@gmail.com>
References: <pull.576.v4.git.1603335680.gitgitgadget@gmail.com>
        <pull.576.v5.git.1603975709.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 29 Oct 2020 12:48:29 +0000
Subject: [PATCH v5 2/2] log, show: add tests for messages containing CRLF
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

A previous commit adjusted the code in ref-filter.c so that messages
containing CRLF are now correctly parsed and displayed.

Add tests to also check that `git log` and `git show` correctly handle
such messages, to prevent futur regressions if these commands are
refactored to use the ref-filter API.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/t3920-crlf-messages.sh | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 3f0ce02c3f..70ddce3a2e 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -105,4 +105,22 @@ test_crlf_subject_body_and_contents tag --list tag-crlf*
 
 test_crlf_subject_body_and_contents for-each-ref refs/heads/crlf*
 
+test_expect_success 'log: --oneline works with messages using CRLF' '
+	for branch in $LIB_CRLF_BRANCHES
+	do
+		cat .crlf-subject-${branch}.txt >expect &&
+		printf "\n" >>expect &&
+		git log --oneline -1 ${branch} >tmp-branch &&
+		git log --oneline -1 tag-${branch} >tmp-tag &&
+		cut -d" " -f2- <tmp-branch >actual-branch &&
+		cut -d" " -f2- <tmp-tag >actual-tag &&
+		test_cmp expect actual-branch &&
+		test_cmp expect actual-tag || return 1
+	done
+'
+
+test_crlf_subject_body_and_contents log --all --reverse --grep Subject
+
+test_crlf_subject_body_and_contents show $LIB_CRLF_BRANCHES
+
 test_done
-- 
gitgitgadget
