From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv4] git apply: option to ignore whitespace differences
Date: Tue, 1 Sep 2009 11:53:54 +0200
Message-ID: <cb7bb73a0909010253j530814cdqe67872d226b5623a@mail.gmail.com>
References: <1249384609-30240-1-git-send-email-giuseppe.bilotta@gmail.com> 
	<7vocpvvxaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Felipe Contreras <felipe.contreras@gmail.com>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 11:54:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiQ4F-0002D7-Po
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 11:54:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753533AbZIAJyO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Sep 2009 05:54:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753431AbZIAJyN
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 05:54:13 -0400
Received: from mail-fx0-f217.google.com ([209.85.220.217]:60500 "EHLO
	mail-fx0-f217.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753438AbZIAJyN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 05:54:13 -0400
Received: by fxm17 with SMTP id 17so3379669fxm.37
        for <git@vger.kernel.org>; Tue, 01 Sep 2009 02:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=RRiWsTSstJVyB1/Xa3WJg23eHQFMnLa1psgaUi+3I4Y=;
        b=SDuJ9BDnoYvHsPi3kJ4yC15U4sPbDoUwwm9MU0sW7utEPPO1JAuRIrr4iLCiEjoilh
         /nbN23crXDmYkunnWGRUd6sRFqG+G/OHtheGM+yEP6zgdXcXOgzMX6mSq3M+wbIFECQn
         SC8uiuFYM7MWRR2+xFTlxXlE1gVu3fCjfF4O8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=U9RbmcFskZswZ5EL/SGlteBkds/KkgdqYOHLvzGSd5HB3AsH/fN5FhWKvQRCP+A5HU
         C7TnWSxZ+CiIfS8+k5bYg5ZDDx+ETV0KVb2jImcYfq5Cz+zm/wyaJ2rDGMZxYK9zgAfr
         8UNtWJvS2R1TeZzMXbAJ1E8RmGUkS5G7tc39g=
Received: by 10.204.19.142 with SMTP id a14mr5435521bkb.1.1251798854500; Tue, 
	01 Sep 2009 02:54:14 -0700 (PDT)
In-Reply-To: <7vocpvvxaw.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127529>

On Tue, Sep 1, 2009 at 11:17 AM, Junio C Hamano<gitster@pobox.com> wrot=
e:
>
> Why do you need imglen[] vla here? =A0IOW, can't the above be simply =
like
> this?
>
> diff --git a/builtin-apply.c b/builtin-apply.c
> index ae11b41..c8372a0 100644
> --- a/builtin-apply.c
> +++ b/builtin-apply.c
> @@ -1874,20 +1874,18 @@ static int match_fragment(struct image *img,
> =A0 =A0 =A0 =A0if (ws_ignore_action =3D=3D ignore_ws_change) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t imgoff =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t preoff =3D 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t postlen =3D postimage->len;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t imglen[preimage->nr];
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < preimage->nr; i++) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0size_t prelen =3D prei=
mage->line[i].len;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 size_t imglen =3D img->=
line[try_lno+i].len;
>
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 imglen[i] =3D img->line=
[try_lno+i].len;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!fuzzy_matchlines(
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 img->bu=
f + try + imgoff, imglen[i],
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preimag=
e->buf + preoff, prelen))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!fuzzy_matchlines(i=
mg->buf + try + imgoff, imglen,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 preimage->buf + preoff, prelen))
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return=
 0;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if (preimage->line[i].=
flag & LINE_COMMON)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 postlen=
 +=3D imglen[i] - prelen;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 imgoff +=3D imglen[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 postlen=
 +=3D imglen - prelen;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 imgoff +=3D imglen;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0preoff +=3D prelen;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/*
> @@ -1899,9 +1897,9 @@ static int match_fragment(struct image *img,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0fixed_buf =3D xmalloc(imgoff);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0memcpy(fixed_buf, img->buf + try, imgo=
ff);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (i =3D 0; i < preimage->nr; i++)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preimage->line[i].len =3D=
 imglen[i];
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 preimage->line[i].len =3D=
 img->line[try_lno+i].len;

Yep, I think that would do it. I'm not sure why I was doing it that
other way. Maybe a leftover from when I was still getting confident
with the code and I hadn't yet found the var that held the initial
match line, or something like that.

--=20
Giuseppe "Oblomov" Bilotta
