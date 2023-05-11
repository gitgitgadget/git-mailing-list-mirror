Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19960C77B7C
	for <git@archiver.kernel.org>; Thu, 11 May 2023 19:33:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238741AbjEKTdA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 15:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232629AbjEKTc7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 15:32:59 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B162859D0
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:32:57 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2ac7f53ae44so97568731fa.2
        for <git@vger.kernel.org>; Thu, 11 May 2023 12:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683833576; x=1686425576;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WN881+kpo4v+XHQslmqM7FeMDGa+Sqe/fzWxKY3MKoQ=;
        b=YcjRssCZr9SL2RjdkvycYfb8y+aq6NZpPt5nd5ySbEmnSnFDqrIHTofle74uHoii5z
         EhD6sLUfqEpua8jNsKFT6BWvutK0M8KPN+hLzXXrHA/Rw3rYNdEd4vdlJTwzxE6iF0vw
         8WvK5RaLCOGRjGwPrqj21cb5cpXCppypwkLDwfZVt/YN8UGP5yVYTRdP5u3y2ig1p2Ag
         mbhzSJlQxi0C569D/03xx6UKyR7aiAIau3qoo9YA+yLYLyi42/3qrlJyrIkY7Plcbe2e
         gjFih+jy4CVhWjwhsVGioHJNRi/Hh7gJcHZ2gpdYqNCMQU+ZmGieygIO+ROI6+I/zEM7
         nX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683833576; x=1686425576;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WN881+kpo4v+XHQslmqM7FeMDGa+Sqe/fzWxKY3MKoQ=;
        b=SO1auzJCjvFEPaLNP4wW9ri61h9kVI2FG8/TdW74LzJLt4ItAYP9fjhphoSwkdW848
         nzd2PeEb+eItdZJGAnC4rQH9Q+/6BsXyczm3I6WfddKeXSVdAiEHxFvYNX6i8G8TnNdH
         Z7C85xG7OWxlwLwP949ftDKMaSkcu02EV41YOqxtglNBcD/IfAyEky7yYzP41oZvFRK8
         4dN5G9KyjnrPXz0dQEXs/8D4TO8392rz218JZPR3C5tIenxSFV3IVUEi6qWiaTFCWMkg
         87Acs2paegTtczi1dkTJ44zMsSZmMs/xKmGp1aOnjevutBQ2ityMfnBqMCAkhLu3p5dr
         GVKg==
X-Gm-Message-State: AC+VfDxYt9j+LCUYSmxIOI+alQk+oaSKNV8g0Kk6f2JsYcczHDeRC2pc
        AyQ2rOpbI0M9NqT4SVdyPVw=
X-Google-Smtp-Source: ACHHUZ6jCI0i/SG4yOTSASECglM6wcM/cIYiWoUE7J+m2Su0LeG+QR6TB41lxuOoMzZUrOteJu0Edg==
X-Received: by 2002:a2e:9942:0:b0:2ad:8f4a:4ed5 with SMTP id r2-20020a2e9942000000b002ad8f4a4ed5mr3185190ljj.37.1683833575725;
        Thu, 11 May 2023 12:32:55 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id v20-20020a2e9f54000000b002ada0c38963sm1175849ljk.62.2023.05.11.12.32.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 12:32:55 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <645d28e112294_26011a294b2@chronos.notmuch>
        <877cte200m.fsf@osv.gnss.ru>
        <645d3dbf785a5_26069229463@chronos.notmuch>
Date:   Thu, 11 May 2023 22:32:54 +0300
In-Reply-To: <645d3dbf785a5_26069229463@chronos.notmuch> (Felipe Contreras's
        message of "Thu, 11 May 2023 13:10:55 -0600")
Message-ID: <87wn1ezms9.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> > Sergey Organov wrote:
>> >
>> >> I'd rather think about generic interface for setting/clearing
>> >> (multiple) bits through CI than resorting to such convenience
>> >> tricks. Once that is in place, one will be able to say "I need these
>> >> bits only", "I need to turn these bit(s) on", and "I need to turn
>> >> these bit(s) off" conveniently and universally in any part of Git CI
>> >> where it's needed.
>> >
>> > It's possible to achieve both.
>> >
>> > Imagine your ideal explicit interface. In that interface the default
>> > is no output, so you *have* to specify all the bits, for example:
>> >
>> >   git show --patch
>> 
>> No, that's not what I meant. There is no point in making "git show" to
>> have no output by default, please see below.
>> 
>> >
>> > Or:
>> >
>> >   git show --raw
>> >
>> > In this ideal interface it's clear what the user wants to do, because
>> > it's explicit.
>> >
>> >   git show --patch --raw --no-patch
>> >
>> > Agreed?
>> >
>> > My proposal achieves your ideal explicit interface, except when no
>> > format is specified (e.g. `git show`), a default format is chosen for
>> > the user, but that's *only* if the user hasn't specified any format.
>> 
>> My point is that the default format should be selected as if it has been
>> provided by existing options, rather than by some magic hidden in the
>> code.
>
> But why?
>
> I don't see any benefit, only drawbacks.
>
>> > If you explicitely specify the output format that you want, then the
>> > default is irrelevant to you, thus you have your ideal explicit
>> > interface.
>> 
>> That's not what I had in mind, sorry. It'd rather be something like:
>> 
>>   --raw: set "raw" bit and clear all the rest
>>   --+raw set "raw" bit  (== current --raw)
>>   ---raw clear "raw" bit (== --no-raw)
>> 
>> In this model
>> 
>>   git show
>> 
>> would be just an alias for
>> 
>>   git log -n1 --patch --cc
>> 
>> and no support for a separate command would be need in the first place.
>> 
>>   git show --raw
>> 
>> would then produce expected output that makes sense due to the common
>> option processing rules, not because somebody had implemented some
>> arbitrary "defaults" for the command.
>
> But now you are at the mercy of those "arbitrary defaults".

No, see below.

>
> Let's say those defaults change, and now the default output of `git show` is
> `--stat`.
>
> Now to generate the same output you have to do:
>
>   git show --raw
>
> in one version of git, and:
>
>   git show --no-stat --patch --raw
>
> in another.

No: --raw in my model clears all the flags but --raw, so

  git show --raw

will produce exactly the same result: raw output only.

Thanks,
-- Sergey Organov
