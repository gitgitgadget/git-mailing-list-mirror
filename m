Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA89C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 08:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiDYIkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 04:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbiDYIkT (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 04:40:19 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E859B69CDF
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 01:37:15 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id k29so12801737pgm.12
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 01:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHUFuo4oQskLbjTj4L19QrqUW2sggei8qiJ+amYW/uc=;
        b=HZ4GRY2aQT0iygZqglF7sN9PUk3/DE8CWbI43sn4Gmmus9qSV15lVvzqSh11B6iqX8
         g2WVNu3ljrw2K/VslrKRiWZSWG0X0bhLROeb4vjxC5vt5rRTTn2SMpINzMH0FfkhIvGp
         jDPfhZUFYFG2A5KjkWccwuxlDIIerXyXnj9uW73joLNQjhxUuGfoEgM1zLu/IU2zAwtC
         mhFjHgWwqK2dD+kj8LntlCL8jRjkPWIOcpYwnAzQrbEdHSdwXfSqt0BYQFk3/GZDalf1
         lUfCRI3Ti1iSKtKfGrU90dQfLqJWtytDssIqU040EQYXnNug3ic6deSlYIasEyTr1pis
         EG9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHUFuo4oQskLbjTj4L19QrqUW2sggei8qiJ+amYW/uc=;
        b=rH0YssUgg1plxztnqagdnf15NCxe40XW9ZWxVXs2KnLdBdmjw+YniG4wyJdl7vvrBR
         zlLQDZCOcaGUi7Dc/bGy7c+GGL/qT4JdRDEj+MKs1oFTZfB+5bnGOaw2vhY9ZOeXLUY1
         XBXq4EBiadGqAeE7JN8qlF+9gutWMZOInnE6tn6ej3FEQK0XHIlXsMdSDO0Fcissn1Mc
         DIq06f7FWvVPJYkBsDuCEnMClFBa0IRkzc9JqhzmfESSUf9hiNErRb/u+dyKsntnJxiA
         lj0Cd3UzK6xK9NDFcwx3g8YZYMKd8w8BiAvkEfFUgbXxzGrAEq5Xia+9Wp+XkdpcwxU9
         b7qQ==
X-Gm-Message-State: AOAM530CZzdvATIq9fJn/21ZYrbeORLHGQwQx+B9+vriFEYO8NopbOm+
        XqfVRyJB1cYztix6sQ7Jj51GYclsICUkZ47WQUr/tNLzOf0=
X-Google-Smtp-Source: ABdhPJzJVjOH+DhQ7EijtMQdhuHQkfqvMC9HXhfier4Li9AZ5tV+lez8n7ntOdS0jsw0hRWU7nZGpBRgyLewqIUulrk=
X-Received: by 2002:a63:f749:0:b0:3aa:361c:8827 with SMTP id
 f9-20020a63f749000000b003aa361c8827mr14383678pgk.361.1650875835212; Mon, 25
 Apr 2022 01:37:15 -0700 (PDT)
MIME-Version: 1.0
References: <CALOmtcX4+ON7+J7K9X4rSYfWYnkciJdFE=v=Oeb7rUqwRt8_JA@mail.gmail.com>
 <CA+CkUQ8hf5m0GZEwcyqLgxMw1vavYey_R4P7oq8=OXc7iAj6MA@mail.gmail.com>
 <CALOmtcW=2skmUPXpnano=21i38b7sq2MEWQjH5yF2jLacZ8sQw@mail.gmail.com>
 <CA+CkUQ9ZnBXU8E=XKTk95hwM4qtZ1M_nX3LTCr5q5njPG3Es5Q@mail.gmail.com>
 <CALOmtcX7amyw3cAuthMPuagUVzJghybHFNy8ciB50yC5SCUwow@mail.gmail.com>
 <CA+CkUQ-YgmRa7ysP30GbkX07Cu_=EM5X66w3Vk=TpshP9xoi_w@mail.gmail.com>
 <CAP8UFD2uUFveiGDAbxObDOh_krmexuLe860Gu397e9KddH0UCg@mail.gmail.com>
 <CALOmtcVN8K59Zkv7XKM7w2zFCbdWKfKr=97-E3306nQHm4Zw=A@mail.gmail.com>
 <CAP8UFD1kinAwq7AL68QXqFR_dxkNFaTp2vP_DUU0KKqkbsXCDQ@mail.gmail.com>
 <CALOmtcWaQgrPTkRA6F8bL3Hp64cOxYrB4xHUa1WC+P34ZdFEbw@mail.gmail.com>
 <CAP8UFD1HGbbmJWB_TksGVLa-7nNBz5pdFi59Y7LP3EODF9Lztg@mail.gmail.com>
 <CALOmtcWFwfV11Vxf1xd_fC=HYGPNO1PtKT=E=-A104cGnAbv4g@mail.gmail.com>
 <CAP8UFD29NgffUBz0CMKyt901Z7Bj5osoBT-4Mfxfp0h_4Qo+Qw@mail.gmail.com>
 <CAP8UFD1f6KCO+=+ZoUFr06XUgEZYOZi8G0V+QKCK=bNbAE9VrQ@mail.gmail.com> <CALOmtcU-a0YUe2M5LwoRVU9PR4NOb8Ux-zEx144upo0oFz8PMA@mail.gmail.com>
In-Reply-To: <CALOmtcU-a0YUe2M5LwoRVU9PR4NOb8Ux-zEx144upo0oFz8PMA@mail.gmail.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 25 Apr 2022 10:37:03 +0200
Message-ID: <CAP8UFD2P6seb60X9Y-an_1aVYjqLhD=g4q=xyC__WofjhA36pw@mail.gmail.com>
Subject: Re: Unify ref-filter formats with other pretty formats: GSoC'22
To:     Tapasweni Pathak <tapaswenipathak@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
        Hariom verma <hariom18599@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Tapasweni,

On Fri, Apr 22, 2022 at 12:40 PM Tapasweni Pathak
<tapaswenipathak@gmail.com> wrote:
>
> Hi Taylor, Hi Junio,
>
> I have added the mailing list (++git@vger.kernel.org) in this email,
> hope now it lands better in your mailbox.
>
> I would be happy to take these tasks, not that I require any
> mentorship but to work with folks who are involved.

I am sure that there will be folks who are involved who will work with
you if you select one of the projects we suggested. We don't suggest
projects we are not interested in. The old timers who suggest them and
are willing to mentor usually do get involved in them.

> I have had times
> where my work has not been seen for quarters and then closed after
> reviews cycles, never let it re-happen.

We cannot guarantee that your work will be merged, as some better
solution might be found, or someone else will decide to do it in
another way and it might turn out to be better. But otherwise you can
be pretty sure that your work will get reviewed. It might take some
time and we might ask for a lot of changes in the reviews though.

> It is a nice and respectful way to say, already deeply involved folks
> as mentors, for someone who is entering the org or community. Not that
> I require any tech or engineering help or otherwise, I mostly work
> independently, just don't want to go my work stale and be clear on
> what exactly is required (before or after a discussion, rather w/ or
> w/o any discussions)

I think we are open to answering specific questions about what is
required for the work we suggest. We might sometimes be wrong though
and realize it later, so the requirements (or sometimes the whole
solution we suggest) could change along the way. That's how software
development works. And even in this case the fact that we realize that
our requirements were wrong is an achievement.
