Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6740DC433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 20:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F6D26135A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 20:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhESUlB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 16:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhESUlB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 16:41:01 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B23CC06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 13:39:40 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i23-20020a9d68d70000b02902dc19ed4c15so12984298oto.0
        for <git@vger.kernel.org>; Wed, 19 May 2021 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=FWcoa1PK5ySQBWRZDvwBrW8T+AI6vKkzV3Wf8QJXkTY=;
        b=phJQk8pbABKURaH5XDEuTHfRr2aCD521cY5SjCdMsS/npBBA/Zrvy00cCm/vpW8mgB
         H48xVnP0m1dV4d1HrvlZOZdLG4uiti1pr9fG9wZjsV2PYgzEqsG+LPq/dYjoD1V1WOhw
         yXAl2QgqNh83E0H7jUBqP2N0QyFCRpSwUO6kpT0Eki91roSR7RTM2a4pehXKVpw+nR+x
         mqAbalXi5PP0XLvS/No9XQjNhB98F3RxfeiPk7jjoBNN3SWs4G1g3CfEiPVBm3NeEZkR
         BJ9hJM9mBcXASFcmSpJ8u7AfjWwF7KN8VVaTHOipFDp4ouBNl3PwRSwvfiMexQbcdpIj
         PVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=FWcoa1PK5ySQBWRZDvwBrW8T+AI6vKkzV3Wf8QJXkTY=;
        b=hRHXFZGQgzApS9iMBHiB4ilulY5cdntRYEDLTQnYj+H6IvO5muOxcQvivpmKCwNVlu
         gD6l3VpeAJbUjDrkIllSain3iN96KaH79CQcdLV/5nXJyFpJ4El5Bzwrl1NP10XdhHzi
         n14bSwvqHohYgd6SXAqX2u4QgroXgTPBDxaBc1NKaT5SChoEBQxnZ34P0+xn9XxDh8tj
         Nl0wIxDKrSMpOgHiMNf0D96/RkCMLPvTJXMtlU5M7r753hfogia7tV54UccssmaX5xKt
         iOjMqlR0TmbOmVgo7TUCk4SXdUaEl9vJgfnXqdbHBUTjvAUeaGtfEbxWFd7PT5H9xUr8
         S8YQ==
X-Gm-Message-State: AOAM531QPKEA+sjlid3tYt+ezVjevo24a8ZuoEvOPLE3wCpPX5idOYPl
        EfXGJ5m1Ria4A1HidyUnuMA=
X-Google-Smtp-Source: ABdhPJweZHhcvd+MlUxhG6nuv1YETeV4BBJMTEPSFPhz3vHscUqTp75pDbRY9wcicl+vb1QvwhT28Q==
X-Received: by 2002:a9d:2f48:: with SMTP id h66mr1091495otb.213.1621456779364;
        Wed, 19 May 2021 13:39:39 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id o80sm94981ooo.41.2021.05.19.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 13:39:38 -0700 (PDT)
Date:   Wed, 19 May 2021 15:39:37 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Message-ID: <60a5778992ddd_1b578208e3@natae.notmuch>
In-Reply-To: <YKVsw3uqb66ifzvd@google.com>
References: <YKTXlTjwOUi4W+R8@coredump.intra.peff.net>
 <YKVsw3uqb66ifzvd@google.com>
Subject: Re: [PATCH] doc: explain the use of color.pager
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder wrote:

> More importantly, I think I'd find a reference to the commit or a
> quotation from the affected user more helpful than a reference to the
> mailing list archive, since that would make this a bit more
> self-contained.

And for me it's the opposite; I find what one user found at one point in
time long ago not particularly important. At best it's a footnote.

> [...]
> > --- a/Documentation/config/color.txt
> > +++ b/Documentation/config/color.txt
> > @@ -127,8 +127,9 @@ color.interactive.<slot>::
> >  	interactive commands.
> >  
> >  color.pager::
> > -	A boolean to enable/disable colored output when the pager is in
> > -	use (default is true).
> > +	A boolean to specify whether `auto` color modes should colorize
> > +	output going to the pager. Defaults to true; set this to false
> > +	if your pager does not understand ANSI color codes.
> 
> I quite like the "set this to false if your pager does not understand
> ANSI color codes" part --- short and to the point.
> 
> The sentence before takes me long enough to understand that I don't
> think we've gotten the wording right yet.  Before I suggest some
> wording, let's make sure I understand the behavior correctly:
> 
> - unlike other color.* settings, this can only be "true" or "false".
>   It cannot be "auto".
> 
> - in other color.* settings, "auto" means "colors are used only when
>   stderr goes to a terminal".  A pager typically ultimately writes to
>   a terminal, but (1) it's not guaranteed to (e.g., xless writes to
>   its own window instead) and (2) more importantly for us, it's not
>   guaranteed to write terminal escapes as is.
> 
> - so this setting can be used to answer "for the sake of evaluating
>   color settings, should we treat output that is going to a pager as
>   going to a terminal?"

Correct.

> If I understood correctly, how about some text like the following?
> 
> 	A boolean to specify whether `auto` color modes should colorize
> 	output going to a pager, in addition to their behavior of
> 	colorizing output going to a terminal.

The "in adittion" part is unnecessary. You don't say "the rest of git's
behavior remains unafffected" on every single configuration. That is
obvious.

We are specifying what happens when output is going to a pager, that's
it.

Everything else--including what happens when the output going to
different programs--it not relevant.

In addition, as far as I can recall there are no commands that send
output both to a pager and to a terminal.

> Side note, not about this patch: we treat pager.color as a synonym for
> color.pager.  Is that something we want to document, or is that an
> instance of being extra friendly when the user makes a typo?

I suspect pager.color is a remnant from an ancient suboptimal name choice.

-- 
Felipe Contreras
