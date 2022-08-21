Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 757FAC32772
	for <git@archiver.kernel.org>; Sun, 21 Aug 2022 13:59:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230488AbiHUN7N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 21 Aug 2022 09:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230440AbiHUN6p (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Aug 2022 09:58:45 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D85517058
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:41 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id bs25so10300156wrb.2
        for <git@vger.kernel.org>; Sun, 21 Aug 2022 06:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=QcF0k+7hSaB899OyvlOfZqH+MgbAnK8B6coZoKwPuuc=;
        b=WqprT+uBiLP78O/yzjs+169RkofjBHGj7xZlLRs1qLw/eBqMaw33PobGPoawTWEf72
         4LyekNh3NpUciSvQdbQSBNzRlEJNfySNPxg0gx71IET4YJtzKYO945EtY0xZP2w9sciJ
         8fiDb8Btld8Um7IbNYuXKFN1oBMYZUsUXyVccauX0mqhmrMkFYqtyRcj9bXpYzYZ0JS1
         hB5TPOW64Qoy9fDCO6MPMUeKjNMKT7wRgv26TIAjqYdgXLUr6lcLUcGLZGXUvdstBCJX
         CwE1JTJXgOYZXd7Nj8YaPnXM2mJmDrNSyywcLVGv8ocVqEPxrMkVKHWVdpIvO+53T79y
         57mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=QcF0k+7hSaB899OyvlOfZqH+MgbAnK8B6coZoKwPuuc=;
        b=Anqg3X+ICXUDrIdvMOCgROnBqVg4PZbrD7izpryPZblf4G/vJsC+PiTtR2894uRm83
         ul3TDGVGipT3iuhnGul7rID/RQowyQnOiJm6AeGT8qAXABfSHxcAPLrgoJXtDTd5zvjx
         f6c0YOOEbCwDH8Wcf6xQ2QZ7zN84awDcY+fw9OH+CeT3rE1xuwQHta/ZjflQ0dT//DvZ
         DSku/cgfbmMiBkoBRw86AetoqqiK8BS4XzgNcZrPfHAeMKTda0HnkMGsjJVesmi/UfCW
         q/leI/PKrNPizzEfthuaYWQD9ZDhBKaaAvhQMiRabt4i6ZVKYF5yZ+5ZB8IDi+GUFzVX
         QuKw==
X-Gm-Message-State: ACgBeo1hOuBcneu6CIAZD/6zg3zOajKpiBa25JxAEOkYt+hl3N/GNb+t
        LrnSFCx2hjlJc1vZsoH4BV+l1UjztBxj0n4U
X-Google-Smtp-Source: AA6agR70j+idxjLhO09mx+7nkaGE2g9djxhKJGlBXJlYq6YY3c0cGrhvn3HCMrl8dZ2flKGX8DmXEA==
X-Received: by 2002:adf:f88c:0:b0:225:4c23:6788 with SMTP id u12-20020adff88c000000b002254c236788mr2792972wrp.140.1661090319079;
        Sun, 21 Aug 2022 06:58:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12-20020a05600c4fcc00b003a5b788993csm12624872wmq.42.2022.08.21.06.58.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Aug 2022 06:58:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 13/32] submodule--helper: move "sb" in clone_submodule() to its own scope
Date:   Sun, 21 Aug 2022 15:57:22 +0200
Message-Id: <patch-v3-13.32-f2f412f50c1-20220821T130231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.2.1279.g64dec4e13cf
In-Reply-To: <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v3-00.32-00000000000-20220821T130231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor the only remaining use of a "struct strbuf sb" in
clone_submodule() to live in its own scope. This makes the code
clearer by limiting its lifetime.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c7833bae81e..2f1f0e1bf34 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1560,16 +1560,24 @@ static void prepare_possible_alternates(const char *sm_name,
 	free(error_strategy);
 }
 
-static int clone_submodule(struct module_clone_data *clone_data)
+static char *clone_submodule_sm_gitdir(const char *name)
 {
-	char *p, *sm_gitdir;
-	char *sm_alternate = NULL, *error_strategy = NULL;
 	struct strbuf sb = STRBUF_INIT;
-	struct child_process cp = CHILD_PROCESS_INIT;
+	char *sm_gitdir;
 
-	submodule_name_to_gitdir(&sb, the_repository, clone_data->name);
+	submodule_name_to_gitdir(&sb, the_repository, name);
 	sm_gitdir = absolute_pathdup(sb.buf);
-	strbuf_reset(&sb);
+	strbuf_release(&sb);
+
+	return sm_gitdir;
+}
+
+static int clone_submodule(struct module_clone_data *clone_data)
+{
+	char *p;
+	char *sm_gitdir = clone_submodule_sm_gitdir(clone_data->name);
+	char *sm_alternate = NULL, *error_strategy = NULL;
+	struct child_process cp = CHILD_PROCESS_INIT;
 
 	if (!is_absolute_path(clone_data->path))
 		clone_data->path = xstrfmt("%s/%s", get_git_work_tree(),
@@ -1658,7 +1666,6 @@ static int clone_submodule(struct module_clone_data *clone_data)
 	free(sm_alternate);
 	free(error_strategy);
 
-	strbuf_release(&sb);
 	free(sm_gitdir);
 	free(p);
 	return 0;
-- 
2.37.2.1279.g64dec4e13cf

