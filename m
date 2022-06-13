Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3556C43334
	for <git@archiver.kernel.org>; Mon, 13 Jun 2022 22:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241392AbiFMWji (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jun 2022 18:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240410AbiFMWjb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jun 2022 18:39:31 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BFEC13F20
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:18 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h19so5601060wrc.12
        for <git@vger.kernel.org>; Mon, 13 Jun 2022 15:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NVOYMfiNJH7gNF7GyDe5YOjFrVJoJwOyWniVwwJSdm8=;
        b=l4WMAtWLm76nOT95UThtv25ln4LJFmZlu56uaVIpFPoNX1OeZOYly5OsnyNZ5eYgJJ
         6VU19HsYj5kkPRfEyxELK20Fp0yl1jIG4EbBMMLtWzMoBdCLzUCvANk9f2w05v8HewH3
         NYeM6wVDLAmSCmPDldzjXhxLeNtfbwQTTOF8+kYO9Gvq0kTYiQyBxVwUZSfL8UpdFjZX
         l9Nx4d+gT7fqfn4gqf+1WhpXUU6YuYxwdR9hA3n7nGnDXoAAS8HpBMbuYDqXB+PEFnhs
         zgGRXAPbz0ldo6ev1x0XG+SyboJ7wgJ24TsGpq8ynxDxYtC6Z7Y5RfVkDRgBZeVmr30s
         mjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NVOYMfiNJH7gNF7GyDe5YOjFrVJoJwOyWniVwwJSdm8=;
        b=0MImGHvszQliCj3FG6w1h8gf4fRcT4KZkeSPj3PQ8JgwQU+kkQIWF8fI8Zy0VBZ/0O
         98kuXGHtjPUh1UUmzf9uXReLLpVjl4VhH500TNyhV2lwN7cq72X5lY2HboXRHn24Scd1
         b3b4tPScHtLBoqYqUOE49rSgKyH0waAirrnI3XhpDL1TowmYImz0PNttLCW5DWdRm+ZG
         XWdo4huaAH/okBuoqQZWmhVeKxHyHuFNLmfck+PB8kax5vz6EDtoGCLKOtjJel5I5ZMZ
         hi2ih4HDnUnO1bFJvlPad0duhC8fhvgb3qAcC3jc3n5OBIvAO37cgp7FKbt3ISNbp1Fr
         6rlQ==
X-Gm-Message-State: AJIora+tfE/rNvNJDYlu7fWDhNv7FKsTTF4T3mhLefi+m1llJJvYL6J4
        Huk5htmBr+YjmYo2uvIw4T/DYB8sdR8gSA==
X-Google-Smtp-Source: AGRyM1u5yVUlJP9aqBrjxbmX72U7Xteyfl6cjTRKfnH4hSegEiVdi4MmTHRruBkm97wYU+slHvy4jw==
X-Received: by 2002:a5d:5704:0:b0:218:3fe6:412c with SMTP id a4-20020a5d5704000000b002183fe6412cmr1755232wrv.445.1655159956456;
        Mon, 13 Jun 2022 15:39:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y3-20020adfd083000000b002103cfd2fbasm9670303wrh.65.2022.06.13.15.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 15:39:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 09/12] submodule--helper: understand --checkout, --merge and --rebase synonyms
Date:   Tue, 14 Jun 2022 00:39:00 +0200
Message-Id: <patch-v2-09.12-01c5eee67c7-20220613T220150Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.1.1239.gfba91521d90
In-Reply-To: <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
References: <kl6lzgig5qmc.fsf@chooglen-macbookpro.roam.corp.google.com> <cover-v2-00.12-00000000000-20220613T220150Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Understand --checkout, --merge and --rebase synonyms for
--update={checkout,merge,rebase}, as well as the short options that
'git submodule' itself understands.

This removes a difference between the CLI API of "git submodule" and
"git submodule--helper", making it easier to make the latter an alias
for the former. See 48308681b07 (git submodule update: have a
dedicated helper for cloning, 2016-02-29) for the initial addition of
--update.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 17 +++++++++++++++++
 git-submodule.sh            | 14 +++++++++-----
 2 files changed, 26 insertions(+), 5 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2f55779cb1..57f0237af23 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2582,6 +2582,7 @@ static int module_update(int argc, const char **argv, const char *prefix)
 	struct update_data opt = UPDATE_DATA_INIT;
 	struct list_objects_filter_options filter_options;
 	int ret;
+	enum submodule_update_type update_type = SM_UPDATE_UNSPECIFIED;
 
 	struct option module_update_options[] = {
 		OPT__FORCE(&opt.force, N_("force checkout updates"), 0),
@@ -2603,6 +2604,15 @@ static int module_update(int argc, const char **argv, const char *prefix)
 		OPT_STRING(0, "update", &opt.update_default,
 			   N_("string"),
 			   N_("rebase, merge, checkout or none")),
+		OPT_SET_INT(0, "checkout", &update_type,
+			N_("use the 'checkout' update strategy (default)"),
+			SM_UPDATE_CHECKOUT),
+		OPT_SET_INT('m', "merge", &update_type,
+			N_("use the 'merge' update strategy"),
+			SM_UPDATE_MERGE),
+		OPT_SET_INT('r', "rebase", &update_type,
+			N_("use the 'rebase' update strategy"),
+			SM_UPDATE_REBASE),
 		OPT_STRING_LIST(0, "reference", &opt.references, N_("repo"),
 			   N_("reference repository")),
 		OPT_BOOL(0, "dissociate", &opt.dissociate,
@@ -2652,6 +2662,13 @@ static int module_update(int argc, const char **argv, const char *prefix)
 
 	opt.filter_options = &filter_options;
 
+	if (update_type == SM_UPDATE_CHECKOUT)
+		opt.update_default = "checkout";
+	else if (update_type == SM_UPDATE_MERGE)
+		opt.update_default = "merge";
+	else if (update_type == SM_UPDATE_REBASE)
+		opt.update_default = "rebase";
+
 	if (opt.update_default)
 		if (parse_submodule_update_strategy(opt.update_default,
 						    &opt.update_strategy) < 0)
diff --git a/git-submodule.sh b/git-submodule.sh
index 1c1dc320922..7fc7119fb21 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -40,7 +40,9 @@ require_init=
 files=
 remote=
 nofetch=
-update=
+rebase=
+merge=
+checkout=
 custom_name=
 depth=
 progress=
@@ -260,7 +262,7 @@ cmd_update()
 			force=$1
 			;;
 		-r|--rebase)
-			update="rebase"
+			rebase=1
 			;;
 		--reference)
 			case "$2" in '') usage ;; esac
@@ -274,13 +276,13 @@ cmd_update()
 			dissociate=1
 			;;
 		-m|--merge)
-			update="merge"
+			merge=1
 			;;
 		--recursive)
 			recursive=1
 			;;
 		--checkout)
-			update="checkout"
+			checkout=1
 			;;
 		--recommend-shallow)
 			recommend_shallow="--recommend-shallow"
@@ -341,7 +343,9 @@ cmd_update()
 		${init:+--init} \
 		${nofetch:+--no-fetch} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
-		${update:+--update "$update"} \
+		${rebase:+--rebase} \
+		${merge:+--merge} \
+		${checkout:+--checkout} \
 		${reference:+"$reference"} \
 		${dissociate:+"--dissociate"} \
 		${depth:+"$depth"} \
-- 
2.36.1.1239.gfba91521d90

