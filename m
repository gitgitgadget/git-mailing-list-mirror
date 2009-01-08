From: "R. Tyler Ballance" <tyler@slide.com>
Subject: Public repro case! Re: [PATCH/RFC] Allow writing loose objects
 that are corrupted in a pack file
Date: Wed, 07 Jan 2009 16:28:34 -0800
Organization: Slide, Inc.
Message-ID: <1231374514.8870.621.camel@starfruit>
References: <20081209093627.77039a1f@perceptron>
	 <1231282320.8870.52.camel@starfruit>
	 <alpine.LFD.2.00.0901062005290.26118@xanadu.home>
	 <1231292360.8870.61.camel@starfruit>
	 <alpine.LFD.2.00.0901062026500.3057@localhost.localdomain>
	 <1231314099.8870.415.camel@starfruit>
	 <alpine.LFD.2.00.0901070743070.3057@localhost.localdomain>
	 <1231368935.8870.584.camel@starfruit>
	 <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-1Q43gnNi5gwpVcJTG9x+"
Cc: Nicolas Pitre <nico@cam.org>,
	Jan =?ISO-8859-1?Q?Kr=FCger?= <jk@jk.gs>,
	Git ML <git@vger.kernel.org>, kb@slide.com
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jan 08 01:30:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LKimm-0003JJ-HR
	for gcvg-git-2@gmane.org; Thu, 08 Jan 2009 01:30:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753787AbZAHA2p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 Jan 2009 19:28:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753003AbZAHA2o
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Jan 2009 19:28:44 -0500
Received: from mx0.slide.com ([208.76.68.7]:58380 "EHLO mx0.slide.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752464AbZAHA2n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Jan 2009 19:28:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=slide.com; s=slideinc; h=Subject:From:To:Date:Message-Id; bh=r
	KlhKMJkLFi9UEebhOYSPN5zvYM2gPBEuQbHNqQoXKM=; b=Inz19zvnqgSbwyK5s
	aHBYBFsUGVtxJJODwKoqWaNWFSNp+/zK8ETV165aBmIrJ3trVMtFHR5n3WqI8yq8
	XhUYFBbSjpwiIMXWrQSGLWiPZQ/t+5mApcBSV3YUjVRd/C1ly1boMs4uwqiBFzlv
	z4GhtaUx0NFJhRPKyQdUQ1dOtU=
Received: from nat3.slide.com ([208.76.69.126]:43654 helo=calculon.corp.slide.com)
	by mx0.slide.com with esmtp (Exim 4.69 #1)
	id 1LKilI-0004yu-CV; Wed, 07 Jan 2009 16:28:36 -0800
Received: from localhost (localhost.localdomain [127.0.0.1])
	by calculon.corp.slide.com (Postfix) with ESMTP id 5CE803898BB3;
	Wed,  7 Jan 2009 16:28:36 -0800 (PST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.457
X-Spam-Level: 
X-Spam-Status: No, score=-3.457 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.942, BAYES_00=-2.599]
Received: from calculon.corp.slide.com ([127.0.0.1])
	by localhost (calculon.corp.slide.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8sS3kZXhwCnZ; Wed,  7 Jan 2009 16:28:35 -0800 (PST)
Received: from [10.10.8.190] (dhcp-10-10-8-190.corp.slide.com [10.10.8.190])
	by calculon.corp.slide.com (Postfix) with ESMTP id A85C13898B8A;
	Wed,  7 Jan 2009 16:28:35 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0901071520330.3057@localhost.localdomain>
X-Priority: 1
X-Mailer: Evolution 2.24.1.1 
X-Content-Bypass: Bypassed by sending host IP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104857>


--=-1Q43gnNi5gwpVcJTG9x+
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2009-01-07 at 15:29 -0800, Linus Torvalds wrote:
> It is certainly possible. It's too bad that it's private, because it make=
s=20
> it _much_ harder to try to pinpoint this.

My most esteemed colleague (Ken aka kb) who pointed out the memory issue
was on the right path (I think), and I have a reproduction case you can
try with your very own Linux kernel tree!

WOO!

I set ulimit -v really low (150M), and the operations I made got an
mmap(2) fatal error, but there is a sweet spot that I found, see the
transcript below. I basically chose an arbitrary revision from a couple
of weeks ago, and rolled the repository back to that point, then I tried
with iterations of ulimit -v 150, 250, 450, and then back down to 350.

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
        addressspace    unlimited
        maxfilelocks    unlimited
        sigpending      24564
        msgqueue        819200
        nice            0
        rt_priority     0
        tyler@grapefruit:~/source/git/linux-2.6> export
        START=3D56d18e9932ebf4e8eca42d2ce509450e6c9c1666
        tyler@grapefruit:~/source/git/linux-2.6> git reset --hard $START
        HEAD is now at 56d18e9 Merge branch 'upstream' of
        git://ftp.linux-mips.org/pub/scm/upstream-linus
        tyler@grapefruit:~/source/git/linux-2.6> ulimit -v `echo "350 *
        1024" | bc -l`
        tyler@grapefruit:~/source/git/linux-2.6> git pull
        error: failed to read object
        be1b87c70af69acfadb8a27a7a76dfb61de92643 at offset 1850923
        from .git/objects/pack/pack-dbe154052997a05499eb6b4fd90b924da68e799=
a.pack
        fatal: object be1b87c70af69acfadb8a27a7a76dfb61de92643 is
        corrupted
        tyler@grapefruit:~/source/git/linux-2.6>
       =20
I've tried this a couple of times, and it does seem to be reproducible,
let me know if you have any issues reproducing it locally and I'll try
to dig into it more with valgrind or something a bit more pin-pointing
than "ulimit -v && try, try again"


Cheers
--=20
-R. Tyler Ballance
Slide, Inc.

--=-1Q43gnNi5gwpVcJTG9x+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkllSLIACgkQFCbH3D9R4W8HcQCeKRQxeYXwcXIrYpPD/JYozMSd
ojAAnjsIhGefhZMIFX7aapYkE+1lfzcc
=dB7k
-----END PGP SIGNATURE-----

--=-1Q43gnNi5gwpVcJTG9x+--
