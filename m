Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E231C433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 21:01:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiDHVDn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 17:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiDHVDl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 17:03:41 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F553B9184
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 14:01:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n6so19518494ejc.13
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 14:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=LGqtMGqr3CZfYqMPYLB3f5VUouwvMy0kXUIwiotAnm4=;
        b=wO6veAwnrdlZKyGTKEgZrpCBXjAWgiVTMRoqhtA03gxgXWaTAoSikcIRr6qV/Zc9Xs
         K+WRk34Fcxoj1twq6f8yKpkhDxnvuhzapifjsSQiuHboDpzNAOTOI3tj+yTbjPoWO6xM
         uW6N1koefoaj5dJ8ZT2pDHJZ11DER9mCA3qFF9NW+zcCdz30glNphlPu3WcI2YGQVNHq
         WslmwXJWLJ+3XLIl2tz9b5rWqgjfBYIp34vmVraHX+kRhZgttVBpQSW4+rytDtxIxxFs
         wCDnLxdX8AnYkkbSRyEp2oGIJP3e3HRdAexZNoj2As0GyGWM6PooOCqcMxQiTLWO2Avy
         wAWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=LGqtMGqr3CZfYqMPYLB3f5VUouwvMy0kXUIwiotAnm4=;
        b=Xhs4BXCSNcZnyK6bvKh42Y77NwxKn+9KHQEOgBgS9CNOpAFsPGFsxpfuDnmTYR4i23
         NWsKSxiUx+ZIwfAnIBJztQYfVunLbDolAPbsFRyYXVAiB9BNq8y2RweRECdVWpHCfIIr
         zaMLhiQKzBjc8dEn/F6t+jIXf8lisa4xOgqStjr1tZ1xf7tZQL2+h9IWT/C8uU8wiPvC
         MIEf4AcQH3yT7fYcmtZoqIP6ePdvsINrvI1bDiA2HuJVoG5kBCoJO7EutSpHcEhUIlkl
         KseIIkri6inT1QTTlrCAb81fhkj+eoAYplU0skP0JnQEgLOQRc3uvJkJXsYVlcGm9E15
         UzJw==
X-Gm-Message-State: AOAM5320SHTjU2E8h/0eyFUWBury4f8svNaTdFdVIaE+AK5pQgBvk1Sc
        1twwGCAqizsA6N/nnBhHNhOz1bIQzsgVo9fu
X-Google-Smtp-Source: ABdhPJxMKnuaC0sN0a0O05FSHTZ5rkr7USZcWT1BVraFwvIYeI6kSedLKM9pPinaZAxeAiXkLo/+CA==
X-Received: by 2002:a17:906:40d6:b0:6e7:681e:b4c3 with SMTP id a22-20020a17090640d600b006e7681eb4c3mr19536521ejk.697.1649451692931;
        Fri, 08 Apr 2022 14:01:32 -0700 (PDT)
Received: from vmiklos.hu (178-164-175-237.pool.digikabel.hu. [178.164.175.237])
        by smtp.gmail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm8972288ejc.197.2022.04.08.14.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 14:01:32 -0700 (PDT)
Date:   Fri, 8 Apr 2022 23:01:30 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3] git-log: add a --since=... --as-filter option
Message-ID: <YlCiqgO6rL908Zsi@vmiklos.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtub3moa0.fsf@gitster.g>
 <xmqqv8vkpara.fsf@gitster.g>
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

Signed-off-by: Miklos Vajna <vmiklos@vmiklos.hu>
---

Hi Junio,

On Thu, Apr 07, 2022 at 07:30:33PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> As a single-shot change, "--since-as-filter" is certainly an easy to
> explain approach of least resistance.
> 
> But when viewed from a higher level as a general design problem, I
> am unsure if it is a good direction to go in.
> 
> Giving "--since" the "as-filter" variant sets a precedent, and
> closes the door for a better UI that we can extend more generally
> without having to add "--X-as-filter" for each and every conceivable
> "--X" that is a traversal stopper into a filtering kind.

I like the idea of doing this mode as "--since=... --as-filter". I can
still implement it just for --since=... initially, but it can be
extended for other flags as well in the future if there is a need.

> If we pursue the possibility further, perhaps we may realize that
> there isn't much room for us to add too many "traversal stoppers" in
> the future, in which case giving "as-filter" to a very limited few
> traversal stoppers may not be too bad.  I just do not think we have
> explored that enough to decide that "--since-as-filter" is a good UI

My understanding is that get_revision_1() has a special-case for the max
age case to be a "traversal stopper", and all other options are just 
filtering in limit_range(). But perhaps I missed something.

Here is an updated patch to do the new syntax.

Thanks,

Miklos

 Documentation/rev-list-options.txt |  5 +++++
 revision.c                         | 14 +++++++++++--
 revision.h                         |  1 +
 t/t4217-log-limit.sh               | 32 ++++++++++++++++++++++++++++++
 4 files changed, 50 insertions(+), 2 deletions(-)
 create mode 100755 t/t4217-log-limit.sh

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index fd4f4e26c9..8565299264 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -25,6 +25,11 @@ ordering and formatting options, such as `--reverse`.
 --after=<date>::
 	Show commits more recent than a specific date.
 
+--as-filter::
+	When combined with `--since=<date>`, show all commits more recent than
+	a specific date. This visits all commits in the range, rather than stopping at
+	the first commit which is older than a specific date.
+
 --until=<date>::
 --before=<date>::
 	Show commits older than a specific date.
diff --git a/revision.c b/revision.c
index 7d435f8048..41ea72e516 100644
--- a/revision.c
+++ b/revision.c
@@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
 		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
 		    !revs->line_level_traverse)
 			continue;
+		if (revs->max_age != -1 && revs->as_filter && (commit->date < revs->max_age) &&
+		    !revs->line_level_traverse)
+			continue;
 		date = commit->date;
 		p = &commit_list_insert(commit, p)->next;
 
@@ -1838,6 +1841,7 @@ void repo_init_revisions(struct repository *r,
 	revs->dense = 1;
 	revs->prefix = prefix;
 	revs->max_age = -1;
+	revs->as_filter = 0;
 	revs->min_age = -1;
 	revs->skip_count = -1;
 	revs->max_count = -1;
@@ -2218,6 +2222,9 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("since", argv, &optarg))) {
 		revs->max_age = approxidate(optarg);
 		return argcount;
+	} else if (!strcmp(arg, "--as-filter")) {
+		revs->as_filter = 1;
+		return argcount;
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
index 0000000000..a66830e3d7
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
+	git log --since="2022-01-01" --as-filter --pretty="format:%s" > actual &&
+	test_i18ngrep init actual &&
+	! test_i18ngrep second actual &&
+	test_i18ngrep third actual
+'
+
+test_done
-- 
2.34.1

