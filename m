From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: libgit2 - a true git library
Date: Fri, 31 Oct 2008 18:47:45 +0100
Message-ID: <20081031174745.GA4058@artemis.corp>
References: <20081031170704.GU14786@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="mxv5cy4qt+RJ9ypb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Oct 31 18:49:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kvy7L-0006zQ-Pj
	for gcvg-git-2@gmane.org; Fri, 31 Oct 2008 18:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750867AbYJaRru (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Oct 2008 13:47:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751016AbYJaRru
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Oct 2008 13:47:50 -0400
Received: from pan.madism.org ([88.191.52.104]:54882 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750842AbYJaRrs (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Oct 2008 13:47:48 -0400
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 6A07D3B622;
	Fri, 31 Oct 2008 18:47:46 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 53A9F5EE23B; Fri, 31 Oct 2008 18:47:45 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20081031170704.GU14786@spearce.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99613>


--mxv5cy4qt+RJ9ypb
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 31, 2008 at 05:07:04PM +0000, Shawn O. Pearce wrote:
> During the GitTogether we were kicking around the idea of a ground-up
> implementation of a Git library.  This may be easier than trying
> to grind down git.git into a library, as we aren't tied to any
> of the current global state baggage or the current die() based
> error handling.
>=20
> I've started an _extremely_ rough draft.  The code compiles into a
> libgit.a but it doesn't even implement what it describes in the API,
> let alone a working Git implementation.  Really what I'm trying to
> incite here is some discussion on what the API looks like.

I know this isn't actually helping a lot to define the real APIs, but we
should really not repeat current git mistakes and have a really uniform
APIs, meaning that first we must decide:
  * proper namespacing (e.g. OBJ_* looks like failure to me, it's a way
    too common prefix);

  * proper public "stuff" naming (I e.g. realy like types names -- not
    struct or enum tags, that I don't really care -- ending with _t as
    it helps navigating source.

  * ...

And write that down _first_. It's not a lot of work, but it must be
done. Working on a library really asks us to create something coherent
for our users.


Second, if we want this to be a successful stuff, we all agree we must
let git be able to use it medium term. That means that when git-core is
experimenting with new interfaces, it will probably need to hook into
some more internal aspects of the library. This is a problem to solve
elegantly, linking git against a static library won't please a lot of
vendors and linux distributions, and exporting "private" symbols is a
sure way to see them being abused.


Last but not least, I believe parts of git-core are currently easy to
just take. For example, any code *I* wrote, I hereby give permission to
relicense it in any of the following licenses: BSD-like, MIT-like,
WTFPL.

For example, on parse-options.c, git blame yields:

    git blame -C -C -M parse-options.c|cut -d\( -f2|cut -d2 -f1|sort|uniq -c
	 16 Alex Riesen
	  6 Jeff King
	 47 Johannes Schindelin
	 12 Junio C Hamano
	 19 Michele Ballabio
	  1 Nanako Shiraishi
	  1 Olivier Marin
	395 Pierre Habouzit

Okay, arguably parse-options.c in libgit quite doesn't makes sense
(though it can help bringing some kind of uniformity to other git
ecosystem tools built on libgit but that's not the point I'm trying to
make), I'm sure this kind of pattern where it's likely to be easy to
relicense code happens to some source files. Nicolas already said I
think that he was okay with relicensing his work too e.g.

Maybe we could, in parallel to that, contact people who "own" code in
the core parts of git to ask them where they stand, and see if that can
free some bits of the code. Attached is the current owners of the non
builtin-* C, non header, code in git core, got using this on top of
next:

for i in *.c; do
  case $i in
  builtin-*)
    continue;;
  *)
    git blame -C -C -M $i|cut -d\( -f2|cut -d2 -f1;;
  esac
done

and doing  sort | uniq -c | sort -n >owners on it is attached.
Interestingly, it yields around 200 contributors "only" but more
interestingly, only 41 people "own" more than 100 lines of code in
there, and 23 more if you add people with more than 50. IOW, it wouldn't
be absurd to mail those roughly 65 people ask them what they think of
relicensing their work (for those where it's needed because of current
GPL-ness of the code) and see what result it yields. Worst case we lost
like 2 or 3 weeks, best case scenario, we can reuse some bits of git to
reimplement some of the algorithms verbatim.



--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline; filename=owners
Content-Transfer-Encoding: quoted-printable

16818	Junio C Hamano
8892	Linus Torvalds
4978	Johannes Schindelin
3664	Shawn O. Pearce
2938	Nick Hengeveld
2857	Nicolas Pitre
2455	Daniel Barkalow
1660	Pierre Habouzit
1294	Adam Simpkins
1126	Mike McCormack
1110	Ren=C3=A9 Scharfe
861	Jeff King
653	Lukas Sandstr=C3=B6m
564	Miklos Vajna
531	Johannes Sixt
495	Alex Riesen
400	Martin Koegler
332	Petr Baudis
310	Jon Loeliger
263	Timo Hirvonen
236	Brandon Casey
231	Lars Hjemli
221	Sergey Vlasov
200	H. Peter Anvin
181	Dmitry Potapov
165	Mike Hommey
163	Matthias Lederhofer
158	Robert Shearman
155	Andreas Ericsson
151	YOSHIFUJI Hideaki
147	Franck Bui-Huu
137	Christian Couder
127	Stephan Beyer
127	David Reiss
123	Paolo Bonzini
120	Steffen Prohaska
115	Scott R Parish
113	Bradford C. Smith
109	Kristian H=C3=B8gsberg
105	Heikki Orsila
100	Andy Whitcroft
93	Jim Meyering
90	Wincent Colaiuta
90	Julian Phillips
87	Stephen R. van den Berg
85	Marco Costalba
82	David Rientjes
76	Sven Verdoolaege
75	Eric Wong
72	Edgar Toernig
71	Ramsay Allan Jones
69	Martin Waitz
68	Mark Wooding
68	Eric W. Biederman
67	Geert Bosch
64	Michal Ostrowski
64	David Kastrup
63	Theodore Ts'o
63	Alexandre Julliard
61	Brian Downing
59	Alexander Gavrilov
58	Andy Parkins
56	Jon Seymour
52	Carlos Rica
47	Sean Estabrooks
44	Dana L. How
43	J. Bruce Fields
41	Ping Yin
40	Florian Forster
38	Tilman Sauerbeck
38	Serge E. Hallyn
38	Kay Sievers
38	Jason Riedy
37	Dustin Sallings
35	Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy
35	Luiz Fernando N. Capitulino
35	Clemens Buchacher
34	Fredrik Kuivinen
33	Pavel Roskin
33	Lars Knoll
32	Josef Weidendorfer
32	Jonas Fonseca
30	Peter Eriksen
28	Jay Soffian
26	Gr=C3=A9goire Barbier
25	Adam Roben
24	Marius Storm-Olsen
24	Luben Tuikov
24	J=C3=BCrgen R=C3=BChle
24	Bryan Larsen
24	Anders Melchiorsen
23	Pieter de Bie
23	Nanako Shiraishi
23	Michael S. Tsirkin
23	Brian Hetro
22	Paul Mackerras
22	Jens Axboe
20	Thomas Rast
19	Paul Collins
19	Matthias Kestenholz
19	Joachim Berdal Haga
19	David Woodhouse
18	Mark Levedahl
17	Michele Ballabio
15	Gerrit Pape
14	Sam Vilain
13	Olivier Marin
13	Adam Brewster
12	SZEDER G=C3=A1bor
12	Kai Ruemmler
12	Govind Salinas
11	Sasha Khapyorsky
11	Raphael Zimmerer
11	Brian Gernhardt
10	Steven Grimm
10	Holger Eitzenberger
10	Dmitry V. Levin
10	Dennis Stosberg
10	Avery Pennarun
9	Willy Tarreau
9	Santi B=C3=A9jar
9	Robin H. Johnson
9	James Bowes
9	Bj=C3=B6rn Steinbrink
8	Markus Amsler
8	Jonathan del Strother
8	Johan Herland
8	Chris Parsons
8	Boyd Lynn Gerber
7	Robin Rosenberg
7	Paul Serice
7	Matt Kraai
7	Jason McMullan
7	Frank Lichtenheld
7	Christopher Li
6	Qingning Huo
6	Han-Wen Nienhuys
6	David Soria Parra
6	Bj=C3=B6rn Engelmann
6	Ariel Badichi
5	Sam Ravnborg
5	Peter Hagervall
5	Paul T Darga
5	Michal Vitecek
5	James Bottomley
5	Dotan Barak
5	David S. Miller
5	Andr=C3=A9 Goddard Rosa
4	Uwe Kleine-K=C3=B6nig
4	Teemu Likonen
4	Samuel Tardieu
4	Patrick Welche
4	Michael Spang
4	Matthieu Moy
4	Joey Hess
4	Finn Arne Gangstad
4	Dmitry Kakurin
4	Carl Worth
4	Arjen Laarhoven
3	Steven Drake
3	Matthew Ogilvie
3	Li Hong
3	Josh Triplett
3	Jakub Narebski
3	Eygene Ryabinkin
3	Brian Gerst
2	Tom Prince
2	Todd Zullinger
2	Shawn Bohrer
2	Matthias Urlichs
2	Martin Sivak
2	Krzysztof Kowalczyk
2	Kevin Ballard
2	Jan Harkes
2	Fernando J. Pereda
2	Eyvind Bernhardsen
2	Deskin Miller
2	Charles Bailey
2	Andrew Ruder
2	Amos Waterland
2	Alp Toker
2	Alexey Nezhdanov
1	Yann Dirson
1	Tuncer Ayaz
1	Tony Luck
1	Timo Sirainen
1	Thomas Harning
1	Thomas Glanzmann
1	Sverre Hvammen Johansen
1	Stephan Feder
1	Simon Hausmann
1	Salikh Zakirov
1	Ryan Anderson
1	Rutger Nijlunsing
1	Randal L. Schwartz
1	Peter Valdemar M=C3=B8rch
1	Paul Eggert
1	Patrick Higgins
1	Mika Kukkonen
1	Matt Draisey
1	Marco Roeland
1	Lars Doelle
1	Jerald Fitzjerald
1	Jean-Luc Herren
1	Jan Andres
1	Ingo Molnar
1	David Symonds
1	David Meybohm
1	Darrin Thompson
1	Bryan Donlan
1	Brad Roberts
1	Blake Ramsdell
1	Benoit Sigoure
1	Adeodato Sim=C3=B3

--wRRV7LY7NUeQGEoC--

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkLRL8ACgkQvGr7W6HudhzSmQCdF33ndtYAbqlYeDlFyZ8eOu0C
80QAnj2SR8asSEuvCSuf5eZXQwRa9RFj
=ZGuD
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
