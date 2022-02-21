Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A887AC433EF
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233112AbiBUTjx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233076AbiBUTjp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:45 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C354923BCF
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:05 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m17so31459968edc.13
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pySz8DHlsvFVKFY/EbMC9WlscONi7Dh/pY8V9fNU9ok=;
        b=kd4hQeLr2tKA7LL9gy74HiApEg6xI9Yb4uyjA+y2T1jWvZ6vIdzn3AOcdU8o3tDeEY
         pZOGnzGaQRLWTCQtT3Bj4GccJ+qKjK7XMf9OfEs11DINpjP9N2x19yPNdz8vJBHBEljF
         e9NpTN+SzMLJNhitwsTu5Nh7+vNJDH4olzyor5haT0VucAaS2j5slTtNiI46TBW8unpp
         6fd9EUv4vHwvoWfwrimC3CjiRFSx8Eq57YdZpgpEFEza0k4TWku6lkE2Ew/Z1JDSMVaA
         dyJS0Q4BujcnS3OVhyELWw0kWxV8v5kBTQ37I1GiCBh7ksisy0ZSY69nM7wAsIpE6KtF
         s+0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pySz8DHlsvFVKFY/EbMC9WlscONi7Dh/pY8V9fNU9ok=;
        b=WSrTiI0CVIhdH4Ix24Gv3ZLQXfwDHAO5OZKb3WROQvXyGabYffzkK9I8bVEYso9dJW
         GasemxPPjzl03y2uZO7/ziSMZoT0/I+m2CASQ00TWlQ4FTqN4Aw07SCBZCpgP+ZoY35/
         SvLzquy7yI39TfVCzC4CWOPRQtapT56UxtSHx4x2EeKeANulrMhgsoztxCK3XmyD29RU
         24OB92eMzSfJe317rUx/oHry6Y0lLb8udLrib9pN8AyT0c3ERShHYoI8xvkANfqV/hNJ
         jdGOY/7rxetpN0RXRzN+U7+KR6L3BdHDE/s7GnNok2BSm4xzFcnlgKrCXMpOyxpEabFk
         mHNQ==
X-Gm-Message-State: AOAM5327nkMEx5h2V+gpJ0nn5Qtl77ZHMJd2eBpQIoAF0IQHtVKeI+AV
        XX58Gz3DLUOG5UUW1nvBRaxHRD37Gh502w==
X-Google-Smtp-Source: ABdhPJxHxgppkXEQiIH/k8reXIF0Cy4c27NqS/vMaVt09KPy7kk+4JcFdPMBgC7X3z+oLl0tvYinZA==
X-Received: by 2002:a05:6402:190c:b0:408:80a7:ed8a with SMTP id e12-20020a056402190c00b0040880a7ed8amr23441301edz.137.1645472344122;
        Mon, 21 Feb 2022 11:39:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.39.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:39:03 -0800 (PST)
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
Subject: [PATCH v2 7/9] help: error if [-a|-g|-c] and [-i|-m|-w] are combined
Date:   Mon, 21 Feb 2022 20:38:50 +0100
Message-Id: <patch-v2-7.9-992ee6580ac-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more sanity checking to "git help" usage by erroring out if these
man viewer options are combined with incompatible command-modes that
will never use these documentation viewers.

This continues the work started in d35d03cf93e (help: simplify by
moving to OPT_CMDMODE(), 2021-09-22) of adding more sanity checking to
"git help". Doing this allows us to clarify the "SYNOPSIS" in the
documentation, and the "git help -h" output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c  | 41 +++++++++++++++++++++++++++++++++++------
 t/t0012-help.sh | 10 ++++++++++
 2 files changed, 45 insertions(+), 6 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index b682446bbf5..1fc45adfcc7 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -574,12 +574,40 @@ static const char *check_git_cmd(const char* cmd)
 	return cmd;
 }
 
-static void opt_mode_usage(int argc, const char *opt_mode)
+static void no_help_format(const char *opt_mode, enum help_format fmt)
+{
+	const char *opt_fmt;
+
+	switch (fmt) {
+	case HELP_FORMAT_NONE:
+		return;
+	case HELP_FORMAT_MAN:
+		opt_fmt = "--man";
+		break;
+	case HELP_FORMAT_INFO:
+		opt_fmt = "--info";
+		break;
+	case HELP_FORMAT_WEB:
+		opt_fmt = "--web";
+		break;
+	default:
+		BUG("unreachable");
+	}
+
+	usage_msg_optf(_("options '%s' and '%s' cannot be used together"),
+		       builtin_help_usage, builtin_help_options, opt_mode,
+		       opt_fmt);
+}
+
+static void opt_mode_usage(int argc, const char *opt_mode,
+			   enum help_format fmt)
 {
 	if (argc)
 		usage_msg_optf(_("the '%s' option doesn't take any non-option arguments"),
 			       builtin_help_usage, builtin_help_options,
 			       opt_mode);
+
+	no_help_format(opt_mode, fmt);
 }
 
 int cmd_help(int argc, const char **argv, const char *prefix)
@@ -594,7 +622,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 
 	switch (cmd_mode) {
 	case HELP_ACTION_ALL:
-		opt_mode_usage(argc, "--all");
+		opt_mode_usage(argc, "--all", help_format);
 		if (verbose) {
 			setup_pager();
 			list_all_cmds_help();
@@ -606,20 +634,21 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		printf("%s\n", _(git_more_info_string));
 		break;
 	case HELP_ACTION_GUIDES:
-		opt_mode_usage(argc, "--guides");
+		opt_mode_usage(argc, "--guides", help_format);
 		list_guides_help();
 		printf("%s\n", _(git_more_info_string));
 		return 0;
 	case HELP_ACTION_CONFIG_FOR_COMPLETION:
-		opt_mode_usage(argc, "--config-for-completion");
+		opt_mode_usage(argc, "--config-for-completion", help_format);
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
-		opt_mode_usage(argc, "--config-sections-for-completion");
+		opt_mode_usage(argc, "--config-sections-for-completion",
+			       help_format);
 		list_config_help(SHOW_CONFIG_SECTIONS);
 		return 0;
 	case HELP_ACTION_CONFIG:
-		opt_mode_usage(argc, "--config");
+		opt_mode_usage(argc, "--config", help_format);
 		setup_pager();
 		list_config_help(SHOW_CONFIG_HUMAN);
 		printf("\n%s\n", _("'git help config' for more information"));
diff --git a/t/t0012-help.sh b/t/t0012-help.sh
index c87730aa920..f12783fd153 100755
--- a/t/t0012-help.sh
+++ b/t/t0012-help.sh
@@ -49,6 +49,16 @@ test_expect_success 'invalid usage' '
 	test_expect_code 129 git help --config-sections-for-completion add
 '
 
+for opt in '-a' '-g' '-c' '--config-for-completion' '--config-sections-for-completion'
+do
+	test_expect_success "invalid usage of '$opt' with [-i|-m|-w]" '
+		git help $opt &&
+		test_expect_code 129 git help $opt -i &&
+		test_expect_code 129 git help $opt -m &&
+		test_expect_code 129 git help $opt -w
+	'
+done
+
 test_expect_success "works for commands and guides by default" '
 	configure_help &&
 	git help status &&
-- 
2.35.1.1132.ga1fe46f8690

