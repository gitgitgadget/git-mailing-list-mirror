Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03DF5C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 13:40:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiKUNkW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 08:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKUNkC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 08:40:02 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 604372BFE
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:39:55 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id ja4-20020a05600c556400b003cf6e77f89cso10612046wmb.0
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 05:39:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=9X3SceFSc6v0lQ1eAXPisSazFES+GrrYmlbyUpdwqb4=;
        b=aqUlgzyfQfwWj9eNiAvcy4+Y7Z5MdkGKmP8jQQ+CMucbvQ61vymF79WuRew3NqZ1+O
         P7l1e/isPKNjCqJOm3f19EHT8XGxDMwXEcxAsZF8mYO3N91vnjGuds6xa3ehaDkm9QWZ
         aY7DSpldsfpFUrMQPxl1s0aMpFc+UeiUrI+XjxHhfoP0yVVCzdqgs0KwXNpCsXhimeyM
         4u2zOyYp3zemWUco7S6GHH8DwA5sm8O9lJYYTPsyW10srUdE8btF6nykaI01je+7pOvs
         De7YAedaIwLNfcHQG8sWABwyh8kCrIS68IsBJVHch4ghBSKMQZDFKCBKDJTVp2jwUh7f
         r+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9X3SceFSc6v0lQ1eAXPisSazFES+GrrYmlbyUpdwqb4=;
        b=rhFP0EyMQu4rgOT8qWWPNRv71rRrp1MZPTe4dWb8a13DFScu50SR4YMJ1GAxOkXaMD
         9oKz19vpgM+DnEiBLtcSdQwNzxAVaGR5kQdQep0yUXia29fI7K7OW72vREq7OT8qrg5D
         akD9trIPfaX5yCIFB/1dAUmylRzuztb+x8SCjgrqOIjg0pmDND8yTsIiMNqvmiew9Kio
         08awnpVj6Yc3oQFSXEPscySAdpFiNRpLW+/PunTkBPCvJTAzhWJ9YJamdnFWHUQNlbMQ
         NUW5LrDk3UtOh2APKMZ7O36WZiCqVFSB9aTExLH1Y5RUqzJOcjfGAswhJBSHf54DVwp7
         9v/Q==
X-Gm-Message-State: ANoB5pkzg860hgN65e6/Q/9poBhou4vOynTWt7e43hQsFajcPgtvmBQs
        GvHYpXtCJ6qOpDRYngcL7rGqqwteU+c=
X-Google-Smtp-Source: AA0mqf4A2E3spCr+3BVywitE2LSraBokF/ut4ON4sFSU8eiU0kZ+Ghs3PgxXLoen51z0Cpssbl51VA==
X-Received: by 2002:a05:600c:3b18:b0:3cf:6ab3:49ce with SMTP id m24-20020a05600c3b1800b003cf6ab349cemr12641382wms.137.1669037993549;
        Mon, 21 Nov 2022 05:39:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb12000000b002365730eae8sm11182898wrr.55.2022.11.21.05.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Nov 2022 05:39:53 -0800 (PST)
Message-Id: <pull.1429.git.1669037992587.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Nov 2022 13:39:52 +0000
Subject: [PATCH] config: introduce an Operating System-specific `includeIf`
 condition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is relatively common for users to maintain identical `~/.gitconfig`
files across all of their setups, using the `includeIf` construct
liberally to adjust the settings to the respective setup as needed.

In case of Operating System-specific adjustments, Git currently offers
no support to the users and they typically use a work-around like this:

	[includeIf "gitdir:/home/"]
		path = ~/.gitconfig-linux
	[includeIf "gitdir:/Users/"]
		path = ~/.gitconfig-mac
	[includeIf "gitdir:C:"]
		path = ~/.gitconfig-windows

However, this is fragile, as it would not even allow to discern between
Operating Systems that happen to host their home directories in
`/home/`, such as Linux and the BSDs.

Let's introduce a new condition: `os:<uname-s>` where `<uname-s>` is the
system name, i.e. the output of `uname -s`.

This addresses https://github.com/git-for-windows/git/issues/4125

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    config: introduce an Operating System-specific includeIf condition
    
    I was about to write up guidelines how to write this patch, but it
    turned out that it was much faster to write the patch instead.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1429%2Fdscho%2Finclude-if-os-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1429/dscho/include-if-os-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1429

 Documentation/config.txt |  5 +++++
 config.c                 | 11 +++++++++++
 t/t1309-early-config.sh  | 16 ++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e376d547ce0..2db73d8228e 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -186,6 +186,11 @@ As for the naming of this keyword, it is for forwards compatibiliy with
 a naming scheme that supports more variable-based include conditions,
 but currently Git only supports the exact keyword described above.
 
+`os`::
+	The data that follows this keyword is taken as the name of an
+	Operating System; If it matches the output of `uname -s`, the
+	include condition is met.
+
 A few more notes on matching via `gitdir` and `gitdir/i`:
 
  * Symlinks in `$GIT_DIR` are not resolved before matching.
diff --git a/config.c b/config.c
index 9b0e9c93285..9ab311ae99b 100644
--- a/config.c
+++ b/config.c
@@ -394,6 +394,15 @@ static int include_by_remote_url(struct config_include_data *inc,
 					     inc->remote_urls);
 }
 
+static int include_by_os(const char *cond, size_t cond_len)
+{
+	struct utsname uname_info;
+
+	return !uname(&uname_info) &&
+		!strncasecmp(uname_info.sysname, cond, cond_len) &&
+		!uname_info.sysname[cond_len];
+}
+
 static int include_condition_is_true(struct config_include_data *inc,
 				     const char *cond, size_t cond_len)
 {
@@ -408,6 +417,8 @@ static int include_condition_is_true(struct config_include_data *inc,
 	else if (skip_prefix_mem(cond, cond_len, "hasconfig:remote.*.url:", &cond,
 				   &cond_len))
 		return include_by_remote_url(inc, cond, cond_len);
+	else if (skip_prefix_mem(cond, cond_len, "os:", &cond, &cond_len))
+		return include_by_os(cond, cond_len);
 
 	/* unknown conditionals are always false */
 	return 0;
diff --git a/t/t1309-early-config.sh b/t/t1309-early-config.sh
index 537435b90ae..7da67af06e7 100755
--- a/t/t1309-early-config.sh
+++ b/t/t1309-early-config.sh
@@ -100,4 +100,20 @@ test_expect_success 'onbranch config outside of git repo' '
 	nongit git help
 '
 
+test_expect_success '[includeIf "os:..."]' '
+	test_config x.y 0 &&
+	echo "[x] y = z" >.git/xyz &&
+
+	if test_have_prereq MINGW
+	then
+		uname_s=Windows
+	else
+		uname_s="$(uname -s)"
+	fi &&
+	test_config "includeIf.os:not-$uname_s.path" xyz &&
+	test 0 = "$(git  config x.y)" &&
+	test_config "includeIf.os:$uname_s.path" xyz &&
+	test z = "$(git config x.y)"
+'
+
 test_done

base-commit: e4a4b31577c7419497ac30cebe30d755b97752c5
-- 
gitgitgadget
