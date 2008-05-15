From: "=?ISO-8859-1?Q?Jo=E3o_Abecasis?=" <joao@abecasis.name>
Subject: git-svn condenses history when dcommit is interrupted
Date: Thu, 15 May 2008 04:06:33 -0500
Message-ID: <7bf6f1d20805150206j231eeea6pb7c608a713dd202c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 15 11:09:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwZQv-0006ox-HW
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 11:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751835AbYEOJGj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 May 2008 05:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752048AbYEOJGj
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 05:06:39 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:12742 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751640AbYEOJGh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 05:06:37 -0400
Received: by ug-out-1314.google.com with SMTP id h2so1332883ugf.16
        for <git@vger.kernel.org>; Thu, 15 May 2008 02:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=EGxKUP0XQfOLJWuCKYVPrsU2v5dd7ftp2X/YkhCkZf0=;
        b=XlrAaSvchmSv0x2KY++lZ1TZb3P3HY3pdeUgRjqCb4RoUAfAZKbqNN9717/rCX3yEX9tjWsCy0BAGV78odopNRbERO5MfMHKKeUcw68zLvxHqb1ZUO83gPIBLJ0fAG+4VsDsWwJDEUWcNWZfTNI+Ajngt9j8EOtaVdbzfgK1oAc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=f8XX6b7ztiAH9R6Cziy0hI1ig7Un03BO5Kn50DJyKr+Kgq4UEQUklj2CJ+67RVNrFRdLGUPAieD5zfoEBJxaR4Rq+KtmjPPSnsruaagm5aZKK2+QBcv2x5qAoTpvHMcaVrepg1trA5zwRKc1GY8TJn7ppS2fgkKdddYFYh3YJGU=
Received: by 10.66.219.3 with SMTP id r3mr9937513ugg.50.1210842393360;
        Thu, 15 May 2008 02:06:33 -0700 (PDT)
Received: by 10.66.225.9 with HTTP; Thu, 15 May 2008 02:06:33 -0700 (PDT)
Content-Disposition: inline
X-Google-Sender-Auth: 1daf9f2edf8f8630
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82193>

Hi,

I hope this is the right list for reporting git-svn issues, if it
isn't, please direct me to a more appropriate place. Thanks!

When a git-svn dcommit is interrupted after a commit is submitted to
the subversion server, but before the local history is reconciled,
that commit is lost from the history. Instead, changes are condensed
into the next commit git-svn sees on the server.

Given my current flakey internet connection, unfortunately, I've been
given the chance to see this happen a couple of times, already. Some
output I gathered the last time this occured can be found below. In
case it matters, this was on Mac OS X 10.5.2.


[ The versions ]


$ git --version
git version 1.5.5
$ svn --version
svn, version 1.4.4 (r25188)
   compiled Nov 25 2007, 08:20:33

Copyright (C) 2000-2006 CollabNet.
Subversion is open source software, see http://subversion.tigris.org/
This product includes software developed by CollabNet (http://www.Colla=
b.Net/).

The following repository access (RA) modules are available:

* ra_dav : Module for accessing a repository via WebDAV (DeltaV) protoc=
ol.
  - handles 'http' scheme
  - handles 'https' scheme
* ra_svn : Module for accessing a repository using the svn network prot=
ocol.
  - handles 'svn' scheme
* ra_local : Module for accessing a repository on local disk.
  - handles 'file' scheme


[ The issue: I had 2 pending commits on my tree. Something happens
halfway through the first commit, after it has been registered with
the server ]


$ git svn dcommit
Committing to https://svn.cct.lsu.edu/repos/saga/trunk ...
	M	external/boost/plugin/boost/plugin/config.hpp
Committed r1731
	M	external/boost/plugin/boost/plugin/config.hpp
RA layer request failed: PROPFIND request failed on '/repos/saga':
PROPFIND of '/repos/saga': SSL negotiation failed: Secure connection
truncated (https://svn.cct.lsu.edu) at /usr/local/git/bin/git-svn line
2475

$ git svn dcommit
Committing to https://svn.cct.lsu.edu/repos/saga/trunk ...
Merge conflict during commit: Your file or directory
'external/boost/plugin/boost/plugin/config.hpp' is probably
out-of-date: The version resource does not correspond to the resource
within the transaction.  Either the requested version resource is out
of date (needs to be updated), or the requested version resource is
newer than the transaction root (restart the commit). at
/usr/local/git/bin/git-svn line 453

$ git svn fetch
W: Ignoring error from SVN, path probably does not exist: (175002): RA
layer request failed: PROPFIND request failed on '/repos/saga':
PROPFIND of '/repos/saga': Could not read status line: SSL error:
sslv3 alert bad record mac (https://svn.cct.lsu.edu)
W: Do not be alarmed at the above message git-svn is just searching
aggressively for old history.
This may take a while on large repositories
Path '' was probably deleted:
RA layer request failed: PROPFIND request failed on '/repos/saga':
PROPFIND of '/repos/saga': Could not read status line: SSL error:
sslv3 alert bad record mac (https://svn.cct.lsu.edu)
Will attempt to follow revisions r1730 .. r1731 committed before the de=
letion
r1730 .. r1730 OK
$ git svn fetch
$


[ At this point, git-svn wouldn't commit the second patch, nor would
it fetch the one it had committed earlier. I resorted to committing
the second patch using plain svn. After that... ]


$ git svn fetch
Index mismatch: 0948c9dd98f0b0578aa151c5a074a89268ae5470 !=3D
c22e958474fbfe55c807068cd230b550a23cab3c
rereading 0b7d73659df689e9baf585e117e6fec7d6b2c81e
	M	external/boost/plugin/boost/plugin/config.hpp
	M	bindings/saga/C/engine/saga_c_export_declarations.h
r1732 =3D dabf31cc720d31b75f6070490156a8165ec6c3b4 (trunk)
$


[ r1732 was actually a change to saga_c_export_declarations.h alone,
but now it shows up merged with r1731 :-/ ]


Is there any further info I can provide that could help?

Did I do something wrong? Are there any steps I can take after dcommit
breaks to avoid this issue? The last time this happened, I ended up
cloning the svn repository afresh and have a backup available, but
would rather find a better way to fix this.

Any help appreciated. Thanks!


Jo=E3o
