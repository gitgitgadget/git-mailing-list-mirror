Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F48C04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:31:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233314AbiG1QbJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:31:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232818AbiG1Qap (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:45 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDBB43121C
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j29-20020a05600c1c1d00b003a2fdafdefbso1312041wms.2
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=RNhvJzwdpxHKH8msFj3ks2FkMR8WWi9q5BufnSrkGKE=;
        b=dTyFUPzEgUOt8USofSPEqHHvssXleNMIyZDmzUljVziSO8jUk4Hn2A3qTekxYmacdP
         60LiCG+X4o5yFskoW7VE3MiyUL+zEFNi4isdeS8ewPyHwVtqRzdhKWQGi459yjlan84t
         KD+IMy013ID6Bo7dwCFuCbgAiaFQyvwqHUWlSa4x7aGvtxi86Ig+6pETdP2an7PnlzFf
         OwBz3raGg5YOgBMcTNGbkEBi25i0qf3C6nwS4Y+48P5xiI/Zdp6F5UkPy3p01hSJCynU
         7mL94ToK7ZyDQ7ah22CrzVTeG0JwU4Qdv4mC/LsjX1X+dsOjPg6ysMych83sikcigExu
         f93A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=RNhvJzwdpxHKH8msFj3ks2FkMR8WWi9q5BufnSrkGKE=;
        b=qCXxnwb6bK49q5jJwXBEpgLwd25QlLraGStmpsG/yVxtkaV5kM3qGk7GiGJQjRVbgq
         rsaobvYF1Zvo4c/wbSxBNhPBiuQOnxVB+REWDzxudNnw4I4vZcBxt/g/4o4SatL6EcF+
         2om/yY74HI7Msxq5+MmJpDUPPqxKCNJyb0gTakAGWDIy+30ezCdfRXDB44KLGebcp5b0
         dCgO9rgrL0Vwgl1S61MFL4j+O+W+zm37iaLlDUMnpf7OPVLzEQIhICG0rlYBqvx3kRy8
         Ro0Lidef+HLBVgbiNt99xFjfQA++nYs1K+CLuGCVMK+F2GmhIPey85512rTIjlbl27Wp
         y1vQ==
X-Gm-Message-State: AJIora8Y0QTN7GTltyvkXyEivzl7Wei7hyohROc8aFI7NO2gzqAaPDsD
        xfY/q4WSIPdZBHyC3loEUv4EfNlBUCXIWg==
X-Google-Smtp-Source: AGRyM1uteTrzxaPfc2RafdbXiozy41k29UkL6QMY9TsOEX2H+NpnIKO/3bltpF1Ih8Imr+sMWCi7jw==
X-Received: by 2002:a05:600c:3549:b0:3a3:16af:d280 with SMTP id i9-20020a05600c354900b003a316afd280mr144766wmq.142.1659025831274;
        Thu, 28 Jul 2022 09:30:31 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/17] submodule--helper: fix a leak in module_add()
Date:   Thu, 28 Jul 2022 18:30:07 +0200
Message-Id: <patch-v4-13.17-b27b665d287-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in module_path(), since a6226fd772b (submodule--helper:
convert the bulk of cmd_add() to C, 2021-08-10), we've been freeing
add_data.sm_path, but in this case we clobbered it, and didn't free
the value we clobbered.

This makes test 28 of "t/t7400-submodule-basic.sh" ("submodule add in
subdirectory") pass when we're compiled with SANITIZE=leak..

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 0f6c07e3d1e..6077aecd202 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3290,8 +3290,12 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	else
 		add_data.sm_path = xstrdup(argv[1]);
 
-	if (prefix && *prefix && !is_absolute_path(add_data.sm_path))
-		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
+	if (prefix && *prefix && !is_absolute_path(add_data.sm_path)) {
+		char *sm_path = add_data.sm_path;
+
+		add_data.sm_path = xstrfmt("%s%s", prefix, sm_path);
+		free(sm_path);
+	}
 
 	if (starts_with_dot_dot_slash(add_data.repo) ||
 	    starts_with_dot_slash(add_data.repo)) {
-- 
2.37.1.1197.g7ed548b7807

