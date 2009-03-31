From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/4] quote: add "sq_dequote_to_argv" to put unwrapped args in an argv array
Date: Tue, 31 Mar 2009 07:09:38 +0200
Message-ID: <200903310709.39034.chriscool@tuxfamily.org>
References: <20090329114452.b19a2f60.chriscool@tuxfamily.org> <7vhc1bjyl7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Mar 31 07:12:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoWGm-000226-Hw
	for gcvg-git-2@gmane.org; Tue, 31 Mar 2009 07:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753324AbZCaFKp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 31 Mar 2009 01:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752326AbZCaFKo
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 01:10:44 -0400
Received: from smtp6-g21.free.fr ([212.27.42.6]:49736 "EHLO smtp6-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943AbZCaFKo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Mar 2009 01:10:44 -0400
Received: from smtp6-g21.free.fr (localhost [127.0.0.1])
	by smtp6-g21.free.fr (Postfix) with ESMTP id DAC70E08080;
	Tue, 31 Mar 2009 07:10:34 +0200 (CEST)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp6-g21.free.fr (Postfix) with ESMTP id F1621E08016;
	Tue, 31 Mar 2009 07:10:31 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7vhc1bjyl7.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115211>

Le lundi 30 mars 2009, Junio C Hamano a =E9crit :
> Christian Couder <chriscool@tuxfamily.org> writes:
> > This new function unwraps the space separated shell quoted elements=
 in
> > its first argument and put a copy of them in the argv array passed =
as
> > its second argument.
> >
> > Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> > ---
> >  quote.c |   17 +++++++++++++++++
> >  quote.h |    2 ++
> >  2 files changed, 19 insertions(+), 0 deletions(-)
> >
> > diff --git a/quote.c b/quote.c
> > index 8cf0ef4..5b12a4a 100644
> > --- a/quote.c
> > +++ b/quote.c
> > @@ -120,6 +120,23 @@ char *sq_dequote(char *arg)
> >  	return sq_dequote_many(arg, NULL);
> >  }
> >
> > +int sq_dequote_to_argv(char *arg, const char ***argv, int *nr, int
> > *alloc) +{
> > +	char *next =3D arg;
> > +
> > +	if (!*arg)
> > +		return 0;
> > +	do {
> > +		char *dequoted =3D sq_dequote_many(next, &next);
> > +		if (!dequoted)
> > +			return 1;
>
> Usually we signal an error with a negative value, e.g. -1.
>
> > +		ALLOC_GROW(*argv, *nr + 1, *alloc);
> > +		(*argv)[(*nr)++] =3D xstrdup(dequoted);
>
> The original sq_dequote() interface takes advantage of the fact that =
the
> result of single-quote unquoting is always shorter than the original =
and
> it can rewrite the argument in-place to return the result.  I would
> expect dequote_step() to retain that trait and allow the caller to us=
e
> its return value without xstrdup().

I thought that it could be dangerous not to use xstrdup, as users of th=
is=20
function might want to free the strings in argv one by one. But I don't=
=20
care much.

Thanks,
Christian.
