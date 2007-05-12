From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] Updated documentation of hooks in git-receive-pack.
Date: Sat, 12 May 2007 22:13:09 +0200
Message-ID: <20070512201309.GB8983@efreet.light.src>
References: <20070512171113.GA8100@efreet.light.src> <7vmz09yh8n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="+g7M9IMkV8truYOl"
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 12 22:13:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmxyC-0002Oo-GU
	for gcvg-git@gmane.org; Sat, 12 May 2007 22:13:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756192AbXELUNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 May 2007 16:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756637AbXELUNY
	(ORCPT <rfc822;git-outgoing>); Sat, 12 May 2007 16:13:24 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:1906 "EHLO mail.bluetone.cz"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756192AbXELUNX (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 May 2007 16:13:23 -0400
Received: from ([85.207.119.145])
	by mail.bluetone.cz with ESMTP with TLS id 5203017.198056;
	Sat, 12 May 2007 22:13:09 +0200
Received: from bulb by efreet.light.src with local (Exim 4.67)
	(envelope-from <bulb@ucw.cz>)
	id 1Hmxxl-0002gU-5J; Sat, 12 May 2007 22:13:09 +0200
Content-Disposition: inline
In-Reply-To: <7vmz09yh8n.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-esp: ESP<0>=
	RBL:<0> 
	SHA:<0> 
	UHA:<0> 
	BAYES:<0> 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47088>


--+g7M9IMkV8truYOl
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 12, 2007 at 12:27:52 -0700, Junio C Hamano wrote:
> Jan Hudec <bulb@ucw.cz> writes:
>=20
> > Added documentation of pre-receive and post-receive hooks and updated
> > documentation of update and post-update hooks.
> >
> > Signed-off-by: Jan Hudec <bulb@ucw.cz>
>=20
> Thanks, much appreciated.  Domain ucw.cz sounds familiar; are
> you close by to Pasky?

Studied the same faculty.

> [...]
> > +The standard output of this hook is sent to `stderr`, so if you
> > +want to report something to the `git-send-pack` on the other end,
> > +you can simply `echo` your messages.
>=20
> I think "sent to stderr" is a implementation detail between
> receive-pack and hook scripts.  I would just keep the "if you
> want to..." part.

It's actually original wording from description of 'update'. I think just
leaving out the stderr thing is not right, because it's important that both
stdout and stderr go to the same place. I'll change it to:

  Both standard output and error output are forwarded to `git-send-pack` on
  the other end, so you can simply `echo` messages for the user.

> > +[[post-receive]]
> > +post-receive
> > +------------
> > +
> > +This hook is invoked by `git-receive-pack` on the remote repository,
> > +which happens when a `git push` is done on a local repository.
> > +It executes on the remote repository once after all the refs have
> > +been updated.
> > +
> > +This hook executes once for the receive operation.  It takes no
> > +arguments, but for each ref that was updated it receives on standard
> > +input a line of the format:
> > +
> > +  <old-value> SP <new-value> SP <ref-name> NL
> > +
> > +on stdin, where `<old-value>` is the old object name stored in the
> > +ref, `<new-value>` is the new object name to be stored in the ref and
> > +`<ref-name>` is the full name of the ref.
>=20
> Maybe
>=20
> 	It takes no arguments, but gets the same information as
> 	the `pre-receive` hook does on its standard input.
>=20
> to avoid the duplicated description.

Makes sense.

> > +[[post-update]]
> >  post-update
> >  -----------
> > =20
> > @@ -146,7 +214,8 @@ the outcome of `git-receive-pack`.
> > =20
> >  The 'post-update' hook can tell what are the heads that were pushed,
> >  but it does not know what their original and updated values are,
> > -so it is a poor place to do log old..new.
> > +so it is a poor place to do log old..new. See
> > +<<post-receive,'post-receive'>> hook above for a better one.
>=20
> Instead of just passing 'a better one' judgement without
> rationale, it is more helpful to explain why the newer ones are
> recommended, so that the reader can agree to it.
>=20
>         In general, `post-receive` hook is preferred when the hook needs
>         to decide its acion on the status of the entire set of refs
>         being updated, as this hook is called once per ref, with
>         information only on a single ref at a time.

Yes, it's probably better. Though in this case the post-update hook should =
be
really obsoleted. It takes names of all updated refs on command-line, which
is unlikely to fail on linux, but might fail on Windows where the
command-line lenght is much more limited. But for now I'll just mention that
the other hook does have the information this one does not.

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--+g7M9IMkV8truYOl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGRh/VRel1vVwhjGURAu9jAKC173A+56g4MnC0uPoKj5v1/BphMQCg0vPu
cmodz71iX7/L3bh+lzEUZNM=
=QCSs
-----END PGP SIGNATURE-----

--+g7M9IMkV8truYOl--
