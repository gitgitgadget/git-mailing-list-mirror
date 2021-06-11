Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DDCAC48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1CCA61374
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 17:58:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbhFKSAE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhFKSAD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 14:00:03 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836EFC061574
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:57:55 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 36-20020a9d0ba70000b02902e0a0a8fe36so3937817oth.8
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 10:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KWnayGuUUc6IOMbkYDN+cpz6kbjInbp7ODUJj/rf6mI=;
        b=GrTWJfwhCIpyXgD9vE5RKicPsG4ILwl18DqYXqyeCtY00SelN6+MzTJ3rpsbChfJcJ
         46i05Os3i7gQr3u+518oQkDydKdjCpq4ZKQPnAoLFwSfQLfHkyw9UQaR/6tm9n8mk9ex
         wYJBXUiUVudR4QdA0DdpWVIR3fR7CpZiAk4TwejuEU6ZsGtELE5cIA2Z4lOUqY6imXmv
         cMH9pibKdpD0JJ0R44g8PUglgvrb/l27Z5lIwe3RX4smWPzbksoLA2RtoPQFwq7aVtvz
         9xNm44Vb2zrr4IZWlURJJeLmWDfwvF8MUaohGyfl/bkd+gY2jUjfR+OKcUx22iaoBEWD
         5zuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KWnayGuUUc6IOMbkYDN+cpz6kbjInbp7ODUJj/rf6mI=;
        b=uI/n9BJ1vaAxUtWqMMD4kxufssE8MdlOvzgb6xBTVTNPLdyxI3n2Ii4Qky9rSD6xcQ
         rA7hCz6IeTGu8CXHe73rNjncmDx5MQzrQg+9pqIao2KR4p02og5YGk+Zred3/QHIUb7h
         mj7p71QIx39x2r0jDmpBxP7KjgZs03mt5m9Giftxj3Pp9mkd1d4G6Av4AwYI34uzMuLV
         dl+dHv6rWPYw3Co1WW+ljt+J/4EdCTb/e3uIBr4jf8zgnqDoGRY6dUFwOhigw0nZ6pqX
         QkdUzP+Pi1UkoU/ujFF15EfxFY2471NBh19LYZdyRrOf25v5x2gZSYLn0SQUPeZEJYzX
         Br6A==
X-Gm-Message-State: AOAM5325Skos/EV0f4SR2kBx7aMNh+YzmEBS5DnpuwWIfkYy2WMoxQQD
        cvsnwpWjtc6iNznwYQXBxSw=
X-Google-Smtp-Source: ABdhPJwD1FvCC2a9+i4mPG0mPYpCogpV7Zhs3KgFEGhC+ynF7hMUyuUd5c+DTZcZFmJMGU42YSFLkw==
X-Received: by 2002:a9d:66d9:: with SMTP id t25mr4128223otm.217.1623434274843;
        Fri, 11 Jun 2021 10:57:54 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id k8sm1268288ool.5.2021.06.11.10.57.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 10:57:54 -0700 (PDT)
Date:   Fri, 11 Jun 2021 12:57:47 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Sergey Organov <sorganov@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Sixt <j6t@kdbg.org>, Jeff King <peff@peff.net>,
        David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <60c3a41bd25e3_8d0f2089e@natae.notmuch>
In-Reply-To: <CABPp-BHRQSF2_aYTBfpfnW4Bh3Hz7vLFj_QNGj8R4WeCS6_utw@mail.gmail.com>
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
 <20210609192842.696646-8-felipe.contreras@gmail.com>
 <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
 <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
 <xmqqh7i5ci3t.fsf@gitster.g>
 <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
 <xmqqy2bg3nqw.fsf@gitster.g>
 <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
 <xmqqo8cc3maq.fsf@gitster.g>
 <875yykipq2.fsf@osv.gnss.ru>
 <60c38205cdbf8_3ad92084@natae.notmuch>
 <CABPp-BHRQSF2_aYTBfpfnW4Bh3Hz7vLFj_QNGj8R4WeCS6_utw@mail.gmail.com>
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> On Fri, Jun 11, 2021 at 8:32 AM Felipe Contreras <felipe.contreras@gmail.com>
> wrote:
> > Sergey Organov wrote:
> > > Junio C Hamano <gitster@pobox.com> writes:

> >   git init repo &&
> >   cd repo &&
> >
> >   echo 1 > content &&
> >   git add content &&
> >   git commit -m 1 content &&
> >
> >   git checkout -b A master &&
> >   echo A > content &&
> >   git commit -m A content &&
> >
> >   git checkout -b B master &&
> >   echo B > content &&
> >   git commit -m B content &&
> >
> >   git checkout -b C A &&
> >   git rev-parse B >.git/MERGE_HEAD &&
> >   echo C > content &&
> >   git commit -m C -a &&
> >
> >   git checkout -b D A &&
> >   git rev-parse B >.git/MERGE_HEAD &&
> >   echo D > content &&
> >   git commit -m D -a &&
> >
> >   git -c merge.conflictstyle=diff3 merge -m final C &&
> >   cat content
> 
> Right, here you do not have a unique merge base; you have two of them: A &
> B (it's possible to have three or more as well).  To do a three-way merge,
> you need a single base commit.  So, whenever you have more than one merge
> base, both merge-recursive and merge-ort will merge the merge bases to get
> a virtual merge base.  There's always a risk that the merge bases don't
> have a unique merge base either, forcing the algorithm to recurse.  This
> behavior is where the merge algorithm 'recursive' got its name from (and
> which also appears in ort's name -- "Ostensibly Recursive's Twin").
> 
> You could decide to just pick one of the merge-bases at random, and yield a
> different set of surprises including silently merging in favor of one side
> when the two sides did things differently.  That's problematic.
> 
> Instead of using a merge base (a recent-as-possible common commit), you
> could decide to instead just try to find a unique common base, regardless
> of how ancient it is.  Using ancient commits as the base is a step towards
> just doing a two-way merge (treating the histories as completely
> independent and throwing merge conflicts whenever any files aren't
> identical on the two sides).  Sure, it's not as bad, but it does yield
> massive amounts of useless conflicts.  So this is problematic too.
> 
> The alternative to the above two options was the
> make-a-virtual-merge-base-by-merging-merge-bases strategy.  It apparently
> was very successful.

OK. That makes sense.

> But it does mean that merge bases can have conflict markers in them.

But why? And even if they do, why do they have to be diff3 conflict
markers?

This would be more human-friendly:

  <<<<<<< HEAD
  D
  ||||||| merged common ancestors
  <<<<<<<<< Temporary merge branch 1
  B
  =========
  A
  >>>>>>>>> Temporary merge branch 2
  =======
  C
  >>>>>>> C

Or just put a stub conflict marker:

  <<<<<<< HEAD
  D
  ||||||| merged common ancestors
  <<<<<<<<< Temporary merge >>>>>>>>>
  =======
  C
  >>>>>>> C

Or just use the base of the virtual merge:

  <<<<<<< HEAD
  D
  ||||||| merged common ancestors
  1
  =======
  C
  >>>>>>> C

We don't have to use diff3 all the way.

Cheers.

-- 
Felipe Contreras
