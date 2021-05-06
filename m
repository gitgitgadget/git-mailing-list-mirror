Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ACDFC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31F5D6144F
	for <git@archiver.kernel.org>; Thu,  6 May 2021 15:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbhEFP0T (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 11:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235477AbhEFPZl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 11:25:41 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E81C061344
        for <git@vger.kernel.org>; Thu,  6 May 2021 08:24:41 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a4so8889788ejk.1
        for <git@vger.kernel.org>; Thu, 06 May 2021 08:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=pvrS9on/SYLGzEbyDvzYiwzhk+WfUCt/Jst05If0uMc=;
        b=PW4PcGrQiJF5hrJymtRxdqP5sjrMopxWrN/OwG2sdrlQ8Df5ok+dpaiTWpHS9o0DtP
         RDSZ7bLini7kuEV0iXNuE+xBv7qZpHBr5zhC5UreUCIAmXMqnko/Xqk2DaqPNaWpwXm6
         FrpU4p/DK1lt9IG4Q1BPeX+ZokxgHTuBf849Y6RupkqAYgU86A6BCz+mk3lHcwYQHHP6
         ds6EDxwpGGy8Sx4wtvdA7Df5iOshQXEZScr9w74v+OR6hKVb1CwEik3cmf0ClgUQIFU6
         srn0875/V6hhas+c1MB1GqneJ6gGXlSyF46cFJvAt1pOdHtSGscd/zAVq8rzeATr3eJp
         w+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=pvrS9on/SYLGzEbyDvzYiwzhk+WfUCt/Jst05If0uMc=;
        b=OAnNH4QkL9Kn0Aeay+RnU8RIeaWuQfwAruSKVLOaTjjRF+odxi6nj/YXjQpu7XI5lZ
         yhuMZHhW5G/1hZFHCCIftyrswthvn6HS5YFIPf1AnGgw467jtof8l6Yn7FUakLBWgDhs
         O+nAne+YYHJue+m1Zpcn/jS1ZP+yLr2bOEPBG4J3i8NDjNlqtMMZOxEOSOS0gqT44t8e
         FUeAXwMGR1iiog68Om/hAF3gvPO0axcM3A/I2LJDllcpOw38cLtttA846RlmtJR8HhQ9
         o4Oo3zpYJz8SzLbIohGn+c9bUV572ykkzV/G6QMhP/hhiLkXilRS6VV3i1/shO8jHc/0
         F0lw==
X-Gm-Message-State: AOAM531imFtJwY73UGZJLEKWxBnv6ToZrV+dIUJ0fggC1VvfFhLso1VW
        r3Uecl3DlY3BgyKcqkUTAws=
X-Google-Smtp-Source: ABdhPJyL9UoaubLPR9BaC5CG8Rn1Lletd/GSEK8QLBr2NXM3M/qWvzk2YR7MrfoNS734SHoNtFKZlw==
X-Received: by 2002:a17:906:3ce9:: with SMTP id d9mr4992492ejh.172.1620314679969;
        Thu, 06 May 2021 08:24:39 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h4sm929671edv.97.2021.05.06.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 08:24:39 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Susi <phill@thesusis.net>
Cc:     git@vger.kernel.org
Subject: Re: git send-email says AUTH is unknown command?
Date:   Thu, 06 May 2021 17:22:31 +0200
References: <878s4sc7gr.fsf@vps.thesusis.net>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <878s4sc7gr.fsf@vps.thesusis.net>
Message-ID: <87k0obvqa1.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, May 06 2021, Phillip Susi wrote:

> git send-email prompts for my SMTP password then says:
> Command unknown: 'AUTH' at /usr/lib/git-core/git-send-email line 1573.
>
> That line reads:
>
> smtp_auth_maybe or die $smtp->message;
>
> Why is it complaining that it does not know what AUTH means?  It is
> connecting to port 25 and /should/ be using STARTTLS.

This message is from your server indirectly, i.e. there is no AUTH verb
supported by it.

I'm almost certain that you'll find that you cannot in fact auth on port
25 on this server, and must use another port to do SSL from the start,
i.e. not STARTSSL[1].

We should probably intercept this in particular and emit a better error,
patches welcome :)

1. https://metacpan.org/release/libnet/source/lib/Net/SMTP.pm#L169
