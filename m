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
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADD33C48BCD
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C94D613FE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 19:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbhFITcK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 15:32:10 -0400
Received: from mail-oi1-f173.google.com ([209.85.167.173]:36518 "EHLO
        mail-oi1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbhFITcI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 15:32:08 -0400
Received: by mail-oi1-f173.google.com with SMTP id a21so26265504oiw.3
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 12:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zGFFGAFQ5vVRP5dlLhyMbBL6ZllOMkvKR1U/z7h6pxM=;
        b=sQ6Xgmu3Qb4tqWMcIvcP+B9efgxvEWuvpwHtqiSV05xO77mFWsd0rx6N4pSTAZdaSD
         qzTg9w3Z06O/o3vCM1duBx7X3edmk4XzXSSqYSm/J6xK/7xOmTz6Lgb3cc3lTcYG2vHu
         K5TyRcr+bvNvlhUcw/oD3063eeSrMargPF/K37D41XQZJOso4UnHlXvPyL41F47VaSHh
         Pi+hF+2sN/0HHRSV6HKoxMOcGmDJ2W+sLk+xb0jIBIWEXiesWUveLi7GaAI7zJe6v7A5
         /WtYkF0/24J8TAJ3pLpaezHa9ly2+VVW012Sbapc6/QDfxFLkvLqQQmCiNUdgIoqpMmp
         /ddw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zGFFGAFQ5vVRP5dlLhyMbBL6ZllOMkvKR1U/z7h6pxM=;
        b=cfRUMkEajwaDhIo32wWDLjdodQd4IlXSQkzigNKgGXymrmii4fG6p4AtyYyh/B2sYb
         OQh88XbGQHr/7jJuiieOZ407mDWYpYc6QL2z7ncheDbvLWIuKMfhia53Faa9U/dP8iBq
         nwk/rKvy2V1kEssGwqhiJp3+8eHzpNr/Zi93m3sFts21er3G1SuSESRLR6EzsqLQIlIo
         NgxczSM+qOWZ6PgE4icRvX7/JnNtYoEY0whCdIJS0VVNxPEfbUVVJNb5kx8+6QUnmlv4
         ei2N8KWoaF9SGzVCSKSMj7Wl0Db+jI9Nfkj6ycNBQnR8kfNq7ebKFc2FVUVMcJdR7g/e
         dHJw==
X-Gm-Message-State: AOAM530GVe0aj7qucFtHBbqdJmqwQUyF40/am/6z3+ZvDS8Ulj2T/4aK
        ezTzeWWBTYWp3gSkQ3ew+46dUUUTHNdp7w==
X-Google-Smtp-Source: ABdhPJwrf+kGR3UNVH+Upl7vtjAcBU4KwlnU5ZKYH3txjE5PvbBgSHZCc8rfrxy3/uSFi+rHJfklXw==
X-Received: by 2002:a05:6808:985:: with SMTP id a5mr7477585oic.42.1623266941051;
        Wed, 09 Jun 2021 12:29:01 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id p25sm128446ood.4.2021.06.09.12.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Jun 2021 12:29:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     David Aguilar <davvid@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Sergey Organov <sorganov@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/7] checkout: fix merge.conflictstyle handling
Date:   Wed,  9 Jun 2021 14:28:39 -0500
Message-Id: <20210609192842.696646-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.2.g41be0a4e50
In-Reply-To: <20210609192842.696646-1-felipe.contreras@gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently both merge.conflictStyle and `git commit --merge
--conflict=diff3` don't work together, since the former wrongly
overrides the later.

The way merge configurations are handled is not correct.
It should be possible to do git_config(merge_recursive_config, ...) just
like we can with git_diff_basic_config and others.

Therefore builtins like `git merge` can't call this function at the
right time.

We shuffle the functions a little bit so at least merge_recursive_config
doesn't call git_xmerge_config directly and thus override previous
configurations.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/merge-recursive.c          |  3 +++
 builtin/merge.c                    |  4 ++++
 merge-recursive.c                  |  2 +-
 sequencer.c                        |  5 +++++
 t/t6440-config-conflict-markers.sh | 31 ++++++++++++++++++++++++++++++
 5 files changed, 44 insertions(+), 1 deletion(-)

diff --git a/builtin/merge-recursive.c b/builtin/merge-recursive.c
index a4bfd8fc51..80f9279b4c 100644
--- a/builtin/merge-recursive.c
+++ b/builtin/merge-recursive.c
@@ -4,6 +4,7 @@
 #include "tag.h"
 #include "merge-recursive.h"
 #include "xdiff-interface.h"
+#include "config.h"
 
 static const char builtin_merge_recursive_usage[] =
 	"git %s <base>... -- <head> <remote> ...";
@@ -30,6 +31,8 @@ int cmd_merge_recursive(int argc, const char **argv, const char *prefix)
 	char *better1, *better2;
 	struct commit *result;
 
+	git_config(git_xmerge_config, NULL);
+
 	init_merge_options(&o, the_repository);
 	if (argv[0] && ends_with(argv[0], "-subtree"))
 		o.subtree_shift = "";
diff --git a/builtin/merge.c b/builtin/merge.c
index eddb8ae70d..7aa3dbb111 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -43,6 +43,7 @@
 #include "commit-reach.h"
 #include "wt-status.h"
 #include "commit-graph.h"
+#include "xdiff-interface.h"
 
 #define DEFAULT_TWOHEAD (1<<0)
 #define DEFAULT_OCTOPUS (1<<1)
@@ -659,6 +660,9 @@ static int git_merge_config(const char *k, const char *v, void *cb)
 	if (status)
 		return status;
 	status = git_gpg_config(k, v, NULL);
+	if (status)
+		return status;
+	status = git_xmerge_config(k, v, NULL);
 	if (status)
 		return status;
 	return git_diff_ui_config(k, v, cb);
diff --git a/merge-recursive.c b/merge-recursive.c
index d146bb116f..10e6e1e4d1 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -3845,7 +3845,7 @@ static void merge_recursive_config(struct merge_options *opt)
 		} /* avoid erroring on values from future versions of git */
 		free(value);
 	}
-	git_config(git_xmerge_config, NULL);
+	git_config(git_default_config, NULL);
 }
 
 void init_merge_options(struct merge_options *opt,
diff --git a/sequencer.c b/sequencer.c
index 0bec01cf38..9e2bdca0f6 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -34,6 +34,7 @@
 #include "commit-reach.h"
 #include "rebase-interactive.h"
 #include "reset.h"
+#include "xdiff-interface.h"
 
 #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
 
@@ -224,6 +225,10 @@ static int git_sequencer_config(const char *k, const char *v, void *cb)
 	if (status)
 		return status;
 
+	status = git_xmerge_config(k, v, NULL);
+	if (status)
+		return status;
+
 	return git_diff_basic_config(k, v, NULL);
 }
 
diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index 44f79ac91b..485ad0eee0 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -89,4 +89,35 @@ test_expect_success 'notes' '
 	)
 '
 
+test_expect_success 'checkout' '
+	test_create_repo checkout &&
+	(
+		test_commit checkout &&
+
+		fill a b c d e >content &&
+		git add content &&
+		git commit -m initial &&
+
+		git checkout -b simple master &&
+		fill a c e >content &&
+		git commit -a -m simple &&
+
+		fill b d >content &&
+		git checkout --merge master &&
+		! grep -E "\|+" content &&
+
+		git config merge.conflictstyle merge &&
+
+		git checkout -f simple &&
+		fill b d >content &&
+		git checkout --merge --conflict=diff3 master &&
+		grep -E "\|+" content &&
+
+		git checkout -f simple &&
+		fill b d >content &&
+		git checkout --merge --conflict=merge master &&
+		! grep -E "\|+" content
+	)
+'
+
 test_done
-- 
2.32.0.2.g41be0a4e50

