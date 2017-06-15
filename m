Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9271020401
	for <e@80x24.org>; Thu, 15 Jun 2017 18:38:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752660AbdFOSh4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 14:37:56 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34601 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdFOShx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 14:37:53 -0400
Received: by mail-pg0-f53.google.com with SMTP id v18so10201054pgb.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 11:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=RjP6oxBPg+H1GIG7St9B6Hw290CctwV/oY4tn7P1NRY=;
        b=lOtnSRPEKKQSciZPdYRxcPDYFKsuTw0s71fnKeldqnkb7x9C7nLyHYaOp17hiu+nFT
         sTWP9ZeIwRBSc3jQ0TL6xs7W0B4PlZUFfmKT59sAX/6K7QsJajjiMdH0SbKm1qNMR/K+
         Er007i1mZVYXmthvY+3zEXnf4gY/8F+PeavHEBAnXXA/vnU4uildIH8KMEGPGg6g8s8P
         +FprAu1VFq4OfSF0KwZ9eaWUMpAW4n8TSZTZoAS0eqA9FUbXmHU8kh3/Xo6B0twZK4rx
         mmuEwPge6z1e3K++pVanfPef9AIr3I8NJ/xWH4bFS1d5EyZ8DXyTC6Djnidzx042oYE7
         W4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=RjP6oxBPg+H1GIG7St9B6Hw290CctwV/oY4tn7P1NRY=;
        b=XPTOvc1+Cg43jZ4WnhlftqOn+kxrnz751n5M/1fhqoF8CrLND2FUl5COIL0kefMjOg
         scf74Bu8G5Xv7uKbOg6qWs8FiTnK0Ad5gWK9Yk/VvWFJEUEFnwZRj4yy/7Z4vYz8vtLb
         4+Gru3LIkC7TCkXRAEIReAdbD5oBW3OQtRxcMDFxSeoodQLBcvzEj+6GUexmMzG91wnW
         kDYf77IkFzTRoEN3XB9J8GMTQMoZ/2GV1DCUpSeIsujbKzUrBeBz8eT6KInCVGX9S+TD
         cgusHWjHlEMFO3BHOfts6McKkEvrtN9N/FeY52qS4+06YGtgQfIeZ+jBpB5AnHrSDKP2
         S1KA==
X-Gm-Message-State: AKS2vOxpHBSpqhXWXtNyyohBNOXRwfzAjX3LZwVxT8CcYcBIyusNuPch
        5ySEQcbzkb09xg==
X-Received: by 10.84.129.35 with SMTP id 32mr7864420plb.165.1497551873046;
        Thu, 15 Jun 2017 11:37:53 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id d88sm1539549pfk.133.2017.06.15.11.37.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 11:37:52 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Michael Giuffrida <michaelpg@chromium.org>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [BUG] add_again() off-by-one error in custom format
References: <CACi5S_1j46SbP7cQMdUnULmgGD7xBkSUrS2PKbzq8ZydybHE=w@mail.gmail.com>
        <xmqqd1a8n7o8.fsf@gitster.mtv.corp.google.com>
        <d229403a-d078-87b4-f3e8-89058fa4b548@web.de>
        <xmqqtw3j68rc.fsf@gitster.mtv.corp.google.com>
        <99d19e5a-9f79-9c1e-3a23-7b2437b04ce9@web.de>
        <xmqqwp8f4mb2.fsf@gitster.mtv.corp.google.com>
        <dae96f72-761c-3ed1-4567-0933acc7618a@web.de>
Date:   Thu, 15 Jun 2017 11:37:51 -0700
In-Reply-To: <dae96f72-761c-3ed1-4567-0933acc7618a@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 14 Jun 2017 20:24:25 +0200")
Message-ID: <xmqqtw3h14hs.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> Am 13.06.2017 um 23:20 schrieb Junio C Hamano:
>
>> I think the real question is how likely people use more than one
>> occurrence of the same thing in their custom format, and how deeply
>> they care that --format='%h %h' costs more than --format='%h'.  The
>> cost won't of course be double (because the main traversal costs
>> without any output), but it would be rather unreasonable to expect
>> that --format='%h %h %h %h %h' to cost the same as --format='%h';
>> after all, Git is doing more for them ;-)
>
> The answer to the first half is obviously "very likely" -- otherwise
> this bug wouldn't have been found, right? :)

Not really.  There was only one (this one) after all these years.
The question we are asking is not "very rarely this is used and we
can afford to leave it broken?"  It is "very rarely this is used
and we can afford not to optimize for that rare use case?".

> Regarding the question of how bad a 50% slowdown for a second %h
> would be: No idea.  If ran interactively it may not even be noticeable
> because the user can read the first few lines in less while the rest
> is prepared in the background.  We don't have a perf test for formats
> with duplicate short hashes, so we don't promise anything, right? :)

OK.

> -- >8 --
> Subject: [PATCH] pretty: recalculate duplicate short hashes
>
> b9c6232138 (--format=pretty: avoid calculating expensive expansions
> twice) optimized adding short hashes multiple times by using the
> fact that the output strbuf was only ever simply appended to and
> copying the added string from the previous run.  That prerequisite
> is no longer given; we now have modfiers like %< and %+ that can
> cause the cache to lose track of the correct offsets.  Remove it.
>
> Reported-by: Michael Giuffrida <michaelpg@chromium.org>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> I'm sending this out in the hope that there might be a simple way
> to fix it after all, like Gábor's patch does for %+.  %< and %>
> seem to be the only other problematic modifiers for now -- I'm
> actually surprised that %w seems to be OK.

Thanks, this looks like a sensible first step.  Will queue.
