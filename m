Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA48C4361B
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 893B322597
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 06:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728114AbgLDGR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 01:17:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgLDGR7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 01:17:59 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3489EC08E85F
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 22:16:42 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id t143so5013845oif.10
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 22:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TEzwLjbmSnTJQosFhHvBja9SD2pcRvmyFnA6PY+Y8t4=;
        b=Mz7oi1aENBDLk5Ph/Qx0siGH8Wc3BEgxM3t/eFu1FKniZoYYe9zhzRMD9e6Mfh6hGj
         4XxybBu+DtBmo1sZZEdtPatAij2kbt80Mge8d5kFv1lM53rre7QiNnpapSjwlOI3rjWv
         ZTU01SrDlsaystxLmvE2GIrfvo5wMD7WCv8hZNNwju7/DWeNuKo0r6xCZ7lmWYqjlPnv
         rUpu/3RDd1ZwZ4+GgLReSM3ON1JESWKVzNaklZGbemD1c6/WlrRn0kR51TqaoOGP7yek
         xCG9Uy8ZERe5Y8YDu8u+pRNbhpwoG1muQMqysl+WrPYLuKuLJvXWydu3TLBnMXaBRDF2
         iqMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TEzwLjbmSnTJQosFhHvBja9SD2pcRvmyFnA6PY+Y8t4=;
        b=mDXAU0xGO80MRu/6+baNMGRhE2V5i7nbUscGSa7SsIIh3mtFzf7O/bAKc72N6fmpoB
         2hbwT/O1FtRsv8RUw1/0tnuF/RNDcQbd5bzFent7tPBvbNJiV2RfbKIc3YGtfdrVh7Ss
         iHHOidJWC9rrs5xqO+98zrZNQzYsL9QWDuJKeyMJvVWJD3LI44kjBwKqsqL3q/aTjggt
         LkjI6wXc1jvcJbw2ogavKu5jWhinxy+ZqYoj5G8EL8E4b0/Y45NpNkwi9XgKnDIRXdRT
         LB81DCwpNzg+S9wB8NrNgFMtkr0ECDm/h6wiy7ltl+TzY6u1SVFZC5Xh6uNqH8AQY/wM
         GXGA==
X-Gm-Message-State: AOAM533xpQEhPvpSZSb7s+WOdLaYV041k4iZ/rO65N/UaKM7OdsCLa13
        41e5esYljwCEVnVB6e85Efud7x/qfsUsaQ==
X-Google-Smtp-Source: ABdhPJzDuDoJgOCfkuZfTMbtDrTV0uyBS3tSLfUsxGz513ZEJt+mikhBUgL7ndaKGkqqfXYKEm6/3Q==
X-Received: by 2002:aca:5453:: with SMTP id i80mr2114521oib.2.1607062601402;
        Thu, 03 Dec 2020 22:16:41 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id l12sm471241ooe.27.2020.12.03.22.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:16:40 -0800 (PST)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?V=C3=ADt=20Ondruch?= <vondruch@redhat.com>,
        Alex Henrie <alexhenrie24@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        "Theodore Y . Ts'o" <tytso@mit.edu>,
        Jacob Keller <jacob.keller@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Richard Hansen <rhansen@rhansen.org>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        "W. Trevor King" <wking@tremily.us>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 09/14] pull: introduce --merge option
Date:   Fri,  4 Dec 2020 00:16:18 -0600
Message-Id: <20201204061623.1170745-10-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201204061623.1170745-1-felipe.contreras@gmail.com>
References: <20201204061623.1170745-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously --no-rebase (which still works for backwards compatbility).

Now we can update the default warning, and the git-pull(1) man page to
use --merge instead of the non-intuitive --no-rebase.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 Documentation/git-pull.txt   | 9 ++++++---
 builtin/pull.c               | 4 +++-
 t/t7601-merge-pull-config.sh | 4 ++--
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pull.txt b/Documentation/git-pull.txt
index ad33d2472c..c220da143a 100644
--- a/Documentation/git-pull.txt
+++ b/Documentation/git-pull.txt
@@ -61,7 +61,7 @@ However, a non-fast-foward case looks very different.
 ------------
 
 By default `git pull` will warn about these situations, however, most likely
-you would want to force a merge, which you can do with `git pull --no-rebase`.
+you would want to force a merge, which you can do with `git pull --merge`.
 
 Then "`git pull`" will fetch and replay the changes from the remote
 `master` branch since it diverged from the local `master` (i.e., `E`)
@@ -148,8 +148,11 @@ It rewrites history, which does not bode well when you
 published that history already.  Do *not* use this option
 unless you have read linkgit:git-rebase[1] carefully.
 
---no-rebase::
-	Override earlier --rebase.
+-m::
+--merge::
+	Force a merge.
++
+Previously this was --no-rebase, but that usage has been deprecated.
 
 Options related to fetching
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/pull.c b/builtin/pull.c
index b200f7544c..6ea95c9fc9 100644
--- a/builtin/pull.c
+++ b/builtin/pull.c
@@ -131,6 +131,8 @@ static struct option pull_options[] = {
 		"(false|true|merges|preserve|interactive)",
 		N_("incorporate changes by rebasing rather than merging"),
 		PARSE_OPT_OPTARG, parse_opt_rebase),
+	OPT_SET_INT('m', "merge", &opt_rebase,
+		N_("incorporate changes by merging"), 0),
 	OPT_PASSTHRU('n', NULL, &opt_diffstat, NULL,
 		N_("do not show a diffstat at the end of the merge"),
 		PARSE_OPT_NOARG | PARSE_OPT_NONEG),
@@ -1024,7 +1026,7 @@ int cmd_pull(int argc, const char **argv, const char *prefix)
 			"\n"
 			"You can replace \"git config\" with \"git config --global\" to set a default\n"
 			"preference for all repositories.\n"
-			"If unsure, run \"git pull --no-rebase\".\n"
+			"If unsure, run \"git pull --merge\".\n"
 			"Read \"git pull --help\" for more information."
 			));
 	}
diff --git a/t/t7601-merge-pull-config.sh b/t/t7601-merge-pull-config.sh
index 6b4adab8b1..1de64e6cc5 100755
--- a/t/t7601-merge-pull-config.sh
+++ b/t/t7601-merge-pull-config.sh
@@ -69,9 +69,9 @@ test_expect_success 'pull.rebase not set and --rebase given' '
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-test_expect_success 'pull.rebase not set and --no-rebase given' '
+test_expect_success 'pull.rebase not set and --merge given' '
 	git reset --hard c2 &&
-	git pull --no-rebase . c1 2>err &&
+	git pull --merge . c1 2>err &&
 	test_i18ngrep ! "Pulling without specifying how to reconcile" err
 '
 
-- 
2.29.2

