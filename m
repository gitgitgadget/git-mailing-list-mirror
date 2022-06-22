Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A7DCCA479
	for <git@archiver.kernel.org>; Wed, 22 Jun 2022 21:31:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230477AbiFVVbN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Jun 2022 17:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbiFVVbL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Jun 2022 17:31:11 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FE4413D39
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:31:11 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 89so27195778qvc.0
        for <git@vger.kernel.org>; Wed, 22 Jun 2022 14:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qF9N3ItpzV7CLYma7LzNjoifq85W8PWGkXYTHhuKfG4=;
        b=6GCmaJubUkAnwZJB+Z2JJJI/TPcVxedGM1fKevXz0YseWps7sKM60m1Hx46Ola94Uf
         YKT4pl6/dGBUATIvD+Su3hP9TYkYAUYVVlgxwQuk1iVyl4mkxUuWkAF8nwhkIN7SLwHG
         BCOsVAftUJWgfNXugPMTtDvs3Sz32jxfSDPoG0wJLxyul0EsdB2iDbZ7sGk1WxdbMOfs
         oyuUnJSEDEOyvZJL2TQtk5ug9PVw3Gd574v+IKp8JmJLTkslI+rOK9bCdys52WCe8zNx
         rqIi8l6p9EM4oMjNBRhNqRRZ13X2kI9JhiKbU3uaX26biZtI+fOt0fRoMutZTepQUnUB
         vqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qF9N3ItpzV7CLYma7LzNjoifq85W8PWGkXYTHhuKfG4=;
        b=UVPFKpUq0RPQjNKap4KvN5LMuHVJ2/6y5K+Zsw1gU88yhafp56k4J8lXDaZrhh3gcv
         phLq5loFkCJEmvSA3WTOSpU33Zfw+E6fUsdFSjQq3hydfus4j9yF6sjAxDy5hjjG9jWr
         OXEmRRYP2fEXcaaxLnJpoiXjkJ2Pa24nB2nFrIwTz2yfc5XcxDb4cA8QRfVqyoNWVtO2
         j4fEWKWOMHDS0ttYjuipeqcMUtGbStpBz+nMX8d6m0fOqd9Usmm+zvka4Y/3ha6emHxQ
         s4PmUglZRoO3gvYRjYI3c76X13zGnp8KjpvWa0iXgIfjQvQCQgjaJTmAdNPTfeE2sBn6
         StaQ==
X-Gm-Message-State: AJIora8hW3BDy7pBrUfGOmuAIF6lkQxT+HtMR1EgOhKcbrMgumnAFc6R
        vhaSPG8Q0srREJG9+PbRNLVw8w==
X-Google-Smtp-Source: AGRyM1u/rojw654wYcIifPnN3BD/BYaX/kqk6yDmq8yEA2prhofuoOFkA+fj3Zb1gjE0Z/qG451SFQ==
X-Received: by 2002:ac8:7d94:0:b0:304:fe52:7b87 with SMTP id c20-20020ac87d94000000b00304fe527b87mr5059463qtd.482.1655933470201;
        Wed, 22 Jun 2022 14:31:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a15-20020ac85b8f000000b00304e38fb3dasm16624022qta.35.2022.06.22.14.31.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jun 2022 14:31:09 -0700 (PDT)
Date:   Wed, 22 Jun 2022 17:31:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        haoyurenzhuxia@gmail.com, git@vger.kernel.org,
        derrickstolee@github.com, dyroneteng@gmail.com
Subject: Re: [RFC PATCH] midx.c: clean up .rev file
Message-ID: <YrOKHIjXCb5YgIOr@nand.local>
References: <20220622115014.53754-1-haoyurenzhuxia@gmail.com>
 <220622.86a6a4lmdv.gmgdl@evledraar.gmail.com>
 <xmqqo7yk60vf.fsf@gitster.g>
 <YrNb2x2/7Z31XnFJ@nand.local>
 <xmqqtu8c31xp.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtu8c31xp.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 22, 2022 at 12:58:42PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >   - the MIDX file itself is written using a lock_file, so it is
> >     atomically moved into place, and the temporary file is either
> >     removed, or cleaned up automatically with a sigchain handler on
> >     process death
>
> Good.
>
> >   - the bitmap (written in bitmap_writer_finish(), which is the path for
> >     both single- and multi-pack bitmaps) is written to a temporary file
> >     and moved into place after the bitmaps are written.
> >
> >     ...but this temporary file isn't automatically cleaned up, so it
> >     could stick around after process death. Luckily the race window here
> >     is pretty small, since all of the bitmaps have been computed already
> >     and are held in memory.
> >
> >     This is probably worth a cleanup on its own, too.
>
> As long as the "temporary file" is clearly a temporary file that
> "gc" can recognize and get rid of, it would be OK, I would think.

Yeah, I think either is fine (though it would be slightly nicer to have
the sigchain code clean it up ahead of time when possible). In the
meantime, nothing is broken, though.

> >   - unless GIT_TEST_MIDX_WRITE_REV=1 is in your environment, we won't
> >     *write* a .rev file, hence this is pretty rare to deal with in
> >     practice.
>
> OK, but if we were to write one, we should do the same "write into a
> temporary, rename it in place" dance, right?  Or is a separate .rev
> file is pretty much a thing of last decade that we do not have to
> worry too much about?

Right. Technically we link() it into place, cf. our discussion about it
here:

    https://lore.kernel.org/git/xmqq5yqeghck.fsf@gitster.g/

But in general this is not really at all considered common anymore,
since we expect all new writes to have the reverse index embedded in the
MIDX itself.

Thanks,
Taylor
