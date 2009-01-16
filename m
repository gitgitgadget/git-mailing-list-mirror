From: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
Subject: Re: [PATCH take 3 0/4] color-words improvements
Date: Thu, 15 Jan 2009 19:42:55 -0600
Message-ID: <200901151942.55742.bss@iguanasuicide.net>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de> <alpine.DEB.1.00.0901151940170.3586@pacific.mpi-cbg.de> <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1681099.yMzEaNeqYh";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,
	Teemu Likonen <tlikonen@iki.fi>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org
To: Santi =?utf-8?q?B=C3=A9jar?= <santi@agolina.net>
X-From: git-owner@vger.kernel.org Fri Jan 16 02:44:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LNdl5-0000oO-2a
	for gcvg-git-2@gmane.org; Fri, 16 Jan 2009 02:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753584AbZAPBnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Jan 2009 20:43:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753358AbZAPBnB
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Jan 2009 20:43:01 -0500
Received: from eastrmmtao102.cox.net ([68.230.240.8]:40597 "EHLO
	eastrmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753344AbZAPBnA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Jan 2009 20:43:00 -0500
Received: from eastrmimpo03.cox.net ([68.1.16.126])
          by eastrmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090116014257.QIHG8735.eastrmmtao102.cox.net@eastrmimpo03.cox.net>;
          Thu, 15 Jan 2009 20:42:57 -0500
Received: from localhost ([72.204.50.125])
	by eastrmimpo03.cox.net with bizsmtp
	id 41iw1b00B2i4SyG021iwVX; Thu, 15 Jan 2009 20:42:57 -0500
X-Authority-Analysis: v=1.0 c=1 a=PdaMveHqyoEA:10 a=Fq1VQ0LPAAAA:8
 a=YrOn8CkxHAgwBcmbliMA:9 a=4yJAJIThgL-dcUHicDwWh1ApAmYA:4 a=cdoSpQTWPqQA:10
 a=T3brmoaXcPoA:10 a=LY0hPdMaydYA:10 a=6gS1wYE9ivNxE8TmPowA:9
 a=79tHGbjNoo7xKPMe6NQopPil9vEA:4 a=rPt6xJ-oxjAA:10
X-CM-Score: 0.00
Received: from bss by localhost with local (Exim 4.69)
	(envelope-from <bss@iguanasuicide.net>)
	id 1LNdjb-000Cmo-Uh; Thu, 15 Jan 2009 19:42:55 -0600
User-Agent: KMail/1.9.9
In-Reply-To: <adf1fd3d0901151610p41930ee2gfc7259aee7e15d73@mail.gmail.com>
X-Eric-Conspiracy: There is no conspiracy
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105901>

--nextPart1681099.yMzEaNeqYh
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thursday 15 January 2009, Santi B=E9jar <santi@agolina.net> wrote=20
about 'Re: [PATCH take 3 0/4] color-words improvements':
>It may be ok and logical, but for me it is not what I want. Mmaybe I
>don't really undestand what I want or is a crazy idea but here it is
>anyway:

The discussion above is mildly theoretical.  I don't imagine someone is=20
going to intentionally mark 98% of a file as non-words, which is basically=
=20
what you are doing with a regex of "a+".

>a) primary words are those with alphanumerics (or a regex)

regex: [[:alnum:]]+

example words: matrix ball I a
example non-words: don't haven't

>b) secondary "words" are the other non-whitespaces characters (in this
>case "[]{} and ,"

regex: []{}[,]

example words: [ , }
example non-words: [] ball 147

>c) whitespaces are cruft.
>
>(having two regexp to specify what is a words but they cannot mix).

Combine regex with '|' to get:
[[:alnum:]]+|[]{}[,]

>If everything works as I think (it's late night :-) with the above two
> lines:
>
>matrix[a,b,c]
>matrix{d,b,c}
>
>the word diff would be
>
>matrix<RED>[<GREEN>{<RED>a<GREEN>d<RESET>,b,c<RED>]<GREEN>}<RED>

=46or this specific case, the regex "[^[:space:]]" by itself should work,=20
although it would end up being a character-by-character diff.

The regex you built from your description "[[:alnum:]]+|[]}{[,]" would also=
=20
give the same diff.  However:
=2Ddont
+don't
gives a word diff of:
don't
not:
don<RED>'<RESET>t
because "'" is not recognized as part of any word it is considered=20
ignorable.

There was a patch that included documentation that most users should add=20
"|[^[:space:]]" to the end of their regex, to capture all non-whitespace=20
characters that are not otherwise part of a word as individual,=20
single-character "words".
=2D-=20
Boyd Stephen Smith Jr.                     ,=3D ,-_-. =3D.=20
bss@iguanasuicide.net                     ((_/)o o(\_))
ICQ: 514984 YM/AIM: DaTwinkDaddy           `-'(. .)`-'=20
http://iguanasuicide.net/                      \_/    =20

--nextPart1681099.yMzEaNeqYh
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAklv5h8ACgkQ55pqL7G1QFk08ACgiRGoOEOI5Jcs492toQgKNnDj
MpAAnA+uwH9fhOO7IPovvOqW7xylD5Ib
=OJI7
-----END PGP SIGNATURE-----

--nextPart1681099.yMzEaNeqYh--
