Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88345C0015E
	for <git@archiver.kernel.org>; Sat, 22 Jul 2023 21:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229503AbjGVVVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Jul 2023 17:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGVVVj (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Jul 2023 17:21:39 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF5910D8
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 14:21:38 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id 6a1803df08f44-635e6f8bf77so21878806d6.0
        for <git@vger.kernel.org>; Sat, 22 Jul 2023 14:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teknique-com.20221208.gappssmtp.com; s=20221208; t=1690060897; x=1690665697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qC20GXqAbAFmV8aNCXKf/jTUOAXPlFeenGibyoGiZ2k=;
        b=OrM2f4eAiC7EwTOVjDJcdozBMpiQZ2E21lBsdZTMv/BqUlKpgqfZkNAoYu5Ew8Op/y
         6WvlylbD2gxpy/roOOarhnwBpqfCYqYQc10jqcGhbeIUbuyN7zku5T9O6sH+VAe2jwOU
         ttrH+XjliLgtKSYKMJzSUAWTuzbdDIp8VQPKja93JkB/uDUVu6d6vFNtr8/BqNuhn2ln
         v3BhCo0Co+UE7ojMxJQnUoxLjRxfLXRx+wDgOZIluayTC8XzKCvK3S5L8w64JPE/a6EV
         v1bTMqL5izOtdwXUr5+QMOQMc/VOxG3yBW4oNpsyOn93kT/7SrbJyGDbl8BGDJ//R72r
         XIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690060897; x=1690665697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qC20GXqAbAFmV8aNCXKf/jTUOAXPlFeenGibyoGiZ2k=;
        b=EyQ6UEPXucpL+WA0/Ow/xfGXlZ7tQmjBoU9oO/U8vbs5qqNEMo9dvBX2aE4ySpnARb
         HO8IORFfg9L/YOynbe/5/8RBBr+Gw6GySlVBL6/PA/5EyBYKOsAeAsSEpZbZ6YZb87yP
         I5TNXwXR2txYUzOb+0fyeODoh/fBQb6V09zckEh8Y6nlKnRW+DFfXOF50qa1ZRgmutE+
         fX9mq++4WtfBEKN9KiwJzDdylg4eNhNR+9NPWQXXp48EBT88p+OtyhdOfSe8lyG6JdAg
         Wn7Lg2e7Lst4XbMjhOmA0UounIOMOo2rZf4aGinsIzQ+AIBnV0sOkPv5cmc81tDNXnYf
         OTOQ==
X-Gm-Message-State: ABy/qLbUDvJ7v8fOrg4Yhj5lGzulD/Md0vqMmBtWcPUzEdIT74cBEITL
        LVdeqlnJZLkVhpIUL4Z6a1L7EjWPBddNcunsyEK60g==
X-Google-Smtp-Source: APBJJlECZvCllIxsCYlDoA/F23DDhMaW3jxmCjBFg7WFZUi59dEq/E6pcavt8fYGKSfGLRNWPSgUe4Ka1hg9Xh8EzEU=
X-Received: by 2002:a05:6214:4289:b0:626:b17:3b97 with SMTP id
 og9-20020a056214428900b006260b173b97mr4000233qvb.65.1690060897511; Sat, 22
 Jul 2023 14:21:37 -0700 (PDT)
MIME-Version: 1.0
References: <CA+EiEZ+PBLEtQ1bD_TnsstT0jNehAs2CGgYXebEE4aweK=kmgg@mail.gmail.com>
 <20230717-upscale-repacking-a56622@meerkat>
In-Reply-To: <20230717-upscale-repacking-a56622@meerkat>
From:   Tom Isaacson <tom.isaacson@teknique.com>
Date:   Sun, 23 Jul 2023 09:21:28 +1200
Message-ID: <CA+EiEZLKkaX78y74xWQMioSyvwFgD7m9K-Pad14dbZSXKGuFNQ@mail.gmail.com>
Subject: Re: Parsing git send-email
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We use Yocto at work and try to help out with the project. I read this
and the linked articles and one piece in
https://www.linux.com/audience/maintainer-confidential-opportunities-and-ch=
allenges-of-the-ubiquitous-but-under-resourced-yocto-project/
caught my eye:
> One question that comes up a lot is the project=E2=80=99s development mod=
el. We=E2=80=99re an =E2=80=9Cold school=E2=80=9D patch on a mailing list, =
similar to the kernel. New developers complain that we should have GitHub w=
orkflows so they can make point-and-click patch submissions. I have made su=
bmissions to other projects that way, and I can see the attraction of it. E=
qually, it does depend a lot on your review requirements. We want many peop=
le to see our patches, not just one person, and we greatly benefit from tha=
t comprehensive peer review.

It seemed like someone must have solved this problem already so I
looked around and found https://gitgitgadget.github.io/, which is what
this mailing list uses. Yocto already uses
https://github.com/getpatchwork/patchwork to monitor patches sent to
the mailing list. I was wondering if there are any other similar
projects I haven't heard of.


On Tue, Jul 18, 2023 at 2:05=E2=80=AFAM Konstantin Ryabitsev
<konstantin@linuxfoundation.org> wrote:
>
> On Sun, Jul 16, 2023 at 11:22:20AM +1200, Tom Isaacson wrote:
> > I'm trying to find a way of parsing emails sent by "git send-email".
> > Does anyone know of any existing solutions?
>
> Define parsing?
>
> If you just want patch/description/header information, the easiest is to =
use
> git-mailinfo. If you want to do something more than that, then you need t=
o
> give additional information regarding what your end-goal is.
>
> -K



--=20
Tom Isaacson
