Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 855CDC433FE
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2215F206F9
	for <git@archiver.kernel.org>; Thu,  3 Dec 2020 16:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgLCQjW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 11:39:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731337AbgLCQjV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 11:39:21 -0500
Received: from mail-ed1-x544.google.com (mail-ed1-x544.google.com [IPv6:2a00:1450:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCA2C061A4E
        for <git@vger.kernel.org>; Thu,  3 Dec 2020 08:38:35 -0800 (PST)
Received: by mail-ed1-x544.google.com with SMTP id b73so2731160edf.13
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 08:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=k1tBV2zWNr4wt37hZ8mr2N373eTVulTbvVlFZxTmuvc=;
        b=dW9BZWz1cgLJbU8zK6nM3em+ZPQzgv/Uh+rY/6qChdHkuO2RYZkjf71WPKzcibuVpF
         QX8imugheZ+JWLaDxXD9oy7UKtbQdo1DkuAv5pBuTI8UxY6G4PH25dckToVlEoNPj9n/
         jltdz3X1o7T6UHNfzNXVfBOTies2juVgPUbG5VcHZR6iJNavCX6ds7dAEyxpbnkTZ8sT
         kAmfJ0T/zVnpsSwXbRvTgZi1dJmFJYMxL2DWDnowplUlPc10fkwbB/ezSQbksfuPXETm
         hsWVZ8kLkhxE5/NI7mO5fHYtaduhmNxv6R4C7WCSZ/dix3BzDGH02EfOtRt+4gXPyr/E
         mnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=k1tBV2zWNr4wt37hZ8mr2N373eTVulTbvVlFZxTmuvc=;
        b=Nr8YCbAL4RHtD8JLD6wKWwrlGu0UGOBqDnxsdllFK0gn3weMAR8i4dqwR+aJ/yfGIO
         bgKfaTDHC8InX4d+zRQFvP4oNN95AGRjkWLWZmKFK4BlKUdrQrlGtxTlH4Y/qf7XFCrx
         195sh0Vf6D7KSHhyQtJKEDq5SHufQfW4tNmAJUnag+rXzAX+5y4LpHDoFu0z4ua6hToV
         OLKPgLYtc9Q/Oc9bWeTCKHab0BlSFOndQnCdM7tIsaA2vm9AiS9ovlXyeif4ncJOOgpm
         2SBtyT5I7idGiVi9s0VIEzYMY5CkjC/opmg0QhHjJ9WuBG8JxZPhnsDWCKR9SStm1eE5
         XZsw==
X-Gm-Message-State: AOAM530ZJ44mu0kwqfah3nQpzfL5H1g8UNEtrMkzYjnx1RNpJjjMguPK
        NvYvZmCM/vCv6Jm3CB/pbro=
X-Google-Smtp-Source: ABdhPJxg05xJ87M3zp0UhppcJhvympd97IVVunfdet8MwA8efmX+eoFQMAQoyhQ6Xt2bfHG4vXV1Eg==
X-Received: by 2002:a05:6402:1c8a:: with SMTP id cy10mr3595837edb.151.1607013514231;
        Thu, 03 Dec 2020 08:38:34 -0800 (PST)
Received: from evledraar (i116144.upc-i.chello.nl. [62.195.116.144])
        by smtp.gmail.com with ESMTPSA id d1sm1511243edd.59.2020.12.03.08.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 08:38:33 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 00/10] make "mktag" use fsck_tag()
References: <20201126012854.399-1-avarab@gmail.com>
 <20201126222257.5629-1-avarab@gmail.com>
 <87zh2xvny6.fsf@evledraar.gmail.com>
 <xmqqlfehpa7p.fsf@gitster.c.googlers.com>
 <xmqqwnxzluir.fsf@gitster.c.googlers.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.13
In-reply-to: <xmqqwnxzluir.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 17:38:32 +0100
Message-ID: <87h7p2vo8n.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Dec 02 2020, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:
>>
>>> On Thu, Nov 26 2020, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>>>
>>>> Now a non-RFC. I went for the approach I suggested in
>>>> <87r1ognv4b.fsf@evledraar.gmail.com> of just having fsck_tag() able to
>>>> optionally tell us about its parsed tag/type, thus avoiding any need
>>>> for a custom parser in mktag.c. Hopefully I've addressed the rest of
>>>> the feedback, range-diff below.
>>>
>>> Ping @ Jeff & brian: you said you wanted this in one shape or another,
>>> so mind seeing if the v2 looks good to you?:)
>>>
>>> Junio didn't pick it up for the "What's Cooking" sent out recently,
>>> hopefully some reviewer ACK/NACK will help move it forward. Thanks!
>>
>> True.  I don't want to queue too many topics on 'seen', only to end
>> up with a pile of patches that haven't been reviewed adequately and
>> cannot move forward.
>
> So, now I've seen all of them.
>
> There were some minor things in the earlier part I commented on, and
> if I am not mistaken, a new check, "body must not begin with a blank
> line", should not be added at all, which would affect 08/10.
>
> I am not sure how much longer we want to retain the .extra level of
> checks that are more strict than those of fsck.  If we decide that
> it is not worth it to forbid new object headers, we may be able to
> lose 08/10 altogether.
>
> Other than the above, the series mostly looked well done.

Hi. Just a quick note to say thanks for all the feedback, and that I
don't have a v3 ready now, but will submit one soon-ish.

FWIW the header-body newline thing wasn't something I was trying to
sneak in, I went wrong in my testing somewhere and thought it was a bug
under mktag. Will test for that, remove that check or whatever as
appropriate. Thanks for the review.
