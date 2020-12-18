Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24C57C4361B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:01:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA78423B7B
	for <git@archiver.kernel.org>; Fri, 18 Dec 2020 21:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgLRVBh (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 16:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725818AbgLRVBg (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 16:01:36 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F31C0617A7
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:00:56 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id h205so8821094lfd.5
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 13:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EGOHg6iPCxFkK4Ko256Uaoi5WgIrB3Z1dJWmo3/+aso=;
        b=g2vPVUuwwqRt55Ew5gY3fPs3t51OwKwH1/Df1vAFufI3l3cqvB/LAb4Av4Kx7Y5CMS
         ZM+u3PvX8+3NY4BEUZx3fYXh03WMfdJqk9QF663vQ8wdko9zSO/oZkzR/Con0Mes3pzG
         g9L7tnfxZ0zpd4hy7+mZadrHeenWiuYJqM8K+D9BDeREFyDCjBfvedCAP0PtMNRFrRO2
         D2ceupAquTOusx1ZrdarPIvtu1fKMwlBrcy/h4Yn19lRdsQ/2jjjOYx+Fw5yl38X6ikA
         Xr6woyb9SOX1g2vzJ/FRj9X3XJLeFjV126FBMjZ0FfO2JG6wv/SMGOJLIUYG8JmVMn6Q
         uDAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=EGOHg6iPCxFkK4Ko256Uaoi5WgIrB3Z1dJWmo3/+aso=;
        b=VXFZXGfFVQCNqro4BdCKjrdSP08UTzem+ItVp30By5D4uX5MGyfQOVMfSwH1YkYWxc
         W2D3fGFIXlge5WTF2PzRggm16k6q6QZh7mkPPB6eP8Ty31lrlkCxfuSiG+YHrN6qDeje
         4EkEWoeHPSsFzaydUy8MSQdS7nQtsLM6cHhvcBURxoqcMHh6uebeg6t5fanr76lZsoof
         8BI/BAivf/qlDSzrkzIpCfeuYHQSdSmQ0ktyLUDeZ2Movgx77Wrqv/yjL4WY4bLb1I+F
         2AE4OUWnsAtCbUt3xEHsAUqSzMMElQ1IlTxmNTpfISpP2+m5/nzdzXC5U87YntS+MYxY
         y5xQ==
X-Gm-Message-State: AOAM532xdRdXfwuwKmlcikApn6HPZwq5JIjchAqTFd/TJeP8SMOvMNu4
        Lj+kkEvvGZYwRQrYwnXEXB4EtMG6bDc=
X-Google-Smtp-Source: ABdhPJzVbniRcE4X5wDQIHJda3f+JP+h0dwpGw4EiS89HdGoX6WmHSWhNqCgfRyW3LGImqJYPS6T/g==
X-Received: by 2002:a19:6a08:: with SMTP id u8mr1994064lfu.217.1608325254339;
        Fri, 18 Dec 2020 13:00:54 -0800 (PST)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id j18sm1043451lfb.77.2020.12.18.13.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 13:00:53 -0800 (PST)
From:   Sergey Organov <sorganov@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 22/33] diff-merges: implement new values for
 --diff-merges
References: <20201101193330.24775-1-sorganov@gmail.com>
        <20201216184929.3924-1-sorganov@gmail.com>
        <20201216184929.3924-23-sorganov@gmail.com>
        <CABPp-BG1S83EUbqtqqjeLT4=Je44BpRMrf0MB+DNQK2wjRDbqQ@mail.gmail.com>
        <871rfncie5.fsf@osv.gnss.ru>
        <CABPp-BFtJ_LE2RhKoOQQ7h_Nspa=12Chwtp8kBq0PCKA6j2BPA@mail.gmail.com>
Date:   Sat, 19 Dec 2020 00:00:52 +0300
In-Reply-To: <CABPp-BFtJ_LE2RhKoOQQ7h_Nspa=12Chwtp8kBq0PCKA6j2BPA@mail.gmail.com>
        (Elijah Newren's message of "Fri, 18 Dec 2020 08:42:11 -0800")
Message-ID: <878s9u96d7.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Fri, Dec 18, 2020 at 6:12 AM Sergey Organov <sorganov@gmail.com> wrote:
>>
>> Elijah Newren <newren@gmail.com> writes:
>>
>> > On Wed, Dec 16, 2020 at 10:50 AM Sergey Organov <sorganov@gmail.com> wrote:
>> >>
>> >> We first implement new options as exact synonyms for their original
>> >> counterparts, to get all the infrastructure right, and keep functional
>> >> improvements for later commits.
>> >>
>> >> The following values are implemented:
>> >>
>> >> --diff-merges=          old equivalent
>> >> first|first-parent    = --first-parent (only format implications)
>> >> sep|separate          = -m
>> >> comb|combined         = -c
>> >> dense| dense-combined = --cc
>> >>
>> >> Signed-off-by: Sergey Organov <sorganov@gmail.com>
>> >> ---
>> >>  diff-merges.c | 19 ++++++++++++++++---
>> >>  1 file changed, 16 insertions(+), 3 deletions(-)
>> >>
>> >> diff --git a/diff-merges.c b/diff-merges.c
>> >> index 6446e2093661..cba391604ac7 100644
>> >> --- a/diff-merges.c
>> >> +++ b/diff-merges.c
>> >> @@ -15,6 +15,11 @@ static void set_separate(struct rev_info *revs) {
>> >>         revs->separate_merges = 1;
>> >>  }
>> >>
>> >> +static void set_first_parent(struct rev_info *revs) {
>> >> +       set_separate(revs);
>> >> +       revs->first_parent_merges = 1;
>> >> +}
>> >> +
>> >>  static void set_m(struct rev_info *revs) {
>> >>         /*
>> >>          * To "diff-index", "-m" means "match missing", and to the "log"
>> >> @@ -38,11 +43,19 @@ static void set_dense_combined(struct rev_info *revs) {
>> >>  }
>> >>
>> >>  static void set_diff_merges(struct rev_info *revs, const char *optarg) {
>> >> -       if (!strcmp(optarg, "off")) {
>> >> +       if (0) ;
>> >
>> > Leftover cruft from some intermediate changes or something?
>>
>> No. It's just an idiom for if-switch, making all the actual cases look
>> the same. Without this the first one looks special when in fact it
>> isn't. I won't die for it though.
>>
>> >
>> >> +       else if (!strcmp(optarg, "off")   || !strcmp(optarg, "none"))
>> >>                 suppress(revs);
>> >> -       } else {
>> >> + else if (!strcmp(optarg, "first") || !strcmp(optarg,
>> >> "first-parent"))
>> >> +               set_first_parent(revs);
>> >> +       else if (!strcmp(optarg, "sep")   || !strcmp(optarg, "separate"))
>> >> +               set_separate(revs);
>> >> +       else if (!strcmp(optarg, "comb")  || !strcmp(optarg, "combined"))
>> >> +               set_combined(revs);
>> >> + else if (!strcmp(optarg, "dense") || !strcmp(optarg,
>> >> "dense-combined"))
>> >> +               set_dense_combined(revs);
>> >> +       else
>> >
>> > Not sure I like the special-casing for "sep" and "comb".  "dense"
>> > seems okay since it's a real word.
>>
>> That was a poor-man attempt at unique shortcuts made by hand, as well as
>> a reminder to consider to re-write this using generic options framework
>> that will do it automagically. They are just a few first letters,
>> nothing more. That's why I didn't even document them.
>
> Seems like a
>    /* TODO: use generic options framework to allow abbreviations */
> would make that intent much more clear.
>
>> > Since you're adding short versions of m, c, and cc later in the
>> > series, do we need these other special-case forms?
>>
>> No, I don't think we do necessarily need them, but then they do no harm
>> either, so I didn't remove them when I added m, c, and cc. Neither was I
>> sure we do need these m, c, and cc in the first place.
>
> Well, I'd say it certainly adds clutter for reviewers, so there is at
> least a little harm.  ;-)  It was on the patch that added m, c, and cc
> that it particularly stood out to me, so I looked up the relevant
> commit so that I could add the comment at the right place to make it
> easier for you to rip out.

May that's because they did make sense before the patch that added m, c,
and cc, where they stood out for you.

Overall, if we do agree m, c, and cc mnemonics are good to have, I'd opt
for removing these hand-made abbrevs indeed.

Thanks,
-- Sergey
