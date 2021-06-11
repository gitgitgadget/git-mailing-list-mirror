Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A271C48BD1
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:54:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5D1A61004
	for <git@archiver.kernel.org>; Fri, 11 Jun 2021 15:54:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230364AbhFKP4K (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Jun 2021 11:56:10 -0400
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38408 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229942AbhFKP4J (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jun 2021 11:56:09 -0400
Received: by mail-lf1-f43.google.com with SMTP id r5so9258599lfr.5
        for <git@vger.kernel.org>; Fri, 11 Jun 2021 08:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7RQvoJ1jxf4zzfJsjLQjo9PKCt16UD2e6ZD8Z7bISYU=;
        b=mOOsjkDG8vFTKJjU/aEsmIHOi6hiq4zBZ28Qu5/JzpVI45gUEBiVkBnqaqvBpjWkYh
         wPnMzS0b2dSpx13s1dumgb8C7aqvUk0ViaiSzxtYAz0U2kE57q1mxuD5CO9cuiQG2pmY
         Ur/Yg32la1UoGUUKLkzqdBn9EHTrBx+oShnfy/PZzLtxaPKTUMg7NS+hna+3KNfFb59U
         Rqv80kw1Qk5Krhed/ZLLQ5EP1c0tucKB+UFLpMIH5vcKLNMTkB+BBxpO/sDCnOz9kV+t
         D0oEuDsI0BvIiMxbquDKTNqo4DOubIPGbS5qfL+EWqRR/hT2W7tnEc8jHsTGLuknwvqu
         buug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=7RQvoJ1jxf4zzfJsjLQjo9PKCt16UD2e6ZD8Z7bISYU=;
        b=EqR4vpp95Hj+67Q4ym1cQJBLynYY+/mCR/v8PbbFsXpiwdb0FjULJJrs7myYnWyzdh
         UgnUgiYzau7UnPQGn3UosNk43ye2LRjbL2dUuJiE3HFAZWlBkbZKMXDm1cImqxHU/8wx
         Mdx9l30f1PhL3wGb/VnNL5FkX8ybjLI2w7wRV+CHZsINnwplW/O74o5gEzM5ftd5/t8c
         yW/xO7zbyLHNGYzTVDjHhOX8ZIRSSIs6K6iigvKqFN/N1AfC7kv4t+S6hdrnibuBydyI
         jnbRyD/YVpHh57bfdukS2VRrmKGEwZZJpB3qs6Ztbr8vtwsMh3BXubyCNXhxrb22mnUE
         sdhA==
X-Gm-Message-State: AOAM532YP0KHkpR/6VCa0Ooq2il0HIsO+PtphXQJ3+b5ivonwpX3ZsvR
        JRWju6zpUvhNJbvx4j5YXoJMrsJ/Iro=
X-Google-Smtp-Source: ABdhPJz++biUAk3nPv6PbUrpapYimJ/hb4L8tAzN6eJLmDKyl6mu5JIP866OTKBELkLPhD6Ok1/DVw==
X-Received: by 2002:ac2:44c2:: with SMTP id d2mr2975019lfm.337.1623426773618;
        Fri, 11 Jun 2021 08:52:53 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id z9sm622273lfu.53.2021.06.11.08.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 08:52:53 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>, David Aguilar <davvid@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Denton Liu <liu.denton@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 7/7] xdiff: make diff3 the default conflictStyle
References: <20210609192842.696646-1-felipe.contreras@gmail.com>
        <20210609192842.696646-8-felipe.contreras@gmail.com>
        <60883e1b-787f-5ec2-a9af-f2f6757d3c43@kdbg.org>
        <YMIYUgo71aKJ1Nnx@coredump.intra.peff.net>
        <xmqqh7i5ci3t.fsf@gitster.g>
        <638a0500-459a-a25b-afca-904ec0e09866@kdbg.org>
        <xmqqy2bg3nqw.fsf@gitster.g>
        <07ef3a3b-4812-4fa1-c60c-b9085a268bc3@kdbg.org>
        <xmqqo8cc3maq.fsf@gitster.g> <875yykipq2.fsf@osv.gnss.ru>
        <60c38205cdbf8_3ad92084@natae.notmuch>
Date:   Fri, 11 Jun 2021 18:52:52 +0300
In-Reply-To: <60c38205cdbf8_3ad92084@natae.notmuch> (Felipe Contreras's
        message of "Fri, 11 Jun 2021 10:32:21 -0500")
Message-ID: <87a6nwflez.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>
>> > I notice that "git merge --help" tells what each part separated by
>> > conflict markers mean in both output styles, but does not make a
>> > specific recommendation as to which one to use in what situation,
>> > and it might benefit a few additional sentences to help readers
>> > based on what you said, i.e. the "RCS merge" style that hides the
>> > original is succinct and easier to work with when you are familiar
>> > with what both sides did, while a more verbose "diff3" style helps
>> > when you are unfamiliar with what one side (or both sides) did.
>> 
>> I don't get it. Once you have diff3 output, and you want something
>> simpler, you just kill the inner section, right? RCS merge output style
>> is simply inferior.
>
> The issue here is not a mere inner section, it's a nested inner section
> due to a recursive merge.

No, this one is just generic suggestion by Junio to improve
documentation, unrelated to particular problematic contents of the inner
section of diff3.

Thanks
-- Sergey Organov
