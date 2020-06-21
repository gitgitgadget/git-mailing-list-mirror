Return-Path: <SRS0=gxdb=AC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147A7C433E0
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE8F2467F
	for <git@archiver.kernel.org>; Sun, 21 Jun 2020 05:22:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IErss4fS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbgFUFVg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Jun 2020 01:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726015AbgFUFVc (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Jun 2020 01:21:32 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91476C061796
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:32 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l26so11979847wme.3
        for <git@vger.kernel.org>; Sat, 20 Jun 2020 22:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FWSeW4Q6dW3AgDaYeUDND5vtHEgS6HfIU4cF51s8+9g=;
        b=IErss4fSHUKymmHa8Sa66A+50+bO0xO9ZueTssZF0I6CJoX24FkdIl3mrrAhGSdDC6
         q5Y4HPTZ5BauvteJweyoF0NZUl2irQAaE2NiXhl4RQLGlvx8UaXFaKNln5mrQNELF0Yg
         rl9zsHzAmsbq2eh/Mcw4zN5ab+fQGJQXkIkvLWQybkhgJHZ2GWZiFZTVuqe2VWu2A2Ce
         KICZnR+5h3W8fsOfc2oLPf+jH5ONf8ugUcnjXWZ0LNlg16eBTaV5NWXhpuHsS6AyP2sV
         u0UBqWJ+DCQL/re5MPhfDLLSRLoNFhdfHNCB2lkL2CAbUv3ZaR6bY17o2KXLmY7xlWzz
         Rv6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FWSeW4Q6dW3AgDaYeUDND5vtHEgS6HfIU4cF51s8+9g=;
        b=Gi6TtDNbOncE3FU27rWHwZeKTqUVWpxAGiiNkQvuvHIpkIsBl2yUnmdvE0KUPWxH1Y
         2CCh9tUkuNi+whXYQW01p9YuUNdpcoAvb5dKTcnJrtPNhGQBP/grfXCap5ipJqJXnhfB
         xWpZ70Z7O0rGa90wqO18eH6jMJn6rt2bfstwbH2TXDn1lke5SZZcGsGcnFxYGTqE3PNn
         KLbn3R3ldLQ8pN5XQAPKFosCraa5CgseTym4NNNK2rJPX4OZQERmFff7m6xVAg8ab/X2
         vyXgQlSy1v8DmsryPnz1/le8xyzpq/S1ULisp67ZvalSe8mA+7PH3gj0F+OdYwdLWLy/
         dtJQ==
X-Gm-Message-State: AOAM531NnxbNxl13nNgLKy0gwiL/CQBONeKHOM0WFHU2fnqIAqrdgpQE
        lZ5Y/Tk3aEnTS6kr/xozkqEHSawq
X-Google-Smtp-Source: ABdhPJydVJV+YyqmUQqJ1L2V8YyvQvn3x3+V4jTrWCLABztsgTBMGx1GETyNlSfZjYmSEgkfDku8qQ==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr11132705wme.112.1592716891111;
        Sat, 20 Jun 2020 22:21:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w2sm450716wrs.77.2020.06.20.22.21.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2020 22:21:30 -0700 (PDT)
Message-Id: <1fd1b919684173d0971869a9aaf8554055760d63.1592716887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
References: <pull.808.v2.git.git.1592513398.gitgitgadget@gmail.com>
        <pull.808.v3.git.git.1592716887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 21 Jun 2020 05:21:26 +0000
Subject: [PATCH v3 2/3] git-prompt: document how in-progress operations affect
 the prompt
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, szeder.dev@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 contrib/completion/git-prompt.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 014cd7c3cfc..179b96e4936 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -70,6 +70,10 @@
 # state symbols by setting GIT_PS1_STATESEPARATOR. The default separator
 # is SP.
 #
+# When there is an in-progress operation such as a merge, rebase,
+# revert, cherry-pick, or bisect, the prompt will include information
+# related to the operation, often in the form "|<OPERATION-NAME>".
+#
 # By default, __git_ps1 will compare HEAD to your SVN upstream if it can
 # find one, or @{upstream} otherwise.  Once you have set
 # GIT_PS1_SHOWUPSTREAM, you can override it on a per-repository basis by
-- 
gitgitgadget

