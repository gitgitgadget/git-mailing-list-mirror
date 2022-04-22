Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B725C433EF
	for <git@archiver.kernel.org>; Fri, 22 Apr 2022 21:07:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiDVVKc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Apr 2022 17:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiDVVKa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Apr 2022 17:10:30 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3273420E4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 13:06:25 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id f17so11680350edt.4
        for <git@vger.kernel.org>; Fri, 22 Apr 2022 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vmiklos-hu.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=X/CbYh2Ntui9iAui52/1qsSeDreyGLBAspIIh4RoJN0=;
        b=AxsYrYkuKQIVDRCxew7HRuIt4Y7pZdT8ZVJL0EuWrLR1jT7r1DpBpw8M8X4SpvJ6d+
         L5Ycc0fYA7Kh6xSVFj4E/g3jZVNVGQ2Gh48ETRB3x8FvpPclyZ9RCxWd/y7OLLpr8zVY
         h4GkZ4UsKpSoLzm7ukUEtW56vS4Q9QcMEdWmw+mgBIcca4g0tsZBGLv+DKRFpJ8+IGTP
         UbZywQ2ZhcmcBSIe5pCmRySsR4LOaQyt17G0vGn3BaGM0PXOe1tfQTzKsHR+PLJaXUp5
         YH1S0thnUc7qwkc/RwXR1BQvdykjprQySAn8L0zF8JpFtcsx45WINLb9L8O72Z2eF8k0
         cFVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=X/CbYh2Ntui9iAui52/1qsSeDreyGLBAspIIh4RoJN0=;
        b=RIVyCZOnc0/apg6wFiOgaEOanFsHY9wQhW9Pdb/4gRQ+wbnALVrs8T36T8LVnYakSc
         0uIFhgvWnzDeOVhN/LQxFfC5UPyCZi+bWaeMgdyIoJndnYAVFe5JG8cYrrcT4l8sGXDu
         4JJNRgtoOWx0qT1DABOIfRn4Zx1Ueda30eN3fKshovhv2Hiv8nZv2KTbzDh0qnpgxPh9
         w3uSpEewDZkmZovgs2QXLeSBqcHukajSUue7zA/PSEyriS4+LvWT5+CQGI10XG6Kssla
         1XzFhoxG1f/fi7FX+CHq5m7ze9BlZeaZ/e9UtI3Pu4exuBf9Ed1tbDM8nvytpmYo8DJ8
         8Fog==
X-Gm-Message-State: AOAM531jLwYY4CzqBQQCo9YUWsipRoiIHw9/uc5jvZZLb09d+obsn6X3
        R8k62yY3OSe6NcHTklRTihSbVJE79GQKXkXj
X-Google-Smtp-Source: ABdhPJzvlNWccPJYMV/Dg2dJr3AU0ndg6WENvAgMbGyLeHDxxOLtYn0bOHjEwKdca3zJcNP5h6Tjgg==
X-Received: by 2002:a05:6402:27cb:b0:423:d386:42be with SMTP id c11-20020a05640227cb00b00423d38642bemr6705118ede.227.1650657708647;
        Fri, 22 Apr 2022 13:01:48 -0700 (PDT)
Received: from vmiklos.hu (92-249-245-217.pool.digikabel.hu. [92.249.245.217])
        by smtp.gmail.com with ESMTPSA id bs2-20020a056402304200b0041fc40eeb91sm1217807edb.49.2022.04.22.13.01.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 13:01:48 -0700 (PDT)
Date:   Fri, 22 Apr 2022 22:01:46 +0200
From:   Miklos Vajna <vmiklos@vmiklos.hu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>
Subject: [PATCH v6] log: "--since-as-filter" option is a non-terminating
 "--since" variant
Message-ID: <YmMJqvKN6itSHEZW@vmiklos.hu>
References: <Yka2GSGs3EIXm6Xt@vmiklos.hu>
 <xmqq1qygy9nd.fsf@gitster.g>
 <Yk8Gvf/fjVca9hDB@vmiklos.hu>
 <xmqqv8vkpara.fsf@gitster.g>
 <xmqqtub3moa0.fsf@gitster.g>
 <CANgJU+Wr+tKNPfeh4dst-E_LSnoYYmN1easqmkFUA9spp-rpKQ@mail.gmail.com>
 <xmqqilrfk14q.fsf@gitster.g>
 <xmqqzgkd7y42.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzgkd7y42.fsf@gitster.g>
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

On Fri, Apr 22, 2022 at 11:48:45AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Now I had some time to think about it, I have a feeling that it is
> quite unlikely for us to add traversal stopper other than since, so
> having a separate "--as-filter" would probably be more confusing
> than adding "--since-as-filter", stressing on "only the 'show
> commits with timestamp after this one' has two variants".

I'm fine with this approach, it goes back to the initial version. I 
rather reworked v5 in practice, to keep the other improvements.

Here is a patch that does this.

Regards,

Miklos

 Documentation/rev-list-options.txt |  5 +++++
 revision.c                         | 10 +++++++++
 revision.h                         |  1 +
 t/t4217-log-limit.sh               | 32 ++++++++++++++++++++++++++++
 t/t4218-blame-limit.sh             | 34 ++++++++++++++++++++++++++++++
 5 files changed, 82 insertions(+)
 create mode 100755 t/t4217-log-limit.sh
 create mode 100755 t/t4218-blame-limit.sh

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
index 7d435f8048..ee933a11c7 100644
--- a/revision.c
+++ b/revision.c
@@ -1440,6 +1440,9 @@ static int limit_list(struct rev_info *revs)
 		if (revs->min_age != -1 && (commit->date > revs->min_age) &&
 		    !revs->line_level_traverse)
 			continue;
+		if (revs->max_age_as_filter != -1 &&
+			(commit->date < revs->max_age) && !revs->line_level_traverse)
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
index 0000000000..587cd0e386
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
+test_expect_success 'git log --since-as-filter=...' '
+	git log --since-as-filter="2022-01-01" --format=%s >actual &&
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

