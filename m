From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Proposed config addition: submodules.denyNonFastForward
Date: Fri, 10 Jul 2009 12:50:04 -0700
Message-ID: <20090710195004.GA2371@starfruit.corp.slide.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 10 21:51:20 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MPM7r-00080Y-SL
	for gcvg-git-2@gmane.org; Fri, 10 Jul 2009 21:51:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569AbZGJTvK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2009 15:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752889AbZGJTvI
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Jul 2009 15:51:08 -0400
Received: from mx0.slide.com ([208.76.68.7]:48164 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752440AbZGJTvH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2009 15:51:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Date:From:To:Subject:Message-ID; bh=v
	h5opwvjyaB/AFnCQnBccwOQReILSvSrlcdHCIfAHck=; b=IDvodv4EH4s/LejY6
	BEBX4fPe8a8NpH8Ik4nmNmGY3D27JT0yp4CfkpYA36T0nGUjvB4AB1V1Gl6yt0R2
	XqsXZMwPgm2EY5DrQYEf8mX+XlnEO9NqmkmUhBtVe10g47N4sXZuKeSWLEx32RZ/
	9Zx+/xM5k9ixDUqJjCNZSRUvdM=
Received: from nat3.slide.com ([208.76.69.126]:52919 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1MPM7e-0002Zm-Hb
	for <git@vger.kernel.org>; Fri, 10 Jul 2009 12:51:06 -0700
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 824F2A6F0003
	for <git@vger.kernel.org>; Fri, 10 Jul 2009 12:51:06 -0700 (PDT)
X-Virus-Scanned: amavisd-new at calculon.corp.slide.com
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rD848A4+o+oi for <git@vger.kernel.org>;
	Fri, 10 Jul 2009 12:51:06 -0700 (PDT)
Received: from starfruit.corp.slide.com (starfruit.corp.slide.com [10.10.10.45])
	by calculon.corp.slide.com (Postfix) with ESMTP id 47698A6F0002
	for <git@vger.kernel.org>; Fri, 10 Jul 2009 12:51:06 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123078>


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In my previous thread regarding submodules "Manasging submodules on
large multi-user projects" I feel that some things were left largely
unresolved. My options given were:

  * Use repo (and retrain users)
  * Use Avery's git-subtree(1) addition (and potentially retrain)

After discussing some of the pitfalls that I've had with submodule
deployment with a kindred spirit in the #github channel, we came to the
conclusion that submodules would be very usable if one could implement a
"submodules.denyNonFastForward" configuration.


THE ERRORCASE:
--------------
The majority of problems with submodules comes from PEBKAC, where users
don't run `git submodule update` and/or the often execute `git commit -a`=
=20
with nary a concern for whether it's a good idea or not. I concede that
these are systemic organizational changes, but I find changing software
to be well within the acheivable, whereas changing people I've
discovered is near-impossible.=20

Problems occur in this scenario:

            -sub@A-  -sub@B-
[master] ------*--------*------->
                \        \
        [branch] `--------`---X (commit -a)

In the second merge from master to branch, if the user neglects to
execute `git submodule update` and then executes the commit at 'X' they
will inadvertantly change the index for the submodule to roll it back to
"A" instead of keeping it at "B" where it should be.



THE POTENTIAL SOLUTION (and it's problems)
------------------------------------------
The implementation details behind submodules.denyNonFastForward are
certainly not simple.=20
   * Is it a server-side (bare repo) config value or a client side config v=
alue?=20
     (I'm assuming it fits best client side).=20
   * What if you have a submodule and you explicitly need to roll it
     back to a previous version of the submodule?
   * Does this cross the line of separation between super- and
     sub-module? Currently ths super (from my understanding) does not=20
     contain or maintain any "knowledge" of the sub-module, it merely=20
     is aware of a particular commit to detach the head to.


With the weekend coming up, I have some available coding time, and
certainly have no problems attempting to come up with a patch set to add
this configuration value, but I do need some guidance as to whether it
fits into Git conceptually and whether it's technically feasible.


Cheers

-R. Tyler Ballance
Slide, Inc.

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEARECAAYFAkpXm2wACgkQFCbH3D9R4W8mgwCeMoEv8cg8WSj96f7TEDBRvp0t
aTEAoJqjeFZ3+q28GvAVIbB+V++hY3kg
=rP8w
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
