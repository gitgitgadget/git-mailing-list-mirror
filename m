Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB278C433EF
	for <git@archiver.kernel.org>; Mon, 24 Jan 2022 18:17:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241700AbiAXSRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jan 2022 13:17:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiAXSRB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jan 2022 13:17:01 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 388F5C06173B
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:17:01 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id b14so6361077ljb.0
        for <git@vger.kernel.org>; Mon, 24 Jan 2022 10:17:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herrmann.io; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0y27KEHmcmwHxJgv+j4HI+39O1eHgEmlK09p7yErzYA=;
        b=PGFjobkQKcmSi2PuD+etZtzeo3HeVpOgqZzZrcli+2PCAr9hfZan1OiHR2iXSfJxVU
         5M2nUkZXz1IyM8ZXpb7C+4LErLhsONpWJAhF+j4kujXvjxyFOVW5n4peiZVlCXsyv2LU
         ECvoiu5y60ban+QUpiKcVPZf+kSuIOZsFcDhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0y27KEHmcmwHxJgv+j4HI+39O1eHgEmlK09p7yErzYA=;
        b=JeHaQsA3mtQmA7W7H1XIn2jDL7hwvc1XJZHcJtZc59QxKJi/hhNqQ26Zh6+Vp4+qiX
         1Z1+ZHbTKgNTwX6HuqzoywUhUCKL/yEKFrVEM2nRX1/ATFynvFDS2GOxIyElTlqxzY24
         HleQ5pTcVIMrAfiReDuBEEmDDqkjIdCSLoozz2abzfsCoPlyRgmk39Vr2CBIT7VVnosL
         NXThtC7lAaUmMcqFe8BwXZsDrdZo0XC1mUx7rNnskqeTbxJ41hMwFCUvpQju+uJ/QsXk
         9CBffOHO7+mOFdRxMj+4pGetLqPz0KbQ9QjSOdHw9p6sXXjneOIcXSb181SO/T6Sklq5
         fr4w==
X-Gm-Message-State: AOAM533x7OS6SPeYBo0WrdpaDnEppceT60+f0Igp7DFuVr7muGj58EBv
        2AXoWD8bmFFjJ3SreseDAq2mSd9i/2m8dppudylMog==
X-Google-Smtp-Source: ABdhPJwrgXwdy3BvOG5L9euBZarBsTNy6DyL+o9nVtvMNzLmu+9UbHFQnTF3/mExhHFeyGM/HVM9yHQouROcmEuRIfo=
X-Received: by 2002:a2e:b5cf:: with SMTP id g15mr11985863ljn.194.1643048219572;
 Mon, 24 Jan 2022 10:16:59 -0800 (PST)
MIME-Version: 1.0
References: <CABrKpmDseZkPCpRb8KmBJaxDp24sySJay5ffZrxqgSMGKyj5qQ@mail.gmail.com>
 <YeiOoAcM7TMK2pgz@camp.crustytoothpaste.net> <xmqqilufl5cv.fsf@gitster.g>
 <CABrKpmCt3zKONLp5ZjV1PxLyfM-koc=tKopKUUpx4nF2n_eo_w@mail.gmail.com>
 <YengSfSDzVzvrJ6f@camp.crustytoothpaste.net> <CABrKpmASHgBwPYgKnO2ZZRVVxMti=NFaxw6cBV=pst0xpVZYGA@mail.gmail.com>
 <CABrKpmBFrrWgBh7QAOX35zQr_e+LC1E6Jn5FKb_XP-7bew9Hkg@mail.gmail.com> <xmqqk0ep57ou.fsf@gitster.g>
In-Reply-To: <xmqqk0ep57ou.fsf@gitster.g>
From:   Michael Herrmann <michael@herrmann.io>
Date:   Mon, 24 Jan 2022 15:16:43 -0300
Message-ID: <CABrKpmB7UEGzLCiNHQtY5-Dt16jLkpcpBEx3o8y9OBGZ418keA@mail.gmail.com>
Subject: Re: A puzzle: reset --hard and hard links
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It is merely because you helped Git to realize

I don't want to "help Git realize". I'm sorry but in my opinion `git
status` should not have any effects on other commands. I don't
understand how you can argue that calling `git status` is a valid fix
to "help Git".

> With another step 1.5 "append a line to the file in question", git
> should severe the link,

I don't want to sever the hard link. I want to avoid that it gets severed.

On Mon, 24 Jan 2022 at 15:07, Junio C Hamano <gitster@pobox.com> wrote:
>
> Michael Herrmann <michael@herrmann.io> writes:
>
> > I now believe this is a bug in Git because calling `git status` fixes
> > the problem.
> >
> > 1) Create a hard link to a file in a Git repo.
> > 2) Call `git status`.
> > 3) Call `git reset --hard`.
>
> It is merely because you helped Git to realize that there is no need
> to change the contents of hte file with "reset --hard".
>
> With another step 1.5 "append a line to the file in question", git
> should severe the link, I would think, as at that point, to revert
> the contents of the file in question to its pristine state, it needs
> to modify it.
>
>
>
>
>
>
