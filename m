Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88134C388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:53:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B3D72223F
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 13:53:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uCFoq9EK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbgKMNxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 08:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726795AbgKMNxq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 08:53:46 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB81C0613D1
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:53:39 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id d28so8756102qka.11
        for <git@vger.kernel.org>; Fri, 13 Nov 2020 05:53:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8l/Zv25LwG6bORWryw3QmAzfjup9r+2cpEL2qCN/vUI=;
        b=uCFoq9EKdcm8bdTB7LcmY7e42IUClgvmyZkwy2xbD3tD7+i8VrfsuDna1ZcqeoZcRg
         xhtGLZQs4kubpXhkpFEZ9Hd3MTRGV9i9UniViDpMm+unNWHMWShiPylbqCufOu6iiVyk
         G0xcnV5IKuakqGa5xaMAy9CLPMDlvqcrPytufOPudfDl/9pRtSxuOKECvFvEUk1YdZiy
         DtoHHnpH6FWOxw1g9s1HJ0a9AUpO+X826IxYhDB8QbhLg8xnXUKABNArsDWziv/sCUbF
         zxgcba++s2ggX4HFClqBzsyE1RpFyFsNxEcghORet4iUk3djsZT2sdlOJFQF2jpBUpN9
         eQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8l/Zv25LwG6bORWryw3QmAzfjup9r+2cpEL2qCN/vUI=;
        b=RGFSCbBzC4GLN9MkuWJUYR+ogTRifwt5Dwp1Cy66SErppI85s6WPoSuX1rkI70Y5C8
         klGaS/XUU3O7Q/ITHZE9vI8fVsOWcytXC/HYFmt3NEZq9DN+KW+rTUfCsAsfYPWEFsh1
         oBJk7WDkl3dZD6PlnPcpY9/IqoMVffR1KltWBTIUIHsXfxi32VIIxwIkQL/C8yW3bhXS
         GLp3KytIe4SKKy8E9e9XAnwpiOabg8Guh7sBesj3tn8I4INXsTS2zBT0AcvagYUeaDt3
         ZH1NDfsTw7grPyInWapu+mbti04MyDJogORxT5lZKJp2vasO1/SQt/6QEu6kJIAk6eFE
         L+fg==
X-Gm-Message-State: AOAM531hZWr+U63xBUd/0I+fHtCtOFwEtWwWBiqALe11vC7P1eBXfYBl
        pmvzn9D4DKXW5FTYcEVWscV26rGOrMWNPA==
X-Google-Smtp-Source: ABdhPJxVowqi/ZCpoAXT9fgRd6qF6hR1PEKa3ABZuLjjJOfCcB4l6Mi+h2Hf2YhApI33chwF48WLMw==
X-Received: by 2002:a37:41d2:: with SMTP id o201mr1937589qka.425.1605275618395;
        Fri, 13 Nov 2020 05:53:38 -0800 (PST)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id n41sm7231531qtb.18.2020.11.13.05.53.36
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Fri, 13 Nov 2020 05:53:37 -0800 (PST)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <CAMP44s1vx==-0Sh_dN66k-u_LwUSqQRn+ckMrYMHhz7i8ZVr2Q@mail.gmail.com>
Date:   Fri, 13 Nov 2020 08:53:35 -0500
Cc:     "D.E. Goodman-Wilson" <don@goodman-wilson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git mailing list <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3EC700EE-8DB1-4A31-9061-6C5899330CCC@gmail.com>
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com> <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com> <nbCkLegnP_kb-16UzAuDChE0p68ZtRD_3ZN3o3BJHYBYpUxTWuKjvhCSKT7zRZl_sckHrkyJl2fwePFUBR-HtDcEV0rHuac6Ygg-FrrYsYI=@goodman-wilson.com> <CAMP44s1vx==-0Sh_dN66k-u_LwUSqQRn+ckMrYMHhz7i8ZVr2Q@mail.gmail.com>
To:     Felipe Contreras <felipe.contreras@gmail.com>
X-Mailer: Apple Mail (2.3124)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Felipe,=20

> Le 13 nov. 2020 =C3=A0 01:47, Felipe Contreras =
<felipe.contreras@gmail.com> a =C3=A9crit :
>=20
> On Fri, Nov 13, 2020 at 12:02 AM D.E. Goodman-Wilson
> <don@goodman-wilson.com> wrote:
>>> Did we hear the testimony of a single black person that was offended
>> by the word?
>>=20
>>> Nobody affected by this change actually asked for this change
>>=20
>> Five minutes searching Twitter will reveal a great number of Black =
git users championing this change.
>=20
> This is anecdotal evidence.
>=20
> We all live in our own digital bubble. Every person's Twitter feed is
> different, and Google search results depend on where you live, and
> your past searches.
>=20
> You may find "a great number" of users that match that criteria, what
> I find is only people criticizing the move, and after five minutes I
> haven't found a single black person actually offended by the current
> name.
>=20
>> How is reopening this discussion anything but a distraction?
>=20
> This discussion never happened.
>=20
> Everyone in the June thread argued about the different names of the
> potential branch, and the culture war implications. Virtually *nobody*
> argued about the manner of implementation: deprecation period, clear
> warnings, Git 3.0 consideration.

I couldn't agree more. We really need to be warning users several =
versions in advance,
and I mean months or even years. I don't wan't to come up with a number, =
but I would
guess that maybe 85 %, (or even 95 % ?) of the world-wide Git user base =
is unaware that any discussion
on that topic ever took place.

Brian mentioned that some people voicing their concern on the list did =
not abide by the code of conduct.=20
There was also very vocal disagreement voiced in the Git-for-Windows =
GitHub project before the
discussion reached the mailing list, of which a lot was also considered =
to not abide by that project's
code of conduct. While I agree that discussion should be done with =
respect, and some people that=20
are driven to react to such important changes might not be aware of any =
code of conduct they should=20
follow, because they don't participate in the "day-to-day" life of the =
project, just the fact that they even
care enough to voice their disagreement should be a big red flag in =
terms of how this change should be done,
in my opinion.

I had avoided commenting on this whole subject, but the main point you =
are bringing,=20
that such a change, if done, should be made with great care to our user =
base and a lot=20
more warning, is a very important one.=20

Thanks for bringing it up.

Philippe.


