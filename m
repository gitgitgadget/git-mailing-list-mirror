Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C29D0FA3740
	for <git@archiver.kernel.org>; Fri, 28 Oct 2022 19:50:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbiJ1TuA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Oct 2022 15:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbiJ1Ttt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2022 15:49:49 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D870E9C22C
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:49:44 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z3so5479500iof.3
        for <git@vger.kernel.org>; Fri, 28 Oct 2022 12:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+8gs9XE2ovM4fsuxGfwrysFltUp/IgfMGCeACLdEBSk=;
        b=CVPL2n8bRrMRbI2reLu5Id3HjI3zpPoy9gR/YkAsWCHUYTCvnqJW5SHUOi7SNwh+6e
         NtwX3k5NDYM0W4JDkr+oMkuHfkoeCAm13lJBd+PBK9NM08uV+fs9FfZVlgG/lm2iHizf
         roE/7pXfHpB9gLZwl/XVqr+aRg4i63nlvKaBFa1f23izDcMKz5yY6kqUgADJ+8Vhoyql
         JhgJTjl9Ug+VwlnUS/mgo5YTfAMKsZ6+caPJ7BseaQSNjogANdQqYEsWLhRtGiQguqRr
         Hqd2fol58JtSrnIa2AqEZ5p8zpVUBl6BpmGD100aDJnmV4aUnhr56SL9gSxb7TJTprsz
         txCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+8gs9XE2ovM4fsuxGfwrysFltUp/IgfMGCeACLdEBSk=;
        b=4aV4FkxSWtbt6w1L9pbhTxMTiluin5Rq2HCJsdvpqo83//dB06y+FwfgldQECy+Kto
         HQmZPQU/1G9uWd3XEmepy3qZJXTeUpbCiGd66ZubmnXYuLof6Y8PYKFSY1RwJ6OjTunT
         EgN1uGdMJ+AnzYLM5ftGFBoWy+7gyDb3ryEe0PR7MD30zq/6HYLpP8Awff4slEI/3wa7
         OwWs86n/k5sIJFW+V44cu4lm4Ks8tUDYdhp45ugrhRu/aM5zYM6szeBK8/kyOt2obLaE
         +FCO20oCjcuIvG+OaF0X0biOMFKq5GbiVkJUmFzvYxHvfixheK0BlmhhZe5bgHzRgpEh
         bnAA==
X-Gm-Message-State: ACrzQf1J+sxU4Z12T7NtfSDC94T5BaoVD2yVNUlGsvtXFRVWq1gX0BpL
        VE4c3EC+qp/GPwb8X4z6EgNVNWNacXBS/djF
X-Google-Smtp-Source: AMsMyM5AvLYP6oZ6620Jm3U2hy5s2SXRcmYm41tJXWPGOyBtg/iz2Knq56mpxnWKBxKbj3V2ZKXuUA==
X-Received: by 2002:a5e:9e01:0:b0:6a4:f730:624c with SMTP id i1-20020a5e9e01000000b006a4f730624cmr574479ioq.107.1666986584299;
        Fri, 28 Oct 2022 12:49:44 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n8-20020a056602340800b006ca9e36fec8sm746505ioz.54.2022.10.28.12.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Oct 2022 12:49:43 -0700 (PDT)
Date:   Fri, 28 Oct 2022 15:49:42 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 0/3] Implement filtering repacks
Message-ID: <Y1wyVpHprWGxEDi/@nand.local>
References: <20221012135114.294680-1-christian.couder@gmail.com>
 <xmqqilkm9wv6.fsf@gitster.g>
 <CAP8UFD2HX6rK4TRP6ynUzWn4eoHa1FrbiFOtxBaxX-ZkBF3FJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2HX6rK4TRP6ynUzWn4eoHa1FrbiFOtxBaxX-ZkBF3FJw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 20, 2022 at 01:23:02PM +0200, Christian Couder wrote:
> On Fri, Oct 14, 2022 at 6:46 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > For example one might want to clone with a filter to avoid too many
> > > space to be taken by some large blobs, and one might realize after
> > > some time that a number of the large blobs have still be downloaded
> > > because some old branches referencing them were checked out. In this
> > > case a filtering repack could remove some of those large blobs.
> > >
> > > Some of the comments on the patch series that John sent were related
> > > to the possible data loss and repo corruption that a filtering repack
> > > could cause. It's indeed true that it could be very dangerous, and we
> > > agree that improvements were needed in this area.
> >
> > The wish is understandable, but I do not think this gives a good UI.
> >
> > This feature is, from an end-user's point of view, very similar to
> > "git prune-packed", in that we prune data that is not necessary due
> > to redundancy.  Nobody runs "prune-packed" directly; most people are
> > even unaware of it being run on their behalf when they run "git gc".
>
> I am Ok with adding the --filter option to `git gc`, or a config
> option with a similar effect. I wonder how `git gc` should implement
> that option though.
>
> If we implement a new command called for example `git filter-packed`,
> similar to `git prune-packed`, then this new command will call `git
> pack-objects --filter=...`.

Conceptually, yes, the two are similar. Though `prune-filtered` is
necessarily going to differ in implementation from `prune-packed`, since
we will have to write new pack(s), not just delete loose objects which
appear in packs already.

So it's really not just a matter of purely deleting redundant loose
copies of objects like in the case of prune-packed. Here we really do
care about potentially writing a new set of packs to satisfy the new
filter constraint.

Presumably that tool would implement creating the new packs according to
the given --filter, and would similarly delete existing packs. That is
basically what your implementation in repack already does, so I am not
sure what the difference would be.

> Yeah. So to sum up, it looks like you are Ok with `git gc
> --filter=...`  which is fine for me, even if I wonder if `git repack
> --filter=...` could be a good first step as it is less likely to be
> used automatically (so safer in a way) and it might be better for
> implementation related performance reasons.

If we don't intend to have `git repack --filter` part of our backwards
compatibility guarantee, then I would prefer to see the implementation
just live in git-gc from start to finish.

Thanks,
Taylor
