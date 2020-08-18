Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DAF3C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49501207D3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:25:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lwWtDBs+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgHROZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHROZf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:25:35 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 428F8C061342
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:35 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p20so18492558wrf.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jYgqkLLflNd7h+6/tcXLxlqF6ut+j9/Y+I7yuqUTRrE=;
        b=lwWtDBs+AXATBRRTKgiOzZAy4ZvjFPvrqG+sbDztBJ31JpNDD2Xq30YO325/76Tmak
         LGL6zDaEXd1qZIlJbO3vBQw8TxdB2S4hgTrOfYju1wwDBdt+PSJWRlmqsNxkXceqnjWF
         E3V32Z3cWE9KW1xTWJCWwiALSXIa4G+sysaJbjWpGb5+JnFcDe5PN2knoZk+PtPH+Z8E
         2AWmVmzqAU9TNOdIYxmEUZI2kKeHUgbr0QPpncr23rJ4SCBvpTkTVffBvgtVAXSVJ8N7
         VbsBLA2IdLZYy0V5jdiZnxoigZGCseo+mdeG4V2pjUNo4zh95Zk6YyY9budrmZvbiVWt
         8KCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jYgqkLLflNd7h+6/tcXLxlqF6ut+j9/Y+I7yuqUTRrE=;
        b=ZDTJ4UzJHUefVnoKcJtgWVm/EwRYvSK8ZnoumnL0jXc0HLHO0eawHfnqxOb3Tf2/9k
         WxjaUyJ9Fob5hfRBdWZOCRNMO6ylTEKp9deIgSevsAdyqKn38G9Xr96HrIPjHERX/ZAi
         d0F5Cu+3A1JFPC4Tt7//T3wInXe9K+Ts3n0GRBbGKSd7HSFU66/kly/q9Ziz/WYuR56o
         TwJRgXWIBT9/6TWdZcB9c6LNnn+0NSt+etcjzEFii1f4Zyvo7ggYo98gfwwAteeRIMjT
         PuCLsosYooptHzNyNIqSgMMlN8WtySp1YyhJVN6XuhPz0b/24BUkpEbQ1+7z5WQdv0v2
         ei5g==
X-Gm-Message-State: AOAM532g83/OSuq4HN0tOLbOGE+7edeO1ZgBjF2gNDpCbt2N1R0ZMjNX
        piUVH5NT4a7iS6K4Ayjq8NS7GR0tViI=
X-Google-Smtp-Source: ABdhPJx+kKm9Nh3xZgA15dJNKrjI+iorjcBdXUn9EePvrpLyQcy5N7+lkbyByGt3DIk9Pr7LHYrOTw==
X-Received: by 2002:a5d:6681:: with SMTP id l1mr19732746wru.47.1597760733564;
        Tue, 18 Aug 2020 07:25:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f17sm46705wru.13.2020.08.18.07.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:25:32 -0700 (PDT)
Message-Id: <f3bc0b2d921a88e4a19f80645cfac5c5039a0450.1597760730.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
References: <pull.696.git.1596731424.gitgitgadget@gmail.com>
        <pull.696.v2.git.1597760730.gitgitgadget@gmail.com>
From:   "Junio C Hamano via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:25:22 +0000
Subject: [PATCH v2 1/9] fetch: optionally allow disabling FETCH_HEAD update
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Junio C Hamano <gitster@pobox.com>

If you run fetch but record the result in remote-tracking branches,
and either if you do nothing with the fetched refs (e.g. you are
merely mirroring) or if you always work from the remote-tracking
refs (e.g. you fetch and then merge origin/branchname separately),
you can get away with having no FETCH_HEAD at all.

Teach "git fetch" a command line option "--[no-]write-fetch-head".
The default is to write FETCH_HEAD, and the option is primarily
meant to be used with the "--no-" prefix to override this default,
because there is no matching fetch.writeFetchHEAD configuration
variable to flip the default to off (in which case, the positive
form may become necessary to defeat it).

Note that under "--dry-run" mode, FETCH_HEAD is never written;
otherwise you'd see list of objects in the file that you do not
actually have.  Passing `--write-fetch-head` does not force `git
fetch` to write the file.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/fetch-options.txt |  9 +++++++++
 builtin/fetch.c                 | 15 ++++++++++++---
 t/t5510-fetch.sh                | 15 +++++++++++++--
 t/t5521-pull-options.sh         |  7 +++++++
 4 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 495bc8ab5a..b65a758661 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -64,6 +64,15 @@ documented in linkgit:git-config[1].
 --dry-run::
 	Show what would be done, without making any changes.
 
+ifndef::git-pull[]
+--[no-]write-fetch-head::
+	Write the list of remote refs fetched in the `FETCH_HEAD`
+	file directly under `$GIT_DIR`.  This is the default.
+	Passing `--no-write-fetch-head` from the command line tells
+	Git not to write the file.  Under `--dry-run` option, the
+	file is never written.
+endif::git-pull[]
+
 -f::
 --force::
 	When 'git fetch' is used with `<src>:<dst>` refspec it may
diff --git a/builtin/fetch.c b/builtin/fetch.c
index c8b9366d3c..cb38e6f5ec 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -56,6 +56,7 @@ static int prune_tags = -1; /* unspecified */
 #define PRUNE_TAGS_BY_DEFAULT 0 /* do we prune tags by default? */
 
 static int all, append, dry_run, force, keep, multiple, update_head_ok;
+static int write_fetch_head = 1;
 static int verbosity, deepen_relative, set_upstream;
 static int progress = -1;
 static int enable_auto_gc = 1;
@@ -162,6 +163,8 @@ static struct option builtin_fetch_options[] = {
 		    PARSE_OPT_OPTARG, option_fetch_parse_recurse_submodules),
 	OPT_BOOL(0, "dry-run", &dry_run,
 		 N_("dry run")),
+	OPT_BOOL(0, "write-fetch-head", &write_fetch_head,
+		 N_("write fetched references to the FETCH_HEAD file")),
 	OPT_BOOL('k', "keep", &keep, N_("keep downloaded pack")),
 	OPT_BOOL('u', "update-head-ok", &update_head_ok,
 		    N_("allow updating of HEAD ref")),
@@ -895,7 +898,9 @@ static int store_updated_refs(const char *raw_url, const char *remote_name,
 	const char *what, *kind;
 	struct ref *rm;
 	char *url;
-	const char *filename = dry_run ? "/dev/null" : git_path_fetch_head(the_repository);
+	const char *filename = (!write_fetch_head
+				? "/dev/null"
+				: git_path_fetch_head(the_repository));
 	int want_status;
 	int summary_width = transport_summary_width(ref_map);
 
@@ -1329,7 +1334,7 @@ static int do_fetch(struct transport *transport,
 	}
 
 	/* if not appending, truncate FETCH_HEAD */
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		retcode = truncate_fetch_head();
 		if (retcode)
 			goto cleanup;
@@ -1596,7 +1601,7 @@ static int fetch_multiple(struct string_list *list, int max_children)
 	int i, result = 0;
 	struct strvec argv = STRVEC_INIT;
 
-	if (!append && !dry_run) {
+	if (!append && write_fetch_head) {
 		int errcode = truncate_fetch_head();
 		if (errcode)
 			return errcode;
@@ -1797,6 +1802,10 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	if (depth || deepen_since || deepen_not.nr)
 		deepen = 1;
 
+	/* FETCH_HEAD never gets updated in --dry-run mode */
+	if (dry_run)
+		write_fetch_head = 0;
+
 	if (all) {
 		if (argc == 1)
 			die(_("fetch --all does not take a repository argument"));
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 9850ecde5d..5bd1f953af 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -539,13 +539,24 @@ test_expect_success 'fetch into the current branch with --update-head-ok' '
 
 '
 
-test_expect_success 'fetch --dry-run' '
-
+test_expect_success 'fetch --dry-run does not touch FETCH_HEAD' '
 	rm -f .git/FETCH_HEAD &&
 	git fetch --dry-run . &&
 	! test -f .git/FETCH_HEAD
 '
 
+test_expect_success '--no-write-fetch-head does not touch FETCH_HEAD' '
+	rm -f .git/FETCH_HEAD &&
+	git fetch --no-write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
+test_expect_success '--write-fetch-head gets defeated by --dry-run' '
+	rm -f .git/FETCH_HEAD &&
+	git fetch --dry-run --write-fetch-head . &&
+	! test -f .git/FETCH_HEAD
+'
+
 test_expect_success "should be able to fetch with duplicate refspecs" '
 	mkdir dups &&
 	(
diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
index 159afa7ac8..db1a381cd9 100755
--- a/t/t5521-pull-options.sh
+++ b/t/t5521-pull-options.sh
@@ -85,6 +85,13 @@ test_expect_success 'git pull --cleanup errors early on invalid argument' '
 	test -s err)
 '
 
+test_expect_success 'git pull --no-write-fetch-head fails' '
+	mkdir clonedwfh &&
+	(cd clonedwfh && git init &&
+	test_expect_code 129 git pull --no-write-fetch-head "../parent" >out 2>err &&
+	test_must_be_empty out &&
+	test_i18ngrep "no-write-fetch-head" err)
+'
 
 test_expect_success 'git pull --force' '
 	mkdir clonedoldstyle &&
-- 
gitgitgadget

