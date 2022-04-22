Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC9DDC433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 13:38:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448099AbiDVNlY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 09:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448086AbiDVNlV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 09:41:21 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF75583BF
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 06:38:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id o20-20020a05600c511400b0038ebbbb2ad8so5404476wms.0
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:mime-version:content-transfer-encoding
         :fcc:to:cc;
        bh=eTWB7ih3CiEQ8e6jRQ//GsqKphiysNBxFCxnf9uM5F4=;
        b=E3nqI+xoAd1WiINtW8ZxC4/fo3kvJBWd1jzkJnTS8Hf5cEzdpRG1+dvJjSKSL8AK4F
         gmunhmjo69rYEdJxfrLnfh8tt3X0IyhBm4XT/fxklJZkTd7JpP5eNFMqn5Rk1AF2tMtg
         RY75yknddp5fjbyyvq49w9lJugtfT2v1DZYqXf42NbuT78xLFEVcMkqMhp3YRQ+ad62v
         3zTuiXNEdZSMV9TzkyU17NaTqQ4/A2aGKQ+CdF9yl7b0/jRwu3nItIkym80BKYI3qizx
         1zt7T5KYURn7dDRh6YMMEVP1wyhq43hwVrJ9xlE/zXnLmGoulF1ak4ZsBMkuOtNhrcJq
         56xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=eTWB7ih3CiEQ8e6jRQ//GsqKphiysNBxFCxnf9uM5F4=;
        b=EFyATGaMxr2tdKX0PJn8pR3xu34zc5HGANS7r0q5WE7Tw1RenjMRS8RpLuPBuV1R2Q
         /j/tTuPMCymGo0Z1joz6FwbbnQfijdspcHyNayRL8EI7Kt5R1Y/XbpGMUoJpKXrHmJlY
         Bjzx/nAoxBABBzLwdvD5gLSqEr4R2Flv9AzsZkCFDaLVu2AmlFMI7Gzm0f1yAjbKxF3o
         O+LDTz/jny+h7IzZ2FMGZTkYiqOaV7yb2wR6B7t0SCSMVE2hBBzhV+O0wRYjZjnb0NcA
         dVrmhTLrmurOOsWOqav9nHmkcbz1I4m3fXclyE9swNkqqpNUxtFMxEdhsWf+/vqBQF4z
         MgLg==
X-Gm-Message-State: AOAM530n8J7A8l3LBhGKQCLTgb2yiSu8Gt1qG8ofeASdlQskhEMxDDha
        xYNvoqKWSHdjg02BNFisP5SsSNagaM0=
X-Google-Smtp-Source: ABdhPJy2QMfpHCSfydjtS+zDQCWPqMiAddPr/dJ+0Njq4KrXcbjkYrOyhX74PxyF0aVTYvU8zzvAfA==
X-Received: by 2002:a05:600c:35c5:b0:390:9982:73ec with SMTP id r5-20020a05600c35c500b00390998273ecmr13477603wmq.196.1650634705508;
        Fri, 22 Apr 2022 06:38:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d64e7000000b0020aaa0fea81sm2121280wri.36.2022.04.22.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 06:38:25 -0700 (PDT)
Message-Id: <pull.1222.git.1650634704191.gitgitgadget@gmail.com>
From:   "gdd via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 22 Apr 2022 13:38:24 +0000
Subject: [PATCH] show-branch: fix SEGFAULT on both --current & --reflog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        gdd <gregory.david@p1sec.com>,
        Gregory DAVID <gregory.david@p1sec.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gregory DAVID <gregory.david@p1sec.com>

If run `show-branch` with `--current` and `--reflog` simultaneously, a
SEGFAULT appears.

The bug is that we read over the end of the `reflog_msg` array after
having `append_one_rev()` for the current branch without supplying a
convenient message to it.

It seems that it has been introduced in: Commit
1aa68d6735 (show-branch: --current includes the current branch.,
2006-01-11)

Signed-off-by: Gregory DAVID <gregory.david@p1sec.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
    show-branch: fix SEGFAULT on --current + --reflog
    
    If run show-branch with --current and --reflog simultaneously, a
    SEGFAULT appears.
    
    The bug is that we read over the end of the reflog_msg array after
    having append_one_rev() for the current branch without supplying a
    convenient message to it.
    
    It seems that it has been introduced in: Commit 1aa68d6735 (show-branch:
    --current includes the current branch., 2006-01-11)
    
    Signed-off-by: Gregory DAVID gregory.david@p1sec.com Thanks-to: Ævar
    Arnfjörð Bjarmason avarab@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1222%2Fp1-gdd%2Ffix%2Fshow-branch-segfault-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1222/p1-gdd/fix/show-branch-segfault-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1222

 builtin/show-branch.c  | 16 ++++++++++++++++
 t/t3202-show-branch.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index e12c5e80e3e..723637079d8 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -812,8 +812,24 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 		if (!has_head) {
 			const char *name = head;
+			struct object_id oid;
+			char *ref;
+			unsigned int flags = 0;
+			char *log_msg = NULL;
+			char *end_log_msg;
+			timestamp_t timestamp;
+			int tz;
+
+			if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
+				die(_("no such ref %s"), *av);
+			read_ref_at(get_main_ref_store(the_repository), ref, flags, 0, i, &oid, &log_msg, &timestamp, &tz, NULL);
+			end_log_msg = strchr(log_msg, '\n');
+			if (end_log_msg)
+				*end_log_msg = '\0';
 			skip_prefix(name, "refs/heads/", &name);
 			append_one_rev(name);
+			reflog_msg[ref_name_cnt - 1] = xstrfmt("(%s) (current) %s", show_date(timestamp, tz, DATE_MODE(RELATIVE)), (!log_msg || !*log_msg) ? "(none)" : log_msg);
+			free(log_msg);
 		}
 	}
 
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 7a1be73ce87..7f6ffcf8a57 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -161,4 +161,47 @@ test_expect_success 'show branch --reflog=2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'show branch --reflog=2 --current' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
+	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10
+	>	  * [branch10] (4 years, 5 months ago) (current) branch: Created from initial
+	>	---
+	>	+ * [refs/heads/branch10@{0}] branch10
+	>	++* [refs/heads/branch10@{1}] initial
+	EOF
+	git show-branch --reflog=2 --current >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'show branch --current' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [branch1] branch1
+	>	 ! [branch2] branch2
+	>	  ! [branch3] branch3
+	>	   ! [branch4] branch4
+	>	    ! [branch5] branch5
+	>	     ! [branch6] branch6
+	>	      ! [branch7] branch7
+	>	       ! [branch8] branch8
+	>	        ! [branch9] branch9
+	>	         * [branch10] branch10
+	>	          ! [master] initial
+	>	-----------
+	>	         *  [branch10] branch10
+	>	        +   [branch9] branch9
+	>	       +    [branch8] branch8
+	>	      +     [branch7] branch7
+	>	     +      [branch6] branch6
+	>	    +       [branch5] branch5
+	>	   +        [branch4] branch4
+	>	  +         [branch3] branch3
+	>	 +          [branch2] branch2
+	>	+           [branch1] branch1
+	>	+++++++++*+ [master] initial
+	EOF
+	git show-branch --current >actual &&
+	test_cmp actual expect
+'
+
 test_done

base-commit: d516b2db0af2221bd6b13e7347abdcb5830b2829
-- 
gitgitgadget
