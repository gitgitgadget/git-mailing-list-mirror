Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8620C74A5B
	for <git@archiver.kernel.org>; Fri, 17 Mar 2023 05:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbjCQFBV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Mar 2023 01:01:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbjCQFBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2023 01:01:19 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E11C5A920
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l12so3338164wrm.10
        for <git@vger.kernel.org>; Thu, 16 Mar 2023 22:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679029275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Jq6EtT3ivDdJlpJBGbRAFd/+oTBhB0RxGrEbZmVA5r4=;
        b=CfCu0hutIfoirpPgiFRaFD25DxepdcqUFe+2MR5BFMc4rOMBKNhq+vHkVQGVUjs6lY
         s81aRKlZzSbT4Ck0kdh6MsH0twVasOqKYDrdP4kIRfMs8KDGNaxH1P2lv2LFtxpVLNY/
         pfwjQpxQFX4WFp08UcoWA10pZSqLjGtByyIyHBzEUfNSVe0oNuI12iO7LbZzfxLxzXMd
         2Fp19IKuK+Dn7vX/Gw3Pj/qMe7qY2uLjnIAITBojNLVMqStetUtzCGYtVSYgMP1M+/9D
         d5NV6bCMayOUPEmSe1IwK2Xbe5YpaStG/ZZ7kiCvKUNG7D7MS22Mn1czJT/fM+LmBfC/
         N3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679029275;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Jq6EtT3ivDdJlpJBGbRAFd/+oTBhB0RxGrEbZmVA5r4=;
        b=tb9dSOCrBsqlaRJCHMvz21m/bo9IBgEX6OgFERjs7MsNZFoLTSfEFhH9qUh+o0fX5t
         GMazCE9EKUueb2AICKr0dx1bZyk4Fa6GmCSxTRhYWWqVh9tqgKaedvxL+1ZYlLA7r1CT
         FHBNTRdXdOQsaW8g+eyLo9OK5G2TwuUfF6XYgit9wvxv5c3O7xVq2UQvR3RsfDhqG3c8
         LQSf7PN40giTLYq5vqCBTTa5VPwOiSFGBWdFG8ayel59Vr2Ra95kes+Xgs5n9HV7wE1A
         oeKsSXf0tJ8vCEkMNEkYNXtXfiTZQ2LSmwrOM00BBFE7E6B6uGKR8+XvYyjTfWbc5uWV
         0cFQ==
X-Gm-Message-State: AO0yUKVOvcdb9/W6BM1d+7YA/JkVsQKI+J/h6dt9DRPvHalyqzxAj1v/
        zNN77p0WCOVCNUsge0hWMdhMnlvUm6bHMw==
X-Google-Smtp-Source: AK7set9WVTu1R2ltZwVmyGPOv1fx1LBLoaZLRX5JFtBoQqMMMMpbg0NyROfTjNu99C0khdLQ5Csusg==
X-Received: by 2002:a5d:5234:0:b0:2ce:a3c7:d2a4 with SMTP id i20-20020a5d5234000000b002cea3c7d2a4mr1292926wra.25.1679029275301;
        Thu, 16 Mar 2023 22:01:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g9-20020a5d4889000000b002c559843748sm1027844wrq.10.2023.03.16.22.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Mar 2023 22:01:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Emily Shaffer <nasamuffin@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Calvin Wan <calvinwan@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 1/5] config.h: move up "struct key_value_info"
Date:   Fri, 17 Mar 2023 06:01:06 +0100
Message-Id: <RFC-patch-1.5-13d383536bd-20230317T042408Z-avarab@gmail.com>
X-Mailer: git-send-email 2.40.0.rc1.1034.g5867a1b10c5
In-Reply-To: <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
References: <pull.1463.v2.git.git.1678925506.gitgitgadget@gmail.com> <RFC-cover-0.5-00000000000-20230317T042408Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Move the declaration of the "struct key_value_info" earlier in the
file, in a subsequent commit we'll need it shortly after this line.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/config.h b/config.h
index 7606246531a..571b92d674a 100644
--- a/config.h
+++ b/config.h
@@ -110,6 +110,13 @@ struct config_options {
 	} error_action;
 };
 
+struct key_value_info {
+	const char *filename;
+	int linenr;
+	enum config_origin_type origin_type;
+	enum config_scope scope;
+};
+
 /**
  * A config callback function takes three parameters:
  *
@@ -612,13 +619,6 @@ int git_config_get_expiry(const char *key, const char **output);
 /* parse either "this many days" integer, or "5.days.ago" approxidate */
 int git_config_get_expiry_in_days(const char *key, timestamp_t *, timestamp_t now);
 
-struct key_value_info {
-	const char *filename;
-	int linenr;
-	enum config_origin_type origin_type;
-	enum config_scope scope;
-};
-
 /**
  * First prints the error message specified by the caller in `err` and then
  * dies printing the line number and the file name of the highest priority
-- 
2.40.0.rc1.1034.g5867a1b10c5

