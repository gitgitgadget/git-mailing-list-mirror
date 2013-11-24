From: =?utf-8?B?UGF3ZcWC?= Sikora <pawel.sikora@agmk.net>
Subject: slow git-cherry-pick.
Date: Sun, 24 Nov 2013 11:45:32 +0100
Message-ID: <2142926.gg3W3MsbJZ@localhost.localdomain>
Reply-To: pawel.sikora@agmk.net
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Nov 24 12:07:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VkXX5-0002cr-IU
	for gcvg-git-2@plane.gmane.org; Sun, 24 Nov 2013 12:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751964Ab3KXLHK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Nov 2013 06:07:10 -0500
Received: from adamg.eu ([91.192.224.99]:60107 "EHLO adamg.eu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751793Ab3KXLHI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Nov 2013 06:07:08 -0500
X-Greylist: delayed 1283 seconds by postgrey-1.27 at vger.kernel.org; Sun, 24 Nov 2013 06:07:08 EST
Received: from mail.agmk.net ([91.192.224.71]:42449)
	by adamg.eu with esmtp (Exim 4.82)
	(envelope-from <pluto@agmk.net>)
	id 1VkXCA-0004fP-7c
	for git@vger.kernel.org; Sun, 24 Nov 2013 11:45:42 +0100
Received: from localhost.localdomain (unknown [185.28.248.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	(Authenticated sender: pluto@agmk.net)
	by mail.agmk.net (Postfix) with ESMTPSA id 20F571EE0F52
	for <git@vger.kernel.org>; Sun, 24 Nov 2013 11:45:32 +0100 (CET)
User-Agent: KMail/4.11.3 (Linux/3.11.8-300.fc20.x86_64; KDE/4.11.3; x86_64; ; )
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238255>

Hi,

i've recently reinstalled a fresh system (fc20-beta) on my workstation
and observing a big slowdown on git cherry-pick operation (git-1.8.4.2-=
1).
the previous centos installation with an old git version works faster
(few seconds per cherry pick). now the same operation takes >1 min.

my git repo isn't very big[1] but it's checked out on the linear lvm
where random i/o generally hurts and strace shows that current git vers=
ion
performs 2x{lstat}+1x{open,read,close} [2] on whole checkout before
cherry-pick. there is also a .gitattributes searching on all levels
which doing another tons of i/o. looks like git-status on action but
why on whole repo while cherry-pick touches limited set of files?

is it a bug or feature?

BR,
Pawe=C5=82.

please CC me on reply.


[1]
$ du -sh .git/objects/
4.2G    .git/objects/
$ find sources -type f|wc -l
9536
$ find buildenv -type f|wc -l
14637

[2]
lstat("buildenv/boost-1.51.0/include/boost/bimap.hpp", {st_mode=3DS_IFR=
EG|0664,=20
st_size=3D387, ...}) =3D 0
lstat("buildenv/boost-1.51.0/include/boost/bimap.hpp", {st_mode=3DS_IFR=
EG|0664,=20
st_size=3D387, ...}) =3D 0
open("buildenv/boost-1.51.0/include/boost/bimap.hpp", O_RDONLY) =3D 5
read(5, "// Boost.Bimap\n//\n// Copyright ("..., 387) =3D 387
close(5)

--=20
gpg key fingerprint =3D 60B4 9886 AD53 EB3E 88BB  1EB5 C52E D01B 683B 9=
411
