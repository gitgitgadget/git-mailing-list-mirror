Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835EAC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 14:23:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 617FD61130
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 14:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237230AbhIOOZP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 10:25:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233935AbhIOOZO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 10:25:14 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1831C061574
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 07:23:55 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id f18so1063577vka.12
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 07:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=u/4BUdk1JXYAPm/11tMbLBEcO9DMx7HIhQ/KmJzc048=;
        b=ctg0C7pultNPj3r9A3rj+H46eUEItpCQ82yjwL15uJDnj3QcUJuNgjhNSGSFSFle9O
         j/nUsSHoxHLhUKy/t0FL0gAzFW+3viOOavSrviNrGDcRftBqOkXcsI7TGf7jXo2iRkOV
         2JIssXIU5X1gG/LyiTJaFLfmCFUOzE7DdEETl4f84lW0W14VMhdNaz08lx04psAFC/U7
         ua0sZxoN2ydVHWzVH7X4BzAAKpXxqDcHOLcxyqyJDM+t/jjtlaM8AzeBFnsRFKNc80h5
         YezL51o4DK7HIKF0BQS1NvEIqlZqQARl4yxKpFyqOpwghiLCJbG67TM3bHlb54E7Iavd
         c6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=u/4BUdk1JXYAPm/11tMbLBEcO9DMx7HIhQ/KmJzc048=;
        b=guSoNmsd7t5J+MT9I2FI11EiWoWymk3/EdshHQFgrlcE1IHJdVn5ULJ0Z6JtdEBZiO
         u9PnK7zMmZq3TYALvHgEkh6zCVDszS3S0EEH1a/DEgFJyUdKZOA/ioI+E1oZllKI2jun
         G0hzuic+zcvvDhZIWF3SgVCqDCeC7BhEvDu1sxS6tYwDCP20uTY9qfRKLbWLc2zdPstJ
         arBGJ5t91VbrZEzeogxGOjh5gv+OBJoSRpvfYRwBoiDZf/tb+a1fHyNN8HEp8jUqxyMB
         prR7Si0lMkDPc/iuM/dBytq1dTXZOXn4Vdi23vTeHAuUb1YMD52YukgaVCUi7nnX+kDf
         uMlA==
X-Gm-Message-State: AOAM530IUYOOMb3/jvJ6ubdUq07R3gs9DlRvthGuBlMo/a6H4vWhIaQ4
        1SVLo7AS1xqwuh30hYieXBzmEQoYA8uI90Qiemh0EhOEoBrWNlOFjqI=
X-Google-Smtp-Source: ABdhPJwsrDw3HO8faAt+V2d9DGfTPX4MCF1ejABV+g3R769cXrPW5JYMGgwn/q8gVCI7lGWkskZHnc2uCXHssIeMVn4=
X-Received: by 2002:a05:6122:16a2:: with SMTP id 34mr296354vkl.26.1631715834931;
 Wed, 15 Sep 2021 07:23:54 -0700 (PDT)
MIME-Version: 1.0
References: <YTNpQ7Od1U/5i0R7@coredump.intra.peff.net> <YTNpeH+jO0zQgAVT@coredump.intra.peff.net>
 <CAOLTT8Tka0nxHb3G9yb-fs8ue7RaPCUVSKi5PM+GY+rMjFRnog@mail.gmail.com>
 <YTTARcEvpXWSDfYW@coredump.intra.peff.net> <CAOLTT8QbdNBSY95bCa+UNJBqsJEEHbnaKfZLzvN2Qzd-Np8Lqg@mail.gmail.com>
 <YTeo/dCFfpAIfo3K@coredump.intra.peff.net> <CAOLTT8Ru-Zhmo5j=jNjWexrahT0qAO5zEMW09XT00-TCca-SkA@mail.gmail.com>
 <YTtrF8C0mmT6kBJT@coredump.intra.peff.net> <CAOLTT8RPzutEQxbr9cu=ze7rgPKvG6Ghu4b2Bi47eStY1TqGzQ@mail.gmail.com>
In-Reply-To: <CAOLTT8RPzutEQxbr9cu=ze7rgPKvG6Ghu4b2Bi47eStY1TqGzQ@mail.gmail.com>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Wed, 15 Sep 2021 22:23:43 +0800
Message-ID: <CAOLTT8SYxUbfG7YvAs03nwRdee8JfNPUYCCpKcFoAgBjB2oqLw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ref-filter: hacky "streaming" mode
To:     Jeff King <peff@peff.net>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

ZheNing Hu <adlternative@gmail.com> =E4=BA=8E2021=E5=B9=B49=E6=9C=8815=E6=
=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=888:27=E5=86=99=E9=81=93=EF=BC=9A
>
> > So yes, it's complicated. And it must be explained to the user that
> > "%(refname)" behaves slightly differently with "git tag --verify", but
> > that is unavoidable if we do not want to break scripts (it _already_
> > behaves slightly differently, and we just never told anyone).
> >

$ git tag --verify --format=3D'verify: %(refname) %(symref)' annotated symr=
ef
verify: annotated
verify: symref
$ git tag --verify --format=3D'verify: %(refname) %(symref)'
refs/tags/annotated refs/tags/symref
error: tag 'refs/tags/annotated' not found.
error: tag 'refs/tags/symref' not found.

$ git verify-tag --format=3D'verify: %(refname) %(symref)' annotated
symref
verify: annotated
verify: symref
$ git verify-tag --format=3D'verify: %(refname) %(symref)'
refs/tags/annotated refs/tags/symref
verify: refs/tags/annotated
verify: refs/tags/symref

As we can see, there is a slight difference between git tag --verify and
git verify-tag: git tag --verify can not handle refs' fullname refs/tags/*
(because read_ref_full() | read_ref() can't handle them). So, as a standard=
,
which characteristics should we keep?

> > The other option is to declare the current behavior a bug and fix it. I
> > am quite tempted by that route, given the inconsistency with other
> > formatters, including even "git tag --list --format=3D%(refname)"!
>
> I don't know, I think both fix methods are okay.
>
> >
> > -Peff
>
> Thanks.
> --
> ZheNing Hu
