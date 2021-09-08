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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE3ECC433FE
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAA2C610A3
	for <git@archiver.kernel.org>; Wed,  8 Sep 2021 15:24:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352023AbhIHPZm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 11:25:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbhIHPZh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Sep 2021 11:25:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84154C061575
        for <git@vger.kernel.org>; Wed,  8 Sep 2021 08:24:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id d6so3848998wrc.11
        for <git@vger.kernel.org>; Wed, 08 Sep 2021 08:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Riwawg7bkbhRneeTM2zFhUajOuQs+hSXu12hgjAMIxA=;
        b=NacMASg1NGKWo0TQzxvudfjWTQ1fo/RuBmqIWqthbyXQPRqyqRR+Wv06b3yK83Z5ft
         GrsAH/UHVOBOTm/HiYJNcgDWzSPZWEK1dc80JcJJ7m3nd1RtspB4cXlyhREfIwG9qGOQ
         RpGy87bi/j3dC4VvpaLEVFD+JN9MaYpPu9FUiLwqy7HiF654x5eUxdXjG/Nw0s6Luwb8
         cqbaXqP9UBUFt//DE1LIbc+HXqxnWMFFcJ3RdEaSGyousBVtoXfK79DKtMYR+jxleYKR
         7Uu9tjH6qa0JvOV4QpNhijCM8hfzlvArFYnPSU+VLTMJo0pJX+dJJ6fK+nGPjGCSsbqO
         Gptw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Riwawg7bkbhRneeTM2zFhUajOuQs+hSXu12hgjAMIxA=;
        b=0Snq+NCiVrB9PhOkRL60PfVzKeeLOfilvq/o/KgNyPWsRtYn7s0DCjnPYi9lTBCWrb
         Q2GyZMyM1T9n74knsetQoaXvYBy2w2F3Q2du+DpiC4JdGI3NqOSyhb0Au7G055crd6nc
         YXbLym4k9Ica0jJuu4WmO6SZ2tikdienC4U2giCLsomUvauziNW5pYukF4UEW3D7l+SG
         48tPQJieHauPrIvWwrPw7/hWoiKh+Y9T5NBOOcN/Mzmrm3CvJSC+MyVqmkw8r3oOBXts
         tYg2JmwsflZ0QA4xsD1DbNEI85hVqBWTdTKj6sO915yu3QNFq5ko11tVRhYFOkn1tcC+
         It8A==
X-Gm-Message-State: AOAM531TqsBTOganrRs42q8nYXtUcARy3i11lddV+nrUfCDemChOjzpU
        hI9dfg1rmMrf65ZMHSzgZtMN4Cvc9ZLLAg==
X-Google-Smtp-Source: ABdhPJwMkQQtDj7uqKSzdC65ARbqCYT1O5txpncuQLm0l8K0qM/amqh5Sw5MbgXTFwbzmRj69Apw8A==
X-Received: by 2002:adf:b7c7:: with SMTP id t7mr4552762wre.259.1631114667853;
        Wed, 08 Sep 2021 08:24:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x21sm2365240wmi.15.2021.09.08.08.24.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Sep 2021 08:24:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/6] help: correct usage string for "git help --guides"
Date:   Wed,  8 Sep 2021 17:24:18 +0200
Message-Id: <patch-2.6-1ebd443e43c-20210908T151949Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.825.g2bf60429931
In-Reply-To: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
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
split "-a" processing into two, 2013-04-02) and is no longer
applicable as explained above.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt |  6 +++---
 builtin/help.c             | 14 +++++++++-----
 t/t0012-help.sh            |  5 +++++
 3 files changed, 17 insertions(+), 8 deletions(-)

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
index 44ea2798cda..0f9dc31c40f 100644
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
 
@@ -547,11 +548,17 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	int nongit;
 	enum help_format parsed_help_format;
 	const char *page;
+	int standalone = 0;
 
 	argc = parse_options(argc, argv, prefix, builtin_help_options,
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
+	/* Options that take no further arguments */
+	standalone = show_config || show_guides;
+	if (standalone && argc)
+		usage_with_options(builtin_help_usage, builtin_help_options);
+
 	if (show_all) {
 		git_config(git_help_config, NULL);
 		if (verbose) {
@@ -580,11 +587,8 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 	if (show_guides)
 		list_guides_help();
 
-	if (show_all || show_guides) {
+	if (show_all || standalone) {
 		printf("%s\n", _(git_more_info_string));
-		/*
-		* We're done. Ignore any remaining args
-		*/
 		return 0;
 	}
 
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 5679e29c624..6e01da614f0 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -34,6 +34,11 @@ test_expect_success 'basic help commands' '
 	git help -a >/dev/null
 '
 
+test_expect_success 'invalid usage' '
+	test_expect_code 129 git help -c git-add &&
+	test_expect_code 129 git help -g git-add
+'
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-- 
2.33.0.825.g2bf60429931

