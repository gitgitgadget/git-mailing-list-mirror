Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E6DC433DB
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 15:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F7F62333B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 15:19:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgLWPTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 10:19:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725267AbgLWPTz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 10:19:55 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D70D0C06179C
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 07:19:14 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id j21so3764457oou.11
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 07:19:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=QgzdQmekAl6K4LITTbDGnG78oyN8QbFLUFdT+zOZ9e4=;
        b=FAGc2j2BGqeS8BwWTiQ4dkFbZrP0gynpfZvNQvCVBM/zMlAyZq/aGrvqxXWDw0bXLm
         4qYka1Kt1Vtb2N3p9WYnUGfZCFAbdQyO0dKhb/38OuIO+eKz9zudpWdcofotPloFrN79
         ntcEnkX/KW6VVH05lRtZv5u0S//fRvhhqbaYGQT9WlzU4gAibAqEEgSfjqL7eYw/2vYp
         a1efEpYtYLRx/RtUZJ5Kom/cxgUOnfSTiDgXKNg4oEo/T/SoBuvxBxvVSil69REg91Z6
         IgP+7UcKvlmEnGijz/tCw2L+bHL3jFy0zVww2j0U+5N0qdNTH2yX0o/pLD43xjqcaHSb
         syRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=QgzdQmekAl6K4LITTbDGnG78oyN8QbFLUFdT+zOZ9e4=;
        b=koCM38LN9K9GJc6kuWFg4Twd0wofLOjkZednV0Sn57msgifWat8VKHyiGq3fp/FTwn
         zryReAXaD/gVKONQ6NUjuH3vxsCd9DNSKYl9o38Gy+LSdrW5Ttu9Kv2+4d7GiIwXlurR
         6L2h8CqMOESV/eFv9Kh+/pCU3Is8n827rhVtx3DnQUVsP4Hmzoa+JNg3OmltWWNVFnKi
         HzLBjA5y6Sl02OW4Tce5IisO5Hi3gZM6AkprwAXr9ZVVWBcT+O2NW3HAopzo4Ru694Jg
         wMNKjrBnaxQVpmKu/tDsI5ol/CvIQ5WNzGfPZeuoro7y2TL8HQNzgaHKfm6yGmHXkf2Q
         3uww==
X-Gm-Message-State: AOAM530RZc2wrHcBYa2xwF7ZI9eQoWL0ogRAZqgY7EPciFuK7r7PvSuu
        pXdBiqpphUSZ7P+ORZ0Mltocu2FqXjnvcg==
X-Google-Smtp-Source: ABdhPJx4YsNR1WpuwNSIx9DPCWecowXXbkOs9m01VNf+mL8mwDgm5JdP0B73FXTLgimO9ClKpu4rNw==
X-Received: by 2002:a4a:db78:: with SMTP id o24mr14025556ood.69.1608736753318;
        Wed, 23 Dec 2020 07:19:13 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id 31sm5429229otd.24.2020.12.23.07.19.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 07:19:12 -0800 (PST)
Date:   Wed, 23 Dec 2020 09:19:11 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Cc:     git@sfconservancy.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Jeff King <peff@peff.net>,
        'Junio C Hamano ' <gitster@pobox.com>
Message-ID: <5fe35fef595de_22f222088f@natae.notmuch>
In-Reply-To: <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com>
References: <20201223061718.102779-1-felipe.contreras@gmail.com>
 <3d21cc06-415d-860b-7bd2-31047d68bc05@gmail.com>
Subject: Re: [PATCH] CODE_OF_CONDUCT: expect tolerance, not respect
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee wrote:
> On 12/23/2020 1:17 AM, Felipe Contreras wrote:
> > As many argued; respect cannot be manufactured at will. If you don't
> > respect an idea (for example that the Earth is flat), then it doesn't
> > matter how hard you try; you still will not respect it.
> 
> ...
> 
> >  * Using welcoming and inclusive language
> > -* Being respectful of differing viewpoints and experiences
> > +* Being tolerant of differing viewpoints and experiences
> >  * Gracefully accepting constructive criticism
> >  * Focusing on what is best for the community
> >  * Showing empathy towards other community members
> 
> As mentioned in 5cdf230 (add a Code of Conduct document, 2019-09-24):
> 
>     This patch adapts the Contributor Covenant Code of Conduct. As opposed
>     to writing our own from scratch, this uses common and well-accepted
>     language, and strikes a good balance between illustrating expectations
>     and avoiding a laundry list of behaviors. It's also the same document
>     used by the Git for Windows project.
> 
> It is highly recommended to stick to the widely-used and carefully
> crafted phrasing.

No widely-used and carefully crafted phrasing is perfect.

> Specifically, "Being respectful" is different from "Have respect",

Indeed.

 1. Having respect is something that cannot be chosen at will. Either
    you have it, or you don't.

 2. Being respectful is something you can choose, but it is *showing*
    respect, even though you might not actually have it.

If you don't have the first, then the second is an act.

> which negates your argument for changing this word.

It's not my argument. It's the argument of dozens of intellectuals (and
others) who criticized the original University of Cambridge freedom of
speech policy.

> We can only enforce what is evidenced by actual communication, not the
> internal lives of community members.

Indeed. But it's not wise to ask community members to *pretend* to have
something they don't.

> I could just as easily argue that it is possible to be tolerant without
> being respectful.

It is, and that's precisely the point; the change matters.

If you say "I think this proposal doesn't make any sense", that's being
disrespectful towards that viewpoint, but it is honest, and tolerant.

If you police language and demand that members *pretend* to have respect
towards certain viewpoints, even though they don't have it, that just
stifles the expression of opinions. Not to mention the cognitive burden
of being constantly lying.

Either way, if you leave it as "being respectful", then the document is
a sham, because people are disrespectul towards the viewpoints of others
all the time, in this mailing list, and many others.

That point is not currently being enforced as it is, and I think (and
hope) it never will.

Cheers.

-- 
Felipe Contreras
