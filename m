Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBDBC3DA66
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 19:11:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229559AbjHYTKf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 15:10:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbjHYTKR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 15:10:17 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED65B2133
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 12:09:29 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-579de633419so15423717b3.3
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 12:09:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692990520; x=1693595320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MkZECLDvgWDPTks0WmsjRJe/WQGjPeRtqyXnCoE3DsA=;
        b=DSOCHPXH7bpPq6xZjV5WAQPjvQqHKgaGEG7wl0WKOSZwCcOeLgTMcOtp9krHqdRcB8
         i/8JJcignKEq5GQODi813rpzUFB+BcbZSVfpo/337lMr/O494fyeUDL1A7YuxzN9vHQf
         YFLUq78eyynafQZBciqlJQ6kw6A8QC2VtXF0lOVGpEKOEClBzZo/C6UqxGyVnlZgmXd5
         C4MY3C8w4v8PJ3kPP97BCU4OmyyZ/cuDPD9HcGtZR6snnNo6MEqqpgLUSgKrXg6DNi8N
         ylM8ezREFBBCzBZP8LeMtg7yZmXyTTd9hYUV1Wc14RcRlxl4Txc/OvDZiBmWDgeKPKcO
         rOMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692990520; x=1693595320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MkZECLDvgWDPTks0WmsjRJe/WQGjPeRtqyXnCoE3DsA=;
        b=D8q7MSwH0bzmnprKaTkob51gIBdv+SCN6I0R8SJQByReMI/xyNgG+arGjkUY0OosL5
         3XQ4DN14kMwqGi6/5EFC1KRPwnTBW52JGWzTOzq0yOFKv6v4VLvsoDdQ/F3YJIj46W17
         a/k5XS4IKlBrIvSP18xjKX68Mn5ZPCtSMQ0/d4Bp2monx7Qy3rNk05+1pLcI1od+WHvN
         BBkdaSIg9AdF5pWXl4l0KwTqearIC7vNzqHkmG3RmEN4CKuQ39LlH2IMwt1J2irSd/QG
         MGBP03s8PbYuuaxjDUWakQ8BZFKLUveOMf8WAaCrqObEi43xvok1WpCyEfPpm6xs2ddh
         pWrA==
X-Gm-Message-State: AOJu0YwUEU2yJN1ghJ9IqC/11IoCBecZuytWEkTvGkBzyp8FzR/b2TdF
        RNLTQ3YfNsmDPPwB/F3p4HzVAg==
X-Google-Smtp-Source: AGHT+IERhxG5/MCzNJNoT4aSjNgA5a//Qg84mRvTqOOwtZJ1RM9GHPpzzxig4+6OHrJ4xVVa/EXFhg==
X-Received: by 2002:a81:9289:0:b0:58c:54f8:bd45 with SMTP id j131-20020a819289000000b0058c54f8bd45mr20335888ywg.44.1692990520471;
        Fri, 25 Aug 2023 12:08:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w82-20020a817b55000000b0056dfbc37d9fsm651349ywc.50.2023.08.25.12.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 12:08:40 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:08:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Teng Long <dyroneteng@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/3] leak tests: mark remaining tests leak-free as such
Message-ID: <ZOj8N4OS8zp7h9Vc@nand.local>
References: <cover.1692902414.git.me@ttaylorr.com>
 <20230824205009.GA1516@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230824205009.GA1516@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 24, 2023 at 04:50:09PM -0400, Jeff King wrote:
> On Thu, Aug 24, 2023 at 02:40:34PM -0400, Taylor Blau wrote:
>
> > While working on another topic that cleared up some leaks, I wanted to
> > see if any new tests became leak-free, so I ran:
> >
> >     $ make SANITIZE=leak
> >     $ make GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=-i test
>
> Is that exactly what you ran? Because I'd expect the second "make"
> invocation to rebuild Git _without_ SANITIZE=leak enabled in that case.
> (Though I would have then expected most of the scripts to complain
> loudly about the mismatch; did you "cd t" in between the two?).

Argh. No, I wrote instead:

  make SANITIZE=leak
  make -C t GIT_TEST_PASSING_SANITIZE_LEAK=check ... test

> >  t/t3321-notes-stripspace.sh | 1 +
> >  t/t5571-pre-push-hook.sh    | 1 +
> >  t/t5583-push-branches.sh    | 1 +
> >  t/t7516-commit-races.sh     | 2 ++
> >  4 files changed, 5 insertions(+)
>
> If I run a single:
>
>   make SANITIZE=leak GIT_TEST_PASSING_SANITIZE_LEAK=check GIT_TEST_OPTS=-i test
>
> on v2.42.0, I get many hits. All of the ones you mentioned, plus:
>
>   t7408 t5407 t7008 t5811 t3407 t6001 t4058 t2016
>
> If I run a few by hand, I _do_ see leaks in them, but the exit codes are
> hidden from the test suite (they are sub-programs of scripts, etc). I
> guess you also have:
>
>   GIT_TEST_SANITIZE_LEAK_LOG=true

Yep, that is in the patch message, and definitely necessary (as you
found ;-)) to get accurate results here.

Thanks,
Taylor
