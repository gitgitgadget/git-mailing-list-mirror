Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E88C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233219AbiBUTkH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:40:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:57224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233114AbiBUTjn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:43 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F36C223BC5
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:03 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id w3so31514197edu.8
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DC/EtAnL9w/ctOawL83PIgPMQ10LhUoUJ8De8P55aJE=;
        b=RctxNREsql4EZsu29/2XaGUCi1ZHNszQCQPGQ0yFtW1LLE4QL92HAwySvU5slqSUU6
         OAb4E1xww/dOFG62dtw/4/9Hyq3CQAxpbOMNGFEKDrUxOIcMyRM8ycTO3sxRQ0pCS+2y
         WN8r+evmMfzws0Mv/m75LRJ311ocCvOq3koblf1AJMWebDB1E6K3fseCC3hHhZYnVs+K
         W/C1PCzdIPrhTdXCYM6KVN/uNFw2NnmV+9HZ3o7w8lBYfHikz4BQTXaNehfcU5aPzA7S
         UDAEtRzzP9gFzG0mMrBqlaCO+vfQs98XpdWw6BrZz2bEqiqk1rSFAIc6CTTX441jHjd1
         wmRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DC/EtAnL9w/ctOawL83PIgPMQ10LhUoUJ8De8P55aJE=;
        b=lmof8YLyjivG6Gf8qEwHU6iWlTaYfXwwDxInIYeSgkTxRsUKd9weD8aXsURFWyTui/
         Kw1nsHj+/NylQSrr0wz5Va7U4087UIfo79HSV6CdoW+iAuF/2nRY4Z8LFHsn4P1xwGLQ
         nezHVSIKbh21bCUeqjY1MUiCT1h4r/bdW7ehyjmHjrlTLDrQJEco0aVCAC/pZk2SN3Au
         4hUwwpn90NPz6waXKZr9pNfn7BwnybM2o0F65ENS5+aW3h28UFlM4Dt9Jz23NeVyTv6O
         zgVZ+P8/cG0YP9rgY3Ha4W3G1Pgy9gL7xAOKfldzZtv3Su0vgCc5d4hfbeU2CV3U2Nah
         v6Dw==
X-Gm-Message-State: AOAM531uUoTbggbD8L2GpF832iBZN030uuRTTQbcAerhzuFo8vzd4lea
        ib1r/SZ35DaaHiMGqcEWpe8Gri+NMM7+KA==
X-Google-Smtp-Source: ABdhPJynFqYfIffAEhocbyjssSnL/VsAXQwQX+96+65sJ0hRF7nyiPTGot2u6qFh2tO12zlJuGSrEw==
X-Received: by 2002:a50:9358:0:b0:40f:aee9:86fb with SMTP id n24-20020a509358000000b0040faee986fbmr23189582eda.383.1645472342269;
        Mon, 21 Feb 2022 11:39:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:39:01 -0800 (PST)
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
Subject: [PATCH v2 5/9] help: note the option name on option incompatibility
Date:   Mon, 21 Feb 2022 20:38:48 +0100
Message-Id: <patch-v2-5.9-e5c49089106-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the errors added in d35d03cf93e (help: simplify by moving to
OPT_CMDMODE(), 2021-09-22) to quote the offending option at the user
when invoked as e.g.:

    git help --guides garbage

Now instead of:

    fatal: this option doesn't take any other arguments

We'll emit:

    fatal: the '--guides' option doesn't take any non-option arguments

Let's also rename the function, as it will be extended to do other
checks that aren't "no extra argc" in a subsequent commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/help.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/builtin/help.c b/builtin/help.c
index d387131dd83..1c1581ef850 100644
--- a/builtin/help.c
+++ b/builtin/help.c
@@ -574,11 +574,12 @@ static const char *check_git_cmd(const char* cmd)
 	return cmd;
 }
 
-static void no_extra_argc(int argc)
+static void opt_mode_usage(int argc, const char *opt_mode)
 {
 	if (argc)
-		usage_msg_opt(_("this option doesn't take any other arguments"),
-			      builtin_help_usage, builtin_help_options);
+		usage_msg_optf(_("the '%s' option doesn't take any non-option arguments"),
+			       builtin_help_usage, builtin_help_options,
+			       opt_mode);
 }
 
 int cmd_help(int argc, const char **argv, const char *prefix)
@@ -604,20 +605,20 @@ int cmd_help(int argc, const char **argv, const char *prefix)
 		printf("%s\n", _(git_more_info_string));
 		break;
 	case HELP_ACTION_GUIDES:
-		no_extra_argc(argc);
+		opt_mode_usage(argc, "--guides");
 		list_guides_help();
 		printf("%s\n", _(git_more_info_string));
 		return 0;
 	case HELP_ACTION_CONFIG_FOR_COMPLETION:
-		no_extra_argc(argc);
+		opt_mode_usage(argc, "--config-for-completion");
 		list_config_help(SHOW_CONFIG_VARS);
 		return 0;
 	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
-		no_extra_argc(argc);
+		opt_mode_usage(argc, "--config-sections-for-completion");
 		list_config_help(SHOW_CONFIG_SECTIONS);
 		return 0;
 	case HELP_ACTION_CONFIG:
-		no_extra_argc(argc);
+		opt_mode_usage(argc, "--config");
 		setup_pager();
 		list_config_help(SHOW_CONFIG_HUMAN);
 		printf("\n%s\n", _("'git help config' for more information"));
-- 
2.35.1.1132.ga1fe46f8690

