Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9412C6FD19
	for <git@archiver.kernel.org>; Mon, 13 Mar 2023 11:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230155AbjCMLuT (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Mar 2023 07:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231497AbjCMLuJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2023 07:50:09 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CCE18B04
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 04:49:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id fm20-20020a05600c0c1400b003ead37e6588so10710051wmb.5
        for <git@vger.kernel.org>; Mon, 13 Mar 2023 04:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678708175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sm9u0xbAbvf5O1dRGmqzgZD69gqvXzJXtCD+IWI9ry0=;
        b=niaMNt8uXt74SdStmSrRg1LWkYO7Au36wK0VvwpOn3b3CAT2BAgbjgxVnScgnNlspk
         i9AjrJnDUd28VO+7FedBrqyx0JCwGTYGPOWdGUs9SpEAg9/ooPuuJzXHSZFa5AXSetyJ
         vfZS/CIrLOw/MvnlU9IO3iL90I00wPyaKXV9npwhMe3Of+9ywWwga/dxt/utv+rOKAL8
         CZaiwfvLhvUm6jzEkldKHwTlZkgCu0qiv537HHgWfON0HyWqIddufZ4m1qdW1MkTei2h
         6xVWUXIX9ty+sA55azy2tusjj6gOeaOzpchyFHLqHITnIJFRDhRQWN1CsCu/XuVtBP7M
         gQAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678708175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sm9u0xbAbvf5O1dRGmqzgZD69gqvXzJXtCD+IWI9ry0=;
        b=RLa6T1TbJ5QoZO1ieRwlDhnV23tDwwD32TSoekOHnoNjUpUfEi8XiATH1Xy8ohR3dI
         ChbdwB/rp/PQ7u/1Fn5xYe3dr0/NZOqRbfmQz20zxP4/WtI5cL+iVQe56QiS5uyz2q3O
         mni/t96MxzWQkiDh7a0eDVbLQFyNo0hikUKim7CtfhluGVVLCxQCUc/3X6qKWQfST6ol
         QROcIIsVVrjQ0ziyliwA4OLzd1Fwc/Ef1r845iNhes/TJgcxUpKHfvIU48PAHbtwqtOt
         9BBzGFQsQLD07F45iISA4P9aqNleFss5DtgNh6Xh3N9BuSf1d8DD5btYrNPTOWFjuqC4
         nCpw==
X-Gm-Message-State: AO0yUKUNumtgB73rLm2cpH1njlqNCwfjlspCpBpiDFfXzXMUJekiiG0F
        zXmIGZpNDNPaIjXD3DGCB3ukKMq7ZFV6OZ3wEgQ=
X-Google-Smtp-Source: AK7set/kIoXhzkNkE1sUM2KeggnM9S375/8yRK9hbMAMVNM3iarYQUjuurbzgaD5pfDe2QMxtcZt4mDEg0c380jcEcc=
X-Received: by 2002:a05:600c:9:b0:3df:97b0:ba00 with SMTP id
 g9-20020a05600c000900b003df97b0ba00mr3085143wmc.1.1678708174694; Mon, 13 Mar
 2023 04:49:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAAo-ADZBBRxSROeAwrA9o30Etf3QQhLCaWQJtVsChVwT-AbgTg@mail.gmail.com>
 <xmqqwn3pai2d.fsf@gitster.g>
In-Reply-To: <xmqqwn3pai2d.fsf@gitster.g>
From:   Ilia Pozhilov <ilyapoz@gmail.com>
Date:   Mon, 13 Mar 2023 13:49:23 +0200
Message-ID: <CAAo-ADbUf1UqSE1EFf1yOY5Mhu0R5_NQuK8agBpOn60zgpWnVQ@mail.gmail.com>
Subject: Re: Track git blame through two unrelated histories
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thank you very much for this! It worked, I found the corresponding
commits and did exactly as you suggested. Now blames just work!

Now I will need to figure out if this is push'able to github, but even
at this stage it's incredibly useful, I love blames!

On Thu, Mar 9, 2023 at 8:35=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Ilia Pozhilov <ilyapoz@gmail.com> writes:
>
> > So let's say I add two remotes and fetch all the commits, but they
> > look like this:
> >
> > A->B-> .... . . . -> Z    history1
> >
> > 1 -> 2 -> ..... -> 0 history2
> >
> > and file contents in commits Z and 1 are exactly the same, but the
> > commits themselves are completely unrelated for git.
>
> You mean you want to pretend that history "2 -> ... -> 0" was built
> on top of Z?  Here I am assuming that time flows from left to right
> in the picture.
>
> If so, you should be able to graft the histories together, perhaps?
>
> Totally untested but something like
>
>         $ git replace --graft 1 Z
>
> based on my reading of "git help replace" should allow you to
> pretend that Z happened immediately before 1.
>
