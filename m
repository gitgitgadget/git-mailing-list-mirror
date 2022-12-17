Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CBB7C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 14:47:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLQOrI (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 09:47:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiLQOrG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 09:47:06 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB24512AB6
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 06:47:04 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id y18-20020a0568301d9200b0067082cd4679so3028705oti.4
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 06:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rn+F6sDKsvRxTgKDxNpWc1scFnCuYm6HEcfaZPmP8Rk=;
        b=IzFPHuMCpqbclDiaJzg25WugcVbTMymOzVOYp+Y+/wRE7LlrPPqFRTK5YxWCepxxBp
         pOZiF5gn3q613WeAKmZOgNEh/RrdxMiQx8eoq8kTuDrcZROxUXUm6oRKht2slMOt7NBP
         sLmoy6XMoJqYyrLSqeEnwpskKRfYZmqIRNtq9w8Xa35btiYe2IQ/R5BSNLaDmzG60fD9
         qePvN32fX87xFvvb+A7Wa+rWnZWf7X1fFiSGIdpgj3TzNzCJi+SUnkeYREtp2iT0J/Iy
         aUbc0uF4TCqYjWXC1bnfC9ZmagwMMXXdnO/fy51UvaIQ0+8X9RVdF+cEvcGDxwhrfM/C
         MkmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rn+F6sDKsvRxTgKDxNpWc1scFnCuYm6HEcfaZPmP8Rk=;
        b=mIUxc1HVAJqyAfKWdT3LxiApXzLqNeLVzqCQ8Yshuw3GsdKzv7cBvOKibRrZHC5dZJ
         H9VTZYahb3H6oQKOpmZRoNclTgf4fom+V4pmUU8OIxy7Ju0eRwyPASjC5j2PTHoDOxEf
         35P61Yvuzlh2+EGg+2gK3e/OGoGoBWT8NDlQ7Tjuq41ryPSpkbTJndemzNs3BEgXk62L
         oZs4wSKJR/RWxTee0q2I4LpTGTzTeMoVyzJ20+JcVX67QV5qOvnI4DomSw/xVp7BRhDi
         JEs2B5Dk5NqWidg785+pCmonf3mO5aWOhK7bPcnAAKP+EBZdFoCRhZzQjeeM6UqsKslB
         WwqA==
X-Gm-Message-State: ANoB5pnlkpFUYOPfmXHDzeMmpZ7jQyQy2ApeiIm83TzOAXyh9WX/YhCK
        Gk7luQ/iX/9sUZzvqiap9ILARTnzLq3Dt6FLbqnuh+3TJFI=
X-Google-Smtp-Source: AA0mqf57EJZOQwp5rfoy+Yau+iVD2Gj4F1mH60oQdBV9GCgzFk+B7PxvwWiuqcxYAEkVxTvH9XnJh2Trmnz0io3AmYs=
X-Received: by 2002:a9d:550d:0:b0:66d:6909:e477 with SMTP id
 l13-20020a9d550d000000b0066d6909e477mr49565820oth.114.1671288424062; Sat, 17
 Dec 2022 06:47:04 -0800 (PST)
MIME-Version: 1.0
References: <20221216093552.3171319-1-karthik.188@gmail.com> <221216.86k02r1fcl.gmgdl@evledraar.gmail.com>
In-Reply-To: <221216.86k02r1fcl.gmgdl@evledraar.gmail.com>
From:   Karthik Nayak <karthik.188@gmail.com>
Date:   Sat, 17 Dec 2022 15:46:37 +0100
Message-ID: <CAOLa=ZR2XUX1EPgG0g_UgZo3wjuZLWthJerztqUL4+qCJKb=KA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] check-attr: add support to work with revisions
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, toon@iotcl.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 16, 2022 at 5:30 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Fri, Dec 16 2022, Karthik Nayak wrote:
>
> > v1: https://lore.kernel.org/git/20221206103736.53909-1-karthik.188@gmai=
l.com/
> > v2: https://lore.kernel.org/git/CAOLa=3DZSsFGBw3ta1jWN8cmUch2ca=3DzTEjp=
1xMA6Linafx9W53g@mail.gmail.com/T/#t
>
> Could you please set the In-Reply-To header appropriately in the future,
> so that each version of this series isn't in its own disconnected
> thread?
>

I didn't know, will do this from next time!

> > This series aims to add a new flag `-r|--revisions` to git-check-attr(1=
) which
> > allows us to read gitattributes from the specified revision.
>
> I didn't look at the v2, but expected at least the short form to be gone
> here re
> https://lore.kernel.org/git/CAOLa=3DZTSzUh2Ma_EMHHWcDunGyKMaUW9BaG=3DQdeg=
tMqLd+69Wg@mail.gmail.com/;
>

Right, I was open to it, but since there wasn't any confirmation, I
didn't go forward with it.
Will remove it from the next version.

> I'm still more partial to the alternate suggestion I had in
> https://lore.kernel.org/git/221207.86lenja0zi.gmgdl@evledraar.gmail.com/;
> I'm not sure what you meant in your reply at
> https://lore.kernel.org/git/CAOLa=3DZQua8TfApCdzoK06_2fkWb4ZCfWewXKOSaXno=
1fqFSq2A@mail.gmail.com/
> (sorry about not following up at the time) with:
>
>         "when being consistent we need to be fully consistent,
>         i.e. <revision>:<path>, tweaking this slightly to be
>         <revision>:<attr> is worse than breaking consistency."
>
> Yes, it would, but isn't that by definition the case with any
> proposal?
>

I'm not opposing the proposal, rather stating my opinion on it. To go
over my reply

I'm only saying that most users of Git are accustomed to the `<revision>:<p=
ath>`
syntax and now breaking that only in one command to be `<revision>:<attr>` =
seems
a bit odd, from the user experience point of view.

> We don't have a way to refer to an attribute (or all attributes for -a)
> for a given revision/path, the task of this series is to invent such a
> syntax.
>
> So we could invent that as this series currently does with:
>
>         git check-attrs --revision <rev> <attr>... <path>...
>
> Or, as I suggested:
>
>         git check-attr [<rev>:]<attr>... -- <path>...
>
> Or whatever. Here I'm not saying that one is better than the other, but
> advocating for one on the basis of consistency doesn't make sense to me,
> this is new syntax.
>

I see what you mean, but I was referring to consistency around how differen=
t
options are used in other git commands.

Mainly that most commands treat the second section after `<rev>:` to
be a path, now
adding a new option where the section after `<rev>:` to be an
attribute, might be a
bit confusing.

> I think what you mean is that because the log family uses "<rev>:<path>"
> we should not come up with a syntax that looks anything like
> "<lhs>:<rhs>"., as the "<lhs>" in the mind of some users is going to be
> "<rev>", and the "<rhs>" is "<path>", so it would be confusing to have
> it be "<attr>" here, and have the "<path>..." come after the "--".
>

Exactly.

> I'm not convinced by that. From refspecs to e.g. "git log"'s own "-L" we
> have little mini-syntaxes in various places that use this sort of colon
> notation. I find it more elegant than "--revision".
>
> It's fine if you disagree, I'm just trying to understand the basis of
> the disagreement.
>

I don't disagree. I think it's healthy to have this discussion,
especially since we're
adding a new option and this is the right time. I'm all ears and finally wa=
nt to
get the best solution.

--=20
- Karthik
