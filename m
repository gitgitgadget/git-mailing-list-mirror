Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27687C43461
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 05:08:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D82DB20936
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 05:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgIPFIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 01:08:39 -0400
Received: from mail-ej1-f66.google.com ([209.85.218.66]:35663 "EHLO
        mail-ej1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPFIi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 01:08:38 -0400
Received: by mail-ej1-f66.google.com with SMTP id u21so8483335eja.2
        for <git@vger.kernel.org>; Tue, 15 Sep 2020 22:08:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ew2Kf/kPPg1k4VuKTMAijcydfSmFRpmqlZ5FTojuTeA=;
        b=MsrthQCC6xAYh04+a4p1JcrcqTj+WQfS0ItnY/gMm5eASvSjWzIUE2kFgGsyaIiTD9
         Q1lLFCaBxLIlRNbzcsa7vHwe1eDovwlwIlbKECHgrWCb8vYPs3bPGLOD/9dw1ld1MMBB
         nEPYY+DuAkJL+WW7t0qfMktBSQr33xjR7P7Yn1PV+olS10k5qSzSvnJtoaSd/2elUlbw
         C1YwNOrCDUilv/dYSscMqOLFtkHfGS2J5d/upfotUJnyOHwuNO1Akb2TxzoOAqmIuRBi
         V6NN1JWTipYMoQ5FIKa5JreWAEUHESeAzjLCxNAzietJVjSLa7o5dIOJGDYVb7QsjKXx
         NJpg==
X-Gm-Message-State: AOAM533uJi7uutXDfx3/ppIce1jjbYgd0b7YjLxbiRp6jRo2ouPBYZ8l
        st3f3YAapL+iw1BTe5SkwOEg2jFuIN/ON5XBWIk=
X-Google-Smtp-Source: ABdhPJwYXNCG42SZqoOklTeWoRaC6SNzaoQRyh7z1j3DZOgRshiXu1bH2sFfD/k/CoNQIHDVzKiIjt1pcPSbqvbAAmQ=
X-Received: by 2002:a17:906:250a:: with SMTP id i10mr23122982ejb.202.1600232915801;
 Tue, 15 Sep 2020 22:08:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200913193140.66906-1-alipman88@gmail.com> <20200916020840.84892-1-alipman88@gmail.com>
 <xmqq8sdaxqyu.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sdaxqyu.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 16 Sep 2020 01:08:24 -0400
Message-ID: <CAPig+cR7DnufEALmmW4e-6zxDsrGa_MeHT32mG5n1EQ6xEs8+A@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] git branch: allow combining merged and no-merged filters
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Aaron Lipman <alipman88@gmail.com>, Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 12:53 AM Junio C Hamano <gitster@pobox.com> wrote:
> Even though I said "I do not mind", using DO_MERGE_FILTER prefix is
> way too much noise.  The common prefix is appropriate for external
> API, but this is merely an internal contract between a private
> helper do_merge_filter() and its only caller.
>
>     #define EXCLUDE_REACHED 0
>     #define INCLUDE_REACHED 1
>     static void reach_filter(struct ref_array *array,
>                              struct commit_list *check_reachable,
>                              int include_reached) {
>
> to make it clear which part of the callback struct is really passed
> between the caller and the helper.  Even if we are not renaming
> things that much, a locally defined preprocessor macro with shorter
> names, defined just before the callee, would be more appropriate for
> a case like this, with a single callee called by only one caller.

Thanks for stating what I was planning on saying, with particular
emphasis on keeping these #defines in the .c file rather than the .h
file since they are not part of the public API.

Aside from that, this re-roll seems to address all of my previous
review comments. Thanks.
