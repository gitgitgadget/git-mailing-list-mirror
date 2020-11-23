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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D3A8C63798
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C28E2080A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HO1810yL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388368AbgKWQFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732604AbgKWQFV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:21 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9CC2C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:19 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id a65so17747176wme.1
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kyGJkfWKndxqyK4ZGyfS8HYEi0adgfoui48H66tiSN4=;
        b=HO1810yLQv4ofXvYkiDJiW2Jhzh2pmRJctiaIzX2pizdxDEJOX1O/gpfCZjsGK10Md
         F0tYwYRYcc/aKgJj+ulnDbLYn2Qf1tPq2FtxZDmS0mP8TRwQey/eKdSF5vA8FWA/VkzD
         n7QK2KWCzzu0xVTXrhr/2xK2E+yUUFWDLVWPFpGLUkGeYPlQ4M8ZC/M/IMfwxyjxjmaq
         6bUOGKNK1/5gMToXN/1bB9Xm91X3JVLC5AJuOSn3hya1nCJ8j28hwhAW1mhSBeHrqwnk
         2cPpU6lSy5avCUh9gObgiz6iG1SP5dwwsWirmOfo9O2iQAz87dnDENiprvyAb3hPne5S
         XVZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kyGJkfWKndxqyK4ZGyfS8HYEi0adgfoui48H66tiSN4=;
        b=SOi2Fi9ddn3cn/j5R0MlD2Anb9kf9YxgYBh4DlIuzZIu5DD0Fk+T9+RoMB4TnuGKQZ
         04AQUr8xQQBS1WgQZzmIFQBoDAaMqogvFqH1Wp50efFAiR7i3GiKAM5/fSVjBR8UAUjn
         LiKHHfvkywswqg5re7KJJ2Aq7twRT3JPzoDZ2bmyAITmGByka/5zbMQ1hFfMhrNjU1fB
         2quQrBxaUzBebiFBe0Y7UkW6XvOXfvRaXEUn79Yg0qT/KIPGak2rLuYxnhGdM4Xr9pn2
         qQe2MO6GacXgBrcAPab2Ajor5aAv0o4Hc32FOwLexx0Pe4iWeJUXizhleAlVBv/zFZU1
         8ZrQ==
X-Gm-Message-State: AOAM533uXJy5eWHCyOFAWsmINn0mzAJgJrcYZ+6NRdvDv9otisb7JEsy
        zVa6ADNwgL39x0VwzDIUMb1ohXhjZ0o=
X-Google-Smtp-Source: ABdhPJyP9Hq0SJMweINQ97HNk22y5dru01g6fPN57XdE2REQyo+oxtBspY92CFcx84J+TR24FZVGNA==
X-Received: by 2002:a1c:32c6:: with SMTP id y189mr25350911wmy.133.1606147514374;
        Mon, 23 Nov 2020 08:05:14 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m20sm21895071wrg.79.2020.11.23.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:13 -0800 (PST)
Message-Id: <0e6a7371ed4696f6cc85df07466fb6c20d58d62e.1606147507.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
        <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:04 +0000
Subject: [PATCH v2 4/7] config: add --fixed-value option, un-implemented
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
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The 'git config' builtin takes a 'value_regex' parameter for several
actions. This can cause confusion when expecting exact value matches
instead of regex matches, especially when the input string contains glob
characters. While callers can escape the patterns themselves, it would
be more friendly to allow an argument to disable the pattern matching in
favor of an exact string match.

Add a new '--fixed-value' option that does not currently change the
behavior. The implementation will follow for each appropriate action.
For now, check and test that --fixed-value will abort the command when
included with an incompatible action or without a 'value_regex'
argument.

The name '--fixed-value' was chosen over something simpler like
'--fixed' because some commands allow regular expressions on the
key in addition to the value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-config.txt | 20 +++++++++++++-------
 builtin/config.c             | 26 ++++++++++++++++++++++++++
 t/t1300-config.sh            | 23 +++++++++++++++++++++++
 3 files changed, 62 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7573160f21..d4bb928ea7 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,15 +9,15 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [--type=<type>] --add name value
-'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value_regex]
 'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] --unset name [value_regex]
-'git config' [<file-option>] --unset-all name [value_regex]
+'git config' [<file-option>] [--fixed-value] --unset name [value_regex]
+'git config' [<file-option>] [--fixed-value] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
 'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
@@ -165,6 +165,12 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file, along with their values.
 
+--fixed-value::
+	When used with the `value_regex` argument, treat `value_regex` as
+	an exact string instead of a regular expression. This will restrict
+	the name/value pairs that are matched to only those where the value
+	is exactly equal to the `value_regex`.
+
 --type <type>::
   'git config' will ensure that any input or output is valid under the given
   type constraint(s), and will canonicalize outgoing values in `<type>`'s
diff --git a/builtin/config.c b/builtin/config.c
index e7c7f3d455..bfb55a96df 100644
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
+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
@@ -745,6 +747,30 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_builtin_config();
 	}
 
+	if (fixed_value) {
+		int allowed_usage = 0;
+
+		switch (actions) {
+		case ACTION_GET:
+		case ACTION_GET_ALL:
+		case ACTION_GET_REGEXP:
+		case ACTION_UNSET:
+		case ACTION_UNSET_ALL:
+			allowed_usage = argc > 1 && !!argv[1];
+			break;
+
+		case ACTION_SET_ALL:
+		case ACTION_REPLACE_ALL:
+			allowed_usage = argc > 2 && !!argv[2];
+			break;
+		}
+
+		if (!allowed_usage) {
+			error(_("--fixed-value only applies with 'value_regex'"));
+			usage_builtin_config();
+		}
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 8783767d4f..6dc8117241 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1960,4 +1960,27 @@ test_expect_success '--replace-all and value_regex' '
 	test_cmp expect actual
 '
 
+test_expect_success 'refuse --fixed-value for incompatible actions' '
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
+	# These modes complain when --fixed-value has no value_regex
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

