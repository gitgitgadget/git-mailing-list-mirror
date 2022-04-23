Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93D0CC433EF
	for <git@archiver.kernel.org>; Sat, 23 Apr 2022 13:00:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233218AbiDWNDC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 23 Apr 2022 09:03:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbiDWNDB (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Apr 2022 09:03:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4FE012AFE
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 06:00:01 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l7so21234582ejn.2
        for <git@vger.kernel.org>; Sat, 23 Apr 2022 06:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=TkzFrvt80zJLzfs2sOz08+CmmmzMHlYqCcFinOd+R4A=;
        b=gsss3CTlMZxe1HY4Gkw9akkq0qgEOMPqrKrMAP7c5sL62cc8g5xcME10BN7CWuV7WA
         kjksEyaFBBGy1Fj+0A+BPYPgpUIy+OBCqghTXJRvln+qjTFlhK+BLkbHuRHApXFa3y4E
         bUABYyJIHQt8YwLJwKZ3l79cDM4hC8joEXcJsEY8FZNKZXaM9bfWUizNGBPhQgiteycv
         UFa+Wyx9jumVrVM+xKUsq8E4F/W6SL23wq8xl0Bf5TCrQDlj4y9AD23hLPGb5pYRZyA6
         3UL6EG4Aef9iuUt4hjp4zgiFJkV04zZ3btuHdZk4rOEcImPlYdubXCoP1kB5wrnJaMp1
         MQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=TkzFrvt80zJLzfs2sOz08+CmmmzMHlYqCcFinOd+R4A=;
        b=l0vZ0e4VEd/8xoSvXR4BuG+35xa2LVE+2FrGTNEOn9pj6sg5xpp7kxP5UIdPiVIjSo
         kox+zP4wcPq9bmzmDmYWx592t2lba+axbG5rBqrMsKr9vHT3b6KtEXzg/CuRKSrdjtBX
         pkdVf3sJXgnT1bBDbAK27MhuLtK9ZVDtuAK1XXA5gD6E7Pr0jk2ttOwEyuSfCvvI3fqp
         KUk/uzwBvWGaICEUdSKv1IS52I87BdR1YUpk8lPKuc5W0SXRu3PxZ4LT0U3Qz6x2o6Lk
         RCHE2f2kP5RYMEjYp/jcTjntG2KpC/1aHI6cSXwyr5RvEIz1vlnC43W5Pp2GrMPEG7MH
         HRBQ==
X-Gm-Message-State: AOAM532IqdS3OYiIKWAouq9LYhLxqAMCqgOdZaqp1deWc26mAfW5dTQJ
        qfl4ZZlK23QarIvDKV9lcXyZAA==
X-Google-Smtp-Source: ABdhPJxHWPujqW12HSs7Rhx9od/xzcUK8AlSE3lYNfhjC1cCWfRPmlyQbwY1OphgovgTgCnIupZPog==
X-Received: by 2002:a17:907:948b:b0:6d8:27f8:ab4a with SMTP id dm11-20020a170907948b00b006d827f8ab4amr8125946ejc.39.1650718800192;
        Sat, 23 Apr 2022 06:00:00 -0700 (PDT)
Received: from vmiklos.hu (92-249-245-217.pool.digikabel.hu. [92.249.245.217])
        by smtp.gmail.com with ESMTPSA id c2-20020a170906170200b006efe7be5f10sm1667106eje.185.2022.04.23.05.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:59:59 -0700 (PDT)
Date:   Sat, 23 Apr 2022 14:59:57 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v7] log: "--since-as-filter" option is a non-terminating
 "--since" variant
Message-ID: <YmP4TaYmSEi6GeB4@vmiklos.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqee1o6a68.fsf@gitster.g>
 <xmqqsfq44rc6.fsf@gitster.g>
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

Add a new "--since-as-filter" option that is a variant of
"--since=<time>".  Instead of stopping the traversal to hide an old
enough commit and its all ancestors, exclude commits with an old
timestamp from the output but still keep digging the history.

Without other traversal stopping options, this will force the command in
"git log" family to dig down the history to the root.  It may be an
acceptable cost for a small project with short history and many commits
with screwy timestamps.

It is quite unlikely for us to add traversal stopper other than since,
so have this as a --since-as-filter option, rather than a separate
--as-filter, that would be probably more confusing.

Signed-off-by: Miklos Vajna <vmiklos@vmiklos.hu>
---

Hi Junio,

On Fri, Apr 22, 2022 at 03:11:11PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Thanks.  Now 2.36 release is behind us, let's queue this in 'seen'
> and after getting reviewed by somebody else---I do not trust
> anything looked at by me and nobody else---merge it down, aiming for
> graduation during this cycle.

Ævar: you had opinion in this thread -- are you interested in reviewing this patch?

> Much ealrier than this part in the same loop there is
> 
> 		if (revs->max_age != -1 && (commit->date < revs->max_age))
> 			obj->flags |= UNINTERESTING;
> 		if (process_parents(revs, commit, &original_list, NULL) < 0)
> 			return -1;
> 
> which taints the commit we are looking at as UNINTERESTING, cutting
> the traversal down to its parents, if its timestamp is older than
> max_age, and it would need to be taught not to do that, no?
> 
> Ah, OK, max_age_as_filter is *NOT* a boolean (false is -1 and true
> is something else) but is an independent timestamp and the
> expectation is that max_age is left to be -1 when --since is not in
> use.  --since-as-filter's timestamp is stored in max_age_as_filter
> so the earlier "compare with max_age and use UNINTERESTING bit to
> stop traversal" code does not have to be modified.

Yes, max_age is the terminating timestamp and max_age_as_filter is the
filtering timestamp.

> > +		if (revs->max_age_as_filter != -1 &&
> > +			(commit->date < revs->max_age) && !revs->line_level_traverse)
> > +			continue;
> >  		date = commit->date;
> >  		p = &commit_list_insert(commit, p)->next;
> 
> And if that is the assumption of this code, shouldn't this part be
> using "if max_age is set (i.e. not -1) and the commit is older than
> that and we are not doing -La,b traversal"?  "--since-as-filter"
> being used does not mean max_age must be set to a value that can be
> compared to timestamps in commits in the world order of this version
> of the patch, right?

Good catch, commit->date < revs->max_age is meant to be commit->date <
revs->max_age_as_filter there, fixed.

> Everything except that "why are we checking if --since-as-filter is
> set and then comparing with the value came from --since?" part looks
> great to me.  If that indeed is a bug (it is very possible that I am
> misreading the logic and the comparison with continue is perfectly
> correct), and if the tests added by this patch didn't catch it, then
> the test script may need a bit more work to catch such a mistake.

Yes, it was a bug. For example git log --children --since-as-filter=...
gave empty output due to this. I now added a test for this.

> Hardcoding the object names like this does not pass our test suite.
> These abbreviated object names hardcode the use of SHA-1, but the
> code is tested in repositories that use SHA-256 as well.
> 
> As you are creating four commits with distinct timestamps, I think
> you can simply filter out the object name part for comparison,
> perhaps like:
> 
> redact_blame_output () {
> 	sed -e 's/\([^]*\)\([0-9a-f]*\) /\1HASH /'
> }
> 
> test_expect_success 'git blame --since=...' '
> 	git blame --since=2020-02-15 file >raw &&
> 	redact_blame_output <raw >actual &&
> 	redact_blame_output <<-\EOF &&
> 	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 1) a
> 	^c7bc5ce (A U Thor 2020-02-01 00:00:00 +0000 2) a
> 	33fc0d13 (A U Thor 2020-03-01 00:00:00 +0000 3) a
> 	ec76e003 (A U Thor 2020-04-01 00:00:00 +0000 4) a
> 	EOF
> 	test_cmp expect actual
> '
> 
> But did you really mean to test how --since works with blame?  Given
> that there does not seem to be any clock skew in the history being
> tested, I am wondering if this new test file should even be a part
> of the topic.

I dropped t/t4218-blame-limit.sh from this topic. The idea was to
increase coverage for git blame --since=..., as it seems to have no
test. But we can get back to that in a separate topic, I agree to keep
this topic scoped.

Thanks,

Miklos

 Documentation/rev-list-options.txt |  5 ++++
 revision.c                         | 10 ++++++++
 revision.h                         |  1 +
 t/t4217-log-limit.sh               | 41 ++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+)
 create mode 100755 t/t4217-log-limit.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fd4f4e26c9..195e74eec6 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -25,6 +25,11 @@ ordering and formatting options, such as `--reverse`.
 --after=<date>::
 	Show commits more recent than a specific date.
 
+--since-as-filter=<date>::
+	Show all commits more recent than a specific date. This visits
+	all commits in the range, rather than stopping at the first commit which
+	is older than a specific date.
+
 --until=<date>::
 --before=<date>::
 	Show commits older than a specific date.
diff --git a/revision.c b/revision.c
index 7d435f8048..c367273c00 100644
--- a/revision.c
+++ b/revision.c
@@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
 		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
 		    !revs->line_level_traverse)
 			continue;
+		if (revs->max_age_as_filter != -1 &&
+			(commit->date < revs->max_age_as_filter) && !revs->line_level_traverse)
+			continue;
 		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
 
@@ -1838,6 +1841,7 @@ void repo_init_revisions(struct repository *r,
 	revs->dense = 1;
 	revs->prefix = prefix;
 	revs->max_age = -1;
+	revs->max_age_as_filter = -1;
 	revs->min_age = -1;
 	revs->skip_count = -1;
 	revs->max_count = -1;
@@ -2218,6 +2222,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
+	} else if ((argcount = parse_long_opt("since-as-filter", argv, &optarg))) {
+		revs->max_age_as_filter = approxidate(optarg);
+		return argcount;
 	} else if ((argcount = parse_long_opt("after", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
@@ -3862,6 +3869,9 @@ enum commit_action get_commit_action(struct rev_info *revs, struct commit *commi
 	if (revs->min_age != -1 &&
 	    comparison_date(revs, commit) > revs->min_age)
 			return commit_ignore;
+	if (revs->max_age_as_filter != -1 &&
+	    comparison_date(revs, commit) < revs->max_age_as_filter)
+			return commit_ignore;
 	if (revs->min_parents || (revs->max_parents >= 0)) {
 		int n = commit_list_count(commit->parents);
 		if ((n < revs->min_parents) ||
diff --git a/revision.h b/revision.h
index 5bc59c7bfe..e80c148b19 100644
--- a/revision.h
+++ b/revision.h
@@ -263,6 +263,7 @@ struct rev_info {
 	int skip_count;
 	int max_count;
 	timestamp_t max_age;
+	timestamp_t max_age_as_filter;
 	timestamp_t min_age;
 	int min_parents;
 	int max_parents;
diff --git a/t/t4217-log-limit.sh b/t/t4217-log-limit.sh
new file mode 100755
index 0000000000..6e01e2629c
--- /dev/null
+++ b/t/t4217-log-limit.sh
@@ -0,0 +1,41 @@
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
+test_expect_success 'git log --since-as-filter=...' '
+	git log --since-as-filter="2022-01-01" --format=%s >actual &&
+	cat >expect <<-\EOF &&
+	third
+	first
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'git log --children --since-as-filter=...' '
+	git log --children --since-as-filter="2022-01-01" --format=%s >actual &&
+	cat >expect <<-\EOF &&
+	third
+	first
+	EOF
+	test_cmp expect actual
+'
+
+test_done
-- 
2.34.1

