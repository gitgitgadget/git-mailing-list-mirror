Return-Path: <SRS0=05is=6N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6B10C83004
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B427C206F0
	for <git@archiver.kernel.org>; Wed, 29 Apr 2020 16:18:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aldTgS6c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD2QR7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Apr 2020 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726774AbgD2QR5 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 29 Apr 2020 12:17:57 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72BFC03C1AD
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:17:57 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id t199so2303795oif.7
        for <git@vger.kernel.org>; Wed, 29 Apr 2020 09:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=No4F1mgSfPwjy+CMgPIc5T76gGelRf8iK/VyOafj+0A=;
        b=aldTgS6cLH/4YnuGAA1elaX9e1SGsLytlP60Y64BWA9Oos/nB89VCZuG3uzA+huTY9
         wS5t22adWGk8Pa/9HpYZGw0utBddOi6SoZysEr3OA9H8nWsIXkqQFIDYNn5w//tZHWXh
         Z3Cy+8c9HM19lVw/kHg004xa96aqLPCJFCVbQrGtT9KUyxOBEm25qDFbhKbX6SkR48iL
         EdEcoL6zc9QWrC/crLGKqg3XPElSk3tb0U2ab6DGynybc/sGC2dxK9QlvAhzF9tYR9bc
         rn7TAJbkRoqT4msH/TOgCLGbQF8bOiBk0YnQfb/TW2WgWw9AqE6Zw79FUvAJuDw0XFfj
         eTEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=No4F1mgSfPwjy+CMgPIc5T76gGelRf8iK/VyOafj+0A=;
        b=uDyd8cRx3zsdTrbGO3NNSL4xAa4koBH0tz2NL6w4w6O7hKI0IlkYZicWxwNKUODRqv
         NSHj4eHVETCkXoRnyU3AwZEgIWguhg1dlMjdCdtaK04Tj6eA1vT0lYZoWO67r6gd7+vf
         JUO/BsqFNZ6VU5LhpCi8E++b7w8o+tR8Jt+bWHRfjeZwjNJZJ/Ma8MWdjG9/+tvbKaUN
         X3Z8U86yDhVKvrMl+k0NMuFPH/GiWLZT6c8zM5wivacxiVrGWGuocBda3zhv0jc0G5cU
         X+1AhPT4owyGoKeuavDggnMhpznU1HDiBuR5lRjlCaEuxpw05l4DmigNhLVOGOJyAAN3
         B9Gg==
X-Gm-Message-State: AGi0PuY+J+I+OxZA/AR25DlMPQvPu/4Lg+U4yAeTOH927rgaMrBKZjb7
        RhEd/OFQn5Vzk4s6wd9WTYHb7bQrMO2Yfgwwmf8=
X-Google-Smtp-Source: APiQypK7ebjyh3FxvoEbXQbcVChvOekDiexfkN4wtc4PUimXpbFX3+9/TmbY+nb/SYOXaiigzr7nHORPC+D3Qu18P9Y=
X-Received: by 2002:aca:fdd5:: with SMTP id b204mr2326939oii.167.1588177077183;
 Wed, 29 Apr 2020 09:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200429093811.8475-1-shouryashukla.oo@gmail.com> <20200429093811.8475-2-shouryashukla.oo@gmail.com>
In-Reply-To: <20200429093811.8475-2-shouryashukla.oo@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 29 Apr 2020 09:17:43 -0700
Message-ID: <CABPp-BFJe81XD6Sd0OPoLGG5u2Vr4xoQrM2N=20eLscw0r8oXw@mail.gmail.com>
Subject: Re: [PATCH v4 2/4] gitfaq: changing the remote of a repository
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 29, 2020 at 2:38 AM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> Add issue in 'Common Issues' section which addresses the problem of
> changing the remote of a repository, covering various cases in which
> one might want to change the remote and the ways to do the same.
>
> Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
> ---
>  Documentation/gitfaq.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/Documentation/gitfaq.txt b/Documentation/gitfaq.txt
> index b1e758ffd1..7d294306f9 100644
> --- a/Documentation/gitfaq.txt
> +++ b/Documentation/gitfaq.txt
> @@ -232,6 +232,17 @@ I asked Git to ignore various files, yet they are still tracked::
>         it is advised to use `git rm --cached <file>`as well as make
>         the file pattern is mentioned in the '.gitignore'.
>
> +[[changing-remote-of-the-repository]]
> +I want to change the remote of my repository. How do I do that?::
> +       A remote is an identifier for a location to which Git pushes your
> +       changes as well as fetches any new changes from (if any). There
> +       might be different circumstances in which one might need to change
> +       the remote URL (see linkgit:git-remote[1]). To change the remote URL
> +       one may use: git remote set-url <name> <newurl>
> ++
> +One can list the remotes of a repository using `git remote -v` command.
> +The default name of a remote is 'origin'.

Looks good to me.  :-)
