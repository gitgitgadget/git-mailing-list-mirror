Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C106BEB64D8
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 15:21:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjFUPVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 11:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233262AbjFUPVl (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 11:21:41 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACAEE2126
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 08:19:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b466073e19so67039461fa.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 08:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687360777; x=1689952777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mPixbbdOCX9MJN4LB/ot3Mmjg77IZ31In4E+htlSfFo=;
        b=YyJnnhkfCsCeEpGLvuZd2ecsZXKGAh081iPMsyNzoqHUJIYctkAlS3nKeSxIOouS4T
         iVuwCdnpt1ZNx+nGXLpheiVcshn0aSxJe+Vj2nPWkm/WfN8etxTCb4f6t2aVZCGdxmp/
         rY+ZhR3KevcAH5x/tCG/vEzRHQ4F48mdscPi2sEIAsXMSSBZ0b3u9lJaeqtVjw1t7z3Q
         CYtcqyMzenh2lzQZOtQOjpzyzq8DSp4FMyXDWffUM+62K/xQKjcSa4bplR7K5V9KtJC1
         6gzMD7HD/DJFFcPSqN2I+soIsat60Ln+L0QY+xhfd1TK04FweJ5qSRb3eF+cwhg8Oq+L
         cNzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687360777; x=1689952777;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mPixbbdOCX9MJN4LB/ot3Mmjg77IZ31In4E+htlSfFo=;
        b=Fbd22/1JoyorPGpTCdV3bXOG6eC25BulCNDAj46LhvnYmvnUA84Ak5p4U0LBzffuwm
         fMLzJNvlMnZj94sOj19QXzI3oiseA2bmIYmARi7LahrvfyXV+jGL2hU/WU3P2XUOI5an
         fQtDOI5GPtobCdnUAC8HE737ZlHK2/PLm/lsroR+LqqySr+IQr3/nc3QwfDRJsvz8rz1
         eRfnsxE03PXNLCxREF4gFwEXQn1aesQnC7ff6x9mysXlY1xyQw/9cXQ8bZHDRKjQnnBn
         uEMdW+AeNLB/lGnCO0kHjqR6yIL0AXFEw5o14w5Qn5el93lUidTP+WAj+3uQdBlmLryc
         MsuQ==
X-Gm-Message-State: AC+VfDwPdKdwM51f+nRaq3u484x+lL0NHTNSoa+/jC9kV+I6O8a/Wprv
        ZhlX79xVsyFQh24GnbbeEe8a0xHXoj3xgdN/Ux0=
X-Google-Smtp-Source: ACHHUZ4jiuBmQTMPBlzcdxfr0g+u84HbbUVH+ukaiOgqh4wJamzjqsE96gPweK0HIUwfQzUycy4hEfn74jiI5zabe/Y=
X-Received: by 2002:a2e:7209:0:b0:2b4:5a0b:9297 with SMTP id
 n9-20020a2e7209000000b002b45a0b9297mr10417467ljc.29.1687360776535; Wed, 21
 Jun 2023 08:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1549.git.1687327684909.gitgitgadget@gmail.com> <20230621081754.GA803861@coredump.intra.peff.net>
In-Reply-To: <20230621081754.GA803861@coredump.intra.peff.net>
From:   =?UTF-8?Q?Guido_Mart=C3=ADnez?= <mtzguido@gmail.com>
Date:   Wed, 21 Jun 2023 08:19:24 -0700
Message-ID: <CA++DQUkM-o4_zR=oK=kF=wE5youvQ4iQrw2KyTTGhNbcUViTdg@mail.gmail.com>
Subject: Re: [PATCH] ls-files: add an --exclude-links option
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?Guido_Mart=C3=ADnez_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff, thanks for reviewing!

On Wed, Jun 21, 2023 at 1:17=E2=80=AFAM Jeff King <peff@peff.net> wrote:
>
> On Wed, Jun 21, 2023 at 06:08:04AM +0000, Guido Mart=C3=ADnez via GitGitG=
adget wrote:
>
> > From: =3D?UTF-8?q?Guido=3D20Mart=3DC3=3DADnez?=3D <mtzguido@gmail.com>
> >
> > Add an option to exclude symlinks from the listed files. This is useful
> > in case we are listing the files in order to process the contents,
> > for instance to do some text replacement with `sed -i`. In that case,
> > there is no point in processing the links, and it could even be
> > counterproductive as some tools (like sed) will replace the link with a
> > fresh regular file.
> >
> > This option enables a straightforward implementation of a `git sed`:
> >
> >     #!/bin/bash
> >     git ls-files --exclude-links -z | xargs -0 -P $(nproc) -- sed -i -e=
 "$@"
>
> This invocation would likewise have a problem with gitlink entries (for
> submodules). I think what you really want is not "exclude symlinks" but
> "show only regular files".
Ah, thanks! I hadn't realized that. I suppose my patch should also
come with a few tests, including one with submodules.

> There is no option for that, but you can do
> it by grepping modes from "-s", like:
>
>   git ls-files -s | grep '^100[67]' | ...
>
> You do unfortunately have to then pull the filename out of the rest of
> the line, and since we didn't use "-z", it will be quoted (and using
> "-z" makes it hard to use tools like grep and sed). A mild application
> of perl works, though:
>
>   git ls-files -s |
>   perl -0ne 'print if s/^100(644|755).*?\t//' |
>   xargs -0 ...
My perl-foo is not as strong, so I didn't realize perl could do this
kind of thing :) Still it may be desirable for ls-files to do the
filtering itself?

> So I dunno. That is not exactly pretty, but if you were hiding it in a
> "git sed" alias or script, it's not so bad.
>
> If we were to add an option to ls-files, it would make more sense to me
> to allow the user to include/exclude by mode or possibly naming the type
> (e.g., "f" for regular files, "l" for symbolic links, etc, which matches
> "find"). And then allow inclusion/exclusion similar to the way that
> git-diff's --diff-filter option works.
Yes, this is totally reasonable. I'll try to get that working here and resu=
bmit.

Thanks,
Guido

>
> -Peff
