From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [RFC] CLI option parsing and usage generation for porcelains
Date: Sun, 14 Oct 2007 11:57:55 +0200
Message-ID: <20071014095755.GF1198@artemis.corp>
References: <1192282153-26684-1-git-send-email-madcoder@debian.org> <20071014091855.GA17397@soma>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="V4b9U9vrdWczvw78";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sun Oct 14 11:58:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ih0Eb-00074E-GQ
	for gcvg-git-2@gmane.org; Sun, 14 Oct 2007 11:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755144AbXJNJ57 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Oct 2007 05:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755110AbXJNJ57
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Oct 2007 05:57:59 -0400
Received: from pan.madism.org ([88.191.52.104]:46186 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754895AbXJNJ56 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Oct 2007 05:57:58 -0400
Received: from madism.org (olympe.madism.org [82.243.245.108])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id AB70524DF5;
	Sun, 14 Oct 2007 11:57:56 +0200 (CEST)
Received: by madism.org (Postfix, from userid 1000)
	id C35353AB61B; Sun, 14 Oct 2007 11:57:55 +0200 (CEST)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>,
	Eric Wong <normalperson@yhbt.net>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20071014091855.GA17397@soma>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60823>


--V4b9U9vrdWczvw78
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 14, 2007 at 09:18:55AM +0000, Eric Wong wrote:
> Pierre Habouzit <madcoder@debian.org> wrote:
> >   Following Kristian momentum, I've reworked his parse_option module
> > quite a lot, and now have some quite interesting features. The series is
> > available from git://git.madism.org/git.git (branch ph/strbuf).
> >=20
> >   The following series is open for comments, it's not 100% ready for
> > inclusion IMHO, as some details may need to be sorted out first, and
> > that I've not re-read the patches thoroughly yet. Though I uses the tip
> > of that branch as my everyday git for 2 weeks or so without any
> > noticeable issues.
> >=20
> >   And as examples are always easier to grok:
> >=20
> > $ git fetch -h
> > usage: git-fetch [options] [<repository> <refspec>...]
> >=20
> >   -q, --quiet           be quiet
> >   -v, --verbose         be verbose
> >=20
> >   -a, --append          append in .git/FETCH_HEAD
> >   -f, --force           force non fast-forwards updates
> >   --no-tags             don't follow tags at all
> >   -t, --tags            fetch all tags
> >   --depth <depth>       deepen history of a shallow clone
> >=20
> > Advanced Options
> >   -k, --keep            keep downloaded pack
> >   -u, --update-head-ok  allow to update the head in the current branch
> >   --upload-pack <path>  path to git-upload-pack on the remote
> >=20
> > $ git rm -rf xdiff # yeah -rf now works !
>=20
> Very nice.  I worked on gitopt around summer of 2006 but never had the
> time to test it thoroughly.  It was a _lot_ more intrusive than yours
> currently is (it touched the diff + revision family of commands).
>=20
> One feature I really like is automatically handling of long option
> abbreviations.  gitopt supported this at the expense of complexity
> and the aforementioned intrusivenes.  This allows automatic handling
> of the abbreviation style seen commonly in git shell scripts:
>=20
>    --a|--am|--ame|--amen|--amend)  (from git-commit.sh)

  Yes, but if you do that, you can't order options in the order you
want (because of first match issues), making the help dumps hopelessly
random. I prefer exact match, especially since your shell can help you
autocomplete the proper command.

  I intend to have some magic in the parse_options module to dump the
options in a machine parseable way, so that zsh/bash completion for the
parseopt aware commands is almost trivial. (this was requested from one
of the zsh upstream developpers, and it definitely make sense).

  Note that I didn't migrated all the commands yet especially not
diff.c, We'll need a new construct for that: embedding a struct options
array into another to inherit its flags, though I'm not sure it's
enough, as a struct options right now embeds pointers to the variables
it fills, which doesn't work with the "pure" `diff_opt_parse` approach
right now. But I'm sure I'll come up with something :)

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--V4b9U9vrdWczvw78
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHEegjvGr7W6HudhwRAlw5AKCUucQHfS1Is6MaMjG6UMfTmt4kIgCfcJDx
bbAmxpRiUqn/vkl/6G1FBjk=
=2a0I
-----END PGP SIGNATURE-----

--V4b9U9vrdWczvw78--
