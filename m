Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E2301F462
	for <e@80x24.org>; Wed, 19 Jun 2019 09:46:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731267AbfFSJqj (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 05:46:39 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:38742 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726958AbfFSJqi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 05:46:38 -0400
Received: by mail-pg1-f194.google.com with SMTP id v11so9347941pgl.5
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 02:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XfGH3BtNYY634r77KxikKtiFh/6cHjB08xJHnduOGl4=;
        b=s7I00K+oH5/6nlaaeFDFRPOSVe8aknWplwTQz0IYQIo66H4Jk6mvqpQw8nQRvq8Mgo
         bMv/aaW4jp8Sv3/AaQ7wTugB9KaBCcYa3rmaP2ssuH2qYGq6hQrdWyZCMQ9BOd0KPEIX
         2gDCRWCiElu+mFw46B9gtvxMWdcc5FPP+6buJ5lzVchfUcob8xwFCGNYjOLtNLLXbYb+
         6cxpyOAXe4mwklwwazgEaN7p6vjUSpVsKRuLYlW1kVEPCTt39234iO3Hv5NlyzFj40pS
         MrbguLAMkEyHuIPya5+9xBYZVgfntZgxdx8yfJxXad+ylViFc9Oeh/ZjoWs7FSZUHbYL
         BJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=XfGH3BtNYY634r77KxikKtiFh/6cHjB08xJHnduOGl4=;
        b=pl2P89adeRwhcqqHrrTHsq2bAmpIRsnr8ci/FBTQpy8hEFnBvvp1lRiFfR8mjhcP+V
         SgofqMvnUqHb1JwM1LdRXGsijIEflNG45Tnn0g27XUFcquB/ezniKlRqQTEHTMFKKgTC
         n8ILvs0/txHAOGoV3+1ejtIiwY/axG5D67EAs2oTzPGAqCNAEMHb7qD18V4q5t2LAK+0
         ImX4yBj1AbyTrVo4jM+EewJXdMnMO8v4y31Y/iouc0139IgrP11LOMyOQ4WdXf5MUa+L
         bn2L0v0ifjjyxbIqFsXUSEMI7n1HOGr//83ebBYX4m8Y/bpfzZTjZKAMwXj1IYlRJYsy
         F77w==
X-Gm-Message-State: APjAAAXwgQENbP6Mvrl6ChQOuF6jFqMSle9abdz4TRmKi4Y+UWawz8Yi
        r5oVHip92TIp/V5T/p06M5IMgHfA
X-Google-Smtp-Source: APXvYqzUiF8u/MrmO3EgRVPDqD1HAS5LO9v+OD4V2eSJn/7jrkWxGewuWAXVYRkWwKVlVeYgXv4Jxw==
X-Received: by 2002:a65:638e:: with SMTP id h14mr6678881pgv.86.1560937597644;
        Wed, 19 Jun 2019 02:46:37 -0700 (PDT)
Received: from ash ([115.76.181.38])
        by smtp.gmail.com with ESMTPSA id g8sm17042041pfi.8.2019.06.19.02.46.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 02:46:35 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Jun 2019 16:46:31 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] fetch: only run 'gc' once when fetching multiple remotes
Date:   Wed, 19 Jun 2019 16:46:30 +0700
Message-Id: <20190619094630.32557-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.22.0.rc0.322.g2b0371e29a
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In multiple remotes mode, git-fetch is launched for n-1 remotes and the
last remote is handled by the current process. Each of these processes
will in turn run 'gc' at the end.

This is not really a problem because even if multiple 'gc --auto' is run
at the same time we still handle it correctly. It does show multiple
"auto packing in the background" messages though. And we may waste some
resources when gc actually runs because we still do some stuff before
checking the lock and moving it to background.

So let's try to avoid that. We should only need one 'gc' run after all
objects and references are added anyway. Add a new option --no-auto-gc
that will be used by those n-1 processes. 'gc --auto' will always run on
the main fetch process (*).

(*) even if we fetch remotes in parallel at some point in future, this
    should still be fine because we should "join" all those processes
    before this step.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Documentation/fetch-options.txt |  4 ++++
 builtin/fetch.c                 | 17 +++++++++++------
 t/t5514-fetch-multiple.sh       |  7 +++++--
 3 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 91c47752ec..592f391298 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -88,6 +88,10 @@ ifndef::git-pull[]
 	Allow several <repository> and <group> arguments to be
 	specified. No <refspec>s may be specified.
 
+--[no-]auto-gc::
+	Run `git gc --auto` at the end to perform garbage collection
+	if needed. This is enabled by default.
+
 -p::
 --prune::
 	Before fetching, remove any remote-tracking references that no
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ba63d5ac6..6a3c507897 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -48,6 +48,7 @@ static int prune_tags = -1; /* unspecified */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen_relative;
 static int progress = -1;
+static int enable_auto_gc = 1;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow, deepen;
 static int max_children = 1;
 static enum transport_family family;
@@ -169,6 +170,8 @@ static struct option builtin_fetch_options[] = {
 	OPT_STRING_LIST(0, "negotiation-tip", &negotiation_tip, N_("revision"),
 			N_("report that we have only objects reachable from this object")),
 	OPT_PARSE_LIST_OBJECTS_FILTER(&filter_options),
+	OPT_BOOL(0, "auto-gc", &enable_auto_gc,
+		 N_("run 'gc --auto' after fetching")),
 	OPT_END()
 };
 
@@ -1424,7 +1427,7 @@ static int fetch_multiple(struct string_list *list)
 			return errcode;
 	}
 
-	argv_array_pushl(&argv, "fetch", "--append", NULL);
+	argv_array_pushl(&argv, "fetch", "--append", "--no-auto-gc", NULL);
 	add_options_to_argv(&argv);
 
 	for (i = 0; i < list->nr; i++) {
@@ -1674,11 +1677,13 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 	close_all_packs(the_repository->objects);
 
-	argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
-	if (verbosity < 0)
-		argv_array_push(&argv_gc_auto, "--quiet");
-	run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
-	argv_array_clear(&argv_gc_auto);
+	if (enable_auto_gc) {
+		argv_array_pushl(&argv_gc_auto, "gc", "--auto", NULL);
+		if (verbosity < 0)
+			argv_array_push(&argv_gc_auto, "--quiet");
+		run_command_v_opt(argv_gc_auto.argv, RUN_GIT_CMD);
+		argv_array_clear(&argv_gc_auto);
+	}
 
 	return result;
 }
diff --git a/t/t5514-fetch-multiple.sh b/t/t5514-fetch-multiple.sh
index 0030c92e1a..5426d4b5ab 100755
--- a/t/t5514-fetch-multiple.sh
+++ b/t/t5514-fetch-multiple.sh
@@ -105,9 +105,12 @@ test_expect_success 'git fetch --multiple (two remotes)' '
 	 git remote rm origin &&
 	 git remote add one ../one &&
 	 git remote add two ../two &&
-	 git fetch --multiple one two &&
+	 GIT_TRACE=1 git fetch --multiple one two 2>trace &&
 	 git branch -r > output &&
-	 test_cmp ../expect output)
+	 test_cmp ../expect output &&
+	 grep "built-in: git gc" trace >gc &&
+	 test_line_count = 1 gc
+	)
 '
 
 test_expect_success 'git fetch --multiple (bad remote names)' '
-- 
2.22.0.rc0.322.g2b0371e29a

