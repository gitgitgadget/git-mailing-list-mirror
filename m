From: Benoit Sigoure <tsuna@lrde.epita.fr>
Subject: BUG in gitk (was: Re: BUG: git-svn does not escape literal backslashes in author names.)
Date: Sat, 17 Nov 2007 21:18:39 +0100
Message-ID: <37A0587D-2C1A-4180-A724-2E7B338465D9@lrde.epita.fr>
References: <1213a9470711120628l4ccab632n17635295ec897a2@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-4-127671525"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Adrian Wilkins <adrian.wilkins@gmail.com>
X-From: git-owner@vger.kernel.org Sat Nov 17 21:21:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ItUA3-0002VR-Uj
	for gcvg-git-2@gmane.org; Sat, 17 Nov 2007 21:21:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762666AbXKQUUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 17 Nov 2007 15:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759143AbXKQUUi
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Nov 2007 15:20:38 -0500
Received: from postfix2-g20.free.fr ([212.27.60.43]:57061 "EHLO
	postfix2-g20.free.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762761AbXKQUUh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Nov 2007 15:20:37 -0500
Received: from smtp6-g19.free.fr (smtp6-g19.free.fr [212.27.42.36])
	by postfix2-g20.free.fr (Postfix) with ESMTP id 75BC71EDC7B8
	for <git@vger.kernel.org>; Sat, 17 Nov 2007 19:19:41 +0100 (CET)
Received: from smtp6-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp6-g19.free.fr (Postfix) with ESMTP id C3F6C5FE39;
	Sat, 17 Nov 2007 21:18:54 +0100 (CET)
Received: from [192.168.0.7] (rob76-3-82-235-3-5.fbx.proxad.net [82.235.3.5])
	by smtp6-g19.free.fr (Postfix) with ESMTP id 85C705FD80;
	Sat, 17 Nov 2007 21:18:54 +0100 (CET)
In-Reply-To: <1213a9470711120628l4ccab632n17635295ec897a2@mail.gmail.com>
X-Pgp-Agent: GPGMail 1.1.2 (Tiger)
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65302>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--Apple-Mail-4-127671525
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed

On Nov 12, 2007, at 3:28 PM, Adrian Wilkins wrote:

> Recently converted a large (11,000+ revisions) repository.
>
> We authenticate against the NT domain controller, so all our revision
> authors are of the form "domain\user". (You can switch off mod_sspi
> reporting the domain part, but I didn't know about this at the time,
> so it continues for historical reasons.)
>
> git-svn treats the literal backslashes in the author names as escapes.
> This leads to authors like
>
> domainkevin
> domain\
> ichard

Hi Adrian,
I tried to reproduce the error but didn't succeed (see below).  Which  
version of Git did you use?

However, gitk fails to properly render the various properties when  
they contain backslash sequences.  If a gitk expert could have a  
look, I tried but didn't find a standard Tcl procedure to escape  
everything properly and I didn't feel like recoding my own procedure  
because I guess this already exists...

Cheers,


$ svnadmin create repo
$ svn co file://`pwd`/repo wc
Checked out revision 0.
$ cd wc
$ svn mkdir trunk tags branches
A         trunk
A         tags
A         branches
$ svn ci -m stdlayout
Adding         branches
Adding         tags
Adding         trunk

Committed revision 1.
$ cd trunk
$ touch plop && svn add plop
A         plop
$ svn ci -m test --username 'domain\name\richard\test\\ok'
Adding         trunk/plop
Transmitting file data .
Committed revision 2.
$ cd ../..
$ git svn clone --stdlayout file://`pwd`/repo git
Initialized empty Git repository in .git/
r1 = dc86087745d9b6378114f49c1e480d178cf328f9 (trunk)
         A       plop
r2 = de5affcfdc897bfa77a2402a447771f0a88b04bf (trunk)
Checked out HEAD:
   file:///tmp/repo/trunk r2
$ cd git
$ git log
commit de5affcfdc897bfa77a2402a447771f0a88b04bf
Author: domain\name\richard\test\\ok <domain\name\richard\test\ 
\ok@e88f2f36-2641-46fb-97e4-5fd9951470b2
Date:   Sat Nov 17 12:17:29 2007 +0000

     test

     git-svn-id: file:///tmp/repo/trunk@2  
e88f2f36-2641-46fb-97e4-5fd9951470b2

commit dc86087745d9b6378114f49c1e480d178cf328f9
Author: tsuna <tsuna@e88f2f36-2641-46fb-97e4-5fd9951470b2>
Date:   Sat Nov 17 12:16:29 2007 +0000

     stdlayout

     git-svn-id: file:///tmp/repo/trunk@1  
e88f2f36-2641-46fb-97e4-5fd9951470b2
$ gitk # Oops

-- 
Benoit Sigoure aka Tsuna
EPITA Research and Development Laboratory



--Apple-Mail-4-127671525
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (Darwin)

iD8DBQFHP0yfwwE67wC8PUkRAhMaAJ9Zjr8v7g3NwOqmdwm7kQh8GwoZQwCeNoP2
xDaOEjlwMp4r/5uRrwBt4Sw=
=MyuC
-----END PGP SIGNATURE-----

--Apple-Mail-4-127671525--
