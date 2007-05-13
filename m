From: Jan Hudec <bulb@ucw.cz>
Subject: Re: RFD Use git for off-site backups
Date: Sun, 13 May 2007 14:34:36 +0200
Message-ID: <20070513123436.GE8983@efreet.light.src>
References: <20070513093417.GA18546@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="FN+gV9K+162wdwwF"
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Sun May 13 14:34:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnDHr-000546-8B
	for gcvg-git@gmane.org; Sun, 13 May 2007 14:34:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757625AbXEMMep (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 08:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757744AbXEMMeo
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 08:34:44 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1705 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1757625AbXEMMeo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 08:34:44 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.201388;
	Sun, 13 May 2007 14:34:36 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1HnDHY-0005OV-3H; Sun, 13 May 2007 14:34:36 +0200
Content-Disposition: inline
In-Reply-To: <20070513093417.GA18546@cip.informatik.uni-erlangen.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47144>


--FN+gV9K+162wdwwF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, May 13, 2007 at 11:34:17 +0200, Thomas Glanzmann wrote:
> I am thinking about using git for doing differential backups of a whole
> machines. And I would like to know what is necessary to obtain that. In
> such a scenario the machine to be backed up should have a local index
> file but sends its objects directly to the remote machine via git-via-ssh
> or git protocol. Is it possible to store extra information like extended
> attributes / acls in git? I don't care about named pipes, sockets and
> device files for the moment.

I don't actually think git is a good match for whole-machine backups. It's
strenghts are in distributedness and branching, but you don't need either of
those for large-scale backups (monitoring changes say in /etc is a different
thing -- git is sensible match there -- see http://www.isisetup.ch/).

I can suggest two solutions:

 - Use CVS on the client (machine to back up) and git-cvsserver on the
   server. You will probably be able to find some scripts that do backups to
   CVS. On server you will still have git for digging in history. Git is al=
so
   very space efficient.

   CVS does not cache any data on the client. It only keeps metadata to
   detect which files were modified. Therefore it will have minimal overhead
   in storage, but needs to transfer the modified files in their entirety.

 - Use Subversion. There is summer of code project to create git-svnserver,
   so you might be able to use git on the server-side in future with
   subversion client too. But for backups you should not need any of the
   version control features subversion does not have, so subversion should =
be
   suitable.

   Subversion stores copy of the previous revision on the client, so all da=
ta
   under it's control will take twice as much space on client, but it will
   only transfer deltas over the network.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--FN+gV9K+162wdwwF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRwXcRel1vVwhjGURAgOrAJ9uoo04ykLbqwcpoKz8FWtXX0m+ZQCffmbP
+V0K8nKlMEAscD47KPsMvLM=
=dgXY
-----END PGP SIGNATURE-----

--FN+gV9K+162wdwwF--
