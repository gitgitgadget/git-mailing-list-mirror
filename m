Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641BBC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJLQhS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiJLQhR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:37:17 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FAC4B40EE
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:37:15 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id d6so26539378lfs.10
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NE0x+pKOXR0tmRDwXdJFdQoLK2rGQsxjEkJcAdnOPg8=;
        b=R2J4PtSrEjhOsF1H6MLT5xr+aPZY5RPJNR+jeXIeZ5YuuzY4pEldRj2V4lj29TJVhv
         18rhsYb+pfJwPl/elhgJ17Rx1mAZoy7qs6c8hb/jX4wIrxuInlNHc1ynWqQxCTLj27qN
         M2lH7Php1vB2yNcJBREcKci0NnodG/SnIxECb2kqjorQueG69QxFFdGSYceZVSRf9+AE
         YtRglyZ1HgjCMIJURZ6fHot5Ao8e8EP/MI4HMo/3dzd8PWRlE49MLUhFk1EyfQLt0tDj
         Tm3j5029a0AxhA1eDd1kGOG883ilefXPQEd5t8LSgWZf+hmrpreANSwBoI6rjobiO8HE
         8J0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NE0x+pKOXR0tmRDwXdJFdQoLK2rGQsxjEkJcAdnOPg8=;
        b=OsG+ckGMBuAUm442YAEbl9lTFFimc5uwf7kI1Eu0TqfWs4hkvXoKKbXnswim6073+p
         43nfn0zVqJS7STwfsyoC7DEBHuINfj6op86C2x8iDv7/WX4mQbfQyAGalQortyVS2fki
         bZrGdXiK2HaDNPCm4aDrfzuVIFjs8u6W1h/GzIXExkG+qNhF2Efgc/OFFXgihuOUojz1
         FHq1H8uppLPEFQM7KvlNtivkqLmKoy1fydKVC/sdwDt2hQPfRDVGeGSC66obUpQZdNon
         vtSeDtHEmh3+bXc/PgXCgfuyTK52OZs8o45/EtEs4l6BnEitr3+g7mu2Uu0aWG29FUHA
         iQ8g==
X-Gm-Message-State: ACrzQf2anxy3QdQd9Q9wq+VXSRY4lR/xuNx0yljpjsbbXIizGxdHg0r7
        GS6K79MNlJ9iZF0RM+oIfVEvIzzxKvJEasVtU6o=
X-Google-Smtp-Source: AMsMyM6mAdUtEWah9kKEI6XUed/OneI63XTteowL7OMwLJQ5pM8SxHoIuTdagvIZOYt20PqnDTpLW1HuHqWfe2EE054=
X-Received: by 2002:a05:6512:689:b0:4a2:5bb2:a990 with SMTP id
 t9-20020a056512068900b004a25bb2a990mr11487999lfe.619.1665592633893; Wed, 12
 Oct 2022 09:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAP8UFD26PY-53vZNZJzCRNiqaVB4fd=AvBtVuvMQP9p8Oqj82Q@mail.gmail.com>
 <9fcfc8b0-772d-08c3-595b-5a5a139d7ecd@github.com> <CADo9pHgcfwV53ooyM8Dh5jVO2rxO-tUHeLovd7HYLdTSOkNtyA@mail.gmail.com>
 <CA+PPyiH8EPWpTuOJg1hSthFP1xBxurjN7J0J00g6xvFi_vbcYw@mail.gmail.com>
 <ae8a98d9-eec1-cdcd-67a3-695aaca7f5ae@github.com> <CA+PPyiFC0mjvY494AVZMB952Ux-TPyA-Uetu1xQ6FiHA_vaRaA@mail.gmail.com>
 <CA+PPyiEms=f7=rXkvfmaazNkxKS1-VA-XJZOrhieQEut8f7QWA@mail.gmail.com>
 <xmqqleplmz3n.fsf@gitster.g> <Y0Zig4XUePPhMaA3@danh.dev> <CA+PPyiGPo1j-2MxTvmV2jDYNVFV1q8+7TVX1uoEUpWc0o+Rkdw@mail.gmail.com>
 <Y0baxKPxHp7UdYTi@danh.dev>
In-Reply-To: <Y0baxKPxHp7UdYTi@danh.dev>
From:   NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>
Date:   Wed, 12 Oct 2022 19:37:02 +0300
Message-ID: <CA+PPyiE6e4NWGXS4WBzNteYdcNS_FW3beUq03uXx24guSDZYmQ@mail.gmail.com>
Subject: Re: [Outreachy] internship contribution
To:     =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Luna Jernberg <droidbittin@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        git@vger.kernel.org, Hariom verma <hariom18599@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Please reply inline or inter-leaved.
>
> Perhaps this documentation can help you get started with building Git
> from source. (I suspect you're missing something like libcurl
> development files, too).
I am sorry, I was not minding about it, thanks alot for reminding me
On Wed, Oct 12, 2022 at 6:18 PM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh
<congdanhqx@gmail.com> wrote:
>
> On 2022-10-12 13:37:48+0300, NSENGIYUMVA WILBERFORCE <nsengiyumvawilberfo=
rce@gmail.com> wrote:
> > I am using ubuntu(wsl)
>
> Please reply inline or inter-leaved.
>
> Perhaps this documentation can help you get started with building Git
> from source. (I suspect you're missing something like libcurl
> development files, too).
>
> https://git-scm.com/book/en/v2/Getting-Started-Installing-Git
>
> --
> Danh
