Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2F0C1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 08:46:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727529AbeIGN0u (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 09:26:50 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:32917 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbeIGN0u (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 09:26:50 -0400
Received: by mail-qt0-f194.google.com with SMTP id r37-v6so15470804qtc.0
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 01:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=P9RWsHs+MOj4D/YmTwY8AkPYlZs5NooPk8Mpf4T2K2Q=;
        b=ud74inzj0ln43RLnKzNoDjVqf8UHp1RcTI8DZh6PdwFnScgJF0gWTCwgEkCH6+2VwP
         FHLm+2l0pTJ1tJcIfmIRGNWDtLVRZIrIPNfuk5KdX/9ZGawMRsjdyu8HEEzbM3YiwqMy
         QNrVOcxTGP+bNpoa9e9eLZrHxdK7Fp2qGTkcDwbBiWgFkqpGso5t2S7CBYDy1zGOut/Z
         ttNxhqqFSX3yo37b4ZwerJGP4lDeZZENMcvIihyipZRYSRcFELER57lHJerVLaihYAy3
         hyetIaSyysQL55Gvm8x3pjwj7OIs6upwjJ613imjtStIEGO0QokigPeOnnYa6m8BK4/z
         JCJg==
X-Gm-Message-State: APzg51BijJ+0f42LxKzjAcPShFBygan8iqT4zm4eFyoh5qY/HL+LDv+1
        3RQlA50U7yeddCeRO/F7FC5Sk9L0iRPHUcOEvcc=
X-Google-Smtp-Source: ANB0VdamlLrINngvwUOcU4o+oshdJFY5WqySosNMpRHYpYyMiOJgt/10/DMHho8Gokf285bsq6+wH1aCI52deaA06cI=
X-Received: by 2002:aed:2aa1:: with SMTP id t30-v6mr5254216qtd.101.1536310014281;
 Fri, 07 Sep 2018 01:46:54 -0700 (PDT)
MIME-Version: 1.0
References: <20180722095717.17912-1-sunshine@sunshineco.com>
 <20180722095717.17912-15-sunshine@sunshineco.com> <xmqqr2jrt46j.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr2jrt46j.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Sep 2018 04:46:43 -0400
Message-ID: <CAPig+cS5VwmNnrpFwpm9Ko2xg3WVsfffDLpkJLtU9ziSFOoyUw@mail.gmail.com>
Subject: Re: [PATCH 14/14] format-patch: allow --range-diff to apply to a lone-patch
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 25, 2018 at 5:07 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > +     if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
> > +             struct diff_queue_struct dq;
> > +
> > +             memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
> > +             DIFF_QUEUE_CLEAR(&diff_queued_diff);
> > +
> > +             next_commentary_block(opt, NULL);
> > +             fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
> > +             show_range_diff(opt->rdiff1, opt->rdiff2,
> > +                             opt->creation_factor, 1, &opt->diffopt);
> > +
> > +             memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
> > +     }
> >  }
>
> This essentially repeats what is already done for "interdiff".

Yes, the two blocks are very similar, although they access different
members of 'rev_info' and call different functions to perform the
actual diff. I explored ways of avoiding the repeated boilerplate
(using macros or passing a function pointer to a driver function
containing the boilerplate), but the end result was uglier and harder
to understand due to the added abstraction. Introducing
next_commentary_block()[1] reduced the repetition a bit.

> Does the global diff_queued_diff gets cleaned up when
> show_interdiff() and show_range_diff() return, like diff_flush()
> does?  Otherwise we'd be leaking the filepairs accumulated in the
> diff_queued_diff.

Both show_interdiff() and show_range_diff() call diff_flush(). So, the
"temporary" diff_queued_diff set up here does get cleaned up by
diff_flush(), as far as I understand (though this is my first foray
into the diff-generation code, so I may be missing something). And,
the diff_queued_diff which gets "interrupted" by this excursion into
interdiff/range-diff gets cleaned up normally when the interrupted
diff operation completes.

[1]: https://public-inbox.org/git/20180722095717.17912-6-sunshine@sunshineco.com/
