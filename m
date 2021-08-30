Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58216C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:17:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CE7160F4B
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 21:17:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237145AbhH3VS2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 17:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236811AbhH3VS1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 17:18:27 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709DDC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:17:33 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id x2-20020a1c7c02000000b002e6f1f69a1eso387928wmc.5
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=i0Va3DqPJ4fKnBXcFLxaeYsYLhVA5jxWGN2mecSRvKY=;
        b=E/nIrEPFD64MKn3VTufuryDKlMKyzNiNFZkENwZVnhzBQXWB1Eb1gyDvXKPW5lS1qx
         ovIY936X3N+lIQj/REGc95TrVYLBcnJB7xIArGPyMg5+u+QtWUD90auQUElXHH56FVCS
         O+woY27hzVkOGT8VbJ2lVQBWj3j3f0z4Eb6CxBeLzOImoeFnxwLlTI32g7TwCLeS8OKN
         3KvorYomzJ5QRbr7yZv6CtpS9NdSEjMZf71tZ75sZwgtTuzK0+OJlAF1GUo9tvmItDUO
         h0THHF76kNjv6xr0nZXZ6OJPka7euFIDN/Lokod8xN28W1sXsQBzXdc/AX4R/TvgjqUf
         C8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=i0Va3DqPJ4fKnBXcFLxaeYsYLhVA5jxWGN2mecSRvKY=;
        b=h4wtP9YUqKvdG2r+a5g1hprN8x3f47z6enSLQSTwx//5B8V1JYgBnBHPg+r3DAY1e2
         QbTsrnHQ/hRRVy2vaO+2Fm17xGoad1WO60zm2uWxnYFxEXPcFBIixASwC+5arNlCvvi1
         WL/68UiO8J964+G9sipUUFSy0JhL1NNp+mxhLsysHgUIUT2Gg5CY0fC3s3JTcTwOrGM1
         o5GZhevaNbNAZ/3GR4TYWF0EKs71km29tc+k4CnflhBVbboDQhCbynQWAXPEx4DGqXdO
         0xJjtZ77ahrSP/al7RnIKyeWUvyykCyJy742DvM2ot6FIvM/77lHR2CO5E8W+seIq8/x
         Gjfw==
X-Gm-Message-State: AOAM530t0pweXi4d/UCqPiS1C47jbmhXRODRA7Qa0DDXOLpiQ9F/Kuep
        FHwUi/KuWvy7uXh4MZ3J2bM=
X-Google-Smtp-Source: ABdhPJzpeNsjF2oibY/Bj0YeVm8jN0qOxZvMtWGIKddex6ID73BQhq3CSM1yYKQ/JYn/IIt4Su43aQ==
X-Received: by 2002:a7b:cb89:: with SMTP id m9mr907968wmi.123.1630358252149;
        Mon, 30 Aug 2021 14:17:32 -0700 (PDT)
Received: from szeder.dev (84-236-78-211.pool.digikabel.hu. [84.236.78.211])
        by smtp.gmail.com with ESMTPSA id k1sm16778032wrz.61.2021.08.30.14.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 14:17:31 -0700 (PDT)
Date:   Mon, 30 Aug 2021 23:17:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 6/7] [RFC] entry: don't show "Filtering content: ...
 done." line in case of errors
Message-ID: <20210830211730.GL23408@szeder.dev>
References: <20210620200303.2328957-1-szeder.dev@gmail.com>
 <20210620200303.2328957-7-szeder.dev@gmail.com>
 <85ff4cb1-f3e3-4fcb-d9d8-fd294e0df451@web.de>
 <YNKT4Fr/LOGnx9/o@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YNKT4Fr/LOGnx9/o@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 09:52:32PM -0400, Taylor Blau wrote:
> On Mon, Jun 21, 2021 at 08:32:56PM +0200, René Scharfe wrote:
> > Am 20.06.21 um 22:03 schrieb SZEDER Gábor:
> > > RFC!!  Alas, not calling stop_progress() on error has drawbacks:
> > >
> > >   - All memory allocated for the progress bar is leaked.
> > >   - This progress line remains "active", in the sense that if we were
> > >     to start a new progress later in the same git process, then with
> > >     GIT_TEST_CHECK_PROGRESS it would trigger the other BUG() catching
> > >     nested/overlapping progresses.
> > >
> > > Do we care?!  TBH I don't :)
> > > Anyway, if we do, then we might need some sort of an abort_progress()
> > > function...
> >
> > I think the abort_progress() idea makes sense; to clean up allocations,
> > tell the user what happened and avoid the BUG().  Showing just
> > "aborted" instead of "done" should suffice here -- the explanation is
> > given a few lines later ("'foo' was not filtered properly").
> 
> Very well put. I concur that having an abort_progress() API makes sense
> for all of the reasons that you suggest, but also because we shouldn't
> encourage not using what seems like an appropriate API in order to not
> fail tests when GIT_TEST_CHECK_PROGRESS is set.

Ah, damn, I was hoping that I can get away with it :)

