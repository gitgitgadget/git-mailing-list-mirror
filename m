Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76EECC43603
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 10:12:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 452E5217BA
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 10:12:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPoV7hUM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbfLGKMk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 05:12:40 -0500
Received: from mail-ed1-f66.google.com ([209.85.208.66]:38701 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726025AbfLGKMk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 05:12:40 -0500
Received: by mail-ed1-f66.google.com with SMTP id i6so6977115edr.5
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 02:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hnLS4C3nPSYwE1/YAerTZ6hfMk8vnGY8LdXNmP8tIZk=;
        b=DPoV7hUMDOFsNkn4D8pXKobcbL+ckeLZxxcgQXh0rEflAwFBbi16rJ9XtDO1XT6GUd
         4zPHmileblI7VC3HM9+B+bSTFqeZtQMHARa4ljXFNIwnC9Gi/KD7IDbGeD24TRvf/Enj
         YbNYbCO7VrPLoURZllUHZu4mGBymnD7SFdFmoNNYPJBgeD5krZ8/HeL0JDvbSZOEOBgX
         4P9Zhykc4pt5F7oZthBVTowPPqijw1PvK1qN3Eimpv456NXEnAFe/XbPIut5OKxM8HmB
         R9DUAB5OECOlqkPtEgnOxn/JKC3ZVNcpkyItJQ6BUGAQH6QpwKDUda4VwtQkcRf8a8y7
         8dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hnLS4C3nPSYwE1/YAerTZ6hfMk8vnGY8LdXNmP8tIZk=;
        b=E5ZoEUA8A/r4D8ghuntSK3htwsBui6LE2nHK7p+e2+WRtjW8uwt9PzhW+iyHiZK3Sh
         zaBGjqCEIjG5zamlIP5haSwJgU/6pv5qzWYiJ/USYRI0m7VxVosGLMb/uVs+AyBLS3OV
         T5dq9ENvv5P1NU/3zhkBPncgicFTsec2luOwCr2wX+sVsyVJZl6181Z827s+I7l0DBxv
         ObXPPimXhaVWm4UNs6lj0F2QjuhiOIOlxf19ar6JyYEQ9wtM+JtzH9h6+Z/b/yri3H5B
         cMVyEe6Qkes/0SQnopIkBv+DG+VPf5ZdLEfTri/3kKKVdLyJubtU0tEHzL3JRQ3i+DKd
         9rXQ==
X-Gm-Message-State: APjAAAX5IgGP9lluSfEEo1gldtoo0zAn1JncNiq/uojs8H+Ak7AHZzrt
        0dyQ+MqZDltVAwonF2cuouPq4YH/HT6YNihw32A=
X-Google-Smtp-Source: APXvYqxhoOnf+YGMAsj7hJZ2kNJK09KQnZV4jYOaoAeLBakiksZiBuQGlbpSqXoyg2ME25P9HbPgVCkCgeAz6iGiPZY=
X-Received: by 2002:a50:f299:: with SMTP id f25mr21446283edm.280.1575713558569;
 Sat, 07 Dec 2019 02:12:38 -0800 (PST)
MIME-Version: 1.0
References: <20191115141541.11149-1-chriscool@tuxfamily.org>
 <20191115180319.113991-1-jonathantanmy@google.com> <xmqqeexwxyc0.fsf@gitster-ct.c.googlers.com>
 <xmqqa78kxy1i.fsf@gitster-ct.c.googlers.com> <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq8snpw2pk.fsf@gitster-ct.c.googlers.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 7 Dec 2019 11:12:27 +0100
Message-ID: <CAP8UFD20LMxuV7KWAvobybHYZruDiADX-yOFPLyMxsHS7HZN0g@mail.gmail.com>
Subject: Re: [PATCH v3 0/9] Rewrite packfile reuse code
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 6, 2019 at 10:42 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > Junio C Hamano <gitster@pobox.com> writes:
> >
> >> Jonathan Tan <jonathantanmy@google.com> writes:
> >>
> >>>> It could be a good idea if Peff could answer some of the comments made
> >>>> by Jonathan Tan about patch 9/9.
> >>>>
> >>>> I have put Peff as the author of all the commits.
> >>>
> >>> Thanks. I think the series looks mostly good except for the questions I
> >>> raised in patch 9/9, so I'll wait for Peff to respond too.
> >>
> >> Hmph, the round before this one has been in 'next' for quite a
> >> while, so should I eject it before waiting for Peff to respond
> >> before queuing this one?
> >
> > After rebasing these v3 patches on top of the base of the one in
> > 'next', the only difference seems to be the log message of 3/9 and
> > the contents of 9/9.  I guess I'll mark the topic as "on hold" for
> > now before doing anything, as I am officially taking a time-off most
> > of this week ;-)
>
> So..., that week has passed---anything new?

Unfortunately, no.

If you want I can send an incremental change on the content of 9/9 on
top of what's in next. Otherwise I can't see what I could do on this.

Peff, could you tell us if you might have time to take a look at this soon?
