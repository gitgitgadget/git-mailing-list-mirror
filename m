Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADFA5C432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 08:01:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 72B0E207FC
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 08:01:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p66K3WgU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbfKXIBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 03:01:18 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46253 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfKXIBS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 03:01:18 -0500
Received: by mail-wr1-f68.google.com with SMTP id z7so10206368wrl.13
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 00:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=MXIFS8SvygHAUfH8DMMADCIjXmkmYNgHZ++anABHsgg=;
        b=p66K3WgUhGkrlU7tw/CZQvfpafCKLFRsCzuixLgdDIAeGciYPVJJz8yGTKWuzr59Vl
         E6Yw933mpW/ItcvaryZvhD776xEleQ/Vmejx7hH/ScfN4qfcN6mhvvVAOEprUEiBkLFG
         GB4gkn4XwPfYGMGsO8oqUDnWVi5V81D6FIMz32Vu/rN1oi/BBaT3Z7DFT1OgkVPTKme9
         p5wbwYmLeneW/PHwnflfQ2XFB67HnoRF/SJxW9YLsKE2OFGKWm+96Cmh6+HsHnoHuMNw
         SRuVxMV87f5a+fm5oV3I/fnDTDCockbACYGHEz/QCamOjFrqnPCRc3rV8yGAxGI42fua
         fk/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=MXIFS8SvygHAUfH8DMMADCIjXmkmYNgHZ++anABHsgg=;
        b=soQjx2IbSXJjp1LUjdquNTkMcNkeY0A3TygBBeVGcixsRYxIWcWhPGqH5dvQ4zaVgj
         7n8eVmhNiSnIPSB6YwlLWTcCAODC0EB2PTQ2yVy4zOqwrQ0DR90rM+ZjsS4Emr0kaaH2
         Vbileo1SCUj/bqquvDHytr8h+slyz4h1czIHUJLF/tzb2IzNXM8Df+LsR/O7G4/YO82C
         6gavSVEzPQbMKSfYGswV97PCn/aOz4pO/wzASCFVpdx1xPtSMYNWjk5bFYMtA3cjr0mN
         6v3Q6+GkMTrnU1E2v1ViRliALiOtCZaMfsYTUU0yCPMEjGNuKqvX8aElOJBhyqMKz0L5
         NZkA==
X-Gm-Message-State: APjAAAW8fExtPDx77vhoxUSit4mVQtjkbEkUp7uO8RwUF8lQx2gQ9At9
        5mVubiz7sRRHOxpZ4uQ7/cfVt4m8
X-Google-Smtp-Source: APXvYqygm2cNGs2k+EY7J/O2iVaJpTApuKP15S3UnaoGplC9n/0pRBH3ZShKIrKeYrUThtIzpRAbUw==
X-Received: by 2002:a5d:4445:: with SMTP id x5mr26605369wrr.341.1574582475914;
        Sun, 24 Nov 2019 00:01:15 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w11sm5459161wra.83.2019.11.24.00.01.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 00:01:15 -0800 (PST)
Message-Id: <e4c932bd0907daa53d1d721f9c9400bdad17fb62.1574582473.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
References: <pull.472.git.1574490521.gitgitgadget@gmail.com>
        <pull.472.v2.git.1574582473.gitgitgadget@gmail.com>
From:   "Manish Goregaokar via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 08:01:13 +0000
Subject: [PATCH v2 1/1] submodule: fix 'submodule status' when called from a
 subdirectory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Manish Goregaokar <manishsmail@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Manish Goregaokar <manishsmail@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Manish Goregaokar <manishsmail@gmail.com>

When calling `git submodule status` while in a subdirectory, we are
incorrectly not detecting modified submodules and
thus reporting that all of the submodules are unchanged.

This is because the submodule helper is calling `diff-index` with the
submodule path assuming the path is relative to the current prefix
directory, however the submodule path used is actually relative to the root.

Always pass NULL as the `prefix` when running diff-files on the
submodule, to make sure the submodule's path is interpreted as relative
to the superproject's repository root.

Signed-off-by: Manish Goregaokar <manishsmail@gmail.com>
---
 builtin/submodule--helper.c |  3 ++-
 t/t7400-submodule-basic.sh  | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 909e77e802..eeea8dfa97 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -802,7 +802,8 @@ static void status_submodule(const char *path, const struct object_id *ce_oid,
 			 path, NULL);
 
 	git_config(git_diff_basic_config, NULL);
-	repo_init_revisions(the_repository, &rev, prefix);
+
+	repo_init_revisions(the_repository, &rev, NULL);
 	rev.abbrev = 0;
 	diff_files_args.argc = setup_revisions(diff_files_args.argc,
 					       diff_files_args.argv,
diff --git a/t/t7400-submodule-basic.sh b/t/t7400-submodule-basic.sh
index a208cb26e1..4545b47ca4 100755
--- a/t/t7400-submodule-basic.sh
+++ b/t/t7400-submodule-basic.sh
@@ -356,6 +356,25 @@ test_expect_success 'status should only print one line' '
 	test_line_count = 1 lines
 '
 
+test_expect_success 'status from subdirectory should have the same SHA1' '
+	test_when_finished "rmdir addtest/subdir" &&
+	(
+		cd addtest &&
+		git status > /tmp/foo &&
+		git submodule status | awk "{print \$1}" >expected &&
+		mkdir subdir &&
+		cd subdir &&
+		git submodule status | awk "{print \$1}" >../actual &&
+		test_cmp ../expected ../actual &&
+		git -C ../submod checkout @^ &&
+		git submodule status | awk "{print \$1}" >../actual2 &&
+		cd .. &&
+		git submodule status | awk "{print \$1}" >expected2 &&
+		test_cmp actual2 expected2 &&
+		test_must_fail test_cmp actual actual2
+	)
+'
+
 test_expect_success 'setup - fetch commit name from submodule' '
 	rev1=$(cd .subrepo && git rev-parse HEAD) &&
 	printf "rev1: %s\n" "$rev1" &&
-- 
gitgitgadget
