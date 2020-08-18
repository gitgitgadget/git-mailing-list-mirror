Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488DDC433E5
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2694D2076D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 04:02:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="W/IU4H3w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbgHREB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 00:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbgHREBz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 00:01:55 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57DAC061389
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:55 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n19so8829159ybf.0
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 21:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=VmRHp8hAbHUsjPYlGKbIckUXMeT/vlR+MBAv3XSf4Rc=;
        b=W/IU4H3wXyXmpzLyoWlk7DqFq6c0XNqc/mjjzVkds8pgxZRZ52QGEvIly3QAvs4c31
         9cbUQTxqvhzAIsYx6Uwz7yHlqigLunE5ktZVp6yO8E3gPTLZNqpSdSODD7aBtXrQvEqx
         NSG99OsTDBLZqhLp+VuLiCMF2CXJMuN6ZqW0rZ14l35kaM4fpgoECyx+n+XTBnok2cte
         SYGv/+jR/P/fQILBVNWZa10JbUu9mswNjFWfWTiKYyT/chbkyIndhe2Pk6mE/085u6fG
         hEa5PYHfGHbBZUyqElsGiHjWseqH5O5fgVT2Y393XbVpnm2nDh2gSzbLnLDHEIWaVqhN
         k08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=VmRHp8hAbHUsjPYlGKbIckUXMeT/vlR+MBAv3XSf4Rc=;
        b=nYuq6ONYZ2jSwvoglCqZ+vnM1xLIq5uQU4ehctwjVPbhGFu/4Vhk6QVA1KNDIZR3fZ
         tqGE50HqDCwbM9SuATOh6oBDTvWqeiDYXNnR8p/GlvPKwhI3TB6HSmiRY4E0YMjGJc97
         3fea987ZUXHKJiDbhi3KEbqCERFUypXVP/26MT4PATt6B608WzFn6vhHmWMTlN3hPLIH
         8HBGkvNGevhWMySy5G/0yyckkCABNEh4mbUswq0IWSar07GHvLYNpIMpb+Si3a5GoTve
         GTbN4o/dMxCl+1ttlWjrhJwdjJBrYbHZ5wLYcAieRh4d3OWQeaWxCLFFVfvoSaoq6KFn
         /osw==
X-Gm-Message-State: AOAM5302pIJjHI/13hiKvf8T0X+/Ipbzy1dVWiBWC9g+kn01tM7ut5a0
        6+6xQvEXD/dsI+BNnPRqQBXO/KgWntszawW+Vm2IcmuyrTTVXJU9rOHDc/jRDG0dlhY5/gq/qMK
        aOomNhxzOS890sLGBpmDrd4LL7xgZyRQJ74sTm5JGcDBLtajPOiUxjHLsyrzvqV0qkA0NcZ+ci4
        1S
X-Google-Smtp-Source: ABdhPJzS/mhcK5geskCtap7s5sz6uHidFpKiXwNDe17zs7HgP5IWP0J8bSxQWJcCvkWhq5dx3k95FPmRZgR+LDCclImC
X-Received: by 2002:a25:7491:: with SMTP id p139mr26311547ybc.293.1597723314927;
 Mon, 17 Aug 2020 21:01:54 -0700 (PDT)
Date:   Mon, 17 Aug 2020 21:01:33 -0700
In-Reply-To: <cover.1597722941.git.jonathantanmy@google.com>
Message-Id: <fda9f834f691adb3bf18c3b01deb058e8fe36c0c.1597722942.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597722941.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
Subject: [PATCH v3 3/7] fetch: avoid reading submodule config until needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, stolee@gmail.com,
        gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In "fetch", there are two parameters submodule_fetch_jobs_config and
recurse_submodules that can be set in a variety of ways: through
.gitmodules, through .git/config, and through the command line.
Currently "fetch" handles this by first reading .gitmodules, then
reading .git/config (allowing it to overwrite existing values), then
reading the command line (allowing it to overwrite existing values).

Notice that we can avoid reading .gitmodules if .git/config and/or the
command line already provides us with what we need. In addition, if
recurse_submodules is found to be "no", we do not need the value of
submodule_fetch_jobs_config.

Avoiding reading .gitmodules is especially important when we use "git
fetch" to perform lazy fetches in a partial clone because the
.gitmodules file itself might need to be lazy fetched (and otherwise
causing an infinite loop).

In light of all this, avoid reading .gitmodules until necessary. When
reading it, we may only need one of the two parameters it provides, so
teach fetch_config_from_gitmodules() to support NULL arguments. With
this patch, users (including Git itself when invoking "git fetch" to
lazy-fetch) will be able to guarantee avoiding reading .gitmodules by
passing --recurse-submodules=no.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c    | 10 ++++++++--
 submodule-config.c |  8 ++++++--
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index a5498646bf..29db219c68 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1786,12 +1786,18 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		free(anon);
 	}
 
-	fetch_config_from_gitmodules(&submodule_fetch_jobs_config,
-				     &recurse_submodules);
 	git_config(git_fetch_config, NULL);
 
 	argc = parse_options(argc, argv, prefix,
 			     builtin_fetch_options, builtin_fetch_usage, 0);
+	if (recurse_submodules != RECURSE_SUBMODULES_OFF) {
+		int *sfjc = submodule_fetch_jobs_config == -1
+			    ? &submodule_fetch_jobs_config : NULL;
+		int *rs = recurse_submodules == RECURSE_SUBMODULES_DEFAULT
+			  ? &recurse_submodules : NULL;
+
+		fetch_config_from_gitmodules(sfjc, rs);
+	}
 
 	if (deepen_relative) {
 		if (deepen_relative < 0)
diff --git a/submodule-config.c b/submodule-config.c
index e175dfbc38..c569e22aa3 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -777,10 +777,14 @@ static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
 {
 	struct fetch_config *config = cb;
 	if (!strcmp(var, "submodule.fetchjobs")) {
-		*(config->max_children) = parse_submodule_fetchjobs(var, value);
+		if (config->max_children)
+			*(config->max_children) =
+				parse_submodule_fetchjobs(var, value);
 		return 0;
 	} else if (!strcmp(var, "fetch.recursesubmodules")) {
-		*(config->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
+		if (config->recurse_submodules)
+			*(config->recurse_submodules) =
+				parse_fetch_recurse_submodules_arg(var, value);
 		return 0;
 	}
 
-- 
2.28.0.220.ged08abb693-goog

