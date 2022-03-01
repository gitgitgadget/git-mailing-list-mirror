Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C4ABC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232440AbiCAEnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:43:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232389AbiCAEmo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:44 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D812E6FA33
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:42:02 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id c192-20020a621cc9000000b004e0ff94313dso9004073pfc.17
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SxQM2cxFgTJkz187BLMpOB9JRuL0P/ov+6eGJwePauo=;
        b=WeSk1R6cCb/u2AkNnG01CWEjzrxUFy2f6Z5M6qh7AjgRwioG6WVgMZjpPniM6beBEZ
         paBjplT678baxmjKVomo4Papc7Ks0cHnk/p3DB0XMC5dsO77okYg5PtvUHdezp2osdxw
         6n1C8P/hrMecbUd+OyWsJdsGAdg2fAP0o7fG39NA0s7DptSOx4/W1TvfyWhYV1GTzXeL
         FxbGRzbx8t8Tb8QgcSZdeNgV80IPPBZo8xo32MFpqwSYLi9W1xId4PITK46kfBSI+Gau
         mCCo9eHcO4oafOjnhMiyE55h3mQJLqOJyTr2dHXFxmDzGwAmWSmCldD0L33vzO1b211N
         pT8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SxQM2cxFgTJkz187BLMpOB9JRuL0P/ov+6eGJwePauo=;
        b=6IkSQ2Y5/KYc+n9z863koDkGv8cVSiLV2xr1KtTagrzvLWX3vOixrdKGNAYue8pJR0
         01iGdHPED7Xt7hbuzz+b8OK2ffVRLd7z0eCjaiswUv3GlaQdxxfMTldNO3ausGCYUDdS
         vsavlf572XFMLuZ4Uvm3hH2fAz4KbFis1hf9OqMcwlKmLbElzr/GuepN2E2GUH7oNMsZ
         L/sZh5ZkmcZZUG70TnSUXENaRoz2w7DV+OYZ03NgSjom0xoV3n9YXMkQO+azCrjVNBtY
         /moB+VsmSy7YTJ++8wxllVXke5TIJl+IMQNsS+9CEfAWbMm5BO8pQUQQxTNC3gngzl2D
         xdJw==
X-Gm-Message-State: AOAM531FxMRj47RDFk95hpxbB2lZum2SNB/AOyFIX6+1O5XzgP3T2H7F
        UZv7zLyfJCfu2dgkur8XtFOkW2eRP5fq1GEktfJX41eqbTXasNC+EaF4w8xjd0pcy5OcoQWDNZy
        E/GO8NkmSz9Rt5PfDFLfwfdkkbn/KBKe7NEq0BoLWkyRp+hJHhXdIQFzDRYHAT94=
X-Google-Smtp-Source: ABdhPJxxGtM2YqUgLAHP7XOJ3TF1YfnXCB8DWSXV7xkZ5wfGkblGY9VqEbJ0jT2OuJY7tL1VNaKlVTerU0xRgA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:8f94:b0:151:64c5:7759 with SMTP
 id z20-20020a1709028f9400b0015164c57759mr9057509plo.4.1646109722245; Mon, 28
 Feb 2022 20:42:02 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:32 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-14-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 13/13] submodule--helper update-clone: check for --filter
 and --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"git submodule update --filter" also requires the "--init" option. Teach
update-clone to do this usage check in C and remove the check from
git-submodule.sh.

In addition, change update-clone's usage string so that it teaches users
about "git submodule update" instead of "git submodule--helper
update-clone" (the string is copied from git-submodule.sh). This should
be more helpful to users since they don't invoke update-clone directly.

Signed-off-by: Glen Choo <chooglen@google.com>
---
Since we expect users to act upon the usage string, I've updated it to
reflect "git submodule update" [1] (since that's what users actually
invoke), but I feel a bit iffy about not being able to use
usage_with_options() (because the options and usage string are for
different commands).

This might indicate that this is work we should put off until the
conversion to C is mostly complete, but on the other hand, the usage
string is still more helpful than it used to be because we never
presented users with the options anyway.

[1] It's not immediately obvious which command we prefer to show - some
other commands use "git submodule--helper" and others use "git
submodule".

 builtin/submodule--helper.c | 20 +++++++++++++++++++-
 git-submodule.sh            |  5 -----
 2 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 2ffc070319..3e8a05a052 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2543,7 +2543,12 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper update-clone [--prefix=<path>] [<path>...]"),
+		N_("git submodule [--quiet] update"
+		"[--init [--filter=<filter-spec>]] [--remote]"
+		"[-N|--no-fetch] [-f|--force]"
+		"[--checkout|--merge|--rebase]"
+		"[--[no-]recommend-shallow] [--reference <repository>]"
+		"[--recursive] [--[no-]single-branch] [--] [<path>...]"),
 		NULL
 	};
 	suc.prefix = prefix;
@@ -2554,6 +2559,19 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	memset(&filter_options, 0, sizeof(filter_options));
 	argc = parse_options(argc, argv, prefix, module_update_clone_options,
 			     git_submodule_helper_usage, 0);
+
+	if (filter_options.choice && !suc.init) {
+		/*
+		 * NEEDSWORK: Don't use usage_with_options() because the
+		 * usage string is for "git submodule update", but the
+		 * options are for "git submodule--helper update-clone".
+		 *
+		 * This will no longer be an issue when "update-clone"
+		 * is replaced by "git submodule--helper update".
+		 */
+		usage(git_submodule_helper_usage[0]);
+	}
+
 	suc.filter_options = &filter_options;
 
 	if (update)
diff --git a/git-submodule.sh b/git-submodule.sh
index 51be7c7f7e..aa8bdfca9d 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -356,11 +356,6 @@ cmd_update()
 		shift
 	done
 
-	if test -n "$filter" && test "$init" != "1"
-	then
-		usage
-	fi
-
 	{
 	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
 		${GIT_QUIET:+--quiet} \
-- 
2.33.GIT

