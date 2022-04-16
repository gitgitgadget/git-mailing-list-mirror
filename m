Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91BB1C433EF
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 14:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiDPOZu (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Apr 2022 10:25:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232288AbiDPOZt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Apr 2022 10:25:49 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E66BA2DAB3
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 07:23:15 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id c6so12875831edn.8
        for <git@vger.kernel.org>; Sat, 16 Apr 2022 07:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nLQgXbwelVyZrDo8Yn3nVbyKZbKmBZWA+COb5bq8gC4=;
        b=IyzIsTLAVjID2nISPOBWS+QhbP8IXKnOc4GODHNdTS1kxjGjN3qWAAr2HXQFT2JsGM
         9mq3BL0o1nGE9UDiu3n9xZhvLgbFKub6EaejRFMvKCIp2Ld2tZKkXVHb9u/kdnwXkzeB
         oMaz9i8V+1Gjf9xwO8BFaNnAGDCOcPJHNw6pdDdU9wFodfp+5dI5uekdFWtQqUMtQMSq
         S+ssz0aNGcmTjXd6v6Ej1LMQoYL01yPNIwCutjJECULLjovdAjjD84Y8eY8q0+O/U6JI
         kGBfcVglvyZYldt314FvwG/4+bbFaXBhD+tJW/qUKYft7q0gjrTYR/TtsvBVPNrLstIZ
         vNDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nLQgXbwelVyZrDo8Yn3nVbyKZbKmBZWA+COb5bq8gC4=;
        b=3H8+cn5pk+BMJvKVzNfeqChH2KVAYs7sPhB8DCyLjKOLAwfnhvL6ZNccaFk0cFJtsZ
         zl4LGte3Tu8Gi3HoWqPHC5N9gGJ0CcA56sa3Y3EwNblWliPhFiEwf/942QxorU1zXrfl
         sutJMnvBMJ7MdUCZX4cXhs8hj9VHpg9bSB9eBKvFcjKML2x2636IalweBCVB3kUg2Z0I
         WyDDYuiCfd49l6J8Nmt1wUuIGW+YKs5afwzboWBdXfwLqAGpjrXb+qHNzQHpsqnjEFMW
         rgh1BaSP/KRCh/j27xh/HqUGaW53gPSr6SXpVpeNbyYVxOyQB6ma0BV927LQzDxz5y4d
         MN4w==
X-Gm-Message-State: AOAM531CPq5oyRGKIavw0vSvGdv0s2nJ2+TS7p5nGh0STdompfosS7rL
        hK9yaKvM02AZGt6OoDLLVYEygE+JSbyM4LmO
X-Google-Smtp-Source: ABdhPJzAIKyNhPO8ThbI/prkjUOaIxFW8vveubKirX8NEy69ziAERtdI1Yj9SbExXKEtCRwyoWQAJA==
X-Received: by 2002:a05:6402:5cf:b0:41d:7aa7:152a with SMTP id n15-20020a05640205cf00b0041d7aa7152amr4083996edx.68.1650118994036;
        Sat, 16 Apr 2022 07:23:14 -0700 (PDT)
Received: from vmiklos.hu (94-21-185-252.pool.digikabel.hu. [94.21.185.252])
        by smtp.gmail.com with ESMTPSA id jt8-20020a170906ca0800b006df9b29eaf1sm2646822ejb.8.2022.04.16.07.23.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 07:23:13 -0700 (PDT)
Date:   Sat, 16 Apr 2022 16:23:11 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org
Subject: [PATCH v5] log: "--as-filter" option adjusts how "--since" cut-off
 works
Message-ID: <YlrRT6NAgW6nK2fc@vmiklos.hu>
References: <xmqqtub3moa0.fsf@gitster.g>
 <xmqqv8vkpara.fsf@gitster.g>
 <YlCiqgO6rL908Zsi@vmiklos.hu>
 <220412.86pmlmhe9a.gmgdl@evledraar.gmail.com>
 <YlnYDgZRzDI87b/z@vmiklos.hu>
 <xmqqmtgm9c01.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmtgm9c01.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "--since=<time>" option of "git log" limits the commits displayed by
the command by stopping the traversal once it sees a commit whose
timestamp is older than the given time and not digging further into its
parents.

This is OK in a history where a commit always has a newer timestamp than
any of its parents'.  Once you see a commit older than the given <time>,
all ancestor commits of it are even older than the time anyway.  It
poses, however, a problem when there is a commit with a wrong timestamp
that makes it appear older than its parents.  Stopping traversal at the
"incorrectly old" commit will hide its ancestors that are newer than
that wrong commit and are newer than the cut-off time given with the
--since option.  --max-age and --after being the synonyms to --since,
they share the same issue.

Add a new "--as-filter" option that modifies how "--since=<time>" is
used.  Instead of stopping the traversal to hide an old enough commit
and its all ancestors, exclude commits with an old timestamp from the
output but still keep digging the history.

Without other traversal stopping options, this will force the command in
"git log" family to dig down the history to the root.  It may be an
acceptable cost for a small project with short history and many commits
with screwy timestamps.

Signed-off-by: Miklos Vajna <vmiklos@vmiklos.hu>
---

Hi Junio,

On Fri, Apr 15, 2022 at 04:13:02PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> A suggested rewrite.

Thanks a lot, I've updated the commit message to match this.

> > +		if (revs->max_age != -1 && revs->as_filter && (commit->date < revs->max_age) &&
> > +		    !revs->line_level_traverse)
> 
> That's an overly long line.

Fixed.

> > +			continue;
> 
> In any case, isn't this too late in limit_list() to adjust --since?
> There is this logic earlier in the loop:
> 
> 	while (original_list) {
> 		struct commit *commit = pop_commit(&original_list);
> 		struct object *obj = &commit->object;
> 		show_early_output_fn_t show;
> 
> 		if (commit == interesting_cache)
> 			interesting_cache = NULL;
> 
> 		if (revs->max_age != -1 && (commit->date < revs->max_age))
> 			obj->flags |= UNINTERESTING;
> 		if (process_parents(revs, commit, &original_list, NULL) < 0)
> 			return -1;
> 
> We look at max_age and if it is set and newer than the timestamp of
> the commit we are looking at, we immediately mark that commit
> uninteresting so that this and all its ancestors are excluded from
> the output.  Don't you want to disable that logic so that the
> traversal continues?

Yes, a "and not as-filter" was missing there, I've added it now.

> 
> > @@ -3862,6 +3868,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
> >  	if (revs->min_age != -1 &&
> >  	    comparison_date(revs, commit) > revs->min_age)
> >  			return commit_ignore;
> > +	if (revs->max_age != -1 && revs->as_filter &&
> > +	    comparison_date(revs, commit) < revs->max_age)
> > +			return commit_ignore;
> >  	if (revs->min_parents || (revs->max_parents >= 0)) {
> >  		int n = commit_list_count(commit->parents);
> >  		if ((n < revs->min_parents) ||
> 
> I am not sure how --since should affect (or not affect) the history
> simplification, but my gut feeling says this may cause unintended
> fallout.  I do not have time to dig deeper today, but something to
> keep in mind...

Hm, this works exactly as --after (which is already filtering), this is the
actual place where this patch implements the filtering way of --since.  Based
on this, it feels safe to me. But perhaps I missed something.

> > +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
> > +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> 
> Does any of the tests in this file care?  The above is a mechanism
> primarily for transitioning scripts that were written long time ago,
> and newly written tests that do not have to care about the initial
> branch should not need it (they can instead explicitly create a
> branch and work on it, if they really need to refer the initial
> branch by name, but as far as I can tell, none your test in this
> file even needs to refer to any branch with any name).

Indeed not needed, I now removed these.

> > +GIT_TEST_COMMIT_GRAPH=0
> > +GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
> 
> Do these matter, and should these matter?  Does anybody export them
> to make any difference in this test?

Aha, doesn't matter, removed.

> > +test_expect_success 'setup test' '
> > +	git init &&
> > +	echo a > file &&
> 
> Style:
> 
> 	echo a >file &&

Fixed.

> > +	GIT_COMMITTER_DATE="2021-02-01 0:00" git commit -m init &&
> 
> It is somewhat annoying to see 00:00 spelled as 0:00 here (and below).

Fixed.

> > +test_expect_success 'git log --since=... --as-filter' '
> > +	git log --since="2022-01-01" --as-filter --pretty="format:%s" > actual &&
> 
> I think you meant --format=%s (which is --pretty="tformat:%s"), as
> you do not want "actual" to end in an incomplete line.  The same
> "no space between the redirection operator and its target" applies
> here as everywhere else.

Indeed, fixed.

> 
> > +	! test_i18ngrep init actual &&
> > +	test_i18ngrep first actual &&
> > +	! test_i18ngrep second actual &&
> > +	test_i18ngrep third actual
> 
> test_i18ngrep -> grep
> 
> But stepping back a bit, do we or do we not care the order in which
> first and third appear in the "actual" file?  It's not like we have
> a mergy history and two commits that cannot topologically be
> compared.  We have a simple linear single strand of pearls here, and
> if you start traversing from the tip, you'll reliably see third
> first, then second, then first and then finally init, in that order
> and in no other order.  So, wouldn't we be better off writing it
> more like ...
> 
> 	git log --since=2022-01-01 --as-filter --format=%s >actual &&
> 	cat >expect <<-\EOF &&
> 	third
> 	first
> 	EOF
> 	test_cmp expect actual
> 
> ... i.e. explicitly spell out what we expect not to change?

Aha, I reworked the test to avoid the grep here.

Regards,

Miklos

 Documentation/rev-list-options.txt |  6 ++++++
 revision.c                         | 16 +++++++++++---
 revision.h                         |  1 +
 t/t4217-log-limit.sh               | 32 ++++++++++++++++++++++++++++
 t/t4218-blame-limit.sh             | 34 ++++++++++++++++++++++++++++++
 5 files changed, 86 insertions(+), 3 deletions(-)
 create mode 100755 t/t4217-log-limit.sh
 create mode 100755 t/t4218-blame-limit.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fd4f4e26c9..354bd29f10 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -350,6 +350,12 @@ The following options select the commits to be shown:
 <paths>::
 	Commits modifying the given <paths> are selected.
 
+--as-filter::
+	When combined with `--max-age=<date>`, `--since=<date>` or
+	`--after=<date>`, show all commits more recent than a specific date. This
+	visits all commits in the range, rather than stopping at the first commit
+	which is older than a specific date.
+
 --simplify-by-decoration::
 	Commits that are referred by some branch or tag are selected.
 
diff --git a/revision.c b/revision.c
index 7d435f8048..f9970bd8ac 100644
--- a/revision.c
+++ b/revision.c
@@ -1426,7 +1426,8 @@ static int limit_list(struct rev_info *revs)
 		if (commit == interesting_cache)
 			interesting_cache = NULL;
 
-		if (revs->max_age != -1 && (commit->date < revs->max_age))
+		if (revs->max_age != -1 && !revs->as_filter &&
+			(commit->date < revs->max_age))
 			obj->flags |= UNINTERESTING;
 		if (process_parents(revs, commit, &original_list, NULL) < 0)
 			return -1;
@@ -1440,6 +1441,9 @@ static int limit_list(struct rev_info *revs)
 		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
 		    !revs->line_level_traverse)
 			continue;
+		if (revs->max_age != -1 && revs->as_filter &&
+			(commit->date < revs->max_age) && !revs->line_level_traverse)
+			continue;
 		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
 
@@ -1838,6 +1842,7 @@ void repo_init_revisions(struct repository *r,
 	revs->dense = 1;
 	revs->prefix = prefix;
 	revs->max_age = -1;
+	revs->as_filter = 0;
 	revs->min_age = -1;
 	revs->skip_count = -1;
 	revs->max_count = -1;
@@ -2218,6 +2223,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
+	} else if (!strcmp(arg, "--as-filter")) {
+		revs->as_filter = 1;
 	} else if ((argcount = parse_long_opt("after", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
@@ -3365,7 +3372,7 @@ static void explore_walk_step(struct rev_info *revs)
 	if (revs->sort_order == REV_SORT_BY_AUTHOR_DATE)
 		record_author_date(&info->author_date, c);
 
-	if (revs->max_age != -1 && (c->date < revs->max_age))
+	if (revs->max_age != -1 && !revs->as_filter && (c->date < revs->max_age))
 		c->object.flags |= UNINTERESTING;
 
 	if (process_parents(revs, c, NULL, NULL) < 0)
@@ -3862,6 +3869,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->min_age != -1 &&
 	    comparison_date(revs, commit) > revs->min_age)
 			return commit_ignore;
+	if (revs->max_age != -1 && revs->as_filter &&
+	    comparison_date(revs, commit) < revs->max_age)
+			return commit_ignore;
 	if (revs->min_parents || (revs->max_parents >= 0)) {
 		int n = commit_list_count(commit->parents);
 		if ((n < revs->min_parents) ||
@@ -4019,7 +4029,7 @@ static struct commit *get_revision_1(struct rev_info *revs)
 		 * that we'd otherwise have done in limit_list().
 		 */
 		if (!revs->limited) {
-			if (revs->max_age != -1 &&
+			if (revs->max_age != -1 && !revs->as_filter &&
 			    comparison_date(revs, commit) < revs->max_age)
 				continue;
 
diff --git a/revision.h b/revision.h
index 5bc59c7bfe..fe37ebd83d 100644
--- a/revision.h
+++ b/revision.h
@@ -263,6 +263,7 @@ struct rev_info {
 	int skip_count;
 	int max_count;
 	timestamp_t max_age;
+	int as_filter;
 	timestamp_t min_age;
 	int min_parents;
 	int max_parents;
diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
new file mode 100755
index 0000000000..41df7f0f0f
--- /dev/null
+++ b/t/t4217-log-limit.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='git log with filter options limiting the output'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test' '
+	git init &&
+	echo a >file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2021-02-01 00:00" git commit -m init &&
+	echo a >>file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2022-02-01 00:00" git commit -m first &&
+	echo a >>file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2021-03-01 00:00" git commit -m second &&
+	echo a >>file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2022-03-01 00:00" git commit -m third
+'
+
+test_expect_success 'git log --since=... --as-filter' '
+	git log --since="2022-01-01" --as-filter --format=%s >actual &&
+	cat >expect <<-\EOF &&
+	third
+	first
+	EOF
+	test_cmp expect actual
+'
+
+test_done
diff --git a/t/t4218-blame-limit.sh b/t/t4218-blame-limit.sh
new file mode 100755
index 0000000000..bef7cf7d48
--- /dev/null
+++ b/t/t4218-blame-limit.sh
@@ -0,0 +1,34 @@
+#!/bin/sh
+
+test_description='git blame with filter options limiting the output'
+
+. ./test-lib.sh
+
+test_expect_success 'setup test' '
+	git init &&
+	echo a >file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-01-01 00:00" GIT_COMMITTER_DATE="2020-01-01 00:00" git commit -m init &&
+	echo a >>file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-02-01 00:00" GIT_COMMITTER_DATE="2020-02-01 00:00" git commit -m first &&
+	echo a >>file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-03-01 00:00" GIT_COMMITTER_DATE="2020-03-01 00:00" git commit -m second &&
+	echo a >>file &&
+	git add file &&
+	GIT_AUTHOR_DATE="2020-04-01 00:00" GIT_COMMITTER_DATE="2020-04-01 00:00" git commit -m third
+'
+
+test_expect_success 'git blame --since=...' '
+	git blame --since="2020-02-15" file >actual &&
+	cat >expect <<-\EOF &&
+	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 1) a
+	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 2) a
+	33fc0d13 (A U Thor 2020-03-01 00:00:00 +0000 3) a
+	ec76e003 (A U Thor 2020-04-01 00:00:00 +0000 4) a
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.34.1

