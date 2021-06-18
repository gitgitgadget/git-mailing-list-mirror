Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47119C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:00:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B720613B4
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 16:00:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbhFRQDD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 12:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhFRQDC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 12:03:02 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F542C061574
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:00:53 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id w127so11048728oig.12
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 09:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=NJ74IGL8Kkv46eyRestGIgC9WiLOuuY45cn5K1wLWuI=;
        b=fbaVJ7/POGFjT7m7uZzkKOzFN0tqOb3ZYgBuFmKRYpxOke8VdB6zU2+rDx/U6LPN3D
         J8aC4Cr3UD6Jg1XadEVb+FZzeorUKc8vF7QGBkBgglY7cQQORGNAJ5Vlck9dVn6GPfje
         SW5wjjsM4NAn/m2ucFHMHNy2jsBaKZUQDrVJ3DHvhjyG8WSVLCeFzrQqwNkyPkHLKi3b
         mcjcl4DDarUONdnMGOkvGkk8SebZyNTIOTLCaXTHIZswua9dEtujKg6xNnLBWxDgJNxP
         x62/cDE08jmbDKkZJItJ4AtplPOp49XrdNDgdrOweBkMaS4h/N/LrOgLUSFjo0xQDgu4
         PlGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=NJ74IGL8Kkv46eyRestGIgC9WiLOuuY45cn5K1wLWuI=;
        b=WL1kzyRk+GrsxWH6S2i3Byemf5eFu3Sz+I6qGsIzRcyINCx0xrr1wnq+YDIPkSxktJ
         AjppWuHrZwnXPXXeyd1mAAfd+EU/BigxGJw7QszwIWtOcvZ9FVdI+GwO4kdn9iYQKp+5
         6hYWE5o2C9YHm57KZUFXXL1px2xIoGWcp/tHr3/ggPlmXD6/PphfKs2PywXZl35GWCXR
         FRmZz4TIOKkf0HH/TQXrsr5t/cSAmAfSXxYg2JtNQ2Z7/+OaH0ML4BKvQv0FEv5iL9Cg
         nH7iICT88k35ItswXGEdmYPqmTzFtF73WdVwmyIHgYBrtxi3sKvMLF8OHB3Fz0Xj/vTc
         0ulQ==
X-Gm-Message-State: AOAM532zP9NG0o39r2pzHeWCR4u1ZgpxrS66BPexby0CeY1kPY4ZGmL0
        3jie6opkuu7OawUodd7nUP+Yv194PV6bGg==
X-Google-Smtp-Source: ABdhPJy5AKF6/lgFUKk+hh2DsPvvDsBmmtLEIn3Gk0CQ+VV4wrZOKr2PTHc7L6chlTDEj63TyGweYw==
X-Received: by 2002:aca:d983:: with SMTP id q125mr8077919oig.87.1624032052803;
        Fri, 18 Jun 2021 09:00:52 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id w69sm1883933oia.22.2021.06.18.09.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 09:00:52 -0700 (PDT)
Date:   Fri, 18 Jun 2021 11:00:51 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <60ccc3332428c_5eaa2208df@natae.notmuch>
In-Reply-To: <CAPig+cTr2fEYN2y7FyKaspuaCpAq6wNtHgg_8RcrOmvsN5+XaA@mail.gmail.com>
References: <60cc1749b1c4d_5d12520825@natae.notmuch>
 <CAPig+cTr2fEYN2y7FyKaspuaCpAq6wNtHgg_8RcrOmvsN5+XaA@mail.gmail.com>
Subject: Re: Only 27% of reviewed-by tags are explicit, and much more
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine wrote:
> On Thu, Jun 17, 2021 at 11:47 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> > This prompted me to write a script [6] to programmatically find stati=
stics
> > about these trailers. Obviously it isn't perfect (as all software); i=
t
> > tries to avoid human fuzziness (like people pasting other patches wit=
h
> > scissors [-- >8 --], or just straight put pasting the patch [^From: ]=
), but
> > even so there are instances I manually had to skip [7].
> >
> > Here are the top 20 reviewers over the past 10 years with their
> > corresponding explicit over total Reviewed-by count:
> >    ...
> >   5. Eric Sunshine: 14% (17/116)
> =

> Does your script check cover letters? Based upon a quick glance at it,
> it doesn't seem to.

Not really, that's a good point.

> Although I've reviewed thousands of patches over the years, I almost
> never give my Reviewed-by:; it is an exceedingly rare occurrence.
> However, when I do give it, it's almost always in response to the
> cover letter (saying "this entire series is reviewed by <me>"), not in
> response to individual patches. I've seen other reviewers do so, as
> well. So, if your script doesn't take cover letters into account, then
> you might want to revise it to do so in order to get a more accurate
> picture.

I've updated the script to consider all responses to the cover letter
that start with 'Re: '.

> In fact, if my memory is correct, some reviewers give their
> Reviewed-by: to an entire series in response to one of the patches
> rather than to the cover letter, so perhaps you can come up with a
> heuristic to identify those cases too.

That's true. Depending whether or not that's the exception or the rule it=

might make sense to simply consider all Reviewed-by responses to apply
to the entire series and make the heuristic match the cases where it's
only for a single patch.


Anyway, with the updated script the explicit reviewed-bys are 40%, and
here are the stats:

  1. Jonathan Nieder: 80% (254/314)
  2. Jeff King: 7% (18/248)
  3. Stefan Beller: 28% (54/190)
  4. Matthieu Moy: 64% (84/131)
  5. Eric Sunshine: 38% (45/116)
  6. Derrick Stolee: 11% (12/102)
  7. Taylor Blau: 46% (39/83)
  8. Michael Haggerty: 76% (42/55)
  9. Elijah Newren: 25% (12/47)
  10. Johannes Schindelin: 11% (4/35)
  11. Jonathan Tan: 28% (9/32)
  12. Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy: 20% (6/30)
  13. Ronnie Sahlberg: 100% (16/16)
  14. SZEDER G=C3=A1bor: 0% (0/14)
  15. Luke Diamand: 7% (1/13)
  16. Felipe Contreras: 8% (1/12)
  17. Johannes Sixt: 40% (4/10)
  18. =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason: 22% (2/9)
  19. Stefano Lattarini: 37% (3/8)
  20. Torsten B=C3=B6gershausen: 0% (0/7)

Jonathan Nieder, Matthieu Moy, Michael Haggerty and Ronnie Sahlberg got
considerably more percentage, but others didn't.

The histogram [1] shows an increase in the 60%-100% range, in particular
the 80% range (thanks to Jonathan Nieder), but there's still plenty
below 50%.

You got considerably more, from 17 to 45, but still pretty far from a
100%.

I think the conclussion still stands: Reviewed-by isn't always expressly
given, in fact, the majority of case it isn't.

Cheers.

[1] https://i.imgur.com/gr6YjsZ.png

-- =

Felipe Contreras=
