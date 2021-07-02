Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ED4BC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 546C461427
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 12:16:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbhGBMTZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 08:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232058AbhGBMSw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 08:18:52 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F96C061762
        for <git@vger.kernel.org>; Fri,  2 Jul 2021 05:16:19 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w17so12924677edd.10
        for <git@vger.kernel.org>; Fri, 02 Jul 2021 05:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=lhyHM44axTFtLvWyJfQxAxLssFdiiMGS2c8bFdXHg18=;
        b=Cg70q2rXlM5r6QIVJL9oBQ18ez/HomEwmDU5jb7S8VD19gEAVcsTtQ7hgJ/57/JJuF
         dwT6Sqx+em6ZZqLMr44uBYQepE1NWWLBRlNvCl6MqPbfzoMwkpDsS4KXspsI+q7yRCd6
         oO2wK8l7AUpECQm76uBPOOFnQeWpdSPq0wc/Wb5b+Or80eE5eyfUL+iWvA8cgW2Yo7t3
         DKVQJheNgyK9PBGrMf0v0o9PzfbFo8oMA5GdNrTPxnCZQl2op0bWlYeEJcOG7SR/vWF5
         0o++nf0GdFH3D/8EZzF7R1dS/PB+yL7ZN9A+YDvDSTn3lkWrC0DQmfmUwJM0x4AAw6/3
         qX4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=lhyHM44axTFtLvWyJfQxAxLssFdiiMGS2c8bFdXHg18=;
        b=hQJlTWM7n3t4exuufhT6xbSmamE+5wvXM9HlqKinoUSTYBCJn5NQZ+j8FKt+nrdCZ7
         vR6J2wNgiic0X1IfuOlemhnTM2YatnRkG7tgGHvjzZ6NUMPTeGiVcNfs5Qcko2bcMOhF
         /G+rMktAHLJFQ3OOUjUbcUtWNdunEGyZZ/ogVx2dYwJpqVWQc/bhohdlRLmTkQweNM7h
         0lb5lcemDNoqXVCQCkPyoK+Y10YvmGr5B+B/cYnq7WcYxgy/XRwddNKSCHlvzrp1u76R
         At8w7ZnbJYyElQCnRpgGbk4sXJKWilt8LlTmNwxaktCHEHOCVfu9Zx8e7t8JJDiHMX8j
         jkNA==
X-Gm-Message-State: AOAM532L4EdgkctYMwT/tgULrZrdUZtkqGjhJ3PrqVr5RM/l9qRY2ZQc
        ITFOyiM9dJAShrPPTgFgzmo=
X-Google-Smtp-Source: ABdhPJzAvWjEZ//8iZY26+1m5hXpCh07SnxGFAj79r2EIf7Mn68Cd4VH0mGWPHu0YVSQ0cW32SJqZQ==
X-Received: by 2002:a50:ec08:: with SMTP id g8mr6345926edr.98.1625228178370;
        Fri, 02 Jul 2021 05:16:18 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id j19sm1238945edr.64.2021.07.02.05.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jul 2021 05:16:17 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Michal =?utf-8?Q?Such=C3=A1nek?= <msuchanek@suse.de>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Date:   Fri, 02 Jul 2021 14:15:10 +0200
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
 <YKViF9OVLeA95JPH@google.com> <20210520071141.GZ8544@kitsune.suse.cz>
 <YKaaBj0KmJ3K5foC@coredump.intra.peff.net> <xmqqwnrtt84s.fsf@gitster.g>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <xmqqwnrtt84s.fsf@gitster.g>
Message-ID: <87wnq8ap2n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, May 21 2021, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
>
>> decision. Likewise for irc. I don't think #git or even #git-devel has
>> any official status. It is simply where people doing things chose to go.
>> Now they may choose to go somewhere else, but they don't necessarily
>> have to do it as a unit.
>
> FYI I contacted https://libera.chat/ to register "as a project",
> primarily to prevent other folks squat on #git and #git-*; if we
> decide to move our bi-weekly "Git Standup" there, it may turn out to
> be useful.

I don't know if it was formally decided, but it seems the standup is in
fact happening on liberachat recently. Could you update the calendar
entry in your "Git" calendar[1] to s/irc.freenode.org/irc.libera.chat/g?

1. https://calendar.google.com/calendar/embed?src=jfgbl2mrlipp4pb6ieih0qr3so%40group.calendar.google.com
