Return-Path: <SRS0=/7R8=BN=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D40C433DF
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4770320722
	for <git@archiver.kernel.org>; Mon,  3 Aug 2020 23:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="huC/EoJ1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbgHCXIS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:08:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728298AbgHCXIR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Aug 2020 19:08:17 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBDADC06174A
        for <git@vger.kernel.org>; Mon,  3 Aug 2020 16:08:17 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id x12so21080305qtp.1
        for <git@vger.kernel.org>; Mon, 03 Aug 2020 16:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bdtDumEmpHDmsgpY/PmldVQ4hqc18hiDKJsaqCW9CKg=;
        b=huC/EoJ1bE393JBL+1YzeumPITh14mJCATVoWETjQ/DP6GQmFAO8U/5LA1l4sJGPG2
         hjmskWzvHnV37k9P7K2EZn//mjKMVLrGDfO6D/YKZ+xYFNKW4Caz6N+/G2F4+Lg4qelG
         g+bexK8paMJr/JzaKWbQlfvSzffJ/j6oWFp8i6UirNzmbpE3D9HV8AWH7Smd8bgn2KWq
         stXNQ7d6OrLX4OlED6Fejrujw96baHKizgMHa9tZuGiseG8q5EHGrJPNR1topOFSyJSt
         aceqkZkGH5qFYBbgfXismsBcDSKW+66cvYi8F2JH8xxinqbT1QB+Q2OIYDYeXhZJOBIg
         tGvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bdtDumEmpHDmsgpY/PmldVQ4hqc18hiDKJsaqCW9CKg=;
        b=a9ljuPL99C4JOiKeGbAIP3pwGeB+HqcW3Qs7lJbCGA6DMFakrb0YDZM4JVi6CZTjXr
         hi/onZETbcVHO0fAuidf60kLOzO7UVAbgWmkLAYME6VmQwOVkyxlVmI1VLjbQ+AgKm5/
         WBm2rdQ/HBWJGdEl/97byKcZbrh9u8XSd09vL8hGky2NBQvNRcnQ/fKA6/Cq6iEPLaC7
         6DEtusDzYTRo2S9um7MH1x3BSP7BfRAeVs7/lDqU0nx7apuUhNINCgT9H+bEt4QVJN9l
         4vCrkME/tJW0vZEM9fO7uYil0t9Pm/zcHAZ7BZ2vT+BpmHnQRLMPpz0JfH4dd9iLBaM8
         /ZpA==
X-Gm-Message-State: AOAM5306xLA8kItmqBC5Epo1p1EzOOwJC4oHA7Js+78Hoog5qfl0u+15
        5amOeKbpbanCNxcSBl5Hg2VHmQ==
X-Google-Smtp-Source: ABdhPJwS9BsST8oihL4oOiXyj4MzGAM25M1E8RorMxF8PswKWucD3w5nsoF7x/i9hicYjirMN+xtsw==
X-Received: by 2002:ac8:4892:: with SMTP id i18mr17030530qtq.360.1596496096793;
        Mon, 03 Aug 2020 16:08:16 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:3475:b417:c07c:c811])
        by smtp.gmail.com with ESMTPSA id 139sm19546893qkl.13.2020.08.03.16.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 16:08:15 -0700 (PDT)
Date:   Mon, 3 Aug 2020 19:08:14 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        sandals@crustytoothpaste.net, steadmon@google.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 01/18] maintenance: create basic maintenance runner
Message-ID: <20200803230814.GA73765@syl.lan>
References: <pull.671.git.1594131695.gitgitgadget@gmail.com>
 <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
 <63ec602a07756a41f8ccddd745562c567a4b3ed7.1595527000.git.gitgitgadget@gmail.com>
 <20200729221905.GB519065@google.com>
 <5cbdb559-3897-961f-4dd3-0bab11848c5b@gmail.com>
 <20200731003022.GA1029866@google.com>
 <a176ddf5-b45b-fb25-8740-96efbd324edf@gmail.com>
 <20200803174654.GA2473576@google.com>
 <20200803224631.GA73022@syl.lan>
 <20200803230134.GA58587@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200803230134.GA58587@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 03, 2020 at 04:01:34PM -0700, Jonathan Nieder wrote:
> Taylor Blau wrote:
> > On Mon, Aug 03, 2020 at 10:46:54AM -0700, Jonathan Nieder wrote:
> >> Derrick Stolee wrote:
> >>> On 7/30/2020 8:30 PM, Jonathan Nieder wrote:
> >>>> Derrick Stolee wrote:
>
> >>>>> If there is a better way to ask "Did my command call 'git gc' (with
> >>>>> no arguments|with these arguments)?" then I'm happy to consider it.
> >>>>
> >>>> My proposal was just to factor this out into a function in
> >>>> test-lib-functions.sh so it's easy to evolve over time in one place.
> >>>
> >>> This is a valuable suggestion, but this series is already too large
> >>> to make such a change in addition to the patches already here.
> >>
> >> Hm, it's not clear to me that this would make the series significantly
> >> larger.
> >
> > I think what Stolee is trying to say is less about a change that would
> > make the series larger, it's about changing an already-large series.
> >
> >> And on the contrary, it would make the code less fragile.  I think this
> >> is important.
> >
> > I'm not sure that I see your argument. What we are really discussing is
> > whether or not we should have a static struct outside of 'cmd_gc()', or
> > a zero-initialized frame local struct within 'cmd_gc()'. I fully
> > understand the arguments in favor of one or the other, but I struggle to
> > grasp that this is worth our time to debate in this much detail.
>
> Sorry for the lack of clarity.  The proposal Stolee is pushing back on
> above is to have a helper in test-lib-functions.sh that tells a test
> whether an event it cares about happened in traces (in this example,
> invocation of "git gc").

Serves me right for reading too quickly ;).

> I consider it important because if we are getting into the habit of
> having our tests assume the current exact byte-for-byte trace JSON
> output, then that is an assumption that is going to be painful to
> unravel.  Factoring out a helper would also make the test easier to
> read, but that is less important than "an ounce of prevention is worth
> a pound of cure" to me in this example.

I still only partially buy into this, though. I had to deal with some
rather fragile grepping through trace2 JSON in t4216 (? or something,
the log-bloom tests) recently, and found it a little fragile, but not
overly so.

I'd rather just move forward, but I do feel strongly that we discuss
these matters on the list.

> Jonathan

Thanks,
Taylor
