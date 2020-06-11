Return-Path: <SRS0=QgeI=7Y=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B60AEC433E0
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:22:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93081206DC
	for <git@archiver.kernel.org>; Thu, 11 Jun 2020 17:22:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jr8bkyjQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgFKRWN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Jun 2020 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726763AbgFKRWM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Jun 2020 13:22:12 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E563C03E96F
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:22:12 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id x27so3933022lfg.9
        for <git@vger.kernel.org>; Thu, 11 Jun 2020 10:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8NSXp7aIK1opPOM6pDYJWt0ztrsBO1j5dDhFZoOzu4=;
        b=jr8bkyjQ+lhmScg6eEb6frTaSyN+ZAduc/71GndB114UKKcGDdoaXW20mqfpTJFuhf
         tsyWTdefbbgTI9klu3L7FN2Ul2Mf+ud4A2/S6QAtdqYgnKvxnAfPyjba85opznBPHu2v
         ZsSmkuhkvP5EnPU0HR7f7HnadlOGl9TouFHNzJKnggD3xAXWAUHGPHbox7agEOBrl6OT
         jut7ze5mdC10iv3ESoAQ7A10+E3CctuKyj3lYbyo/GfXPjg+ks4o5rw79Gnb4qFMeqek
         h5eeSBQMsuAA9ZEIKimKhh4QhXTHJsITpzv5vg6tJHnHZtBXukpb77CORMMx85qaFw+I
         gO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=p8NSXp7aIK1opPOM6pDYJWt0ztrsBO1j5dDhFZoOzu4=;
        b=TsEBt4uybj/6AuwPPoBsOkNkHoAkLII/gK0TnSb4wHbPWTePVJ+o/9sJIEjNrw1kBc
         ZXp6Ckjre6HlJBkJFQHmFISWz75gzGMBD1fo8O4ecV8rF4ttzoGGXX/GPTMlU9CM2nAT
         fKGUfp2DBkTmId06CL9K+mLfzL2mOD3R9N+0Zw5hwW89n3nMhRSanZkt785USVBqu2ey
         PJ5AoezHxMxLer/+1C/7IE9ybZTaLa1/Mfbb3aqpXK0nu7lBPLfAb5A0L0a9nHPvUIwH
         wsPVMz9b01aB7pFcw2mmdF8BgkM8dajiWxXzlde90l71mkiIICHI3C3PH5W1oNJ2SpLR
         UM5g==
X-Gm-Message-State: AOAM5338OsGS05R/dkah68BtkkDtlNHCI48VhAojKiLtjZ03EadaBed1
        d7aJ00/TVSV/suqKYsgFwkIX2mVmsx4=
X-Google-Smtp-Source: ABdhPJwgo5aG5o2wEFnQUVxaKn+777cpnH+/XLnEURQPg+EnmkJBl2mD3vqa85/26fq7xT8tGyqcvg==
X-Received: by 2002:a19:987:: with SMTP id 129mr4892281lfj.8.1591896130697;
        Thu, 11 Jun 2020 10:22:10 -0700 (PDT)
Received: from localhost ([146.66.199.134])
        by smtp.gmail.com with ESMTPSA id v11sm851828ljc.137.2020.06.11.10.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2020 10:22:09 -0700 (PDT)
From:   Azat Khuzhin <a3at.mail@gmail.com>
To:     git@vger.kernel.org
Cc:     Azat Khuzhin <a3at.mail@gmail.com>
Subject: [PATCH] pull: passthrough --no-verify to merge
Date:   Thu, 11 Jun 2020 20:22:01 +0300
Message-Id: <20200611172201.962109-1-a3at.mail@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Azat Khuzhin <a3at.mail@gmail.com>
---
 builtin/pull.c                                   |  6 ++++++
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 12 ++++++++++++
 2 files changed, 18 insertions(+)

diff --git a/builtin/pull.c b/builtin/pull.c
index 00e5857a8d..de48cab325 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -83,6 +83,7 @@ static char *opt_commit;
 static char *opt_edit;
 static char *cleanup_arg;
 static char *opt_ff;
+static char *no_verify;
 static char *opt_verify_signatures;
 static int opt_autostash = -1;
 static int config_autostash;
@@ -160,6 +161,9 @@ static struct option pull_options[] = {
 	OPT_PASSTHRU(0, "ff-only", &opt_ff, NULL,
 		N_("abort if fast-forward is not possible"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
+	OPT_PASSTHRU(0, "no-verify", &no_verify, NULL,
+		N_("bypass pre-merge-commit and commit-msg hooks"),
+		PARSE_OPT_NOARG),
 	OPT_PASSTHRU(0, "verify-signatures", &opt_verify_signatures, NULL,
 		N_("verify that the named commit has a valid GPG signature"),
 		PARSE_OPT_NOARG),
@@ -691,6 +695,8 @@ static int run_merge(void)
 		argv_array_push(&args, opt_ff);
 	if (opt_verify_signatures)
 		argv_array_push(&args, opt_verify_signatures);
+	if (no_verify)
+		argv_array_push(&args, no_verify);
 	argv_array_pushv(&args, opt_strategies.argv);
 	argv_array_pushv(&args, opt_strategy_opts.argv);
 	if (opt_gpg_sign)
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index b3485450a2..be5dcfcc90 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -278,4 +278,16 @@ test_expect_success 'check the author in hook' '
 	test_cmp expected_hooks actual_hooks
 '
 
+test_expect_success '--no-verify with failing hook (pull)' '
+	test_when_finished "rm -f \"$PREMERGE\" actual_hooks" &&
+	cp "$HOOKDIR/fail.sample" "$PREMERGE" &&
+	git remote add origin . &&
+	test_when_finished "git remote remove origin" &&
+	git branch -f side side-orig &&
+	git checkout side &&
+	git pull --no-verify --no-edit . master &&
+	git checkout master &&
+	test_path_is_missing actual_hooks
+'
+
 test_done
-- 
2.27.0

