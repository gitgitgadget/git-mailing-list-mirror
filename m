Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7B541F453
	for <e@80x24.org>; Thu, 21 Feb 2019 11:51:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727219AbfBULv4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Feb 2019 06:51:56 -0500
Received: from forward100p.mail.yandex.net ([77.88.28.100]:44913 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728172AbfBULvy (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 21 Feb 2019 06:51:54 -0500
X-Greylist: delayed 419 seconds by postgrey-1.27 at vger.kernel.org; Thu, 21 Feb 2019 06:51:51 EST
Received: from mxback3o.mail.yandex.net (mxback3o.mail.yandex.net [IPv6:2a02:6b8:0:1a2d::1d])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id A046F5982126;
        Thu, 21 Feb 2019 14:44:50 +0300 (MSK)
Received: from smtp2o.mail.yandex.net (smtp2o.mail.yandex.net [2a02:6b8:0:1a2d::26])
        by mxback3o.mail.yandex.net (nwsmtp/Yandex) with ESMTP id zoxgIE5fXb-iox4JJ2d;
        Thu, 21 Feb 2019 14:44:50 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1550749490;
        bh=SqBvCvAcQllPmY75Jf1kBveenoGETSEZ3B5dfAPsh5c=;
        h=Date:From:Subject:To:Cc:Message-Id:In-Reply-To:References;
        b=qxtBnguyIKDlp0bpO5s9JTdI8LzKRXzFBQbA/4ez+mTIcUjdfLJKA3k0l0L/4zGCO
         A5cXokGYKgRFyf9cqg43G6OAugSSpXGpHAXZg3WniQwOWEfcUQuutenLhaXCrHKKgK
         +9PtXaTeX7LLvS/SNT8rduwvyIvuuXdhT7khCsU0=
Authentication-Results: mxback3o.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by smtp2o.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id x0P84QfyVA-inU4cTXx;
        Thu, 21 Feb 2019 14:44:49 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
Date:   Thu, 21 Feb 2019 14:44:48 +0300
From:   Konstantin Kharlamov <hi-angel@yandex.ru>
Subject: Re: [PATCH] worktree add: sanitize worktree names
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Message-Id: <1550749488.30307.2@yandex.ru>
In-Reply-To: <CACsJy8AERM==LunYTszUf1Fb-uHPZLjkSE5x1T=0Ueqsvq3F_A@mail.gmail.com>
References: <1550500586.2865.0@yandex.ru>
        <20190221110026.23135-1-pclouds@gmail.com> <1550748525.30307.1@yandex.ru>
        <CACsJy8AERM==LunYTszUf1Fb-uHPZLjkSE5x1T=0Ueqsvq3F_A@mail.gmail.com>
X-Mailer: geary/remotes/upstream/master-0-gfbf2f307
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On =D0=A7=D1=82, Feb 21, 2019 at 2:38 PM, Duy Nguyen <pclouds@gmail.com> wr=
ote:
> On Thu, Feb 21, 2019 at 6:28 PM Konstantin Kharlamov=20
> <hi-angel@yandex.ru> wrote:
>>=20
>>=20
>>=20
>>  On =D0=A7=D1=82, Feb 21, 2019 at 2:00 PM,
>>  =3D?UTF-8?b?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?=3D Duy <pclouds@gmail.com>=20
>> wrote:
>>  > Worktree names are based on $(basename $GIT_WORK_TREE). They=20
>> aren't
>>  > significant until 3a3b9d8cde (refs: new ref types to make=20
>> per-worktree
>>  > refs visible to all worktrees - 2018-10-21), where worktree name=20
>> could
>>  > be part of a refname and must follow refname rules.
>>  >
>>  > Update 'worktree add' code to remove special characters to follow
>>  > these rules. The code could replace chars with '-' more than
>>  > necessary, but it keeps the code simple. In the future the user=20
>> will
>>  > be able to specify the worktree name by themselves if they're not
>>  > happy with this dumb character substitution.
>>  >
>>  > Reported-by: hi-angel@yandex.ru
>>  > Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
>>  > ---
>>  >  builtin/worktree.c      | 47
>>  > ++++++++++++++++++++++++++++++++++++++++-
>>  >  t/t2025-worktree-add.sh |  5 +++++
>>  >  2 files changed, 51 insertions(+), 1 deletion(-)
>>  >
>>  > diff --git a/builtin/worktree.c b/builtin/worktree.c
>>  > index 3f9907fcc9..ff36838a33 100644
>>  > --- a/builtin/worktree.c
>>  > +++ b/builtin/worktree.c
>>  > @@ -262,6 +262,46 @@ static void validate_worktree_add(const char
>>  > *path, const struct add_opts *opts)
>>  >       free_worktrees(worktrees);
>>  >  }
>>  >
>>  > +/*
>>  > + * worktree name is part of refname and has to pass
>>  > + * check_refname_component(). Remove unallowed characters to=20
>> make it
>>  > + * valid.
>>  > + */
>>  > +static void sanitize_worktree_name(struct strbuf *name)
>>  > +{
>>  > +     int i;
>>  > +
>>  > +     /* no ending with .lock */
>>  > +     if (ends_with(name->buf, ".lock"))
>>  > +             strbuf_remove(name, name->len - strlen(".lock"),
>>  > +                           strlen(".lock"));
>>  > +
>>  > +     /*
>>  > +      * All special chars replaced with dashes. See
>>  > +      * check_refname_component() for reference.
>>  > +      */
>>  > +     for (i =3D 0; i < name->len; i++) {
>>  > +             if (strchr(":?[]\\~ \t@{}*/.", name->buf[i]))
>>  > +                     name->buf[i] =3D '-';
>>  > +     }
>>  > +
>>  > +     /* remove consecutive dashes, leading or trailing dashes */
>>  > +     for (i =3D 0; i < name->len; i++) {
>>  > +             while (name->buf[i] =3D=3D '-' &&
>>  > +                    (i =3D=3D 0 ||
>>  > +                     i =3D=3D name->len - 1 ||
>>  > +                     (i < name->len - 1 && name->buf[i + 1] =3D=3D=20
>> '-')))
>>  > +                     strbuf_remove(name, i, 1);
>>  > +     }
>>  > +
>>  > +     /* last resort, should never ever happen in practice */
>>  > +     if (name->len =3D=3D 0)
>>  > +             strbuf_addstr(name, "worktree");
>>=20
>>  I assume this means a user have passed a zero-sized worktree name?=20
>> But
>>  zero-sized file/directory names are not possible anyway, would it=20
>> make
>>  sense to just return an error in this case?
>=20
> It could happen if you do "git worktree add .lock". The ".lock" part
> will be stripped out, leaving us with an empty string.

Ah, I see. Then, would it maybe make sense to just sanitize the ".lock"=20
out the same way as you did with special symbols, i.e. with dashes?

(I am not a git developer, so not sure if that's a good question, but I=20
would also question why ".lock" needs to be deleted. I guess git uses=20
the postfix internally, but why can't it be okay with "name.lock.lock")

=

