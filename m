Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97498C433FE
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:42:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353804AbhKYIpS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:45:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353425AbhKYInR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:43:17 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAF8BC0613F1
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:27 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id b12so9906355wrh.4
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k8ksTLhk6dw/Y0Uea/a7jNB64e2HNpj7JfoIEHOv3Vc=;
        b=arL7jaLKcZ78Kf0ahtvy5qOCDNc+XSD+c/gvrvCGrptLGCfVD9YNMVDFqVi/siajqX
         GB7cVTJ/nFz1LSsRNIyk488Qw07D5J/EzqNOUUlHws2C2wXfV20Fnrq5zr8fLBI1jGGb
         Vn73EO/2VoBm4ioJ3PgErF4RxOYOUjeUaCyKfBvuAKpgZ498SHrkIRKJxy5FUryQgCSA
         xflFf6jtP1vbMXzVCKnMBIAvT6uFz/SzBWAXG5HhhLtkTds4xaJbp6In3wQJNEX9qXc0
         +dlHMbZOzpaAI3859LsbABZ+FySLLscjDNM/y0J6t9+R0ZjsXUe96qMjIEDludRwbMYt
         1t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k8ksTLhk6dw/Y0Uea/a7jNB64e2HNpj7JfoIEHOv3Vc=;
        b=myaaYalEKTz1lhfGCMmMpUDjQyJiNa4HBkcbEQEppvw0z8rBMF5LvSQOcqTKGdZLGl
         tF8n77+nqasGN8f3VhpK4W3Ii6b5qgfBEZg1uuk7bePxDgdonqalliLP2dl1mNmC0rB2
         PjqMSj0Vdw/Zfy3u/iCL1dwQl9FhBzvrT4yl0xvzFHtmwsw9vZe917SCy/w6p74cW7UO
         N90z//fe8Sjgg7LOw2/3NjimOPovqpAR1P13MQQTJxs449RSerl0mQq3y0IInrF0RpCy
         MBba0QMVMZSIMgo8YvUSEOW9dPPnEHAEISanm6zCvN7NQhv5cNDUSXcLzMbhbtlV1v1g
         KUSw==
X-Gm-Message-State: AOAM530pN1IdHJ91eI1ThMJJIhjHz5Qdkb+e+60QVZySaXR4fvLzpfVB
        27yTFh9gcqfL/I7fDmIJ+yw2QascyfQ=
X-Google-Smtp-Source: ABdhPJyLD/GhGOheJChooxoQL7zQFpRGYqrQmoXJ/Nz8vQSHErsdQ+O4W4+mt5oFdDqaI6+Pi/Iegw==
X-Received: by 2002:a05:6000:11cd:: with SMTP id i13mr94568wrx.524.1637829566083;
        Thu, 25 Nov 2021 00:39:26 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b188sm2260565wmd.45.2021.11.25.00.39.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:25 -0800 (PST)
Message-Id: <edec0894ca2a01c7afbc70590efd5ee8a0d1abde.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:14 +0000
Subject: [PATCH v2 7/9] stash: do not attempt to remove
 startup_info->original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/stash.c      | 6 +++++-
 t/t2501-cwd-empty.sh | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index a0ccc8654df..50b4875980c 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -1485,8 +1485,12 @@ static int do_push_stash(const struct pathspec *ps, const char *stash_msg, int q
 			struct child_process cp = CHILD_PROCESS_INIT;
 
 			cp.git_cmd = 1;
+			if (startup_info->original_cwd &&
+			    *startup_info->original_cwd &&
+			    !is_absolute_path(startup_info->original_cwd))
+				cp.dir = startup_info->original_cwd;
 			strvec_pushl(&cp.args, "clean", "--force",
-				     "--quiet", "-d", NULL);
+				     "--quiet", "-d", ":/", NULL);
 			if (include_untracked == INCLUDE_ALL_FILES)
 				strvec_push(&cp.args, "-x");
 			if (run_command(&cp)) {
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 20e1b6adede..ff4e7cd89fa 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -236,7 +236,7 @@ test_expect_success 'clean does not remove cwd incidentally' '
 	test_path_is_dir untracked
 '
 
-test_expect_failure 'stash does not remove cwd incidentally' '
+test_expect_success 'stash does not remove cwd incidentally' '
 	git checkout foo/bar/baz &&
 	test_when_finished "git clean -fdx" &&
 
-- 
gitgitgadget

