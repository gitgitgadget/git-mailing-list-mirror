Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E25C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 19:21:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237198AbjFBTVs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 15:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237206AbjFBTVp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 15:21:45 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE044E5D
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 12:21:40 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f81ffc9065so33061cf.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 12:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685733700; x=1688325700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xG2/DfIkZJtHsdw4M+qG8dEGdI2QqSBbWfiDfSfBIxE=;
        b=vmVS/uFQH4iXlhH+qKFoAIVpKslH1WTH2+2FQf2xrwZ+a4srGbKor6NqUaZJ+Nog49
         0ZdcYOWMwy5owtZe+fw1tT23Yh3elbzaE0zBPeshN9f2mjv8Dq7hQ1v1kaNysTnOxApB
         Ug6DwuMbKXiIK5/Ffq2VBTJWHt+263SdGRy0AC5IHhhNKwFBlLF8mYSm+Bqu19sqTaiB
         wT4dyHCoMGzTodXVkITYbbKwReluOXEqEfi8ehONSvLFSq1NRjZAnI2Zu77N4eYh5gwK
         Rt+vZVjbWRwhJfsx/xAu8LOuROEgAaFCjNzU51n2euWJvuxe4iwk7W5pbRXDpkA2/ekD
         ZXwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685733700; x=1688325700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xG2/DfIkZJtHsdw4M+qG8dEGdI2QqSBbWfiDfSfBIxE=;
        b=lYmWLv8XFNQi/o4qNnasYfbUPYTkb9rAnHuk/dOfs/5Q3cOswuY0kBmbpYaR0RSw+O
         g1a2L8eS5y28HvWivGv16cVy07PQEQvNkSbIiasblZpX42clE9WcovOOq38K8PiGVMIv
         OFYolEpzeODtyNooIALq8ZM05RYhoBTzX5xdcgJbldQYALz3ZxM68+WIH7R6MqbKXMyd
         vdUoCdPavHpuiOlOXSsodvK9VK1PLaDymcCcflZ9gnWp5sx55tnFxhxGLBFNv7aAsf8n
         xSbPZ2dFExA2p+HN+Ig9ofqntKFCqizxqbO1zPrpnu3+kp+2FG4n0+90PqzeL14sCWwa
         d9nw==
X-Gm-Message-State: AC+VfDx6tZqt80dgN2QmjcWC2lt6yMSpJTXnEsAWWyuZQ0sZwgRW2Tv4
        g4lOD779AbJLrEdpF/aCNlHtzdwKEl3WUUoUUfLE3A==
X-Google-Smtp-Source: ACHHUZ6Ra6F6XRJtIiFBcB6/b43jBJcE89cDB/Kp7ULrB1ZIijOlAMsBVN3BdSdpmh6IoWl9X5TDRQFmQsVxVQdlhtY=
X-Received: by 2002:ac8:5b8f:0:b0:3ef:4319:c6c5 with SMTP id
 a15-20020ac85b8f000000b003ef4319c6c5mr244295qta.19.1685733699635; Fri, 02 Jun
 2023 12:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230602184557.1445044-1-asedeno@google.com> <CAPig+cS0sGYiCa9Og-f-UL=pZo9OAz587UsdX69BCf7hraHWFA@mail.gmail.com>
In-Reply-To: <CAPig+cS0sGYiCa9Og-f-UL=pZo9OAz587UsdX69BCf7hraHWFA@mail.gmail.com>
From:   =?UTF-8?Q?Alejandro_Sede=C3=B1o?= <asedeno@google.com>
Date:   Fri, 2 Jun 2023 15:21:28 -0400
Message-ID: <CALVMLfLw4P=VnBOYA-WbHRNPZiAiO05h4k+cSvPJuaqkjgp5ew@mail.gmail.com>
Subject: Re: [PATCH] statinfo.h: move DTYPE defines from dir.h
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?Alejandro_R=2E_Sede=C3=B1o?= <asedeno@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That is a valid question, and it's another typo. I meant name-hash.c.

-Alejandro

On Fri, Jun 2, 2023 at 3:06=E2=80=AFPM Eric Sunshine <sunshine@sunshineco.c=
om> wrote:
>
> On Fri, Jun 2, 2023 at 3:03=E2=80=AFPM Aleajndro R Sede=C3=B1o <asedeno@g=
oogle.com> wrote:
> > These definitions are used in cache.h, which can't include dir.h
> > without causing name-info.cc to have two definitions of
> > `struct dir_entry`.
>
> What is `name-info.cc`?
>
> > Both dir.h and cache.h include statinfo.h, and this seems a reasonable
> > place for these definitions.
> >
> > This change fixes a broken build issue on old SunOS.
> >
> > Signed-off-by: Alejandro R. Sede=C3=B1o <asedeno@mit.edu>
> > Signed-off-by: Alejandro R Sede=C3=B1o <asedeno@google.com>
