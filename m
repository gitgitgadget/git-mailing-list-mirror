Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985A3C433EF
	for <git@archiver.kernel.org>; Fri, 11 Mar 2022 19:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351165AbiCKTnl (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 14:43:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbiCKTnk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 14:43:40 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7009FDC
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 11:42:35 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id p8so7748436qvg.12
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 11:42:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nN4GykbWdbX2oiXtXofZK1wBS5yfG6p6JoKi1o4glYA=;
        b=HQzAYiJ3a/IO86rap+ubFkDxMPfthqJXx1K7S3fg0ffP67KFbQ62Y2jikUUb3dUKd2
         F2Uqfg6oIQCOB0Y5H8BPNAKiVXHb+bgN8aHLai2QvUg7b5d/kkRtkogTyTjrTstuZJur
         8uZd2h4WYk0ax2zmQY8M5a9Vurpe3Sozbflvk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nN4GykbWdbX2oiXtXofZK1wBS5yfG6p6JoKi1o4glYA=;
        b=c8+W3ilg3pj0uPuawlngijwGD0FUyKFXl/JABWPGSKCwjaRCFOt5lv9YqdeDYmYft2
         H1NULcENmCFOBlO3XsITuKIsyIu7RcU6xD6zjVjnEB0D3h+MpiafMq6+kzYLrQo/VqT9
         SNFrqzp+DH6mKP7xU2RDWg/iLCWioieiF1kD/w84zM5zla+v1IfM3GVHveCQ5alDu8DD
         0IjzDwl0kdojwSh2hsCYR4LsHzx72sv6XvftM4SDeP9DvnJV9Tm4H+zmjBwDgq7cFWdL
         +c8Qma25dBOyLdY3CvW0kb4ve3A4meAyDOgCBKZ4SUE3/lYZiZYSW/c3ldntCCZqETaC
         0L5g==
X-Gm-Message-State: AOAM531o/qlpx/AGd03Zg3fBXq9abApzlw3eW5xtIfpo+5JfH162n4DI
        73D2fOV68dnEQWlkt4cMnTDJb8kZGMFCUg==
X-Google-Smtp-Source: ABdhPJyjK+10DiOLg2kTYyYL5hAzgWU0ww8sy6fcBlHIG8oiHt/ffW2uZAxvOk8s4HisSl7pIldq8Q==
X-Received: by 2002:a05:6214:19ed:b0:42f:f387:ff0f with SMTP id q13-20020a05621419ed00b0042ff387ff0fmr9173934qvc.83.1647027755079;
        Fri, 11 Mar 2022 11:42:35 -0800 (PST)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-127.dsl.bell.ca. [216.209.220.127])
        by smtp.gmail.com with ESMTPSA id m23-20020a05620a221700b00649555cd27bsm4216949qkh.79.2022.03.11.11.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 11:42:34 -0800 (PST)
Date:   Fri, 11 Mar 2022 14:42:32 -0500
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     git@vger.kernel.org
Subject: Re: RFC: Using '--no-output-indicator-old' to only show new state
Message-ID: <20220311194232.huwvcsar5iglswne@meerkat.local>
References: <CAHk-=wgh8emJn-+FtxN=m_SCPiP6cGKHU-5ozzV9tWBMxn+xcA@mail.gmail.com>
 <xmqqo82dd0qv.fsf@gitster.g>
 <CAHk-=wg+n_-btzoyMqnDYsJxFYAyUh0Kb=TkpS8RiD_h3G=_cA@mail.gmail.com>
 <xmqqfsnpcxdm.fsf@gitster.g>
 <CAHk-=whRbuJJ1LzYN9F48JaS7EjuP3FkppHJXi1wAO_qLJQ2xw@mail.gmail.com>
 <CAHk-=wj0ZfmTEhc4iPJSbn_FxzU94qZfK9WcgujKUcZK9a2UvQ@mail.gmail.com>
 <220311.867d90j2vj.gmgdl@evledraar.gmail.com>
 <CAHk-=wgT9=3V60koHO40omnubeBK3bD8kX8WAx+gUHTWoNCn4Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=wgT9=3V60koHO40omnubeBK3bD8kX8WAx+gUHTWoNCn4Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 11, 2022 at 11:15:10AM -0800, Linus Torvalds wrote:
> So, for example, I could trivially use "torvalds@kernel.org" to send
> out patches, but I've tried to avoid having multiple active email
> accounts and confusing people with different names etc.

FWIW, you can send mail through mail.kernel.org with your regular
torvalds@linux-foundation.org email. This is what akpm does, and it's kosher
as far as DKIM/DMARC is concerned.

If you'd like to try that out, you can set that up with git-send-email:
https://korg.docs.kernel.org/mail.html#sending-outgoing-mail

Just set your sendemail.from=torvalds@linux-foundation.org instead of
torvalds@kernel.org.

-K
