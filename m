Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A5401F404
	for <e@80x24.org>; Wed, 12 Sep 2018 19:01:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728001AbeIMAHF (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 20:07:05 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33356 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727047AbeIMAHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 20:07:04 -0400
Received: by mail-wr1-f67.google.com with SMTP id v90-v6so3173743wrc.0
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 12:01:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=BuOC3J8DyUc+zkxiuOzN0k4Xo/YmQL+69CRBN8YLyes=;
        b=jTKsOcdNK67CxOBu/HPPUaM3eNwrKhJFeHzkE8VVNG0Qp3SBirExKQtG8/8X5eEYBE
         U3ODXkxOSds7sMgZAndACpGJwDDHTM1vgvjH9zDYtIv8Es/LPdi0lpcaur+xxn8NEoNB
         TlA1T1jCcVTVkh48pUaa42lLbyaGeQj/bw/2OwX8biBiaRr65FpjQdM1rOG4R6Oy0ThZ
         5dohBH2QlnEyZnDd7HBEwCQHyac7v8uFwi8AQo84zk//bK3IUdNX74JjOif06jSow0aF
         3AvaofV7hULzjj8pfuT8u3bMrR97VvzolddSgBuI4yHdgdTPlDt1I/rOsCXnSVpr6aMq
         xDyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=BuOC3J8DyUc+zkxiuOzN0k4Xo/YmQL+69CRBN8YLyes=;
        b=XkLnKUmPKyMY1PBUqxmUZze+wOBfOedrVH0PvuMF7c+sMTFCCBzE4qJz6DBb6icjMK
         ++VIlwMJs8MVxmmWJ4PCmFB0rCk2gT3qowQpjLO1j1InNGVjH/psEVrKiPpv1hCtnqSR
         zO5zuVJA9m7KpqjzXKImwYFtgvK8mKKJ2T2IfhAm4UUEnWHKMho4QVUTihPWjRvL8dc8
         XuNoPw7LHafrm/YDBOYkuZo/nj1IRUk+uAiptfemyxirjA8Hv3+pflA9a5sOK/PzFiiO
         8S4MPHO1PDntVqsMu5tVxIBRGDsSTbbrpoFeWVCji9cZbO5cv8TDtSq2qI2BbxqfBsez
         uMyg==
X-Gm-Message-State: APzg51BonAez0uoZeWn6UMkxlwf8p9JBGY0d1IcIG2lW4UDQmWqq+6PN
        5yH8YuA1JO2J+3in87erzwC5Acwr
X-Google-Smtp-Source: ANB0VdYueEiZllwgEP6yvebwJS2w/GoOdmBXA/dHfCatIJ6GeX1dweQ9FHS27Uhqmk1pvGxkO1EFvg==
X-Received: by 2002:adf:b357:: with SMTP id k23-v6mr2650781wrd.207.1536778870479;
        Wed, 12 Sep 2018 12:01:10 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id k63-v6sm3061468wmd.46.2018.09.12.12.01.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 12:01:09 -0700 (PDT)
Date:   Wed, 12 Sep 2018 20:01:08 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     ryenus <ryenus@gmail.com>, Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH] linear-assignment: fix potential out of bounds memory access
 (was: Re: Git 2.19 Segmentation fault 11 on macOS)
Message-ID: <20180912190108.GE4865@hank.intra.tgummerer.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
 <20180911163419.GB4865@hank.intra.tgummerer.com>
 <20180911172903.GC4865@hank.intra.tgummerer.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180911172903.GC4865@hank.intra.tgummerer.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/11, Thomas Gummerer wrote:
> On 09/11, Thomas Gummerer wrote:
> > I think you're on the right track here.  I can not test this on Mac
> > OS, but on Linux, the following fails when running the test under
> > valgrind:
> > 
> >     diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> >     index 2237c7f4af..a8b0ef8c1d 100755
> >     --- a/t/t3206-range-diff.sh
> >     +++ b/t/t3206-range-diff.sh
> >     @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
> >             test_cmp expected actual
> >      '
> >      
> >     +test_expect_success 'amend and check' '
> >     +       git commit --amend -m "new message" &&
> >     +       git range-diff master HEAD@{1} HEAD
> >     +'
> >     +
> >      test_done
> > 
> > valgrind gives me the following:
> > 
> > ==18232== Invalid read of size 4
> > ==18232==    at 0x34D7B5: compute_assignment (linear-assignment.c:54)
> > ==18232==    by 0x2A4253: get_correspondences (range-diff.c:245)
> > ==18232==    by 0x2A4BFB: show_range_diff (range-diff.c:427)
> > ==18232==    by 0x19D453: cmd_range_diff (range-diff.c:108)
> > ==18232==    by 0x122698: run_builtin (git.c:418)
> > ==18232==    by 0x1229D8: handle_builtin (git.c:637)
> > ==18232==    by 0x122BCC: run_argv (git.c:689)
> > ==18232==    by 0x122D90: cmd_main (git.c:766)
> > ==18232==    by 0x1D55A3: main (common-main.c:45)
> > ==18232==  Address 0x4f4d844 is 0 bytes after a block of size 4 alloc'd
> > ==18232==    at 0x483777F: malloc (vg_replace_malloc.c:299)
> > ==18232==    by 0x3381B0: do_xmalloc (wrapper.c:60)
> > ==18232==    by 0x338283: xmalloc (wrapper.c:87)
> > ==18232==    by 0x2A3F8C: get_correspondences (range-diff.c:207)
> > ==18232==    by 0x2A4BFB: show_range_diff (range-diff.c:427)
> > ==18232==    by 0x19D453: cmd_range_diff (range-diff.c:108)
> > ==18232==    by 0x122698: run_builtin (git.c:418)
> > ==18232==    by 0x1229D8: handle_builtin (git.c:637)
> > ==18232==    by 0x122BCC: run_argv (git.c:689)
> > ==18232==    by 0x122D90: cmd_main (git.c:766)
> > ==18232==    by 0x1D55A3: main (common-main.c:45)
> > ==18232== 
> > 
> > I'm looking into why that fails.  Also adding Dscho to Cc here as the
> > author of this code.
> 
> The diff below seems to fix it.  Not submitting this as a proper
> patch [...]

I found the time to actually have a look at the paper, so here's a
proper patch:

I'm still not entirely sure what the initial code tried to do here,
but I think staying as close as possible to the original is probably
our best option here, also for future readers of this code.

--- >8 ---

Subject: [PATCH] linear-assignment: fix potential out of bounds memory access

Currently the 'compute_assignment()' function can may read memory out
of bounds, even if used correctly.  Namely this happens when we only
have one column.  In that case we try to calculate the initial
minimum cost using '!j1' as column in the reduction transfer code.
That in turn causes us to try and get the cost from column 1 in the
cost matrix, which does not exist, and thus results in an out of
bounds memory read.

Instead of trying to intialize the minimum cost from another column,
just set it to INT_MAX.  This also matches what the example code in the
original paper for the algorithm [1] does (it initializes the value to
inf, for which INT_MAX is the closest match in C).

Note that the test only fails under valgrind on Linux, but the same
command has been reported to segfault on Mac OS.

Also start from 0 in the loop, which matches what the example code in
the original paper does as well.  Starting from 1 means we'd ignore
the first column during the reduction transfer phase.  Note that in
the original paper the loop does start from 1, but the implementation
is in Pascal, where arrays are 1 indexed.

[1]: Jonker, R., & Volgenant, A. (1987). A shortest augmenting path
     algorithm for dense and sparse linear assignment
     problems. Computing, 38(4), 325–340.

Reported-by: ryenus <ryenus@gmail.com>
Helped-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
---
 linear-assignment.c   | 4 ++--
 t/t3206-range-diff.sh | 5 +++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/linear-assignment.c b/linear-assignment.c
index 9b3e56e283..7700b80eeb 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -51,8 +51,8 @@ void compute_assignment(int column_count, int row_count, int *cost,
 		else if (j1 < -1)
 			row2column[i] = -2 - j1;
 		else {
-			int min = COST(!j1, i) - v[!j1];
-			for (j = 1; j < column_count; j++)
+			int min = INT_MAX;
+			for (j = 0; j < column_count; j++)
 				if (j != j1 && min > COST(j, i) - v[j])
 					min = COST(j, i) - v[j];
 			v[j1] -= min;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 2237c7f4af..fb4c13a84a 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -142,4 +142,9 @@ test_expect_success 'changed message' '
 	test_cmp expected actual
 '
 
+test_expect_success 'no commits on one side' '
+	git commit --amend -m "new message" &&
+	git range-diff master HEAD@{1} HEAD
+'
+
 test_done
-- 
2.19.0.397.gdd90340f6a

