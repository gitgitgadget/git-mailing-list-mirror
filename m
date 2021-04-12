Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD0AC43470
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F1DB6134F
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:22:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240260AbhDLLWW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:22:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240249AbhDLLWT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:22:19 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 607FDC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:22:01 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id w4so8781694wrt.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:22:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpALpbU5JBXMLt5ot7y6KK/aE9xw3HhNyhyb7Jot/OQ=;
        b=lwBbTjzg6HciHrV4ITfpRV05Layi5pDb2xN9RFPJqDd2BM0r9+2dSV5jmh4ELTi8CL
         Y4VmT5e8t7Hqjw7/hrm/HrZIDI3QebHc1K/+gh8c8nGUHET+tF+23J7DmuVLA9UwTq+z
         IszqVAZeZyisnxvnGRQPuh35y5hPSmC35gXFB83kAhhSgqWngLemJRTt8HKMvhxqAhew
         kjas6c99wWfycp74bPou9GipKa52DjpukfiUaS0yb1weZR6F6quPZR4aRi41n0vlaqm8
         9mRfWq+BMoG8a6HEzR902AHGM3LHURI2h28qDfULJxEnlM2LfU8C0sCGp7faeyIsfMDw
         r2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpALpbU5JBXMLt5ot7y6KK/aE9xw3HhNyhyb7Jot/OQ=;
        b=fKM1ZYuqWZHxkA3Yb6GIgPncAMM/WtVgrR6LMR5jCEqPYzf03Lo+znMZAg7FsEyhnU
         LgJaFrM2XB/jO5bGqTzdTIKqPLVKaTOlvr4x4Kr7VRR084VQRdANmiUYRPil0S607qNU
         aDpITkBNPfMRzi+IuMk/M+cJoNQYmLPirSTE8S6GT2jtPn5UVCv3WXU428OURhaQB/dt
         lIxUIAa3/h0YQ5qwr0UdfE00qzYLN1NsAYEbTlB0BBWPxmtgRlwY0ZGmG2mN92BhsRRg
         Nenfcc/OS6aFRuvLuTSHRB0ZZI5z8cNPl4szgmfRT2lRhFhPNSCcJ6w078VLMsLY7mN+
         Y2bg==
X-Gm-Message-State: AOAM530UDtnQJvFOigdAhJSSi3+VvZoL/ZLeV2hQAPqWypOjk8e7uNnU
        XpTAWYR835qPU11Qg9nXpSc9wEzaSWKb0A==
X-Google-Smtp-Source: ABdhPJwP2wZ5beDiUtDzDiHrYRG7pDQzvoBrJTPQNYcPOujs9d13kGJyglFxkuGQ08DysfdmS1l9Tw==
X-Received: by 2002:a5d:58e4:: with SMTP id f4mr28993107wrd.130.1618226519869;
        Mon, 12 Apr 2021 04:21:59 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm14580907wmb.25.2021.04.12.04.21.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:21:59 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Benno Evers <benno@bmevers.de>, Jean Privat <jean@pryen.org>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/5] describe tests: fix nested "test_expect_success" call
Date:   Mon, 12 Apr 2021 13:21:46 +0200
Message-Id: <patch-4.5-5c81358d6bb-20210412T111601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
References: <20210228195414.21372-1-avarab@gmail.com> <cover-0.5-00000000000-20210412T111601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a nested invocation of "test_expect_success", the
"check_describe()" function is a wrapper for calling
test_expect_success, and therefore needs to be called outside the body
of another "test_expect_success".

The two tests added in 30b1c7ad9d6 (describe: don't abort too early
when searching tags, 2020-02-26) were not testing for anything due to
this logic error. Without this fix reverting the C code changes in
that commit still has all tests passing, with this fix we're actually
testing the "describe" output. This is because "test_expect_success"
calls "test_finish_", whose last statement happens to be true.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6120-describe.sh | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 911b1928057..9dc07782ea6 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -469,7 +469,7 @@ test_expect_success 'name-rev covers all conditions while looking at parents' '
 #  o-----o---o----x
 #        A
 #
-test_expect_success 'describe commits with disjoint bases' '
+test_expect_success 'setup: describe commits with disjoint bases' '
 	git init disjoint1 &&
 	(
 		cd disjoint1 &&
@@ -482,19 +482,22 @@ test_expect_success 'describe commits with disjoint bases' '
 		git checkout --orphan branch && rm file &&
 		echo B > file2 && git add file2 && git commit -m B &&
 		git tag B -a -m B &&
-		git merge --no-ff --allow-unrelated-histories main -m x &&
-
-		check_describe "A-3-gHASH" HEAD
+		git merge --no-ff --allow-unrelated-histories main -m x
 	)
 '
 
+(
+	cd disjoint1 &&
+	check_describe "A-3-gHASH" HEAD
+)
+
 #           B
 #   o---o---o------------.
 #                         \
 #                  o---o---x
 #                  A
 #
-test_expect_success 'describe commits with disjoint bases 2' '
+test_expect_success 'setup: describe commits with disjoint bases 2' '
 	git init disjoint2 &&
 	(
 		cd disjoint2 &&
@@ -508,10 +511,13 @@ test_expect_success 'describe commits with disjoint bases 2' '
 		echo o >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:01" git commit -m o &&
 		echo B >> file2 && git add file2 && GIT_COMMITTER_DATE="2020-01-01 15:02" git commit -m B &&
 		git tag B -a -m B &&
-		git merge --no-ff --allow-unrelated-histories main -m x &&
-
-		check_describe "B-3-gHASH" HEAD
+		git merge --no-ff --allow-unrelated-histories main -m x
 	)
 '
 
+(
+	cd disjoint2 &&
+	check_describe "B-3-gHASH" HEAD
+)
+
 test_done
-- 
2.31.1.634.gb41287a30b0

