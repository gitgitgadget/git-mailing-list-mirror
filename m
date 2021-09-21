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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E15C4332F
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6552B6109E
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232338AbhIUWmQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhIUWmP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:15 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2E3DC061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d6so1034811wrc.11
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Spl6bv4gDZERDD6jQZXTrRHh05/jBVi6l0NZTv70ytQ=;
        b=UJaO+ba8KSa085VM3vkU5p/R+y45F510VgGgdfVHSbVJ4e2Vfg3kcnPlHXZ8no2637
         1wacn6jB4Ty8HwlgudzOwec+5/AnOOPYIyzehHdl5oQ82s2SQlZ2yjofQ7t6EHWEPgIY
         Ru0F3LwVGQByEnd8dRSRKAWEwnPmSNxwfG7WdHc+lWpBJCe1vfNvnJMfNBPAglxjPcre
         qrs0mLq0CJL35Uukfrcp3DW7sUcpuXD7GKRfoqPybTX8PXKcVeS5CmmFcF2mQ+hWIfe4
         NO9R2WYUJBGN9CB8sSk5o9i6fASSGSBE7VR0kaz40ZLavESPOsQGzKnUKy8q1yMSoEWn
         JRmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Spl6bv4gDZERDD6jQZXTrRHh05/jBVi6l0NZTv70ytQ=;
        b=HAe7+9EOpLx4ik6oIsgBZzVtk0uyVeg4ps66KsXCIIAIx38V0j7Os9m8TczP0Mc8Ll
         7lKYZoOY2cb+ieWIdn/0ab0QFE8piaLsvZ6BAS7lx9cFv/1VQdPhciv3t1+fS/15lOpf
         4ZEmk2NxQHWEAMi93iXHh1qjw7/Zd82FuqtZUUBEGe6znSe39ece5mB12Du4kBwiAqoY
         utZKO3auLLGVk3ZlORaVJRFQ0zCKHxa1kbgpYggEQuqp3lWteIEaIZY2f9JlcvrMxC9G
         Ry1WfvouBGxJOmp7nTqN08FHHVPKH/4fS3H4FtU2MDWD32S4IhupkPJkb9I46zYHwbcv
         uUsw==
X-Gm-Message-State: AOAM532N6Tp8qsi5alvEPMLQEN2NpyUPYQ0Qqz0sZoBrPDqcgRkffS47
        9NGQ4vHTXrTy06a4vRfGM6IhgtRybZeyHA==
X-Google-Smtp-Source: ABdhPJxpu3oOxxiaSbXdE7tN8XvhnRAuqsvbMUmwDBQT7CFohDE31oNYriLxy3wGU77U5fy6jSmYVQ==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr34828653wri.20.1632264044878;
        Tue, 21 Sep 2021 15:40:44 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:43 -0700 (PDT)
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
Subject: [PATCH v3 2/9] help: correct usage & behavior of "git help --guides"
Date:   Wed, 22 Sep 2021 00:40:32 +0200
Message-Id: <patch-v3-2.9-e24ab59bc94-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 65f98358c0c (builtin/help.c: add --guide option,
2013-04-02) and a133737b809 (doc: include --guide option description
for "git help", 2013-04-02) which introduced the --guide option, it
cannot be combined with e.g. <command>.

Change the command and the "SYNOPSIS" section to reflect that desired
behavior. Now that we assert this in code we don't need to
exhaustively describe the previous confusing behavior in the
documentation either, instead of silently ignoring the provided
argument we'll now error out.

The "We're done. Ignore any remaining args" comment added in
15f7d494380 (builtin/help.c: split "-a" processing into two,
2013-04-02) can now be removed, it's obvious that we're asserting the
behavior with the check of "argc".

The "--config" option is still missing from the synopsis, it will be
added in a subsequent commit where we'll fix bugs in its
implementation.

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
index 5679e29c624..0525ec3ee58 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -34,6 +34,10 @@ test_expect_success 'basic help commands' '
 	git help -a >/dev/null
 '
 
+test_expect_success 'invalid usage' '
+	test_expect_code 129 git help -g add
+'
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-- 
2.33.0.1098.gf02a64c1a2d

