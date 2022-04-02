Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CAD4AC433F5
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 10:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245135AbiDBKLT (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 06:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbiDBKLR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 06:11:17 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0A82DD62
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 03:09:19 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r13so10578953ejd.5
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 03:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=r7ObhGA6f5PbirC6g9OLsL9pid5jpW8rnQtjza8sEVY=;
        b=3MA3hOMjTkFk6WUeQ2F5fDT3lyL4RmAHbqa8BOuLr6gxpyPwsf1KtDXNy/I7PNZor/
         1GPauYVn2S2y8fVFKf9vQ7fmostiYT/rto1bwzQfwW8nTakTTO6YtwDOZRWK2MR52Ojp
         ENHF3OxjCMEaLabK/tOfVZ6k0TP6hcazHlC2C+uh+jvrbUQLRK0bIY4Burzgk0FVe1Xo
         /HcpuHBXcn7Ig3dXod9jZhNtf4/VdrELZsLJ4gwGR6Y/9Z6tXcGVJ0KHjPhZ/znsMyrh
         Q6v5UPFRfaPYAN0A4CJjRBgfR57IeJfC+njNCJ1YGhtCHz5cfR2LrjsB3b9KI05Zp58F
         SwsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=r7ObhGA6f5PbirC6g9OLsL9pid5jpW8rnQtjza8sEVY=;
        b=OkUTaF8oRQhMIUSYLMtkF8LYatN7tlRXowkTJDfviCZuABySdBBuJ7Cs7mp4440uTG
         L0MLb+3YgRAIYFHVX2Z7c9JGakVOugE85Ah5trn6+j4auNccQ1r24bsrtYMNKj3LvRIG
         fTcfQ/Bodp+zF0hUGmStNtkaGJwxvV+SuKvmKdjrfJC1m67hBfGpHPWMMvU4tzLCyOtv
         C0PzUivbLtDdPoUHkhoytf5otLrsg3sHvzagX+HZMZeMR5DLdIn7rTUBoFxg+4okTd3U
         JKs4WLdTZ5cHmveQTQiNRAsoSR5stFDV7wOjbzfc/YjUw7JIL+tKK/1/oMInTs5C/AJl
         Iqiw==
X-Gm-Message-State: AOAM532HnXTSvPaAP3PLJCTUqMbvj/3p7tpCgtVDM8t8CV+YVbhSeaUH
        LfJN//A/DbVs9XUCAIhBJv82uw==
X-Google-Smtp-Source: ABdhPJyXQEfg/tIsnxGA68ybrwlc/0jm6jm7jGfIZwhR6XTiUr4rkZoWFdkYamEpXV0+t6oWVRZyIQ==
X-Received: by 2002:a17:907:1614:b0:6df:678a:a7d5 with SMTP id hb20-20020a170907161400b006df678aa7d5mr3199516ejc.719.1648894157977;
        Sat, 02 Apr 2022 03:09:17 -0700 (PDT)
Received: from vmiklos.hu (92-249-130-49.digikabel.hu. [92.249.130.49])
        by smtp.gmail.com with ESMTPSA id hp11-20020a1709073e0b00b006dfd53a0e39sm1934994ejc.135.2022.04.02.03.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 03:09:17 -0700 (PDT)
Date:   Sat, 2 Apr 2022 12:09:15 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v2] git-log: add a --since-as-filter option
Message-ID: <Ykggy4poryul8uyG@vmiklos.hu>
References: <xmqq1qygy9nd.fsf@gitster.g>
 <YkdwbUqM45T06R00@vmiklos.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YkdwbUqM45T06R00@vmiklos.hu>
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

Hi,

On Fri, Apr 01, 2022 at 11:36:48PM +0200, Miklos Vajna <vmiklos@vmiklos.hu> wrote:
> Here is a patch that does this.

Oops, forgot the sign-off, fixed now.

Regards,

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

