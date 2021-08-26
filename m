Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FCAEC432BE
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:10:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25DEF60F5B
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 19:10:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243386AbhHZTLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhHZTLD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 15:11:03 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7773C061757
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 12:10:15 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id r21so3372724qtw.11
        for <git@vger.kernel.org>; Thu, 26 Aug 2021 12:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=84y4i0I5iEgtw/rf+l8IrH5i/6huzGsOz3eFR6sddbo=;
        b=h9yfAl0APNpXC/dRzpByK25pINqkfvOSTIhgw5B/ggj+w6d/8oHzE4od1cgSQ0axea
         bDMkLc0xSnPU04QehlAeHYQtEh1ivRUsT7ijuPT9be7YE7HpII0Q5GOyGy5/zH8gpqv7
         br6JVsMji4wMBr1OJNUxWfS/FdMTNnhr79a8vqEyCR6l7R7+bTzZuYSaof4870r6l9oZ
         x8HWUXoARfKoqk3iq7tcWHS13yej/+gc82ZdhglLGEJ3RGh+9kmmOXHOtxFcipEBZPeO
         OQRnVdMN3Umle5w7lVdeWKAgujZRgMJZRb2s5ebwcV6WkDyL7n4N70oXtc52VAbcdPO4
         0Fhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=84y4i0I5iEgtw/rf+l8IrH5i/6huzGsOz3eFR6sddbo=;
        b=qisrVcR0cN2k2qvEPt2CvWyJnSVB1zv3QDya/flE4/G510WlCcSReX4SbE4fTUajap
         iqqk8D5y0BW04eav/bLka82knxRku689SJy13m5sGVAiqQ34aUDqGp1RRARMwHbAhzzn
         CLTLQN+l4YadY/A0UfSmtVnnIngGS7Cv38SFLdlmV92i4fZiS7XNGWm0xO6iM9tosumO
         QzdXTNmVhDMosu4xMqxlZSvtAFwSemRXlryzGR+2h5MAEGg1Y8kzBs7Y/ZYXEXmaNxDE
         jbmpYO3Z1Qs/MT2frGGNdsF0l/ogtQ9puw58JWAPNRPYPraU5Q2U+Ia+h5mogB1RBojW
         7KlQ==
X-Gm-Message-State: AOAM533EGF6/qe8GT0YwIedRHhgL+daXQZNJO9b6BXFAfxgzht8RAaOq
        mY4Ay8kFqFdPgBlIoNMyON6Q0g==
X-Google-Smtp-Source: ABdhPJxTbLpyfzU5ux+nCkGqUJ8GYKqgKWkA9rO0KQWHRQWJXbwjbsMYk7bsPZV+KHVIS0b6XoxuGg==
X-Received: by 2002:ac8:6bcc:: with SMTP id b12mr4672750qtt.243.1630005014938;
        Thu, 26 Aug 2021 12:10:14 -0700 (PDT)
Received: from mango.meuintelbras.local ([177.32.116.19])
        by smtp.gmail.com with ESMTPSA id r128sm3108551qke.98.2021.08.26.12.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:10:14 -0700 (PDT)
From:   Matheus Tavares <matheus.bernardino@usp.br>
To:     matheus.bernardino@usp.br
Cc:     allred.sean@gmail.com, git@vger.kernel.org,
        larsxschneider@gmail.com, peff@peff.net, avarab@gmail.com
Subject: [PATCH v2] checkout: make delayed checkout respect --quiet and --no-progress
Date:   Thu, 26 Aug 2021 16:10:06 -0300
Message-Id: <f3ac3246254c99e6ecb4a4578022d04324691c63.1630004263.git.matheus.bernardino@usp.br>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <d1405b781915c085ac8a8965dadf3efbe1b0f6aa.1629915330.git.matheus.bernardino@usp.br>
References: <d1405b781915c085ac8a8965dadf3efbe1b0f6aa.1629915330.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The 'Filtering contents...' progress report from delayed checkout is
displayed even when checkout and clone are invoked with --quiet or
--no-progress. Furthermore, it is displayed unconditionally, without
first checking whether stdout is a tty. Let's fix these issues and also
add some regression tests for the two code paths that currently use
delayed checkout: unpack_trees.c:check_updates() and
builtin/checkout.c:checkout_worktree().

Signed-off-by: Matheus Tavares <matheus.bernardino@usp.br>
---

Changes since v1:

- Exctract duplicated code from the different test cases into an
  auxiliary function.
- Split test that do not depend on TTY. 

 builtin/checkout.c    |  2 +-
 entry.c               |  7 +++--
 entry.h               |  3 +-
 t/t0021-conversion.sh | 71 +++++++++++++++++++++++++++++++++++++++++++
 unpack-trees.c        |  2 +-
 5 files changed, 80 insertions(+), 5 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index b5d477919a..b23bc149d1 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -404,7 +404,7 @@ static int checkout_worktree(const struct checkout_opts *opts,
 	mem_pool_discard(&ce_mem_pool, should_validate_cache_entries());
 	remove_marked_cache_entries(&the_index, 1);
 	remove_scheduled_dirs();
-	errs |= finish_delayed_checkout(&state, &nr_checkouts);
+	errs |= finish_delayed_checkout(&state, &nr_checkouts, opts->show_progress);
 
 	if (opts->count_checkout_paths) {
 		if (nr_unmerged)
diff --git a/entry.c b/entry.c
index 125fabdbd5..044e8ec92c 100644
--- a/entry.c
+++ b/entry.c
@@ -159,7 +159,8 @@ static int remove_available_paths(struct string_list_item *item, void *cb_data)
 	return !available;
 }
 
-int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
+			    int show_progress)
 {
 	int errs = 0;
 	unsigned delayed_object_count;
@@ -173,7 +174,9 @@ int finish_delayed_checkout(struct checkout *state, int *nr_checkouts)
 
 	dco->state = CE_RETRY;
 	delayed_object_count = dco->paths.nr;
-	progress = start_delayed_progress(_("Filtering content"), delayed_object_count);
+	progress = show_progress
+		? start_delayed_progress(_("Filtering content"), delayed_object_count)
+		: NULL;
 	while (dco->filters.nr > 0) {
 		for_each_string_list_item(filter, &dco->filters) {
 			struct string_list available_paths = STRING_LIST_INIT_NODUP;
diff --git a/entry.h b/entry.h
index b8c0e170dc..7c889e58fd 100644
--- a/entry.h
+++ b/entry.h
@@ -43,7 +43,8 @@ static inline int checkout_entry(struct cache_entry *ce,
 }
 
 void enable_delayed_checkout(struct checkout *state);
-int finish_delayed_checkout(struct checkout *state, int *nr_checkouts);
+int finish_delayed_checkout(struct checkout *state, int *nr_checkouts,
+			    int show_progress);
 
 /*
  * Unlink the last component and schedule the leading directories for
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index b5749f327d..33dfc9cd56 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -6,6 +6,7 @@ GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
 . ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-terminal.sh
 
 TEST_ROOT="$PWD"
 PATH=$TEST_ROOT:$PATH
@@ -1061,4 +1062,74 @@ test_expect_success PERL,SYMLINKS,CASE_INSENSITIVE_FS \
 	)
 '
 
+test_expect_success PERL 'setup for progress tests' '
+	git init progress &&
+	(
+		cd progress &&
+		git config filter.delay.process "rot13-filter.pl delay-progress.log clean smudge delay" &&
+		git config filter.delay.required true &&
+
+		echo "*.a filter=delay" >.gitattributes &&
+		touch test-delay10.a &&
+		git add . &&
+		git commit -m files
+	)
+'
+
+test_delayed_checkout_progress () {
+	if test "$1" = "!"
+	then
+		local expect_progress=N &&
+		shift
+	else
+		local expect_progress=
+	fi &&
+
+	if test $# -lt 1
+	then
+		BUG "no command given to test_delayed_checkout_progress"
+	fi &&
+
+	(
+		cd progress &&
+		GIT_PROGRESS_DELAY=0 &&
+		export GIT_PROGRESS_DELAY &&
+		rm -f *.a delay-progress.log &&
+
+		"$@" 2>err &&
+		grep "IN: smudge test-delay10.a .* \\[DELAYED\\]" delay-progress.log &&
+		if test "$expect_progress" = N
+		then
+			! grep "Filtering content" err
+		else
+			grep "Filtering content" err
+		fi
+	)
+}
+
+for mode in pathspec branch
+do
+	case "$mode" in
+	pathspec) opt='.' ;;
+	branch) opt='-f HEAD' ;;
+	esac
+
+	test_expect_success PERL,TTY "delayed checkout shows progress by default on tty ($mode checkout)" '
+		test_delayed_checkout_progress test_terminal git checkout $opt
+	'
+
+	test_expect_success PERL "delayed checkout ommits progress on non-tty ($mode checkout)" '
+		test_delayed_checkout_progress ! git checkout $opt
+	'
+
+	test_expect_success PERL,TTY "delayed checkout ommits progress with --quiet ($mode checkout)" '
+		test_delayed_checkout_progress ! test_terminal git checkout --quiet $opt
+	'
+
+	test_expect_success PERL,TTY "delayed checkout honors --[no]-progress ($mode checkout)" '
+		test_delayed_checkout_progress ! test_terminal git checkout --no-progress $opt &&
+		test_delayed_checkout_progress test_terminal git checkout --quiet --progress $opt
+	'
+done
+
 test_done
diff --git a/unpack-trees.c b/unpack-trees.c
index 5786645f31..f07304f1b7 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -479,7 +479,7 @@ static int check_updates(struct unpack_trees_options *o,
 		errs |= run_parallel_checkout(&state, pc_workers, pc_threshold,
 					      progress, &cnt);
 	stop_progress(&progress);
-	errs |= finish_delayed_checkout(&state, NULL);
+	errs |= finish_delayed_checkout(&state, NULL, o->verbose_update);
 	git_attr_set_direction(GIT_ATTR_CHECKIN);
 
 	if (o->clone)
-- 
2.32.0

