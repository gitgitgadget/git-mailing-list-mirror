Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A13CC4332F
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DB876108B
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhIJLba (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:31:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhIJLb3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:31:29 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07231C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:18 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so1388187wra.8
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GFHyYbZ4py9YZZE41Kne8WFro2/2GS4PQhfF3G8sCYY=;
        b=HohC0wWwM6J1APEYsjAjx1pa1oGCKGZ4gkf0XaAZv6vN1agZcflgtFOcwKtdK0smYU
         nhRnthCxS2/h2475MANpJOBIrMbgmnuUHG9ELp3OWPFffVEt20JViV1GSBjY7a/Ktvs3
         flY/KsO41LVoBjaiman0qY0+EZ1+/IO3nU5gBK6kd2tAOHuuWorXIu1Ha+74xMbwplsM
         BRDFQ2c+q+rWiZQ1JZygnrPZcsr6NKgpy8PR/Pxg6od3NucZk/hr4EC6YjApylb5gUBm
         i7UlHVw6LbADuYsY8rLnXQwVyUCBKFt0gh09fpMhecF3csUPWCf+KgTULBgTVhCliBH5
         xjlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GFHyYbZ4py9YZZE41Kne8WFro2/2GS4PQhfF3G8sCYY=;
        b=lVhnZjTzd34ULBsNkDfxPpse5FmU2L8HBLZDlU9g+WQE425fnAn4QncnqWmuB6cOI4
         SLVISXojaza4FsvgQV47uDFgqDd0N8AUvlpCLG6EnW0gOwj1auN3pifwWjUb2E80e7ey
         odCPw/d1NxsDr26DGTZNqtQl9k/S6MmbQ9tn6FsSOugtgNztydqTqNkEoMIpmrAfO5BL
         g6IiW2jUtGbtNFOxKkF+gfiocg1kdbUPyiGv7s6zmBq+2XNWN/2pydOQKpkOTZxXDVzH
         CrBphHrdTcrS7Q3xWjtr7u0HKKfIWVg8J3ynhXkPJkODoMdJ2Bjhno01WP5Q6o2WQts8
         xSTA==
X-Gm-Message-State: AOAM530ZJVSzny46I/hifnBR5cZQ1e9GxKOXifSXEPsAyN33ddv2v/vt
        zQH9ZN116UBkHx+pgZxeoWO8/TVU+kzcEQ==
X-Google-Smtp-Source: ABdhPJyObKoEfDvMueCwFTtOn0PTXPnx5Tj0g90q1DK4Mb5o4a/DcKqaOlbFPMr6KUQR2X61ZjLiSQ==
X-Received: by 2002:a5d:58c9:: with SMTP id o9mr8610666wrf.279.1631273416316;
        Fri, 10 Sep 2021 04:30:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4103278wmp.1.2021.09.10.04.30.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:30:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] help: correct usage & behavior of "git help --guides"
Date:   Fri, 10 Sep 2021 13:28:43 +0200
Message-Id: <patch-v2-2.5-039639a0dd3-20210910T112545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 65f98358c0c (builtin/help.c: add --guide option,
2013-04-02) and a133737b809 (doc: include --guide option description
for "git help", 2013-04-02) which introduced the --guide option it
cannot be combined with e.g. <command>.

Change both the usage string to reflect that, and test and assert for
this behavior in the command itself. Now that we assert this in code
we don't need to exhaustively describe the previous confusing behavior
in the documentation either, instead of silently ignoring the provided
argument we'll now error out.

The comment being removed was added in 15f7d494380 (builtin/help.c:
split "-a" processing into two, 2013-04-02). The "Ignore any remaining
args" part of it is now no longer applicable as explained above, let's
just remove it entirely, it's rather obvious that if we're returning
we're done.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt |  6 +++---
 builtin/help.c             | 11 +++++++----
 t/t0012-help.sh            |  4 ++++
 3 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index 568a0b606f3..cb8e3d4da9e 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -8,8 +8,9 @@ git-help - Display help information about Git
 SYNOPSIS
 --------
 [verse]
-'git help' [-a|--all [--[no-]verbose]] [-g|--guides]
+'git help' [-a|--all [--[no-]verbose]]
 	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
+'git help' [-g|--guides]
 
 DESCRIPTION
 -----------
@@ -58,8 +59,7 @@ OPTIONS
 
 -g::
 --guides::
-	Prints a list of the Git concept guides on the standard output. This
-	option overrides any given command or guide name.
+	Prints a list of the Git concept guides on the standard output.
 
 -i::
 --info::
diff --git a/builtin/help.c b/builtin/help.c
index 44ea2798cda..51b18c291d8 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -59,8 +59,9 @@ static struct option builtin_help_options[] = {
 };
 
 static const char * const builtin_help_usage[] = {
-	N_("git help [-a|--all] [-g|--guides] [--[no-]verbose]]\n"
+	N_("git help [-a|--all] [--[no-]verbose]]\n"
 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
+	N_("git help [-g|--guides]"),
 	NULL
 };
 
@@ -552,6 +553,11 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
+	/* Options that take no further arguments */
+	if (argc && show_guides)
+		usage_msg_opt(_("--guides cannot be combined with other options"),
+			      builtin_help_usage, builtin_help_options);
+
 	if (show_all) {
 		git_config(git_help_config, NULL);
 		if (verbose) {
@@ -582,9 +588,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	if (show_all || show_guides) {
 		printf("%s\n", _(git_more_info_string));
-		/*
-		* We're done. Ignore any remaining args
-		*/
 		return 0;
 	}
 
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 5679e29c624..c3aa016fd30 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -34,6 +34,10 @@ test_expect_success 'basic help commands' '
 	git help -a >/dev/null
 '
 
+test_expect_success 'invalid usage' '
+	test_expect_code 129 git help -g git-add
+'
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-- 
2.33.0.873.g125ff7b9940

