X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Martin Waitz <tali@admingilde.org>
Subject: Re: [RFC] Submodules in GIT
Date: Sat, 2 Dec 2006 20:46:03 +0100
Message-ID: <20061202194602.GP18810@admingilde.org>
References: <20061201121234.GQ18810@admingilde.org> <4570289D.9050802@b-i-t.de> <20061201133558.GU18810@admingilde.org> <45703375.4050500@b-i-t.de> <20061201145817.GY18810@admingilde.org> <45704EA3.40203@b-i-t.de> <20061201165418.GD18810@admingilde.org> <45706758.2020907@b-i-t.de> <20061201184801.GG18810@admingilde.org> <4570BC07.4080203@stephan-feder.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EmwFttYoLalE/5Ab"
NNTP-Posting-Date: Sat, 2 Dec 2006 19:46:28 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <4570BC07.4080203@stephan-feder.de>
X-PGP-Fingerprint: B21B 5755 9684 5489 7577  001A 8FF1 1AC5 DFE8 0FB2
User-Agent: Mutt/1.5.9i
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33034>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gqaoa-0006XJ-Ik for gcvg-git@gmane.org; Sat, 02 Dec
 2006 20:46:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1162493AbWLBTqI (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 2 Dec 2006
 14:46:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162507AbWLBTqI
 (ORCPT <rfc822;git-outgoing>); Sat, 2 Dec 2006 14:46:08 -0500
Received: from agent.admingilde.org ([213.95.21.5]:44760 "EHLO
 mail.admingilde.org") by vger.kernel.org with ESMTP id S1162493AbWLBTqE
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 2 Dec 2006 14:46:04 -0500
Received: from martin by mail.admingilde.org with local  (Exim 4.50 #1) id
 1GqaoF-0004LG-5j; Sat, 02 Dec 2006 20:46:03 +0100
To: sf <sf-gmane@stephan-feder.de>
Sender: git-owner@vger.kernel.org


--EmwFttYoLalE/5Ab
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

hoi :)

On Sat, Dec 02, 2006 at 12:34:31AM +0100, sf wrote:
> > Now your submodule is no longer seen as an independent git repository
> > and I think this would cause problems when you want to push/pull between
> > the submodule and its upstream repository.
>=20
> You can always pick a single commit or several commits out of a larger
> repository and have a complete git repository.
>=20
> And I already explained how to push and pull even from within superprojec=
ts.

Sure it you are able to make it work, but it needs more work on the UI part.
How do you handle the index? How do you allow to clone only the
submodule?

I really thought about such a setup too, but then decided that it is
much easier to work with submodules when you can really see it as a
repository of its own.

> > But you could still call the "xdiff" part of the git repository a
> > submodule.  And then changes to the xdiff directory result in a new
> > submodule commit, even when there is no direct reference to it.
> > So you'd still "commit to the xdiff submodule".
>=20
> Let's make certain that we understand each other. I see a clear
> distinction between the submodule code in a supermodule branch (commits
> in the supermodule's tree and nothing else) and submodule branches which
> are independent of the superproject. Supermodule branches and submodule
> branches do not interact, only if I want them to.

Agreed.
I think the thing which caused some discussion is that I make the
current submodule commit which is used by the supermodule available in a
refs/head in the submodule.
So there is one "branch" in the submodule which corresponds to the
version used by the supermodule, but this is just for user interface.
It's most important purpose is to give this special commit a name, so
that it can be used in merges, etc.

By selecting another refs/heads "branch" in the submodule you can also
easily detach the submodule from the supermodule.
It is really important to understand that you can't branch the submodule
alone and still have it connected to the supermodule, because the
supermodule always tracks only one commit for each submodule.
So every branch that affects the project has to be done on project
(topmost supermodule) level.
But of course the submodule can have other branches which are not
tracked by the supermodule.
So by checking out refs/heads/master (as it is used in my
implementation) you can attach the submodule to the supermodule (attach
as in: bring the working directory in sync with the whole project), and
you can detach it by selecting another refs/heads (the submodule is
still part of the supermodule, but not in the state which is currently
visible in the working directory).
This may sound confusing, but it really is the only semantic for
submodule branches that makes sense.
There are fears that you may commit something that does not match your
current working directory.  Sure, but you explicitly asked for it and I
think it won't be a problem if git-status tells about this fact.


> The double slashes is the only way I can think of that clearly indicates
> that I do not mean the contents named by the path, but the commit that
> you find there. Once you have named a commit in that way, you can
> continue to apply other revision naming suffixes, paths, and so on.

With the current semantics, you can already get to the submodule commit
(just leave out your double slashes), but what is missing is simply to
apply all the modifiers again on this submodule commit.
So I think we can do without the double slashes.

--=20
Martin Waitz

--EmwFttYoLalE/5Ab
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFFcdf6j/Eaxd/oD7IRAj2LAJwPSq1vhkaqhr2k1w3Gsd9Cse/zngCcDR6F
QS6qpYjkXAzwkqH1daS0hwQ=
=t67z
-----END PGP SIGNATURE-----

