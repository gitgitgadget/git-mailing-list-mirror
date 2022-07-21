Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD8E8C43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiGUTP3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233560AbiGUTOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:50 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E557D8D5F7
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:28 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h206-20020a1c21d7000000b003a2fa488efdso1329875wmh.4
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0qX+2Kje057Xg7xHBIA7J9T8jY8Egoygt24/m7iQF0w=;
        b=g7iH/unb2C7oILssr3FgDdVVObWQjKOrUUBg+JBl6Fu5de7Nbyg3wRL+DdqsTpap2U
         4O6GsNT6JKKuTxeKjSgBSVmSeLEyN3Yq8BIO5VDWxPe1b6afEnI4fcaPZ91viy20681/
         sLwC3dvseB9FOW/zwhny7rdGhhyuvpXxD8/KuoHQcjmxen6QuJ1AYUPLuhTM1IUHoILO
         PI3q8kB+GIP7GtAwqd0rQMSZkBsKPnBzu7o8BN371Bj2ld3adeYpPXkzF9e8lb0mkjzG
         wWinRcQOW/VSI2Eajk4rxbsJhFC3bCMilzASwULzQkE4K/r+dhJ8bkaubCNtRsE2acYc
         dl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0qX+2Kje057Xg7xHBIA7J9T8jY8Egoygt24/m7iQF0w=;
        b=zyDpGlQnzxam1RjyY07H9k5wXJNDQTGLW9YpTK0ffYHaqEUEtQjLH2c3fJfAvrdN2a
         Ry/M1eR4z+C2FNXSE1ZuIhs0NkMg8GT6ZoAhs07cWCHp71yCNxjJ6MZlNmrdYkQlekY6
         VOvIkxQsKjm+s0L6pOZNWarHgnRqxPBkA1AcKhUgc+SLnVIa0qDPEjWNGQuT6pVTJUon
         lKKCTchzBsU2RUCGvsfQHE/Lb7Pm6Up1VuyslkE8jUnBEaiOvQyurLgty/HR/8IQP+8I
         PUnJalBpqXCILanJaqcSkrT+R3MPb5bf87wwTIki/IwtGQRXqUYwhA65RgaYi1YT2Omx
         MyBg==
X-Gm-Message-State: AJIora8L/VG4VGNFolZ5wOXvPpAfT13W6tOoHPSnakd3aoKY9XpxUVu4
        LzRqTXXP5qEJLCEDjI1crSDtm6XC1QlPDA==
X-Google-Smtp-Source: AGRyM1u9tGTNYLh0uVmTt0P+8pAwAiWTmN18mPduwnO6epyKG6MjqKFF8ef5bXTacsh6Op6RjEuUHQ==
X-Received: by 2002:a05:600c:2116:b0:3a3:7f:f3cc with SMTP id u22-20020a05600c211600b003a3007ff3ccmr9638095wml.28.1658430867189;
        Thu, 21 Jul 2022 12:14:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 26/26] submodule--helper: fix a configure_added_submodule() leak
Date:   Thu, 21 Jul 2022 21:13:22 +0200
Message-Id: <patch-v3-26.26-581ce0872c0-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix config API a memory leak added in a452128a36c (submodule--helper:
introduce add-config subcommand, 2021-08-06) by using the *_tmp()
variant of git_config_get_string().

In this case we're only checking whether
the (repo|git)_config_get_string() call is telling us that the
"submodule.active" key exists.

As with the preceding commit we'll find many other such patterns in
the codebase if we go fishing. E.g. "git gc" leaks in the code added
in 61f7a383d3b (maintenance: use 'incremental' strategy by default,
2020-10-15). Similar code in "git gc" added in
b08ff1fee00 (maintenance: add --schedule option and config,
2020-09-11) doesn't leak, but we could avoid the malloc() & free() in
that case.

A coccinelle rule to find those would find and fix some leaks, and
cases where we're doing needless malloc() + free()'s but only care
about the key existence, or are copying
the (repo|git)_config_get_string() return value right away.

But as with the preceding commit let's punt on all of that for now,
and just narrowly fix this specific case in submodule--helper.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c    | 4 ++--
 t/t7413-submodule-is-active.sh | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 37c145b3ede..fdf96c5d424 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3261,7 +3261,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	char *val = NULL;
+	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3306,7 +3306,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val)) {
+	if (!git_config_get_string_tmp("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
diff --git a/t/t7413-submodule-is-active.sh b/t/t7413-submodule-is-active.sh
index c8e7e983317..c4c1f86f3d2 100755
--- a/t/t7413-submodule-is-active.sh
+++ b/t/t7413-submodule-is-active.sh
@@ -6,6 +6,7 @@ This test verifies that `git submodue--helper is-active` correctly identifies
 submodules which are "active" and interesting to the user.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.37.1.1095.g0bd6f54ba8a

