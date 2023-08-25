Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2104CC71134
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 19:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbjHYTFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 15:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230140AbjHYTFG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 15:05:06 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A560D3
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 12:05:04 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-5920efd91c7so14601027b3.2
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 12:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692990303; x=1693595103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Rwua4wX3gFWs/7XmTbf92TmH7F6PTbWpClke94tvAXg=;
        b=xUnxxGuN/YZM9bCUNwu6SIyw/nFL2CFKey0RTYUb6IiH7+/6HSiVJa3Di/4vUUXTSE
         moA9d4HrNYhErKyZIWRVpCSekUrEiXk5quhfZr2eofRlqEsuT2IBCSiP+akFOcm9YFx3
         ALyugpMDvlfDcRQJG9+7XtNIEVs8GMdN0aCnMiZu++8c61fpu0PRxN9dNKpaTrrigxRo
         rqG+baYD5N5SZzFeEiCs++9dA3Sv+MLbBixwDRDQm8dNxCDQISc8l3NT2IatnZbzYjyn
         DUL1WsiOHzmNUFamZm0z9QdmkBOITMyxPQpkEjd1EniimJt+IW/WW1MtMQoDU/jnUPfs
         KhTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692990303; x=1693595103;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rwua4wX3gFWs/7XmTbf92TmH7F6PTbWpClke94tvAXg=;
        b=UJhJyG8umvDjy8UkRf/rnPFszDN4MaG32B6wp29cM33coLb7wYO+LQYHhmL7eIKOHT
         PskaRF+clh70uXcJgb7TKyuIJpyl+6isavKm3Y0ihzuKHXzhOIZJjMnYqP21UP8pON3B
         BaZFk2rl+oPIiVSqn/aFLvI+Mh6s9eacpvw4qRa9bYT+URV10A6TtnP0DynXN7J4EQb1
         0g3hYUvwRn3Qb6yOcc6obVYuBJdxdF5ZhXe5bOqmJ2coqvZ3RZ7VD1G3YcxPkp03cTZ2
         nRCXY057OLbko8R7KIDA2mCTKdMV/DrOAwElvslESnmjVArH7gKWQOt2+oiX0skUg09P
         V9KA==
X-Gm-Message-State: AOJu0YyEmmoSezkQx+CytrSsDrNHDBE6j9CikZT6b0ZWHeIEicRm/got
        13g+xz/oG2B8gqJWmkd6UGNWa9SzbAI71CqeAerOmQ==
X-Google-Smtp-Source: AGHT+IHivDjRgMmM5wrxB4JF6ioPSydCQQTCB/eo3ti1z+jYo11U6xIy7Wif+OrsHs0n/KiIIaoqHQ==
X-Received: by 2002:a81:7103:0:b0:592:58c4:1810 with SMTP id m3-20020a817103000000b0059258c41810mr11400088ywc.23.1692990303671;
        Fri, 25 Aug 2023 12:05:03 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id a5-20020a0dd805000000b00570589c5aedsm652569ywe.7.2023.08.25.12.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:05:03 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:05:02 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 1/3] leak tests: mark a handful of tests as leak-free
Message-ID: <ZOj7XqRSmIFxaI3P@nand.local>
References: <cover.1692902414.git.me@ttaylorr.com>
 <b1711c4c817f95011bc477a9485c115b4926c7da.1692902414.git.me@ttaylorr.com>
 <20230824210238.GA940724@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824210238.GA940724@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 05:02:38PM -0400, Jeff King wrote:
> On Thu, Aug 24, 2023 at 02:40:38PM -0400, Taylor Blau wrote:
>
> > In the topic merged via 5a4f8381b6 (Merge branch
> > 'ab/mark-leak-free-tests', 2021-10-25), a handful of tests in the suite
> > were marked as leak-free.
> >
> > As far as I can tell, each patch from that series ran tests from a
> > handful of subject areas, such as "some ls-files tests", or "all trace2
> > tests". This left some gaps in which tests had and hadn't been audited
> > to be leak-free.
> >
> > This patch closes those gaps by exporting TEST_PASSES_SANITIZE_LEAK=true
> > before sourcing t/test-lib.sh on most remaining leak-free tests. This
> > list was compiled by doing:
> >
> >     $ make SANITIZE=leak
> >     $ make \
> >         GIT_TEST_PASSING_SANITIZE_LEAK=check \
> >         GIT_TEST_SANITIZE_LEAK_LOG=true \
> >         GIT_TEST_OPTS=-vi test
>
> So having resolved my "oops, lsan logs are racy" problem, my system now
> agrees with yours on which tests are now leak-free. And we definitely
> _were_ leak free less than year ago when I posted that other patch. So
> I'm not sure I buy the "these were missed in 5a4f8381b6" logic.

Phew ;-). Thanks for chasing that down, I'm glad that our two sides
agree.

> The one in t5571, I mentioned earlier that I bisected to 861c56f6f9
> (branch: fix a leak in setup_tracking, 2023-06-11).
>
> The one in t7516 seems to have been fixed by 866b43e644
> (do_read_index(): always mark index as initialized unless erroring out,
> 2023-06-29).
>
> I found both by bisecting between v2.39.0 (which shows the leak) and
> v2.42.0 (which doesn't).

Much appreciated. I'm happy to fold those details into a new round if
you think they are useful enough to live in the commit history. I could
grab your patch as a preparatory step, too. But if you are happy with
this as-is, I am too.

Thanks,
Taylor
