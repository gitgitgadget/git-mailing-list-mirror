Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816CEC64E8A
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44323206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9IOTIPF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732871AbgKYWNI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732602AbgKYWNF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:05 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022FC061A53
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:05 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id u12so31079wrt.0
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ggyTh2xfy1KZsvIVeRaTDC19qP+roOPfuNpnuBpZipQ=;
        b=T9IOTIPF8J8fFyMq3vaelWIvHjllhyacQk9YjTRPzNP+F9f6bWWauRtxY8Fg0XDiU9
         BeBl29xyu7vxKSL4t7soPVIrljMH1y8iTdSllS7c8XN75NyJA1TjmbOjDi4E+qtw0mQU
         jOOehhrnMr058y08NgtJUzh7Ozk/79hTyGlOFx2tNvFodmDd+1cXOI+uZt0e3h1FIqq0
         fDJv1B78n5ZjUJhejWuGrU7Ekr7xHsvrvq9aSXCusoLUDGwohKFRujvwl3JvyPwStAlR
         T/ZYHLy33RBFjkrUQb2p8CzcjqZHVDjFRyqNAYBEwKl9vsMIogz6Mmap05Ij8KbutOSm
         IJ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ggyTh2xfy1KZsvIVeRaTDC19qP+roOPfuNpnuBpZipQ=;
        b=jssubx4kNGjPr/FCF9YRCeQd2dNCOKZQ3gPt5Q2o37qYV6aKW85cZuLeg4OtkKvDwU
         NiBhHJr3IxP31qdPPF7RNSOFg9wU5sVIG9VFer8PrAvtrtSFZBwm4r7avG/1yDawLHGm
         t1YVS/m4saEI2g+jk8ElXEEwjVF8gtGVVDNSqM2J+cWR86whN2HQHwkoZmpF/sZIH/NV
         DBygOsgDnaPmmleAurRyAxuYBBFkUVIfhnwS1xYBLJ7pzRZLpcIuevgSU48qVk65TJRM
         AEcrFT/EqlRyO2H+qXNiznQUiBph8SK5BJF4+syEbzfTrZw1i9VJo4LwfQjzHgdnU2z+
         KWnA==
X-Gm-Message-State: AOAM532YkD58wbb/Slynevt2S9TNXeql+94rVQOPoMFp4EVc/M4H5AF7
        XjIn+SFtH+1rP4rxqzEoLcczcIeBLhY=
X-Google-Smtp-Source: ABdhPJzEXIowgFGMstqf18As1tuPJYU/upMPEeZe24Mk/WQEqTDHJQokpX+sbHMaf8R6Oxm6YKIQCQ==
X-Received: by 2002:adf:f542:: with SMTP id j2mr71541wrp.32.1606342383721;
        Wed, 25 Nov 2020 14:13:03 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g186sm7221394wma.1.2020.11.25.14.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:13:03 -0800 (PST)
Message-Id: <0c276ffcee4be302be3db9b43ab8371ef26a0aec.1606342377.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
        <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:53 +0000
Subject: [PATCH v3 5/8] config: add --fixed-value option, un-implemented
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git config' builtin takes a 'value-pattern' parameter for several
actions. This can cause confusion when expecting exact value matches
instead of regex matches, especially when the input string contains
metacharacters. While callers can escape the patterns themselves, it
would be more friendly to allow an argument to disable the pattern
matching in favor of an exact string match.

Add a new '--fixed-value' option that does not currently change the
behavior. The implementation will be filled in by later changes for
each appropriate action. For now, check and test that --fixed-value
will abort the command when included with an incompatible action or
without a 'value-pattern' argument.

The name '--fixed-value' was chosen over something simpler like
'--fixed' because some commands allow regular expressions on the
key in addition to the value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-config.txt | 20 +++++++++++++-------
 builtin/config.c             | 36 ++++++++++++++++++++++++++++++++++++
 t/t1300-config.sh            | 24 ++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 0be5499952..09a1d273a9 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,15 +9,15 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
+'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
 'git config' [<file-option>] [--type=<type>] --add name value
-'git config' [<file-option>] [--type=<type>] --replace-all name value [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value-pattern]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value-pattern]
+'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
 'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] --unset name [value-pattern]
-'git config' [<file-option>] --unset-all name [value-pattern]
+'git config' [<file-option>] [--fixed-value] --unset name [value-pattern]
+'git config' [<file-option>] [--fixed-value] --unset-all name [value-pattern]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
 'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
@@ -165,6 +165,12 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file, along with their values.
 
+--fixed-value::
+	When used with the `value-pattern` argument, treat `value-pattern` as
+	an exact string instead of a regular expression. This will restrict
+	the name/value pairs that are matched to only those where the value
+	is exactly equal to the `value-pattern`.
+
 --type <type>::
   'git config' will ensure that any input or output is valid under the given
   type constraint(s), and will canonicalize outgoing values in `<type>`'s
diff --git a/builtin/config.c b/builtin/config.c
index 9d97091561..d0adbed872 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -34,6 +34,7 @@ static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
 static int show_scope;
+static int fixed_value;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -141,6 +142,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when comparing values to 'value-pattern'")),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
@@ -745,6 +747,40 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_builtin_config();
 	}
 
+	/* check usage of --fixed-value */
+	if (fixed_value) {
+		int allowed_usage = 0;
+
+		switch (actions) {
+		/* git config --get <name> <value-pattern> */
+		case ACTION_GET:
+		/* git config --get-all <name> <value-pattern> */
+		case ACTION_GET_ALL:
+		/* git config --get-regexp <name-pattern> <value-pattern> */
+		case ACTION_GET_REGEXP:
+		/* git config --unset <name> <value-pattern> */
+		case ACTION_UNSET:
+		/* git config --unset-all <name> <value-pattern> */
+		case ACTION_UNSET_ALL:
+			allowed_usage = argc > 1 && !!argv[1];
+			break;
+
+		/* git config <name> <value> <value-pattern> */
+		case ACTION_SET_ALL:
+		/* git config --replace-all <name> <value> <value-pattern> */
+		case ACTION_REPLACE_ALL:
+			allowed_usage = argc > 2 && !!argv[2];
+			break;
+
+		/* other options don't allow --fixed-value */
+		}
+
+		if (!allowed_usage) {
+			error(_("--fixed-value only applies with 'value-pattern'"));
+			usage_builtin_config();
+		}
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 040b9f7506..f6f071006d 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1967,4 +1967,28 @@ test_expect_success '--replace-all and value-pattern' '
 	test_cmp expect actual
 '
 
+test_expect_success 'refuse --fixed-value for incompatible actions' '
+	test_when_finished rm -f config &&
+	git config --file=config dev.null bogus &&
+
+	# These modes do not allow --fixed-value at all
+	test_must_fail git config --file=config --fixed-value --add dev.null bogus &&
+	test_must_fail git config --file=config --fixed-value --get-urlmatch dev.null bogus &&
+	test_must_fail git config --file=config --fixed-value --get-urlmatch dev.null bogus &&
+	test_must_fail git config --file=config --fixed-value --rename-section dev null &&
+	test_must_fail git config --file=config --fixed-value --remove-section dev &&
+	test_must_fail git config --file=config --fixed-value --list &&
+	test_must_fail git config --file=config --fixed-value --get-color dev.null &&
+	test_must_fail git config --file=config --fixed-value --get-colorbool dev.null &&
+
+	# These modes complain when --fixed-value has no value-pattern
+	test_must_fail git config --file=config --fixed-value dev.null bogus &&
+	test_must_fail git config --file=config --fixed-value --replace-all dev.null bogus &&
+	test_must_fail git config --file=config --fixed-value --get dev.null &&
+	test_must_fail git config --file=config --fixed-value --get-all dev.null &&
+	test_must_fail git config --file=config --fixed-value --get-regexp "dev.*" &&
+	test_must_fail git config --file=config --fixed-value --unset dev.null &&
+	test_must_fail git config --file=config --fixed-value --unset-all dev.null
+'
+
 test_done
-- 
gitgitgadget

