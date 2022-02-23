Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E694C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 15:33:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242091AbiBWPeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 10:34:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233112AbiBWPeJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 10:34:09 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1615B151A
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:33:41 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id h15so27786564edv.7
        for <git@vger.kernel.org>; Wed, 23 Feb 2022 07:33:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pvH54qV6UBJof1si+Hhq6cdvrx/iXWGdn3psQyGAVSE=;
        b=o+Q5+v6GzG57Owwqv0mCxezMJdpuYJhvhhspOw9R63rHli79McPG5nplhXGvVUDq6b
         k+3v4ycZAfNH6g8YSK2yxjAT4Q8TcmA490BvUgJfpKxvIcRDDBuwnmn0RN6O1QOPloK8
         vm8jE97grxv4cVyTri2zJY2IcYC1bnv1d9X+Lofs25GDYHz9omE4ldBGZRzfOFsF5Er9
         LkN4/Arr2qEtClBfVO8JTLbYXOpOngx4yCmntGveMPolLysjGvTJeqaeXpaVQE7DSutp
         ByAZ8qUCHFP5dwn6v53iPtmlzS4E5zSQrbAPw0WCNTEAFlfJrOBBpxavI10RdrZn4wlW
         vk9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pvH54qV6UBJof1si+Hhq6cdvrx/iXWGdn3psQyGAVSE=;
        b=vSU3mcbnDe9i86vEsUPhqwi+1KaSkqgnbLAXjMx1PDIGP50ETKeXcrN24j/qUChiI7
         ORQn5IxVHWkSuDPxDK96bojQg8LU/WAWjo5zOua4xv6f/J40sD4XhFlZlVtYnHk66ari
         q5K/JlLqPb60AMJo/6rYgznrj6FJymSWfrdWlMsrEl7gzY9y2z7wXPhj9weq1oB4z6I6
         sEMl5nABQSeFrF0xvqZ0GmOcETIzb4bgkViHIikCinxfZ8ETISxQSJdNeEYCD0ukZwo7
         d9tw5IECFwrqjSd4T7VMWqbN0TosbVVVbNRGCDeL4ZEu4kknyFQ20dVDPPmCvYeMVfVe
         YNJw==
X-Gm-Message-State: AOAM533zsvOnGQw/NNRo5sAltItQT7Xbk5pUe/n8IGQnVOqS/QefsEsc
        14zi+Tfvm/2eWklEVc6F0BUNVH7F8jmrKCBRAUAbX5MpSKk=
X-Google-Smtp-Source: ABdhPJxQQcOU3C+iBjSwTZNJykzDnb711jgnYzI42Ey9KrjtNV28N3jzR8B+Spxenmp1ckU+E+hcQvEXef0jRGq8aCw=
X-Received: by 2002:a05:6402:369c:b0:413:2bc0:3f00 with SMTP id
 ej28-20020a056402369c00b004132bc03f00mr6745014edb.126.1645630420289; Wed, 23
 Feb 2022 07:33:40 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BERVCynOVvBq0QL49Ah+gy3W2snUVWBHfzXaVpXX3Dpyg@mail.gmail.com>
 <3bdff4ba-fb5f-e369-306d-5510ab20893a@gmail.com>
In-Reply-To: <3bdff4ba-fb5f-e369-306d-5510ab20893a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 23 Feb 2022 07:33:29 -0800
Message-ID: <CABPp-BF_ygATPVGfSR24URm5ZTHBJwJd0miMtgMgNWfw_o33Nw@mail.gmail.com>
Subject: Re: BUG: fast-import, ftruncate, and file mode
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 23, 2022 at 5:59 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> On 23/02/2022 07:47, Elijah Newren wrote:
> > Hi,
> >
> > fast-import makes use of odb_mkstemp(), which creates a secure
> > temporary file and opens it with mode 0444, and then uses it for its
> > packfile writing.  Sometimes, fast-import will call its
> > truncate_pack() function, which makes use of ftruncate().
> >
> > According to my local manpage, "With ftruncate(), the file must be
> > open for writing; with truncate(), the file must be writable."
> >
> > The writable requirement does not appear to be enforced by the kernel
> > on common filesystems like ext4 or zfs, but this is enforced on some
> > filesystems.  Apparently a "VxFS Veritas filesystem" got triggered by
> > this...and some helpful bug reporters tracked this problem down and
> > found a workaround (for the filter-repo usecase, they recompiled a
> > special copy of git using mode 0644 for odb_mkstemp, since it was just
> > an intermediate step anyway and won't be used elsewhere).
>
> Am I missing something or is this really a file system bug? Surely if we
> have opened a file for writing the file permissions when we call
> ftruncate() should be irrelevant?
>
> Best Wishes
>
> Phillip

Oh, indeed, looks like I can't read late at night.  Sorry for the noise.
