Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C7C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:22:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45EB9603E5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:22:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhJ1WYb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:24:31 -0400
Received: from mout.gmx.net ([212.227.17.22]:34793 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231521AbhJ1WYa (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635459720;
        bh=c+Wn77Nov8d15MK9cvJA9oJDjHgU6dXsQuUyVc63Xlo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UpOdtSRvDA3PVTgHeTmhPLOXwT8UYy/z2D5708t6xhIJJ4Yeeffg/SZt/pK4Y8CW6
         rv8zvN1O6rvm5Gk816FEe09sOJIWv2Th54SECm4zCXcBMiksMrskmRlos4Z4EQ87uu
         DIdwIkae3AGq9WQ9Ga4Svp26mgdEMfcYZFDd0qsw=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.119.151] ([213.196.213.185]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MMXQF-1mOyBL2Efn-00JWig; Fri, 29
 Oct 2021 00:22:00 +0200
Date:   Fri, 29 Oct 2021 00:21:59 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Carlo Arenas <carenas@gmail.com>
cc:     Matt Cooper via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Matt Cooper <vtbassmatt@gmail.com>
Subject: Re: [PATCH v2 4/7] odb: teach read_blob_entry to use size_t
In-Reply-To: <CAPUEsphWBuQybeBe8bjaUFZ=k+5maYCxiY4wche4XLVFPph+fw@mail.gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2110290019540.56@tvgsbejvaqbjf.bet>
References: <pull.1068.git.1635320952.gitgitgadget@gmail.com> <pull.1068.v2.git.1635454237.gitgitgadget@gmail.com> <3ffd3a001f742713eb0fde8508f876ff95103d82.1635454237.git.gitgitgadget@gmail.com>
 <CAPUEsphWBuQybeBe8bjaUFZ=k+5maYCxiY4wche4XLVFPph+fw@mail.gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:a5X2pBJEjoglWM4Yz6zL9xB74wfQw4t12XI2fnsM6w1Eyv/ap7R
 TyI5tGB7LClYz/cjOvQxnhZqJE1e4F0EtrTn2+jOhtGzqMlOuP114ho+GTmcP+0YEBmwEoC
 kihzSITuZvcD4z1ez0t1C0tssRiU29G0cwvW/6skajxJI6HFuqEa/UTFcwT0VmdvzsGam2W
 CxpSQdooL4BOcayZ+Ap4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rTh0o5nqP+4=:1r8qqKn8CahUk5JpFrtp6k
 W7G1hp9vwltBbWzbm8smFGo1odc0VRrSdBDsXr4DXjWmal0kW0EEwFFemVb6PO0oIqbjmA4j9
 gfRwRyc5rXEjA1lA9JUWrgXqFYnHPWZ8hy5vxOeB/MYdMdkb9cYYTyu3/2cStWK/ciVmREm6V
 f1sKzJQF7SjHruucwVoWdsx3b+D2Sj2L/36pi9zYXk9Po6ln2jXUUCmLXavvmzngb6hSeDut5
 RFvPyrebZWZBUlQgOSt1DqayMi4n9Of56AJc+5ARPXIcaQtw3u3VCMEYFu0SWPLZvsW0xMurI
 Gsl5w39DlX/85SzT9iHiuiVPEzczhNbv6OL8tt0nsv0KdMWhKbvmUsOIbMDmb6tZx0tPMbF5c
 6x3FnZU4a/fK4fkZtwKLNLOKDRV+Dn5944uEYNGcLLr2W9qse9h2BPHuGX66AvnDRpopg01zy
 C4RAM/rUER6cXgBVTgFcKdm1BSOy+4hA0KROq/YrEhX2I+dclIaJ6+Xpszwj7vXFkHbvCR4e0
 YPIdK37UZskJchx/2L5DAAfuzBc6/f+ze3fgKSmNEAbcsx1wq2gnwE8/OXXHbDptonugE60yJ
 0alpyJoFJUvKfZeTI5Q1/jSDJJdiTyNJceEw+q5QJ04xqg0CbvQYw9laLu20PMi3mxknBE216
 K95XQQ34VETpAr5o5i/KrN5Gl52DqH+GLz0j6KAsy6w3o57jRO4brBzaXJ1T+Mjie6rs8jxGJ
 SqGGk3CN9rIQz3RcrZu8mRCPqpZjP9KIhvLZFpPbecCFCCSO2DTcK7NFvV8vxHcUopF6x5jmi
 eYWX3R8M8bst8hagml9oxqoyYJpV0JBTmkqqrGQQM4Zm8FD6moVyHzUcHXfE5EGJ9RkGn3A9E
 fc2uROt00cN7ED9RNwoM0wxQHsInX+a1gCB+CykJdrnx+7CNqeRIk/iDF1YNyQZxNaHSmhRQw
 9HGlKvlgS2C+GTKyVyDo0pZONGKg/TvuZ/L/OFGlrKbfxSjAQBb/XXYdu5Uuu1lpxsxw3THks
 d0ByqDnJebbRwmavY/am4mOy0O9toeSQ+NieXODyxHmgWPf9y2QZ4zrG3iuikBQvQqxfhxqLh
 y7pmiR86Raw954=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo,

On Thu, 28 Oct 2021, Carlo Arenas wrote:

> On Thu, Oct 28, 2021 at 1:50 PM Matt Cooper via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
> > diff --git a/entry.c b/entry.c
> > index 711ee0693c7..4cb3942dbdc 100644
> > --- a/entry.c
> > +++ b/entry.c
> > @@ -82,11 +82,13 @@ static int create_file(const char *path, unsigned =
int mode)
> >         return open(path, O_WRONLY | O_CREAT | O_EXCL, mode);
> >  }
> >
> > -void *read_blob_entry(const struct cache_entry *ce, unsigned long *si=
ze)
> > +void *read_blob_entry(const struct cache_entry *ce, size_t *size)
> >  {
> >         enum object_type type;
> > -       void *blob_data =3D read_object_file(&ce->oid, &type, size);
> > +       unsigned long ul;
> > +       void *blob_data =3D read_object_file(&ce->oid, &type, &ul);
> >
> > +       *size =3D ul;
>
> Considering this unsigned long variable is obviously holding an
> incorrect value, might be worth adding a "TODO" comment here,
> mentioning it should be changed to a real size_t (probably after
> release, since it is obvious that change is too intrusive to need this
> as a kludge for now).

I do not think it would be a good idea to introduce a `TODO` comment here.
Why _here_, of all places? Just because we use `size_t` correctly for a
bit of the function?

No, that `TODO` would easily be forgotten when somebody tackles the big
`unsigned long` -> `size_t` project. I therefore do not even want to add
it. We know about this problem. No need for a code comment that is prone
to become stale.

Ciao,
Dscho
