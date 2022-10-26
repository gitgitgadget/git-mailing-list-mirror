Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5E88C38A2D
	for <git@archiver.kernel.org>; Wed, 26 Oct 2022 15:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234635AbiJZPhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Oct 2022 11:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234610AbiJZPgp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Oct 2022 11:36:45 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F70130D5C
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:44 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id bk15so26992091wrb.13
        for <git@vger.kernel.org>; Wed, 26 Oct 2022 08:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9B5zI19cDlP59KQZBSGfNuJCK9G1ziDbj8x+wqZkgYw=;
        b=mHGUcAdxECQ79oektdh+8CEtKCXvnLJRmwdD9Lm5RSn51N+D++DuW7NdbKFO39JddX
         E7/B/Mm21g6tWiaNmS0O2muhoDvyXFf+g1TdckpUswoq9/IANp0RPDPr3cm/G0Tp+w4Z
         DRWDQKvjSXBHUxeMnMgJaG70IEJq0K8I93mUz5eHGqEHnGNz9UcNV/yAYzaeWp2lU+QN
         MMqFFGdoDa/sC1iD7mZI9nf8gJqZYZOdrGHxY2sma1ejlmFLYAPlF7XZKZ+l4P0OIabk
         EQfMJn7DdmpDO9HBFcY1sU3ah69qyKkl5HyRlQW8rxdhVNHBsZIvP5/GPmRQ41k0QKm6
         YFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9B5zI19cDlP59KQZBSGfNuJCK9G1ziDbj8x+wqZkgYw=;
        b=5miymsoS4wQ/O4cLA3dO5rxqR/m46lDNFpPmQyMqAbpS5F7YZQm2m6zPRgZ5a4sFX4
         EBS0y2i+5bX005FnzB+l+prprxfOr4OdlXDU6ldrq7BQVTx2W91IspfrIIsAwpQt6MPL
         wk2w7mikyrtiP2nfXHEQTIuedjAUM9YZ5ysowaT1HFGITdI+ganPQ9K8YWo3Eo5QqWWU
         tA/1i7HuOM75j/yl4JNue+kzL2uBRnK7HLkGUUbN1+wJqx+qkxj6UL/7obzW/7ZjHH1T
         yFWFRO7xHthlDVBR/e1VdTeCraigHis50gv9oeCfC+bFkuM8ptCm8cUD/aK6mEY0UgH2
         VgPw==
X-Gm-Message-State: ACrzQf11Fiw0lJFJIujVhC1eFY2lZpLl6b6iMbn7XJrr02WWRaK85x6B
        olSRg0a6KTTZd4C9srZBttK0P3Mje/XFwQ==
X-Google-Smtp-Source: AMsMyM5MfO5D7WW57/NvnJRm0Vwzy46p461OG/ViyJyPXZDLaUWqZIdIEIuGQCn8mOkoX3nLkk2qUw==
X-Received: by 2002:a05:6000:2ad:b0:231:48fb:3a64 with SMTP id l13-20020a05600002ad00b0023148fb3a64mr28517351wry.184.1666798602676;
        Wed, 26 Oct 2022 08:36:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r1-20020a0560001b8100b002366f300e57sm5581884wru.23.2022.10.26.08.36.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Oct 2022 08:36:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/10] builtin/gc.c: use "unsorted_string_list_has_string()" where appropriate
Date:   Wed, 26 Oct 2022 17:35:19 +0200
Message-Id: <patch-06.10-9c36f17481b-20221026T151328Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1251.g3eefdfb5e7a
In-Reply-To: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor a "do I have an element like this?" pattern added in [1] and
[2] to use unsorted_string_list_has_string() instead of a
for_each_string_list_item() loop.

A preceding commit added a "const" to the "struct string_list *"
argument of unsorted_string_list_has_string(), it'll thus play nicely
with git_config_get_const_value_multi() without needing a cast here.

1. 1ebe6b02970 (maintenance: add 'unregister --force', 2022-09-27)
2. 50a044f1e40 (gc: replace config subprocesses with API calls,
   2022-09-27)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/gc.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 04c48638ef4..f435eda2e73 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1467,7 +1467,6 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	const char *key = "maintenance.repo";
 	char *config_value;
 	char *maintpath = get_maintpath();
-	struct string_list_item *item;
 	const struct string_list *list;
 
 	argc = parse_options(argc, argv, prefix, options,
@@ -1485,14 +1484,8 @@ static int maintenance_register(int argc, const char **argv, const char *prefix)
 	else
 		git_config_set("maintenance.strategy", "incremental");
 
-	if (!git_config_get_knownkey_value_multi(key, &list)) {
-		for_each_string_list_item(item, list) {
-			if (!strcmp(maintpath, item->string)) {
-				found = 1;
-				break;
-			}
-		}
-	}
+	if (!git_config_get_knownkey_value_multi(key, &list))
+		found = unsorted_string_list_has_string(list, maintpath);
 
 	if (!found) {
 		int rc;
@@ -1532,7 +1525,6 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 	const char *key = "maintenance.repo";
 	char *maintpath = get_maintpath();
 	int found = 0;
-	struct string_list_item *item;
 	const struct string_list *list;
 
 	argc = parse_options(argc, argv, prefix, options,
@@ -1541,14 +1533,8 @@ static int maintenance_unregister(int argc, const char **argv, const char *prefi
 		usage_with_options(builtin_maintenance_unregister_usage,
 				   options);
 
-	if (!git_config_get_knownkey_value_multi(key, &list)) {
-		for_each_string_list_item(item, list) {
-			if (!strcmp(maintpath, item->string)) {
-				found = 1;
-				break;
-			}
-		}
-	}
+	if (!git_config_get_knownkey_value_multi(key, &list))
+		found = unsorted_string_list_has_string(list, maintpath);
 
 	if (found) {
 		int rc;
-- 
2.38.0.1251.g3eefdfb5e7a

