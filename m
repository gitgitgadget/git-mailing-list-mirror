Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D5EC5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 11:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EF022255
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 11:55:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjXNZbKi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727690AbgKTLzb (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 06:55:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725797AbgKTLzb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 06:55:31 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13D75C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 03:55:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id o15so9764810wru.6
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 03:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bmKRxZcHmwVuPYJPOu7BgjDRvXCh7LLhAmBAM4IVt98=;
        b=TjXNZbKiezdCt3DVJ+XZqmoAaY+zx7zBez5NhUosE8FuB6peJeQ7ZRgp1yFoqADMYO
         VYXM2Fa22wbYRFevyPZ9vTBeVMddpgPqcaQpFABG2N/ObDKrXOJkW7kZ327AiCysrApu
         YkD5roKAm5XamIr1GK8QgwvqAdS7M39rLsh0PK3msFJCLx9V7DxRFAxia6ec1V9zfrnn
         UPhp9mGKTA3pC1/h7VdpyGYathZ0cpdU2sRUJuBe+1RqQgsw+MQ6lXp7G74BG7lXTXv7
         TwQiZyhq02y6OCOmj9bhxe2l9q1Tin46fewgDd7JWS0zGNbxlGl4vaMuzvl8WsFf5vxq
         PHqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bmKRxZcHmwVuPYJPOu7BgjDRvXCh7LLhAmBAM4IVt98=;
        b=NX6BXXLjizD+f532MZQ7U5YMkvAvmDTExKr/OReDiEkuUBwHV/0zejaKf60WG1Wd1+
         le84IU3K9TXB7i6yj9eZtoMSmU0b+9kFbsDn36Z4TLkHakKUWHpflPwjMBGqxMUtEZv2
         IYGqbei8F7tz/4YbPQgw0zXjU/slC4e5GOM2DLhM7kfhC+Y2EmNP8eLY3z2zJnNBiv6A
         waocUvjjrEvKJmfXPSOisEChSasbdjiOG/kEcgl8QmVBrputoMWReAhIvB5W4K0P9XNN
         8z/QpdlaFC9f95ZpFsr4CYf6wFlE3pzR0i4bXJZg17/A/ARZpsywycCw80Zb+pId0sSs
         6kbg==
X-Gm-Message-State: AOAM530DmTY9AGrBFhkdF5YErglEa6moAFWoERdfaONpWMi4VKSAl2E6
        5cNN0GX//+TALhW5gmeVoAmUBYK5iAcHKQ==
X-Google-Smtp-Source: ABdhPJzajJr64gwD4FSf64p605Bj/pf03iyLFuQcDloWUIpZU/MeITSD3j6xHskRWe3sa6b4+7CnfA==
X-Received: by 2002:adf:a54d:: with SMTP id j13mr16505590wrb.132.1605873329560;
        Fri, 20 Nov 2020 03:55:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t7sm4773275wrp.26.2020.11.20.03.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 03:55:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] gc: rename keep_base_pack variable for --keep-largest-pack
Date:   Fri, 20 Nov 2020 12:55:22 +0100
Message-Id: <20201120115522.23617-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20200806214929.22qgjg3o2noosjuo@ltop.local>
References: <20200806214929.22qgjg3o2noosjuo@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in an earlier change the keep_base_pack variable name is a
relic from an earlier on-list version of ae4e89e549 ("gc: add
--keep-largest-pack option", 2018-04-15) before it was renamed to
--keep-largest-pack.

Let's change the variable name to avoid that confusion, it's easier to
read the code if there's a 1=1 mapping between the variable name and
option name.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 5cd2a43f9f..07c15e4b64 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -533,7 +533,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	const char *name;
 	pid_t pid;
 	int daemonized = 0;
-	int keep_base_pack = -1;
+	int keep_largest_pack = -1;
 	timestamp_t dummy;
 
 	struct option builtin_gc_options[] = {
@@ -547,7 +547,7 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 		OPT_BOOL_F(0, "force", &force,
 			   N_("force running gc even if there may be another gc running"),
 			   PARSE_OPT_NOCOMPLETE),
-		OPT_BOOL(0, "keep-largest-pack", &keep_base_pack,
+		OPT_BOOL(0, "keep-largest-pack", &keep_largest_pack,
 			 N_("repack all other packs except the largest pack")),
 		OPT_END()
 	};
@@ -624,8 +624,8 @@ int cmd_gc(int argc, const char **argv, const char *prefix)
 	} else {
 		struct string_list keep_pack = STRING_LIST_INIT_NODUP;
 
-		if (keep_base_pack != -1) {
-			if (keep_base_pack)
+		if (keep_largest_pack != -1) {
+			if (keep_largest_pack)
 				find_base_packs(&keep_pack, 0);
 		} else if (big_pack_threshold) {
 			find_base_packs(&keep_pack, big_pack_threshold);
-- 
2.29.2.222.g5d2a92d10f8

