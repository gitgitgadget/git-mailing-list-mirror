From: Hugo Mildenberger <Hugo.Mildenberger@namir.de>
Subject: Re: [PATCH] Quote LF in urls git fetch saves in FETCH_HEAD
Date: Wed, 13 May 2009 14:39:32 +0200
Message-ID: <200905131439.33907.Hugo.Mildenberger@namir.de>
References: <200905112208.21017.Hugo.Mildenberger@namir.de> <7vws8l7w0d.fsf@alter.siamese.dyndns.org> <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 14:40:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4DlM-0002Sw-Jh
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 14:40:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756700AbZEMMkf convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 May 2009 08:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756351AbZEMMkf
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 08:40:35 -0400
Received: from mx02.qsc.de ([213.148.130.14]:59182 "EHLO mx02.qsc.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756018AbZEMMke convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 May 2009 08:40:34 -0400
Received: from localhost (port-87-234-69-58.dynamic.qsc.de [87.234.69.58])
	by mx02.qsc.de (Postfix) with ESMTP id 3584016C000E
	for <git@vger.kernel.org>; Wed, 13 May 2009 14:40:33 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <81b0412b0905122306w4ed41bdiab073a05587fab55@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119044>

Am Mittwoch, 13. Mai 2009 schrieb Alex Riesen <raa.lkml@gmail.com>
> 2009/5/13 Junio C Hamano <gitster@pobox.com>:
> > Alex Riesen <raa.lkml@gmail.com> writes:
> >
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 for (i =3D 0; i < url_=
len; ++i)
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 if ('\n' =3D=3D url[i])
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fputs("\\n", fp);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 else
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fputc(url[i], fp);
> >> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 fputc('\n', fp);
> >
> > This ad-hoc quoting feels _very_ wrong. =C2=A0Who is on the reading=
 side and
> > how does it unquote?
>=20
> git fmt-merge-msg. It does not unquote. The url is purely information=
al here.
> OTOH, the \n shouldn't be in url text at all, so treat it as slightly
> less annoying
> warning.
>=20
> > If it is just informational use only, then it might make more sense=
 to
> > drop this ugly "quoted \n" silently. =C2=A0I dunno.
>=20
> That'd mean to loose the information completely. Which is just as bad
> as putting the LF in the url in the first place.
> --

This stray linefeed is not information, but pure contamination. Thus it=
=20
would be much better to simply strip it off. And besides from the fact =
that=20
git apply rejects this patch (fatal: corrupt patch at line 6), I think =
it would=20
also not handle the equally wrong repository directory name on disk, wh=
ich=20
then possibly leads to subsequent make failures (as it actually happend=
 in=20
the case I described earlier here.) Why not just return to your origina=
l idea,=20
which proposed testing the repository name against a regular expression=
=20
describing a forbidden set of characters (which is "\n", currently) and=
 then=20
terminate with a clear message?
