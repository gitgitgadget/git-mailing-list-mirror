Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877AFC4332F
	for <git@archiver.kernel.org>; Wed, 21 Dec 2022 09:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234585AbiLUJmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Dec 2022 04:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231652AbiLUJms (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Dec 2022 04:42:48 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99C54634D
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 01:42:46 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v13-20020a17090a6b0d00b00219c3be9830so1560250pjj.4
        for <git@vger.kernel.org>; Wed, 21 Dec 2022 01:42:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xg4Ypf+FhH6HZPEJeuO4jiWv2woKNqERLCwKG/QwV0Q=;
        b=OwgkHDnP0P9RuF8dMq4ZHf/N1fBiwah7HwQeB1QvIIapiy1KRSltPOW6f3FB86Y108
         7qUKKZpiOUnjlOlooftiMnTjUb5d0rsI3znVqFQOFOHDXTN/APqXaTlYdKcO8CqH2rXN
         wUs+3PdC/kohQuS1G4ANmhSJ0npQpOX9OXxTFlgtTVW9tjfC4T+z5/5NG8FUIPvlONIq
         i2PCGbcgVKBWd6tOMQ/Us5Fdo3psvchVwJHjUw0Ak0Wk4kLUTiSav7en0SlJl5x9QAWR
         FZEyAd3HbzyaV++wEldpd5pfTwHdQtLQIyxQYOmmzwvUlIdhYy5eRmlHi53QTC/rZOqZ
         aVSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Xg4Ypf+FhH6HZPEJeuO4jiWv2woKNqERLCwKG/QwV0Q=;
        b=yYuEapRUl+ybWBIBbemq3+ePSwEkdh742q2hF/029nSoDZ4vwM0rGwKR3/VlBuhhWM
         IupqYVLI9pc9+Kos2qncEHBH/SZRi6VunvQXuNK1+UbQL+qcBQSswrlxs74i+uG9dGb8
         e/vUhoSQ6ZuNzAhm1xaGi9ZOnRStFQCN/df3d7irtecFYxyWRzfJo5619HhqbMdPzs2W
         vivy1Zl/TsZ5+YvrjuEt/YYJMpgOx/2kRBQoNAefq0KsJ4nR3naSoCZgNRKKI21MWYDg
         nto7Ebmco+iqf0aACL29afLFGkDfTJdXtD+0sR0ePZVxRw0IkHjqReXm8hHTEAWy2+Su
         yf/A==
X-Gm-Message-State: AFqh2kplyNtNpR+IPCTp7jntjFPIlLZh/ojxxRIuVTHmnmJFjH4AqlEH
        XmY0WpdmPBnZt86IIfgVMHICYNDqwYqCoQ==
X-Google-Smtp-Source: AMrXdXsPa+KcvYlDdWE3QGGqkfrbJFAf1YPqgF1lqU370A+9P+MrPH2fuUFyeh2lo0zH+VUDLgozbQ==
X-Received: by 2002:a17:90a:664a:b0:223:ff2e:ca5c with SMTP id f10-20020a17090a664a00b00223ff2eca5cmr1948024pjm.42.1671615765831;
        Wed, 21 Dec 2022 01:42:45 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id b8-20020a17090a6ac800b002199eaa80e1sm993683pjm.13.2022.12.21.01.42.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Dec 2022 01:42:45 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v4] am: Allow passing --no-verify flag
References: <20221130172833.2662751-1-thierry.reding@gmail.com>
        <xmqqr0xkt07x.fsf@gitster.g> <xmqqlenst021.fsf@gitster.g>
        <Y6LP+fCMmP33T6Cx@orome>
Date:   Wed, 21 Dec 2022 18:42:44 +0900
In-Reply-To: <Y6LP+fCMmP33T6Cx@orome> (Thierry Reding's message of "Wed, 21
        Dec 2022 10:20:57 +0100")
Message-ID: <xmqqtu1prt2j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thierry Reding <thierry.reding@gmail.com> writes:

> On Thu, Dec 01, 2022 at 09:55:18AM +0900, Junio C Hamano wrote:
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > ...
>> > The same comment as the previous one applies to "test_cmp_rev second"
>> > check.  I think removing them would make the tests better.
>> 
>> I will queue this on top for now.  Thanks.
>
> Just to clarify: do you want me to send out another version with your
> changes on top or should I consider this done?

It is up to you.

 * If you agree with the "fix-up" done with the extra commit (marked
   as "SQUASH???") on top and there is no other changes you want to
   make, you can tell me to squash it into your patch.

 * If you don't and have better idea, you can send out an updated
   version, and you have my permission to include any (or all) parts
   of the changes I gave in the message you are responding to.

 * Or if you make a very good argument and convince me why your
   original without my fix-up is better, I may change my mind and
   drop the changes, keeping your original alone.

Of course, folks on the list may have other suggestions and review
comments, which may change the picture again ;-)

In any case, thanks for contributing!

