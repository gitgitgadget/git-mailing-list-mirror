Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA50FC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 16:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232133AbiG1Qac (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jul 2022 12:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230463AbiG1QaW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jul 2022 12:30:22 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC316BE2F
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:21 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id l22so2891887wrz.7
        for <git@vger.kernel.org>; Thu, 28 Jul 2022 09:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=/Gq1NyfgLUzAiQv6ZnsJD1oZyAik6HkPAulV6EOUzHY=;
        b=ef5PHp1Rze2BlgxDE4HyInZbSwqqmPLvFpKN2FfHEzHjl0ASC48bUj9LwmiSjATHeT
         lQtqHQwqu5d5VQJ3iLdHj1DYbdt1W4AxChrsgJLa/d/vUE8RZQ/gh31px6m8xHf76/t2
         PrT7z2YxTd2fPbgohfIdE/IoU6hAK+iGM620jLng0XnRASupb3IoSwUq6qmjfMvnrg+G
         uh9u5yE+D4zPBiiGaAnWdcsCI2d6PPoNPYqNaRxZqDt85nR3r5NQyOeuz/XHgM2UuY1R
         y2LbsPNDro6MyqqWk7xNpu73xOjXH9/Tes0ghs6WoR4vVxNa+u0HE3sVKsXZ0J3Nozwi
         ftkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=/Gq1NyfgLUzAiQv6ZnsJD1oZyAik6HkPAulV6EOUzHY=;
        b=yxeTq/TZoP0AEp1WQsxlzqk3ZYZSvekivf00TpyZ+ojgTy3dMenW+8oko1ag+GIdzp
         imQvQg+z27Jj4NNtMpYayPh1QHEgUcRcMaK1IlbZy49Wfd633gxbytnY5sxicJTcjkud
         v9GkYqccgm45Z7NsifMrj0fC3g/70uq07mlz2rZ20b7O2P0FzrYjgelHfaaaEzHNiX8S
         Xat22XCj2phdjqHCN7LsZZupWEUcGwqOmYRC5/7sKI3AeiEHaRgnRm1UT7r/UWH+PLFN
         MoCYw2OCgnwPDs3qv9ic5xHxbG/TtNOw/gfg/Vw5nyVFU0wjQusvRP/LjE+aZ+DRYapN
         yq0A==
X-Gm-Message-State: AJIora+KKy2oIOlWu7eTlkZSOF7RGeLQyGcWGZh3IMblRKLT/i/9Wfms
        olfOicpgAmOxYAKkLqbsqBHU3Mdc2+wYHA==
X-Google-Smtp-Source: AGRyM1thwjuC5+m7wIvUrbJOeeZrlq9Egn8LWpnwu/LzQ+GW9Q+Oy+cRFotiI5LbR3gf1JLPXDpHJw==
X-Received: by 2002:a5d:620b:0:b0:21e:5b97:c826 with SMTP id y11-20020a5d620b000000b0021e5b97c826mr17101407wru.600.1659025820969;
        Thu, 28 Jul 2022 09:30:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c13-20020a5d528d000000b0021ef34124ebsm1492018wrv.11.2022.07.28.09.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 09:30:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 04/17] submodule--helper: "struct pathspec" memory leak in module_update()
Date:   Thu, 28 Jul 2022 18:29:58 +0200
Message-Id: <patch-v4-04.17-683d327752f-20220728T162442Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1197.g7ed548b7807
In-Reply-To: <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
References: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com> <cover-v4-00.17-00000000000-20220728T162442Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The module_update() function calls module_list_compute() twice, which
in turn will reset the "struct pathspec" passed to it. Let's instead
track two of them, and clear them both.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 6c53c83a2af..057cb6c0d42 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2537,6 +2537,7 @@ static int update_submodules(struct update_data *update_data)
 static int module_update(int argc, const char **argv, const char *prefix)
 {
 	struct pathspec pathspec = { 0 };
+	struct pathspec pathspec2 = { 0 };
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options = { 0 };
 	int ret;
@@ -2625,7 +2626,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		struct init_cb info = INIT_CB_INIT;
 
 		if (module_list_compute(argc, argv, opt.prefix,
-					&pathspec, &list) < 0) {
+					&pathspec2, &list) < 0) {
 			ret = 1;
 			goto cleanup;
 		}
@@ -2648,6 +2649,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 cleanup:
 	list_objects_filter_release(&filter_options);
 	clear_pathspec(&pathspec);
+	clear_pathspec(&pathspec2);
 	return ret;
 }
 
-- 
2.37.1.1197.g7ed548b7807

