Return-Path: <SRS0=gV3S=CS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73C19C433E2
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 06:02:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 314CA207DE
	for <git@archiver.kernel.org>; Wed,  9 Sep 2020 06:02:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726293AbgIIGCm (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Sep 2020 02:02:42 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:44553 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgIIGCm (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Sep 2020 02:02:42 -0400
Received: by mail-ej1-f66.google.com with SMTP id r7so1734980ejs.11
        for <git@vger.kernel.org>; Tue, 08 Sep 2020 23:02:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZlAFuRsKAygQnjFUrvVaN/RpEexMuwDOCs5NDVJFR3o=;
        b=rYeMXE9Lemf6HtW0M3SopzB5vo4abuPXbyUjs7T79d8YpJUjIEchxK4LiQbj8Tq/40
         IEl1M42MsW9wgt9u/4cN7TNum5VByWjACEYKNN4OPLOlr6LJLO8fNlNQU871BMY7vCgq
         lKNjwlkCPHmy4hv4tJHlPRsnWBWwKA0LSUotSlXbA63pXIpPY1gpSU1kkXINPfH661Au
         UFXArnRqHcHa7mp1WkW/SyCMVKR1hCuvv2+3rAncdRDoKLtNqKGXFfUUPga7ARWjD3N3
         vRitkhwA+qg4U0f1Vnr/9WxUMfRTnzpcUCckXwH2V3vbrSF8P6glWj82siluTpofJZVL
         d5TQ==
X-Gm-Message-State: AOAM5318bVLEcIbWxoX3N3Ae88Y6LPr5p2O361Ks4iELB0MgMt3EJgwy
        VrFkaOID730LHLLWyU3pUGBoCpZmUusHl8Xwr7M=
X-Google-Smtp-Source: ABdhPJwqJdj/ZuCVS8ndhjRThQdJtXbGHuywwHoG5fZm+u5eqkf0nGMKJlpybcqn3gGhfgO6GFFAXH0OuwinJiCXqhI=
X-Received: by 2002:a17:906:a1cf:: with SMTP id bx15mr1915234ejb.231.1599631360013;
 Tue, 08 Sep 2020 23:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200908071610.16714-1-sunshine@sunshineco.com> <xmqqy2ljx6l2.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqy2ljx6l2.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 9 Sep 2020 02:02:29 -0400
Message-ID: <CAPig+cQMKDb1bFYUFAZs6EAc6HsfosK-2oPe-f54OULd4PgThw@mail.gmail.com>
Subject: Re: [PATCH 0/3] format-patch: --interiff/--range-diff tweaks
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>, Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 8, 2020 at 6:11 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > This series addresses a few comments[2,3,4,5] which cropped up during
> > review of the series which added --interdiff and --range-diff options to
> > git-format-patch[1]. That series made it into 'next' before I could address
> > the comments, so these patches (based upon 'master') make minor tweaks
> > "incrementally" (over 2 years late).
>
> The last step subtly changes the behaviour, if I am reading its
> description correctly.  Does it deserve a documentation update, or
> are we just making the code behave "better" but still within the
> boundary of how it is documented to work, hence no need to update
> the doc (but deserves an advertisement in the release notes)?

I honestly don't have an answer because I have trouble reasoning about
these cases (perhaps due to unclear mental model). That's part of the
reason why this patch series took so long. The first two patches were
ready in September 2018, but I kept putting off the third one because
I was having trouble understanding your suggested changes. It only
started to click the other day when I sat down and really studied your
proposal for a long time. Attempting to write a meaningful commit
message, rather than a hand-wavy one, forced me to think about it even
more critically, which helped (perhaps even more than the code itself)
to better understand it.

I wouldn't be opposed to dropping the last patch, however, with
whatever understanding I gained, I do agree that the way you suggested
coding it does make more sense and is more intuitive. But that doesn't
mean that it is sufficiently concrete in my brain to say whether a
documentation update is warranted and, if so, exactly how to
articulate such an update.
