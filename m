Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23EC2C433EF
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbiFMWje (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240835AbiFMWjO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:14 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E214B62C9
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:13 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id n185so3708429wmn.4
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J0zZrIr+hh/sfytsdc1vSMu75sb/aYHhbqFm1Ictlmw=;
        b=PDZla1qwRlYS+CVYrwbi1bwmRZxIoJx6Tsg0tRI2011fiIHmmKFvv4nSUCwr6YPu5d
         UEn3UPMnr+hyewcG1cS7Mc9JXBRQkAYJn9zeulhNiZoooQEsG9fjS6jc5E4qrPSCPfnX
         esKOo1FfBO6hD/gMp8msRibsU5HHhsBYGFnSWUSH9qLA4H6zR2T9vxQRYoNnW5Byd92N
         1UfkRb9wDJGAV/Xmq5OLDiV/1s1uqvgGByUvVOGEciX+7O6z5WCN9Hwj0HiJ6B9Ch06T
         uNHRtfxR725J7XuPxhigp9ZEYBM3HFiKYA4J+f8+UI1vEAed3CSUkfCYIBuNZOVZ3oK0
         vwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J0zZrIr+hh/sfytsdc1vSMu75sb/aYHhbqFm1Ictlmw=;
        b=Tn+pzZQ8EJpQDgVeKfm2uz8CvMZheNJ9RUqKmCJpuLaevm/EeIcH4e6pYj2VoMBFFX
         drSOfAwwtqF7P88B+QUJzzWv+QXeECKm1msvfjKGuiJUF1yGiz4EOHWsu/AALco5yP1r
         C0ePVOZPXWMy5ah4orVbFs6IsSqL0fTokjxJ55yrkoM4NyOQ/7f1u6LACMf/7ZQ2Ll3j
         HhwwsuDDiCIYP9WOOPHbNHYa24XLb4MLPFgDAsgwxaxvVEIHtF8vqhatkHaGIjza8/mz
         uxsF4/gfq+rywCrAyrbe4+Cw1GPJ/HWFzONH+MIErvQZrtQ83U4vSUQbHmEKB6zle07Y
         e7wA==
X-Gm-Message-State: AOAM530SRp5WdQv8RwfkrJ7Slt5ZjEjaQQl5gThpSPkrgxNoy3dw+nNM
        aMRylinezHB0lDnu25wciR+Q5WnNkF58rA==
X-Google-Smtp-Source: ABdhPJxpWtngbOz++AjBTNeTk1hYNe4Owh6oGLtLfJ/5RFni0BJmhl0m+H1qttnsanzw8EU1rh3sOQ==
X-Received: by 2002:a7b:ce08:0:b0:39c:8f58:2414 with SMTP id m8-20020a7bce08000000b0039c8f582414mr940268wmc.74.1655159952236;
        Mon, 13 Jun 2022 15:39:12 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/12] submodule--helper: have --require-init imply --init
Date:   Tue, 14 Jun 2022 00:38:56 +0200
Message-Id: <patch-v2-05.12-ef3265a588e-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Adjust code added in 0060fd1511b (clone --recurse-submodules: prevent
name squatting on Windows, 2019-09-12) to have the internal
--require-init option imply --init, rather than having
"git-submodule.sh" add it implicitly.

This change doesn't make any difference now, but eliminates another
special-case where "git submodule--helper update"'s behavior was
different from "git submodule update". This will make it easier to
eventually replace the cmd_update() function in git-submodule.sh.

We'll still need to keep the distinction between "--init" and
"--require-init" in git-submodule.sh. Once cmd_update() gets
re-implemented in C we'll be able to variables and other code related
to that, but not yet.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 5 ++++-
 git-submodule.sh            | 1 -
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 9d3642290f3..7bcb76cea6a 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2618,7 +2618,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "progress", &opt.progress,
 			    N_("force cloning progress")),
 		OPT_BOOL(0, "require-init", &opt.require_init,
-			   N_("disallow cloning into non-empty directory")),
+			   N_("disallow cloning into non-empty directory, implies --init")),
 		OPT_BOOL(0, "single-branch", &opt.single_branch,
 			 N_("clone only one branch, HEAD or --branch")),
 		OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
@@ -2642,6 +2642,9 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, module_update_options,
 			     git_submodule_helper_usage, 0);
 
+	if (opt.require_init)
+		opt.init = 1;
+
 	if (filter_options.choice && !opt.init) {
 		usage_with_options(git_submodule_helper_usage,
 				   module_update_options);
diff --git a/git-submodule.sh b/git-submodule.sh
index 20fc1b620fa..5b9683bf766 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -251,7 +251,6 @@ cmd_update()
 			init=1
 			;;
 		--require-init)
-			init=1
 			require_init=1
 			;;
 		--remote)
-- 
2.36.1.1239.gfba91521d90

