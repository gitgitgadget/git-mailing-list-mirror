Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26D5C4332F
	for <git@archiver.kernel.org>; Fri, 18 Nov 2022 20:00:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiKRUAZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Nov 2022 15:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRUAX (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Nov 2022 15:00:23 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E96FEC5B4E
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 12:00:21 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id f7so8597749edc.6
        for <git@vger.kernel.org>; Fri, 18 Nov 2022 12:00:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QljIPeyvmbYdzO6NDqQdtYUm9ztIT8Q48u7gS5ZQVwk=;
        b=kjRAWJhnHzovXGNwCyEZ+ljrrYNLO3hhScNOevuLadbUJ6KXUPpbmq9bQdcAtYEw6+
         jiH1nQUjsDU6hPGpMtawV793u+icB4hhZOyEVKE01w13nQ7gR/oi8cMc+wZZwWJUDGyQ
         ynrvjJW5470d90EhbsmKHIoxWMMEoPaKtsY9Orv+cj1biJRY1BPr/mxPQYnC5/xefIoZ
         /yJG95J6qo4NQ4XlMMZMA3cGU5az1LB7zxBlTC2FDgTSdculuWJEb5/umThb4pGPQ1qo
         mJRNmymUs8JKKlGyGDAXufK+9cYKuFlH0SmuFuXBSbjvMyisvuJ8hCQ9RD5s6XDH6SBQ
         jThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QljIPeyvmbYdzO6NDqQdtYUm9ztIT8Q48u7gS5ZQVwk=;
        b=V8kWCIok6EuQzf4b3WQ5OfwpFLKrK/z+Pae7giaUJhJGA0v0HVJcAaR0c6NL150b+s
         dGqTLyq1e/Ukhtid1BqNU1Vjj2vLunDU8Stm3AHOau0fM4LnnL8u1TxuAY50I6E6Xnnx
         6KReZZ/4zVFoDwDqkYjMcSWC99scg8yc9J9gn8dx0IR3SoVqH1/Z6N5+mqGfabMLrx0P
         3JQLm+W3ofVIU+g7qtKtxX3ih29cx/4Rbzic5Ds79ylAyaoZmmOiN4kxA3WVvEoPjnYP
         PJljsPePLKgOQlDR6cPB/e3IoXNs80gFrUgpYbE/JkMJ7qkJydnBefQ+YsrYHWLgXcCx
         P7Jg==
X-Gm-Message-State: ANoB5pnLmgnUX3njMeocw/vgOGsU4gkZAJMeT83KBhoGRygSEyyLWM5C
        fyDhp7UGEfImTaHWf7Ahmn1sfZJ5TjOGHBl5Jc0XjCsZ
X-Google-Smtp-Source: AA0mqf6lD42NlUA4iQC5LXz11LfDV18NWTpzKbXcQt2yQVwfbhNYCAEJcWGvlWAtEBwiYAU0yn1hJz5QDXnCK6DNayg=
X-Received: by 2002:aa7:c60b:0:b0:462:750b:bced with SMTP id
 h11-20020aa7c60b000000b00462750bbcedmr7262469edq.313.1668801620450; Fri, 18
 Nov 2022 12:00:20 -0800 (PST)
MIME-Version: 1.0
References: <CAJCbrz5+LC9g34x0E_2HAezFNaMGW7ECSA9iXpHgnAHGoQNzHA@mail.gmail.com>
 <221118.86iljcf3a9.gmgdl@evledraar.gmail.com>
In-Reply-To: <221118.86iljcf3a9.gmgdl@evledraar.gmail.com>
From:   Sergey Ivanov <icegood1980@gmail.com>
Date:   Fri, 18 Nov 2022 22:00:07 +0200
Message-ID: <CAJCbrz56=ozc6BCmh=M7Cxmk5Uqb12XrRALGzMVfhff2+QKCqg@mail.gmail.com>
Subject: Re: bug report: add/delete instead of rename
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Awesome, thanks!

=D0=BF=D1=82, 18 =D0=BD=D0=BE=D1=8F=D0=B1. 2022 =D0=B3. =D0=B2 21:53, =C3=
=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>:
>
>
> On Fri, Nov 18 2022, Sergey Ivanov wrote:
>
> > Thank you for filling out a Git bug report!
> > Please answer the following questions to help us understand your issue.
> >
> > What did you do before the bug happened?
> >
> > hard rename of files and directories via 'git mv' . git status before
> > commit for some related files:
> >
> > Changes to be committed:
> >   (use "git restore --staged <file>..." to unstage)
> >
> > new file:   sepolicy/private/file.te
> > renamed:    sepolicy/components/icl_infotainment.te ->
> > sepolicy/private/icl_infotainment.te
> > renamed:    sepolicy/common/hal_icl_infotainment.te ->
> > sepolicy/public/icl_infotainment.te
> > renamed:    sepolicy/common/file.te -> sepolicy/public/file.te
> >
> > Changes not staged for commit:
> >   (use "git add/rm <file>..." to update what will be committed)
> >   (use "git restore <file>..." to discard changes in working directory)
> > modified:   sepolicy/private/icl_infotainment.te
> > modified:   sepolicy/public/file.te
> >
> > What did you expect to happen?
> >
> > All related nodes are renamed during commit
> >
> > What happened instead? (Actual behavior)
> >
> > delete mode 100644 sepolicy/common/file.te
> > delete mode 100644 sepolicy/components/icl_infotainment.te
> > create mode 100644 sepolicy/private/icl_infotainment.te
> > create mode 100644 sepolicy/private/file.te
> > create mode 100644 sepolicy/public/file.te
> > rename sepolicy/{common/hal_icl_infotainment.te =3D>
> > public/icl_infotainment.te} (90%)
> >
> > What's different between what you expected and what actually happened?
> >
> > Instead of renaming 2 more pairs of create/delete formed.
> > It makes harder to see changes on gitlab UI after push.
> >
> > Anything else you want to add:
> >
> > Please review the rest of the bug report below.
> > You can delete any lines you don't wish to share.
>
> Git, unlike some other SCM's (e.g. SVN) doesn't track renames at
> all. I.e. it doesn't matter if you use "git mv", or just manually remove
> a file, "git add" that removal, add another file separately etc.
>
> So I think you're probably just running into that. I.e. "renames" are
> heuristically determined based on how similar the file is
> before/after. Likely you rewrote it more than the rename detection was
> willing to accept.
>
> But see the "git log" manual for details, as it's a heuristic you can
> tweak it, and e.g. set -M<n> for how similar two files should be before
> they're considered a rename.



--=20
Kind regards,
Sergey Ivanov
