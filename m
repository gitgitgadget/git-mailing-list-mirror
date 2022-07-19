Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DECC43334
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240286AbiGSUsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239786AbiGSUrq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:47:46 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCEE558F1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id a11so3534330wmq.3
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FmjuKXsERfgH/d6ei8I0lm6cr7sFdVo1vyQ2hhDWaiw=;
        b=LBp9ep+Lw0XSWN5aTC570O1U+E8aIhNaZyDV17s92kHZ/5SWbnKUurzlAFk5pN17Ae
         lwGkUS3+oH/6ACWjkabTONox/+GAHkWs+bCPj95uMoUuo6sAWbNIw/JjCEgo2H936osD
         QEsXHawO9KI/CKloXGE7+j1qwFEWC+k+Xkz8soc0G1F6C9/ebp4914bLqtaUvFNWQgZs
         +B8pHVqYqj6O90WVjMa3UboeC97dhEggtcgHKmoXbxCeljLe+E0ShMLTY0COtJCldc9a
         uNrXr3N6tTL/Vqmu0R2liDhjMUjQYpeWfWi+bBSscsN6ICn4PkVF/LequBEHk7XjrjV+
         jwEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FmjuKXsERfgH/d6ei8I0lm6cr7sFdVo1vyQ2hhDWaiw=;
        b=Pmqt1v3j3b0lLx6H3l3NwL/VyxYbatoca+In6IpUMFpMcJRmQoG0vqu5nRIQ0vch8y
         2fxTmi1eVIyPHL/CmeWa91qfRAQrANiuj7oKGJ9HBy9l3l+BmePXZqvG3jiYyFATW3Kn
         1K3w+v+ClV7kHF1iqfbMaeN00z3pA3jYSvc7tZC5Igizr7Mlp+QvZYpnVvuZ814BblWz
         toWzXhcJwErplYplyfQAL8dOZtcN3ihOG9fkwRyVy1oxKMOHWspQX5LFIRIghW8RpsVs
         yEBwMvOT8v7Mf7Np2QZCj5UM1CBMkGP+3Jxtit/88DgMTfQ44VHdzD1SUuDZqb8KCs1q
         tEUg==
X-Gm-Message-State: AJIora9vu0/hGhRKFTRyebis4ihHIdhie+Yleq/qoJJo4gBvoUNUZxK7
        ZROcwNJlpanIQhwOiOwrFqS2HnKdxZ+wHg==
X-Google-Smtp-Source: AGRyM1vtNK/Ri+7KFvxpd03voiTqREXQNexYlVqVxMpDdIaP7TKnTFTFjtZKhd/WvWSe47Ppptgz1A==
X-Received: by 2002:a05:600c:3512:b0:3a0:5005:86b5 with SMTP id h18-20020a05600c351200b003a0500586b5mr882482wmq.191.1658263660981;
        Tue, 19 Jul 2022 13:47:40 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/24] submodule--helper: fix a leak in module_add()
Date:   Tue, 19 Jul 2022 22:47:07 +0200
Message-Id: <patch-v2-16.24-1f01203d154-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
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
 builtin/submodule--helper.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 46685bf0610..642595cc3f4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3398,8 +3398,11 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	else
 		add_data.sm_path = xstrdup(argv[1]);
 
-	if (prefix && *prefix && !is_absolute_path(add_data.sm_path))
-		add_data.sm_path = xstrfmt("%s%s", prefix, add_data.sm_path);
+	if (prefix && *prefix && !is_absolute_path(add_data.sm_path)) {
+		char *sm_path = add_data.sm_path;
+		add_data.sm_path = xstrfmt("%s%s", prefix, sm_path);
+		free(sm_path);
+	}
 
 	if (starts_with_dot_dot_slash(add_data.repo) ||
 	    starts_with_dot_slash(add_data.repo)) {
-- 
2.37.1.1062.g385eac7fccf

