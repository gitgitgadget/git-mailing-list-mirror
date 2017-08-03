Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9AD0B1F991
	for <e@80x24.org>; Thu,  3 Aug 2017 18:20:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752086AbdHCSUu (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Aug 2017 14:20:50 -0400
Received: from mail-pg0-f43.google.com ([74.125.83.43]:37067 "EHLO
        mail-pg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752019AbdHCSUN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Aug 2017 14:20:13 -0400
Received: by mail-pg0-f43.google.com with SMTP id y129so9272188pgy.4
        for <git@vger.kernel.org>; Thu, 03 Aug 2017 11:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FbMkFLLmVO+9nCbT74F0stMC/KSPTNYXMVbW3b5lh+E=;
        b=UdgDXT4EWjVPM3wEhjrgJzAm6W2jMhz4M760AW7wTWn3GmP1cxH/X5YSi539i4jP0A
         yvfj8jAb00Zrd+L0ROHfnaOM8b4LGxEnfqeLysls6jx5zsOngnj0hPasxR94ZtWW4c19
         X/7jmmMkxFAlxpqQJ1ULCz+5ghzzDr0i9I/pJgbJf9Z4xnCXv0zkU6G7EOuV/0fHA7JM
         52DfFu+JvknXTNWtMZnQVXaTdyBSiHmScuYU2pAIktoJti9G5RVZy7R7xWQLfNC3tfqJ
         c7+aGInz1QPdY6PsjUOOIGLPfpI3ZAO8wgN1iJrLJB0k3ltbYce0n6KvrjEV/WfTiEdC
         /82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FbMkFLLmVO+9nCbT74F0stMC/KSPTNYXMVbW3b5lh+E=;
        b=FJcn0m8a4seIjdmq/qcw3277Hv5OqAOg/UOI3oRJTjqrc6fuQ8NYb/BHd/V/1pk6+H
         xvt1/jvanBu29TDD3iF0jV3cvE4Q/GiRRJfbywXlVKHj6d54Aj0X7GT5G1cbW72o8Fg7
         g1jdaPBRXDUjWYJBibhTmVQxUNikU3/g8SxaoHZ4VUwxGDyaIFRuFU4ALkHRbOoWF8N6
         I9dr0V9ualwyg4+KgS4MvQCUyBg1bdRM0JQxaKfxzwmh/DCBEHyak0Pd86E7QAOnC1Q9
         4kQ3VOaELwsovkRUbBO6MJdDt2gQScFFenQsfouK3fvUPw8O91h9LqcrWdlUtsfduf9q
         e7BA==
X-Gm-Message-State: AIVw111liJJYseGBoFRYjFyRM/X5r1B4n3BK0gsYYlhfDELPW3jDGC31
        uCpHINzia3TvVcuwJjRJ4Q==
X-Received: by 10.84.136.1 with SMTP id 1mr2976973plk.165.1501784412744;
        Thu, 03 Aug 2017 11:20:12 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id d1sm10706293pgc.57.2017.08.03.11.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Aug 2017 11:20:10 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, gitster@pobox.com, jrnieder@gmail.com,
        Jens.Lehmann@web.de, Brandon Williams <bmwill@google.com>
Subject: [PATCH v2 04/15] submodule--helper: don't overlay config in remote_submodule_branch
Date:   Thu,  3 Aug 2017 11:19:49 -0700
Message-Id: <20170803182000.179328-5-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc1.383.gd1ce394fe2-goog
In-Reply-To: <20170803182000.179328-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
 <20170803182000.179328-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't rely on overlaying the repository's config on top of the
submodule-config, instead query the repository's config directly for the
branch field.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 builtin/submodule--helper.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 1e49ce580..f71f4270d 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -1066,17 +1066,24 @@ static int resolve_relative_path(int argc, const char **argv, const char *prefix
 static const char *remote_submodule_branch(const char *path)
 {
 	const struct submodule *sub;
+	const char *branch = NULL;
+	char *key;
+
 	gitmodules_config();
-	git_config(submodule_config, NULL);
 
 	sub = submodule_from_path(&null_oid, path);
 	if (!sub)
 		return NULL;
 
-	if (!sub->branch)
+	key = xstrfmt("submodule.%s.branch", sub->name);
+	if (repo_config_get_string_const(the_repository, key, &branch))
+		branch = sub->branch;
+	free(key);
+
+	if (!branch)
 		return "master";
 
-	if (!strcmp(sub->branch, ".")) {
+	if (!strcmp(branch, ".")) {
 		unsigned char sha1[20];
 		const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
 
@@ -1094,7 +1101,7 @@ static const char *remote_submodule_branch(const char *path)
 		return refname;
 	}
 
-	return sub->branch;
+	return branch;
 }
 
 static int resolve_remote_submodule_branch(int argc, const char **argv,
-- 
2.14.0.rc1.383.gd1ce394fe2-goog

