Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D23C433FE
	for <git@archiver.kernel.org>; Thu, 10 Feb 2022 09:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiBJJ3g (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Feb 2022 04:29:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238563AbiBJJ3S (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Feb 2022 04:29:18 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1CE81131
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:18 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id y3-20020a1709029b8300b0014c8bcb70a1so1174433plp.3
        for <git@vger.kernel.org>; Thu, 10 Feb 2022 01:29:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=eDE9N2lSSvdsSpnLVK+ske7kG+FpFoWcwLzUChjaM1g=;
        b=SoWpyRGSv8RVXU1gr0LZrom3F0GAGkVXpCOeCPPA/RCBeWimUPIPJOon3/Y5Ftc6OB
         0dM9oROZWjKDTo45F5Kbz84tx16CNdPVATxYNprAH09gwBHRSqFUFCLTvTX588ghqNma
         RaLMhtxeMHNT14QMQ+VtszsI5BxLRBL1Owq4/BHKspzrRX0JMqijWZzdVmabceJZePFz
         j2HmCRkKpKIEujD82QoDYgK7NeTSXLWFwEcUJ3GPAhQ3+0zD/krMKMwkeSZOGwbVS+dI
         QAEIJYMucpbVNKQqbOjSoKmmfd+XdeljY5SbGGhJOi2j8byOl7b9SGMDf6d+CbQ97+Ka
         /ZsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=eDE9N2lSSvdsSpnLVK+ske7kG+FpFoWcwLzUChjaM1g=;
        b=MamgMofI5/X2gpjMQXQvvY4IqvWl4UdFU4aMt7PPmLyyMZ3nO4PcoedcPBTIpfO3qz
         4UP/Xd0+zwroOc9Hm4T/tivMC7gKKvzTef3gPZ8HHL6bnP4ro9qWphWmI7brhvuoWpco
         R4+tvi/7S01JV3/hIufucn6zazNMbdQcBBzytzBXAu8GmIV4ksSrK/IKGsxq+PJEi3qw
         Pvfb6/G8jHJ589tIT8XkCZfc6sLml3j/wsPe01G3iZebphG0zOc2wjyLRvVqZaC0Sky4
         UnC+bXHVKUOHUKQuDYJn/W9sBgzNDrkRA52jfSeyqVlFtwhZ4/943TZSuXv7lXYNwccN
         tlvw==
X-Gm-Message-State: AOAM533RRxWoPuTvA5Cd1qTUDqSqEqPw7EfRz/Gd+/EFge1jW01WQVXC
        Nmqdz0XqXofkFAV0NGp4Vq8KkKcB9xtAX8LvKMYoW/Fdb8MrWDAHtZ2G93U0H3hRJ2bN6n9TIYH
        v/B+AtpxxxuX+IB3AISfSLJOktu58yQ9QfJYJfBQaybyq22ZuWfutNXUbySn4Da0=
X-Google-Smtp-Source: ABdhPJxYD74gOcnvmuQJxMkIAt2wBzFxc8LMQNrriU5ooLNE69V7KA57IgoRrUtW7P28upfseUiF3/KN2vqP0A==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90a:4291:: with SMTP id
 p17mr1813198pjg.126.1644485357980; Thu, 10 Feb 2022 01:29:17 -0800 (PST)
Date:   Thu, 10 Feb 2022 17:28:27 +0800
In-Reply-To: <20220210092833.55360-1-chooglen@google.com>
Message-Id: <20220210092833.55360-15-chooglen@google.com>
Mime-Version: 1.0
References: <20220208083952.35036-1-chooglen@google.com> <20220210092833.55360-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v7 14/20] submodule--helper update-clone: learn --init
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
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
index a05aea5cd6..5635f0c48b 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1989,6 +1989,7 @@ struct submodule_update_clone {
 	int failed_clones_nr, failed_clones_alloc;
 
 	int max_jobs;
+	unsigned int init;
 };
 #define SUBMODULE_UPDATE_CLONE_INIT { \
 	.list = MODULE_LIST_INIT, \
@@ -2483,6 +2484,8 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	struct submodule_update_clone opt = SUBMODULE_UPDATE_CLONE_INIT;
 
 	struct option module_update_clone_options[] = {
+		OPT_BOOL(0, "init", &opt.init,
+			 N_("initialize uninitialized submodules before update")),
 		OPT_STRING(0, "prefix", &prefix,
 			   N_("path"),
 			   N_("path into the working tree")),
@@ -2536,6 +2539,29 @@ static int update_clone(int argc, const char **argv, const char *prefix)
 	if (pathspec.nr)
 		opt.warn_if_uninitialized = 1;
 
+	if (opt.init) {
+		struct module_list list = MODULE_LIST_INIT;
+		struct init_cb info = INIT_CB_INIT;
+
+		if (module_list_compute(argc, argv, opt.prefix,
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
+		info.prefix = opt.prefix;
+		info.superprefix = opt.recursive_prefix;
+		if (opt.quiet)
+			info.flags |= OPT_QUIET;
+
+		for_each_listed_submodule(&list, init_submodule_cb, &info);
+	}
+
 	return update_submodules(&opt);
 }
 
diff --git a/git-submodule.sh b/git-submodule.sh
index aa9c898e1c..3ccf2388bf 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -347,14 +347,11 @@ cmd_update()
 		shift
 	done
 
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

