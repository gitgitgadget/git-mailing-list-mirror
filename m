Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80F09C4338F
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65FDB60EB9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 20:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236422AbhHQUWc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 16:22:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbhHQUW1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 16:22:27 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B10BC061154
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:19:31 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g9so11731834ioq.11
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 13:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OmxGYhaIQHtZMVVNmMm8G0+fsEWCbX7/3Ee9nNykYew=;
        b=Ry941Veqqt6q23uSn+d7+LK1D4UPbGflEtNneCfPd0kDEjW6IuBe2bVpQHigd6guZG
         2iW3PEhvoqbMS5s0tIiJQaln667TJAFEr4deeujwpQOCmT0ZWDQuWYaxSqo4HzO9P9SL
         SIYw3yG2dQZqZzA9tgZqh9rE6JyDf2pnzm/NmKW7gZ5ruhi35W/Azbn+p7JiOCEoA3Y8
         rJ3Wkp7ewrDqCSGkKUpTVaoNRZGHMsLiN8o5ddO2JPeaJPZettvqb4oVFhJOeUDO9GT3
         VKyNTtmlftEtUDJ54Cr0O7GC+OVrStdNoFqzzCdpKhoRW+DuznSNpDPnH85xgbLd2vMg
         JRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OmxGYhaIQHtZMVVNmMm8G0+fsEWCbX7/3Ee9nNykYew=;
        b=eJZDOkzpOAEBrSi8yufJLyuqhhAikI3Qbpw2Mtc9cnKFnvaaWba8t64VZ3v8fcjapq
         r/wmw1vysJHop0N+3D31S1+IL9Te2yu0mHN3IJyTTi056+arngKCMBL+LARIdhvSDmTi
         ELCrSb3qNL94ybcJyu2SSNIED3rodIJENyofy5ABMCXTkcKuNZnY9tF6Pug3SPX2dGW8
         ESeqtSJMnKnI8qPirchnMwxLkVfIn2XBj4YQE7DJrPdy72bckgZ4qpcR+CfGCp8F+B+N
         30TpeLgLF1nzx6VKZJpMBHcrMQyrd3Cs5zQTEgsU5vsX00AQw7xuI4cBAozUkpw7AqMN
         PD8A==
X-Gm-Message-State: AOAM5309n5aN8ILKRTKd3C+gdwtip/FwGoLbUdKrrK738fbKLDPiw3YN
        hZ5uHxj5fXRf/afmAQHPAE4BKa7fq+h44tbMGB7uIODe
X-Google-Smtp-Source: ABdhPJxb3JzvnUbP+UeGf8Wggv8e5UBGfEesSlSk1u5lf4ksJVSeBSVNQwtEEvTF9mOJBixFOyGsspvgJy+aWnGoqnY=
X-Received: by 2002:a5e:c609:: with SMTP id f9mr4097617iok.127.1629231571110;
 Tue, 17 Aug 2021 13:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20210817081458.53136-1-mirucam@gmail.com> <20210817081458.53136-2-mirucam@gmail.com>
 <3dcf28af-1e75-0934-4663-3691b0efde1d@gmail.com> <CAP8UFD0RFm=CBsckhdBJKJ9QAw+hWT0yY84J4dNcaXegRp4u0w@mail.gmail.com>
In-Reply-To: <CAP8UFD0RFm=CBsckhdBJKJ9QAw+hWT0yY84J4dNcaXegRp4u0w@mail.gmail.com>
From:   "Miriam R." <mirucam@gmail.com>
Date:   Tue, 17 Aug 2021 22:19:20 +0200
Message-ID: <CAN7CjDBJMLn=MkJHnFFBmTsMR0dy65+D1UMWObyHV8=qoNfOHg@mail.gmail.com>
Subject: Re: [PATCH v4 1/6] t6030-bisect-porcelain: add tests to control
 bisect run exit cases
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

El mar, 17 ago 2021 a las 11:23, Christian Couder
(<christian.couder@gmail.com>) escribi=C3=B3:
>
> On Tue, Aug 17, 2021 at 11:03 AM Bagas Sanjaya <bagasdotme@gmail.com> wro=
te:
> >
> > On 17/08/21 15.14, Miriam Rubio wrote:
> >
> > > +test_expect_success 'bisect run fails with exit code equals or great=
er than 128' '
> > > +     write_script test_script.sh <<-\EOF &&
> > > +     exit 128 >/dev/null
> > > +     EOF
> > > +     test_must_fail git bisect run ./test_script.sh > my_bisect_log.=
txt
> > > +'
> >
> > This only checks for exit code equals to 128. You should also check for
> > exit code greater than 128, for example 255.
> >
Noted.
Thank you for reviewing, Bagas.
> > > +
> > > +test_expect_success 'bisect run fails with exit code smaller than 0'=
 '
> > > +     write_script test_script.sh <<-\EOF &&
> > > +     exit -1 >/dev/null
> > > +     EOF
> > > +     test_must_fail git bisect run ./test_script.sh > my_bisect_log.=
txt
> > > +'
> >
> > This test looks OK, using -1 as representative of negative exit code.
> > However, wording of test name can also be 'bisect run fails with
> > negative exit code'.
>
> Actually I am not sure that it makes sense to test an exit code
> smaller than 0, as POSIX exit codes are between 0 and 255 (included).
>
> For example:
>
> $ bash -c 'exit -1'; echo $?
> 255
>
> $ dash -c 'exit -1'; echo $?
> dash: 1: exit: Illegal number: -1
> 2
Ok, I will remove this test. No problem.
Thanks, Christian.
