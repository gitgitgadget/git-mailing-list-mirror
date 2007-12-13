From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFH] convert shortlog to use parse_options
Date: Thu, 13 Dec 2007 21:53:05 +0100
Message-ID: <20071213205305.GA5423@artemis.madism.org>
References: <20071213055226.GA3636@coredump.intra.peff.net> <20071213090604.GA12398@artemis.madism.org> <20071213091055.GA5674@coredump.intra.peff.net> <20071213093536.GC12398@artemis.madism.org> <7vbq8u4ho8.fsf@gitster.siamese.dyndns.org> <20071213180347.GE1224@artemis.madism.org> <7vzlwe1jeb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="/9DWx/yDrRhgMJTb";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 13 21:53:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2v3k-0007du-9x
	for gcvg-git-2@gmane.org; Thu, 13 Dec 2007 21:53:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751816AbXLMUxK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 15:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759528AbXLMUxI
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 15:53:08 -0500
Received: from pan.madism.org ([88.191.52.104]:60228 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbXLMUxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 15:53:07 -0500
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id 82CC12E894;
	Thu, 13 Dec 2007 21:53:06 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 81A28A831; Thu, 13 Dec 2007 21:53:05 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <7vzlwe1jeb.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68190>


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 13, 2007 at 07:31:24PM +0000, Junio C Hamano wrote:
> So I am not entirely opposed to your version, nor I am claiming my
> suggestion is better.  However, I just thought that "some parameters you
> MUST stick to the flag" might create confusion to the end users, and I
> wanted to see if others can come up with a less confusing alternative.
> And the way I did so was to keep the discussion going by stirring the
> pot a bit.

I understand that, and I hope I wasn't sounding harsh at all, I was just
debating. Note that I don't like the asymmetry of some options needing a
specific syntax whereas all the rest is lax. It's cumbersome at the very
least. Though, to me there is one gain: when the user uses the
--long-opt=3Dfoo version you are _sure_ about what he meant. When you have
--long-opt foo you're not.

Your proposal tries hard to do what the user meant, with a reasonable
chance of being wrong. My proposal is on the conservative side, but
generate totally incomprehensible errors: if you do
  $ git describe --abbrev 10 HEAD
with my patch you get a not very nice
  fatal: Not a valid object name 10
as an answer. which is kind of going back to the kind of situations
parse-options is trying to avoid in the first place. I wouldn't be
really annoyed by my solution if we were able to generate an
intelligible error message instead. But guess what, if we were able to
do so, we would be able to fix the ambiguity in the first place *sigh*.


So maybe the thing would be to sleep on a it a bit and not taking any of
my patches yet (not even in pu) and let people think. It's not a major
problem, though it's one that must be fixed before 1.5.4 because we
don't want a broken option parser ever be released.


Note that there is another path, that would be to disallow mixing of
options with real arguments, and have an option separator (though with
`--` having a distinct meaning in git, that wouldn't be that easy). But
sadly some git commands already allowed such a thing, so imposing it in
parse-options would be backward incompatible for those. And I believe
many people are attached to this feature anyways.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--/9DWx/yDrRhgMJTb
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHYZuxvGr7W6HudhwRAua7AJ4mP3d2eK2eTg8QkKuaHJuwkg7ChgCfYrQ4
44l/oCOolSlpN3wRdUaNRrs=
=k4sc
-----END PGP SIGNATURE-----

--/9DWx/yDrRhgMJTb--
