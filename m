From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Re: [PATCH] Wrap inflateInit to retry allocation after releasing
 pack memory
Date: Thu, 08 Jan 2009 10:15:52 -0800
Organization: Slide, Inc.
Message-ID: <1231438552.8870.645.camel@starfruit>
References: <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
	 <1231368935.8870.584.camel@starfruit>
	 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
	 <1231374514.8870.621.camel@starfruit>
	 <alpine.LFD.2.00.0901071836290.3283@localhost.localdomain>
	 <20090108030115.GF10790@spearce.org>
	 <alpine.LFD.2.00.0901071904380.3283@localhost.localdomain>
	 <20090108031314.GG10790@spearce.org> <20090108031655.GH10790@spearce.org>
	 <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-OcGlcTlRD2NbYB1FQqEG"
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Junio C Hamano <gitster@pobox.com>,
	Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 19:18:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKzRn-0006vh-Ch
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 19:17:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754802AbZAHSQM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jan 2009 13:16:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754425AbZAHSQJ
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Jan 2009 13:16:09 -0500
Received: from mx0.slide.com ([208.76.68.7]:41416 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752351AbZAHSQI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jan 2009 13:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=x
	4Hpeon6PZi/NwUF9XcD69KZzR1qjioro0z31bOefew=; b=n9kwXaDzpoRSLgPeT
	8Mc7aY6jBtMnokQh3w+hcLOqkH7eNRxCuCcvsNuHwHCiqsDWX0T90H83pivK0A89
	hsHu1WieYuqAzW77CXzsrLJaYBhFheRNoKPI7HNsXsxtbkJ957mXHNSzyJNQD+7M
	Ugi4rbm38hxHboHtOnanckePok=
Received: from nat3.slide.com ([208.76.69.126]:56518 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKzQA-0005mU-9Z; Thu, 08 Jan 2009 10:15:54 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 401393898319;
	Thu,  8 Jan 2009 10:15:54 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.96
X-Spam-Level: 
X-Spam-Status: No, score=-2.96 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.043, BAYES_00=-2.599,
	MIME_QP_LONG_LINE=1.396]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KpXbl523oqTb; Thu,  8 Jan 2009 10:15:53 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id B809A38980BE;
	Thu,  8 Jan 2009 10:15:53 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901071941210.3283@localhost.localdomain>
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104947>


--=-OcGlcTlRD2NbYB1FQqEG
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 19:54 -0800, Linus Torvalds wrote:
>=20
> On Wed, 7 Jan 2009, Shawn O. Pearce wrote:
> >
> > If we are running low on virtual memory we should release pack
> > windows if zlib's inflateInit fails due to an out of memory error.
> > It may be that we are running under a low ulimit and are getting
> > tight on address space.  Shedding unused windows may get us
> > sufficient working space to continue.
>=20
> Let's do this (more complete) wrapping instead, ok?
>=20
> This one _just_ wraps things, btw - it doesn't do the "retry on low memor=
y=20
> error" part, at least not yet. I think that's an independent issue from=20
> the reporting.
>=20
> Hmm?=20
>=20
> Tyler - does this make the corruption errors go away, and be replaced by=20
> hard failures with "out of memory" reporting?

Yeah, looks like it:


        tyler@grapefruit:~/source/git/linux-2.6> export
        START=3D56d18e9932ebf4e8eca42d2ce509450e6c9c1666
        tyler@grapefruit:~/source/git/linux-2.6> git reset --hard
        HEAD is now at 9e42d0c Merge
        git://git.kernel.org/pub/scm/linux/kernel/git/davem/sparc-2.6
        tyler@grapefruit:~/source/git/linux-2.6> git reset --hard $START
        HEAD is now at 56d18e9 Merge branch 'upstream' of
        git://ftp.linux-mips.org/pub/scm/upstream-linus
        tyler@grapefruit:~/source/git/linux-2.6> ulimit -v `echo "350 *
        1024" | bc -l`
        tyler@grapefruit:~/source/git/linux-2.6> limit
        cputime         unlimited
        filesize        unlimited
        datasize        unlimited
        stacksize       8MB
        coredumpsize    0kB
        memoryuse       2561MB
        maxproc         24564
        descriptors     1024
        memorylocked    64kB
        addressspace    350MB
        maxfilelocks    unlimited
        sigpending      24564
        msgqueue        819200
        nice            0
        rt_priority     0
        tyler@grapefruit:~/source/git/linux-2.6> git pull
        Updating 56d18e9..9e42d0c
        fatal: Out of memory? inflateInit failed
        tyler@grapefruit:~/source/git/linux-2.6> which git
        /home/tyler/bin/git
        tyler@grapefruit:~/source/git/linux-2.6>=20



>=20
> This patch is potentially pretty noisy, on purpose. I didn't remove the=20
> reporting from places that already do so - some of them have stricter=20
> errors than this.

I'm assuming this patch is going to be reworked, if so, I'll back it out
of our internal 1.6.1 build and anxiously await The Real Deal(tm)


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-OcGlcTlRD2NbYB1FQqEG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAklmQtgACgkQFCbH3D9R4W9ArACgsXd0d75p2/RAfeeF/xhBFJlG
388An2e9SKOKg233M/ErX2M3TWTVjL+5
=Ok/L
-----END PGP SIGNATURE-----

--=-OcGlcTlRD2NbYB1FQqEG--
