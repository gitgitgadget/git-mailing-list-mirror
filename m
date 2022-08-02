Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D157C19F28
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:48:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbiHBPsB (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236949AbiHBPrQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:47:16 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C37537185
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:46:46 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id l4so18420056wrm.13
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=n4MIAzCkogt282Uh8Cshx/PYZ/+axm3sZAQnxKzmwHU=;
        b=o2X37BkNm3Ho+eh9Kqh8PszPTvSc0SuRYyEplkjnuInTWpbUnPJPRTGmyVKfnk4LrL
         uxuVo2FBg35ZDSkO7YU9YyAt9htowhDVVQ976MOq0vSFdoLPAKCs6bS2IVO94zeY1iSg
         AqLh8hlpdwiebRk784GtRr9LJrPIA3gAgbnKk9uVdQ/LkvCFiLdzUBE+mLK3H/2J5S+k
         pE89aFN+2+CFEZyIy9V46ZpzbI+QUENMC44e0d8WJJ76Asu5Gr/GWC8zzp/tFeNIOnEz
         vCCyL94SwfWdjG+CEcF9NQ8yhqyv4wS2gNitKIGxO9303UGiRgKcAjGiuNBlyNXjcYeE
         X6Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=n4MIAzCkogt282Uh8Cshx/PYZ/+axm3sZAQnxKzmwHU=;
        b=4lvMER8iLp2LbV1MpxBH7irthrdokvckm67xyaAIVGKjSgwBue9sRggKJT6VACZSPu
         xx+loelK0mgUi2btvfA5xTdnU1R4Vnm21GVW2/V8zQGvVlbZp0cFC0QdsEIyfwyGsS+K
         BzEAGaYqef+9MfWPKCZh/dys8szBOSpHYdBQlb9CmI6k1QnDgmwQlZkiRLi9BE7PiVpn
         qQ+b61otYCPbFO/3Rs3ebiswb+a26H+tZwmsrTfrIqZ5FNMljYQZRQb/AemHF5HAkSEt
         WFPCzHMHoieK37d2OeeaamEAGOW4h29F9ZIzLrwDjKlThZajh5bqUfaMcWZhG1lz75u4
         Fv3Q==
X-Gm-Message-State: ACgBeo2Hyee13DsbVdXNab8KxpVbO8j2VE7ast0/zFxmhkU2IxDr9Oc4
        z3xorTImM6lv7PXzckrkDIN3eWQEhBGPTQ==
X-Google-Smtp-Source: AA6agR5fN5Cjtl8j6y11tgYXw36guiLuHyVSJStuubTP+plna/RvBN7D78PypfD788jQhbuRyX3SAg==
X-Received: by 2002:adf:fecd:0:b0:21f:d78:743f with SMTP id q13-20020adffecd000000b0021f0d78743fmr13668808wrs.704.1659455205008;
        Tue, 02 Aug 2022 08:46:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i18-20020a1c5412000000b003a4c6e67f01sm10599260wmb.6.2022.08.02.08.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:46:44 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Prathamesh Chavan <pc44800@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 28/28] submodule--helper: fix bad config API usage
Date:   Tue,  2 Aug 2022 17:46:12 +0200
Message-Id: <patch-v2-28.28-6160a1ab250-20220802T154036Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20220728T161116Z-avarab@gmail.com> <cover-v2-00.28-00000000000-20220802T154036Z-avarab@gmail.com>
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
index 4f7ece6fb05..5bc9cc41369 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -3098,7 +3098,7 @@ static void configure_added_submodule(struct add_data *add_data)
 	 * is_submodule_active(), since that function needs to find
 	 * out the value of "submodule.active" again anyway.
 	 */
-	if (!git_config_get_string("submodule.active", &val) && val) {
+	if (!git_config_get_string("submodule.active", &val)) {
 		/*
 		 * If the submodule being added isn't already covered by the
 		 * current configured pathspec, set the submodule's active flag
-- 
2.37.1.1233.ge8b09efaedc

