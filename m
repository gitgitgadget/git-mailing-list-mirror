Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD510C77B7F
	for <git@archiver.kernel.org>; Fri, 12 May 2023 08:40:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239992AbjELIkS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 04:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232659AbjELIkQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 04:40:16 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC2A92D48
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:40:14 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f24ceae142so7470047e87.3
        for <git@vger.kernel.org>; Fri, 12 May 2023 01:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683880813; x=1686472813;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pi4eFjU3/RTwnz5MuTPE/VaY+7cvmjDOXrZ3rS3YTfw=;
        b=dC4R53OOGYnTgGLnjpT84WcYtuX7HLqNFMYYML+0mUyb9hX9tS2n2AyS8L8kjU23Gt
         eyjWuaurBIhZd1ndQ9wWqKYCLm+Q9NKR/uVHMdJ3GnrZcF/lGSVOd1QxwYUDVUwMg8lv
         +CsrYHhqnLzzzzZyaEQwXBds0YrASKDd2Ito0v/RPGeYApzzDu0A6dmhAh6zuRDnDs5/
         fUTLaAigLAw+WSjnFwemzgrZyX4HM30wpY+WvfM1tl+qxqCGakddIBzJ4DVqby+JLxEV
         +ZIFTDzREEjsR3tZ+6nJBc2Xcj1hRJUI7gOCGZeinZUUFid4Gt04fuRjms6lxf2I3MJD
         nAKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683880813; x=1686472813;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pi4eFjU3/RTwnz5MuTPE/VaY+7cvmjDOXrZ3rS3YTfw=;
        b=JpqkJOrdyZqKaClf/20RwCQcwGTzrVMxnMr+Yr86sg1XrJRJSM5c6yoBHVul3TIC4s
         9e2j7OPEidbznjCcpy9mukcSWKA0uwe+OJNUhEl9kmVdqaMhyTOSGuKJ2Xi35oJXdHCE
         rHomoWvwcC/z008vosA9Xe0pAdQhEKrIDTPKqU6DH01HVzCIhQUV97tKv4v9gnt/Ho+8
         LhKPXtIOKqDhcWYb0rPBg7wnlMGJBtww1z6qepAmzucSphH1/1NTcFLY+U3ce2qBzqs+
         tO/245GvDDM8tiJydQAXYliVlAmOXxeNtzmWbJwVVlEyZBhQp31pSVREX9i4CAjC5aWT
         uvOw==
X-Gm-Message-State: AC+VfDy8IF32ey7syp1PtTp8A6W6Z5CHuNiOdID20lmjRExwsp9T6jnr
        hxO5u1yfKV9NeWIHNA4U1k23lkPDTuY0wQ==
X-Google-Smtp-Source: ACHHUZ5xwcHtpQrEkIQy2/ZMQBAhwI4KHlCSOjaG7abAZT0bY7xpg58b/kP0x/dAU0hUc5S/UeG2Iw==
X-Received: by 2002:ac2:5096:0:b0:4f1:3f83:fd15 with SMTP id f22-20020ac25096000000b004f13f83fd15mr3288776lfm.36.1683880812816;
        Fri, 12 May 2023 01:40:12 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id u24-20020ac24c38000000b004f252f48e5fsm131230lfq.40.2023.05.12.01.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 01:40:12 -0700 (PDT)
From:   Sergey Organov <sorganov@gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru>
        <645d28e112294_26011a294b2@chronos.notmuch>
        <877cte200m.fsf@osv.gnss.ru>
        <645d3dbf785a5_26069229463@chronos.notmuch>
        <87wn1ezms9.fsf@osv.gnss.ru>
        <645d480be344d_260ff5294c@chronos.notmuch>
        <87mt2azkdp.fsf@osv.gnss.ru>
        <645d572a47e5b_57c4e294dc@chronos.notmuch>
        <87fs82zdny.fsf@osv.gnss.ru>
        <645d7a153ac66_1ba85a29451@chronos.notmuch>
Date:   Fri, 12 May 2023 11:40:11 +0300
In-Reply-To: <645d7a153ac66_1ba85a29451@chronos.notmuch> (Felipe Contreras's
        message of "Thu, 11 May 2023 17:28:21 -0600")
Message-ID: <873542j638.fsf@osv.gnss.ru>
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
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> > Sergey Organov wrote:
>> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> >> > Sergey Organov wrote:
>> >> >> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> >> >> > Sergey Organov wrote:
>> >> >> >> >
>> >> >> >> >> I'd rather think about generic interface for setting/clearing
>> >> >> >> >> (multiple) bits through CI than resorting to such convenience
>> >> >> >> >> tricks. Once that is in place, one will be able to say "I need these
>> >> >> >> >> bits only", "I need to turn these bit(s) on", and "I need to turn
>> >> >> >> >> these bit(s) off" conveniently and universally in any part of Git CI
>> >> >> >> >> where it's needed.
>> >> >> >> >
>> >> >> >> > It's possible to achieve both.
>> >> >> >> >
>> >> >> >> > Imagine your ideal explicit interface. In that interface the default
>> >> >> >> > is no output, so you *have* to specify all the bits, for example:
>> >> >> >> >
>> >> >> >> >   git show --patch
>> >> >> >> 
>> >> >> >> No, that's not what I meant. There is no point in making "git show" to
>> >> >> >> have no output by default, please see below.
>> >> >> >> 
>> >> >> >> >
>> >> >> >> > Or:
>> >> >> >> >
>> >> >> >> >   git show --raw
>> >> >> >> >
>> >> >> >> > In this ideal interface it's clear what the user wants to do, because
>> >> >> >> > it's explicit.
>> >> >> >> >
>> >> >> >> >   git show --patch --raw --no-patch
>> >> >> >> >
>> >> >> >> > Agreed?
>> >> >> >> >
>> >> >> >> > My proposal achieves your ideal explicit interface, except when no
>> >> >> >> > format is specified (e.g. `git show`), a default format is chosen for
>> >> >> >> > the user, but that's *only* if the user hasn't specified any format.
>> >> >> >> 
>> >> >> >> My point is that the default format should be selected as if it has been
>> >> >> >> provided by existing options, rather than by some magic hidden in the
>> >> >> >> code.
>> >> >> >
>> >> >> > But why?
>> >> >> >
>> >> >> > I don't see any benefit, only drawbacks.
>> >> >> >
>> >> >> >> > If you explicitely specify the output format that you want, then the
>> >> >> >> > default is irrelevant to you, thus you have your ideal explicit
>> >> >> >> > interface.
>> >> >> >> 
>> >> >> >> That's not what I had in mind, sorry. It'd rather be something like:
>> >> >> >> 
>> >> >> >>   --raw: set "raw" bit and clear all the rest
>> >> >> >>   --+raw set "raw" bit  (== current --raw)
>> >> >> >>   ---raw clear "raw" bit (== --no-raw)
>> >> >> >> 
>> >> >> >> In this model
>> >> >> >> 
>> >> >> >>   git show
>> >> >> >> 
>> >> >> >> would be just an alias for
>> >> >> >> 
>> >> >> >>   git log -n1 --patch --cc
>> >> >> >> 
>> >> >> >> and no support for a separate command would be need in the first place.
>> >> >> >> 
>> >> >> >>   git show --raw
>> >> >> >> 
>> >> >> >> would then produce expected output that makes sense due to the common
>> >> >> >> option processing rules, not because somebody had implemented some
>> >> >> >> arbitrary "defaults" for the command.
>> >> >> >
>> >> >> > But now you are at the mercy of those "arbitrary defaults".
>> >> >> 
>> >> >> No, see below.
>> >> >> 
>> >> >> >
>> >> >> > Let's say those defaults change, and now the default output of `git show` is
>> >> >> > `--stat`.
>> >> >> >
>> >> >> > Now to generate the same output you have to do:
>> >> >> >
>> >> >> >   git show --raw
>> >> >> >
>> >> >> > in one version of git, and:
>> >> >> >
>> >> >> >   git show --no-stat --patch --raw
>> >> >> >
>> >> >> > in another.
>> >> >> 
>> >> >> No: --raw in my model clears all the flags but --raw, so
>> >> >> 
>> >> >>   git show --raw
>> >> >> 
>> >> >> will produce exactly the same result: raw output only.
>> >> >
>> >> > But that {--,--+,---} notion doesn't exist, and I think it's safe to say it
>> >> > will never exist. So, could we limit or solution-space to those solutions that
>> >> > could have the potential to be merged?
>> >> 
>> >> I didn't expect it to exist any time soon, just showed a different way
>> >> of options design.
>> >> 
>> >> >
>> >> > What you suggest could be easily achieved with:
>> >> >
>> >> >   git show --silent --raw
>> >> >
>> >> > But because no other format is explicitely specified, following my notion of
>> >> > defaults, that's the same as:
>> >> 
>> >> The problem that I tried to fight is this notion of defaults that is
>> >> somewhat special, so, if I allow for it, the rest of my suggestions
>> >> becomes pointless,
>> >
>> > No, they don't, all you need to do is specify the default explicitely.
>> >
>> >> and without the "defaults" with non-trivial behavior[*]
>> >> 
>> >>    git show --raw
>> >> 
>> >> won't work as expected provided --raw still just sets "raw" bit and
>> >> doesn't clear all the rest.
>> >
>> > It works perfectly fine. There are no bits to clear, because there are no bits
>> > set.
>> 
>> When I set default value to a variable in C, it does have bits set, and
>> they are kept unless overwritten, so they are set by default as well.
>> Exactly the bits that I've set. Here I've proposed the same principle
>> for handling of options.
>> 
>> What you have in mind is exactly the current behavior
>
> No, it's very different.
>
>  cur: git diff --raw --no-patch # no output
>  new: git diff --raw --no-patch # raw output
>
>  cur: git diff -s --raw # no output
>  new: git diff -s --raw # raw output
>
>  cur: git diff -s --patch --raw --no-patch # no output
>  new: git diff -s --patch --raw --no-patch # raw output
>
> I've no idea what makes you think these are exactly the same.

I was discussing the behavior of defaults rather than the behavior of
particular option sets, and we already agreed about the latter from the
very beginning.

Thanks,
-- Sergey Organov
