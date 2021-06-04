Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BA3C07E94
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E63F613F9
	for <git@archiver.kernel.org>; Fri,  4 Jun 2021 13:34:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbhFDNfp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Jun 2021 09:35:45 -0400
Received: from mail-ot1-f41.google.com ([209.85.210.41]:36812 "EHLO
        mail-ot1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230108AbhFDNfp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Jun 2021 09:35:45 -0400
Received: by mail-ot1-f41.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so9090486otl.3
        for <git@vger.kernel.org>; Fri, 04 Jun 2021 06:33:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=q1Dmdu4k0V+r3TfQD88jlpHopG1zDUiuuyXLmKAK4zM=;
        b=d6HBfwcvT+7a7rVM64sXQI8i9Pr5n5vhbmtbwE+LqMS3eXa3HkgwPlYg60KmenfwQj
         K34Rmwr8kNjArEFcGKIK8Yl9L4UG1iy4AZlZHo6lN2n7fvXAzLNp5L/GHZ1ZSZ8QNvzr
         p+9/x5aVfw4yWRR2uK8iClyMjj+MUOOA1DS11LTRppz3OpNssE/MhoK4krFjECGodQsw
         ckRIl76QQ3zEXsyIQAeGtAgtTS/Fz6pJ0d4pGffEOQl7fANu0CJez4YoWBsOLx4ImujH
         uBix+UjSi5HH7XDHRJTepkfS9Duha8UV3OizTsbQ1lyaxmKDHhB1khdk8n8z+0l/b7JR
         cMCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=q1Dmdu4k0V+r3TfQD88jlpHopG1zDUiuuyXLmKAK4zM=;
        b=R0j+gh3PqFN7FBX9pvWJLRHS6X7PLlQ4B2df/Wr3q3BQ96UudOPKRWJM4mj1eRnhQt
         TDFbIy1PRqSkiraz4xWNsGIhPD7pAmnVHoYyx4PONRf6dvMZlD52RH6ClKwYSyOBOVY4
         2sbDM2rMhLL+a/ZvVVMFtR1C/3yUMtg7imul4clOZdPi38fd/eo/b5TKlgiJexQ/x/FI
         2W23ZDbwxRqP3bPIoflmeyJ/2K60gYKwHEyMEkrMXfQ5uVy2AM7dTvHMObByfbzQwbh9
         GSKC16z1DW6NleYJI2enoCwDjyeY8zyFqQDqT4eqHOkvyfGleBlKicQlud7OviZ6URYF
         Wiiw==
X-Gm-Message-State: AOAM530hjxQCLfwRN+d8r2n/P1Jv6ncEgTQpheG7ovtFH5jgDzQwMLQ7
        JI2z5a5+YjNf0DXYwSW6jyk=
X-Google-Smtp-Source: ABdhPJxSFe7wI1yoTT0JFUv0l4iWL7JbtOrNjPjfAR/bfcLIUOpT+Vebmjz7yrxkARL2aOZBQEnl4A==
X-Received: by 2002:a9d:32b:: with SMTP id 40mr3708659otv.365.1622813565603;
        Fri, 04 Jun 2021 06:32:45 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id u1sm483362otj.43.2021.06.04.06.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 06:32:45 -0700 (PDT)
Date:   Fri, 04 Jun 2021 08:32:44 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Message-ID: <60ba2b7bf4006_f5b33208f8@natae.notmuch>
In-Reply-To: <YLnG1Npa9rMYyWJJ@danh.dev>
References: <CAPig+cT2fJqsptU0YpNQ=nhvU2Tu19zdHXxCin8fUkSkd97m4A@mail.gmail.com>
 <60b928374d90e_39cbe920835@natae.notmuch>
 <CAPig+cS74Ah3OyJPNQhvkdV6f7mkFgFQjHgfrrAE1gZsvN38RA@mail.gmail.com>
 <60b97dd1acd9d_3a18272087b@natae.notmuch>
 <YLmGxcQ3s2gBbfe0@danh.dev>
 <60b98adc7f8cb_3a25c2208c9@natae.notmuch>
 <YLmLyT0XmQ/lOBKg@danh.dev>
 <60b9a1d25b63f_3a3b7e208fd@natae.notmuch>
 <YLm4dn4INFPhg2OI@danh.dev>
 <60b9c17ae2306_3bd68520833@natae.notmuch>
 <YLnG1Npa9rMYyWJJ@danh.dev>
Subject: Re: Gmail OAuth2 in git send-email
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2021-06-04 01:00:26-0500, Felipe Contreras <felipe.contreras@gmail.c=
om> wrote:
> > =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> > > >> > > In the past, when I tried to enable 2FA, Google always asks =
for my
> > > >> > > Phone Number because of *security* and *safety* reason.
> > =

> > I still don't see what is your point.
> > =

> > If you don't have a Gmail account, then why do you care about particu=
lar
> > ways to authenticate into a Gmail account?
> =

> I have a GMail account, and I have 2 FA enabled already.
> =

> I was talking about my experience when I first enabled 2FA,

OK, but I was talking about ways to authenticate into your existing
Gmail account, which was supposed to be the topic of this thread.

Cheers.

-- =

Felipe Contreras=
