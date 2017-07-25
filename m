Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 671D51F89D
	for <e@80x24.org>; Tue, 25 Jul 2017 21:39:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751800AbdGYVju (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jul 2017 17:39:50 -0400
Received: from mail-pg0-f49.google.com ([74.125.83.49]:35879 "EHLO
        mail-pg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbdGYVjr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jul 2017 17:39:47 -0400
Received: by mail-pg0-f49.google.com with SMTP id 125so75321279pgi.3
        for <git@vger.kernel.org>; Tue, 25 Jul 2017 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6h5j/HS9ibfFExWV3o6qbZNtExJT3cIs57KmMR70nDA=;
        b=btJ3qmLZ0UEYcfBGpy5sZo+eVb/ukY0X0NgOd18uptMTRGRPKsNIqwz0YqHOim2Hxn
         pSD+LIMY70L88qtnaqAqXiHfpRai0n//v6mWBPsmC52VZpOUzQOqaKOhQLiq6VLYl6k3
         6fbkHmaPAhYeUQ3slNJuuwtqJGG3uv42P1Jf92aOFimGJTUYZMcKg9FPUtgFnHC+oJQ8
         nzpPCoUn8VtknBY1qF3Kq2PzzK44AY/eleaybkipS8SH0T1quIPKbOLBEWRd0hlgEnPQ
         00C4zhTI3aH46SBM6LhOq7EYRCHD0XZ2+XM/L+9KCCc9VICqfa1PSfl2xPSMcqw/88X9
         /uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6h5j/HS9ibfFExWV3o6qbZNtExJT3cIs57KmMR70nDA=;
        b=mzgXhMMQgbC/E6e4DN2OQ+Khs/2mZ1Efnq2+4bf9PBOqTT0PkXOcH7o07McVov6V0D
         R7k82Cof6al9OThXYPevaeSROA/MNXFY79I0XIugKahcugYK04FEorWbefX3NZrZqKXj
         kYzgLKsIsw4HqmQv6E97ETmTpO5WFXmen5F1/nNoGDZeGgVjwTpm+aXLrrCTO7HM7IFt
         Ve9MfIb8E/AcT2W5zVl0h9GcSZYd/Rj4ikfT3tA9y3TKza1BZvVK0mZrGKDtvVIMZW85
         NOrpDiE8EyjCajqLG5gmeYY1xR4QtG3VgzsJc7TRG08LdB1ackxPyf7ywoMUqDsCA7tr
         jVYQ==
X-Gm-Message-State: AIVw112G+DNrPTBYT4SyB+EbzW5WEc/HCkZslFwi8OkgvxNaAd5Dxgha
        0mnjW6bfShiZoqj0Wz5Rvg==
X-Received: by 10.99.18.65 with SMTP id 1mr20654862pgs.132.1501018786281;
        Tue, 25 Jul 2017 14:39:46 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id m186sm27068839pfc.54.2017.07.25.14.39.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 25 Jul 2017 14:39:45 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [PATCH 04/15] submodule--helper: don't overlay config in remote_submodule_branch
Date:   Tue, 25 Jul 2017 14:39:17 -0700
Message-Id: <20170725213928.125998-5-bmwill@google.com>
X-Mailer: git-send-email 2.14.0.rc0.400.g1c36432dff-goog
In-Reply-To: <20170725213928.125998-1-bmwill@google.com>
References: <20170725213928.125998-1-bmwill@google.com>
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
2.14.0.rc0.400.g1c36432dff-goog

