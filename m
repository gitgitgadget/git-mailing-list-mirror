Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDCEFC4708F
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:39:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA5456140C
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 04:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbhFDElm (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 00:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhFDEll (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 00:41:41 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26672C061760
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 21:39:42 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id l2so7921248wrw.6
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 21:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=JV6/yV6L+ug2kZ4orpy9UwnPTOXis0VPLVJ/TIDN7Gw=;
        b=Vf6QA2Rw96ApayC9MAQJ7j9Tg8R2DZoJ1a6DpWQVxZpMfvtY/LaHt0amo4UGGnFmPB
         EC5jVLFtZzage6fMKevgvKrUnemBbWg6o0KoHkHEORx+PGvyg9C71oWb+tYnpsa+WMJt
         7w22PBJXqNar1B9d/T8lO5INcb7qCLRjDE08a1YfnQZ00zAyNYnRek5sY+hQ2q3WPm6F
         ZpKOAtVSSEfkVa5+/99K+1SDe/e0ND06oF6irA31WJRzTq50Ovo61OUBZJOiML+6+qX7
         3FI8oSLnuXTkkrfrN+Pl98mhJrw/yJlZil+dDfVMzzqN8+US0RjQRuvsTZ5576DxJHjW
         ONXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=JV6/yV6L+ug2kZ4orpy9UwnPTOXis0VPLVJ/TIDN7Gw=;
        b=TV3ggo9dLBTVfFuQfpRspHqNcVA1mdC0d18vzQAdBUsH5nwodiaiXFdK0nowtx6CpU
         Jlr29wVOW6jqzA81UcwCw4bVwpoyQ3e10s3wXVOSKYFjFIJVZ/+v1MMPSUU5x/fOadrm
         nsk1K2JBbXRdu2GUmvkqC9keQRb5ya0rqg9nx6ykL2GjK2149d8Be6SmPjRo4ZPJbhPd
         tp5BWwkEEhPsYBpVS9ceUaCHb51ghXORwC92B8zBoF0FTvgRL5cf9O3WreMcHegIgmmD
         Ic2SbIN7RroAZwM0pLofHy8kEGkuhWl94kU2KT3lz8o00qfn1agsn1BDU1PSdIyLaliZ
         bzHA==
X-Gm-Message-State: AOAM5331vuLH7Jt8o/rEeAQzMqEbEcJZ51aoWo0LqPk3PTjk8x3+8urG
        hu+OyEZAkVn/FGwGXc8cuHA8iQFTD9E=
X-Google-Smtp-Source: ABdhPJwJFSyHNBdSknXoqhRM+TLu/qhQHHAhiIARuSg0Z7ITZ5C4cdwzBZgyADkAsdXs02U93Yj+5g==
X-Received: by 2002:a05:6000:2ca:: with SMTP id o10mr1666430wry.234.1622781580679;
        Thu, 03 Jun 2021 21:39:40 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 89sm5639575wrq.14.2021.06.03.21.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 21:39:40 -0700 (PDT)
Message-Id: <f63ffc2a7c22faea9ffea9abbd95595b6a1196de.1622781578.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
References: <pull.962.v2.git.1622559516.gitgitgadget@gmail.com>
        <pull.962.v3.git.1622781578.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 04 Jun 2021 04:39:35 +0000
Subject: [PATCH v3 1/4] merge-ort: replace string_list_df_name_compare with
 faster alternative
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
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

Rewrite the comparison function in a way that does not require finding
out the lengths of the strings when comparing them.  While at it, tweak
the code for our specific case -- no need to handle a variety of modes,
for example.  The combination of these changes reduced the time spent in
"plist special sort" by ~25% in the mega-renames case.

For the testcases mentioned in commit 557ac0350d ("merge-ort: begin
performance work; instrument with trace2_region_* calls", 2020-10-28),
this change improves the performance as follows:

                            Before                  After
    no-renames:        5.622 s ±  0.059 s     5.235 s ±  0.042 s
    mega-renames:     10.127 s ±  0.073 s     9.419 s ±  0.107 s
    just-one-mega:   500.3  ms ±  3.8  ms   480.1  ms ±  3.9  ms

Signed-off-by: Elijah Newren <newren@gmail.com>
Acked-by: Derrick Stolee <dstolee@microsoft.com>
---
 merge-ort.c | 67 +++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 47 insertions(+), 20 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 142d44d74d63..061f15701359 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -2746,31 +2746,58 @@ static int detect_and_process_renames(struct merge_options *opt,
 
 /*** Function Grouping: functions related to process_entries() ***/
 
-static int string_list_df_name_compare(const char *one, const char *two)
+static int sort_dirs_next_to_their_children(const char *one, const char *two)
 {
-	int onelen = strlen(one);
-	int twolen = strlen(two);
+	unsigned char c1, c2;
+
 	/*
-	 * Here we only care that entries for D/F conflicts are
-	 * adjacent, in particular with the file of the D/F conflict
-	 * appearing before files below the corresponding directory.
-	 * The order of the rest of the list is irrelevant for us.
+	 * Here we only care that entries for directories appear adjacent
+	 * to and before files underneath the directory.  We can achieve
+	 * that by pretending to add a trailing slash to every file and
+	 * then sorting.  In other words, we do not want the natural
+	 * sorting of
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
+	 *
+	 * If this unusual "sort as though '/' were appended" perplexes
+	 * you, perhaps it will help to note that this is not the final
+	 * sort.  write_tree() will sort again without the trailing slash
+	 * magic, but just on paths immediately under a given tree.
 	 *
-	 * To achieve this, we sort with df_name_compare and provide
-	 * the mode S_IFDIR so that D/F conflicts will sort correctly.
-	 * We use the mode S_IFDIR for everything else for simplicity,
-	 * since in other cases any changes in their order due to
-	 * sorting cause no problems for us.
+	 * The reason to not use df_name_compare directly was that it was
+	 * just too expensive (we don't have the string lengths handy), so
+	 * it was reimplemented.
 	 */
-	int cmp = df_name_compare(one, onelen, S_IFDIR,
-				  two, twolen, S_IFDIR);
+
 	/*
-	 * Now that 'foo' and 'foo/bar' compare equal, we have to make sure
-	 * that 'foo' comes before 'foo/bar'.
+	 * NOTE: This function will never be called with two equal strings,
+	 * because it is used to sort the keys of a strmap, and strmaps have
+	 * unique keys by construction.  That simplifies our c1==c2 handling
+	 * below.
 	 */
-	if (cmp)
-		return cmp;
-	return onelen - twolen;
+
+	while (*one && (*one == *two)) {
+		one++;
+		two++;
+	}
+
+	c1 = *one ? *one : '/';
+	c2 = *two ? *two : '/';
+
+	if (c1 == c2) {
+		/* Getting here means one is a leading directory of the other */
+		return (*one) ? 1 : -1;
+	} else
+		return c1 - c2;
 }
 
 static int read_oid_strbuf(struct merge_options *opt,
@@ -3481,7 +3508,7 @@ static void process_entries(struct merge_options *opt,
 	trace2_region_leave("merge", "plist copy", opt->repo);
 
 	trace2_region_enter("merge", "plist special sort", opt->repo);
-	plist.cmp = string_list_df_name_compare;
+	plist.cmp = sort_dirs_next_to_their_children;
 	string_list_sort(&plist);
 	trace2_region_leave("merge", "plist special sort", opt->repo);
 
-- 
gitgitgadget

