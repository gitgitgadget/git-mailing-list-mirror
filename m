Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E25FC433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:09:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbiCAAJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbiCAAJe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:34 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540201323FD
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:47 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id n188-20020a6340c5000000b003747606cb0dso7437619pga.6
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6Gg+ZNtyyULxOoigD38bkD0NFi77mUGN0fpEUvYTLCw=;
        b=aMDbEN8O+fJHSU+EVhecUqTgTJ+6rEVpiqEyZ7IFrO7Qi+Gl4GCKeFY5r0SojKQaOD
         QRrThswp5oM/Jp0qb8gqFr6tIei1K7oEoYiQQjOE67RrvoPKgQtCuHU2ItqrB3har1EZ
         7xYvT0z6xDC+nZZcZfsy+2noTWH49mV5QXsdQ29TjAxY1AH+XL0I44kE4XhS+js4MRkP
         xtkryJM35JFgVc9jjjkyHevYUpLkNCg13wQByTx/kqwzvutuh74bC0ZMyfgfLXCOxWo6
         RJ+yUfXUT51k1SBlcKxrbZQwHCWu/04uNhIusSXwDutO3N0FyCjjTDB2crbXL3DkHOK5
         dFXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6Gg+ZNtyyULxOoigD38bkD0NFi77mUGN0fpEUvYTLCw=;
        b=Cxc9+fyZLAXGvpcI22RWuwyyEEsnhbY5lB+NHXJDXpYyRN4Q1NutNURGGIH+mFz6Pz
         sEDXWnHlwBOi6nnmhtRNg/Jb3HRFER570pIJQVni3DIVlUzytNH3aWuxDh6PaosEPxiZ
         Ibw4vaD6IxGiwLaQc5922bGl4ipp4FldMuKPGbrd30Wm6/U1zSbEkWcxdTNnKu4I+kI9
         kioNDSJYcweohTt7qhKZAjoedsVO/wl1daWKryRBII95OvLM/eXYZLkeCYEcOlJMieeg
         TZZZkwVm2yRYSJHvdcLP3vfWnZQgLstOqsLfDHUR0DGFlWWrFXeIs3qpZXxeOPVWDswW
         khXg==
X-Gm-Message-State: AOAM533EADYgKTKkvGrxiUrjT3/uIRDxcnSDqLVWBt/KXatbAZ4/syYn
        LCeGFYYvSlrlWj9Y8FXBbAyob2MdX+/BnZzab8Zc/VQKxXLtG+3xNpYJW9dQcTBk6iTY1zCbA/K
        Xm4W3dtDzbdEpTQ0mRAejHsAw5xH9TjXNnfbO9s1m4MhEIw8TqZ4NRcqzXg8La3M=
X-Google-Smtp-Source: ABdhPJyPLlsv0mwkAy4QHViOcbXNdBCLbk7szUgTVtbc3VH+qnsDoQPLdF6ULrIRH+EUnm/IwGVJ42/Ko46gqg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:eb0c:0:b0:373:334d:c32f with SMTP id
 t12-20020a63eb0c000000b00373334dc32fmr19347498pgh.358.1646093327172; Mon, 28
 Feb 2022 16:08:47 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:16 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-14-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 13/13] submodule--helper update-clone: check for --filter and --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
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
index 0fc07d35ae..ea88f39fb4 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2544,7 +2544,12 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
@@ -2555,6 +2560,19 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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

