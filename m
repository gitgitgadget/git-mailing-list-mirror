Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98866C433EF
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 00:08:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231654AbiCAAJd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 19:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231304AbiCAAJX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 19:09:23 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16EB39BBBA
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:44 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id w1-20020a05690204e100b006244315a721so11907582ybs.0
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 16:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ifSK06p32C23BmYfMyrll+/iFLQK/m8pYXO3M2+HaJc=;
        b=F17CXjQtz4tf1Ev5b8ndPsrORN7M5LVlzw5K7Ot85b4j+OlUMwTXpzNbhbln15xY0U
         DlfaI3ArSWLcb3l1ghQebuJBOuHOUg4UKL0maYvt1LHpZ82La+M8+TMSWhk6Fch6p8p1
         GaDj09AFOAGaehu7/b+bjeLMMO5DvVpEMColNjtrlWCwzTaxCzsxcmpd523idVcSNQSF
         wrK3P3SEwTZ/N2Rq7RHQY3LVSsWi7JzPtB7Szt0M18qJS6QbybhjTF+PAs3KW7xm4kXg
         T+AwfA8adX9EBJyC0RcDR1JyjjndsrvuK4JtryKwq3/q1Ie5fW+Jif9JcieByj8gUYuz
         s/yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ifSK06p32C23BmYfMyrll+/iFLQK/m8pYXO3M2+HaJc=;
        b=wyNsYmWCDMFc5mOm4279ziUYRGnvIIGi0y8m81J/aebZUlghgdXPbsWj5pkX5bzwwj
         szNfQJXtiWLGHAdAPrN2kA5aAFA1Tot5kSaPTfXNC7X9qyK8ppheeBlya9SRZcl4gJ78
         4j/jdZTFsM9jQ78dqB1qpN9OguY5OdwywhTyDUKsFzw2VO85PV1rNcaUA1ZwJ1ThfgwD
         VXliF7oliZqC7OEtaWYlmm/2DZdvqhLXb6NQP0MY5tbaQ5wrHcysjHOk3XYrBTvxFKuh
         MuLk5oWyYWfNT18mDZrlYffkBRF4C/IUUEtoznXbneLov88P5L/NNDAJzC33qf/bAW4a
         93fw==
X-Gm-Message-State: AOAM5311NwWj3psIKkx0PJvmKwsfe5Sd3QdY/hzfTo80UmGFqGyt/3Z2
        1AaFe4lcPkEf5sg5GbYdITg4s/tvyBioAsYiCeG9ZIhl2JtxS0iNQ5aLQlGbfm0S6RnB3PuVcj2
        MrGlJ+0LP9uh5yGDrVx0EFwli+hIbsZkj8u1pYBPl8W9ApuD0/VFkCrA8sG3P9R8=
X-Google-Smtp-Source: ABdhPJyVY3b9i2aonKLCL4rSzzo7LTfsk+PxK/bMwIOWE8avl/2h6WZj+K826L2zOpkpLjBW24eRtwfsjGmeNg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a81:764d:0:b0:2d0:9d71:2de2 with SMTP id
 j13-20020a81764d000000b002d09d712de2mr22838807ywk.493.1646093323251; Mon, 28
 Feb 2022 16:08:43 -0800 (PST)
Date:   Mon, 28 Feb 2022 16:08:14 -0800
In-Reply-To: <20220301000816.56177-1-chooglen@google.com>
Message-Id: <20220301000816.56177-12-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH 11/13] submodule--helper update-clone: learn --init
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

Teach "git submodule--helper update-clone" the `--init` flag and remove
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
index c3760f511d..0fc07d35ae 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1999,6 +1999,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 
 	int max_jobs;
+	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list = MODULE_LIST_INIT, \
@@ -2508,6 +2509,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &suc.init,
+			 N_("initialize uninitialized submodules before update")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
@@ -2566,6 +2569,29 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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
index 23ebd90892..51be7c7f7e 100755
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

