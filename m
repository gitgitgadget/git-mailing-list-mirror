From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 3/3] fetch: reduce duplicate in ref update status lines
Date: Sat, 4 Jun 2016 06:49:15 +0700
Message-ID: <CACsJy8BiriuKyrP=0RcbFcSC9WSfcfDeKa-GsKosWxOQdpUZ4g@mail.gmail.com>
References: <20160522112019.26516-1-pclouds@gmail.com> <20160603110843.15434-1-pclouds@gmail.com>
 <20160603110843.15434-4-pclouds@gmail.com> <xmqqlh2mp5qv.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 04 01:49:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8yqc-00051s-Cr
	for gcvg-git-2@plane.gmane.org; Sat, 04 Jun 2016 01:49:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751004AbcFCXtr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 3 Jun 2016 19:49:47 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:34086 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750967AbcFCXtp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Jun 2016 19:49:45 -0400
Received: by mail-io0-f177.google.com with SMTP id p194so95275554iod.1
        for <git@vger.kernel.org>; Fri, 03 Jun 2016 16:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=upj0f+PnNABujy+uCXzKD70W+OH3INO7S+2vSLjBO8U=;
        b=t8xP4FzsW5T6qIPwgEuv+4ly4U3yFv19Ogu5yFTPymSQENbGmn6mYcSG+npGW4oWId
         2CxaXo8aP8cQHv337MQVoKV4q1aXkRo6d3tPU31pzd5PS9D7aDBVA735vtklmn/MXdIJ
         nRVJHBSu+Uhy9SjjLBKzuHy5+3YL6JqOcsi0h0cprrkK6WLG344/OFC70emK13vGt2oZ
         1i58asOR1Szg6v8XkxQdpFxVJgT01IvfAtXkKWBFYGE5+7Dkn/TsJSj95Ic84AoDJWGz
         PZyIQ0vgtU8bZLc2LQaHEsOAoNAuMBcNOaTICkk3cJQ9ZXPNeSPzVcP4cEoFncojJA8t
         BjIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=upj0f+PnNABujy+uCXzKD70W+OH3INO7S+2vSLjBO8U=;
        b=XGbK7DYrlGj8iUkiQg6jN63HmmTC3FNCoupoj4TjNI7fzsNcmdA4hZMIPVYkjU4WCp
         wpOqHFq9pCPLhk+FMQ1u0dIC4w3xJlPqyujSLqZD3Zflax2CQpcRsJ9aR1K5HNf6X6QN
         kGfNZnMVGNcGdBepDbDAYrF+mCxekdSv4pO3pQgxSGfiZg/rxXCm2pxYKNriKgodKR56
         0MZz8DXdRVPmje2rCopjqaXhX7kqyCCN38AZQFePqw2AVdMneqpQwWhftqmE2eSuM6lr
         lNm02CdQDgmJGlf8oAw+1cOZvgLinyYq0qyau8zKj1sf7sDMCxz9hKLHeThIIn9uj3u+
         eUXg==
X-Gm-Message-State: ALyK8tJoHRWVrOnO58COG09E0NDsGoRjcHCx71sDgYhGzyPLrcq0kx62Di27Xv7txAwuezLY4TiPWOiQTmIZXA==
X-Received: by 10.36.108.76 with SMTP id w73mr3088690itb.63.1464997784924;
 Fri, 03 Jun 2016 16:49:44 -0700 (PDT)
Received: by 10.64.173.167 with HTTP; Fri, 3 Jun 2016 16:49:15 -0700 (PDT)
In-Reply-To: <xmqqlh2mp5qv.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296432>

On Sat, Jun 4, 2016 at 12:00 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
>
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
> > +static int common_suffix_length(const char *a, const char *b)
> > +{
> > +     const char *pa =3D a + strlen(a);
> > +     const char *pb =3D b + strlen(b);
> > +     int count =3D 0;
> > +
> > +     while (pa > a && pb > b && pa[-1] =3D=3D pb[-1]) {
> > +             pa--;
> > +             pb--;
> > +             count++;
> > +     }
> > +
> > +     /* stick to '/' boundary, do not break in the middle of a wor=
d */
> > +     while (count) {
> > +             if (*pa =3D=3D '/' ||
> > +                 (pa =3D=3D a && pb > b && pb[-1] =3D=3D '/') ||
> > +                 (pb =3D=3D b && pa > a && pa[-1] =3D=3D '/'))
> > +                     break;
> > +             pa++;
> > +             pb++;
> > +             count--;
> > +     }
> > +
> > +     return count;
> > +}
> > +
>
> Why do you need two loops, one going backward from the tail and then
> going forward toward '/'?

I wanted to check something else, then settled for slashes, but the
two loops remained.

> Wouldn't it be sufficient to keep track
> of the last slash you saw in a while scanning backwards?  I.e
> something along the lines of:
>
>         tail_a =3D a + strlen(a);
>         for (pa =3D tail_a, pb =3D b + strlen(b), slash_in_a =3D NULL=
;
>              a < pa && b < pb && pa[-1] =3D=3D pb[-1];
>              pa--, pb--) {
>                 if (*pa =3D=3D '/')
>                         slash_in_a =3D pa;
>         }
>         count =3D a + strlen(a) - slash_in_a;
>
> perhaps?

Actually, Jeff's suggestion about common prefix makes me realize, why
not reuse diff.c:pprint_rename()? Your {a -> b} idea came from that.
We may need some tweaking there because right now it will not show {
-> origin/}master.

> > diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
> > index 454d896..9a7649c 100755
> > --- a/t/t5510-fetch.sh
> > +++ b/t/t5510-fetch.sh
> > @@ -222,11 +222,11 @@ test_expect_success 'fetch uses remote ref na=
mes to describe new refs' '
> >       (
> >               cd descriptive &&
> >               git fetch o 2>actual &&
> > -             grep " -> refs/crazyheads/descriptive-branch$" actual=
 |
> > +             grep " -> refs/crazyheads/.descriptive-branch$" actua=
l |
> >               test_i18ngrep "new branch" &&
> >               grep " -> descriptive-tag$" actual |
> >               test_i18ngrep "new tag" &&
> > -             grep " -> crazy$" actual |
> > +             grep " -> .crazy$" actual |
> >               test_i18ngrep "new ref"
> >       ) &&
>
> These are somewhat cryptic ;-)

Yeah... too lazy to check if } needs to be quoted or not :D
--=20
Duy
