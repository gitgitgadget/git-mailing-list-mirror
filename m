Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D45DC433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC8F6113A
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 15:56:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236597AbhIIP5U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 11:57:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbhIIP5T (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 11:57:19 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C2AC061574
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 08:56:09 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id i6so3329738edu.1
        for <git@vger.kernel.org>; Thu, 09 Sep 2021 08:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=5zAm1wVcp3vRkoE5PPCqZ7xthqnsGnVBI67rwEbaB20=;
        b=UwFfdG7R0DLD1Ag71LWs+Bp8y9IJsntq4WsTYhPk1AOf06+PXfVWXI4+Yot49wATJZ
         MFTq1NqKUuK1qkavoX354OvLX8aPpuPhT6q9qOEAUVM7vPbrxwQxF9IFX1kx8ZN579nH
         5gWWH3HsPvtAEj7stB+Hbz3Dd67vNs6eaDgtqEo0FrhLifjwF0qUzJ12ANfOMh9IEV6B
         CPgfLbi96Wv57edFeryTnCcPoEV9enQUgh4PmHp2EfKb8f+RwnXArm0fs7iPc050xRXe
         MhuJgdVZzU5fpDv3rk5RCWa2TtpfYVn0wbCrY1vh3vncuLvIHbUNl9EnPpewJA22aFd2
         xMUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=5zAm1wVcp3vRkoE5PPCqZ7xthqnsGnVBI67rwEbaB20=;
        b=m1i7sdUtDfGj+WDKdwKwPPeGTpxfrTBBB5uhXOOMtb3kWvUkEUo6m3Ok7BqfjmsN6+
         uDh/HlbtgmNpVUUnfayaPWPrHoTLu8me0ueLDO2NzIQvvmN+N1P0iYhgKbiOYMnnmFhy
         O+g+bM8fEVD7Nuy6jua/6gBCaoJm7azGAvri/vzYifs4cK1gL+QgkmU7G74zouWNBec0
         8/YXwHUktQln5DfsLB79Slnbra+bWfumCZehu5npPLjbWs8gtrBL+eEHa3NeD4M1zBuq
         IS98t0+gRg1iXMWIKE74dNMlA/w333lMP/pUUrSzpfAY6+Fy5RHRRlusUvPQhLfzLSnC
         HEdQ==
X-Gm-Message-State: AOAM5326/6vDBtzfcdPZi1ZRkG8P+ad7kCehgyhVti5nIEbTLvPTt3eH
        9Cq+kOK9j2H9H9UELeiNf4dytzXTtW4udA==
X-Google-Smtp-Source: ABdhPJz7Ga1A2I5zQhwKrtULi9f8Ruqp3yhImo3plEs0oloa5oMwejFWaPPRVa2tgh4VzMjcI1E7NA==
X-Received: by 2002:a05:6402:27cd:: with SMTP id c13mr3863995ede.266.1631202968153;
        Thu, 09 Sep 2021 08:56:08 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id di4sm939049edb.34.2021.09.09.08.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Sep 2021 08:56:07 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH 3/4] midx.c: respect 'pack.writeBitmapHashcache' when
 writing bitmaps
Date:   Thu, 09 Sep 2021 17:50:47 +0200
References: <cover.1631049462.git.me@ttaylorr.com>
 <be8f47e13c612f2fbe4d5f4f49794529b9424664.1631049462.git.me@ttaylorr.com>
 <874kavkfjg.fsf@evledraar.gmail.com> <YTgfuAKJv1rXXm7i@nand.local>
 <87zgsmdu6d.fsf@evledraar.gmail.com> <87v93adr8r.fsf@evledraar.gmail.com>
 <YTogUpdtjsFlbqYM@nand.local>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.0
In-reply-to: <YTogUpdtjsFlbqYM@nand.local>
Message-ID: <8735qdeoa0.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Sep 09 2021, Taylor Blau wrote:

> On Thu, Sep 09, 2021 at 11:34:16AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> In similar spirit as my
>> https://lore.kernel.org/git/87v93bidhn.fsf@evledraar.gmail.com/ I
>> started seeing if not doing the flags via getopt but instead variables &
>> setting the flags later was better, and came up with this on top. Not
>> for this series, more to muse on how we can write these subcommands in a
>> simpler manner (or not).
>
> Sure, I think that everything you wrote here is correct. I don't have a
> strong opinion, really, but one benefit of not manipulating a single
> 'flags' int is that we don't have to do stuff like:
>
>   if (git_config_bool(var, value))
>     opts.flags |=3D FLAG_FOO;
>   else
>     opts.flags &=3D ~FLAG_FOO;
>
> and instead can write `opts.foo =3D git_config_bool(var, value)`.

*nod*

> Of course, the trade-off is that you later have to turn `opts.foo` into
> flags at some point (or pass each option as an individual parameter). So
> nothing's free, and I see it as a toss-up between which is easier to
> read and write.

I think that trade-off is usually a benefit, also in the pack-write.c
etc. case, i.e. you enforce a clear boundary between the built-in and
the underlying API, and don't have to e.g. wonder if some write flag is
handled by verify() (which will just care about the progress flag), as
you pass some moral equivalent of a "struct
all_the_options_for_all_the_things" around between all of them.

I realize trying to solve that problem from a different angle may be how
you ended up going for per-subcommand config reading....

>> I may have discovered a subtle bug in the process, in
>> cmd_multi_pack_index_repack() we end up calling write_midx_internal(),
>> which cares about MIDX_WRITE_REV_INDEX, but only
>> cmd_multi_pack_index_write() will set that flag, both before & after my
>> patch. Are we using the wrong flags during repack as a result?
>
> Only the `write` sub-command would ever want to set that flag, since we
> don't support writing a bitmap after `expire`. So that part seems right,
> but perhaps there is a another problem you're seeing?

In midx_repack() we'll call write_midx_internal(). That function gets
the "flags" we pass to midx_repack() and will check
MIDX_WRITE_REV_INDEX. I haven't checked whether we actually reach that,
but that's what I was wondering, i.e. whether the repack routine would
"write" when repacking, and we missed the flag option there.
