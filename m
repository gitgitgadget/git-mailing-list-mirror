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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78C27C64E75
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C95422256
	for <git@archiver.kernel.org>; Thu, 19 Nov 2020 15:52:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLD5mGxT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbgKSPwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Nov 2020 10:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbgKSPwd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Nov 2020 10:52:33 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3DA3C0617A7
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:31 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id 1so7191823wme.3
        for <git@vger.kernel.org>; Thu, 19 Nov 2020 07:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=C7gc6ZVBdCx8pSOzVMf40W3Pjx8pVRZ16wuxsmUbKts=;
        b=jLD5mGxTcDBedMXf4hKCcHd7/A1HKIj6I2hJODeALA+EXH/Fbt6yD65J3iPSmItKkk
         HoetqtWJqSj7sFPWCwN21QafMSHDXCq40w9Z7Jj+HdWxmGiDi3MJzGIUmRzOqVe6kemK
         FBovNgyQAVX4KyzDtGHXJYtygfnfztw57cv07aOwo5AMEm0ekZkuMxlYbkQ/CiSMOF/l
         J3mZDwtlYy5Q8KFNmqn4xAvSiDF4xW21J1fPGsO+Y1tnTCCyKr8KyfEK4B3Z977SOQxq
         SlcXlp7l+rZZKNl6DwYwCRSUOKkqm+hWz0fbzbineAwdgUKNg+PGjidWBWV3EKdI7B1n
         OX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=C7gc6ZVBdCx8pSOzVMf40W3Pjx8pVRZ16wuxsmUbKts=;
        b=PQ/HAx25QZEpSXlav1HXncx0IEombqkN5cg8Zeov+huLrCPHYfc4p372synk12dSmZ
         JvObJjUJw+wpXl7WLAn2qyQC8e7odsqgkwYpOX/rVZnXzRDCr2ju/HqhYFjZnWTdfWj0
         EMM7OhlfpVJ3NdygHEo6+wZImQwxtGUBddtXe5Iawbg3c9MQ26UyZcMKV7p8rPCUqSfk
         glnvLbRU2YafFg1oeuhbZZGPtMjdcsTIeK6+cMzlZe9f0H498I9bBbUZssbpn1YoMyfz
         OlYfhUp2QcQLoinPJGouzTsOcSDQOTFlJmGzkGX2Y9DxEICNZ16o7hcylrJkV45AfDgx
         YVCQ==
X-Gm-Message-State: AOAM530C88z4z2N3F5V1pASlkPSf8w5wUKQJ5XIRseDY0kRDVnqEbJAY
        LXfmcjHnNkZ872P+3wWZxAdGrvuMXlI=
X-Google-Smtp-Source: ABdhPJzTrqERvTy5BXG1fttbkqlzanxl9ykC96gvAjplC+/79xekiHXfXDt7IcbeOAOMxbmSKXkfSQ==
X-Received: by 2002:a1c:6306:: with SMTP id x6mr4600631wmb.154.1605801147249;
        Thu, 19 Nov 2020 07:52:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t13sm188726wru.67.2020.11.19.07.52.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2020 07:52:26 -0800 (PST)
Message-Id: <28493184b60d3fa46cde346eaae6128bce87c114.1605801143.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 19 Nov 2020 15:52:20 +0000
Subject: [PATCH 4/7] config: add --literal-value option, un-implemented
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
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

Add a new '--literal-value' option that does not currently change the
behavior. The implementation will follow for each appropriate action.
For now, check and test that --literal-value will abort the command when
included with an incompatible action.

The name '--literal-value' was chosen over something simpler like
'--literal' because some commands allow regular expressions on the
key in addition to the value.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 Documentation/git-config.txt | 20 +++++++++++++-------
 builtin/config.c             | 17 +++++++++++++++++
 t/t1300-config.sh            | 13 +++++++++++++
 3 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
index 7573160f21..e244dd73f0 100644
--- a/Documentation/git-config.txt
+++ b/Documentation/git-config.txt
@@ -9,15 +9,15 @@ git-config - Get and set repository or global options
 SYNOPSIS
 --------
 [verse]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
+'git config' [<file-option>] [--type=<type>] [--literal-value] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
 'git config' [<file-option>] [--type=<type>] --add name value
-'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
+'git config' [<file-option>] [--type=<type>] [--literal-value] --replace-all name value [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--literal-value] --get name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--literal-value] --get-all name [value_regex]
+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--literal-value] [--name-only] --get-regexp name_regex [value_regex]
 'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
-'git config' [<file-option>] --unset name [value_regex]
-'git config' [<file-option>] --unset-all name [value_regex]
+'git config' [<file-option>] [--literal-value] --unset name [value_regex]
+'git config' [<file-option>] [--literal-value] --unset-all name [value_regex]
 'git config' [<file-option>] --rename-section old_name new_name
 'git config' [<file-option>] --remove-section name
 'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
@@ -165,6 +165,12 @@ See also <<FILES>>.
 --list::
 	List all variables set in config file, along with their values.
 
+--literal-value::
+	When used with the `value_regex` argument, treat `value_regex` as
+	an exact string instead of a regular expression. This will restrict
+	the name/value pairs that are matched to only those where the value
+	is exactly equal to the `value_regex`.
+
 --type <type>::
   'git config' will ensure that any input or output is valid under the given
   type constraint(s), and will canonicalize outgoing values in `<type>`'s
diff --git a/builtin/config.c b/builtin/config.c
index e7c7f3d455..ad6c695737 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -34,6 +34,7 @@ static int respect_includes_opt = -1;
 static struct config_options config_options;
 static int show_origin;
 static int show_scope;
+static int literal;
 
 #define ACTION_GET (1<<0)
 #define ACTION_GET_ALL (1<<1)
@@ -52,6 +53,16 @@ static int show_scope;
 #define ACTION_GET_COLORBOOL (1<<14)
 #define ACTION_GET_URLMATCH (1<<15)
 
+#define ACTION_LITERAL_ALLOWED (\
+	ACTION_GET |\
+	ACTION_GET_ALL |\
+	ACTION_GET_REGEXP |\
+	ACTION_REPLACE_ALL |\
+	ACTION_UNSET |\
+	ACTION_UNSET_ALL |\
+	ACTION_SET_ALL\
+)
+
 /*
  * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
  * one line of output and which should therefore be paged.
@@ -141,6 +152,7 @@ static struct option builtin_config_options[] = {
 	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
 	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
 	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
+	OPT_BOOL(0, "literal-value", &literal, N_("use literal equality when matching values")),
 	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
 	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
 	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
@@ -745,6 +757,11 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		usage_builtin_config();
 	}
 
+	if (literal && !(actions & ACTION_LITERAL_ALLOWED)) {
+		error(_("--literal only applies with 'value_regex'"));
+		usage_builtin_config();
+	}
+
 	if (actions & PAGING_ACTIONS)
 		setup_auto_pager("config", 1);
 
diff --git a/t/t1300-config.sh b/t/t1300-config.sh
index 74e0f84c0a..73f5ca4361 100755
--- a/t/t1300-config.sh
+++ b/t/t1300-config.sh
@@ -1965,4 +1965,17 @@ test_expect_success '--replace-all and value_regex' '
 	test_cmp expect .git/config
 '
 
+test_expect_success 'refuse --literal-value for incompatible actions' '
+	git config dev.null bogus &&
+	test_must_fail git config --literal-value --add dev.null bogus &&
+	test_must_fail git config --literal-value --get-urlmatch dev.null bogus &&
+	test_must_fail git config --literal-value --get-urlmatch dev.null bogus &&
+	test_must_fail git config --literal-value --rename-section dev null &&
+	test_must_fail git config --literal-value --remove-section dev &&
+	test_must_fail git config --literal-value --list &&
+	test_must_fail git config --literal-value --get-color dev.null &&
+	test_must_fail git config --literal-value --get-colorbool dev.null &&
+	test_must_fail git config --literal-value --edit
+'
+
 test_done
-- 
gitgitgadget

