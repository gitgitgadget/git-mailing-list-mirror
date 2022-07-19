Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 937ABC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240336AbiGSUsR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240277AbiGSUsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:48:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E0B51A08
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:50 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id id17so2574001wmb.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7DrFOnCCw793bn4A+DVPEZ21cZQY1xh+gIFWl11GqDA=;
        b=MkX6lBWu7LZbMSzWjvNtvyfrgxU7uPeI0q4pqqhEs15X6mdFJcuNWnRbMjqk4NcfDo
         gctPx1+//l+teZ0odJQATzUPtD0/cQKxZwo67qNTWKpdxP/wGohIN7meOYnDCTVEMfYn
         6hLn1dh31gFQsPPNWyT0d0K8VhKCK9iIPXzvoBop6dcVRqxgDFqdCJUvjAb7PSe8kVhX
         SkgLeQYRW7dAUtSfkMjBsaNxSZNNHKE5FAAGW9VrhFNktpbNyn2xe9OWX4eSm+uZxCgk
         H4wlEpy/anUhIhGQlg1vONXj5PAnr6k49tmg5jdWgpLAwNRe1HeqFEfkiqS665+jWdE+
         ex3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7DrFOnCCw793bn4A+DVPEZ21cZQY1xh+gIFWl11GqDA=;
        b=qNsBsArUYIMISP6zVifOuApgKTHwIAajBpC9asbZWG7wFDNR+2vCeR52EQYqA0pUTg
         MVmPs4UyOqSHhYThhVkrjTyCIzHBtFvbGEc+71LJRu/gcCurPJ9kXwI1nvsp/oQlROSQ
         F0VjVS2/5av3sBAF0AoZyA9EZja3bt5sBBVKPBWXu/OmC4AeTwE/hUohdcjR0clPRvgE
         lV6LASiT2ebnkv7Eft0te5K+HRIkzX+OOKJS3Tno+cnSamJQ3xSmnvFQtBRxXeQnwJkv
         yiMW6rIxBiTLdTGy/IyK99ZRbn1S+cBPOQbAQoJ6U5mOQR3XIuPk+CfsYCmYpk43d9mb
         MP1g==
X-Gm-Message-State: AJIora++gdLO6r8Fzg42gVRlCFMFRE3PAsSyV/gIzYvZ/3+nYcIpEYLc
        SrZlRnwE9DaCZY5SMC/gVcsSKI4bJd2kEg==
X-Google-Smtp-Source: AGRyM1tt9nCRdiBhFHuRzv4VxCw9MIxP/hpWZS7rWl25+KycpAVPRFvMAEJI2oUMnIMfRPbu6Ofrtg==
X-Received: by 2002:a05:600c:3c8a:b0:3a0:4ad8:d3c4 with SMTP id bg10-20020a05600c3c8a00b003a04ad8d3c4mr908171wmb.43.1658263669260;
        Tue, 19 Jul 2022 13:47:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 24/24] submodule--helper: fix a configure_added_submodule() leak
Date:   Tue, 19 Jul 2022 22:47:15 +0200
Message-Id: <patch-v2-24.24-531db4ddae6-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
index a944f6fa442..09b8a1c2947 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3264,7 +3264,7 @@ static int config_submodule_in_gitmodules(const char *name, const char *var, con
 static void configure_added_submodule(struct add_data *add_data)
 {
 	char *key;
-	char *val = NULL;
+	const char *val;
 	struct child_process add_submod = CHILD_PROCESS_INIT;
 	struct child_process add_gitmodules = CHILD_PROCESS_INIT;
 
@@ -3309,7 +3309,7 @@ static void configure_added_submodule(struct add_data *add_data)
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
2.37.1.1062.g385eac7fccf

