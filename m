From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 19:17:33 +0200
Message-ID: <20080718171733.GV10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <200807181905.07123.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Lea Wiemann <lewiemann@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 19:18:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJtbG-0005D7-LW
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 19:18:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761191AbYGRRRg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2008 13:17:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761134AbYGRRRg
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 13:17:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45225 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761068AbYGRRRf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 13:17:35 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id AF456393B306; Fri, 18 Jul 2008 19:17:33 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200807181905.07123.jnareb@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89060>

On Fri, Jul 18, 2008 at 07:05:05PM +0200, Jakub Narebski wrote:
> Dnia pi=B1tek 18. lipca 2008 18:48, Petr Baudis napisa=B3:
> > On Tue, Jul 15, 2008 at 12:19:31AM +0200, Lea Wiemann wrote:
>=20
> > > No, you should never pass in an invalid SHA1 in the first place. =
 The
> > > above piece of documentation is just a warning that bugs will sho=
w up
> > > delayed.  IOW, this is not the right place to have your error han=
dling.
> > >=20
> > > If you're getting a SHA1 through the user-interface, check its ex=
istence
> > > with get_sha1 before passing it to the constructor.
> >=20
> > But that's an expensive operation, you need extra Git exec for this=
,
> > while all the Git commands can do the checks for you, if you give t=
hem
> > the chance.
> >=20
> > I was doing pretty much this thing in Cogito (initially out of
> > necessity) and it made it ungodly slow for any kind of batch operat=
ions.
>=20
> Lea probably would point out that thanks to '--batch-check' option
> to git-cat-file, and "reuse =3D> 1" option to ->get_bidi_pipe you wou=
ld
> need only one extra Git exec...  BUT it is one extra Git exec per
> entire Perl script (one per request, for example, for gitweb).
> And it wouldn't help batching Perl script commands.

Even so, I don't like this restriction simply since it makes the usage
more complicated - in my commandline tool, I will be forced to write

	my $csha1 =3D $repo->get_sha1($ARGV[0]);
	$csha1 or die "a random inconsistent error message";
	$repo->get_commit($csha1)

instead of

	$repo->get_commit($ARGV[0]) # die if unresolved

and I don't understand why. Me and 80% of the scripts don't *care* abou=
t
some more graceful error handling, and if gitweb and the other 20%
(or less) do, *they* should do the extra work, not me.

--=20
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
