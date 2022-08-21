Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35B7C00140
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 14:02:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231342AbiHUOCq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 10:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbiHUOBy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 10:01:54 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B813E237DE
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id bs25so10305206wrb.2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 07:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=6m7kB9R4Pqfu6/p1zbkfkqYl4dubJeIJuJaSXsL1iVs=;
        b=e7ywES4/aH4SwRTCHjn9WWR6BB//+fwltEPuU9LfM4ch4+EzdjLTlvsOjeJS4VUK6E
         cxoiRPG7cnjxYn2zIDlbb1bNL7CreNy+G0GOe5KFb6KwEcAmDZD/KclhAN/quaNCOTAQ
         9YhQTyt3gMRglm959NeMY7mCDiS1uIvxn72HUrib4otX7hdgKTK769idCiGqXip+g4yA
         dKU5gcPXFePEGU408bTqyW3IKCg1cx0blSWSg4pHPr7EZcytjsopFPzzU1d5+E82FC4R
         wL7I0MGQ3YQSwuzoYoA3iVKBbcgN/ZZkgSHZHn71IOad0tglaOFfQzlx9UgP3MmGZ1jT
         yL+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=6m7kB9R4Pqfu6/p1zbkfkqYl4dubJeIJuJaSXsL1iVs=;
        b=Xe32J5fZaA3kADY2ONk5xi6tRztT9aV8UrYcVHbabaMrT6GPcb4WxsFN5RoFyPHrAY
         QNGzpjdMlFGGtn5y69rLj2GpXOWytKFkGa+qsOz8GTjLFmyeNkAZ2UjLNCWInekH3Pf5
         qtrjx63ykSCxh+i9geSl86lOMCPVvoUw1c/JKR4SSmQOF+/eC3XbGbrYSkMtzHfMyTJS
         5OOYXG3sbszdUg93hRHY1SbSl3yXlC7s5Qr1SJiNVrdt7FUvE6ehfn8srDupMCQg7vfk
         i2L3rsCu2eMexW1BrHCdtAyHhuYBqJxy4XzEko3ZLBmuzKlIW9RcWGQV1fq6NwiI4Irf
         MFfw==
X-Gm-Message-State: ACgBeo2tCKndUW8fAB6q2bCs+/Y9LpCtLGLlorRWdbI2GXGO+DfJmiNK
        Bn2hHhW/6OQjgittE3a6HX2fDP5EPrXSm+dX
X-Google-Smtp-Source: AA6agR7CCexBHtzc8woZoj8fBshILR8Rv1KsPNrv2v58Rm7hn/oiTBn/56dmzOcKWRFKP7MIByF1jg==
X-Received: by 2002:a05:6000:1549:b0:220:71a4:58b6 with SMTP id 9-20020a056000154900b0022071a458b6mr8643539wry.67.1661090477006;
        Sun, 21 Aug 2022 07:01:17 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q4-20020a1c4304000000b003a5c7a942edsm14449642wma.28.2022.08.21.07.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 07:01:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 13/17] submodule--helper: fix a leak in module_add()
Date:   Sun, 21 Aug 2022 15:59:37 +0200
Message-Id: <patch-v6-13.17-56590508180-20220821T130415Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
References: <cover-v5-00.17-00000000000-20220802T155002Z-avarab@gmail.com> <cover-v6-00.17-00000000000-20220821T130415Z-avarab@gmail.com>
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
index d952b9c8616..8d55090ee2e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3315,8 +3315,12 @@ static int module_add(int argc, const char **argv, const char *prefix)
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
2.37.2.1279.g64dec4e13cf

