Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E1A4C433F5
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:24:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E743611C0
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 11:24:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234042AbhKFL1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 07:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbhKFL1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 07:27:17 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF406C061570
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 04:24:36 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso78614wml.1
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 04:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HIXTOrEO4BtMffstH2SjdWfy7+LyYE2ATA4HXMDZnDk=;
        b=cHLZWop/7Vwqm3kw5OkDudEGIlOZbDsa3FnoT5us1BxPiLbJr8vJhFTmpU/mUxLqLN
         MRvihUFNWSzQat8u96prAl0dgkL+2jcpz4DX8J9lVhtOZVVTQpQ08x2q/Gxjaf792nnx
         R28qw5LD+FrHh/maPWidFtWWQypl8bpSSd8LZNllevFRUHqwJAUI7pvYk25ddjvz5eGQ
         aUHGlZVhgVnC4ITG8gKsjAxy8shGMhBojm/wHpPoKQ9pGJYRR0hm+w0KZ9beuBXkb0ug
         5EN17psY2quvoCUfGYKEI3f/E9uVn1oH3RhvihYItcTSP1qv/uJGaOY6wAkh3Gw/1cfA
         +nuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HIXTOrEO4BtMffstH2SjdWfy7+LyYE2ATA4HXMDZnDk=;
        b=mNTUD5PKCb6iB8yUIFEEXRVi6AbBxurp7tm09c84MjC07R6GtIuKxoNL0R4H42WiOK
         8CQw1vNFYcJ6dtEOrnqWritE7IXZgnrdcLagWEIenh00qplR5lTjAj05ZQ7dRdESsp4H
         5BDZldlBxBdR+DLid6PdDPS4bK2oxDpJ7FvdgpxXVJlc8R2Ozr44c1/mh2B7kac/AI9x
         6iqGQM994sMZBEO/BC6d7BH3CqoeEVxWsIjE43xh5lrnYNiwJ0LpjvuQdynh/9/JV7U2
         YepxlNRSz4JpU//uuly0KAaL649eht3xff1wud2mkkGDqdGHuD62M2CBA+ZE0PGEkdcv
         PKAg==
X-Gm-Message-State: AOAM533CUvmuU0+e7vpds3jKOWh+OH64CUbvAkM6rFY/ADX9Oh0sFmgs
        COEJAAy37Kif7qLdh3TRA+M=
X-Google-Smtp-Source: ABdhPJw3wl2ckvknkWYIu4Vs8c6rgMRA7+H0DaamgqgICHEcdCdEdGYeffXPyk7xxv27/ILN4qNL7g==
X-Received: by 2002:a1c:2b85:: with SMTP id r127mr37650650wmr.134.1636197875465;
        Sat, 06 Nov 2021 04:24:35 -0700 (PDT)
Received: from gmail.com (62-47-8-237.adsl.highway.telekom.at. [62.47.8.237])
        by smtp.gmail.com with ESMTPSA id c11sm12306165wmq.27.2021.11.06.04.24.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 04:24:34 -0700 (PDT)
Date:   Sat, 6 Nov 2021 12:24:32 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     rhodges@cisco.com, git@vger.kernel.org, rphodges@gmail.com
Subject: Re: [PATCH v2] apply: make --intent-to-add not stomp index
Message-ID: <20211106112432.otomxu6mwud4b7xi@gmail.com>
References: <20211030204155.2500624-1-aclopte@gmail.com>
 <20211030205147.2503327-1-aclopte@gmail.com>
 <xmqqr1c0cray.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr1c0cray.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Oct 31, 2021 at 11:40:05PM -0700, Junio C Hamano wrote:
> Johannes Altmanninger <aclopte@gmail.com> writes:
> 
> > Commit cff5dc09ed (apply: add --intent-to-add, 2018-05-26) introduced
> > "apply -N" plus a test to make sure it behaves exactly as "add -N"
> > when given equivalent changes.  However, the test only checks working
> > tree changes. Now "apply -N" forgot to read the index, so it left
> > all tracked files as deleted, except for the ones it touched.
> >
> > Fix this by reading the index file, like we do for "apply --cached".
> > and test that we leave no content changes in the index.
> >
> > Reported-by: Ryan Hodges <rhodges@cisco.com>
> > Signed-off-by: Johannes Altmanninger <aclopte@gmail.com>
> > ---
> >
> > Sorry I used the wrong Reported-by: address in v1
> >
> >  apply.c               | 2 +-
> >  t/t2203-add-intent.sh | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/apply.c b/apply.c
> > index 43a0aebf4e..4f740e373b 100644
> > --- a/apply.c
> > +++ b/apply.c
> > @@ -4771,7 +4771,7 @@ static int apply_patch(struct apply_state *state,
> >  					       LOCK_DIE_ON_ERROR);
> >  	}
> >  
> > -	if (state->check_index && read_apply_cache(state) < 0) {
> > +	if ((state->check_index || state->ita_only) && read_apply_cache(state) < 0) {
> >  		error(_("unable to read index file"));
> >  		res = -128;
> >  		goto end;
> 
> Thanks for an attempt, but I am not sure if it is wise to keep
> ita_only independent from check_index like this patch does.

I must confess, I didn't even consider alternative solutions.

> 
> There are many safety/correctness related checks that check_index
> enables, and that is why not just the "--index" option, but "--3way"
> and "--cached" enable it internally.  As "instead of adding the
> contents to the index, mark the new path with i-t-a bit" is also
> futzing with the index, it should enable the same safety checks by
> enabling check_index _much_ earlier.  And if you did so, the above
> hunk will become a totally unnecessary change, because by the time
> the control gets there, because you accepted ita_only earlier and
> enabled check_index, just like you did for "--3way" and "--cached".
> 
> One thing that check_index does is that it drops unsafe_paths bit,
> which means we would be protected from patch application that tries
> to step out of our narrow cone of the directory hierarchy, which is
> a safety measure.  There are probably others I am forgetting.

To be clear, check_index *disables* the unsafe_paths check, but it enables
a stronger check: verify_index_match(), which makes sure that the touched
paths exist in the index.
