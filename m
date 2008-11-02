From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 3/3] git send-email: add --annotate option
Date: Sun, 02 Nov 2008 10:51:52 +0100
Message-ID: <20081102095152.GG4066@artemis>
References: <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225450632-7230-2-git-send-email-madcoder@debian.org> <1225450632-7230-3-git-send-email-madcoder@debian.org> <1225450632-7230-4-git-send-email-madcoder@debian.org> <7vskqa3atg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="gvF4niNJ+uBMJnEh";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Nov 02 10:53:45 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KwZeS-0000jH-Oa
	for gcvg-git-2@gmane.org; Sun, 02 Nov 2008 10:53:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYKBJv5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Nov 2008 04:51:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753258AbYKBJv4
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Nov 2008 04:51:56 -0500
Received: from pan.madism.org ([88.191.52.104]:53240 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753240AbYKBJvz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Nov 2008 04:51:55 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 3CED23B7E2;
	Sun,  2 Nov 2008 10:51:53 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 664A737A8B; Sun,  2 Nov 2008 10:51:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7vskqa3atg.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99836>


--gvF4niNJ+uBMJnEh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 02, 2008 at 06:23:55AM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > This allows to review every patch (and fix various aspects of them, or
> > comment them) in an editor just before being sent. Combined to the fact
> > that git send-email can now process revision lists, this makes git
> > send-email and efficient way to review and send patches interactively.
>=20
> Without your patches, you run format-patch (with or without cover), you
> use the editor of your choice to massage them and feed the resulting files
> to send-email.
>=20
> Only because you wanted to allow format-patch parameters to be given to
> send-email, you now need to also allow the messages to be massaged before
> they are sent out.
>=20
> Is it only me who finds that this series creates its own problem and then
> has to solve it?  What are we getting in return?

Actually my problem is that the current workflow is:

    $ git format-patch [rev-list]

    $ vim *.patch

    # massage patches

    $ git send-email [argument list too long to copy] --compose *.patch

    # struggle in vim to reopen the patches I'm about to comment to copy
    # the Subject lines and other similar stuff

    # answer to a lot of silly questions that git-s-e should guess from
    # the cover.

*also* I often have other patches in my repository, and this send-email
sometimes globs _too many_ patches and this is a big problem for me.
Basically that and all the '#' bits, and the number of commands to type
are what make me dislike git-send-email (but still use it since there
are no good alternatives yet that automate the task).

With my patch series, the workflow is as follows:

    $ git send-email --to <where> --annotate [rev-list]

    # as vim can open many files at once, I have the cover opened _and_
    # all the patches at once, or only the patch if there's one single
    # patch I can massage everything I want.

    # answer 'y' to the _single_ question git-s-e asks.
    # or 'n' if something doesn't fly.

Not only the command line is considerably shorter (even the --to can be
omited actually, but unlike --in-reply-to, it rarely changes and it's in
the history so...), but more importantly I can see what I will send, no
more '*.patch' that will bite me hard. I don't have to struggle opening
all the patches I'm interested in reading while I comment them in the
cover, and so on.


I mean you're mistaken when you say:
  ] Only because you wanted to allow format-patch parameters to be
  ] given to send-email, you now need to also allow the messages to be
  ] massaged before they are sent out.

Your causality is backwards. I _DO_ want git-send-email to allow me to
do the cover _and_ the massaging at once. It's actually the first patch
I wrote locally even if I reordered the series before sending for some
reason I don't remember. *Then* if you do that, there's little point in
having to perform git-format-patch in the first place, hence I wanted
the feature to let git-format-patch be run by git-send-email directly.

I don't know for others, but with those series, git-send-email is
_REALLY_ what I would have wanted it to be from day 1. The sole little
issues I can see are:
 * the To:/Cc:/Bcc:/other headers parsing directly from the cover, for
   that someone better skilled than me shall add a last patch to do that
   properly.

 * when you only edit one single patch, it doesn't do the From/To/Cc/...
   parsing and you'll get all the silly interactive questions again.
   That should probably addressed, but to be frank I care about this one
   less, because I send single patches directly from mutt. So it's not
   really my itch to scratch[0] ;)


  [0] WHO SAID I'M LAZY ? Yeah you in the back, I HEAR YA!
--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--gvF4niNJ+uBMJnEh
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkNeDgACgkQvGr7W6HudhwWCQCeLTlVP+AY/e2R4sjQ+dHlGFBU
QGsAniGHxnqxpRHI95LN+lCI18NiFSIu
=j4kV
-----END PGP SIGNATURE-----

--gvF4niNJ+uBMJnEh--
