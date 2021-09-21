Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AEDC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DFF861050
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbhIUWmU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232837AbhIUWmT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:19 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B210EC061762
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:49 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id w29so1081895wra.8
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DeZry/sDIkSL35JLY7U7NKi9KipS+IzvpAKUQGkWy1k=;
        b=C6lxixZqkH+GiOZyKwmnv1WWFmcCflcbhuaWjVupz1I4/sBcqZRo80XSrZ2N6ilT7W
         UghwyTmqcTpx1uS2OKALjDLMCbWBHP8A3s/OKsPRK1vEnLh1+OHF/OVomBZXmyhB8W27
         6OZAiJMQZPmSf3/a9TqoXjFaO+d+1UFQqnqgabdozZCos6XlSzBPd9DZYk4ozSYRY7ga
         dbocH2B7z1A91IYFIfmqIX9bJqJj1huAFR8Rz8XB4YOuo2ToAW6LuPZG2jPRy0JKCt/h
         bwZB+z9d1KHdgk5swQIPQuFHRT73RBP+DZCgMftpASv1ChAu5EdxQWnakhMgxAALOsSJ
         zsLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DeZry/sDIkSL35JLY7U7NKi9KipS+IzvpAKUQGkWy1k=;
        b=SXzLmAmEfbbJCrTGg/kZEI7UgQegDBeSnEKuJrQLnGOoWisMK3ruDgVVz8e3uaveyq
         hCoQkqsVH8ogu9BKy+K9TqLK2u/beVQ9U4C5HWms/OishMdDmTdhu1hrBbb3dRwpDkkw
         tJVlapPo5D1pq/Aeh3UGG5hw7U6pTD6yaRSPZHlYu8UZY+Bm6vNuBOM23TIzN+CFjaPu
         POd29SQKa2cDGa5K/5+gnvlQX9q2mXibLKC+rAGMF6AFK/5AWxRdiEJsWpx7qGu6VhP8
         4z1lBK6uMLR412LTzJYZCKkmVl4w8b0Owrl+0wgHdcFCW1U8fXG4FAhSZ2GCXC8gIdqT
         aRJQ==
X-Gm-Message-State: AOAM532JMgkI1j0SdX948Wt4pLf5fXVtvkB1Kt1Wx11Ks7mGdlj/OHqo
        IR0MgPTHAYuNlxfOYf6yLxhPmkARiJ6m4A==
X-Google-Smtp-Source: ABdhPJx6pWpPjVkTRSS+K7jvGI2lO6eImPTkdqxcRCIcfKq73IDfkDnlro9okOo8amhupHoo0wVCYA==
X-Received: by 2002:a7b:c217:: with SMTP id x23mr7205942wmi.192.1632264047908;
        Tue, 21 Sep 2021 15:40:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:47 -0700 (PDT)
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
Subject: [PATCH v3 4/9] help: correct logic error in combining --all and --config
Date:   Wed, 22 Sep 2021 00:40:34 +0200
Message-Id: <patch-v3-4.9-d5df231954a-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bug in the --config option that's been there ever since its
introduction in 3ac68a93fd2 (help: add --config to list all available
config, 2018-05-26). Die when --all and --config are combined,
combining them doesn't make sense.

The code for the --config option when combined with an earlier
refactoring done to support the --guide option in
65f98358c0c (builtin/help.c: add --guide option, 2013-04-02) would
cause us to take the "--all" branch early and ignore the --config
option.

Let's instead list these as incompatible, both in the synopsis and
help output, and enforce it in the code itself.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/git-help.txt |  1 +
 builtin/help.c             | 31 ++++++++++++++++++++++---------
 t/t0012-help.sh            |  3 ++-
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-help.txt b/Documentation/git-help.txt
index cb8e3d4da9e..96d5f598b4b 100644
--- a/Documentation/git-help.txt
+++ b/Documentation/git-help.txt
@@ -11,6 +11,7 @@ SYNOPSIS
 'git help' [-a|--all [--[no-]verbose]]
 	   [[-i|--info] [-m|--man] [-w|--web]] [COMMAND|GUIDE]
 'git help' [-g|--guides]
+'git help' [-c|--config]
 
 DESCRIPTION
 -----------
diff --git a/builtin/help.c b/builtin/help.c
index 51b18c291d8..d0c9605dbb5 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -62,6 +62,7 @@ static const char * const builtin_help_usage[] = {
 	N_("git help [-a|--all] [--[no-]verbose]]\n"
 	   "         [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
 	N_("git help [-g|--guides]"),
+	N_("git help [-c|--config]"),
 	NULL
 };
 
@@ -553,9 +554,21 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 			builtin_help_usage, 0);
 	parsed_help_format = help_format;
 
+	/* Incompatible options */
+	if (show_all && show_config)
+		usage_msg_opt(_("--config and --all cannot be combined"),
+			      builtin_help_usage, builtin_help_options);
+
+	if (show_config && show_guides)
+		usage_msg_opt(_("--config and --guides cannot be combined"),
+			      builtin_help_usage, builtin_help_options);
+
 	/* Options that take no further arguments */
+	if (argc && show_config)
+		usage_msg_opt(_("--config cannot be combined with command or guide names"),
+			      builtin_help_usage, builtin_help_options);
 	if (argc && show_guides)
-		usage_msg_opt(_("--guides cannot be combined with other options"),
+		usage_msg_opt(_("--guides cannot be combined with command or guide names"),
 			      builtin_help_usage, builtin_help_options);
 
 	if (show_all) {
@@ -570,6 +583,14 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		list_commands(colopts, &main_cmds, &other_cmds);
 	}
 
+	if (show_guides)
+		list_guides_help();
+
+	if (show_all || show_guides) {
+		printf("%s\n", _(git_more_info_string));
+		return 0;
+	}
+
 	if (show_config) {
 		int for_human = show_config == 1;
 
@@ -583,14 +604,6 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		return 0;
 	}
 
-	if (show_guides)
-		list_guides_help();
-
-	if (show_all || show_guides) {
-		printf("%s\n", _(git_more_info_string));
-		return 0;
-	}
-
 	if (!argv[0]) {
 		printf(_("usage: %s%s"), _(git_usage_string), "\n\n");
 		list_common_cmds_help();
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index 63c4adb99be..b4ed6229ed8 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -35,7 +35,8 @@ test_expect_success 'basic help commands' '
 '
 
 test_expect_success 'invalid usage' '
-	test_expect_code 129 git help -g add
+	test_expect_code 129 git help -g add &&
+	test_expect_code 129 git help -a -c
 '
 
 test_expect_success "works for commands and guides by default" '
-- 
2.33.0.1098.gf02a64c1a2d

