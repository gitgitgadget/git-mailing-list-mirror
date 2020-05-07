Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDB6C38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:48:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C8A172075E
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RH/ZhtwY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEGLsw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 07:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726074AbgEGLsw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 07:48:52 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65332C05BD43
        for <git@vger.kernel.org>; Thu,  7 May 2020 04:48:52 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id l25so2722648pgc.5
        for <git@vger.kernel.org>; Thu, 07 May 2020 04:48:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nqpUO0Yw8Qz3sgyY/BsJ7w/dSo9dm+MuZUuclLk7vAU=;
        b=RH/ZhtwYDHlO0JWpT9Ro0isz3l9fPjvRe74v7yB+AZc5twrZZpsqmn/NXy/AVofw29
         rRenGfLl2ddH5K6Z1Qk2eIMWzeSlMfZ5jvmKTVJSnLKZsabqakF4ci2FNF/HuLv3rDYj
         Wwt9nkEIOe9QPo8ISCj9+KsMoGDz790/a/t9+C3hxD0sKF6cY6WMS0haYPw7HIdOqJBK
         +jsjEifUUaIxPPONw884vbOzwzf/1JXsLHZT2pOhu/DaLguCzq8DPe+yygyE2UwlPhqi
         8U1jJUXqexU4Ay+Q/3TogRdJ8igrCRf52qVKYqHPqqdBrYIry8+TDr4+YK187yXYibPB
         SqBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nqpUO0Yw8Qz3sgyY/BsJ7w/dSo9dm+MuZUuclLk7vAU=;
        b=W6Y7gOK2CzNkpKpil6NtPvWWTcvRJGVS510wg9+p/oaHiINUQlMh2VRe47kukSKm61
         jXJlA3njTYW1+Zq8wAbXBfskqog9Nadxd82FjrZc3x+ZsGciXs4yoPTfMvjmblIJviTO
         IcvHt3P0TT74ZEEerUVFl79r3waOuY0n5XmiYNTvidyOQlv+x3OMGL2QCphP2GN9BQOG
         wJ6c+gpmwbvDjzOi2U8dY4EdAujK3qdCuck6fGMYe2ap/Ud4WuA8NDJ8eBz3wURDuhXY
         5EI/QzSXaT6CpXSEdiRW3EG+JvdjtMKZOPb64KkP6STkLyK+4Bu/Fo/1NZP+6KPhTaXq
         lw1g==
X-Gm-Message-State: AGi0PuaF1jtrohyzlDtajUpBrTG3V/MYclM1Zp4bhSxtCJFTbP04TMbI
        51P1CJlL52nrMsUApVmiRUmLrH4p
X-Google-Smtp-Source: APiQypJvNym9dLoU27v16gs9HRDWwNr5w8kD4q0F3j2/Y08+rgs0eVgcANCrkwrXFe5KAWE1pkDp3g==
X-Received: by 2002:a62:ae0f:: with SMTP id q15mr12857059pff.181.1588852131954;
        Thu, 07 May 2020 04:48:51 -0700 (PDT)
Received: from localhost ([2402:800:6374:cedc:d509:3e82:1f34:e3c4])
        by smtp.gmail.com with ESMTPSA id c4sm3699979pga.73.2020.05.07.04.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 04:48:51 -0700 (PDT)
Date:   Thu, 7 May 2020 18:48:48 +0700
From:   =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
To:     Sibi Siddharthan <sibisiddharthan.github@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Konstantin Tokarev <annulen@yandex.ru>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Sibi Siddharthan via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/8] CMake build system for git
Message-ID: <20200507114848.GA32465@danh.dev>
References: <CAKiG+9Vvwz_ajhJ1KPVWtq25UaGtJOH57eXTA=cgm5qzoZCfGw@mail.gmail.com>
 <xmqqsgghhr32.fsf@gitster.c.googlers.com>
 <689741588534833@mail.yandex.ru>
 <nycvar.QRO.7.76.6.2005041630150.56@tvgsbejvaqbjf.bet>
 <848941588629532@mail.yandex.ru>
 <CAKiG+9Xu+eeET1Y3hFJTSpofxBCWEvwjyaY0cjFbKptzYLACNw@mail.gmail.com>
 <xmqqwo5qc3ec.fsf@gitster.c.googlers.com>
 <CAKiG+9WzQdFa1qM4dKUu8O7k+Q8JGsDMGQg-2GRJr=AJye6wJg@mail.gmail.com>
 <xmqqk11qb61j.fsf@gitster.c.googlers.com>
 <CAKiG+9WE08ikv9uzDg30w2w=+chRQs9te8hKbVg2WG0p964RZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKiG+9WE08ikv9uzDg30w2w=+chRQs9te8hKbVg2WG0p964RZw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-05-07 00:13:25+0530, Sibi Siddharthan <sibisiddharthan.github@gmail.com> wrote:
> On Tue, May 5, 2020 at 11:47 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > Sibi Siddharthan <sibisiddharthan.github@gmail.com> writes:
> >
> > > I have made the following changes as suggested:
> > > 1) The CMake script works from contrib/cmake now.
> I am confused for 1 though.
> I think it would be better to add it as a new commit (between 7/8 and 8/8).
> Is this acceptable?

Please make CMake works from contrib/cmake from the first patch in the
series.

-- 
Danh
