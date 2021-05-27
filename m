Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83D2FC47089
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 602EC613C0
	for <git@archiver.kernel.org>; Thu, 27 May 2021 08:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235488AbhE0Ii7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 May 2021 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235284AbhE0Ii7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 May 2021 04:38:59 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014EEC0613CE
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r10so3800756wrj.11
        for <git@vger.kernel.org>; Thu, 27 May 2021 01:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=Mv2+RTSWpB/XqYEOUbrAx2L54DZGVdKQ+82kshkg7UM=;
        b=cLdT3IwVXxjlARvphwAmeNbILL5gp0xJ8YyjaVm6C7PH83wUj1w+Od78BoW09Zkvhg
         bUDm3OEwNOX+CfIFOkaKRr3ox/FA/G3Gd1Io6VJI33xcf2NhgJKDYe1VSikgERWWjb1f
         xzC4S1V5EamnUG8eXJ2CIWlGnjyBtUDUH/AbiH2J0ICSBtFSKIq74kd5c6uQzjSeBKHN
         Sg5Oca1ctE4W0EMjTMK3K9gDFxa2E+ZZz3OfrqluU117gWhaVy9ZnyXkRYzwZnHDRiIq
         gU+rPCmrIqNc0hTW2hr43kyduDiO3M/LA6Pzfj4B+oifCmmf68XchNajnpqyb9ttn/we
         vV7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=Mv2+RTSWpB/XqYEOUbrAx2L54DZGVdKQ+82kshkg7UM=;
        b=D6XkwgRcZ8PcHpBErRvxFXRdEcQ5RfpLbgGisWV4ZpLIByf1wtwu0W3dk511gREIXf
         0iRo4GJfKwpvezVoQgNGicLg5qlYMaqMNeZ0pbNMgJL+A3JTHi4FCXKa3ROwkpQnL0+T
         lk+SSJpMoe7Igemd9gx/2qjKNoHTa66dEkkBjbB9R6mkwl2xxOHOA7BNYr7W4/1B2dx9
         lMOuNeBbcAV2jkZYtVvyTtmCBrORx2fSgr2UqbEaqwZgGK0NlAJpxw044swBqiFIC/7R
         IoitMZGzNHydBpkMLCzIT3BLUsWn8WZasnEFAefS6CBpU9pZmldsBjW+aeox/X8EDdnY
         bo+w==
X-Gm-Message-State: AOAM533yIZLWlVWk8LHGuc/6UrTyzSG+wMOUqn4XBkwYzRhp7skmM+2A
        JSTnw9xSz4NAd6pitmyok2EcXD3gl5g=
X-Google-Smtp-Source: ABdhPJx7ygqTaRJCaMTvf14cblxopb4/Ox3bXq8FsCXrUIEwU6ZhZSkdwUK1A2VKwlSuvnqqbx5fZg==
X-Received: by 2002:a05:6000:1544:: with SMTP id 4mr2073018wry.370.1622104644562;
        Thu, 27 May 2021 01:37:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k6sm9517958wmi.42.2021.05.27.01.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 01:37:24 -0700 (PDT)
Message-Id: <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.git.1622104642.gitgitgadget@gmail.com>
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 27 May 2021 08:37:17 +0000
Subject: [PATCH 1/5] merge-ort: replace string_list_df_name_compare with
 faster alternative
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Gathering accumulated times from trace2 output on the mega-renames
testcase, I saw the following timings (where I'm only showing a few
lines to highlight the portions of interest):

    10.120 : label:incore_nonrecursive
        4.462 : ..label:process_entries
           3.143 : ....label:process_entries setup
              2.988 : ......label:plist special sort
           1.305 : ....label:processing
        2.604 : ..label:collect_merge_info
        2.018 : ..label:merge_start
        1.018 : ..label:renames

In the above output, note that the 4.462 seconds for process_entries was
split as 3.143 seconds for "process_entries setup" and 1.305 seconds for
"processing" (and a little time for other stuff removed from the
highlight).  Most of the "process_entries setup" time was spent on
"plist special sort" which corresponds to the following code:

    trace2_region_enter("merge", "plist special sort", opt->repo);
    plist.cmp = string_list_df_name_compare;
    string_list_sort(&plist);
    trace2_region_leave("merge", "plist special sort", opt->repo);

In other words, in a merge strategy that would be invoked by passing
"-sort" to either rebase or merge, sorting an array takes more time than
anything else.  Serves me right for naming my merge strategy this way.

Rewrite the comparison function and remove as many levels of indirection
as possible (e.g. the old code had
    cmp_items() ->
      string_list_df_name_compare() ->
        df_name_compare()
now we just have sort_dirs_next_to_their_children()), and tweak it to be
as optimized as possible for our specific case.  These changes reduced
the time spent in "plist special sort" by ~25% in the mega-renames case.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.622 s ±  0.059 s     5.235 s ±  0.042 s
    mega-renames:     10.127 s ±  0.073 s     9.419 s ±  0.107 s
    just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 64 ++++++++++++++++++++++++++++++++++-------------------
 1 file changed, 41 insertions(+), 23 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 142d44d74d63..367aec4b7def 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2746,31 +2746,50 @@ static int detect_and_process_renames(struct merge_options *opt,
 
 /*** Function Grouping: functions related to process_entries() ***/
 
-static int string_list_df_name_compare(const char *one, const char *two)
+static int sort_dirs_next_to_their_children(const void *a, const void *b)
 {
-	int onelen = strlen(one);
-	int twolen = strlen(two);
 	/*
-	 * Here we only care that entries for D/F conflicts are
-	 * adjacent, in particular with the file of the D/F conflict
-	 * appearing before files below the corresponding directory.
-	 * The order of the rest of the list is irrelevant for us.
+	 * Here we only care that entries for directories appear adjacent
+	 * to and before files underneath the directory.  In other words,
+	 * we do not want the natural sorting of
+	 *     foo
+	 *     foo.txt
+	 *     foo/bar
+	 * Instead, we want "foo" to sort as though it were "foo/", so that
+	 * we instead get
+	 *     foo.txt
+	 *     foo
+	 *     foo/bar
+	 * To achieve this, we basically implement our own strcmp, except that
+	 * if we get to the end of either string instead of comparing NUL to
+	 * another character, we compare '/' to it.
 	 *
-	 * To achieve this, we sort with df_name_compare and provide
-	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
-	 * We use the mode S_IFDIR for everything else for simplicity,
-	 * since in other cases any changes in their order due to
-	 * sorting cause no problems for us.
+	 * The reason to not use df_name_compare directly was that it was
+	 * just too expensive, so I had to reimplement it.
 	 */
-	int cmp = df_name_compare(one, onelen, S_IFDIR,
-				  two, twolen, S_IFDIR);
-	/*
-	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
-	 * that 'foo' comes before 'foo/bar'.
-	 */
-	if (cmp)
-		return cmp;
-	return onelen - twolen;
+	const char *one = ((struct string_list_item *)a)->string;
+	const char *two = ((struct string_list_item *)b)->string;
+	unsigned char c1, c2;
+
+	while (*one && (*one == *two)) {
+		one++;
+		two++;
+	}
+
+	c1 = *one;
+	if (!c1)
+		c1 = '/';
+
+	c2 = *two;
+	if (!c2)
+		c2 = '/';
+
+	if (c1 == c2) {
+		/* Getting here means one is a leading directory of the other */
+		return (*one) ? 1 : -1;
+	}
+	else
+		return c1-c2;
 }
 
 static int read_oid_strbuf(struct merge_options *opt,
@@ -3481,8 +3500,7 @@ static void process_entries(struct merge_options *opt,
 	trace2_region_leave("merge", "plist copy", opt->repo);
 
 	trace2_region_enter("merge", "plist special sort", opt->repo);
-	plist.cmp = string_list_df_name_compare;
-	string_list_sort(&plist);
+	QSORT(plist.items, plist.nr, sort_dirs_next_to_their_children);
 	trace2_region_leave("merge", "plist special sort", opt->repo);
 
 	trace2_region_leave("merge", "process_entries setup", opt->repo);
-- 
gitgitgadget

