Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F6A20285
	for <e@80x24.org>; Thu, 24 Aug 2017 19:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753335AbdHXTvd (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 15:51:33 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:37155 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753025AbdHXTvc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 15:51:32 -0400
Received: by mail-pg0-f66.google.com with SMTP id a7so648395pgn.4
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 12:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkRpwIl8GiKfCf86T+6euVOOyt76WM/13BaFsCzN2nI=;
        b=b6qabZst6EtpGuw9MTaSgJ/fYBCeqZoMvJoRJ3uVCRzL5V4ofrg/L6k2/+wPjELbRD
         gxASGZ9Ww5M3xvLtQaBv3Zl3klGTsB0seMf2KMQBqBEcU1Itfnazjda3ShQ7CIml/Z2c
         KLMNUiuNKvpwoUYT02rJfYbaNeaNUdrKqh5QNHDspxbwMlpVB26m8exTM+CROxB4ni+0
         X9ihz8ex+3kf1zslI9VNRARVSi1HzEm2mBEfoleCy6/3jhaJpqo/W4pF3JhA1AM5fVHP
         oc/EEevV5nAvgdY3harbdcn43dRkWYA7MuLZf51aamYcU+SWwmEUDsGOqpKc7XLeuh8H
         tCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkRpwIl8GiKfCf86T+6euVOOyt76WM/13BaFsCzN2nI=;
        b=k34LNloh80IT53E4h2YJcIYv5n3qPlfYbqsmtnwK2Sl+c7EwRhr5dpm0R9C88P8F6P
         WAkzbKHXYyLv005jUsRZsiuNuSoniHNP5flKT6lmpmFydLYUi0OL77ZwtvQhI1hAmLkx
         7ZGfY7/QOfjedDLNEltDt1nAEF9g5cPnqkhwmNBFnBtVdXyXyV1xOCojgoKL/L9mwGQV
         FrMaa9fDgodzx+IlbUouVmeE1Oqyesz0SY+6trqm7E8HsvbFCxPVdxsjiJKzJ0lbswti
         RpDkONQ7ariZSxKwSMhrzy5lUWie3f4hriwvqesnLKfpDdgnGeVnrf4myi1FxTQYzjvl
         l82A==
X-Gm-Message-State: AHYfb5i2cTyDyhl62vAXR8hXrUpIAF7+SEYwk3VbGEyptRd5ufrIWQoZ
        mKYULJI357nOEy51+Nw=
X-Received: by 10.84.133.133 with SMTP id f5mr8009024plf.134.1503604291646;
        Thu, 24 Aug 2017 12:51:31 -0700 (PDT)
Received: from localhost.localdomain ([27.63.191.1])
        by smtp.gmail.com with ESMTPSA id v2sm9074270pfl.21.2017.08.24.12.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 12:51:31 -0700 (PDT)
From:   Prathamesh Chavan <pc44800@gmail.com>
To:     gitster@pobox.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, pc44800@gmail.com,
        sbeller@google.com
Subject: [GSoC][PATCH v3 1/4] submodule--helper: introduce get_submodule_displaypath()
Date:   Fri, 25 Aug 2017 01:20:48 +0530
Message-Id: <20170824195051.30900-2-pc44800@gmail.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170824195051.30900-1-pc44800@gmail.com>
References: <xmqq7exuysc7.fsf@gitster.mtv.corp.google.com>
 <20170824195051.30900-1-pc44800@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Introduce function get_submodule_displaypath() to replace the code
occurring in submodule_init() for generating displaypath of the
submodule with a call to it.

This new function will also be used in other parts of the system
in later patches.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Prathamesh Chavan <pc44800@gmail.com>
---
 builtin/submodule--helper.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 84562ec83..e666f84ba 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -220,6 +220,28 @@ static int resolve_relative_url_test(int argc, const char **argv, const char *pr
 	return 0;
 }
 
+static char *get_submodule_displaypath(const char *path, const char *prefix)
+{
+	const char *super_prefix = get_super_prefix();
+
+	if (prefix && super_prefix) {
+		BUG("cannot have prefix '%s' and superprefix '%s'",
+		    prefix, super_prefix);
+	} else if (prefix) {
+		struct strbuf sb = STRBUF_INIT;
+		char *displaypath = xstrdup(relative_path(path, prefix, &sb));
+		strbuf_release(&sb);
+		return displaypath;
+	} else if (super_prefix) {
+		int len = strlen(super_prefix);
+		const char *format = is_dir_sep(super_prefix[len - 1]) ? "%s%s" : "%s/%s";
+
+		return xstrfmt(format, super_prefix, path);
+	} else {
+		return xstrdup(path);
+	}
+}
+
 struct module_list {
 	const struct cache_entry **entries;
 	int alloc, nr;
@@ -339,16 +361,7 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 
 	/* Only loads from .gitmodules, no overlay with .git/config */
 	gitmodules_config();
-
-	if (prefix && get_super_prefix())
-		die("BUG: cannot have prefix and superprefix");
-	else if (prefix)
-		displaypath = xstrdup(relative_path(path, prefix, &sb));
-	else if (get_super_prefix()) {
-		strbuf_addf(&sb, "%s%s", get_super_prefix(), path);
-		displaypath = strbuf_detach(&sb, NULL);
-	} else
-		displaypath = xstrdup(path);
+	displaypath = get_submodule_displaypath(path, prefix);
 
 	sub = submodule_from_path(&null_oid, path);
 
@@ -363,9 +376,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * Set active flag for the submodule being initialized
 	 */
 	if (!is_submodule_active(the_repository, path)) {
-		strbuf_reset(&sb);
 		strbuf_addf(&sb, "submodule.%s.active", sub->name);
 		git_config_set_gently(sb.buf, "true");
+		strbuf_reset(&sb);
 	}
 
 	/*
@@ -373,7 +386,6 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 	 * To look up the url in .git/config, we must not fall back to
 	 * .gitmodules, so look it up directly.
 	 */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.url", sub->name);
 	if (git_config_get_string(sb.buf, &url)) {
 		if (!sub->url)
@@ -410,9 +422,9 @@ static void init_submodule(const char *path, const char *prefix, int quiet)
 				_("Submodule '%s' (%s) registered for path '%s'\n"),
 				sub->name, url, displaypath);
 	}
+	strbuf_reset(&sb);
 
 	/* Copy "update" setting when it is not set yet */
-	strbuf_reset(&sb);
 	strbuf_addf(&sb, "submodule.%s.update", sub->name);
 	if (git_config_get_string(sb.buf, &upd) &&
 	    sub->update_strategy.type != SM_UPDATE_UNSPECIFIED) {
-- 
2.13.0

