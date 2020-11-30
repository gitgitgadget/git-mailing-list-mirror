Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52215C64E7B
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 13:42:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0580206F9
	for <git@archiver.kernel.org>; Mon, 30 Nov 2020 13:42:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BxIUgNiP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbgK3NmK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Nov 2020 08:42:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726220AbgK3NmJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Nov 2020 08:42:09 -0500
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D04C0613CF
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 05:41:29 -0800 (PST)
Received: by mail-ed1-x542.google.com with SMTP id b2so4007058edy.13
        for <git@vger.kernel.org>; Mon, 30 Nov 2020 05:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:subject:to:cc:message-id:in-reply-to:references
         :mime-version;
        bh=qPionrDFmi1qMJp5XKpjM0IE7ifV4EWya9HA8tqzXrI=;
        b=BxIUgNiPfsPWjpaYLgHGZTLEwRBBzwSkLwaCoN7bpQ+VRylSQFvpCxDw9I2Ey8wIrc
         Lg0VRoMlMySPLQJO++JluRE4MRqK1b5Jrn/ftaeCNVaOlYl+d1z7wBEcI5PDvvQrONmN
         hgYMfsKNj44GnwdXPcW8ynkfQvCBlSF9Ic/R0O1R9oNhWk7QHEUKy6bfQfzLmRuppQx3
         XX79ozxetkfe7hfg+/r+QQJroB2sd61sG4N13jNM7hQeHcG4LtNjLu/pFG3kcUgX8i25
         kxkCr7uyT444dOIavqUbigBkrL6PAdEpTXsOxL2qzBQX1HaVdTuYd48u3VfBrkgXSelh
         Askg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:subject:to:cc:message-id:in-reply-to
         :references:mime-version;
        bh=qPionrDFmi1qMJp5XKpjM0IE7ifV4EWya9HA8tqzXrI=;
        b=f0JU/64ZxRu1ro7sLSqSac/trC5pxM7qU9iN1F+eLEVQ6n7Rik9YrQucteJ9CttVA4
         1XyctShrxSQdZ83aI+9cdD+h6VVkpFMEhLYuqxCzaKunUiPubCY5z8u1K4TCROn7ZwwL
         MABx5gJBwN9WW32U9E+zRNX+AOc5inqOHN8J73qRkUKRnaH2LRZphWlpw+ol3srymYas
         eB9J8GOyvSPnBJk0iOn/MNYgo3ky+GE9ZuFE0xjNuobbKgdtjvQib+8ZufwP9vOeHvDQ
         hp9cACJLjbbuRTRsONpNLY7viz3cUsljZLEDlae/pIuOvMdf21XNbLOcAFJVVge0kr/N
         JqDA==
X-Gm-Message-State: AOAM533uJaIahnfLh1ew5PmYXbH+30d0k+I5NnChFnJq6wEc34K+mGHh
        s+X4f9rrjnAitBClLcLlWQ/+MTxAnpaT/Q==
X-Google-Smtp-Source: ABdhPJzlo2YwCZcQdtyYv9VBJqgvJVgz+mo1tjj7lusrnpd33pbizIm70o5Y57HFoNmFHrVQ0q0irg==
X-Received: by 2002:a05:6402:2d4:: with SMTP id b20mr1515014edx.237.1606743688026;
        Mon, 30 Nov 2020 05:41:28 -0800 (PST)
Received: from [192.168.1.66] ([46.98.122.199])
        by smtp.gmail.com with ESMTPSA id rk12sm8383107ejb.75.2020.11.30.05.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 05:41:27 -0800 (PST)
Date:   Mon, 30 Nov 2020 15:41:20 +0200
From:   serg.partizan@gmail.com
Subject: Re: [PATCH] git-gui: use gray selection background for inactive
 =?UTF-8?Q?text=0D=0A?= widgets
To:     Stefan Haller <stefan@haller-berlin.de>
Cc:     me@yadavpratyush.com, git@vger.kernel.org
Message-Id: <WC3MKQ.KLJ4EJGGRQYY2@gmail.com>
In-Reply-To: <1a42781d-0e4c-6478-f26d-5eccbd9c6205@haller-berlin.de>
References: <DZJ7KQ.UXACXR9SWDQI3@gmail.com>
        <20201123114805.48800-1-stefan@haller-berlin.de>
        <1a42781d-0e4c-6478-f26d-5eccbd9c6205@haller-berlin.de>
X-Mailer: geary/3.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Sun, Nov 29, 2020 at 18:40, Stefan Haller <stefan@haller-berlin.de> 
wrote:
> After spending quite a while single-stepping through lots of Tk code, 
> I
> found the reason. On Mac, disabled text widgets simply don't draw the
> selection background. [1]
> 
> I can see three options for solving this:
> 
> 1) Don't use "state focus" and "state !focus" on the text widgets, but
>    instead set the selection color manually using "text conf sel
>    -background". Disadvantage: have to calculate the disabled color
>    using a heuristic like I did for the file lists in my v2 patch.
> 
> 2) Don't use "configure -state disabled" to make the diff text widget
>    read-only; instead, use one of the other methods from [2].
>    Disadvantage: quite a big change, and seems complex to me.
> 
> 3) Enable the the diff widget when it loses focus, and disable it 
> again
>    when it gets focus. I tried this in a quick prototype, and it works
>    very well. It just *feels* wrong to enable a read-only text widget
>    while it is unfocused; but I couldn't find any situation where it
>    would behave wrong, because as soon as you try to interact with it,
>    the first thing that happens is that it gets disabled again.
> 
> I tend towards option 3, because it's reasonably simple and works. 
> I'll
> work on a patch tomorrow unless anybody has objections.
> 

I don't like any of this options, as it makes code complicated. I 
personally would prefer to not implement this feature at all, but 
that's just me.

Maybe Pratyush can say something reasonable about this, as maintainer.

I propose to wait a week or two for other opinions, before starting to 
write a patch.


