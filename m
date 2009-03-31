From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 1/4] quote: implement "sq_dequote_many" to unwrap many args in one string
Date: Tue, 31 Mar 2009 07:04:52 +0200
Message-ID: <200903310704.52864.chriscool@tuxfamily.org>
References: <20090329114444.5579813c.chriscool@tuxfamily.org> <7vocvjjyqa.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:07:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWCB-0001C2-DB
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:07:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbZCaFF7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 01:05:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750866AbZCaFF7
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:05:59 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:34519 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750728AbZCaFF6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:05:58 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 215BC4C80DC;
	Tue, 31 Mar 2009 07:05:48 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 33E354C80D2;
	Tue, 31 Mar 2009 07:05:46 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vocvjjyqa.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115209>

Le lundi 30 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > @@ -92,6 +92,8 @@ char *sq_dequote(char *arg)
> >  		switch (*++src) {
> >  		case '\0':
> >  			*dst =3D 0;
> > +			if (next)
> > +				*next =3D 0;
>
> 	*next =3D NULL;
>
> >  			return arg;
> >  		case '\\':
> >  			c =3D *++src;
> >
> >
> >
> > diff --git a/quote.h b/quote.h
> > index c5eea6f..c2f98e7 100644
> > --- a/quote.h
> > +++ b/quote.h
> > @@ -39,6 +39,14 @@ extern void sq_quote_argv(struct strbuf *, const
> > char **argv, size_t maxlen); */
> >  extern char *sq_dequote(char *);
> >
> > +/*
> > + * Same as the above, but can unwraps many arguments in the same
> > string
>
> "can unwrap"
>
> > + * separated by space. "next" is changed to point to the next argu=
ment
> > + * that should be passed as first parameter. When there are no mor=
e
> > + * arguments to be dequoted, then "next" is changed to point to NU=
LL.
> > + */
> > +extern char *sq_dequote_many(char *arg, char **next);
> > +
> >  extern int unquote_c_style(struct strbuf *, const char *quoted, co=
nst
> > char **endp); extern size_t quote_c_style(const char *name, struct
> > strbuf *, FILE *, int no_dq); extern void quote_two_c_style(struct
> > strbuf *, const char *, const char *, int);
>
> I think dequote_many() is misnamed, as it only does one but has a
> slightly more helpful interface than the bare sq_dequote() when the
> caller is willing to dequote many.  It probably should be called
> dequote_step().

Yeah, you are right. But you might want to change the function name in =
the=20
patch title too.

Thanks,
Christian.
