From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] revisions: refactor init_revisions and setup_revisions.
Date: Mon, 10 Mar 2008 09:49:21 +0100
Message-ID: <20080310084920.GA2798@artemis.madism.org>
References: <20080304231945.GC24131@artemis.madism.org> <7v63vvkplm.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="Q68bSM7Ycu6FN28Q";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Git ML <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 10 09:51:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JYdii-0007ey-B3
	for gcvg-git-2@gmane.org; Mon, 10 Mar 2008 09:50:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752425AbYCJItk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Mar 2008 04:49:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750920AbYCJItk
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Mar 2008 04:49:40 -0400
Received: from pan.madism.org ([88.191.52.104]:35652 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752424AbYCJItY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Mar 2008 04:49:24 -0400
Received: from madism.org (def92-2-81-57-219-236.fbx.proxad.net [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id DED3832CD8;
	Mon, 10 Mar 2008 09:49:22 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5055F16F; Mon, 10 Mar 2008 09:49:21 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Git ML <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7v63vvkplm.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76706>


--Q68bSM7Ycu6FN28Q
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 10, 2008 at 07:25:25AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
>     struct rev_info gains two new fields:
>    =20
>      * .def to store --default argument;
>      * .show_merge 1-bit field.
>    =20
>     The refactor consists of the following steps:
>    =20
>      * init_revisions now takes the --default argument to initialize .def
>        properly, instead of getting it through setup_revisions.
>    =20
>      * setup_revisions has been split in two:
>    =20
>        - parse_revisions that does (almost) only argument parsing, to be =
more
>          like what parse-options can do, and
>    =20
>        - setup_revisions that does the rest.
>    =20
>     Many places had no arguments to pass to setup_revisions, and those do=
n't
>     use parse_revisions at all.
>=20
> Conceptually, I like the split up into three, which are:
>=20
>  - initializes the structure (init_revisions);
>=20
>  - parses the user arguments (parse_revisions -- the naming could probably
>    be improved, though);

  Well, the goal is to replace that bit with a parse_options
structure/macro at some point, so the naming isn't really important.

>  - prepares the derived/derivable fields for the real work
>    (setup_revisions).
>=20
> Was there a particular reason you moved default to init_revisions() and
> not kept it with setup_revisions()?  All the callers of cmd_log_init()
> needs to say "I want to default to HEAD" because of it, instead of letting
> cmd_log_init() say it at only one place.  Also the caller needs to decide
> upfront before calling init_revisions() what the default should be.

  Yes, because the revision parsing has side effects on that default
parameter (the --default command line switch).

  We could of course have a .def member in the struct rev_info, and use
the one passed to setup_revisions then if it's still NULL, but it
doesn't really makes sense to me, and I don't really see a problem with
saying at init time that you'll default to "HEAD". Though if you really
dislike it that much, I squash a patch that does that on top of it.

> > Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> > ---
> >
> >   This is a required patch for revisions parse-optification that splits
> >   the logic of revision arguments parsing in parsing, and post-processi=
ng.
> >
> >   The aim is to replace parsing with parse-opt at some point.
> >
> >   The final version (using parse-options) will probably need more rework
> >   in revisions.[hc], but I'd like to avoid rebasing this patch over and
> >   over, and I'd be glad if it's merged now, as it's not _that_
> >   intrusive.
>=20
> >   I've been using a git with this patch for a week without issues.
>=20
> .... which is a nice assuring comment ;-)

  Well it has been even more since :)

> > @@ -892,8 +893,7 @@ static void add_grep(struct rev_info *revs, const c=
har *ptn, enum grep_pat_token
> >  		opt->regflags =3D REG_NEWLINE;
> >  		revs->grep_filter =3D opt;
> >  	}
> > -	append_grep_pattern(revs->grep_filter, ptn,
> > -			    "command line", 0, what);
> > +	append_grep_pattern(revs->grep_filter, ptn, "command line", 0, what);
> >  }
>=20
> Made me go "huh?".

  Huh yeah, sorry, that's totally spurious indeed.

> But everything else looked pretty mechanical conversion, and in that sense
> it is not that intrusive.
>=20
> Applying this to 'master' and then merging 'pu' shows that there are a few
> topics that are cooking that would conflict with this change.  Merging
> 'next' seems to go cleanly (I haven't checked the result), so it is not
> too bad for me to carrry this at this moment, if we were not this close to
> the rc freeze.  I dunno.

  Well I can wait longer, I'd just like to see it merged in a not too
far future, because I have to check for new places that would need
conversions at each reabase :) (though the init/setup_revisions
functions changed their number of arguments so I _think_ I should miss
none each time but =E2=80=A6).

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--Q68bSM7Ycu6FN28Q
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBH1PYQvGr7W6HudhwRAnplAJ9Fdds5v7tZgKgqbLRtP2WDR/YbaQCdEc45
5g8HMcYW//5w2iNLoosar04=
=YCUU
-----END PGP SIGNATURE-----

--Q68bSM7Ycu6FN28Q--
