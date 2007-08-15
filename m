From: martin f krafft <madduck@madduck.net>
Subject: using .gitmodule as default (was: git submodule init and redundant
	data in .gitmodules/.git/config)
Date: Thu, 16 Aug 2007 00:29:07 +0200
Message-ID: <20070815222907.GA7395@piper.oerlikon.madduck.net>
References: <20070815162005.GA18463@piper.oerlikon.madduck.net> <20070815163822.GC1070MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8t9RHnE3ZwKMSgU+"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 00:29:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILRMb-00006B-2m
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 00:29:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760451AbXHOW3M (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Aug 2007 18:29:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762493AbXHOW3M
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Aug 2007 18:29:12 -0400
Received: from armagnac.ifi.unizh.ch ([130.60.75.72]:48670 "EHLO
	albatross.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760451AbXHOW3L (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Aug 2007 18:29:11 -0400
Received: from localhost (albatross.madduck.net [127.0.0.1])
	by albatross.madduck.net (postfix) with ESMTP id D81DF895F77
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:29:08 +0200 (CEST)
Received: from albatross.madduck.net ([127.0.0.1])
	by localhost (albatross.madduck.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 25853-10 for <git@vger.kernel.org>;
	Thu, 16 Aug 2007 00:29:08 +0200 (CEST)
Received: from wall.oerlikon.madduck.net (77-56-87-151.dclient.hispeed.ch [77.56.87.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wall.oerlikon.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by albatross.madduck.net (postfix) with ESMTP id 89AAB895D92
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:29:08 +0200 (CEST)
Received: from piper.oerlikon.madduck.net (piper.oerlikon.madduck.net [192.168.14.3])
	by wall.oerlikon.madduck.net (Postfix) with ESMTP id E5C8E9F171
	for <git@vger.kernel.org>; Thu, 16 Aug 2007 00:29:07 +0200 (CEST)
Received: by piper.oerlikon.madduck.net (Postfix, from userid 1000)
	id B8FBD43F9; Thu, 16 Aug 2007 00:29:07 +0200 (CEST)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20070815163822.GC1070MdfPADPa@greensroom.kotnet.org>
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux lenny/sid kernel 2.6.22-1-amd64 x86_64
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at madduck.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55961>


--8t9RHnE3ZwKMSgU+
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

also sprach Sven Verdoolaege <skimo@kotnet.org> [2007.08.15.1838 +0200]:
> The (most appropriate) URL from which to get updates of a submodule
> may be different for different people and therefore has to be stored
> in .git/config.  It was then decided that the default value
> for this URL should be stored in .gitmodules.  git submodule init
> simply initializes the URL using this default value.  You are free
> to not call git submodule init and set a (more) appropriate URL manually.

Ah. I shall prepare a patch against the manpage to make this more
clear then. Thanks for your explanation.

I have one open question though: why require init? It makes perfect
sense to allow for a local override, but unless I need to override
it, git-submodule update should really just keep using the default,
which it does not as far as I can tell from my tests:

piper:/tmp/cdt.tfd29893/co/a> git submodule update
piper:/tmp/cdt.tfd29893/co/a> git-submodule init
Submodule 'b' (/tmp/cdt.tfd29893/repos/b.git) registered for path 'b'
piper:/tmp/cdt.tfd29893/co/a> git submodule update
Initialized empty Git repository in /tmp/cdt.tfd29893/co/a/b/.git/
0 blocks
Submodule path 'b': checked out '0c1403bc9e13480e70745b70f79ffb00deb25a8d'

Is there a reason for this or should I try to create a patch, which
would make git-submodule consult .gitmodules in addition to
config.submodules for all modules not found in config.submodules.

Now if I may go a step further, I'll claim that init is a misnomer,
really. Instead, I would suggest to rename it. Here are some
thoughts:

  - config
    there is already git-config, and just like git-svn reuses e.g.
    rebase, this would keep the taxonomy compact
  - cpconf
    it does copy the configuration, after all
  - override
    not sure, since it doesn't actually override anything, but sets
    it all up for the user to be able to override the config
  - instconf
    install or instantiate the configuration
  - localise
    overloaded word, but it'd be localising configuration in some
    ways
  - localconf
    hinting at making the configuration local

Comments welcome,

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
man muss noch chaos in sich haben
um einen tanzenden stern zu geb=E4hren.
                                                -- friedrich nietzsche
=20
spamtraps: madduck.bogus@madduck.net

--8t9RHnE3ZwKMSgU+
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGw34zIgvIgzMMSnURAqkSAKCy9VP5TlIosoU1vNXXxmvC0k9McgCfSmmH
B1Rz6QmvjoCNmAjjihuaBw0=
=jqAM
-----END PGP SIGNATURE-----

--8t9RHnE3ZwKMSgU+--
