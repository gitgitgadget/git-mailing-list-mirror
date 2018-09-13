Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71DDC1F404
	for <e@80x24.org>; Thu, 13 Sep 2018 22:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727773AbeINDYq (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Sep 2018 23:24:46 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:46627 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727726AbeINDYp (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Sep 2018 23:24:45 -0400
Received: by mail-wr1-f68.google.com with SMTP id a108-v6so8312458wrc.13
        for <git@vger.kernel.org>; Thu, 13 Sep 2018 15:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cs2Ma+Tr8mLuYjPz1Hs+4W3oC18hhyiYltnderLmyVA=;
        b=TpERB9B7DG35r4wV3Nsce2zGL0mKV1C16NPVTAWyJ1M38ys42u1wOFdqzTUS6dw5Wb
         gNUZBwDqtV7qJUi1gthSc8Ys5hyoEFZS8rUyHDfjRlyBk7O6fmrSP06/lfwZy/a0E3Mp
         NZyJqxh+dO1ORPWNz0CdRVdW8cioHnPbWALhm49g79m1w4l/wteEx4zPbl/XYLxRpItD
         POL/+McQSuKbiix1hGLWeAQrgnVNZCl5sqUM8kqy508rl+NtQfaE0z5gqFwS6djxXOAx
         ZHarpa574sWbouaG8BoKRGGYCVli4/FK5cmV0K0p6fgiyYjU5+jYmYv5FZmb8G9/RvS3
         KGwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=cs2Ma+Tr8mLuYjPz1Hs+4W3oC18hhyiYltnderLmyVA=;
        b=h9AmdIsrp7itrRxJlwmqi/GcBiquRxwvxzbD7Yr/xw+YP41ZTTosJY5B563pkJuptA
         JOmjh+koCwGCsiabv/UWkbVKRW1MAJff7URkZg0+3Cp8KfqVNARoBKlzTjV2/aurtzCa
         wobb5NLBUPoHYo/ackDXv8MlJ1ayk47U0L3Rh4MUMKM8aLnCv75nOOCDbPJXacMgXd6i
         ZZDMLo3ENPv1UVMWBemUs+8uocuJsGuMmaaPfT/5qyXUVbRwBESlZi1hi4icGB36Y2R+
         3bxzkJHzOuiMCtbtDpxUKTIbehKOJX/uDdfb/vCTX98WhA8yD4m10StxjOWnOSFCgrQe
         OiQg==
X-Gm-Message-State: APzg51D2PaTpAbtH6hqADR4l0ln8BmRu/1x6cWBQHVAxqZNDnFc/RgYj
        l/TUkzqTaEFXMitXhuzi0Ho=
X-Google-Smtp-Source: ANB0VdYCjG3GzEUInT2ZW4yRR/54jGe+3QN1JcCD/nxoHma/C/6ZtwNsHIeKmUdqtL3eH3kQ/Xc5Pg==
X-Received: by 2002:adf:e711:: with SMTP id c17-v6mr7260157wrm.143.1536876799246;
        Thu, 13 Sep 2018 15:13:19 -0700 (PDT)
Received: from localhost ([2.28.194.193])
        by smtp.gmail.com with ESMTPSA id j75-v6sm47025wmj.8.2018.09.13.15.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Sep 2018 15:13:18 -0700 (PDT)
Date:   Thu, 13 Sep 2018 23:13:18 +0100
From:   Thomas Gummerer <t.gummerer@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Derrick Stolee <stolee@gmail.com>, ryenus <ryenus@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] linear-assignment: fix potential out of bounds memory
 access (was: Re: Git 2.19 Segmentation fault 11 on macOS)
Message-ID: <20180913221318.GE1719@hank.intra.tgummerer.com>
References: <CAKkAvay6crMOJ0Vm2C9Z0ktBj9n4+RkOAiP+zuG=Sm+PVBgQ+Q@mail.gmail.com>
 <1b8a35be-4234-7f71-c0be-41736bbe60cf@gmail.com>
 <844da493-b1c1-b295-0094-beafd48f3b50@gmail.com>
 <fd241679-2283-4e01-315b-db27be8a794c@gmail.com>
 <20180911163419.GB4865@hank.intra.tgummerer.com>
 <20180911172903.GC4865@hank.intra.tgummerer.com>
 <20180912190108.GE4865@hank.intra.tgummerer.com>
 <nycvar.QRO.7.76.6.1809122136020.73@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1809122136020.73@tvgsbejvaqbjf.bet>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/12, Johannes Schindelin wrote:
> Hi Thomas,
> 
> [quickly, as I will go back to a proper vacation after this]

Sorry about interrupting your vacation, enjoy wherever you are! :)

> On Wed, 12 Sep 2018, Thomas Gummerer wrote:
> 
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
> 
> I am worried about this, as I tried very hard to avoid integer overruns.

Ah fair enough, now I think I understand where the calculation of the
initial value of min comes from, thanks!

> Wouldn't it be possible to replace the `else {` by an appropriate `else if
> (...) { ... } else {`? E.g. `else if (column_count < 2)` or some such?

Yes, I think that would be possible.  However if we're already special
casing "column_count < 2", I think we might as well just exit early
before running through the whole algorithm in that case.  If there's
only one column, there are no commits that can be assigned to
eachother, as there is only the one.

We could also just not run call 'compute_assignment' in the first
place if column_count == 1, however I'd rather make the function safer
to call, just in case we find it useful for something else in the
future.

Will send an updated patch in a bit.

> Ciao,
> Dscho
> 
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
> > -- 
> > 2.19.0.397.gdd90340f6a
> > 
> > 
