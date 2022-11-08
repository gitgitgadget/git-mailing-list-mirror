Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38058C43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 14:11:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiKHOLV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 09:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbiKHOLM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 09:11:12 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 708A677229
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 06:10:57 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id f27so38949353eje.1
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 06:10:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n7yrZ8mpwN/oW/Vj+EmpECK4o4IrGSRt7bSYo1UvgT8=;
        b=phC9koWenVI6nyUrUocXyZ0yq1mYYeV+w5zkkIrqEYSbIlcw5psHQcTG7gOIPzyGP5
         takL1Ph2dNoTKmMufHY5DeCW5DIFZeaIs8hF3M4AeHffEKOYigDeArIH6Z3kwyAor2Bp
         GavBme6ESp8NHpmfRNJNWHJeMB1Kk1RmGBEyMUzzwUfDtasNNxGSrB8gwAq0RC1c9NHL
         HaafqalxTF0UfPfbL1d5tT1KhmEAhjmajEYmwRsLqnB/j5IDcgzqYCmrfBMWpom0z0Cq
         hEKgfV1D7fqE2UNFuxlyZOQPuT9RY48IDCG+sTXnpdJKD//IVWvtvNjrYbmgalmf7mcU
         6xUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n7yrZ8mpwN/oW/Vj+EmpECK4o4IrGSRt7bSYo1UvgT8=;
        b=CZTEEpI3Pl44jDlPmruAtGU+Af8nOT4ks2xqQ9jqUcsAnZzp3TauKdBk2FiToeaWdV
         cJxHnfZhITr4tFtGzxEK0QJvbfssr8enjZVhdsnOYi+p9AO6QillVnq+VnZFfW6eY3Y2
         kHI0C1Ac1ZAs072/58/9ONPQJh3uitEYPDC8ab6uppvIG+dDC+hMlx0kDgMmif66SBaP
         ushRmtnh2JvqESEInduBMcjn+uJUE6hB3js1skylitWlylnGwxvCMGb8BbuhMrh3ogjS
         BtSey0txE/WgnTmXsLK8+zRhbtn1100ngoT+y3B6YwRgNjKXew3z2y07TO9yt+tknckS
         VR2Q==
X-Gm-Message-State: ACrzQf37Da/JV2eGc5/G5b7GAEYsDJj+w/LGw/moOQyN9V4Yk/qkMBog
        HqpJBEK48LaQEAHBJs8cohlLKaBE03/N3g==
X-Google-Smtp-Source: AMsMyM7rhHpHk7qxcpeRmmGhqlSWkr6LX4/88kR2ZG4mU5ragylS73PM+QSgj5ZxtQt42+m6QV+VtA==
X-Received: by 2002:a17:907:25c9:b0:77b:a343:bd62 with SMTP id ae9-20020a17090725c900b0077ba343bd62mr55549753ejc.660.1667916655685;
        Tue, 08 Nov 2022 06:10:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a16-20020a170906369000b0078d9c2c8250sm4683666ejc.84.2022.11.08.06.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 06:10:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 7/9] submodule--helper: remove --prefix from "absorbgitdirs"
Date:   Tue,  8 Nov 2022 15:10:38 +0100
Message-Id: <patch-v2-7.9-d1f4ac20a4f-20221108T140501Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1464.gea6794aacbc
In-Reply-To: <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's pass the "-C <prefix>" option instead to "absorbgitdirs" from
its only caller.

When it was added in f6f85861400 (submodule: add absorb-git-dir
function, 2016-12-12) there were other "submodule--helper" subcommands
that were invoked with "-C <prefix>", so we could have done this all
along.

Suggested-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 3 ---
 git-submodule.sh            | 2 +-
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 33f099dbc86..fefedcf8097 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2831,9 +2831,6 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	struct pathspec pathspec = { 0 };
 	struct module_list list = MODULE_LIST_INIT;
 	struct option embed_gitdir_options[] = {
-		OPT_STRING(0, "prefix", &prefix,
-			   N_("path"),
-			   N_("path into the working tree")),
 		OPT_END()
 	};
 	const char *const git_submodule_helper_usage[] = {
diff --git a/git-submodule.sh b/git-submodule.sh
index 5e5d21c010f..d359f171379 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -557,7 +557,7 @@ cmd_sync()
 
 cmd_absorbgitdirs()
 {
-	git submodule--helper absorbgitdirs --prefix "$wt_prefix" "$@"
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper absorbgitdirs "$@"
 }
 
 # This loop parses the command line arguments to find the
-- 
2.38.0.1464.gea6794aacbc

