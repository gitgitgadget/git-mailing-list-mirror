Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF7CC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EC7E60724
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 21:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbhHKVl1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 17:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbhHKVl0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 17:41:26 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342B6C061765
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:41:02 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id r17-20020a0568302371b0290504f3f418fbso5076241oth.12
        for <git@vger.kernel.org>; Wed, 11 Aug 2021 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=V/HM1JCU5OhER5m2RLj35u/Y1TNe15eweyIt+RG67cU=;
        b=KM+P2k6spnBamJBqH28IVedK/YDdtmN6EmdHpkrUNW9FrmZspc5xHOVL4K+O98F3Hv
         LfZU0YmSjhReDIKzGXsTmoQhw+WBsXu58BaoFoxRCIVw1DEJRQYUyrW3qvM6hpbWp+LB
         PgXw5iiLp5y9juN9zrXWMRqZBR4hWcCqZF5iVe145iFHeH4ZNEr6pBbnO73UXbC8q0hV
         G/32uXALcFz+2SOAmcm5dCA59qbpfGzWQnV4IcnGBhKJKJEXcFUhR+goNkmuhi8OOoa2
         OfFzWrnT3z0J30jARbzJQde2z8yYF6ePa9ZdWkGAQpjHqrsS9VI7/MAxSMtys1fjGIRX
         OesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=V/HM1JCU5OhER5m2RLj35u/Y1TNe15eweyIt+RG67cU=;
        b=oAUiiroK9p3CCzCaD+JOiIIOcYCrABLwhEOaBwZOtzxZf6bfRuPo8iFnRFDgMd1wSk
         8W4mPi3DqRjpDdPSC83F/kf7srTjjRDrl+SS6rAw4AKhzSPzI/SyZieynxClKFCem4cJ
         364Uwp+UFLgxhCIz4o3V+PDaKiXiiXyk96uPxrvtonc1MkqfX7jNu5+lxO2fB7d0ccpv
         8pRGIWOlEVPPMZ7RM0tWUp2EnUYB/boP/S0ivYUeQOVmSpbzS8BnNCThAU572z4PT5XS
         q9qdaZaOcEatYQrRest/PqzhuY+G/AC30tBXER4arcnfZPPPyTTEKLmTVaITlpmKuVeh
         XksQ==
X-Gm-Message-State: AOAM533dAp3YguZQ961e/6FrrIw3d3ux7hwhl8TWG3U3xmqrGKcVd10j
        WW/mjJ9X+pcoIT3TYJ62sV8=
X-Google-Smtp-Source: ABdhPJwghwkdZogbFZzKjXe7tg+SySoR58NNtNph+OTvuBAO643fETqfnQ57vV+4dxBW7ii1FRlpcQ==
X-Received: by 2002:a9d:1d04:: with SMTP id m4mr589342otm.346.1628718061620;
        Wed, 11 Aug 2021 14:41:01 -0700 (PDT)
Received: from localhost (fixed-187-189-69-1.totalplay.net. [187.189.69.1])
        by smtp.gmail.com with ESMTPSA id t3sm171777otm.28.2021.08.11.14.41.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 14:41:01 -0700 (PDT)
Date:   Wed, 11 Aug 2021 16:40:59 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Michael J Gruber <git@grubix.eu>, Jeff King <peff@peff.net>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Matthieu Moy <git@matthieu-moy.fr>
Message-ID: <611443ebea222_1ed62089f@natae.notmuch>
In-Reply-To: <162871314612.7067.6886805754107701040.git@grubix.eu>
References: <20210811045727.2381-1-felipe.contreras@gmail.com>
 <20210811045727.2381-7-felipe.contreras@gmail.com>
 <8034894f-a8dd-e1ee-1825-7cb172afdba3@gmail.com>
 <xmqqzgto9dkd.fsf@gitster.g>
 <YRQfx+Njj1WxOnyG@coredump.intra.peff.net>
 <162871314612.7067.6886805754107701040.git@grubix.eu>
Subject: Re: [PATCH 6/7] stage: add 'diff' subcommand
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael J Gruber wrote:

> Therefore, "git stage" as an alias to "git add" does not serve the purpose
> of establishing "staging area" very well, and "git stage --diff" shows
> exactly the problem with turning an "object-like item" into a "verb-like
> command".

But "stage" can be a noun in English too. Just like "branch" can be both
a verb and a noun.

> I still think it's very worthwhile to fantasize about a git which has
> only verb-like commands (such as diff, add, checkout, checkin) and a
> consistent way of specifying the objects to act upon (possibly amended
> by "git pluralnoun" being synonymous to "git ls noun" or similar
> convenience shortcuts).

There was a sub-thread in which we fantasized a consistent UI [1], and
taking Mercurial as inspiration the way to fix some of the warts would
be:

  git branch          # verb
  git branches new    # noun verb
  git branches delete # noun verb

Now, it's pretty unlikely that the inconsistencies with `git branch`
will ever be fixed, but we can take that as guidance for the staging
area:

  git stage               # verb
  git unstage             # verb
  git staging-area add    # noun verb
  git staging-area remove # noun verb
  git staging-area diff   # noun verb

This I think would be the most consistent way of implementing this, my
only problem is that 'staging-area' is too long. Of course users could
easily write aliases, but git should be easy to use by default.

If git implemented default aliases as I suggested [2], then I would have
no problem with 'staging-area', because the user could simply do:

  git sa diff

But that's a very big *if*.

Cheers.

[1] https://lore.kernel.org/git/f0770358-be4c-a747-0851-b2fd73c1978e@mfriebe.de/
[2] http://lore.kernel.org/git/20210702100506.1422429-1-felipe.contreras@gmail.com

-- 
Felipe Contreras
