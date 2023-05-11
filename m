Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9663C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 20:25:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239387AbjEKUZA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 16:25:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238381AbjEKUY5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 16:24:57 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA3F49C8
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:24:56 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-4f24cfb8539so6725276e87.3
        for <git@vger.kernel.org>; Thu, 11 May 2023 13:24:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683836695; x=1686428695;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hpz1Udl9s2KU4SrWFVVFnC23k+oFevQPuu79o014EJI=;
        b=UqtXGOqm0IW4ZzFMJ8cKvBk2wD6rft4uePPqA5yo4HGvleaFJeYj66RWrS3K04RJg5
         nwu5BlQjcWAEow1VjfklXlM/jl6+MVzwfSr9aERpOaJf9HDF2+RhqPGrTHbAUnO2crzd
         LB30J06COQdVSfQrX+OjFGmaKH+kS3pqepzsc8zlwhc9ZzkJjfB4Xd44G05kzjMVw5io
         Kq2KqpIpjOE3MEoqDKGz+6ZGe2tvy5wgHqjAFd/tVQlPA4pwSnIv1r7dA5S18U0M1UC9
         XlBhVC0GPLoI0o0MxVRkIAFeySTI79/CWJhfw5xiis9xtU4BoWNwOsHcjIQTtJyef2YE
         SIfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683836695; x=1686428695;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hpz1Udl9s2KU4SrWFVVFnC23k+oFevQPuu79o014EJI=;
        b=ErJSY5zouwHIJt0IObxxGuS8lv+5hK7jxqK5niLV+osWrkNptbwQh6C3j+7D5/nEAX
         1P/WBqyDDvz94UN2TSKd/fEi+y95dBJd42SIYh+aIswCHTf0v/G3WkseK6Uk6ZiNhwIx
         UAFQ/lXlcp64QTTabEoxyONhlDD4s59MslWPWVHEAN3hqYMSXJJj4S9kFqNOoHJfyUFw
         tdRD09w8rwoExJ3W/DTdpZp/emssite22XQXIk/Ol1R1Gx4hlbdGF1tq6RSqisOiSUGu
         JzHke6+3v/+mL97uD/W17HR5JUtIZi5hnOvZ4Jsk6n+bwFT3QhRHMeyhS3b69TRexSGN
         GPYA==
X-Gm-Message-State: AC+VfDyBnXzypbkecnSXzx5djSnBx686ojWmoRhm6z78T0bEYXxK9BY9
        jlf/73t7H8uy9lHQdB33lPs=
X-Google-Smtp-Source: ACHHUZ6NyYUwvn7/awv/W9saDGSgd6KvIGTVVW6wuaKseGDa5w7wdCqF+5iTVENX+V00DOmt08Mc8w==
X-Received: by 2002:ac2:51cb:0:b0:4b5:178f:a14c with SMTP id u11-20020ac251cb000000b004b5178fa14cmr3394028lfm.16.1683836694490;
        Thu, 11 May 2023 13:24:54 -0700 (PDT)
Received: from osv.localdomain ([89.175.180.246])
        by smtp.gmail.com with ESMTPSA id w9-20020a05651203c900b004f14ae5ded8sm1223512lfp.28.2023.05.11.13.24.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 13:24:54 -0700 (PDT)
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
Date:   Thu, 11 May 2023 23:24:50 +0300
In-Reply-To: <645d480be344d_260ff5294c@chronos.notmuch> (Felipe Contreras's
        message of "Thu, 11 May 2023 13:54:51 -0600")
Message-ID: <87mt2azkdp.fsf@osv.gnss.ru>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Sergey Organov wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> 
>> > Sergey Organov wrote:
>> >> Felipe Contreras <felipe.contreras@gmail.com> writes:
>> >> > Sergey Organov wrote:
>> >> >
>> >> >> I'd rather think about generic interface for setting/clearing
>> >> >> (multiple) bits through CI than resorting to such convenience
>> >> >> tricks. Once that is in place, one will be able to say "I need these
>> >> >> bits only", "I need to turn these bit(s) on", and "I need to turn
>> >> >> these bit(s) off" conveniently and universally in any part of Git CI
>> >> >> where it's needed.
>> >> >
>> >> > It's possible to achieve both.
>> >> >
>> >> > Imagine your ideal explicit interface. In that interface the default
>> >> > is no output, so you *have* to specify all the bits, for example:
>> >> >
>> >> >   git show --patch
>> >> 
>> >> No, that's not what I meant. There is no point in making "git show" to
>> >> have no output by default, please see below.
>> >> 
>> >> >
>> >> > Or:
>> >> >
>> >> >   git show --raw
>> >> >
>> >> > In this ideal interface it's clear what the user wants to do, because
>> >> > it's explicit.
>> >> >
>> >> >   git show --patch --raw --no-patch
>> >> >
>> >> > Agreed?
>> >> >
>> >> > My proposal achieves your ideal explicit interface, except when no
>> >> > format is specified (e.g. `git show`), a default format is chosen for
>> >> > the user, but that's *only* if the user hasn't specified any format.
>> >> 
>> >> My point is that the default format should be selected as if it has been
>> >> provided by existing options, rather than by some magic hidden in the
>> >> code.
>> >
>> > But why?
>> >
>> > I don't see any benefit, only drawbacks.
>> >
>> >> > If you explicitely specify the output format that you want, then the
>> >> > default is irrelevant to you, thus you have your ideal explicit
>> >> > interface.
>> >> 
>> >> That's not what I had in mind, sorry. It'd rather be something like:
>> >> 
>> >>   --raw: set "raw" bit and clear all the rest
>> >>   --+raw set "raw" bit  (== current --raw)
>> >>   ---raw clear "raw" bit (== --no-raw)
>> >> 
>> >> In this model
>> >> 
>> >>   git show
>> >> 
>> >> would be just an alias for
>> >> 
>> >>   git log -n1 --patch --cc
>> >> 
>> >> and no support for a separate command would be need in the first place.
>> >> 
>> >>   git show --raw
>> >> 
>> >> would then produce expected output that makes sense due to the common
>> >> option processing rules, not because somebody had implemented some
>> >> arbitrary "defaults" for the command.
>> >
>> > But now you are at the mercy of those "arbitrary defaults".
>> 
>> No, see below.
>> 
>> >
>> > Let's say those defaults change, and now the default output of `git show` is
>> > `--stat`.
>> >
>> > Now to generate the same output you have to do:
>> >
>> >   git show --raw
>> >
>> > in one version of git, and:
>> >
>> >   git show --no-stat --patch --raw
>> >
>> > in another.
>> 
>> No: --raw in my model clears all the flags but --raw, so
>> 
>>   git show --raw
>> 
>> will produce exactly the same result: raw output only.
>
> But that {--,--+,---} notion doesn't exist, and I think it's safe to say it
> will never exist. So, could we limit or solution-space to those solutions that
> could have the potential to be merged?

I didn't expect it to exist any time soon, just showed a different way
of options design.

>
> What you suggest could be easily achieved with:
>
>   git show --silent --raw
>
> But because no other format is explicitely specified, following my notion of
> defaults, that's the same as:

The problem that I tried to fight is this notion of defaults that is
somewhat special, so, if I allow for it, the rest of my suggestions
becomes pointless, and without the "defaults" with non-trivial behavior[*]

   git show --raw

won't work as expected provided --raw still just sets "raw" bit and
doesn't clear all the rest.

What I described was not meant as an immediate proposal to quickly fix
current CI. Please don't try to get that as such.

[*] Defaults with trivial behavior is just initializing of internal
variable holding flags with specific value, that is exactly the same as
putting corresponding option(s) at the beginning.

Thanks,
-- Sergey Organov
