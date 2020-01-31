Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90240C35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:07:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6644D206F0
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 09:07:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="AjjeBIp5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728257AbgAaJHI (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 04:07:08 -0500
Received: from mout.gmx.net ([212.227.15.15]:49755 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728181AbgAaJHI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 04:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1580461625;
        bh=NE0U8cH1cdsv76HkAXcp8MW4L4kc9WqLEgDt+Pw/mZc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=AjjeBIp5AXNM9k8BRrXF7wAAouFhYFIk6WweGPWWSBxIwJfrrk82oAWHlzUK/Wk1O
         p8faNg4t95mroCk16BJG18jX5NZxydpkk+HJ/NRKWi4FhFSOzs1MdzT39UsmJGWo7e
         v5otzuvjI8iO8IYjiVxlDQAbg34Qly2YYYmUZnn8=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.86]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MXGvM-1j4VHT10Mo-00YkNC; Fri, 31
 Jan 2020 10:07:05 +0100
Date:   Fri, 31 Jan 2020 10:07:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Christian Couder <christian.couder@gmail.com>
cc:     Miriam Rubio <mirucam@gmail.com>, git <git@vger.kernel.org>,
        Pranit Bauva <pranit.bauva@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Tanushree Tumane <tanushreetumane@gmail.com>
Subject: Re: [PATCH v2 09/11] bisect: libify `check_good_are_ancestors_of_bad`
 and its dependents
In-Reply-To: <CAP8UFD3mhirdjHnT+XRq1mPzii3O+mtAMrYCy7mf4HKQZo8Acw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2001311006360.46@tvgsbejvaqbjf.bet>
References: <20200128144026.53128-1-mirucam@gmail.com> <20200128144026.53128-10-mirucam@gmail.com> <nycvar.QRO.7.76.6.2001301341100.46@tvgsbejvaqbjf.bet> <CAP8UFD3mhirdjHnT+XRq1mPzii3O+mtAMrYCy7mf4HKQZo8Acw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:p3Hk/AdCGzpBigDaxlfuf9RkQOB7s99va9bbW15dfhZZbccP0zc
 NHjaz/SYlXIyZj7PfUJx+TO1l9MK1eR66nHmBn2Tcv0O1HwtzWkUIdw6uUHoxd/FMQRmrvu
 oynnt4g5MQgCwisP8NoJyqNJKJ88F7w3rjeHYcQXH35wxrwInuyW+YZK0akRfu+lvm2jblM
 8Ma/eIHkDE0c2/UyaEu0g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1/VMsOAJxGI=:b2stHSUVUhAN0LqUq1v+y/
 JDdWGn6a7638LR1XpVDcn51msY19xtu640OqunmXrJdZNIk0sQiUb4N3YGj+DAyoo6e8pPNvt
 O/6qKvnGobzo/FhnEz6aa2Uh6/8RCJoJ9WHHWgPsZb0Pl8kEuZ0a2+d+XMEsmTBqqiV1lAihv
 Dnkqyn1ksPBy5f3ie0NiNEtekbCO03pHX4/1xWgyP//Eu7Kt5+GnV0tTMIhJDlzEyB3E0u5hx
 U7fFkWV+lBmoQe2Dvg1gx/HVWZitsvajTgj9TK20xraKr/o4+W/f+tcEqLmNsyl6OM8xku8dC
 93rE8jr1iHoQqo8Kn2JHTibXwboFLOgcbv63MEwf+HB855t9BbS3WYgoUw37VCjd6cvKfwoyr
 V3yDyVEvM1aq0fEJT8yBh1yFO7jOKXsenlTwmpmqK1k2GTnQPOgY/lfBOG7KoYyvhDmvMSlPs
 j+3cLdQXfqEE99qc/+MK0DNUhhchE7Y05mYGfIeb+X034O/2WwFo1nbVI1xtoTQ7CaQDKN4i9
 itPSNWyQzP8qbG/91QLTx0nkXQLqnmwCsK1E8JZ7iwTAZ5QyGqxp7HIoivH68mDkzgEtOIoX1
 kXAn3Bhd4VyOnAVe6kp9RinaTwHkMoObHQuCm+GpTWimHuVzxn1m/MkUjQWG6fIls2pKx1zoY
 +y7/GU5qB0rVFwTfgGHm3Tw/wnPkdtzyMkiz6odhtmISB22fp5ngUT7sCvcP/0EToGNtVDwJL
 kZ8C/WViB4LEJYB3euNGhbkBrf2y1duqqoJhrzT5Oi0RGlFHKf/DwVvZwkPIjVrWlG7K7MToG
 xvwjthe8QhJTdr0W+OvOq9mabnvW0otHNi4Saud2XUP+b/f8t4ohcnv+x6BDW96MW0bd+0Q9d
 pMNXoqj1bpMEo+Z/+rjEzm2svuA1kgy0vzA28vstXstLlqDnpsv3M88FXffEwN7K3PPqIymIp
 r++82PuJx9AViySSeEq1G2jMuDtvh+hv66tE2DQ+c6GtUPzCqSLxCnWGC4mZwG9rFvk1XbvLQ
 Jv/5ieriKeKGtoTiureCcY5VOVVchdL6N7X/Z3MWkKtj53lOnUD7eMpldeP6pH9df5PT2Z2iP
 LlpxPggOkRpPYA1Xeufscy8xU/KYMQXxJ1iF/+9PowxfVEJr5rG35LMfjR0jdlyLfEIM2HY+C
 GQBEPQwCveQ0FD9Uz6OF75ThG7NXjPbr0BS9XMmI8Lcaj6OhJp6XuqGoTyDUKMjzDRh9opZfK
 +LPzK59IIFxTVV4gt
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Chris,

On Thu, 30 Jan 2020, Christian Couder wrote:

> Hi Dscho,
>
> On Thu, Jan 30, 2020 at 2:46 PM Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > On Tue, 28 Jan 2020, Miriam Rubio wrote:
>
> > > +             /* Create file BISECT_ANCESTORS_OK. */
> > > +             fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, 06=
00);
> > > +             if (fd < 0)
> > > +                     warning_errno(_("could not create file '%s'"),
> > > +                                   filename);
> > > +             else
> > > +                     close(fd);
> > > +     }
> >
> > I wonder whether this would be easier to read:
> >
> >         if (res =3D=3D -11)
> >                 res =3D 0;
> >         else if (res)
> >                 ; /* error out */
> >         else if ((fd =3D open(filename, O_CREAT | O_TRUNC | O_WRONLY, =
0600)) < 0)
> >                 res =3D warning_errno(_("could not create file '%s'"),=
 filename);
> >         else
> >                 close(fd);
> >
> > Note: my code explicitly assigns `res =3D -1` if the file could not be
> > created, which is technically a change in behavior, but I think it is
> > actually a bug fix.
>
> I don't think so. I think creating the BISECT_ANCESTORS_OK file is not
> absolutely necessary. If it doesn't exist we will just check if
> ancestors are ok again at the next bisection step, which will take a
> bit of time, but which will not make us give any false result, or
> prevent us from continuing the bisection process.
>
> I think that it's also the reason why warning_errno(...) is used in
> case we could not create the file instead of error_errno(...). We just
> want to signal with a warning that something might be wrong because we
> could not create the file, but not stop everything because of that.

Thank you for this explanation, it makes sense to me.

Maybe a code comment would be in order?

Ciao,
Dscho
