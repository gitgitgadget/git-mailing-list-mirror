Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A85CC43334
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 13:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235444AbiGMNQv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 09:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236185AbiGMNQk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 09:16:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953ED12D27
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:36 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id z12so15472668wrq.7
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 06:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k2IR5AYMQjDQMTEKCnHr8D5TPBFdEWrjobcPUsIQycw=;
        b=qp2r2y4U9hW9SsoAMh9vrM5F5f8KxieN/X39Oi26WCYK+MLH1NBBSS+Aajdx91pakF
         k6/atrFBMr1H9AhviyoSv6LqaCSgfMFFHFW3LBW+Rhgpk1DOVCoJLE647bQAj/c2c5bY
         suYNq3L81jSJ/PU6r2XKNbRR4hCK6HQJfcgnWsknoXwkwV/Bvbgdl+gYFiQQMgVwDhZd
         b5CFyEABI8/P4WOVpIpHUyFqkrFaMW6C/iCFaslnydj+jDvkNigFctHrEUuNKW9cOE0G
         199jwxn8lGSLznlDBiQeEpYdiueZJvZNHntYXvoI9jYjLyuyeYOpUslnsLtHwvUgCtQ9
         FPNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k2IR5AYMQjDQMTEKCnHr8D5TPBFdEWrjobcPUsIQycw=;
        b=OQdmA0C+76r6UBq6jxjdLZmSXsuHWBJsD6ezJc1LLHfCPcDgO4s3KeXjAcKfSGqKNW
         3plIxbdNcLvj/XYI/ZwyZLR4YHxmv/Etb4I0KaLD63w3jr3rpLgI6JpbwGtHUHFZ40G9
         mVgQTkRp4DiB+cejrQ9tRTHuIuyHSA9IAsgvNGMKFjgLowD+1EZpAeZhC0Og5V5yfD6r
         wLR4UYTlbVi3sQGkkSO29e6M3oL+Ont5cuAtZKpJaM92vVVea/OihpveGfxnydDPpvoN
         +EmRKtMncPQCY2Pbh4wj8mM2CeVlQPyuY4yemWys86MqTfuPnft3h5Tkg7U0tbeNk3T2
         nRVg==
X-Gm-Message-State: AJIora+kZZSDxmZjvnvigOYnhiOqUmLrNMLOh+4unuZJtt5EITIn9c5z
        8xlT2u1otNrbzCmhnvOv3FdUMAtN8Ylpbg==
X-Google-Smtp-Source: AGRyM1u1WVfgMSaTslp9Tlm1DCUWerd5woBTbgLELmuQnjPZ5GE+NFWU8+JLB4LFLgT2u9ZjxxdfDA==
X-Received: by 2002:a5d:5985:0:b0:21d:b6aa:23f5 with SMTP id n5-20020a5d5985000000b0021db6aa23f5mr3385089wri.18.1657718194353;
        Wed, 13 Jul 2022 06:16:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t63-20020a1c4642000000b003a2e05a81b3sm2216352wma.8.2022.07.13.06.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 06:16:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/11] submodule--helper: free "char *" in "struct update_data"
Date:   Wed, 13 Jul 2022 15:16:14 +0200
Message-Id: <patch-09.11-7b36f71879e-20220713T131601Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.932.g7b7031e73bc
In-Reply-To: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Make the update_data_release() function free the "recursive_prefix"
and "displaypath" members when appropriate. For the former it could
come from either "argv" or from our own allocation, so we need to keep
track of a "to_free" sibling seperately.

For "displaypath" it's always ours, so the "const char *" type was
wrong to begin with, it should be a "char *" instead.

For update_submodule() we'll free() these as we go along, it's called
in a loop by update_submodules(), and we'll need to free the "last"
one.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2b44f391f15..0bac39880d2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1949,7 +1949,7 @@ static void submodule_update_clone_release(struct submodule_update_clone *suc)
 
 struct update_data {
 	const char *prefix;
-	const char *displaypath;
+	char *displaypath;
 	enum submodule_update_type update_default;
 	struct object_id suboid;
 	struct string_list references;
@@ -1987,6 +1987,7 @@ struct update_data {
 
 static void update_data_release(struct update_data *ud)
 {
+	free(ud->displaypath);
 	module_list_release(&ud->list);
 }
 
-- 
2.37.0.932.g7b7031e73bc

