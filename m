Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98DE6C433EF
	for <git@archiver.kernel.org>; Tue, 28 Jun 2022 10:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbiF1KGa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344733AbiF1KG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jun 2022 06:06:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE3F2DAAA
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:18 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id k129so5621078wme.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2022 03:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rQV8033leCUnUqz3xdWGkYI5Ocvxb+4360H2xUio/ew=;
        b=OIZfS9rpzC2xUexP1FrschuKWiylZN8Bq1ZAQ6LNtBnvohioJwJYIs1qAgBonxslVS
         a5GJ3wIukC8pgC/6Jmvcs7Er8kvAKpDLNXrrekd1HH4fhWw8iP1jMxFM01b6ymrSHspO
         S9nJyQNT60Vx5wTevwZNYcNayZb+WxkY8rxoUTCd3ge8B5NO4ynp5nMOi1tScsIonsC9
         2wk5jHo3aSUPnm8qqvaKUEDY+lqDonESNOKTGo8u63u/fA9a/WjWU5Y1aj84UkFo/dbU
         RY02rZJWydlErYGwTkJjQKwXaIb89tPLtgwYMZb/t2sd5unq+WsS0E8x5QoSpRMZMkuL
         r6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rQV8033leCUnUqz3xdWGkYI5Ocvxb+4360H2xUio/ew=;
        b=HI1HFL0p9jaHaZZIJB9SsTWHHGRqCg/HBT+l4rQR+KmcNZAXCJCVrZ04IZkOztJMhV
         rWGiDsDuO2VrBDqW55Sq47IDqXCaVEeaHfI0rAYX2UXaMAmcFlZ3qYLbWQjkNCfdg4oy
         CCLSEFs+xoWweEiSjn7B4GtTML1pSnOGn/4V0bMyOd21Y6YXpDzEUcrws/bWyppqBEEG
         BOjLmZNnM+qefWFOzxtiT703OSKNkD9ptKi5QQ/YkSImMLKZAuP1/Dz9tyPgz+YlXEYj
         3ZMqnkNcKzh9Tna/k0AZiTk4MKwQr+bVLKhgeEHQvku98josdoWyAJx71urH7A5Gke2c
         drCQ==
X-Gm-Message-State: AJIora/cmrCU8deV6ZVIAP/y7M9DtHL3RlIi5loJGOqO4fSgkf0PgVrk
        5N4K/tCitFz56F0YilZCZhzVcPdSP+R17w==
X-Google-Smtp-Source: AGRyM1tFe+RhItiYZ4lmOZjjsloHGK0MtsGoFUFVNgL1yvXpOD0NnPWudi/k9411pup2WHwEJzdpPw==
X-Received: by 2002:a05:600c:3d16:b0:39e:f07b:77a5 with SMTP id bh22-20020a05600c3d1600b0039ef07b77a5mr24683252wmb.140.1656410776388;
        Tue, 28 Jun 2022 03:06:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e16-20020a5d4e90000000b0021b91d1ddbfsm12914430wru.21.2022.06.28.03.06.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 03:06:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/12] submodule--helper: report "submodule" as our name in some "-h" output
Date:   Tue, 28 Jun 2022 12:05:30 +0200
Message-Id: <patch-v4-08.12-b8a9b085633-20220628T095914Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.880.gf07d56b18ba
In-Reply-To: <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
References: <cover-v3-00.12-00000000000-20220622T142012Z-avarab@gmail.com> <cover-v4-00.12-00000000000-20220628T095914Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the user-facing "git submodule--helper" commands so that
they'll report their name as being "git submodule". To a user these
commands are internal implementation details, and it doesn't make
sense to emit usage about an internal helper when "git submodule" is
invoked with invalid options.

Before this we'd emit e.g.:

	$ git submodule absorbgitdirs --blah
	error: unknown option `blah'
	usage: git submodule--helper absorbgitdirs [<options>] [<path>...]
	[...]
And:

	$ git submodule set-url -- --
	usage: git submodule--helper set-url [--quiet] <path> <newurl>
	[...]

Now we'll start with "usage: git submodule [...]" in both of those
cases. This change does not alter the "list", "name", "clone",
"config" and "create-branch" commands, those are internal-only (as an
aside; their usage info should probably invoke BUG(...)). This only
changes the user-facing commands.

The "status", "deinit" and "update" commands are not included in this
change, because their usage information already used "submodule"
rather than "submodule--helper".

I don't think it's currently possible to emit some of this usage
information in practice, as git-submodule.sh will catch unknown
options, and e.g. it doesn't seem to be possible to get "add" to emit
its usage information from "submodule--helper".

Though that change may be superfluous now, it's also harmless, and
will allow us to eventually dispatch further into "git
submodule--helper" from git-submodule.sh, while emitting the correct
usage output.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/submodule--helper.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 10223a00927..d145d53addd 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -444,7 +444,7 @@ static int module_foreach(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper foreach [--quiet] [--recursive] [--] <command>"),
+		N_("git submodule foreach [--quiet] [--recursive] [--] <command>"),
 		NULL
 	};
 
@@ -582,7 +582,7 @@ static int module_init(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper init [<options>] [<path>]"),
+		N_("git submodule init [<options>] [<path>]"),
 		NULL
 	};
 
@@ -1185,7 +1185,7 @@ static int module_summary(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper summary [<options>] [<commit>] [--] [<path>]"),
+		N_("git submodule summary [<options>] [<commit>] [--] [<path>]"),
 		NULL
 	};
 
@@ -1349,7 +1349,7 @@ static int module_sync(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper sync [--quiet] [--recursive] [<path>]"),
+		N_("git submodule sync [--quiet] [--recursive] [<path>]"),
 		NULL
 	};
 
@@ -2788,7 +2788,7 @@ static int absorb_git_dirs(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const git_submodule_helper_usage[] = {
-		N_("git submodule--helper absorbgitdirs [<options>] [<path>...]"),
+		N_("git submodule absorbgitdirs [<options>] [<path>...]"),
 		NULL
 	};
 
@@ -2893,7 +2893,7 @@ static int module_set_url(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-url [--quiet] <path> <newurl>"),
+		N_("git submodule set-url [--quiet] <path> <newurl>"),
 		NULL
 	};
 
@@ -2932,8 +2932,8 @@ static int module_set_branch(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	const char *const usage[] = {
-		N_("git submodule--helper set-branch [-q|--quiet] (-d|--default) <path>"),
-		N_("git submodule--helper set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-d|--default) <path>"),
+		N_("git submodule set-branch [-q|--quiet] (-b|--branch) <branch> <path>"),
 		NULL
 	};
 
@@ -3277,7 +3277,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 	};
 
 	const char *const usage[] = {
-		N_("git submodule--helper add [<options>] [--] <repository> [<path>]"),
+		N_("git submodule add [<options>] [--] <repository> [<path>]"),
 		NULL
 	};
 
-- 
2.37.0.880.gf07d56b18ba

