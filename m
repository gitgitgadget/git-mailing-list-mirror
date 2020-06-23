Return-Path: <SRS0=IiYM=AE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D716C433E0
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:48:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F312720888
	for <git@archiver.kernel.org>; Tue, 23 Jun 2020 22:47:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jK1cr9GN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388651AbgFWWr4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Jun 2020 18:47:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388262AbgFWWrX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jun 2020 18:47:23 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21198C0617BF
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id t194so380822wmt.4
        for <git@vger.kernel.org>; Tue, 23 Jun 2020 15:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=glBlY/7yW7twc8Qy5k7bGwLHwjhCmqCRtylbfMN7Arc=;
        b=jK1cr9GNcCSIdhFgUCemhstCBEx7nBUZmx/Ds1lrb0R5ROFZbtEvMJfeyn014EhgY0
         jbU+aVYUtCNHCyPiB+62euFb4wvA2eNht9PuZW+faIC9/kN5GS0G32/ESJX/ity/W87n
         O+tmQOKmKlUwad6Y/CgaeeyakaEEcgx7/6xQrGBdLaT2o/XDSfBQm+Z66T1chyhPFxl8
         QfR/+bmhs+FMe808xdwWr3iGzn0xIryiPgmhxyed0Z6V05eB3Yl2cfU3EIJ5vjk/Ft91
         kOORmm2vkcIvJWs7Z0cE4j4bw6+Lz9+6PyPB5trgDGnC/h4y71swX4f9aj+mhMrm/jQ+
         ao0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=glBlY/7yW7twc8Qy5k7bGwLHwjhCmqCRtylbfMN7Arc=;
        b=arovoVEtIsA9STcny5UC5W+4CAKe6wHnWonVNHdvYRSpTUOAl3nBgLrUwiSjsZYJgc
         j9IyzOKFZRJebOuNXNt5SYQU35p0yXBABOV0yN8mo4Mlnp2xJxmDPD8fk9/E2Oqsca5G
         02yr5Bu6PcvwLF5mi5lxBORSGPozWOk+dCWWLWFCvXhkM78J7Vl1gxolbdKvgjDAdunW
         ZuDUlbsX0samFKcRBrxWPDI13BZ9kcEyxSOCipbz4rkKj6Acc61zV+rU70VLtzPQO8K2
         4o+GrJ2fCHiZwMcfmAw79G9rlaNJtQ8LrFcw/TzsmCKz9hLJ6qS9zDjOZGavIedZrJK7
         QcOQ==
X-Gm-Message-State: AOAM531m/vea3LQ6X/MLtyH+ZH0e9ZMo0+S7911YHq054wM2+tKYa4n5
        +zSaTLvEArWE7RmIU+M5vhItjI8K
X-Google-Smtp-Source: ABdhPJwYlyj2096Rv4gvunix8xYvIIO0erdkqtZhbh6zhyMNjSMd553YxqbYVQ/ibIIKgtsmITNaqQ==
X-Received: by 2002:a05:600c:4109:: with SMTP id j9mr2607800wmi.157.1592951615560;
        Tue, 23 Jun 2020 15:33:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j14sm24372835wrs.75.2020.06.23.15.33.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2020 15:33:35 -0700 (PDT)
Message-Id: <6bda69541b12e93cfcf7b841b8691296dc82eeba.1592951611.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
References: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
        <pull.656.v3.git.1592951611.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 23 Jun 2020 22:33:25 +0000
Subject: [PATCH v3 3/8] submodule: use a better fall-back for missing
 remote.<name>.branch
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
        Denton Liu <liu.denton@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When `remote.<name>.branch` is not configured, `git submodule update`
currently falls back to using the branch name `master`. A much better
idea, however, is to use `HEAD`: on all Git servers running reasonably
recent Git versions, the symref `HEAD` points to the main branch.

Note: t7419 demonstrates that there _might_ be use cases out there that
_expect_ `git submodule update --remote` to update submodules to the
remote `master` branch even if the remote `HEAD` points to another
branch. Arguably, this patch makes the behavior more intuitive, but
there is a slight possibility that this might cause regressions in
obscure setups.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-submodule.txt |  4 ++--
 builtin/submodule--helper.c     |  2 +-
 t/t7406-submodule-update.sh     | 16 ++++++++++++++++
 t/t7419-submodule-set-branch.sh |  7 +++++--
 4 files changed, 24 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-submodule.txt b/Documentation/git-submodule.txt
index c9ed2bf3d5..b20f85e622 100644
--- a/Documentation/git-submodule.txt
+++ b/Documentation/git-submodule.txt
@@ -284,7 +284,7 @@ OPTIONS
 	`.gitmodules` for `update --remote`.  A special value of `.` is used to
 	indicate that the name of the branch in the submodule should be the
 	same name as the current branch in the current repository.  If the
-	option is not specified, it defaults to 'master'.
+	option is not specified, it defaults to 'HEAD'.
 
 -f::
 --force::
@@ -322,7 +322,7 @@ OPTIONS
 	the superproject's recorded SHA-1 to update the submodule, use the
 	status of the submodule's remote-tracking branch.  The remote used
 	is branch's remote (`branch.<name>.remote`), defaulting to `origin`.
-	The remote branch used defaults to `master`, but the branch name may
+	The remote branch used defaults to `HEAD`, but the branch name may
 	be overridden by setting the `submodule.<name>.branch` option in
 	either `.gitmodules` or `.git/config` (with `.git/config` taking
 	precedence).
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 46c03d2a12..f55f7b7704 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1981,7 +1981,7 @@ static const char *remote_submodule_branch(const char *path)
 	free(key);
 
 	if (!branch)
-		return "master";
+		return "HEAD";
 
 	if (!strcmp(branch, ".")) {
 		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
index 4fb447a143..aa19ff3a2e 100755
--- a/t/t7406-submodule-update.sh
+++ b/t/t7406-submodule-update.sh
@@ -70,6 +70,22 @@ test_expect_success 'setup a submodule tree' '
 	)
 '
 
+test_expect_success 'update --remote falls back to using HEAD' '
+	test_create_repo main-branch-submodule &&
+	test_commit -C main-branch-submodule initial &&
+
+	test_create_repo main-branch &&
+	git -C main-branch submodule add ../main-branch-submodule &&
+	git -C main-branch commit -m add-submodule &&
+
+	git -C main-branch-submodule switch -c hello &&
+	test_commit -C main-branch-submodule world &&
+
+	git clone --recursive main-branch main-branch-clone &&
+	git -C main-branch-clone submodule update --remote main-branch-submodule &&
+	test_path_exists main-branch-clone/main-branch-submodule/world.t
+'
+
 test_expect_success 'submodule update detaching the HEAD ' '
 	(cd super/submodule &&
 	 git reset --hard HEAD~1
diff --git a/t/t7419-submodule-set-branch.sh b/t/t7419-submodule-set-branch.sh
index fd25f786a3..3b925c302f 100755
--- a/t/t7419-submodule-set-branch.sh
+++ b/t/t7419-submodule-set-branch.sh
@@ -52,12 +52,13 @@ test_expect_success 'test submodule set-branch --branch' '
 '
 
 test_expect_success 'test submodule set-branch --default' '
+	test_commit -C submodule c &&
 	(cd super &&
 		git submodule set-branch --default submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		a
+		c
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
@@ -65,6 +66,7 @@ test_expect_success 'test submodule set-branch --default' '
 '
 
 test_expect_success 'test submodule set-branch -b' '
+	test_commit -C submodule b &&
 	(cd super &&
 		git submodule set-branch -b topic submodule &&
 		grep "branch = topic" .gitmodules &&
@@ -78,12 +80,13 @@ test_expect_success 'test submodule set-branch -b' '
 '
 
 test_expect_success 'test submodule set-branch -d' '
+	test_commit -C submodule d &&
 	(cd super &&
 		git submodule set-branch -d submodule &&
 		! grep branch .gitmodules &&
 		git submodule update --remote &&
 		cat <<-\EOF >expect &&
-		a
+		d
 		EOF
 		git -C submodule show -s --pretty=%s >actual &&
 		test_cmp expect actual
-- 
gitgitgadget

