Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2486C433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbiBUTju (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:50 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233120AbiBUTjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:43 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7723BCB
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:04 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id a23so35749941eju.3
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OyKGzFxM2QC5x87vlf/MmlmKiRHJSfuOPozlVExnS2E=;
        b=lPMzdibTsXvlA6LS6WxhzTOCVcMlC5U5+wqepPtTLZsv9GHECQF/B7lZSNMmgcOv6j
         2n2u8Dw1Ya6+seMkCLujQwvp0oaEQfpuQW+UKgwi3WGwRjwlAVmTQTH8aNkTARKRsuxK
         GOLSZl4zsg/8IqXojB6gHmaU0u0zSU1iWECEQBEHF0sW8NjM3MEpIZvDYkBO2uqIbAlY
         Xp212uRiJ9oZqJSb0t91LQP47i4eVx4XERNZQRFvHW8OZ00inXA9+omylBg/CfsJVF9v
         Phw0gs5r9oou/Z1gkGZ7UW2QNGODxlkq+piopI9ciBuHWi1+7hAu31TMX9SRCSzWEOfQ
         9hOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OyKGzFxM2QC5x87vlf/MmlmKiRHJSfuOPozlVExnS2E=;
        b=mxxmJwZlwscdl9u/g8RQD4BE22QrkFUugIM+H3lGTAirwiVLv01uS6xNgUzdjVIb4x
         fbA64zfUHb9rkJ5SZh3xFVjeFBSG7slYBaCUtg58XH2oP9CpJYX7fLs2haoKO7N10Qhr
         XvsekHoRs2qmb8IfFM1rjN/4W98XwlEFhkkTenHw4eDfzU1MwHHbBTpiYDzg7HCsLI31
         Zrhp8vmEkcKuNSwRjAhQBAMSj2tXFKXceOb0veBr8FaGhQrpjCpK84QpUKDB9MZaYTEM
         GH/eR4JtuN9vptpct+ArrCjPb8BkMHhE4xnqprQC8MOG5aUsTo2mBWOMPP9yrNlkcmTo
         dBhQ==
X-Gm-Message-State: AOAM530PDj8As9++GRLwMzw3nKRXgUomeOuSn7rd//HWhvqKOcS6fMz6
        mKMoND8OarAj2vmIUlzUSEWMHoHd177KCg==
X-Google-Smtp-Source: ABdhPJwJiIIe2vWdgsncdP66S+k1logERqOkFdN+uH6Z1NfpE/NJ1zbJOVdTpOnnKaN8Uv74VxOjbA==
X-Received: by 2002:a17:907:2bf7:b0:6cf:86bc:4e2e with SMTP id gv55-20020a1709072bf700b006cf86bc4e2emr17301294ejc.200.1645472343123;
        Mon, 21 Feb 2022 11:39:03 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.39.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:39:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/9] help: correct usage & behavior of "git help --all"
Date:   Mon, 21 Feb 2022 20:38:49 +0100
Message-Id: <patch-v2-6.9-868e8a6cf83-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Do the same for the "--all" option that I did for "--guides" in
9856ea6785c (help: correct usage & behavior of "git help --guides",
2021-09-22). I.e. we've documented it as ignoring non-option
arguments, let's have it error out instead.

As with other changes made in 62f035aee3f (Merge branch
'ab/help-config-vars', 2021-10-13) this is technically a change in
behavior, but in practice it's just a bug fix. We were ignoring this
before, but by erroring we can simplify our documentation and
synopsis, as well as avoid user confusion as they wonder what the
difference between e.g. "git help --all" and "git help --all status"
is (there wasn't any difference).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt | 5 ++---
 builtin/help.c             | 5 +++--
 t/t0012-help.sh            | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index cf1d53e9499..d07590c8ff7 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git help' [-a|--all] [--[no-]verbose]
-	   [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
+'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
 'git help' [-g|--guides]
 'git help' [-c|--config]
 
@@ -46,8 +46,7 @@ OPTIONS
 -------
 -a::
 --all::
-	Prints all the available commands on the standard output. This
-	option overrides any given command or guide name.
+	Prints all the available commands on the standard output.
 
 --verbose::
 	When used with `--all` print description for all recognized
diff --git a/builtin/help.c b/builtin/help.c
index 1c1581ef850..b682446bbf5 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -75,8 +75,8 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [-a|--all] [--[no-]verbose]]\n"
-	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
+	N_("git help [-a|--all] [--[no-]verbose]]"),
+	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
 	N_("git help [-c|--config]"),
 	NULL
@@ -594,6 +594,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	switch (cmd_mode) {
 	case HELP_ACTION_ALL:
+		opt_mode_usage(argc, "--all");
 		if (verbose) {
 			setup_pager();
 			list_all_cmds_help();
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 9ac3f5d3c4b..c87730aa920 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -35,6 +35,9 @@ test_expect_success 'basic help commands' '
 '
 
 test_expect_success 'invalid usage' '
+	test_expect_code 129 git help -a add &&
+	test_expect_code 129 git help --all add &&
+
 	test_expect_code 129 git help -g add &&
 	test_expect_code 129 git help -a -c &&
 
-- 
2.35.1.1132.ga1fe46f8690

