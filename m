From: Sergey Vlasov <vsu@altlinux.ru>
Subject: gitk merge display bugs (was: Re: Display of merges in gitk)
Date: Sat, 30 Jul 2005 18:32:33 +0400
Message-ID: <20050730183233.572939be.vsu@altlinux.ru>
References: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1";
 boundary="Signature=_Sat__30_Jul_2005_18_32_33_+0400_QqxH9Sbj.p34CtEG"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 30 16:33:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DysP1-0004Eg-Sq
	for gcvg-git@gmane.org; Sat, 30 Jul 2005 16:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262971AbVG3OdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jul 2005 10:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262969AbVG3OdP
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jul 2005 10:33:15 -0400
Received: from mail.murom.net ([213.177.124.17]:34452 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S262971AbVG3OdB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Jul 2005 10:33:01 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1DysOV-0006Dw-9H; Sat, 30 Jul 2005 18:32:55 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 62B12E49D55; Sat, 30 Jul 2005 18:32:37 +0400 (MSD)
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17130.56620.137642.941175@cargo.ozlabs.ibm.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i586-alt-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--Signature=_Sat__30_Jul_2005_18_32_33_+0400_QqxH9Sbj.p34CtEG
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Fri, 29 Jul 2005 20:51:40 -0500 Paul Mackerras wrote:

> I have reworked the way gitk displays merges.

I have found a reproducible bug in gitk which seems to be in that new
code for merges.  Run

	gitk f4b3a4c30b5ea3a5de2a2597a3c53266017d02ba

on the git or cogito repository (that commit is from 2005-07-05), then
click the topmost commit ("Merge with Linus' current tree"), then click
it again - you get an error popup with this trace:

can't read "filelines(f13bbe7f56e49a11f6bfc3b73a463c741f969c9c,0,137)": no such element in array
can't read "filelines(f13bbe7f56e49a11f6bfc3b73a463c741f969c9c,0,137)": no such element in array
    while executing
"$ctext insert end "-$filelines($p,$f,$ol)\n" m$pnum"
    (procedure "processgroup" line 143)
    invoked from within
"processgroup"
    (procedure "processhunks" line 47)
    invoked from within
"processhunks"
    (procedure "getmergediffline" line 81)
    invoked from within
"getmergediffline file10 {f4b3a4c30b5ea3a5de2a2597a3c53266017d02ba f13bbe7f56e49a11f6bfc3b73a463c741f969c9c} f4b3a4c30b5ea3a5de2a2597a3c53266017d02ba"

Another badness which appears with the same repository: run

	gitk f13bbe7f56e49a11f6bfc3b73a463c741f969c9c

then repeated clicks on the topmost commit result in a different diff
shown (no error popups, however).

Also if I quickly move between commits, sometimes I get error popups
like:

can't unset "treepending": no such variable
    while executing
"unset treepending"
    (procedure "gettreediffline" line 9)
    invoked from within
"gettreediffline file30 {429a9358763dfb98cd063e40dc49cbc049e2a268 154d3d2dd2656c23ea04e9d1c6dd4e576a7af6de}"

This error does not happen again if the same commit is selected.

All this happens both with current cogito
(134b78a167b5f77725cd8435849de7298b6de477) and git
(9e44f8980b8f41fbeea0a68035865e5778e4dc7d).

--Signature=_Sat__30_Jul_2005_18_32_33_+0400_QqxH9Sbj.p34CtEG
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC64+FW82GfkQfsqIRAj+wAJ9YF2r4lbeq4QzOPI498sGAaECgTACgjAf3
aPPpE+mje+SESB6DJuzipwc=
=Xgz9
-----END PGP SIGNATURE-----

--Signature=_Sat__30_Jul_2005_18_32_33_+0400_QqxH9Sbj.p34CtEG--
