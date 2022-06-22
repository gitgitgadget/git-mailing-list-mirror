Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09656C433EF
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 18:13:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377475AbiFVSNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239459AbiFVSNv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 14:13:51 -0400
Received: from mail-qv1-xf31.google.com (mail-qv1-xf31.google.com [IPv6:2607:f8b0:4864:20::f31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 551EE3C4B9
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 11:13:50 -0700 (PDT)
Received: by mail-qv1-xf31.google.com with SMTP id o43so26342087qvo.4
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 11:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vX/DMH+5M3iXeilTAnOgigU2aIHoZ0Zyk7/F5ukbDs8=;
        b=NEMuRoTbu5VkPS+r5Owbcbe/HkGyTJnOkilFV4Zg86x55U5TqrzmdMS2s7VHgP2hW7
         TghUTHZqodKWQENPkIyoIgFJ950bdDnZ2ojx6MQZQj6bMuhKyfg4zVYw0CuhGE6my1Sf
         PR8rmyVr7cWxv1JAjIFuwYPNfmcuLoPCvRR7ZRWehThN8u6gDgVPcx9JyKjZd1dPJL5z
         roi0FrtQk5aMFrT5QzCpbEhBcmS85DurjkPyEadRyeY34bWomd7FcxLZ5d7nVGfvHBE6
         dr1VxJ+rvDUiPcp1pb6fhSdGbJTaWnEms1kISXwPtRwAhZ0Labjl/NXNvElQuCrKq3EQ
         C8iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vX/DMH+5M3iXeilTAnOgigU2aIHoZ0Zyk7/F5ukbDs8=;
        b=Yvkg83Xwb5eLfjjWwRcUtfyPLSaLbaG17Zre5fwXU31cjcf44v2e3DegdcJmVykcYG
         rCh40lSk4H1FcadPRHOBqOYG0uQmF0fGq4F2yyFuYlJgVGQBHrV2t2HykvEySm2B546U
         wyObTrcSexT3lPixPsLE2YkUpy4k/TOEbQblS9iZhZp4n+YVUb6QBASbLy7nnEhyI8af
         4AsAqwrb0xNB6mV4r55ZoNIAzhcXvkQbd7VN+6Cpszmoj9ijpi4IJpYIjRnXcYEI4X9J
         m4LCgCRbixhfgDl3GVCz1CYLa5pKLHt6z3jAccBGUSopy9gZibEJyy054GF23370l5iz
         6HeA==
X-Gm-Message-State: AJIora/7bEnu3J4eQfVQ0o+2V5X+R+SZ2SGSY/4UNB6KEQ6tWTAOAN1u
        X1RZnbK4wppRmAIMMqzAzVu9Sw==
X-Google-Smtp-Source: AGRyM1tVuLc+daOw2zNDlwAu1HxY2R/qIWB89hQyBrBn9og42sVrVprNj6/ZxYJmXjlWzBwiWDw2/g==
X-Received: by 2002:a05:6214:e4c:b0:470:4804:a620 with SMTP id o12-20020a0562140e4c00b004704804a620mr11287226qvc.16.1655921629393;
        Wed, 22 Jun 2022 11:13:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r1-20020a05620a298100b006a6d74f8fc9sm17933685qkp.127.2022.06.22.11.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 11:13:48 -0700 (PDT)
Date:   Wed, 22 Jun 2022 14:13:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        haoyurenzhuxia@gmail.com, git@vger.kernel.org,
        derrickstolee@github.com, dyroneteng@gmail.com
Subject: Re: [RFC PATCH] midx.c: clean up .rev file
Message-ID: <YrNb2x2/7Z31XnFJ@nand.local>
References: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
 <220622.86a6a4lmdv.gmgdl@evledraar.gmail.com>
 <xmqqo7yk60vf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo7yk60vf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2022 at 10:53:24AM -0700, Junio C Hamano wrote:
> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
> > On Wed, Jun 22 2022, haoyurenzhuxia@gmail.com wrote:
> >
> >> From: Xia XiaoWen <haoyurenzhuxia@gmail.com>
> >>
> >> The command: `git multi-pack-index write --bitmap` will create 3
> >> files in `objects/pack/`:
> >>     * multi-pack-index
> >>     * multi-pack-index-*.bitmap
> >>     * multi-pack-index-*.rev
> >>
> >> But if the command is terminated by the user (such as Ctl-C) or
> >> the system, the midx reverse index file (`multi-pack-index-*.rev`)
> >> is not removed and still exists in `objects/pack/`:
> >>
> >>     $ GIT_TEST_MIDX_WRITE_REV=1 git multi-pack-index write --bitmap
> >>     Selecting bitmap commits: 133020, done.
> >>     Building bitmaps:   0% (3/331)
> >>     ^C^C
> >>
> >>     $ tree objects/pack/
> >>     objects/pack/
> >>     ├── multi-pack-index-3b048d1b965842cd866e10b6ec1a3035dbede0a5.rev
> >>     ├── pack-b7d425f1b01727d5f364f5d9fbab2d1900fcd5c0.idx
> >>     └── pack-b7d425f1b01727d5f364f5d9fbab2d1900fcd5c0.pack
> >> ...
> > Also, the commit message doesn't really say *why*, i.e. in cmd_repack()
> > we've suffered from this already, but don't we have "git gc" cleaning
> > these up? Maybe not (I didn't check), but maybe that was the previous
> > assumption...
>
> Exactly my thought.  Well said.

`repack` relies on `git multi-pack-index write --bitmap` to do the
actual work here. A few things worth noting:

  - the MIDX file itself is written using a lock_file, so it is
    atomically moved into place, and the temporary file is either
    removed, or cleaned up automatically with a sigchain handler on
    process death

  - the bitmap (written in bitmap_writer_finish(), which is the path for
    both single- and multi-pack bitmaps) is written to a temporary file
    and moved into place after the bitmaps are written.

    ...but this temporary file isn't automatically cleaned up, so it
    could stick around after process death. Luckily the race window here
    is pretty small, since all of the bitmaps have been computed already
    and are held in memory.

    This is probably worth a cleanup on its own, too.

  - unless GIT_TEST_MIDX_WRITE_REV=1 is in your environment, we won't
    *write* a .rev file, hence this is pretty rare to deal with in
    practice.

So I think there are two things worth doing here:

  - make sure that the temporary file used to stage the .bitmap is a
    lock_file
  - use a temporary file to stage the .rev file (when forced to write
    one), and ensure that that too is a lock_file

This is mostly the same as Ævar's original suggestion, just with a
larger scope. But I agree that it's the right direction nonetheless.

> The _only_ case that might matter is if the next "write --bitmap" gets
> confused ir there is a leftover file(s) from a previous run, but then
> such a bug should be fixed on the reading side, I would think.

It shouldn't in practice. We'll recognize that the .rev file is garbage
if it's checksum doesn't match the MIDX's, and we squashed the bug where
changing the object *order* (but not the objects themselves) doesn't
change the MIDX checksum (it does now).

We won't write over an existing .rev file with the right name, but we'll
always prefer to read the .rev data from the MIDX itself, if it exists.

Thanks,
Taylor
