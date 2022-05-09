Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7BDC433F5
	for <git@archiver.kernel.org>; Mon,  9 May 2022 18:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240386AbiEISwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 May 2022 14:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240383AbiEISwj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 May 2022 14:52:39 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70192044DC
        for <git@vger.kernel.org>; Mon,  9 May 2022 11:48:43 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id c62so14816422vsc.10
        for <git@vger.kernel.org>; Mon, 09 May 2022 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mva1kckkfycb0lcHIurcFYyYCO6k3wv/oMFB5IXnve0=;
        b=fK+UaV5sMYDyVu8pbCqA5EkGijQG8IXtH9qhH4U1bU6JiGFByEnhopdXMwD6dYuVmc
         EOxs7qr+FlcrG8xqpv0rCKwLenKIifNoSTt/C9NsW9r7j0YYpi/CHe0f8gS/9+fJQr3/
         y1IwUJw2fwkJ5ob7iDD2L/LGB7xWuDGLjqkFpy6oa4FCEdcregP3MlJ3GIPUqhA7IALu
         aMWysRgV2d3tvldMJ1vemzfcuy69/2cEGpA/aiCe0Xwm2wi/z/KFj+jqKfmJvV7ctRJz
         dVzfWXtl6vf9MXmFccd80pwvm+kxXyKI0wi/aSVvZXibo3K6VwAylmcKB8EZdeBqHR7p
         CGnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mva1kckkfycb0lcHIurcFYyYCO6k3wv/oMFB5IXnve0=;
        b=m3P7if0qDw+DZFDeryPsIomAzBDCdbymkcGlf02T63DVAFNIOCrwjAqU6HFlXZ+9cI
         UzfXDg6Jif4wSbcPbX7fXc6v1l/NvJ+3jXHDEHZjBt9uFbceWQcStRURDVlYpb9Khc2K
         omroRtr7gcycoUoJvCXDw1E8LlFBDLE1qlipFLc8COrM7ZpSv4NASFTYFMchZnVzLa6E
         Il24CXXc/LdFybS/t42S1pP1CQf2lX8Q+APJ4jK3gyl+loNY6HANhv0aKFVmkfFr25KM
         oT8BLNlPc4N3cnPM5DMRbK2FYXFPMAn4xIAjN4OoEMB/67Wmia23ICT1RjJpxnpLcJFJ
         fNxQ==
X-Gm-Message-State: AOAM5339auXYq+xEB78NR/QNtPO9CSyiQxU3h0hHRIBh303L8pvXXzcS
        MX3cCWOlEP6UohToL5JXnMQpa4cz0y3eKfWEHjjPTmlegxU=
X-Google-Smtp-Source: ABdhPJwt6UJXLnT+5aJYitt8o9FQyVPogjvBNVHm4/a/2tEY4gV4C8L+1vB1La+qkZIp9SqDLUxHjz2UFxSX7uARV9Y=
X-Received: by 2002:a67:d303:0:b0:32d:3d07:17c4 with SMTP id
 a3-20020a67d303000000b0032d3d0717c4mr9120601vsj.52.1652122122745; Mon, 09 May
 2022 11:48:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220503065442.95699-1-carenas@gmail.com> <20220507163508.78459-1-carenas@gmail.com>
 <20220507163508.78459-3-carenas@gmail.com> <xmqqv8uhgsaz.fsf@gitster.g>
 <20220507185624.k5n6xihvzcuuj3vt@carlos-mbp.lan> <xmqq1qx2ejdv.fsf@gitster.g>
In-Reply-To: <xmqq1qx2ejdv.fsf@gitster.g>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 9 May 2022 11:48:31 -0700
Message-ID: <CAPUEspidmqiUYd3xB4QaR72YU=H8pA-3yNXxOF_MWyA_0wrKcA@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/3] git-compat-util: avoid failing dir ownership
 checks if running privileged
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, bagasdotme@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de,
        Guy Maurel <guy.j@maurel.de>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Randall Becker <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 9, 2022 at 9:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> It is not just "not likely", but such an attack, with a potential
> victim not futzing with SUDO_UID environment themselves, would not
> work at all.  The value of SUDO_UID and the original uid of the
> potential victim by definition should fit in the uid_t type.  So if
> you, the aspiring cracker, have UID 1000, nobody else on the system
> has UID that is congruent modulo uid_t and wrap-around attack does
> not exist.  As long as the type we use to read SUDO_UID string into
> a variable is not narrower than uid_t, there.

correct; would adding a less elegant "static_assert" (obviously not
available in C99) in the code an alternative?, or you are suggesting
that documenting that constrain should be done in a comment and hope
it doesn't get ignored in the future, or maybe gets instead made less
likely to fail by some additional work, like the one I suggested to do
later by moving this code around and using intmax_t instead?

not that there are 2 different scenarios which we might seem to be
flip flopping about :

1) victim gets attacked by tricking them into using the wrong SUDO_UID

unlikely to be useful as you pointed out, and totally useless if we
still restrict this code to run only as root

2) attacker using this code to elevate privileges themselves

only useful if this code is not run as root.

My concern again, is not with this code AS-IS but how it might be used
in the future.

> Of course you can tell any user who runs "sudo" to set SUDO_UID to
> 1000 + 64k and cause wrap-around, but then you can tell them to set
> SUDO_UID to 1000 without relying on wrap-around and have the same
> effect.  So, let's stop worrying about this bogus scenario.

bogus only if we are still only running this code as root, of course.

> As to the "we can break compilation with -Wsign-compare on a system
> with signed uid_t", I agree that is true if we have

Apologies for not documenting it until now, but I had
-Wtautological-constant-out-of-range-compare in mind instead, but your
are correct either one would work and the point was that (without
having to add even an "static assert") we were able to find them and
warn them that they need to patch.

>         env_id <= (uid_t) -1

If that was not enough, that simple code ALSO disabled the code in
that case to make sure they MUST patch locally if they need to make it
work, or come back to us to figure out a portable way to accommodate
them in the future, with all the information about their system we
currently lack.

> there.  But I am not sure if that is the most effective way to smoke
> out platforms where this code has trouble working correctly.  Also,
> I would think that a system with signed uid_t is a possibility, but
> a user with a negative UID?

It doesn't need to be a real user (specially if someone independently
decides to remove the restriction that keeps this code available only
to root).

The fact that it was negative but was treated as a positive number on
our code just makes the wraparound we decided to ignore before more
likely to work without triggering alarms somewhere else and because we
decided to ignore an unlikely to be useful positive wraparound, we
also would fall from the negative wraparound here that would had
protected this code from both if that humble line of code wouldn't had
been removed.

In your hypothetical system where uid_t is 16-bit (hence 15-bit for
valid non-negative ids if uid_t is signed, since no sane system would
have negative ones), either 65536 or -65536 would become 0, as well as
at least the other 2^16 possibilities that a larger long would
provide.

If the size difference is even smaller (ex: uid_t is signed int), so
the type we are using to parse those values is only 1 bit wider it
will still be a concern IMHO.

I know people that wrote code to check if "/" was writable as means to
make sure they were "root", because that is what any sane system would
do, and then came Windows and even in 2022 anyone can write to "/"
there and create subdirectories.

Carlo
