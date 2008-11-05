From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH 2/5] git send-email: interpret unknown files as revision  lists
Date: Wed, 05 Nov 2008 11:40:01 +0100
Message-ID: <20081105104001.GA22272@artemis.corp>
References: <1225815858-30617-2-git-send-email-madcoder@debian.org> <1225815858-30617-3-git-send-email-madcoder@debian.org> <1225815858-30617-4-git-send-email-madcoder@debian.org> <1225815858-30617-5-git-send-email-madcoder@debian.org> <7vvdv3nj28.fsf@gitster.siamese.dyndns.org> <1225450632-7230-1-git-send-email-madcoder@debian.org> <1225815858-30617-1-git-send-email-madcoder@debian.org> <1225815858-30617-2-git-send-email-madcoder@debian.org> <1225815858-30617-3-git-send-email-madcoder@debian.org> <7v1vxroxn1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="CE+1k2dSO48ffgeK";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 05 11:41:25 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxfpE-0007zg-EJ
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 11:41:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754569AbYKEKkG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 05:40:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754605AbYKEKkG
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 05:40:06 -0500
Received: from pan.madism.org ([88.191.52.104]:51365 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbYKEKkE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 05:40:04 -0500
Received: from madism.org (def92-12-88-177-251-208.fbx.proxad.net [88.177.251.208])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (verified OK))
	by hermes.madism.org (Postfix) with ESMTPS id 730B63C1B6;
	Wed,  5 Nov 2008 11:40:02 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 3B75FEBFD8; Wed,  5 Nov 2008 11:40:01 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <7viqr2mz75.fsf@gitster.siamese.dyndns.org> <7vvdv3nj28.fsf@gitster.siamese.dyndns.org> <7v1vxroxn1.fsf@gitster.siamese.dyndns.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100154>


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 04, 2008 at 11:54:26PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:

> > @@ -363,10 +366,22 @@ if (@alias_files and $aliasfiletype and defined $=
parse_alias{$aliasfiletype}) {
> > =20
> >  ($sender) =3D expand_aliases($sender) if defined $sender;
> > =20
> > +sub check_file_rev_conflict($) {
> > +	my $f =3D shift;
> > +	if ($repo->command('rev-parse', '--verify', '--quiet', $f)) {
> > +		die("revision/filename conflict on `$f'");
>=20
> Perhaps wording this a bit more to the point?  This is triggered when=20
> '$f' can be both a filename or a revision, so...
>=20
> 	File '$f' exists but it could also be the range of commits
>         to produce patches for.  Please disambiguate by...
>=20
> 	* Saying "./$f" if you mean a file; or
>         * Giving -F option if you mean a range.
>=20
> Earlier I suggested that "origin^0" is a way for the user to disambiguate
> favouring a rev, but such a filename can exist, so we cannot blindly
> suggest to say "$f^0" here.  I think adding -F (or --format-patch) option
> to send-email to explicitly disable file/directory interpretation would be
> a cleaner solution for this (and it would allow you to drive this from a
> script without worrying about what garbage files you happen to have in the
> working tree).

Okay, still having --[no-]format-patch is probably a good idea indeed
for scripts. Will do.

On Tue, Nov 04, 2008 at 11:54:39PM +0000, Junio C Hamano wrote:
> Pierre Habouzit <madcoder@debian.org> writes:
>=20
> > +	print C <<EOT;
> > +From $tpl_sender # This line is ignored.
> > +GIT: Lines beginning in "GIT: " will be removed.
> > +GIT: Consider including an overall diffstat or table of contents
> > +GIT: for the patch you are writing.
> > +GIT:
> > +GIT: Clear the body content if you don't wish to send a summary.
> > +From: $tpl_sender
> > +Subject: $tpl_subject
> > +In-Reply-To: $tpl_reply_to
> > +
>=20
> Somebody already suggested this but I really think GIT: lines should be at
> the end and use '# ' prefix instead.

This will break previous editor syntax hilighting stuff even more, and
has the drawback that you can't put shell sniplets in here. I think it's
why GIT: was chosen. But maybe we just don't care.

> With the ability to give --cover-letter option to underlying format-patch
> do you still need this?
>=20
> > +	my $editor =3D $ENV{GIT_EDITOR} || Git::config(@repo, "core.editor") =
|| $ENV{VISUAL} || $ENV{EDITOR} || "vi";
> > +
> > +	if ($annotate) {
> > +		do_edit($compose_filename, @files);
> > +	} else {
> > +		do_edit($compose_filename);
> > +	}
>=20
> Don't we want to abort the whole process when the user kills the editor
> instead of normal exit (iow, do_edit() which is system() reports that the
> editor was killed)?

Probably, I kept what was done as is, but we probably want do_edit() to
die() if the user killed it.

On mer, nov 05, 2008 at 07:03:42 +0000, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> > On Tue, Nov 04, 2008 at 03:54:54PM -0800, Junio C Hamano wrote:
> Yeah, if send-email did not have --compose to begin with, we could just
> say "don't use --compose; use --cover-letter when you use send-email to
> front-end format-patch instead", but some people perhaps are used to run
> format-patch separately without --cover-letter and then create the cover
> letter from scratch with --compose (which seems a bit more work to me,
> though).
>=20
> So I am not opposed to a sendemail.foo configuration option.

Will do


--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--CE+1k2dSO48ffgeK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkkRd/8ACgkQvGr7W6HudhzmUwCbBMRmEdK/3CmVpDFEkldBqV5h
oLQAn2k4xN6VfxV74E4KK72pciaFtMT7
=J5f0
-----END PGP SIGNATURE-----

--CE+1k2dSO48ffgeK--
