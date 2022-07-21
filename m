Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 781E3C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 19:13:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233489AbiGUTNu (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 15:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233462AbiGUTNo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 15:13:44 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF08AECE
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:43 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id z13so3589163wro.13
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 12:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mnddJpSdd54BXlv0z6me5PLcjFXPrLFeaf9eDVC6A/E=;
        b=c1kiG4Hg/sApfohKPaB7ZEanzaz6qSEHI1nZnR4+4sLLpYUo7lcQPFaQORe7UZHHRo
         a95qFs75yCZ7Sba4r7HPpE5y/5o1MnNnHrq9bhLvbaKpqai9xrC4LwjaKn+tN394O+1U
         6JTly7reDJH6q0GlSFP65X+UzsS33Bvl5dUGPxtuGd4NdabSvuns6v03VZE1zxdSdP0I
         syJf5mAxzLSrVVSqGyjh7PI628DNBwjBzn6njAJ90QEK/tgBvznbo52asJj60thwVvea
         TjRHbCSgB2Ff19E/2NC4r4BeuVer8wY8PaoAkZ9LShoCxZg1HJovAW9hkB9W0iN3meFX
         qDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mnddJpSdd54BXlv0z6me5PLcjFXPrLFeaf9eDVC6A/E=;
        b=fF5JRn1JgbcmWa9t9OKonxsMocU35mfujfNMtNyM7n173yyji3uIKopKSfMqM7l/b2
         piSOHFSE/IeO9vnZQe/w7NEGQl836rcpszb5LurohAgO2q+6yenqfPnBwAouKzKyzl+L
         ZYqyJZ0KGReAZqGDvzKGiX8TazDtU6cB3DADc7fm5lEQ0Fzl2axmS19CZ4yegc5IbgKd
         aR1WNq16uu6ACWwGltbkDpBkpvU72pxrRQvYzxFF3B0594gT60sJow22N1W267HzkzI1
         KJuxusBZXbkNC8OXJC2/jylKQGewVLBMF9rhSBWG1ScsaJA8otWosa3neG5WOePC8Jq3
         PXZw==
X-Gm-Message-State: AJIora+U6yx8vG5AXGUusYMjpgecpBZWPL+1Nh+5EglZjt+Iyh5Y2lWw
        CAjE9LYGmqq1k88Za6Vz+0nJt8OPYKRRlg==
X-Google-Smtp-Source: AGRyM1uDygTcVLYb/NgZouSkfkG30CXimqHdtZ7+RsvGdDt4UnssTLAz0E3/weC9JaDUhQCgfmYLTA==
X-Received: by 2002:a05:6000:1888:b0:21d:beeb:785c with SMTP id a8-20020a056000188800b0021dbeeb785cmr34177606wri.34.1658430821577;
        Thu, 21 Jul 2022 12:13:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h13-20020a05600016cd00b0021e4e9f6450sm2630637wrf.84.2022.07.21.12.13.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Jul 2022 12:13:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/26] submodule--helper: fix trivial get_default_remote_submodule() leak
Date:   Thu, 21 Jul 2022 21:13:01 +0200
Message-Id: <patch-v3-05.26-75775bf4f6c-20220721T191249Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g0bd6f54ba8a
In-Reply-To: <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
References: <cover-v2-00.24-00000000000-20220719T204458Z-avarab@gmail.com> <cover-v3-00.26-00000000000-20220721T191249Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak in code added in 1012a5cbc3f (submodule--helper
run-update-procedure: learn --remote, 2022-03-04), we need to free()
the xstrdup()'d string. This gets e.g. t/t7419-submodule-set-branch.sh
closer to passing under SANITIZE=leak.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1ddce8e19c1..73ac1fcbb9c 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2486,6 +2486,8 @@ static int update_submodule(struct update_data *update_data)
 		const char *branch = remote_submodule_branch(update_data->sm_path);
 		char *remote_ref = xstrfmt("refs/remotes/%s/%s", remote_name, branch);
 
+		free(remote_name);
+
 		if (!update_data->nofetch) {
 			if (fetch_in_submodule(update_data->sm_path, update_data->depth,
 					      0, NULL))
-- 
2.37.1.1095.g0bd6f54ba8a

