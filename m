Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E837FC43334
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 16:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377021AbiFVQwP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 12:52:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376711AbiFVQvy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 12:51:54 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F25E54248E
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:49:45 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id f14so255953qkm.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 09:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qPu8pTdfVrgBVnVXMR1gh2DXPVblN3T5L3l7XUnW1FE=;
        b=Hg4MbgoLKhEij+pZofeaycIPx4HZAZDWlMgQauitQLbwOiB5JZqmS0v0MMmZGWH4i/
         u9HVYqU12qjC1ECQnWzocMMjkVkZs5iU756FAY9Ebb7hdjD4cysJZBaqZ+G3E/M1e7DH
         hpkskPHF05pGNf7acdWNK2I5CEyUfDw9ezRCNMIsJZEpt7BWneKnhkWFBQPm+BwD+Zjs
         AjmknRrF03jK6NC0DqBfnabV6rVEewdWr1AKbjGAgoEExJD+EnCMtOgZOt/jt9YOXoqm
         RV3LrJuxYehggaq7DcDgPgAM8xqdsrRC9+Sl+cEBbre48x5SDIoW+sdUdK2Sp4gDMCDQ
         jByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qPu8pTdfVrgBVnVXMR1gh2DXPVblN3T5L3l7XUnW1FE=;
        b=s1qRI7CL9cjnGWZnSM5TVda7aaxkt8yhI2Wy1B0zp+ORZofDDcmwVvfL5VC0D+wf/Z
         pRxlIMeCy/jQs6mV8bsiWTaqR37Iy0Qrdra3BgSn8yfyID05xG8aegDZHGfeJfRZ0xdf
         GHhyXAfF+93PwD8ZgpIZfn2NB64RsaNJ9Dtg99KmbqhRO92o+B72SwnLfpyLDcg1Zgrz
         tCULErvhCAZfYVp8AaL7fcjf23+auuiEUgduQfrrlIlVjV/dU00MfyKqUKF/kmhv/YOO
         nC7m3B9mwVWK87bTIf30myXNcn+kwH4xFDlSISLSEyaZ4jY1NiVVatB7o+iY9oBhs53k
         zFyw==
X-Gm-Message-State: AJIora98riHeTEDvR4B1vwQAmxdZHUyxZOFLkeYN2Kh2bKdDJZKefp6h
        pcUmvp5H5WtSy/4ptHmFrvWmQw==
X-Google-Smtp-Source: AGRyM1vUjDcKAmGp25xh13WzQHDC1QZdob2rC3sOmaIZ5fBJZMCQ2JMu4G9U2FcE3fGjXbgF4LCt0g==
X-Received: by 2002:a05:620a:4016:b0:6a6:be5d:f4bd with SMTP id h22-20020a05620a401600b006a6be5df4bdmr3220833qko.382.1655916585008;
        Wed, 22 Jun 2022 09:49:45 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m66-20020a378a45000000b006a981a2c483sm16378478qkd.39.2022.06.22.09.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 09:49:44 -0700 (PDT)
Date:   Wed, 22 Jun 2022 12:49:43 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 2/6] pack-bitmap: prepare to read lookup table extension
Message-ID: <YrNIJ6z+a4++MGQ8@nand.local>
References: <YrDvaMHz9DnjBqLs@nand.local>
 <20220621115212.22383-1-chakrabortyabhradeep79@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220621115212.22383-1-chakrabortyabhradeep79@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 21, 2022 at 05:22:12PM +0530, Abhradeep Chakraborty wrote:
> Taylor Blau <me@ttaylorr.com> wrote:
> > Yeah. The problem here is that we can't record every commit that
> > _doesn't_ have a bitmap every time we return NULL from one of these
> > queries, since there are arbitrarily many such commits that don't have
> > bitmaps.
> >
> > We could approximate it using a Bloom filter or something, and much of
> > that code is already written and could be interesting to try and reuse.
> > But I wonder if we could get by with something simpler, though, which
> > would cause us to load all bitmaps from the lookup table after a fixed
> > number of cache misses (at which point we should force ourselves to load
> > everything and just read everything out of a single O(1) lookup in the
> > stored bitmap table).
> >
> > That may or may not be a good idea, and the threshold will probably be
> > highly dependent on the system. So it may not even be worth it, but I
> > think it's an interesting area to experiemnt in and think a little more
> > about.
>
> Now I got the point. I wonder what if we leave it as it is. How much will
> it affect the code?

I'm not sure, and I think that it depends a lot on the repository and
query that we're running.

I'd imagine that the effect is probably measurable, but small. Each hash
lookup is cheap, but if there are many such lookups (a large proportion
of which end up resulting in "no, we haven't loaded this bitmap yet" and
then "...because no such bitmap exists for that commit") at some point
it is worth it to fault all of the commits that _do_ have bitmaps in and
answer authoritatively.

In other words, right now we have to do two queries when an commit
doesn't have a bitmap stored:

  - first, a lookup to see whether we have already loaded a bitmap for
    that commit

  - then, a subsequent lookup to see whether the .bitmap file itself has
    a bitmap for that commit, but we just haven't loaded it yet

If we knew that we had loaded all of the bitmaps in the file, then we
could simplify the above two queries into one, since whatever the first
one returns is enough to know whether or not a bitmap exists at all.

> > How does this commit_pos work again? I confess I have forgetten since I
> > wrote some of this code a while ago... :-).
>
> It is using recursive strategy. The first call to `stored_bitmap_for_commit`
> function do not have `pos_hint`. So, it uses `bitmap_table_lookup` to find
> the commit position in the list and makes a call to `lazy_bitmap_for_commit`
> function. This function gets the offset and xor-offset using the commit id's
> position in the list. If xor-offset exists, it is using this xor-offset to
> get the xor-bitmap by calling `stored_bitmap_for_commit` again. But this time
> `pos_hint` is xor-offset. This goes on till the last non-xor bitmap has found.

Ahhh. Thanks for refreshing my memory. I wonder if you think there is a
convenient way to work some of this into a short comment to help other
readers in the future, too.

> As I said before, xor-offset should be an absolute value to make it work
> correctly.

Yep, makes sense.

> > Should we print this regardless of whether or not there is a lookup
> > table? We should be able to learn the entry count either way.
>
> No, this is necessary. "Bitmap v1 test (%d entries loaded)" means
> all the bitmap entries has been loaded. It is basically for
> `load_bitmap_entries_bitmap_v1` function which loads all the bitmaps
> One by one. But if there is a lookup table, `prepare_bitmap_git`
> function will not load every entries and thus printing the above
> line is wrong.

Right, that part makes sense to me. But I wonder if we should still
print something, perhaps just "Bitmap v1 test" or "Bitmap v1 test (%d
entries)" omitting the "loaded" part.

Thanks,
Taylor
