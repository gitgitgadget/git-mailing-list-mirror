Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37DA7C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbiCEAQQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:16:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiCEAQB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:16:01 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBBF244A24
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:12 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id y28-20020aa793dc000000b004e160274e3eso5946743pff.18
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qu1Wfiut7OJ2NsIP33OWXJdu2Nsx4/zQgXfZHvrR/+A=;
        b=YUBzhCT8DcauRLtuW6m+Q8qId45dCOyCCNF8J7KmT0IYXD2s0rkAydo2OH70nI5pEV
         5s9xBJ3CESSzYm7yBKnIxIKBc2MZzMuy8Hd6n9v2bwh6A7Kw1N8RBYssdvVXkOGyJ6op
         bUAZpfjYx1A0vN/AN84vLnuMlZ3ZdhA/ALTqp6gA5Y5MecanAzetE+eDyJJD5T+efWGS
         guEXI9/4tKHYmApY2xx1xHWww9Q5qf7jtnXWjdtIMCHkxzMqSZK65ba7bIxUPB3W1XM8
         4AJEVzxf6NZ7AB3smPr6Y7f3zv0V9KboPtme203yd7+lF3TVX/GzKcdLs9YKFUWQpeMc
         bq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qu1Wfiut7OJ2NsIP33OWXJdu2Nsx4/zQgXfZHvrR/+A=;
        b=A+Wi9263Kk/ZTEu8F2XrKiUmCjIg1xhGjjTKa9hi+IDq82jmt4i7O6Hp2XZWSokB3Y
         r+St9djM9LrFFfeCJKCMT8zjKvSyaDok8L8yAUufAS7yxSuoOUUx59fZXhd/8xFkmrL6
         /8wkE/vXnYd7/35QO7nkKks8bnsAxGmeFDEFkj79j7/yHGuCQx3hpEtIJwYW1aE38pex
         Z9UoBamwK0chYFrGCW9O7STfL+TGxAViuaE6oJ+/WtRRY7PJBdh8MihL4QwU6qwHK6Ns
         fYcxj50dTpOSCAkezasprIXdXw1umWu/2Avn+VIFebJXYtQrDqWuMmBO975NArw8MJqh
         V8PQ==
X-Gm-Message-State: AOAM531qBXe9uWBtJEDzufyXAxKX7p0S0wTMzESLS8/vuA7J8B7mJCPo
        sJ1dT+uAdu2U9XZXo3fSnZqG3yo6mXN61O5CYo+CxiDs+NW/qaWr6xUB/NE4EmryuS9pyXp7t5y
        gp88lf0tSkJ/rCwjC2Xbgyt776z4q/bh66D8XPHZJqRade1cVH5V7YgUhvFU0QR8=
X-Google-Smtp-Source: ABdhPJwxdKPlOuYzHKWdOEG4P8+HJfROV9OnxI0T63zhKdb0mD5FYOc7rcIXxKwquBIzTtVNlTleQlitRukbeA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:e803:b0:150:1cb0:e0a4 with SMTP
 id u3-20020a170902e80300b001501cb0e0a4mr878827plg.65.1646439311615; Fri, 04
 Mar 2022 16:15:11 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:58 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 10/13] submodule--helper update-clone: learn --init
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

Teach "git submodule--helper update-clone" the --init flag and remove
the corresponding shell code.

When the `--init` flag is passed to the subcommand, we do not spawn a
new subprocess and call `submodule--helper init` on the submodule paths,
because the Git machinery is not able to pick up the configuration
changes introduced by that init call. So we instead run the
`init_submodule_cb()` callback over each submodule in the same process.

[1] https://lore.kernel.org/git/CAP8UFD0NCQ5w_3GtT_xHr35i7h8BuLX4UcHNY6VHPGREmDVObA@mail.gmail.com/

Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 26 ++++++++++++++++++++++++++
 git-submodule.sh            |  9 +++------
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c6df64bf6a..17dabf3d12 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2000,6 +2000,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 
 	int max_jobs;
+	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list = MODULE_LIST_INIT, \
@@ -2509,6 +2510,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &suc.init,
+			 N_("initialize uninitialized submodules before update")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
@@ -2567,6 +2570,29 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		suc.warn_if_uninitialized = 1;
 
+	if (suc.init) {
+		struct module_list list = MODULE_LIST_INIT;
+		struct init_cb info = INIT_CB_INIT;
+
+		if (module_list_compute(argc, argv, suc.prefix,
+					&pathspec, &list) < 0)
+			return 1;
+
+		/*
+		 * If there are no path args and submodule.active is set then,
+		 * by default, only initialize 'active' modules.
+		 */
+		if (!argc && git_config_get_value_multi("submodule.active"))
+			module_list_active(&list);
+
+		info.prefix = suc.prefix;
+		info.superprefix = suc.recursive_prefix;
+		if (suc.quiet)
+			info.flags |= OPT_QUIET;
+
+		for_each_listed_submodule(&list, init_submodule_cb, &info);
+	}
+
 	ret = update_submodules(&suc);
 	list_objects_filter_release(&filter_options);
 	return ret;
diff --git a/git-submodule.sh b/git-submodule.sh
index 882bf097d5..16dea0ca59 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -361,14 +361,11 @@ cmd_update()
 		usage
 	fi
 
-	if test -n "$init"
-	then
-		cmd_init "--" "$@" || return
-	fi
-
 	{
-	git submodule--helper update-clone ${GIT_QUIET:+--quiet} \
+	git ${wt_prefix:+-C "$wt_prefix"} submodule--helper update-clone \
+		${GIT_QUIET:+--quiet} \
 		${progress:+"--progress"} \
+		${init:+--init} \
 		${wt_prefix:+--prefix "$wt_prefix"} \
 		${prefix:+--recursive-prefix "$prefix"} \
 		${update:+--update "$update"} \
-- 
2.33.GIT

