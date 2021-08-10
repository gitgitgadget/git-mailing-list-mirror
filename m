Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45CF3C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AD296023E
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 11:48:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240388AbhHJLsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 07:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240282AbhHJLsT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 07:48:19 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F766C0617BD
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:41 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id 28-20020a17090a031cb0290178dcd8a4d1so1749710pje.0
        for <git@vger.kernel.org>; Tue, 10 Aug 2021 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WMd2yqKqr7Qv5eGHfw13m9TryrKC0E1cGLSWKSXxRU=;
        b=pQ/XSvkrYWDu4RcwAIJXuK6rBrGXBmhjcg35yW4iLAniJFIKsuInGw7NUyhTJMPuew
         yXShcJ0ROVgXV8S9sLj+EwURBMm0zk2o69/vHZODqQ6X65ZxjOhftQNdP2APongRKfvj
         mU4WXP4g+GjcqyHV5g+cPtb74eHNy78rtwD0iNDE/01nkBOdAUgqJAQGXijhwnJkA6Li
         bLT2g3TkResZ/9S56puT51ScxwGGyKTRu/lw2N2lRlIVesXAr7Ul2G4EeZkt6qK1Zn8X
         314F1c0Iib2vxRfvyChWzc/3Dx2vqxpTGRY0sUyP/+LIUmmJWy8hpKsWFXVd/T89yGJi
         CAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WMd2yqKqr7Qv5eGHfw13m9TryrKC0E1cGLSWKSXxRU=;
        b=imTWrHmxAdQmckJrLDgGcil8cQXElfq7T4GK19ouoKI/yxuFPt0fVB34Uw9MDAVqd2
         zd29y0EKNA58jkTtka7jgR1nKlni3b8XZsrLfofMamg6JmwI2usaaFOR1qRMQOE4uItc
         EkrkmNNdWLFLqj7bpIZaTdT0YrYfc8KqLuMHQszc9pwRJmW4e319bVZycCJJ7Rj3xUMH
         CfIySyiQdbgK7a/3v+lFfsxD+L3Uwb0AA7g3Yi6Oi+ezx+eQF9zmfi3rJa0W2OwohCIf
         HSTe0f+cI0HiYrTHannwdxdneTU7FtASsWWRmrrlt4G4tTfr+1K1teBL/COx/IqrmpyG
         S9UQ==
X-Gm-Message-State: AOAM530beNX9IQ74WIZ82wu3TJr8Ho4msASYiBnxHMYxIUfs5KqqUQ/b
        W3lClFhBz6Res6EbvG8PY7Y=
X-Google-Smtp-Source: ABdhPJyv2fy7U3fifZXjrNzmxwycB5CupSTfZBv0bY5Gb5f88lTKfifzNb+yrRKGNMCMECuvZFeSSQ==
X-Received: by 2002:aa7:8148:0:b029:31b:10b4:f391 with SMTP id d8-20020aa781480000b029031b10b4f391mr22580536pfn.69.1628596060773;
        Tue, 10 Aug 2021 04:47:40 -0700 (PDT)
Received: from atharva-on-air.Dlink ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id g19sm12410232pfc.168.2021.08.10.04.47.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Aug 2021 04:47:40 -0700 (PDT)
From:   Atharva Raykar <raykar.ath@gmail.com>
To:     raykar.ath@gmail.com
Cc:     avarab@gmail.com, christian.couder@gmail.com, congdanhqx@gmail.com,
        emilyshaffer@google.com, git@vger.kernel.org, gitster@pobox.com,
        jrnieder@gmail.com, kaartic.sivaraam@gmail.com, pc44800@gmail.com,
        periperidip@gmail.com, rafaeloliveira.cs@gmail.com,
        sunshine@sunshineco.com
Subject: [GSoC] [PATCH v5 9/9] submodule--helper: rename compute_submodule_clone_url()
Date:   Tue, 10 Aug 2021 17:16:41 +0530
Message-Id: <20210810114641.27188-10-raykar.ath@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810114641.27188-1-raykar.ath@gmail.com>
References: <20210807071613.99610-1-raykar.ath@gmail.com>
 <20210810114641.27188-1-raykar.ath@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Let's rename 'compute_submodule_clone_url()' to 'resolve_relative_url()'
to make it clear that this internal helper need not be used exclusively
for computing submodule clone URLs.

Since the original 'resolve-relative-url' subcommand and its C entry
point has been removed in c461095ae3 (submodule--helper: remove
resolve-relative-url subcommand, 2021-07-02), this rename can be done
without causing any confusion about which function it actually binds to.

Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
---
 builtin/submodule--helper.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 65591e47eb..5ab4e17e75 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -199,7 +199,7 @@ static char *relative_url(const char *remote_url,
 	return strbuf_detach(&sb, NULL);
 }
 
-static char *compute_submodule_clone_url(const char *rel_url, const char *up_path, int quiet)
+static char *resolve_relative_url(const char *rel_url, const char *up_path, int quiet)
 {
 	char *remoteurl, *resolved_url;
 	char *remote = get_default_remote();
@@ -634,7 +634,7 @@ static void init_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(url) ||
 		    starts_with_dot_slash(url)) {
 			char *oldurl = url;
-			url = compute_submodule_clone_url(oldurl, NULL, 0);
+			url = resolve_relative_url(oldurl, NULL, 0);
 			free(oldurl);
 		}
 
@@ -1355,8 +1355,8 @@ static void sync_submodule(const char *path, const char *prefix,
 		if (starts_with_dot_dot_slash(sub->url) ||
 		    starts_with_dot_slash(sub->url)) {
 			char *up_path = get_up_path(path);
-			sub_origin_url = compute_submodule_clone_url(sub->url, up_path, 1);
-			super_config_url = compute_submodule_clone_url(sub->url, NULL, 1);
+			sub_origin_url = resolve_relative_url(sub->url, up_path, 1);
+			super_config_url = resolve_relative_url(sub->url, NULL, 1);
 			free(up_path);
 		} else {
 			sub_origin_url = xstrdup(sub->url);
@@ -2098,7 +2098,7 @@ static int prepare_to_clone_next_submodule(const struct cache_entry *ce,
 	if (repo_config_get_string_tmp(the_repository, sb.buf, &url)) {
 		if (starts_with_dot_slash(sub->url) ||
 		    starts_with_dot_dot_slash(sub->url)) {
-			url = compute_submodule_clone_url(sub->url, NULL, 0);
+			url = resolve_relative_url(sub->url, NULL, 0);
 			need_free_url = 1;
 		} else
 			url = sub->url;
@@ -3025,7 +3025,7 @@ static int module_add(int argc, const char **argv, const char *prefix)
 			      "of the working tree"));
 
 		/* dereference source url relative to parent's url */
-		add_data.realrepo = compute_submodule_clone_url(add_data.repo, NULL, 1);
+		add_data.realrepo = resolve_relative_url(add_data.repo, NULL, 1);
 	} else if (is_dir_sep(add_data.repo[0]) || strchr(add_data.repo, ':')) {
 		add_data.realrepo = add_data.repo;
 	} else {
-- 
2.32.0

