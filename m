Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48EECC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:04:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10B5D22B2C
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 05:04:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730671AbhAZFDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731209AbhAYTYS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:24:18 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D3D6C061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:23:17 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id t63so986424qkc.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iI8cHtoAuB1dWr6MrJCLWuC0nAHi52bbtB2he9xJNe8=;
        b=Hg+jXWTaJ3Opbzpy4HQ1HEeHPmn3xteSRWMS4msvefYMQemEBJYXxrXCWqNv5o6Rhv
         Jw8W3Gl+iX59DlLZHmD4hiTtqxReVZmGoBjNqp4VYf8SVNIlt3qyowkbXn8mVWpyo8hA
         MpQWojpBUiFOSpG6r9fu3I1DFP1cApdqnqEyNMJh9269Df7B249yN6XwM6fH0+Bvde4f
         ayOY/YKlg5kqO8+kwEtE+grsCXHlgBILm24pdAI+S0K7wK7WV5rfXyU81JriuUHjOG00
         /9tJZOsaPe9E5kXnGBmrgA7Ut7wgiDHZfcbTs4uufv3tR+10qbAKPWsUipfLaXiUnVgf
         X79A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iI8cHtoAuB1dWr6MrJCLWuC0nAHi52bbtB2he9xJNe8=;
        b=BjPcHK1PZL6kAXWH7cJ81vWY/37qiVkMADXqzqaXG7M7Fz9BACZ+MFirrBQhylrm3L
         s0GLcpM6Sfj+itfOtcNqJcfE+AmLX4yYef9wj9WTziVkpsWMvNEVZt1AFgFYazbNXrto
         rHvaMmlY8I7Kq6a0heqXGY8IxJHa2vW3SHXOAqgzKjd4W58cfo7cGRnl6ST0/lCm6w8u
         28MuPkShI4Ka+WUU89123LYnd2Ia+7Iyqd+woTetPRWxDhTPXdKFN1hIvUFeDltvwiTT
         EJNLqNNrDzhkeeg3WkMWZxMl3J2OtcLJXHFSjLw2YFAb6aZFzCg1M4o92PEUK+nwH5bv
         scSg==
X-Gm-Message-State: AOAM531ObXuFd/ivUWRQCVc9CjjDvzlUfJoc0FcmsFqJlhJ/DdwoFPNd
        QYsaevVRLutj+mlsFUHcWBQFSQ==
X-Google-Smtp-Source: ABdhPJzOSHw6nlMtCmRbiDNB30ezavckDKPBkztu96L+lcNfyqq7fTNbTStux8+wHUiwgWueJoFRRw==
X-Received: by 2002:a37:8e04:: with SMTP id q4mr2304844qkd.22.1611602596600;
        Mon, 25 Jan 2021 11:23:16 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id 38sm12016030qtb.67.2021.01.25.11.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:23:16 -0800 (PST)
Date:   Mon, 25 Jan 2021 14:23:13 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 1/8] packfile: prepare for the existence of '*.rev'
 files
Message-ID: <YA8aoQK2ABiA64ME@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <6742c15c84bafbcc1c06e2633de51dcda63e3314.1610576805.git.me@ttaylorr.com>
 <YAtXmie2kHNrcBwY@coredump.intra.peff.net>
 <YA8DlQwSzNZXq+AU@nand.local>
 <xmqqy2ggyh1a.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy2ggyh1a.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 25, 2021 at 11:04:33AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >> Thinking out loud a bit: a .rev file means we're spending an extra map
> >> per pack (but not a descriptor, since we close after mmap). And like the
> >> .idx files (but unlike .pack file maps), we don't keep track of these
> >> and try to close them when under memory pressure. I think that's
> >> probably OK in terms of bytes. It may mean running up against operating
> >> system number-of-mmap limits more quickly ...
> >> ...
> >> >  	if (ends_with(name, ".idx"))
> >> >  		return 3;
> >> > -	return 4;
> >> > +	if (ends_with(name, ".rev"))
> >> > +		return 4;
> >> > +	return 5;
> >> >  }
> >>
> >> Probably not super important, but: should the .idx file still come last
> >> here? Simultaneous readers won't start using the pack until the .idx
> >> file is present. We'd probably prefer they see the whole thing
> >> atomically, than see a .idx missing its .rev (they won't ever produce a
> >> wrong answer, but they'll generate the in-core revindex on the fly when
> >> they don't need to).
>
> At some point, we may want to
>
>  - introduce .idx version 3 that is more extensible, so that the
>    reverse info is included in one of its chunks;

I'm not opposed to doing so outside of this series. I'd be fine with
resurrecting the series that Stolee posted a while ago to extract a
"chunk writer" API (for using in the commit-graph and MIDX code) to also
be used here.

That got stalled out because of the conflicts that it would have
produced with Abhishek's work, but now that that's getting picked up it
could move forward.

But brian is also working on an index v3 for some hash transition stuff,
so I'd rather let that settle first.

Of course, you could combine those efforts, but I don't think that what
we have here is such a bad interim state.

>  - make the .rev data for all packs stored as a chunk in .midx, so
>    we can first check with .midx and not open any .rev files.

This is trickier than you might think because of how the MIDX selects
a pack when more than one pack contains a given object. There is also
the concept of a "multi-pack reverse index" which you can think of as
the reverse index for a pack that is more-or-less concatenating all of
the objects in the MIDX together (in pack order). That is the same order
we'll use to lay out the bits of a multi-pack bitmap, eventually.

> either of which would reduce the numberfrom 30k down to 10k ;-)

Your ";-)" is a good reminder that there are probably many other
problems with having 30k (or even 10k!) packs that would make solving
this (index v3 + MIDX chunk) not worthwhile.

Thanks,
Taylor
