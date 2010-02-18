From: martin f krafft <madduck@madduck.net>
Subject: Using trees for metatagging
Date: Thu, 18 Feb 2010 17:12:40 +1300
Message-ID: <20100218041240.GA4127@lapse.rw.madduck.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-ripemd160;
	protocol="application/pgp-signature"; boundary="45Z9DzgjV8m4Oswq"
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 18 05:12:50 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nhxkw-00010N-7D
	for gcvg-git-2@lo.gmane.org; Thu, 18 Feb 2010 05:12:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752569Ab0BREMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2010 23:12:45 -0500
Received: from clegg.madduck.net ([193.242.105.96]:35689 "EHLO
	clegg.madduck.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801Ab0BREMo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2010 23:12:44 -0500
Received: from lapse.rw.madduck.net (unknown [IPv6:2404:130:0:1000:20a:e4ff:fe30:4316])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "lapse.rw.madduck.net", Issuer "CAcert Class 3 Root" (verified OK))
	by clegg.madduck.net (postfix) with ESMTPS id B8F4A1D409C
	for <git@vger.kernel.org>; Thu, 18 Feb 2010 05:12:39 +0100 (CET)
Received: by lapse.rw.madduck.net (Postfix, from userid 1000)
	id B4AA324C; Thu, 18 Feb 2010 17:12:40 +1300 (NZDT)
Mail-Followup-To: git discussion list <git@vger.kernel.org>
Content-Disposition: inline
X-Motto: Keep the good times rollin'
X-OS: Debian GNU/Linux squeeze/sid kernel 2.6.32-1-686 i686
X-Spamtrap: madduck.bogus@madduck.net
X-Subliminal-Message: debian/rules!
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Virus-Scanned: clamav-milter 0.95.3 at clegg
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140294>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Git's object store uses trees mainly to represent a hierarchical
filesystem. It occurs to me that you could layer additional
hierarchies on top =E2=80=94 specifically, you could use it to track subsets
of files, i.e. "tagging".

For instance you want some sort of representation for "the set of
files that need review". You /could/ create a new tree and reference
all files in that set as children. Now if you wanted to find out
what to review, you'd list the children of this tree. After
reviewing a file, you write a new tree with the set less that file's
ref.. Obviously, if you made changes to the file, it should be
reconnected to all other trees that referenced it.

I have a couple of questions about this:

1. Does Git provide plumbing for me to find out which trees
   reference a given blob? If not, I will have to iterate all trees
   and record which ones have a given message as a child.

2. Is there a way you can fathom by which unlinking a blob from the
   main hierarchy also causes it to be unlinked from this meta tree
   I am speaking of as well? Similarly, if a blob is rewritten, how
   could I make sure it replaces the old blob in all referencing
   trees?

3. Am I right in assuming that I'd have to track a completely
   seperate ancestry for this tree, that is create e.g. a commit
   object, point refs/metatrees/mytree to it, and reference the tree
   from the commit?

4. Since this hierarchy is not really to be mapped into the
   filesystem, how would one resolve conflicts when merging
   ancestries? Of course it would be nice if I could check out this
   meta tree into the filesystem, make changes, and be assured that
   new blobs replace old blobs in other referencing trees, as per
   (2.), but that's a pipedream maybe.

5. Do you know of similar efforts? Are there must-reads out there,
   apart from the design of Git?

Thank you,

--=20
martin | http://madduck.net/ | http://two.sentenc.es/
=20
kill ugly radio
                                                        -- frank zappa
=20
spamtraps: madduck.bogus@madduck.net

--45Z9DzgjV8m4Oswq
Content-Type: application/pgp-signature; name="digital_signature_gpg.asc"
Content-Description: Digital signature (see http://martin-krafft.net/gpg/)
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEAREDAAYFAkt8vjgACgkQIgvIgzMMSnXfxwCgvCc9i8XRrdgQx3uSU2w6rCvZ
Jb4An33xC5wTfdjbu+ZwdyW9YxCYAK/7
=c5m3
-----END PGP SIGNATURE-----

--45Z9DzgjV8m4Oswq--
