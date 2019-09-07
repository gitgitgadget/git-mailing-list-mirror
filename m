Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D53B71F4B7
	for <e@80x24.org>; Sat,  7 Sep 2019 00:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393461AbfIGAfH (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Sep 2019 20:35:07 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:43317 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726261AbfIGAfH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Sep 2019 20:35:07 -0400
Received: by mail-vs1-f67.google.com with SMTP id u21so5212343vsl.10
        for <git@vger.kernel.org>; Fri, 06 Sep 2019 17:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fsT56yYxMVk2M1IlEQdw9LM876pxMVWobNmidTPEnR8=;
        b=U5AM0+sJ+BeQKIPjyT7rcwFEv5aimcgfrhMwQIZdfh//P4GIFF0X5IZheGbz/Bgmga
         shLKga07zisLQFI1JL7t/xhLU3LxVguxza3ml/3fTH9Lqn/tPamB0Cdtw6jLZRiQu4gJ
         bjXFt6pFBAj8zsLWwsdUV91c1nAaTipGmqHRLmhPZtlqT3iDOEuUkIwtqj3zopzQOTZH
         XagxIetCuLT2b4duG6kG7zUppUGlNQqa8m0/yuGliebkyFPiN/Swn2De8yC2gHYdY0xE
         hEoexXgkuuQAt3BB7mH7CZ0Tn9c7SMIZ+n/pTgPtKGOQodkZv3LyyLqGAyw3FR36Y8K7
         C+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fsT56yYxMVk2M1IlEQdw9LM876pxMVWobNmidTPEnR8=;
        b=WaSJamoGFWqF/4pJorilTMKz5g/WinkyXtMhqkhiCsmj1tmR1x0f4YFUEfa2exVSnp
         +is9QIOvAJPLsZbRqL8nvw4ep4KdxCmw/jTfPIeilVz6+TcPoYzt9TgIbme0sFSX9g+n
         albSCOO2R2nwiE8FXYl2+afjKQwx11J1krpvbp7rJv3Ku5NAnMd0ywaEeseWKF640eMN
         9qhmzMtlpzdZ6/496Z81cFytTlNTzKylyNNL/YGONitGUNo3++MfBJp72LrqT3/49+ZM
         YdOjNcmE325sutd7m6fnSeDfMD2Uhc1xHXh6/eZJUHzzP+tMYbZwPWnlC744gv4SzQt6
         pE3Q==
X-Gm-Message-State: APjAAAXIUdEDa9OndXvg1z36ev94rAkqbUFpFEykTf0/YobLjOmQqYtz
        Ltks1ArupoKCJpQRwjevx4gdq//z1QfauuKyQPw=
X-Google-Smtp-Source: APXvYqz7O3eRBnnkm5gdY9kXdC9GuCnseenm4Lze9qsgJFXQLNb04OkCVuMWQUPEcRZVBgqqFEJ89AHDBefVZ8KFgmI=
X-Received: by 2002:a67:e886:: with SMTP id x6mr6699346vsn.117.1567816506256;
 Fri, 06 Sep 2019 17:35:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190825185918.3909-1-szeder.dev@gmail.com> <20190905154735.29784-1-newren@gmail.com>
 <20190905154735.29784-13-newren@gmail.com> <20190905192744.GB32087@szeder.dev>
In-Reply-To: <20190905192744.GB32087@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 6 Sep 2019 17:34:55 -0700
Message-ID: <CABPp-BFOyVaK=hvWZtXfBmiSvf2DXf3c-GvPBt7kBu9wtCZSGg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 12/12] clean: fix theoretical path corruption
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        =?UTF-8?Q?Rafael_Ascens=C3=A3o?= <rafa.almas@gmail.com>,
        Samuel Lijin <sxlijin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 5, 2019 at 12:27 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Thu, Sep 05, 2019 at 08:47:35AM -0700, Elijah Newren wrote:
> > cmd_clean() had the following code structure:
> >
> >     struct strbuf abs_path =3D STRBUF_INIT;
> >     for_each_string_list_item(item, &del_list) {
> >         strbuf_addstr(&abs_path, prefix);
> >         strbuf_addstr(&abs_path, item->string);
> >         PROCESS(&abs_path);
> >         strbuf_reset(&abs_path);
> >     }
> >
> > where I've elided a bunch of unnecessary details and PROCESS(&abs_path)
> > represents a big chunk of code rather than an actual function call.  On=
e
> > piece of PROCESS was:
> >
> >     if (lstat(abs_path.buf, &st))
> >         continue;
> >
> > which would cause the strbuf_reset() to be missed -- meaning that the
> > next path to be handled would have two paths concatenated.  This path
> > used to use die_errno() instead of continue prior to commit 396049e5fb6=
2
> > ("git-clean: refactor git-clean into two phases", 2013-06-25), but my
> > understanding of how correct_untracked_entries() works is that it will
> > prevent both dir/ and dir/file from being in the list to clean so this
> > should be dead code and the die_errno() should be safe.  But I hesitate
> > to remove it since I am not certain.  Instead, just fix it to avoid pat=
h
> > corruption in case it is possible to reach this continue statement.
> >
> > Signed-off-by: Elijah Newren <newren@gmail.com>
> > ---
> >  builtin/clean.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/builtin/clean.c b/builtin/clean.c
> > index 6030842f3a..ccb6e23f0b 100644
> > --- a/builtin/clean.c
> > +++ b/builtin/clean.c
> > @@ -1028,8 +1028,10 @@ int cmd_clean(int argc, const char **argv, const=
 char *prefix)
> >                * recursive directory removal, so lstat() here could
> >                * fail with ENOENT.
> >                */
> > -             if (lstat(abs_path.buf, &st))
> > +             if (lstat(abs_path.buf, &st)) {
> > +                     strbuf_reset(&abs_path);
> >                       continue;
> > +             }
>
> I wonder whether it would be safer to call strbuf_reset() at the start
> of each loop iteration instead of before 'continue'.  That way we
> wouldn't have to worry about another 'continue' statements forgetting
> about it.
>
> It probably doesn't really matter in this particular case (considering
> that it's potentially dead code to begin with), but have a look at
> e.g. diff.c:show_stats() and its several strbuf_reset(&out) calls
> preceeding continue statements.

Ooh, I like that idea.  I think I'll apply that here.  I'll probably
leave diff.c:show_stats() as #leftoverbits for someone else, though I
really like the idea of fixing up other issues like this as you
suggest.
