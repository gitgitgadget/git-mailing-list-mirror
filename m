Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46B5EC43334
	for <git@archiver.kernel.org>; Tue, 26 Jul 2022 00:46:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbiGZAp7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbiGZAp6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 20:45:58 -0400
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9687526544
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 17:45:53 -0700 (PDT)
Received: by mail-qv1-xf2e.google.com with SMTP id b11so5078431qvo.11
        for <git@vger.kernel.org>; Mon, 25 Jul 2022 17:45:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=V3yWp7k2ApEEGfFJZU1bBg+5UQjz9EQ0T0cYCsAMpCE=;
        b=Zk8G7cDPczdyMfn11LJtW5tdYbUZR1IUF7Jcw8SYdt1NxTRpFK+YQeQtxYdUe9qvKa
         3GiHLyIe85wQqT6n4pWAJm5WUISC2S5DyHTdBt6wY//IESd4Nh4W7mSo2eoLlw3usMLE
         kP0olhaM+tVEtKFCxbMjXIq06+raaAVgnyHpC9CTfL2dl5NiA6Ts2uXRag5Gk10vWGyW
         V0I+Ue8jRE90g3RWzREVmr2drmANrbc+UfzMsWYqGt2vmRsWORhn7uEUzpR0AXNpBbfN
         fyDGpWskT2gqhz+RcG8fk4dUFEPONxzBjyFGHCn0GKO4LzAMDhm/rYo0s/gbB1A0YzlG
         lKTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=V3yWp7k2ApEEGfFJZU1bBg+5UQjz9EQ0T0cYCsAMpCE=;
        b=wgPqBfJ4R3klnY9srh+uDWM/8lBvXiwtTWMZ/A/4KdFR6J23bO6mQVsQBJqEhAgFSn
         KEP/iM6m3QsUJNvngCmPD1JjXLYyHRQaB9K74l8Uw0C+mLyQjtsfbcVTrryng4OFgfMN
         +zG/X864wJL7+Wzc9TK0fVTWPQl6+suKSsNPEfhyZWKvzheRR4T6Vy3VANamlwD3gcvW
         TYGuzFuZhB4xidLLMHn6voAvDEw2z5t85ez3AawJ36cFZ0rxdEUAA8MOIEGLpqZShmUD
         o64S4+4gyJChgGrrfVlhOiUvzOzC7wzKTx6eeWfkPQO+HeKp8MLKksiTvmcvHp028Ipj
         5xHw==
X-Gm-Message-State: AJIora/u/JABDa6JocVVjPzQjU2WtkHRxQ5DxSIi/zu4WhDPCFtL8SY2
        vXneVtmfAbD+ows54Vc+osA3Zw==
X-Google-Smtp-Source: AGRyM1tJA1CC7eYSFf5fpMn2TLRxfKLx6ZRseV0o0jHL/7uf65Aen1bFnjvf9AGRc0xu4gAJ24UUvw==
X-Received: by 2002:a05:6214:3002:b0:470:7273:bee5 with SMTP id ke2-20020a056214300200b004707273bee5mr12457455qvb.98.1658796352560;
        Mon, 25 Jul 2022 17:45:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id y5-20020a05620a44c500b006b4880b08a9sm9451213qkp.88.2022.07.25.17.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 17:45:52 -0700 (PDT)
Date:   Mon, 25 Jul 2022 20:45:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Martin gren <martin.agren@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Abhradeep Chakraborty via GitGitGadget 
        <gitgitgadget@gmail.com>, git <git@vger.kernel.org>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v3 4/6] pack-bitmap: prepare to read lookup table
 extension
Message-ID: <Yt85P8p3ePW5WWWc@nand.local>
References: <pull.1266.v2.git.1656249017.gitgitgadget@gmail.com>
 <pull.1266.v3.git.1656924376.gitgitgadget@gmail.com>
 <e64362621d235f2c79f52e984de7a2a2794e2842.1656924376.git.gitgitgadget@gmail.com>
 <YtDVDu7VKgAcvRse@nand.local>
 <CAPOJW5y+ywbiT2XBYYNN+y73+V98Ro33D1bgZQveQLTPfrgE_g@mail.gmail.com>
 <YtHoJ90N6rmDmn6M@nand.local>
 <CAN0heSoA=wv4syJ3VOe92QPpjPHyqUPJ8+Pv+mbB0-TiiieVmw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAN0heSoA=wv4syJ3VOe92QPpjPHyqUPJ8+Pv+mbB0-TiiieVmw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Martin,

> > > > The comment you added is definitely helpful, but I still think that this
> > > > line is a little magical. `*va` isn't really a pointer to a `uint32_t`,
> > > > but a pointer to the start of a triplet, which just *happens* to have a
> > > > 4-byte integer at the beginning of it.
>
> Yeah, this all looks quite magical with the casting, and with the
> asymmetric handling of `va` and `vb`.

Yeah, this was my main point (which I didn't intend to create as much of
a digression with as I appear to have!).

The handling here is all correct, but what I was saying was that even
though we're treating `*vb` as a pointer to a `uint32_t`, reading vb[1]
is bogus, since there isn't another 32-bit value there.

So I was saying that you *could* initialize a triplet struct, assign its
fields appropriately, and then compare `*va` to `triplet->foo`. But I
think setting up a struct to only bother reading the first field is
probably wasteful, hence my suggestion for a clarifying comment.

> > > Are you sure about this? As far as I know, the first parameter of such
> > > comparing functions is always a pointer to the given key that we need
> > > to search for and the second parameter points to each element of an
> > > array.
>
> Yes, that matches my understanding and the man-page for bsearch(3):
>
>   "The compar routine is expected to have two arguments which point to
>   the key object and to an array member, in that order, [...]"
>
> I think it would help to make this something like
>
>   static int triplet_cmp(const void *key, const void *array_item)
>
> to really highlight this asymmetric nature of this function, or to make
> clear how the values flow through our call-chain through something like
>
>   static int triplet_cmp(const void *commit_pos, const void *table_entry)

Yeah, that makes sense to me. I'm not too attached to either name, both
seem OK to me.

Thanks,
Taylor
