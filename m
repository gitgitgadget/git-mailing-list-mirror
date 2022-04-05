Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08DCBC4167E
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 21:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383793AbiDEVqE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 17:46:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457515AbiDEQDT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 12:03:19 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD6C7C6E
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 08:58:01 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w21so20035002wra.2
        for <git@vger.kernel.org>; Tue, 05 Apr 2022 08:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zXNzj/I/ZNlakt2Eh6XaA5lSSR0hjCbFzgmm8EynDlQ=;
        b=mmFDF97fCVCEagOP6bepeSFUJzwrhLsNquIM/P95InCvMf4wJ3/1B8RGC4U8y3RR7D
         UdFCyfnT2NY2LkKpbWD/ffwI0BdiKDW85b3BJVEfrFOJ5TGwM3tr4wvdpSjiS6XkTLKf
         I0lri5hGh1rienlCzHDd1mO4DzqM+XZ1zy588ilskNwZJeAOE1l9TyuBxi9cvupXByMb
         0Bj+DmmcbRapQL69BeqkCIlz1iX0FGNE7x+r/2gAtlhx4z1loOqL+8VSXZF97i19xm35
         yiILMiCA8AfyfyU1Sta9NL3f2C44mvJwi07kerWvLo0+ahozLeyjoM8xblwE+lQ//tGZ
         LhnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zXNzj/I/ZNlakt2Eh6XaA5lSSR0hjCbFzgmm8EynDlQ=;
        b=QT2QlzdK3cmuXCnNg76D7sQ5dz8KL54mf85lgb1iN4JAcb3sGeper/Fep3LM89w5Bk
         uYIXnQHcxVAjQ3+43JFAeqakqaoGIzI7djEvdXIj9lPZdGN4dkYbCuNUotVPRo0o5E0m
         3yOfHIOTaenMVapdY86kLbqxDV+3G6IR7+P7pCJM68fQOT3IrKGQmrqeWK4NVJwWOpDe
         9OqwfOOtwsR/8LT8Nwli3GBd+k6KrAuJwtsINldgRkPTz3QMiKOFYQXG57HVxZ8ywjbS
         Yj5QmWEVVUsHP3Bj30vgWhCehddAJxrLG2ftrjAaWr8uhYRquXLByrCRP0SwsOXE9ZRJ
         lbfQ==
X-Gm-Message-State: AOAM531e+9ncgrvGaLRlDlW08HnGgfXhwyY+GMSK+nb8hWPRRBjWzLBa
        z3iNtn/enOJixjKnlj/OdkKsaq7Gf7X6L/1AXz4=
X-Google-Smtp-Source: ABdhPJzlb5onUiKZKprjWB0MOFFQRTfrZ5I0hSnrka88hiWqdPFI/0HfAgI48+d/telP4n7YybYHTeD7B7asIWLnjN8=
X-Received: by 2002:adf:e110:0:b0:205:b611:7a6b with SMTP id
 t16-20020adfe110000000b00205b6117a6bmr3268071wrz.20.1649174280110; Tue, 05
 Apr 2022 08:58:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAB1LBmvX4kv3yqSZ+X4Ozkb9esUem3U1JY48kWVi_Eef78Sk=Q@mail.gmail.com>
 <CAB1LBms3F1EGswxF9mO=JrmWmj4XFncv4ZrkAy-dvOHdVrkwLQ@mail.gmail.com> <d650bb90-df94-eeab-0684-ee447e080ad6@web.de>
In-Reply-To: <d650bb90-df94-eeab-0684-ee447e080ad6@web.de>
From:   Laurent Lyaudet <laurent.lyaudet@gmail.com>
Date:   Tue, 5 Apr 2022 17:57:48 +0200
Message-ID: <CAB1LBms-Urzbx=Q=9Ydvsrgx=6si+FwZa09MEz9zCHRser8iuw@mail.gmail.com>
Subject: Re: Git has two ways to count modified lines
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Eckhard_S=2E_Maa=C3=9F?= <eckhard.s.maass@googlemail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le sam. 2 avr. 2022 =C3=A0 23:55, Ren=C3=A9 Scharfe <l.s.r@web.de> a =C3=A9=
crit :
>
> Am 02.04.22 um 18:49 schrieb Laurent Lyaudet:
> > Le mer. 16 mars 2022 =C3=A0 19:08, Laurent Lyaudet
> The option --break-rewrites controls rewrite detection.  Check out its
> description in the documentation of git diff to see how to use it.
Hello everyone,
Thanks Ren=C3=A9, I checked and now I understand how it works :)
> > But the two other questions remains :
> >> How comes git has two ways to count modified lines ?
> > i.e. What is (was) the purpose of this rewrite counting (when coded) ?
>
> Rewrite detection is meant to improve the diff of a file whose content
> was replaced with something very different.  Instead of lots of hunks
> containing lines that add and remove unrelated stuff, separated by empty
> lines etc. that the diff algorithm matches between the sides even though
> they are also unrelated, a rewrite diff removes all the old lines en
> bloc and then adds all the new ones, which is easier to read in that
> case.
It makes sense to produce diffs simpler to understand.
From my experience, humans are better than computers at knowing when
to "break-rewrites" (or see that a line was moved, etc.) .
I have dreamed about hinting the diff tools for many years,
but I'm more used to simply accept what the computer produces as its
diff(s) and have my own analysis that does not match.
Maybe for git 10.0, someone will add metadata in commits for human
optimized diffs :)
For applying patches, it is useless but for understanding code change, it h=
elps.
At least, it is a good mental exercise.
Just in case, if someone cares, in my notebook I note the following counts =
:
- non empty and not space only created lines
- empty or space only created lines
- modified lines (non space created or deleted character)
- space modified lines (but I should split this category between space
presentation, and space bug related (Yes you can correct bug by
changing only spaces, most of the time in strings)
- moved lines :
   - as is
   - with space modification
   - with non-space modification
- non empty and not space only deleted lines
- empty or space only deleted lines

> >> How can I make git output again the same numbers than just after commi=
t ?
>
> git show --stat --break-rewrites
Thanks :)

Best regards,
    Laurent Lyaudet
