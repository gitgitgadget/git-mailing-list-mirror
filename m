Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D65C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbiCAEnC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:43:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232384AbiCAEmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:39 -0500
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6876E29E
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:58 -0800 (PST)
Received: by mail-pg1-x54a.google.com with SMTP id u10-20020a63df0a000000b0037886b8707bso3039651pgg.23
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eiA/gy55NgWHxnholqKVR1Lek5s+reuzIp59lub6xig=;
        b=iDg27KrVOLWWvQw9rLSBlSzR9+VkpgwhLYagAwOCMaKVxBWOBkjNNRDHvB9TYJ1nSP
         y/m/RzcExexhSLjTXjGyWH5a9PVhKj2ELr6TxBF4dRnpUUoG2Zp6b4RaEUuBZXdP4Fkx
         S9bZvFjSa+xm/IBbRDHQXYc+X+nnESjcZFiF8Ka/kwtkfmxKPArIQXAnyg9SDpyExS3x
         RWG+mQy0VCVqBFk8cOAtFlg1trmqwnFlhG7MgmV53ZgOgHb1iw23jpv7pEXKcvXSW2Wu
         KpcNAdcI3Ny/UFwJkoobVKghzS1u1lzFDM7ZTZpLiMmbYpy+Jgt/HOlA34r8goFXGIci
         fiqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eiA/gy55NgWHxnholqKVR1Lek5s+reuzIp59lub6xig=;
        b=LLG26MaQ2WUeweHz4W0BO+56P+J6p0Yllkx6mMofwm0Cfqm8qH4Nipv4aI0S+uaaq4
         1Ee6Pte3THF2cc4r5+K5RaQkrDrnJ/OarkNmONsCGya1WSzT1c0Uo+rPjEyORKqx8gya
         BBKymJa7F55o4ML8Ag2jx9oFkRN8Pb1mWpIkndWpd7WVUc6wRVTVibhHmaDg8qLVHNBM
         793YN/5Yt4nRnAAJaplp4dgqtY3lsBIzH5+uHrUj9miyMStMvV/k7s2o65ixrv+t192M
         7MpAVJfDz0M6iXqZE4wYFISUO7Nk3y8L10ooxEmNMdNWPD+UAlRAj71qDLHgGniCuS1z
         dd+g==
X-Gm-Message-State: AOAM531AUtWVJ3Pg+q2NFmt8XLWb6Dm+dtLffUiHCcm6zvKKwCme7h9L
        CmURjkIG1ddgDg3Qffq0Bgr4JyS8Jj4ZOX3TA3498IxoVqjO1jutPUMunniOABcC8yW2zBGDhL8
        xx7uGlSS/cp50DmLIj0OaD9EMzeA7Dn5Ul0W977Soe8+Ru62bALaj433RwU/nRfk=
X-Google-Smtp-Source: ABdhPJxd0gmFrtTbG/KdDMBQ6q27Fk7kUG29ZK5ELxyda9XmLSYC+0eWyk4phzx5WzKH0b6eMSodCDgKoMKs7A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2405:b0:4e1:5008:adcc with SMTP
 id z5-20020a056a00240500b004e15008adccmr25515869pfh.35.1646109718098; Mon, 28
 Feb 2022 20:41:58 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:30 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-12-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 11/13] submodule--helper update-clone: learn --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>
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
index 052b247726..2ffc070319 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1998,6 +1998,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 
 	int max_jobs;
+	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list = MODULE_LIST_INIT, \
@@ -2507,6 +2508,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	int ret;
 
 	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &suc.init,
+			 N_("initialize uninitialized submodules before update")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
@@ -2565,6 +2568,29 @@ static int update_clone(int argc, const char **argv, const char *prefix)
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

