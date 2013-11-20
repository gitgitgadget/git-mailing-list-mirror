From: Matthew Cengia <mattcen@gmail.com>
Subject: Bizarre git merge behaviour
Date: Wed, 20 Nov 2013 03:49:36 +0000 (UTC)
Message-ID: <l6hbgg$oej$1@ger.gmane.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 20 04:55:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Viyt3-0003es-NO
	for gcvg-git-2@plane.gmane.org; Wed, 20 Nov 2013 04:55:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752173Ab3KTDzH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Nov 2013 22:55:07 -0500
Received: from plane.gmane.org ([80.91.229.3]:44994 "EHLO plane.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751771Ab3KTDzG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Nov 2013 22:55:06 -0500
Received: from list by plane.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1ViysZ-0003TN-Um
	for git@vger.kernel.org; Wed, 20 Nov 2013 04:55:03 +0100
Received: from c110-22-201-130.sunsh4.vic.optusnet.com.au ([110.22.201.130])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 04:55:03 +0100
Received: from mattcen by c110-22-201-130.sunsh4.vic.optusnet.com.au with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Nov 2013 04:55:03 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: c110-22-201-130.sunsh4.vic.optusnet.com.au
User-Agent: tin/1.9.6-20100522 ("Lochruan") (UNIX) (Linux/2.6.32-5-686 (i686))
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238066>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

The other day I was merging a feature branch (shown below as
origin/22869-new-kernel) into my staging release (shown below as 'wtf'),
and it *reverted* a bucket-load of changes I'd made on other branches
which had been merged into staging before. I can't for the life of me
work out why this happened, and would appreciate any ideas. Output below
shows symptoms:


  mattcen@sonar:prisonpc(wtf)$ git log --numstat --oneline origin/22869-new-kernel ^wtf | cat
  a8879c2 Oops, name .config consistently with deb.
  2797    0       client/kernel/config-3.5.7.20-1
  0       2797    client/kernel/config-3.5.7.21-1
  4c34686 Further lock down the inmate kernel.
  366     1094    client/kernel/config-3.5.7.21-1
  -       -       client/kernel/linux-firmware-image_3.5.7.21-1_i386.deb
  -       -       client/kernel/linux-image-3.5.7.20_3.5.7.20-1_i386.deb
  -       -       client/kernel/linux-image-3.5.7.21_3.5.7.21-1_i386.deb
  6       7       client/scm/50-kernel-prisoner.scm
  4a8acd0 Add build notes about how we generated these kernels.
  37      0       client/kernel/README
  e96adfe Merge remote-tracking branch 'origin/NNNNN-multicast-kernel' into 22869-new-kernel
  4b8afeb Merge commit '8ef01f2' into 22869-new-kernel
  fc4a5e6 Allow staff machines to receive IPTV stuff (per russm).
  1       0       client/scm/50-staff.scm
  117e646 Merge remote branch 'origin/staging' into NNNNN-multicast-kernel
  deb3b38 allow IGMP reports out through iptables
  1       0       client/scm/20-security.scm
  8ef01f2 Enable multicast in inmate kernel.
  0       3034    client/kernel/config-2.6.32.46+drm33.20
  3036    0       client/kernel/config-2.6.32.61+drm33.26
  -       -       client/kernel/linux-firmware-image_2.6.32.46+drm33.20-1_all.deb
  -       -       client/kernel/linux-firmware-image_2.6.32.61+drm33.26-1_all.deb
  -       -       client/kernel/linux-image-2.6.32.46+drm33.20_2.6.32.46+drm33.20-1_i386.deb
  -       -       client/kernel/linux-image-2.6.32.61+drm33.26_2.6.32.61+drm33.26-1_i386.deb
  11      11      client/scm/50-prisoner.scm
  mattcen@sonar:prisonpc(wtf)$ git merge origin/22869-new-kernel
  Auto-merging tca/parts.d/pxelinux-cfg
  Auto-merging pre-install.sh
  Removing ppcadm/templates/wwwfilter.tpl
  Removing ppcadm/templates/streaming_media.tpl
  Removing ppcadm/templates/disc_summary.tpl
  Removing ppcadm/templates/disc_access.tpl
  Auto-merging ppcadm/modules/quarantine.py
  CONFLICT (content): Merge conflict in ppcadm/modules/quarantine.py
  Auto-merging ppcadm/modules/media.py
  CONFLICT (content): Merge conflict in ppcadm/modules/media.py
  CONFLICT (modify/delete): ppcadm/modules/emailstats.py deleted in origin/22869-new-kernel and modified in HEAD. Version HEAD of ppcadm/modules/emailstats.py left in tree.
  Removing generate-mail-stats
  Removing doc/adminguide/images/streaming_media-screen.png
  Auto-merging debian/rules
  Auto-merging debian/prisonpc-internet.install
  CONFLICT (content): Merge conflict in debian/prisonpc-internet.install
  Auto-merging debian/prisonpc-core.cron.d
  Auto-merging debian/NEWS
  CONFLICT (content): Merge conflict in debian/NEWS
  Auto-merging client/scm/50-kernel-prisoner.scm
  CONFLICT (content): Merge conflict in client/scm/50-kernel-prisoner.scm
  Removing client/kernel/linux-image-3.5.7.21_3.5.7.21-1_i386.deb
  Removing client/kernel/linux-firmware-image_3.5.7.21-1_i386.deb
  Auto-merging client/kernel/config-3.5.7.20-1
  Resolved 'client/scm/50-kernel-prisoner.scm' using previous resolution.
  Resolved 'debian/NEWS' using previous resolution.
  Resolved 'debian/prisonpc-internet.install' using previous resolution.
  Resolved 'ppcadm/modules/media.py' using previous resolution.
  Resolved 'ppcadm/modules/quarantine.py' using previous resolution.
  Automatic merge failed; fix conflicts and then commit the result.
  mattcen@sonar:prisonpc(wtf)$ git status --porcelain
  M  client/kernel/README
  R  client/kernel/config-3.5.7.21-1 -> client/kernel/config-3.5.7.20-1
  D  client/kernel/linux-firmware-image_3.5.7.21-1_i386.deb
  A  client/kernel/linux-image-3.5.7.20_3.5.7.20-1_i386.deb
  D  client/kernel/linux-image-3.5.7.21_3.5.7.21-1_i386.deb
  M  client/scm/20-security.scm
  M  client/scm/30-apps.scm
  UU client/scm/50-kernel-prisoner.scm
  M  client/scm/50-staff.scm
  UU debian/NEWS
  M  debian/changelog
  M  debian/prisonpc-core.cron.d
  UU debian/prisonpc-internet.install
  M  debian/rules
  A  doc/adminguide/images/streaming_media-screen.jpg
  D  doc/adminguide/images/streaming_media-screen.png
  M  doc/adminguide/images/web_filtering.png
  M  doc/adminguide/streaming_media.rst
  M  doc/adminguide/system-status.rst
  M  doc/adminguide/web_filtering.rst
  M  dovecot/dovecot-staff.conf
  M  eric/apps/complain.py
  M  eric/apps/links.py
  M  eric/apps/media.py
  M  eric/apps/whitelist.py
  M  eric/eric
  M  eric/eric_cfg.py
  D  generate-mail-stats
  M  ppcadm/modules/disc_access.py
  UD ppcadm/modules/emailstats.py
  UU ppcadm/modules/media.py
  UU ppcadm/modules/quarantine.py
  M  ppcadm/modules/wwwfilter.py
  M  ppcadm/resources/admin.css
  D  ppcadm/templates/disc_access.tpl
  D  ppcadm/templates/disc_summary.tpl
  M  ppcadm/templates/home.tpl
  D  ppcadm/templates/streaming_media.tpl
  M  ppcadm/templates/user.tpl
  D  ppcadm/templates/wwwfilter.tpl
  M  pre-install.sh
  M  tca/parts.d/pxelinux-cfg
  ?? old/
  ?? paste
  mattcen@sonar:prisonpc(wtf)$

- -- 
Regards,
Matthew Cengia
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iQJ8BAEBCgBmBQJSjDFAXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXQwMjI1MjY2QUFCMThBOUQwNEMxOUQ0QjY3
QTdFMzdGMzNCMjI3MkU4AAoJEHp+N/M7InLoJ5UP/0Ws9afdJjQ7h7qP/EQuOOcq
zB/caURaNJbrqioZ/leaLTPKEeSLLL0p27Rooa+dt20qQU4Iq8I5K8tDPau5dh9z
L6AnX1i5nS6Qikz6xqgBpfnnm8MYy/Bi9iW1o8k3lZrNuoVnmrqav/JxrygQLRFv
HEtB5nGAOdsONtlFnGd7QrErf6d+bU5yCE1bN2CDwGYwghl/ApvCIMk16iRiguDA
XmMGl3Y7agQHCOiy8ghCnDwq125BBKpIhLbV485YTTM+4SvbSAwfAWy9ja3KGYO/
hmQeKmKTs3jgJhlV8qNFPCBVbuX6GgQCZeafd0aCK/taJY7AtFcn0aPQL7/d8cSc
5mE0g7Cs2BAUEiN+whYaQbUPjLs5WX8ACqSpQY1eC+dQFVJcr5enQ65bsNqy0TXb
vMmYzT5XHiMnkusdU3gC7D8yhOO0V4JYvPp+o7BEVqAKpwP4tuC3F8shsKXnIK1y
m4aQDmQAVPBcC33FtgZNLlGR7XO5OC47xKfuCmBgxLhyiYb979HUZKm3vktKsDra
ghp6I/TV7i4kkETb9/h5U4mIoTXEtdA1fyvverE+6s4gMx6C+vn10GbB2z898cuT
7OXYMONkcR+r8XtXm0/h5d64Zn82Xk/x52a/eHD6PgAvsfM3RwMiWAVVAKeRxrD9
IvjRBri6se6aBkdL+z9v
=sMCO
-----END PGP SIGNATURE-----
