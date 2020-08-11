Return-Path: <SRS0=r8De=BV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D7AC433E0
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8127B206DA
	for <git@archiver.kernel.org>; Tue, 11 Aug 2020 22:52:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SK6vSAjP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHKWwf (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Aug 2020 18:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726023AbgHKWwd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Aug 2020 18:52:33 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A0DC06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:33 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id o6so352863pll.9
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 15:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=zMoE8u83hGjGVbJdMIkSCp21xQm7MB2j2LIx1Cd3GJo=;
        b=SK6vSAjPsFg7bx7tMXvFK2puTK6HF7ed63ATvHjNjXB2cyXdcL06CpxbARgdtc+QwE
         NXwvMM4goNF4kseK0d3MHqkzfvfN1rNhWJiZVmpHR7MYK3M5phk5rV5XoAxSbp/SgFpv
         na6M/SW2nX7gdTiLVWc7/Gv9z1CAcNUwMUvb9rFwOmlHKDh5nBIRehLHoZRDDTlF8dc5
         f8QqP7yDmJh6nsgNg8VaOVGy8KuFn9hz3S2iSAe5ib5DpnFVz30l4jBP7jKAAJw+DbcR
         oo+gQYEWpshTLqpvssnryA6bOeOMD54IKCGl+SEnwQzzGPB495tWOkSEsdwdFiozzU9/
         ry8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=zMoE8u83hGjGVbJdMIkSCp21xQm7MB2j2LIx1Cd3GJo=;
        b=q2zBpY2n55n6SU75QSEzt14P0Kaa8Mycu1ITUTzhv8jWj94eGmPsZoUV+XlkSQ/sHa
         3PvnJcD6iwgb5j/YAfJ9TzFILR9mcc9XxvyVmv9eTmm6ZZIPJ1ATqdK3ttiG74bhNLAN
         iVzZTmUvZVGqGd1ZipgBESIIhy82wbgdhyH2d7N+mCelcrNLfqCtGAsb54nSTiwPRUIN
         ne7OlMVr49aBiKYQ9bzIeudfHje9AAH/soDJWC3MvggSr4Yn4W+A3gpobsEsEm3y0B0a
         4lN6IYi6nitep0LpCxswJpFgY7tJWCptJVffknrwRtWpqo7iCbjgLv/dMOUGnpr7cvh2
         /FRw==
X-Gm-Message-State: AOAM530ht08ZduDtXGMDEDSRvq8SdUnkkqkHXfVitbQhKcNYuKVbaPUJ
        rYda1BMe+Q+Vi3snsNi05lTAqp5H30Fsa90wuIazP488ZEG7u7R/wzwIBaLKqdRbv51oOJ19c7x
        vVjmJATUMJrkoIP2eVf5qF3+QO0swxGaOXoJgsme+kXGQ/KlOJ7ujAYCcVuxgxdk0edI/NrHBs2
        8f
X-Google-Smtp-Source: ABdhPJz0hG4rGCs30A+hTSDhd2GRZvRoyixpkBC95Mwj0JvHOjaUNA/8m38T8TmOC0jX8MGtK9z9gvlo621KfJR55Ecs
X-Received: by 2002:a17:90a:fc86:: with SMTP id ci6mr3407977pjb.160.1597186353277;
 Tue, 11 Aug 2020 15:52:33 -0700 (PDT)
Date:   Tue, 11 Aug 2020 15:52:18 -0700
In-Reply-To: <cover.1597184948.git.jonathantanmy@google.com>
Message-Id: <8b4a522a13089ea144e922280f1c71a4ec3afa1f.1597184949.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <20200724223844.2723397-1-jonathantanmy@google.com> <cover.1597184948.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.28.0.236.gb10cc79966-goog
Subject: [PATCH v2 3/7] fetch: avoid reading submodule config until needed
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach "git fetch" to avoid reading the submodule config until necessary.
This allows users to avoid the lazy-fetching of this potentially missing
config file by specifying the --recurse-submodules=no command line
option.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c    | 10 ++++++++--
 submodule-config.c |  5 +++--
 2 files changed, 11 insertions(+), 4 deletions(-)

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
index e175dfbc38..8d65273ed2 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -776,10 +776,11 @@ struct fetch_config {
 static int gitmodules_fetch_config(const char *var, const char *value, void *cb)
 {
 	struct fetch_config *config = cb;
-	if (!strcmp(var, "submodule.fetchjobs")) {
+	if (!strcmp(var, "submodule.fetchjobs") && config->max_children) {
 		*(config->max_children) = parse_submodule_fetchjobs(var, value);
 		return 0;
-	} else if (!strcmp(var, "fetch.recursesubmodules")) {
+	} else if (!strcmp(var, "fetch.recursesubmodules") &&
+		   config->recurse_submodules) {
 		*(config->recurse_submodules) = parse_fetch_recurse_submodules_arg(var, value);
 		return 0;
 	}
-- 
2.28.0.236.gb10cc79966-goog

