Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 264EFC07E9B
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0516361C6D
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 18:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231363AbhGGSRi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 14:17:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbhGGSRg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 14:17:36 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 571C8C061574
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 11:14:54 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t24-20020a9d7f980000b029046f4a1a5ec4so3153696otp.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 11:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=1KGcpnsQ/z2h0F7JMvB8xTq4KrhfO9DkZhq0KvJxPnY=;
        b=Netm1k5Q++x+0PPpNgtaJoolgL2RR5v/DXJIDfzJs2c77vXecoR+DWPGb3p3Yql7gU
         2NkyPn3uW8YH3MSX+4wH59yqydaSlUR7zRZYvKbGYDqyoo4Vo9HCe+55yumxyv/F9Spr
         RmWbVJOE/ae/svjai5XiaGGmEZAyiOuxg9jhNAzUIrc8nbW/7oiK8UX40Ny1oM+tjUpK
         z67Mo/EDlVFfN2fncE7Xi9PLbK40f3EB6bGSc1XQ8QuRZsGTqGHxdLlWnXtwY0U8wYf6
         ydSOVqg4tZDyYsCr1bNiXTkQoefd2JaC9+7vUNRjoVw42QJJ2NCmLSTAruke4Eh2UGxB
         /qxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=1KGcpnsQ/z2h0F7JMvB8xTq4KrhfO9DkZhq0KvJxPnY=;
        b=XyySHb9bR4gZghD6cpPF4977F3pW43s9PLM+g6i7/N5ehBpIcoLsZMgRt4TTS9132P
         8t1wW5RlzesQnNX8/n2TUDo1YaCUH9XEe4qn1buBtMG86MilgpGBCq76JV99izVI7jOS
         n0McaZDeV/XJp+o5/0j6DGko+kbamn7uMIBQSgI2SscN6eePOIOCy/otSvW+UAmgKiaN
         9T2KpmbNDpqq+H3UUeavcBOsOaCC3iF8Z2A5iLg0gzkZ/dN/eilgKHrzLG91Nq/dCOnk
         0YgjmOsV8wyZPWw7GOPOGbkQD93fxMaLhIT2sb3xyDIE3s+vh3rc+6IZxHdlGFfrG3M0
         AAVg==
X-Gm-Message-State: AOAM533OCEiI6PlSx/RSdGK6Tpl8nAy+hV5AluIkuGeZ6Offw5+Nj4R6
        UMdN5iI5r81PIwF8YkSOJ4Jb+0pvLQDn/A==
X-Google-Smtp-Source: ABdhPJz+VKzO+b22mHwM19xGm7h+JIMlTQr5xeZr0PZRXfJELrCyB03zEo0OjBcPVsYYj5MKD+DGlw==
X-Received: by 2002:a9d:6185:: with SMTP id g5mr21129621otk.109.1625681693681;
        Wed, 07 Jul 2021 11:14:53 -0700 (PDT)
Received: from localhost (fixed-187-189-163-231.totalplay.net. [187.189.163.231])
        by smtp.gmail.com with ESMTPSA id 76sm2136214otj.28.2021.07.07.11.14.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 11:14:53 -0700 (PDT)
Date:   Wed, 07 Jul 2021 13:14:52 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Message-ID: <60e5ef1c1118_30143720837@natae.notmuch>
In-Reply-To: <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqk0mcy6g2.fsf@gitster.g>
 <b667ca37-b3cb-fce2-a298-63c3b839089d@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> Let's take a step back. How exactly is the word "branch" actually =

> defined? Well it does not matter.
> What matters is, how the word is used.
> What does a person mean, when they speak of the branch?

That is a good point.

> And the answer is, it's not always clear.

Indeed.

> In the above conversation, we use "branch" to speak of the "pointer to =
a =

> single commit".
> We do not include any commits, when speaking of the "branch".
> (And this is how it is used in the docs, as far as I can find)

This is how the term "branch" is used in git lingo.

> However a lot of people use "branch" to refer to the commits within.
> "Push a branch to a remote". That obviously means the objects (e.g. =

> commits) in the branch.
> The doc says (and yes I am getting a bit picky here)
>  >>> Updates remote refs using local refs, while sending objects =

> necessary to complete the given refs.
> "complete the given ref". The ref is given by the branch, and completin=
g =

> means afaik "to make something part of"
> Maybe a mistake made, because "branch" is (according to my observation)=
 =

> so commonly (mis-)used to include the objects.

Yes.

> Anyway, can we agree, that there are people who=C2=A0 (mistakenly) =

> use/understand "branch" as including the objects?
> Enough people to call it a "common mistake".
> If so, then we should not ignore this.

I wouldn't even call it a mistake.

Other SCMs, like Mercrual, do use this second meaning: the branch is the
specific commits that constitute that branch.

Can we really say user thinking that way is a mistake? I'm sure
Mercurial users would say git using the first notion is the a mistake.


It is a bigger mental load to be thinking in the two meanings at the
same time while writing the documentation, but if we really want to
reach the vast majority of users we do need to consider that the user
might be thinking in terms of the second notion.

-- =

Felipe Contreras=
