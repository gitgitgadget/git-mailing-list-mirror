Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68008C433FE
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 16:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243625AbiA0QXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 11:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243621AbiA0QXH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 11:23:07 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7839C061747
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:06 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id bg19-20020a05600c3c9300b0034565e837b6so3554274wmb.1
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 08:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AG8GVRJ1nDvO3QcBYxKRUw5w3+EFCHJFeGRmBSap8OM=;
        b=EjW/WYOAd0T1KoXzI0AnS8QrBb/dgdirZhIFhqnzyb9EPNnxd4HXeKY7cmNC+2Cseo
         EmWmFLlbcxTGoopwBeu4G31nAiJMbEjiEe69aGnfYL/VDCedCAKGUaSwbj5KSs6kng8x
         cLm5y+f9lYJoQVxKzrRYN73cL2Zu0S4CpRmFkQlwf9sx88usH/Gtg8qN7xlNQ4BAK5lY
         qCPSZFeB9QD8oJMm0+QsjGm8VAs1Edk40Y8nrTc5DjbPGnN74R+gKUS2yiUihlste80x
         +5l/zjZFU/D7SizK4PTI8+HS09huvPRnHrS18CzSRUVt1v1+T3q/L2PJjbX1wH8gKfgE
         OUQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AG8GVRJ1nDvO3QcBYxKRUw5w3+EFCHJFeGRmBSap8OM=;
        b=qFmoGcvNrn1YkN0dGZbBG8+sCHoQFdr3w5BMFw4LPJzPN1P/0yxf2CyATRQ71qTiCB
         2fKe6GHRXLgFa3jDmKl7wE9vuOxnUnMK6gQOjCVLf0phVbCjI0EJZXgl0zT2DgB92W6C
         mZz00lj76SeTYQ9cvNMxdtqQUYKWCLxl9iF3+35C53JExOZ2JUYX64C1TibNzE4YgGLf
         RDde920LgOJkv3zSBuxalM2YCsLgIyMaZgSTYzfQGASdwkmNM4hXmLAH/qlWcha6sNm9
         xG708rHbzKV6cXgRJ0oQoHq8X3lKQZ0u9kt5vXTPrXmEGKJRmyORc1gsJdTux0xp//fo
         WW2w==
X-Gm-Message-State: AOAM532wGyv710u4bceaTvY+VvcNXHizVEIoyyRTXWDJOxXTvAZQKinR
        bWI98WVtv/IGbi9J+g3ViV1HfbkpzLN2Yg==
X-Google-Smtp-Source: ABdhPJw/jE9dt8DRrlFTfdJB6D6PTnzO5dnXtSRzKRtgVXWWFUVTlNhQyywRbbJtLNG74iwbRMRqEw==
X-Received: by 2002:a05:600c:1ca0:: with SMTP id k32mr2231719wms.62.1643300584910;
        Thu, 27 Jan 2022 08:23:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13sm3257186wry.77.2022.01.27.08.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 08:23:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        Glen Choo <chooglen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 3/7] submodule--helper: allow setting superprefix for init_submodule()
Date:   Thu, 27 Jan 2022 17:22:52 +0100
Message-Id: <patch-v4-3.7-f31fd72fba2-20220127T143552Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
References: <20211013051805.45662-1-raykar.ath@gmail.com> <cover-v4-0.7-00000000000-20220127T143552Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We allow callers of the `init_submodule()` function to optionally
override the superprefix from the environment.

We need to enable this option because in our conversion of the update
command that will follow, the '--init' option will be handled through
this API. We will need to change the superprefix at that time to ensure
the display paths show correctly in the output messages.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index d38a64c7b7d..f8e18820ace 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -608,18 +608,22 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 
 struct init_cb {
 	const char *prefix;
+	const char *superprefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
 
 static void init_submodule(const char *path, const char *prefix,
-			   unsigned int flags)
+			   const char *superprefix, unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb = STRBUF_INIT;
 	char *upd = NULL, *url = NULL, *displaypath;
 
-	displaypath = get_submodule_displaypath(path, prefix);
+	/* try superprefix from the environment, if it is not passed explicitly */
+	if (!superprefix)
+		superprefix = get_super_prefix();
+	displaypath = do_get_submodule_displaypath(path, prefix, superprefix);
 
 	sub = submodule_from_path(the_repository, null_oid(), path);
 
@@ -693,7 +697,7 @@ static void init_submodule(const char *path, const char *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *cb_data)
 {
 	struct init_cb *info = cb_data;
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->superprefix, info->flags);
 }
 
 static int module_init(int argc, const char **argv, const char *prefix)
-- 
2.35.0.894.g563b84683b9

