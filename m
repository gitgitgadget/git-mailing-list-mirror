Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CBEC433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30F362087E
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 17:45:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j9Dup9hO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgH0RpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 13:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgH0RpX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 13:45:23 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91A43C061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:23 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g33so3880161pgb.4
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 10:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vVvt+hb/ujMi3F93xkL3sQXrzYJs58NBbCJsnrtA2WM=;
        b=j9Dup9hOSz34bz/YTW/3T+gX/QikGNKDFiYZdSH75rWqISr9FR/BO+3NJPMxp6VkE2
         COvd9dYqs042FqMZ+PynZtO7rwqAqC4Z6597tmBqdmUwRVafbTUBs7MKJkjwVQN7rCwz
         WjtXSpf5ci1WdbkEY7p01iPQhZn++ETnpG1NDsiTMZI+fVbCqlif4iLwVV2Bg6Ca5KfQ
         QJK3IcayMTvWOS8rU+5VzMMPOkuaUHJbxiKcfYe+BZGxy2U8hhpQ+pRArRuKGxPD99WK
         JKcejl7EIeQH5obyvJI+hN3mJk51iY91bo7mjC4g+VeG6sSfsdOMOiguDe2QdeUW0n5y
         FE5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vVvt+hb/ujMi3F93xkL3sQXrzYJs58NBbCJsnrtA2WM=;
        b=gU4h4WeiVTa8Z3qHe7VZplxL92NcTEG1YlX5MHXgwHpQid9j+WXdbdJVKFPHsiJAvJ
         a4j58g+s7vRH/SgakLGYqLjS7ZVo/CC8B8vGdv5TSZGVO88Q/ZdA2Mg/TtBE25GvFoT/
         sFlUm7YAp2kHnOqrEfxtUt6+7DboYLYphpmR1Qn4CS1M17rp1L7hyHJntvVCNgIBg5h2
         d9hOyenc+t79LIhBqPhBcN05cjODsDAyv16LtnI5SUUvOdNNT1i68dX3Iobh2IqGxT4h
         v2BCPDwnXBBssTRp200PEiDHEEsuaWQtYFS51Nitrfl4pHdLgffT21J/LLi1KGwDUcDk
         50YQ==
X-Gm-Message-State: AOAM530Q5gTFvC9MNQ+WnVhkdcBAyVCA0In4haMtSB236yQ4yE6as9qS
        TjuwNk2Se+u1Cdpm1yHcDvV4i3Hx0CIvTg==
X-Google-Smtp-Source: ABdhPJwB++b6Px7Ztb+Sv2ggHb8XG0by8uWBn25BZQERloQuzWihRwpHna01vaxUHI7zkLpH1y+s8Q==
X-Received: by 2002:a17:902:b193:: with SMTP id s19mr17619319plr.194.1598550322398;
        Thu, 27 Aug 2020 10:45:22 -0700 (PDT)
Received: from konoha.iballbatonwifi.com ([103.84.62.195])
        by smtp.gmail.com with ESMTPSA id i20sm940847pfq.204.2020.08.27.10.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2020 10:45:21 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     kaartic.sivaraam@gmail.com, christian.couder@gmail.com,
        gitster@pobox.com, Johannes.Schindelin@gmx.de,
        liu.denton@gmail.com, peff@peff.net,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 3/3] t7421: eliminate 'grep' check in t7421.4 for mingw compatibility
Date:   Thu, 27 Aug 2020 23:15:01 +0530
Message-Id: <20200827174501.7103-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827174501.7103-1-shouryashukla.oo@gmail.com>
References: <20200827174501.7103-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'grep' check in test 4 of t7421 resulted in the failure of t7421 on
Windows due to a different error message

    error: cannot spawn git: No such file or directory

instead of

    fatal: exec 'rev-parse': cd to 'my-subm' failed: No such file or directory

Tighten up the check to compute 'src_abbrev' by guarding the
'verify_submodule_committish()' call using `p->status !='D'`, so that
the former isn't called in case of non-existent submodule directory,
consequently, there is no such error message on any execution
environment. The same need not be implemented for 'dst_abbrev' and is
rather redundant since the conditional 'if (S_ISGITLINK(p->mod_dst))'
already guards the 'verify_submodule_committish()' when we have a
status of 'D'.

Therefore, eliminate the 'grep' check in t7421. Instead, verify the
absence of an error message by doing a 'test_must_be_empty' on the
file containing the error.

Reported-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Helped-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 builtin/submodule--helper.c      | 7 ++++---
 t/t7421-submodule-summary-add.sh | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 93d0700891..1db1176e48 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1035,7 +1035,7 @@ static void print_submodule_summary(struct summary_cb *info, char *errmsg,
 static void generate_submodule_summary(struct summary_cb *info,
 				       struct module_cb *p)
 {
-	char *displaypath, *src_abbrev, *dst_abbrev;
+	char *displaypath, *src_abbrev = NULL, *dst_abbrev;
 	int missing_src = 0, missing_dst = 0;
 	char *errmsg = NULL;
 	int total_commits = -1;
@@ -1061,8 +1061,9 @@ static void generate_submodule_summary(struct summary_cb *info,
 	}
 
 	if (S_ISGITLINK(p->mod_src)) {
-		src_abbrev = verify_submodule_committish(p->sm_path,
-							 oid_to_hex(&p->oid_src));
+		if (p->status != 'D')
+			src_abbrev = verify_submodule_committish(p->sm_path,
+								 oid_to_hex(&p->oid_src));
 		if (!src_abbrev) {
 			missing_src = 1;
 			/*
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
index 59a9b00467..b070f13714 100755
--- a/t/t7421-submodule-summary-add.sh
+++ b/t/t7421-submodule-summary-add.sh
@@ -58,7 +58,7 @@ test_expect_success 'submodule summary output for submodules with changed paths'
 	git commit -m "change submodule path" &&
 	rev=$(git -C sm rev-parse --short HEAD^) &&
 	git submodule summary HEAD^^ -- my-subm >actual 2>err &&
-	grep "fatal:.*my-subm" err &&
+	test_must_be_empty err &&
 	cat >expected <<-EOF &&
 	* my-subm ${rev}...0000000:
 
-- 
2.28.0

