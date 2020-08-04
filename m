Return-Path: <SRS0=W4Po=BO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFA1C433DF
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22408207FC
	for <git@archiver.kernel.org>; Tue,  4 Aug 2020 20:10:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="kLXxEZWf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726964AbgHDUKK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Aug 2020 16:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725981AbgHDUKJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Aug 2020 16:10:09 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44874C06174A
        for <git@vger.kernel.org>; Tue,  4 Aug 2020 13:10:09 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id l6so39616744qkc.6
        for <git@vger.kernel.org>; Tue, 04 Aug 2020 13:10:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Uz+p6u172Eb/oOh2JutOA9muZtnK8kaJ/6EbEi3uIig=;
        b=kLXxEZWf9ejCr+0yQ9Cs1olcwzRMjVezOcm8f0MZjcsKlaXH1QXvHuaKOMTJMQ1lld
         oL4Lr9Ql/Oza8lfZ+P34zLFOLIdXplfP355XDyu2G0Ojx6Wny7SHjFndUHu9yMZlfDK3
         IZChvxEnwMODPSi4vr18tSmIuSFhhW3h8HmVN/LjqEZ1ARrpvNTds8lyqFzZ19lg1SDx
         yEFWiCex0bxQz7YpvYG+E9cA0hcOMUcbIE+N2+d2sURBXgBJPTpt+QbtWOGCy60D3S0F
         r0DD0GyVXxt5rIXM7pbNJ7bSegeBpjFtZDY/DgTxZwEZ8PdiOuYbL4bPvS4nNdwbEw1W
         DjwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Uz+p6u172Eb/oOh2JutOA9muZtnK8kaJ/6EbEi3uIig=;
        b=t/8nxOM6shxH5E+FlfBoeG3Ln8cLbo8If63RlzTS3EhYyMlr8kXY3ahdXxRCkGbICI
         LOTiUmrZSGuN/0Tny1s4VgP4hfdPvrnP8hmMVxs2LZc7Z8ZHmUVsgriAaH2//zwf8nAq
         quxwpN4i0ESbLAkxAQfr3AcjIEfngXyJUeo7cpynXVXTf8hDpWAx3BGT4jlpgH5stZhG
         BkLNfIns5dMpuW1wQ3bwd91Db7nhhLAI0tmFEYKM19dj7kYhQUggrJyRTPjMB0HBuxrB
         rMG+J9yK0bLkd3xcvFa2amOMLg/QFzbTjjUBfMXZVawxNiEwniH5MjN2gHrBV+EW97v/
         LDhw==
X-Gm-Message-State: AOAM533YjuGDc84WiIKlch+cOVZBPd+QhpFUb7R9vpt8C2WRg5X7+JTd
        DX6IxRzocFQ0hRU3hULO9i54HHhYnE41RR+o
X-Google-Smtp-Source: ABdhPJzQAYw+Q2jcsbLLYqgTT+3GrwOYHb8pP2FXbxXRJcPsQP6u2xXe/PvOTUAJdgwymdmPLEh+lw==
X-Received: by 2002:a05:620a:48:: with SMTP id t8mr23449245qkt.474.1596571808436;
        Tue, 04 Aug 2020 13:10:08 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:4176:744b:cf1a:a7e1])
        by smtp.gmail.com with ESMTPSA id p17sm22313329qkj.69.2020.08.04.13.10.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 13:10:07 -0700 (PDT)
Date:   Tue, 4 Aug 2020 16:10:06 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        dstolee@microsoft.com
Subject: Re: [PATCH 06/10] commit-graph.c: sort index into commits list
Message-ID: <20200804201006.GC89277@syl.lan>
References: <cover.1596480582.git.me@ttaylorr.com>
 <b31c60d71266c40ae23a619d5ac5fd99148e1649.1596480582.git.me@ttaylorr.com>
 <8bf3b41e-a597-3691-66e0-2be2f5f7e15e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8bf3b41e-a597-3691-66e0-2be2f5f7e15e@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 04, 2020 at 08:31:53AM -0400, Derrick Stolee wrote:
> On 8/3/2020 2:57 PM, Taylor Blau wrote:
> > For locality, 'compute_bloom_filters()' sorts the commits for which it
> > wants to compute Bloom filters in a preferred order (cf., 3d11275505
> > (commit-graph: examine commits by generation number, 2020-03-30) for
> > details).
> >
> > The subsequent patch will want to recover the new graph position of each
> > commit. Since the 'packed_commit_list' already stores a double-pointer,
> > avoid a 'COPY_ARRAY' and instead keep track of an index into the
> > original list. (Use an integer index instead of a memory address, since
> > this involves a needlessly confusing triple-pointer).
>
> It took me a little while to grok that we are switching from sorting
> a list of commit pointers to sorting a list of integers. However, that
> makes a lot of sense. It preserves the commit list sorted by OID for
> binary search, which you will need soon. Perhaps another change would
> need that at another time, too.

Yeah. I had to spend some additional time with this patch (at least back
when it was written in terms of 'struct commit ***'s) to convince myself
of its correctness, too.

I think that this is ultimately the right thing, and that it is probably
as simple as I can make it without refactoring the packed_commit_list,
which I think is squarely outside the scope of this (already-large)
series ;).

> > Alter the two sorting routines 'commit_pos_cmp' and 'commit_gen_cmp' to
> > take into account the packed_commit_list they are sorting with respect
> > to. Since 'compute_bloom_filters()' is the only caller for each of those
> > comparison functions, no other call-sites need updating.
>
> Parsing the changes to these functions is the most complicated, because
> of the int-to-commit indirection. I think they are correct and as easy
> to read as possible.
>
> -Stolee

Thanks,
Taylor
