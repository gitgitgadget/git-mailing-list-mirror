Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAF4EC433EF
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 20:48:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240333AbiGSUsQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 16:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240278AbiGSUsD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 16:48:03 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8710954CAD
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:50 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id n185so9657354wmn.4
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 13:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3OGBCxmj+QDEbGy0AZFt26LADUtsLrnUba8w2Isj5kE=;
        b=EM/4Ozo8lEORXxsV+QtH+fTrzsU1G8EkaCWqoSdzkfKCIsgSKzIrFpfTRLIsijwxBC
         jB/ukyVzJplaEo8EE5iTg4IxmrCEinqIni2ghTNAC0Pr9XmkvXQK357BDS68ewe9dLSK
         70xZZQLovLkJo83ecdBgHmc+RvqQJg12BvbIcJSUvd3hjdIfGgUwzVTChwisTqGE2XyY
         5D4fjw1HxB+B8waT4PSyPZ7vDhC+4MkvFtSop1mVIfCcjDuPAF4uTGqz4OOVqGhve6jz
         A/zz9IOHBvOARh3JubcCwjBwB71y5uVH7qsE+DO8NKIdgn/nfmbkbsZttf0mlN9KjO1S
         jlzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3OGBCxmj+QDEbGy0AZFt26LADUtsLrnUba8w2Isj5kE=;
        b=K4vlu5wdsWS9PgzfGrHRBAUU35bYMg6wic0uFudhiEUhlHYyBtuEy8MAhzaAn/bC19
         AMjZZUeHBaNiVC02BHXHh0WwIjDaHR4S82UJERhX3NyzCoubU463isee6oPyY5s2YUmF
         9ZDeEFSh3jyYQCTvJCRtMYjyZhrfPQbYw/yFSMTprwZ8frFocaVoqyRR5RT6TECkapWI
         BCwG6ccgf3u4P0BIFcQOpgz9gzFdt09ZB8zct1nEVMQVKdzSg4/0uYjNEeVmFfGKXsvb
         7hlkcWFVgU0pKIKrkLgbBB+HxIPh/L7Rey5d49PkiXciCqbsNnNwSJ8rnB9o5jgWq+in
         L+vg==
X-Gm-Message-State: AJIora8pkP+YXYD73gZJXzx74TJk1w2W/HB7T1/Tt5expLqdzsK6TdaD
        fU1/N8kCsPoDBJMxWrLUj55vAJLXqAK1Yg==
X-Google-Smtp-Source: AGRyM1toPdFF7WJUDnRW5O0kWmEFk8uvQ41nsYn6r+H1juuOVXHxxho5QHmozqgtKeSLE1zf0GBmTw==
X-Received: by 2002:a05:600c:35c7:b0:3a3:2612:f823 with SMTP id r7-20020a05600c35c700b003a32612f823mr874659wmq.33.1658263668391;
        Tue, 19 Jul 2022 13:47:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l18-20020a05600c1d1200b003a04d19dab3sm4711348wms.3.2022.07.19.13.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 13:47:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 23/24] submodule--helper: fix bad config API usage
Date:   Tue, 19 Jul 2022 22:47:14 +0200
Message-Id: <patch-v2-23.24-d77c6665ca9-20220719T204458Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1062.g385eac7fccf
In-Reply-To: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20220713T131601Z-avarab@gmail.com> <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix bad config API usage added in a452128a36c (submodule--helper:
introduce add-config subcommand, 2021-08-06). After
git_config_get_string() returns successfully we know the "char **dest"
will be non-NULL.

A coccinelle patch that transforms this turns up a couple of other
such issues, one in fetch-pack.c, and another in upload-pack.c:

	@@
	identifier F =~ "^(repo|git)_config_get_string(_tmp)?$";
	identifier V;
	@@
	  !F(..., &V)
	- && (V)

But let's focus narrowly on submodule--helper for now, we can fix
those some other time.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 37d414258cc..a944f6fa442 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3309,7 +3309,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val) && val) {
+	if (!git_config_get_string("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
-- 
2.37.1.1062.g385eac7fccf

