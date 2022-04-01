Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82613C433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 21:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352804AbiDAVim (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 17:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiDAVik (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 17:38:40 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9741A56235
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 14:36:49 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id a17so4429317edm.9
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 14:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=dpZ9VfAYLpWuoM2cDKk3F/oax/MqZo1ZSgHBvV3/G58=;
        b=a2ryAWfUbdSoo8TZ6jBx37TNfVavP5BX1smsIKpwv3PtpJftWr47q2vBDlzu7Z/yiv
         4HpT5aNnLddNg1PDI164gpDsFo0vwvRIlEkXcnZzzKjlCrntOPs9pZrtDBdy6/+qe2ei
         q0r8K1G9a6a0Jmf1UxgWqhw5euIZ+PeIrsjL2ST2SWfEddG2iC+hv2Jvn/hAp25Jg/C6
         wlt14JEf5c5mjQGOtc7MGqXQUaP+6BI9vLWC46luKoGvnRUvtkjiMKspOaZy/COrhTTV
         UDyQbV/V5Z8ztaL+FffS3GAx7DeDpImaXt0w/nSroB8+GCUfnsEtQ8wo7AA956z/mn1N
         JL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=dpZ9VfAYLpWuoM2cDKk3F/oax/MqZo1ZSgHBvV3/G58=;
        b=n/itUy8aYMIyMtK0RO5EVbv4RhRBHLHq19P9lYpQ5aSA772XfX/J6RwX+Bhrw8ukHO
         IMu5aeVxBVnpcXc9ZB1k6bYSgKzTScIwOky5Tzjev9MF9zMM4CczxDIlqs7hT4QR7SUm
         mbTgqQHxQPCZVbhfIwloQFEOnsl1UHMr3qgUmdyD2dgSbs/U+tRrMVGmM48plN/vIqQt
         PP+WVRl9mghnE7Fu3X0QgkCcd3JpNF0y5OG2mzHzxPrtPsVo189WJsLBku6VdC6X+aJ2
         IDDJwshqTc+98qngLLjVVgkVQ7cEivNsfLXlbkI5Av2OaEhd4eCHJmEEoiFeDdvY9T1w
         /WZg==
X-Gm-Message-State: AOAM531XrYaeDmA5nWRSzvI9y0rKOjQXeUJg88Zckb/hz8N33JrlKOgb
        gf5/Du64UABoNJrbmMjcJcePnP0ZmJoraIjN
X-Google-Smtp-Source: ABdhPJwxRrEpUWwYvzosj4kimdyEgFTd2C0ryAeu0eOTiytvQJBd6Uo70LZnMnRWLIhCpijAbda/Ow==
X-Received: by 2002:a05:6402:22db:b0:419:a146:7ba2 with SMTP id dm27-20020a05640222db00b00419a1467ba2mr22830092edb.399.1648849008058;
        Fri, 01 Apr 2022 14:36:48 -0700 (PDT)
Received: from vmiklos.hu (92-249-130-49.digikabel.hu. [92.249.130.49])
        by smtp.gmail.com with ESMTPSA id v17-20020a170906339100b006e11af84acasm1418194eja.128.2022.04.01.14.36.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 14:36:47 -0700 (PDT)
Date:   Fri, 1 Apr 2022 23:36:45 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH] git-log: add a --since-as-filter option
Message-ID: <YkdwbUqM45T06R00@vmiklos.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq1qygy9nd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is similar to --since, but it will filter out not matching commits,
rather than stopping at the first not matching commit.

This is useful if you e.g. want to list the commits from the last year,
but one odd commit has a bad commit date and that would hide lots of
earlier commits in that range.

The behavior of --since is left unchanged, since it's valid to depend on
its current behavior.
---

Hi,

On Fri, Apr 01, 2022 at 10:51:34AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> We could add a --since-as-filter= option or something, but then the
> user needs to be careful when to stop (and digging down to the root
> of the history, i.e. "never stop", may be an acceptable answer to
> some projects).

Here is a patch that does this. As a somewhat arbitrary testcase, the
LibreOffice core.git repo has 474064 commits and --since-as-filter
finishes in 688 ms for a sample query (and expected output), while I got
empty output with --since previously. I would argue this is an
acceptable trade-off.

What do you think?

Thanks,

Miklos

 Documentation/rev-list-options.txt |  5 +++++
 revision.c                         | 10 ++++++++++
 revision.h                         |  1 +
 t/t4217-log-limit.sh               | 32 ++++++++++++++++++++++++++++++
 4 files changed, 48 insertions(+)
 create mode 100755 t/t4217-log-limit.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fd4f4e26c9..ba01b1ba06 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -25,6 +25,11 @@ ordering and formatting options, such as `--reverse`.
 --after=<date>::
 	Show commits more recent than a specific date.
 
+--since-as-filter=<date>::
+	Show all commits more recent than a specific date. This visits all
+	commits in the range, rather than stopping at the first commit which is older
+	than a specific date.
+
 --until=<date>::
 --before=<date>::
 	Show commits older than a specific date.
diff --git a/revision.c b/revision.c
index 2646b78990..ebc95319d6 100644
--- a/revision.c
+++ b/revision.c
@@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
 		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
 		    !revs->line_level_traverse)
 			continue;
+		if (revs->max_age_as_filter != -1 && (commit->date < revs->max_age_as_filter) &&
+		    !revs->line_level_traverse)
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
index 0000000000..5b7d30d5ad
--- /dev/null
+++ b/t/t4217-log-limit.sh
@@ -0,0 +1,32 @@
+#!/bin/sh
+
+test_description='git log with filter options limiting the output'
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+
+GIT_TEST_COMMIT_GRAPH=0
+GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=0
+
+test_expect_success 'setup test' '
+	git init &&
+	echo a > file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2022-02-01 0:00" git commit -m init &&
+	echo a >> file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2021-01-01 0:00" git commit -m second &&
+	echo a >> file &&
+	git add file &&
+	GIT_COMMITTER_DATE="2022-03-01 0:00" git commit -m third
+'
+
+test_expect_success 'git log --since-as-filter' '
+	git log --since-as-filter="2022-01-01" --pretty="format:%s" > actual &&
+	test_i18ngrep init actual &&
+	! test_i18ngrep second actual &&
+	test_i18ngrep third actual
+'
+
+test_done
-- 
2.34.1

