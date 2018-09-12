Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F3E941F404
	for <e@80x24.org>; Wed, 12 Sep 2018 22:44:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbeIMDuv (ORCPT <rfc822;e@80x24.org>);
        Wed, 12 Sep 2018 23:50:51 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:37319 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbeIMDuv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Sep 2018 23:50:51 -0400
Received: by mail-wr1-f68.google.com with SMTP id u12-v6so3650587wrr.4
        for <git@vger.kernel.org>; Wed, 12 Sep 2018 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=bhTfbE96Cu1SLNHjPtNwsdcAudYOxK0xNpK3Yhz68OE=;
        b=G4ypR46CwMu27KWngqMGdEgKnPaY4JYWLpbDDPzN9LlDwfiaGgSw7QQvlFUQeSUYM2
         FErjbVOoi/1340LT1IJMNbkBKhIxKU1ZiutzLMH2K5EQgGexgzm8cX2g8WrMKmarrZ/D
         54jbdcaZ4o2VuniI1SXzwTLYUBKPEvn9b8G3CPquF/gbkRBw93SudVmMZEUAZ9e34JGV
         Tly3z27YSa+YLVFYIvqv8NwjYDi/KQpynVx4EvM1yQiI4WhhODCHEAHy0cV1dTUengBj
         fDylTNOLowde0q3D666jIdElZLg8NzUpac0g6Zh+1qiV+YGbGM+2thduK+I2KxZpBSF0
         RVrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=bhTfbE96Cu1SLNHjPtNwsdcAudYOxK0xNpK3Yhz68OE=;
        b=BSoSPloL2dvub4BTS8+39hYblqpIrxFspE6g+THAfJnalTIuVMDeLsj4OuLgHqYZOK
         a0Jha/zUeAMppXaEWSOYC1Xcz8F+SZ53wjXZh2U68kE7lo6nl311aY7FEL4XF4r9zqyk
         v8wPr5839kgnUw/ESKAvuR72If94Pys1MZUNXQE2WEUtp/zZ8oej2c/05dpK+GRvXrcn
         BOz0kZRpXV97xl5r3d96E8PHCEYQArGYRNNQt2izBwpUDFNOQXCaQt71Pq4sZnPHvaG+
         I5q9m3fLpn5hTRaaU16uggn0988o5v/WEF+yLhL491bEjkHgP7LAWLdfihJYcJGlq0SG
         p7YQ==
X-Gm-Message-State: APzg51BjrefMczgMWkqGtiQiekDVahZjEwSDre3ikwA2DitxAka1P+xp
        l75RsbI78bOVgn08dS8OUPo=
X-Google-Smtp-Source: ANB0VdYwZKA4aUtv+DIN7WeCZMHgjALassxqvgWXs752op9tVZh9o9s8SGjFdZGueZB2xGAbM/MjKQ==
X-Received: by 2002:a5d:4250:: with SMTP id s16-v6mr3075594wrr.260.1536792251781;
        Wed, 12 Sep 2018 15:44:11 -0700 (PDT)
Received: from localhost ([2.29.27.208])
        by smtp.gmail.com with ESMTPSA id l16-v6sm1562998wmc.38.2018.09.12.15.44.10
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 12 Sep 2018 15:44:10 -0700 (PDT)
Date:   Wed, 12 Sep 2018 23:44:10 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <stolee@gmail.com>, ryenus <ryenus@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] linear-assignment: fix potential out of bounds memory
 access
Message-ID: <20180912224410.GB1719@hank.intra.tgummerer.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
 <20180911163419.GB4865@hank.intra.tgummerer.com>
 <20180911172903.GC4865@hank.intra.tgummerer.com>
 <20180912190108.GE4865@hank.intra.tgummerer.com>
 <xmqqy3c6jx1m.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy3c6jx1m.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:

> > --- >8 ---
> >
> > Subject: [PATCH] linear-assignment: fix potential out of bounds memory access
> >
> > Currently the 'compute_assignment()' function can may read memory out
> > of bounds, even if used correctly.  Namely this happens when we only
> > have one column.  In that case we try to calculate the initial
> > minimum cost using '!j1' as column in the reduction transfer code.
> > That in turn causes us to try and get the cost from column 1 in the
> > cost matrix, which does not exist, and thus results in an out of
> > bounds memory read.
> 
> This nicely explains what goes wrong.
> 
> > Instead of trying to intialize the minimum cost from another column,
> > just set it to INT_MAX.  This also matches what the example code in the
> > original paper for the algorithm [1] does (it initializes the value to
> > inf, for which INT_MAX is the closest match in C).
> 
> Yeah, if we really want to avoid INT_MAX we could use another "have
> we found any value yet?" boolean variable, but the caller in
> get_correspondences() does not even worry about integer overflows
> when stuffing diffsize to the cost[] array, and the other possible
> value that can go to cost[] array is COST_MAX that is mere 65k, so
> it would be OK to use INT_MAX as sentinel here, I guess.

Right, I'm not sure it would be worth introducing another boolean
variable here.  In the normal case we'll always enter the if condition
inside the loop, and set a reasonable 'min' value.

That does not happen if we only have one column, and the 'min' will
remain 'INT_MAX'.  Now in that case it doesn't matter much, as having
only one column means there's no possibility to assign anything, so
the actual values shouldn't matter (at least that's my understanding
of the algorithm so far).

Another improvement we may be able to make here is to not even try to
compute the assignment if there's only one column for that reason, but
I'm out of time today and the rest of my week looks a bit busy, so I
probably won't get to do anything before the beginning of next week.

> > Note that the test only fails under valgrind on Linux, but the same
> > command has been reported to segfault on Mac OS.
> >
> > Also start from 0 in the loop, which matches what the example code in
> > the original paper does as well.  Starting from 1 means we'd ignore
> > the first column during the reduction transfer phase.  Note that in
> > the original paper the loop does start from 1, but the implementation
> > is in Pascal, where arrays are 1 indexed.
> >
> > [1]: Jonker, R., & Volgenant, A. (1987). A shortest augmenting path
> >      algorithm for dense and sparse linear assignment
> >      problems. Computing, 38(4), 325–340.
> >
> > Reported-by: ryenus <ryenus@gmail.com>
> > Helped-by: Derrick Stolee <stolee@gmail.com>
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >  linear-assignment.c   | 4 ++--
> >  t/t3206-range-diff.sh | 5 +++++
> >  2 files changed, 7 insertions(+), 2 deletions(-)
> >
> > diff --git a/linear-assignment.c b/linear-assignment.c
> > index 9b3e56e283..7700b80eeb 100644
> > --- a/linear-assignment.c
> > +++ b/linear-assignment.c
> > @@ -51,8 +51,8 @@ void compute_assignment(int column_count, int row_count, int *cost,
> >  		else if (j1 < -1)
> >  			row2column[i] = -2 - j1;
> >  		else {
> > -			int min = COST(!j1, i) - v[!j1];
> > -			for (j = 1; j < column_count; j++)
> > +			int min = INT_MAX;
> > +			for (j = 0; j < column_count; j++)
> >  				if (j != j1 && min > COST(j, i) - v[j])
> >  					min = COST(j, i) - v[j];
> >  			v[j1] -= min;
> > diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> > index 2237c7f4af..fb4c13a84a 100755
> > --- a/t/t3206-range-diff.sh
> > +++ b/t/t3206-range-diff.sh
> > @@ -142,4 +142,9 @@ test_expect_success 'changed message' '
> >  	test_cmp expected actual
> >  '
> >  
> > +test_expect_success 'no commits on one side' '
> > +	git commit --amend -m "new message" &&
> > +	git range-diff master HEAD@{1} HEAD
> > +'
> > +
> >  test_done
