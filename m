Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABA13C433F5
	for <git@archiver.kernel.org>; Mon, 30 May 2022 13:09:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236379AbiE3NJX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 May 2022 09:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236414AbiE3NJS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 May 2022 09:09:18 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCA1D8214A
        for <git@vger.kernel.org>; Mon, 30 May 2022 06:09:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id e2so14617154wrc.1
        for <git@vger.kernel.org>; Mon, 30 May 2022 06:09:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=iRp7K6Ra30h7u1lx+TVsjsU+LK/R9UG+9JEXaP9xHM0=;
        b=YrQZE0DEcsRDHbyemJJiJWEJHqH1ooaCZscjSLTNwU34XtxCO4T6kVvGU40MSEKNY7
         GBCWwwNcg6VmnsNXScDc+R3B7uimT0+e24WLe0zqpFGO5XbIDFoQ4FPTJyW2/CtLC71g
         Z8aWomwN8ejKm5AGbaPcKv3mv31YO2y6eF344wvmTi6eK6LOmWBQkNZl0pw6mxbxARvH
         CQJ+L46tEUeylOSepCWTX2wpv1TPLQ3alB+pTI2cBvUKaLrIcinYejg7vKVaf9ZR0qEP
         ghfHf3lYKLCLXgsi1BlZ7kNFVClXegEcCZmgAxDOm3HbcKT2fr9qKSAyPz6QcTSER0NS
         Bozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iRp7K6Ra30h7u1lx+TVsjsU+LK/R9UG+9JEXaP9xHM0=;
        b=uvVscUC/CzwM6E5VDvz9P7EX/o1H2C0kvWdgaWiXtxEtfxAPMrf3+rb9DjqCNXPRdQ
         P9AEYEhgmu/N+2Dz8DWxr0IpEXKPK7q+nl1pQ4n18Dzbe7ooediaVDYGz0TUJ2tMvDzz
         VkUOXk6Udf620wZ20yx3CZSM8m9S0G+OQoI11pEKE1R3izCHRJ7On8CyGBAl1/52ZprS
         Y2y4k0eNRWh88BjPUjdH0QVqVc6g3SBXwaVdY+4AQK7J5WFVoRJ09NX5ijZ1MPldpvA2
         F5vQX2zZUEc2tlPERewTBId5VUWmGelzYIqtTpWOZQpb5BKQPmVFVZ/EPJK8qX7Vg6og
         gIQw==
X-Gm-Message-State: AOAM531vosQ/up3yX2uTV4AmxgIsnsR72dIKMF1Umy0Ue3b771catKBx
        3e5xMZocFI0ek74GQMyBOfvy98IZSWw=
X-Google-Smtp-Source: ABdhPJybH2FKOGegdTnWxvtORQGPtceMnkaKkOvywGuZvzu/07h6fJkhYj0toHazD1yp7PycOAekCg==
X-Received: by 2002:a5d:4886:0:b0:20d:527:f98b with SMTP id g6-20020a5d4886000000b0020d0527f98bmr47242510wrq.70.1653916148520;
        Mon, 30 May 2022 06:09:08 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i13-20020adfaacd000000b0020fc40d006bsm8926169wrc.17.2022.05.30.06.09.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 06:09:06 -0700 (PDT)
Message-Id: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 30 May 2022 13:09:05 +0000
Subject: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

After generating diffs for each range to be compared using a 'git log'
invocation, range-diff.c::read_patches looks for the "diff --git" header
in those diffs to recognize the beginning of a new change.

In a project with submodules, and with 'diff.submodule=log' set in the
config, this header is missing for the diff of a changed submodule, so
any submodule changes are quietly ignored in the range-diff.

When 'diff.submodule=diff' is set in the config, the "diff --git" header
is also missing for the submodule itself, but is shown for submodule
content changes, which can easily confuse 'git range-diff' and lead to
errors such as:

    error: git apply: bad git-diff - inconsistent old filename on line 1
    error: could not parse git header 'diff --git path/to/submodule/and/some/file/within
    '
    error: could not parse log for '@{u}..@{1}'

Force the submodule diff format to its default ("short") when invoking
'git log' to generate the patches for each range, such that submodule
changes are always shown.

Note that the test must use '--creation-factor=100' to force the second
commit in the range not to be considered a complete rewrite.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    range-diff: show submodule changes irrespective of diff.submodule
    
    This fixes a bug that I reported last summer [1].
    
    [1]
    https://lore.kernel.org/git/e469038c-d78c-cd4b-0214-7094746b9281@gmail.com/

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1244%2Fphil-blain%2Frange-diff-submodule-diff-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1244/phil-blain/range-diff-submodule-diff-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1244

 range-diff.c          |  2 +-
 t/t3206-range-diff.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/range-diff.c b/range-diff.c
index b72eb9fdbee..068bf214544 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -44,7 +44,7 @@ static int read_patches(const char *range, struct string_list *list,
 
 	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
 		     "--reverse", "--date-order", "--decorate=no",
-		     "--no-prefix",
+		     "--no-prefix", "--submodule=short",
 		     /*
 		      * Choose indicators that are not used anywhere
 		      * else in diffs, but still look reasonable
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e30bc48a290..ac848c42536 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -772,4 +772,48 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success 'submodule changes are shown irrespective of diff.submodule' '
+	git init sub-repo &&
+	test_commit -C sub-repo sub-first &&
+	sub_oid1=$(git -C sub-repo rev-parse HEAD) &&
+	test_commit -C sub-repo sub-second &&
+	sub_oid2=$(git -C sub-repo rev-parse HEAD) &&
+	test_commit -C sub-repo sub-third &&
+	sub_oid3=$(git -C sub-repo rev-parse HEAD) &&
+
+	git checkout -b main-sub topic &&
+	git submodule add ./sub-repo sub &&
+	git -C sub checkout --detach sub-first &&
+	git add sub &&
+	git commit -m "add sub" &&
+	sup_oid1=$(git rev-parse --short HEAD) &&
+	git checkout -b topic-sub &&
+	git -C sub checkout sub-second &&
+	git add sub &&
+	git commit -m "change sub" &&
+	sup_oid2=$(git rev-parse --short HEAD) &&
+	git checkout -b modified-sub main-sub &&
+	git -C sub checkout sub-third &&
+	git add sub &&
+	git commit -m "change sub" &&
+	sup_oid3=$(git rev-parse --short HEAD) &&
+
+	test_config diff.submodule log &&
+	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
+	cat >expect <<-EOF &&
+	1:  $sup_oid1 = 1:  $sup_oid1 add sub
+	2:  $sup_oid2 ! 2:  $sup_oid3 change sub
+	    @@ Commit message
+	      ## sub ##
+	     @@
+	     -Subproject commit $sub_oid1
+	    -+Subproject commit $sub_oid2
+	    ++Subproject commit $sub_oid3
+	EOF
+	test_cmp expect actual &&
+	test_config diff.submodule diff &&
+	git range-diff --creation-factor=100 topic topic-sub modified-sub >actual &&
+	test_cmp expect actual
+'
+
 test_done

base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
-- 
gitgitgadget
