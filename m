From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH 7/7] builtin-merge: avoid non-strategy git-merge
	commands in error message
Date: Sat, 26 Jul 2008 17:25:02 +0200
Message-ID: <20080726152502.GL32057@genesis.frugalware.org>
References: <cover.1217037178.git.vmiklos@frugalware.org> <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <1217073292-27945-1-git-send-email-vmiklos@frugalware.org> <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org> <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org> <99c90877657be0ed439a9918f500d6ad132550a2.1217037178.git.vmiklos@frugalware.org> <13f39dd6752a34beeb6ecccb51dbc7546ef87182.1217037178.git.vmiklos@frugalware.org> <fc448aa651ad9e8e9d1cf5556a665b5bd6074628.1217037178.git.vmiklos@frugalware.org> <65a569c389352c5d0500b8c44c28e5572352e6ba.1217037178.git.vmiklos@frugalware.org> <alpine.DEB.1.00.0807261701520.26810@eeepc-johanness>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I+SguG+o2MtpYMn7"
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:26:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlen-0007fV-Km
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:26:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752181AbYGZPZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752071AbYGZPZF
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:25:05 -0400
Received: from virgo.iok.hu ([193.202.89.103]:48143 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752065AbYGZPZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:25:04 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id DF8F31B24FC;
	Sat, 26 Jul 2008 17:25:02 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id E02CE4465E;
	Sat, 26 Jul 2008 16:41:59 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id 61D231190A09; Sat, 26 Jul 2008 17:25:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807261701520.26810@eeepc-johanness>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90240>


--I+SguG+o2MtpYMn7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jul 26, 2008 at 05:08:11PM +0200, Johannes Schindelin <Johannes.Sch=
indelin@gmx.de> wrote:
> > +		memset(&not_strategies, 0, sizeof(struct cmdnames));
> > +		for (i =3D 0; i < main_cmds.cnt; i++) {
>=20
> Looking through all the discovered git commands?  Cute...  But does that=
=20
> not exclude the commands that are in PATH, starting with git-merge-, even=
=20
> if they are custom strategies?

main_cmds contains only commands in /usr/libexec/git-core, while I guess
custom strategies are elsewhere in PATH, which commands are in
other_cmds, not in main_cmds.

Sample output at me:

$ git merge -s theirss c2
HEAD is now at 1f5e3cc c1
Could not find merge strategy 'theirss'.

available strategies in '/usr/libexec/git-core/'
--------------------------------------------------
  octopus     ours        recursive   resolve     subtree

strategies available from elsewhere on your $PATH
---------------------------------------------------
  theirs

and I have git-merge-theirs in ~/bin (which is in PATH).

>=20
> > +			int j, found =3D 0;
> > +			for (j =3D 0; j < ARRAY_SIZE(all_strategy); j++)
> > +				if (!strcmp(main_cmds.names[i]->name, all_strategy[j].name))
> > +					found =3D 1;
> > +			if (!found)
> > +				add_cmdname(&not_strategies, main_cmds.names[i]->name, strlen(main=
_cmds.names[i]->name));
>=20
> Better have a local variable "name" instead of writing out=20
> "main_cmds.names[i]->name" all the time...

Fixed.

> Oh, and you assume that the names are NUL-terminated (which I assume is=
=20
> not the case in general, as the len member is the only thing that makes=
=20
> struct cmdnames different from struct string_list.

I think the purpose of it is different, but the argument is still valie.
That len member is to be able to have ->name contain "foo.exe" while
having len at 3, so that git help -a will avoid the .exe suffixes.

Changed.

(I do not want to resend a full series yet, but I pushed out an amended
patch to repo.or.cz in the 'merge-custom' branch.)

diff --git a/builtin-merge.c b/builtin-merge.c
index 4084e07..b0d1de5 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -93,11 +93,12 @@ static struct strategy *get_strategy(const char *name)
 		memset(&not_strategies, 0, sizeof(struct cmdnames));
 		for (i =3D 0; i < main_cmds.cnt; i++) {
 			int j, found =3D 0;
+			char *ent =3D main_cmds.names[i];
 			for (j =3D 0; j < ARRAY_SIZE(all_strategy); j++)
-				if (!strcmp(main_cmds.names[i]->name, all_strategy[j].name))
+				if (!strncmp(ent->name, all_strategy[j].name, ent->len))
 					found =3D 1;
 			if (!found)
-				add_cmdname(&not_strategies, main_cmds.names[i]->name, strlen(main_cmd=
s.names[i]->name));
+				add_cmdname(&not_strategies, ent->name, ent->len);
 		}
 		fprintf(stderr, "Could not find merge strategy '%s'.\n\n", name);
 		list_commands("git-merge-", "strategies", &not_strategies);

--I+SguG+o2MtpYMn7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkiLQc4ACgkQe81tAgORUJZ5+gCgojb4qwXG5LA+lp/tg5g/CKsQ
79MAn2446toXJw9d2QVUKAaPfntIdX06
=zuG0
-----END PGP SIGNATURE-----

--I+SguG+o2MtpYMn7--
