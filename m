X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Subject: reexporting git repository via git-daemon
Date: Fri, 8 Dec 2006 22:12:09 +0100
Organization: SelfOrganizing
Message-ID: <200612082212.09682.arekm@maven.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
NNTP-Posting-Date: Fri, 8 Dec 2006 21:12:26 +0000 (UTC)
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
User-Agent: KMail/1.9.5
Content-Disposition: inline
X-Authenticated-Id: arekm
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33745>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1Gsn10-00061r-9u for gcvg-git@gmane.org; Fri, 08 Dec
 2006 22:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1761217AbWLHVMP convert rfc822-to-quoted-printable (ORCPT
 <rfc822;gcvg-git@m.gmane.org>); Fri, 8 Dec 2006 16:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759692AbWLHVMO
 (ORCPT <rfc822;git-outgoing>); Fri, 8 Dec 2006 16:12:14 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:39748 "EHLO
 outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with
 ESMTP id S1761217AbWLHVMN convert rfc822-to-8bit (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 8 Dec 2006 16:12:13 -0500
Received: from [83.11.55.173] (helo=[192.168.0.64]) by tekla.agnat.pl with
 esmtpsa (TLSv1:DHE-RSA-AES256-SHA:256) (Exim 4.63) (envelope-from
 <arekm@maven.pl>) id 1Gsn0t-0005iS-BO for git@vger.kernel.org; Fri, 08 Dec
 2006 22:12:11 +0100
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org


Hi,

I have weird problem wit git (1.4.4.2).

 git --bare clone git://git.kernel.org/pub/scm/git/git.git
fetches everything correctly;

$ cd /tmp
$ git clone /gitroot/home/gitrepo/git
remote: Generating pack...
remote: Done counting 33527 objects.
remote: Deltifying 33527 objects.
remote:  100% (33527/33527) done
Indexing 33527 objects.
remote: Total 33527, written 33527 (delta 23162), reused 33527 (delta 2=
3162)
 100% (33527/33527) done
Resolving 23162 deltas.
 100% (23162/23162) done
Checking files out...
 100% (743/743) done
$

also correctly fetched. The problem begins with exporting that cloned r=
epo=20
once again via git-daemon:

$ git clone git://git.my-server/git
fatal: unexpected EOF
fetch-pack from 'git://git.my-server/git' failed.

strace on git-daemon side:
[...]
18241 lstat("refs/tags/v1.4.1-rc2", {st_mode=3DS_IFREG|0644, st_size=3D=
41, ...}) =3D=20
0
18241 open("refs/tags/v1.4.1-rc2", O_RDONLY) =3D 7
18241 read(7, "33c9db007159db11c1ad5fa7101ea95853740acf\n", 255) =3D 41
18241 close(7)                          =3D 0
18241 write(1, "004233c9db007159db11c1ad5fa7101ea95853740acf=20
refs/tags/v1.4.1-rc2\n", 66) =3D 66
18241 write(1, "0045abc02670169cee9541793a86324a014272ca8ed5=20
refs/tags/v1.4.1-rc2^{}\n", 69) =3D 69
18241 stat("refs/tags/v1.4.1.1", {st_mode=3DS_IFREG|0644, st_size=3D41,=
 ...}) =3D 0
18241 lstat("refs/tags/v1.4.1.1", {st_mode=3DS_IFREG|0644, st_size=3D41=
, ...}) =3D 0
18241 open("refs/tags/v1.4.1.1", O_RDONLY) =3D 7
18241 read(7, "8419a453dc088b25b63ab1746d3d7e679caf686d\n", 255) =3D 41
18241 close(7) =20
18241 write(1, "00408419a453dc088b25b63ab1746d3d7e679caf686d=20
refs/tags/v1.4.1.1\n", 64) =3D 64
18241 write(2, "fatal: ", 7)            =3D 7
18241 write(2, "corrupted pack=20
file ./objects/pack/pack-0bb22295a585ac173504a2f8dfb3e31e074a8715.pack"=
, 85)=20
=3D 85
18241 write(2, "\n", 1)  =20

100% repeatable at this moment. Any ideas?

ps. verification for initial  git://git.kernel.org/pub/scm/git/git.git =
clone:
git]$ git --bare fsck-objects
fatal: Not a git repository: '/gitroot/home/gitrepo/git'
git]$ git fsck-objects
git]$
=20
--=20
Arkadiusz Mi=B6kiewicz        PLD/Linux Team
