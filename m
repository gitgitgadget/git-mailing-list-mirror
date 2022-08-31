Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385CEECAAD5
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 23:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232832AbiHaXTG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 19:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiHaXSe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 19:18:34 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C474A00FB
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:33 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id v16so17401097wrm.8
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 16:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=68b02T2ZuUBA/HDW+OC1DvbC+PwA/q6ufZIF15rjr3c=;
        b=nZN2Mw5WVJcHsYPuq62onsmi+SZ6y/mHZCI00ImTn6db9uRynnig9G0jYzRzL/OH31
         KxmjtAOfbv+FteeyfxdZJ7yFJ7oZ0NVltbqbIacpSAwJ5qFNlacKdFMePUDLzA1XtQqj
         W2HxQEO4JhEC/97DFOgi2+xW0nRYS5mDjh40YjC6y1/SHmRKbZFaNhvu5/ejyIKleiYc
         uRvr+KltRpVhXNDIBr38nW7/jQrwQGdq1iJ7H0ElhRidQRcyU0Yga90ProP77brq5h/e
         W/GZZifm3H93ByI6bUI4N3IN7589mPe8hvuNozNNGy0opYozwORCIWJzwcR9ngjp8RgZ
         Ynsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=68b02T2ZuUBA/HDW+OC1DvbC+PwA/q6ufZIF15rjr3c=;
        b=xcu9i8iD1XA7cSjeypLeLKSy5TX5kPF7bHt1aNTL852dFcou4juyaGiZQCEzNp3nJN
         kezSyXdgm60qdYvbaAG+UuSUshIkTK7whyndDaYZDrstp6vvW6cBZXuAU2NirjATZR2h
         6j7x5RiVw6AXm/10enVg2lDhGwHZqZwJduFjwdRxSB11NjVOotw9UwcBKWZiPCd9MgIY
         t7lB9m7PbIMXli/YWN4ZpKiqLlR/RqnYAj+yOJHFqX5Aiua9yDEHCaC8OhJjqZlO9Chr
         q8utZRLipjzzjzTRKo0EWQ1o8TuvrlqgscRb2dVYWZ+8rkpsiETEvYRkxc/yF9VmvLRE
         8S5g==
X-Gm-Message-State: ACgBeo3QMoYwWiUUGeGoik87HHN1cjK5xmxJHEfm+RuYLQACd0pVb0tK
        m0U1AhuO0Kd8ZWOqJdAI/TJGtJtgWk7Y4w==
X-Google-Smtp-Source: AA6agR5UH1nFLNIKH5SjotDE8u9+Y2D7xiGG1S+YrmfIZIyw1FIVeENVBxfZ5cnek6lJsAP0modkAA==
X-Received: by 2002:a5d:5644:0:b0:225:3ae9:e4c3 with SMTP id j4-20020a5d5644000000b002253ae9e4c3mr12665321wrw.148.1661987913080;
        Wed, 31 Aug 2022 16:18:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u18-20020a05600c19d200b003a5a5069107sm3317903wmq.24.2022.08.31.16.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 16:18:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 16/33] submodule--helper: add "const" to passed "struct update_data"
Date:   Thu,  1 Sep 2022 01:17:58 +0200
Message-Id: <patch-v4-16.33-b77364015cf-20220831T230519Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.3.1420.g76f8a3d556c
In-Reply-To: <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
References: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com> <cover-v4-00.33-00000000000-20220831T230519Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "const" to the "struct update_data" passed to
run_update_procedure(), which it in turn passes along (peeled) to
is_tip_reachable() and fetch_in_submodule()).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 829a57ce8a9..4e3bb54afa2 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2083,7 +2083,7 @@ static int git_update_clone_config(const char *var, const char *value,
 	return 0;
 }
 
-static int is_tip_reachable(const char *path, struct object_id *oid)
+static int is_tip_reachable(const char *path, const struct object_id *oid)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	struct strbuf rev = STRBUF_INIT;
@@ -2102,7 +2102,8 @@ static int is_tip_reachable(const char *path, struct object_id *oid)
 	return 1;
 }
 
-static int fetch_in_submodule(const char *module_path, int depth, int quiet, struct object_id *oid)
+static int fetch_in_submodule(const char *module_path, int depth, int quiet,
+			      const struct object_id *oid)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 
@@ -2126,7 +2127,7 @@ static int fetch_in_submodule(const char *module_path, int depth, int quiet, str
 	return run_command(&cp);
 }
 
-static int run_update_command(struct update_data *ud, int subforce)
+static int run_update_command(const struct update_data *ud, int subforce)
 {
 	struct child_process cp = CHILD_PROCESS_INIT;
 	char *oid = oid_to_hex(&ud->oid);
@@ -2223,7 +2224,7 @@ static int run_update_command(struct update_data *ud, int subforce)
 	return 0;
 }
 
-static int run_update_procedure(struct update_data *ud)
+static int run_update_procedure(const struct update_data *ud)
 {
 	int subforce = is_null_oid(&ud->suboid) || ud->force;
 
@@ -2334,7 +2335,8 @@ static const char *submodule_update_type_to_label(enum submodule_update_type typ
 	BUG("unreachable with type %d", type);
 }
 
-static void update_data_to_args(struct update_data *update_data, struct strvec *args)
+static void update_data_to_args(const struct update_data *update_data,
+				struct strvec *args)
 {
 	enum submodule_update_type update_type = update_data->update_default;
 
-- 
2.37.3.1420.g76f8a3d556c

