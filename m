Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39CFFC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:01:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A98F61361
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 23:01:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235772AbhGNXD4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 19:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbhGNXDz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 19:03:55 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 159F3C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:01:02 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ec55so5435941edb.1
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 16:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=rJQsyyWw92pw5n05nm4mYv4VHI8RwQHH0FENVxkkmkM=;
        b=TWfskgWKzBeNhPsNC9HgNMm9HhfqMroi1anZ01D013HcKmnlu1c/l6xUNO4FNnJMW5
         XamKFNK44eHaXzo9rk9/5hfwwLLskjqbE/VvGJA4qVKLBJ4UZhJecy+qhJgCRieseGVJ
         a/cq3Jh39mD0OQQfok9/j7n55x+SlDqysNJ2KjdN4hzot7H0wh0KGXqMCRhOOPhFt5Ja
         DWGmnFa83D+69kRQaUUwNwZfEwEDYPaY1Kqcp3keJl13A2zDEJdUckmPsDoqd+Rke4iM
         +bR2rFwCLrk474YTT9kFwsPXTDkmPfKCE36+G4yd3xGz1mjTM4XmUXZV9uL8W1NEf/nb
         S3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=rJQsyyWw92pw5n05nm4mYv4VHI8RwQHH0FENVxkkmkM=;
        b=syALXiLYdkHsJjQxR4ig7I4GLKla1sba98N/CN+HJQAmzsGeMnO7DDJ38zkSae3mHR
         o0V3WcsneMG2JdbotGxRGJn+kR60YcRUq5KtNsNBSsIy9PA4kY+sYUzy2V0hKLeEteEN
         sFPLPbL6J2duSpVUtovDTxSkyvQ0FA61cRBW1BLEglD6eDrLY3x+iRVdl2BPGFLLXEQ8
         d5eI5h/9ZI5h6r/PhoPZLvoPtehf/Xkws3/8I9t9WxyhdP7igptUUfq29YxdK/TSua/g
         KlqrfdaShvKR3b715EJ/oZnF5h4I4ZjYXHDHLGOe0fAEhr5zsrCGJiGfSGahEUzZNb3U
         2GLA==
X-Gm-Message-State: AOAM530d9uadixAu6vNrtJTIu75j0wWZ9HHmxgBrm+50OywTCjFjNRVp
        fBl2XbiA6/5SI8x6GePH6i8=
X-Google-Smtp-Source: ABdhPJyPdpQirnKNWSeqKN5Y3nNmD9OGtEZqV8ELotlrDzN2ywuxNhcxzf0/3yXMZgp+jFMaOgUhsQ==
X-Received: by 2002:a05:6402:3d4:: with SMTP id t20mr997538edw.274.1626303660683;
        Wed, 14 Jul 2021 16:01:00 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id jo19sm1209526ejb.59.2021.07.14.16.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 16:01:00 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com,
        gitster@pobox.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 04/24] Documentation: build 'technical/bitmap-format'
 by default
Date:   Thu, 15 Jul 2021 00:58:00 +0200
References: <cover.1617991824.git.me@ttaylorr.com>
 <cover.1624314293.git.me@ttaylorr.com>
 <b0bb2e8051f19ec47140fda6500e092e37c6bea8.1624314293.git.me@ttaylorr.com>
 <87bl7uzvaf.fsf@evledraar.gmail.com> <YO8h0smhBPuIjFAa@nand.local>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <YO8h0smhBPuIjFAa@nand.local>
Message-ID: <87eec0zej2.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Jul 14 2021, Taylor Blau wrote:

> On Fri, Jun 25, 2021 at 01:35:48AM +0200, =C3=86var Arnfj=C3=B6r=C3=B0 Bj=
armason wrote:
>> As a mostly aside I've got a local series queued up to move all of these
>> "format" docs to e.g. gitformat-bitmap(5), i.e. to make them first-class
>> manpages, so other pages can link to them. Right now we mostly don't,
>> but when our manpages do they link to the generated HTML, which e.g. I
>> don't have installed by default.
>
> It would be nice to be able to look it up with "man 5 gitformat-bitmap".
> I actually don't have strong feelings about this particular patch
> getting picked up or not, since it doesn't add the actual format changes
> to the file itself.
>
> This does pick up the bitmap-format document in "make -C Documentation
> html", which is nice(r than "make -C Documentation
> technical/bitmap-format.html" IMHO).

Oh yes, I'm not saying don't add the target. Just a musing on how we
ended up with such a large set of things in "Documentation/technical/*"
as opposed to just man pages.

I guess if there's good reasons for it they'll come out if/when I submit
that series...

>> But there's still (but maybe later in this series) a link to
>> bitmap-format anywhere from another manual page (but there is for
>> e.g. technical/pack-format.html).
>
> No, I didn't add any links pointed at bitmap-format.

I see https://git-scm.com/docs/bitmap-format has somehow managed to get
indexed by Google, perhaps through some magic :)
