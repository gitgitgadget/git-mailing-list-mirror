Return-Path: <SRS0=FGj8=74=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87AA6C433E4
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 654EA206B7
	for <git@archiver.kernel.org>; Mon, 15 Jun 2020 12:50:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eF/F9zlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730020AbgFOMuc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Jun 2020 08:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729975AbgFOMu2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Jun 2020 08:50:28 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD2CCC08C5C5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:25 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id e1so17020394wrt.5
        for <git@vger.kernel.org>; Mon, 15 Jun 2020 05:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Tdb8wznzgbK9hLYQnagv7iZh78WbTR3kMXjfkkQImgk=;
        b=eF/F9zlhlsMHfbJi2o64SVmA0L16ljCehnXXAToZtD7+itBwSnpgCMvQZNgMEn17lC
         TyqNsoVs+VCyXvVsH0p0nbZlSQ8yHoVAzv1ugUEpVKuB504k8OTIxV7myAHPApOAaIiW
         Vze3sm39I//+pofYzB+vVa1VpYi/V+AQjKBpUUr5x4YHtLjEaq60bcybANRyKDTSDGlN
         SDse7A0cFEfMW0UiuCnKzJQuyABUg8Ef/fGrloGRWxqyFOJDK05XPumtBDtTdGNR8mIL
         7YnfY19x9TO6ij0qz5Z3eNXhRWoi7ZeJmTBypJhcALTl9J0RzdT3wxJmtclcVi3n8FLe
         vcMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Tdb8wznzgbK9hLYQnagv7iZh78WbTR3kMXjfkkQImgk=;
        b=r6z1shNK1SNLII4qisD/+D3DrmuYSp3ZtLH/dzFLX+OjLHi0jxymxKi1IqIZTeQ5hY
         Zdq19GS4wAZxCTi5Y9wdt+RJy1dj+X0UnqWKHFgZ/+dKTmv0nG17tJ88/kJRIkwxwYif
         C/HsIn3oyIDhKHd9vAZDitEHQ2Zwp6B/cqAdYwL//uXwwLa47EhI+Wi9/nsbZema3wXT
         ieiSp/MxlDPJkG5acqZ2va/9hZQRbVgUU6zanO6PhNTSCVS5724ecpfOUHId13WuRzbk
         AfpRy9zGZtyFGUrbP7qKxiB4wgMEb3NHWkN+cdy4BbI5hiw5f8CuexvmwQfSM0s6SSri
         B54Q==
X-Gm-Message-State: AOAM5308jBxJTst4QlahRaaenSOcp5ZuFKtPQ4gGRgqAggTik2UP9XJI
        ROWwW61iWyX6CvJhbbc71VfE76Bt
X-Google-Smtp-Source: ABdhPJyv41v6AY+iwCvjX3/oybgeRc5n3scadr65piE3OEHRTHQzlkgcGjBRudLxTcsunyW93WchgA==
X-Received: by 2002:adf:fd49:: with SMTP id h9mr29400763wrs.67.1592225424092;
        Mon, 15 Jun 2020 05:50:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a126sm22822788wme.28.2020.06.15.05.50.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 05:50:23 -0700 (PDT)
Message-Id: <933e314813df34aafca1a47bfc1fcba389dd5364.1592225416.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
References: <pull.656.git.1591823971.gitgitgadget@gmail.com>
        <pull.656.v2.git.1592225416.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 15 Jun 2020 12:50:10 +0000
Subject: [PATCH v2 06/12] branch -m: adjust `core.mainBranch` if necessary
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

When renaming the main branch (as possibly identified by the
`core.mainBranch` setting), we will want to record that the main branch
now has a different name.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch.c  | 9 +++++++++
 t/t3200-branch.sh | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/branch.c b/builtin/branch.c
index accb61b1aae..62f8db5fb05 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -556,6 +556,15 @@ static void copy_or_rename_branch(const char *oldname, const char *newname, int
 	    replace_each_worktree_head_symref(oldref.buf, newref.buf, logmsg.buf))
 		die(_("Branch renamed to %s, but HEAD is not updated!"), newname);
 
+	if (!copy) {
+		char *main_branch = git_main_branch_name(0);
+
+		if (!strcmp(interpreted_oldname, main_branch))
+		    git_config_set("core.mainbranch", interpreted_newname);
+
+		free(main_branch);
+	}
+
 	strbuf_release(&logmsg);
 
 	strbuf_addf(&oldsection, "branch.%s", interpreted_oldname);
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 411a70b0ce9..328544f2736 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -467,6 +467,15 @@ EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'renaming the main branch modifies core.mainBranch' '
+	git init rename-main &&
+	test_commit -C rename-main initial &&
+	git -C rename-main branch -m trunk &&
+	git -C rename-main config core.mainBranch >actual &&
+	echo trunk >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'git branch -c dumps usage' '
 	test_expect_code 128 git branch -c 2>err &&
 	test_i18ngrep "branch name required" err
-- 
gitgitgadget

