From: Jan Hudec <bulb@ucw.cz>
Subject: Re: confused about preserved permissions
Date: Mon, 3 Sep 2007 20:59:16 +0200
Message-ID: <20070903185916.GA3786@efreet.light.src>
References: <20070820164411.GA15637@piper.oerlikon.madduck.net> <6031FB22-648E-47DE-92EE-2E7255322C27@lrde.epita.fr> <7v8x83i5ma.fsf@gitster.siamese.dyndns.org> <20070823060052.GA25153@piper.oerlikon.madduck.net> <85mywiixtp.fsf@lola.goethe.zz> <B38B8F2F-92B0-48F4-9093-54724FA862C2@lrde.epita.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="k+w/mQv8wyuph6w0"
Cc: David Kastrup <dak@gnu.org>,
	git discussion list <git@vger.kernel.org>
To: Benoit SIGOURE <tsuna@lrde.epita.fr>
X-From: git-owner@vger.kernel.org Mon Sep 03 21:01:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ISHBI-0004ku-1w
	for gcvg-git@gmane.org; Mon, 03 Sep 2007 21:01:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754047AbXICTBV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Sep 2007 15:01:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753868AbXICTBV
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Sep 2007 15:01:21 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:50577 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753786AbXICTBU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Sep 2007 15:01:20 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 2B67C572C4;
	Mon,  3 Sep 2007 21:01:19 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id N9CHWUKTIAke; Mon,  3 Sep 2007 21:01:16 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id CA94E572C2;
	Mon,  3 Sep 2007 21:01:15 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1ISH8m-0001Bi-3z; Mon, 03 Sep 2007 20:59:16 +0200
Content-Disposition: inline
In-Reply-To: <B38B8F2F-92B0-48F4-9093-54724FA862C2@lrde.epita.fr>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57503>


--k+w/mQv8wyuph6w0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 23, 2007 at 09:48:23 +0200, Benoit SIGOURE wrote:
> Hmm yes, that's right.
>
> Let's look at the problem from another point of view then: I want my=20
> *working tree* to be group readable even though my umask is 066.  Would i=
t=20
> be possible to add a local config option in the .git repo to tell git tha=
t=20
> it should create new file this way (exactly like core.sharedRepository bu=
t=20
> core.sharedWorkingCopy or whatever).
>
> WDYT?

You need to change umask not just for git, but for your editor and compiler
when you are working in the shared work tree as well, no? So what about
teaching your *shell* to change it as appropriate?

In zsh if you define a function chpwd, it will be called whenever you change
current working directory. If you define it as:

chpwd() {
    # The / at the end is to make foo/* match path foo
    case `pwd`/ in
	/path/to/your/worktree/*) umask 002;;
	*) umask 066;;
    esac
}

would make any command (ie. git, editor and compiler/make/...) ran from the
shared worktree run with umask 002 (or whatever depending on permissions you
want there) and anything ran from anywhere else use your normal umask 066.

I don't use bash, but I am almost sure you can get a suitable hook there as
well. If nothing else I recall there is a way to run a function from prompt
expansion, which would do the trick.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--k+w/mQv8wyuph6w0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG3FmERel1vVwhjGURAtVtAJ9kxDyGCen3m0oDlFxF19FOQ0ppVgCgqjob
kVJ+rKuTdsgK3JouNJTRdfM=
=mFi+
-----END PGP SIGNATURE-----

--k+w/mQv8wyuph6w0--
