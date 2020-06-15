Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8A0C433E5
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBFD720757
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vfXGKeiq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730046AbgFOMui (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730009AbgFOMub (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6DC061A0E
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:31 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b82so5991753wmb.1
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=741Jlv09uRe5iORJ1gS6fMbSSVoxC/9xSl1oE+ybcmA=;
        b=vfXGKeiqc6o7hf4kg8Z8swPeJrJ3tI6dsjwycg10Po5DmATCMDmaVOkE2nAQobBugv
         nxDfpS59QwhCZstM3V1c+6ookV5LDLO+U6go9WrkBpmZVoY/SZwlKOibNrCqpeIyrE59
         owReeOLhpB/0xAzQxKnRdxTiLcLgBSE+iE096GdwGExBI7TC7gGeRjwU5VPBGHgQcg75
         ei5nzeb/cslGp81VB1NLDuTs7vUdDsfMQRRQ9EeD1lkzxej/nxsWH2MbpS6DG06DV2wy
         yq5rW0xeU+Y8UoVePnlKhUnuIA+n3gRncwSKeGoXqXaSpK2c5wav47r6A3ewmTUwx+v3
         itsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=741Jlv09uRe5iORJ1gS6fMbSSVoxC/9xSl1oE+ybcmA=;
        b=AOS1itgQgYFLHVa9fOJiwFVqYoUDMMLk7jEXVzLX/LrZ1mnXIoRVVK9cvW6Q5ENxxq
         jmyzuSuLmqMYDnOtWdVu3pBQ66JRXzga2zgSBHUCJTLuMJD37N9uTd2PBz+8QkP3lXtK
         8RENGUzb2fIF5T6XbB590HEW3dTJjPf/xWMWtBSY/MlnxDatpA8dHEdpQPBlKBd1So3H
         /Ejt6OoLEBBO6NV6+VueucS3KgTv0bH1Wew08D4tOqev5ETJpWASvCIZKALLMJ5XZVh1
         ww5zqjBNVHCYfbbDNeYfjcRMWrfJmkkE0PJ9a8G7AHXBMP0vIcwsaRh+3FrGZ3yx82ao
         Lmyw==
X-Gm-Message-State: AOAM5315CjGQNzvlIPywFkBLllgPNq9ZvjUqaKTMGfeoBIl/nQOvtXX6
        nKRNLLXZVvxN8gBXd1pzALXCbnPC
X-Google-Smtp-Source: ABdhPJzLH0nsoEBynueuKpE3POwp2+4g06K2p7eykHBQYBs5UDeIQZSGvwX6WL1wuQKt0qT7KXAijQ==
X-Received: by 2002:a1c:ba86:: with SMTP id k128mr12515115wmf.19.1592225428755;
        Mon, 15 Jun 2020 05:50:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j16sm29075148wre.21.2020.06.15.05.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:28 -0700 (PDT)
Message-Id: <59d6267f099f30f830836a2422289bc83f5c35e5.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:15 +0000
Subject: [PATCH v2 11/12] submodule: use the correct default for the main
 branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     don@goodman-wilson.com, stolee@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, Matt Rogers <mattr94@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

To allow for overriding the default branch name, we have introduced a
config setting. With this patch, the `git submodule` command learns
about this, too.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/submodule--helper.c | 10 ++++++++--
 t/t7406-submodule-update.sh |  7 +++++++
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 46c03d2a126..48d73e8d9cb 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1980,8 +1980,14 @@ static const char *remote_submodule_branch(const char *path)
 		branch = sub->branch;
 	free(key);
 
-	if (!branch)
-		return "master";
+	if (!branch) {
+		static char *fall_back;
+
+		if (!fall_back)
+			fall_back = git_main_branch_name(MAIN_BRANCH_FOR_INIT);
+
+		return fall_back;
+	}
 
 	if (!strcmp(branch, ".")) {
 		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4fb447a143e..641113afef4 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -70,6 +70,13 @@ test_expect_success 'setup a submodule tree' '
 	)
 '
 
+test_expect_success 'update --remote uses configured default main branch' '
+	git clone super main-branch &&
+	test_must_fail git -C main-branch -c init.defaultBranch=hello \
+		submodule update --init --remote submodule 2>err &&
+	test_i18ngrep origin/hello err
+'
+
 test_expect_success 'submodule update detaching the HEAD ' '
 	(cd super/submodule &&
 	 git reset --hard HEAD~1
-- 
gitgitgadget

