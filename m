Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D092CC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:15:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233365AbiGUTP1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:15:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233548AbiGUTOt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:14:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC1898E6C6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:26 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id bk26so3603174wrb.11
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSqePTZev0IASomKKnjjyMtKvYhqKAFObsgE+A1MjEY=;
        b=iB1hira8BijK8W7Lx8yr5tzy4weYB6EWk/e8if/r+fv1iJK74igdF0Tgy/JZfjNVjt
         ZknpAJCYoi1OotfJL4q+XnHcoIHj4LfLweecT5BoP7aDgLFipp9N5oPnSGimRzX0/J1D
         VGwuwTLjvrzOkgiMIUgCq2rSD6bo1BdhbSyW+HsUBqCgQJTvszonclVdx/dqgAsmf6io
         uzmDKfHOPjo3CPt/ibI2O9rMicHNlwoOzN4Wk4ZNBKL5YQ+iEE09tCF2CS2iyRB1wdm3
         GNjYueeEq4+FwdnQvC3gHCxnpOkMZUvMqfr/+YWArlvYRF1meOHyq1UhJs2EdnCMZztI
         KdVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSqePTZev0IASomKKnjjyMtKvYhqKAFObsgE+A1MjEY=;
        b=XuQArT6iT7FW+ClAZrGszsF4t1WcvUWsusDdZM1RJ/3xPTFokU0kpeKk7W5WkokBYj
         fY95egU2Jl05ANiksn8Uvs1EmUsVxHXI0l+NLkiEt4Q59w+fhXj+6JQhbmsQjTXg5hpm
         3REyQl3aGbY/FFnX92zXryDe4KvqqoV8LO7I5tb7ZJ7VGznK3Zed02xyWY3ujrHYYbi4
         hzQxkwGLs35he7kAgcFX0wgo8QJWUz71XPaDMCxaka4FwqmitIUAtylU/NIhEu9Q3MBV
         o/yAgb01vn5nZVgPbj+vBJawwW50QcM9gWiQhPN2Q+IndtZ2IOYu9HscY+1anB/cmEwb
         KwNw==
X-Gm-Message-State: AJIora/+UtqTiMYxGOKFJdQtyT6zW8DJla056Ck6bqjzSJonMDM4/uXo
        7hWlZQ8bzibT6zaMD72D3BPB/FWl4+uAiQ==
X-Google-Smtp-Source: AGRyM1vrZGtH/JQKXrgweck/Gd/eWvq6TVygoN5FADyYC8C8QRCWoRpmXBRG8+xVi/FPeo9h8Gqqng==
X-Received: by 2002:a5d:6489:0:b0:21d:a9a1:3511 with SMTP id o9-20020a5d6489000000b0021da9a13511mr34777177wri.626.1658430864882;
        Thu, 21 Jul 2022 12:14:24 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:14:23 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 25/26] submodule--helper: fix bad config API usage
Date:   Thu, 21 Jul 2022 21:13:21 +0200
Message-Id: <patch-v3-25.26-f650716cd7e-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
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
index 4e70a74357c..37c145b3ede 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3306,7 +3306,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val) && val) {
+	if (!git_config_get_string("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
-- 
2.37.1.1095.g0bd6f54ba8a

