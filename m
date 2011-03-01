From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 0/2] no-op shell script i18n infrastructure
Date: Tue,  1 Mar 2011 22:49:35 +0000
Message-ID: <1299019777-19033-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 01 23:49:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYO7-0003pk-2i
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:49:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755604Ab1CAWtq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Mar 2011 17:49:46 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:43216 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755336Ab1CAWtp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:49:45 -0500
Received: by bwz15 with SMTP id 15so5073648bwz.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 14:49:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=lMH85J+ku7g+4/kQLGbmWS4zmgx7zM45qOHhvn+LOsk=;
        b=MZ8fqbtSxhzwKu+wPYod1yo+B8GJOSrxVSYvPMDtfTNizFl8LkkOb9yS80eW5CtiEM
         U/KHsVCWaM1bus3TuddftuzEDLs6LJFJQf/bUOzZLA++3ap/AAABM+fwdhhx692oapqi
         +uglINZlQqNHNwA959kQ3cz44CsYXL/3Cqkvk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=dqxofeeetxQDCnEjuoP5a5eg9bGJGvQ1N9Baz03FX8X5cFsyZrP8Fch+O33et569FG
         zv63d0p5xr99k17ETy7nTl1MVIJSPYee47cQ6Kg0J8HNnLW7qg1Qr8RTvewqmq/9zPOH
         nENVSkfAXgnzD2EmXntA0IB/hWSbfW0EJpn2A=
Received: by 10.205.23.208 with SMTP id rb16mr6564544bkb.130.1299019783064;
        Tue, 01 Mar 2011 14:49:43 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm3733741bkf.8.2011.03.01.14.49.42
        (version=SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 14:49:42 -0800 (PST)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168270>

While the no-op C patch series is cooking I thought I'd send an RFC
for the no-op shellscript infrastructure. So here (as threatened in
<AANLkTinUtqJJHNyS9CxrC=3DVnS87v=3DGH=3DpOw9yr4r=3Dpii@mail.gmail.com>[=
1]) is
the infrastructure needed to gettextize the shell script programs.

To quote my previous E-Mail[1] here are the things that are DONE and
still need to be done.
   =20
    Open issues:
   =20
       * Write documentation for git-sh-i18n.sh and git-sh-i18n--envsub=
st
         like we have for git-sh-setup (already in WIP form).

It now has documentation. So this isn't a problem anymore.
   =20
       * git-sh-i18n--envsubst is still too fat:
   =20
            $ ldd -r git-sh-i18n--envsubst
                linux-vdso.so.1 =3D>  (0x00007fffc60fd000)
                libz.so.1 =3D> /usr/lib/libz.so.1 (0x00007f25cff9e000)
                libcrypto.so.0.9.8 =3D> /usr/lib/libcrypto.so.0.9.8
    (0x00007f25cfbfd000)
                libpthread.so.0 =3D> /lib/libpthread.so.0 (0x00007f25cf=
9e0000)
                libc.so.6 =3D> /lib/libc.so.6 (0x00007f25cf67f000)
                libdl.so.2 =3D> /lib/libdl.so.2 (0x00007f25cf47b000)
                /lib64/ld-linux-x86-64.so.2 (0x00007f25d01c0000)
   =20
         It only needs to link to libc, but I didn't find out when I la=
st
         checked how to convince the Makefile to only link against
         that. Help welcome :)

This is still an issue. It needs to link to libgit for xmalloc() and
friends, but it doesn't need libz, libcrypto etc.
   =20
       * Deal with the changes in 92c62a3f4f93432c0c82e3031a9e64e03ba29=
0f7:
   =20
            $ git --no-pager  grep -A1 abomination *.sh
            git-pull.sh:            # XXX: This is an abomination
            git-pull.sh-            require_clean_work_tree "pull with
    rebase" "Please commit or stash them."
   =20
         The changes Ramkumar Ramachandra made in 92c62a3f4f, while goo=
d,
         are hard to square with i18n.
   =20
         I think I'll just leave those bits untranslated for now and de=
al
         with them later, since I'm trying to keep this minimal.

This is not part of this RFC series, but I still haven't dealt with it
in my branch.
   =20
    And then there's the issue that unlike the C patches these will not=
 be
    a no-op that'll be optimized away by the compiler. We'll be calling=
 an
    external program for displaying messages. While this is a trivial c=
ost
    on Unix (especially in the context we're using it, i.e. not in tigh=
t
    loops) it's more expensive on Windows.
   =20
    I don't see any way to deal with that short of implementing some
    pre-processor, but I think the cost is worth it, but others might
    disagree of course.

This is still a problem I think. Although there's been some work on
this on the MinGW front from what I can gleam from the mailing list.
   =20
1. http://www.spinics.net/lists/git/msg151971.html

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (2):
  git-sh-i18n--envsubst: our own envsubst(1) for eval_gettext()
  git-sh-i18n.sh: add no-op gettext() and eval_gettext() wrappers

 .gitignore                              |    3 +
 Documentation/git-sh-i18n--envsubst.txt |   36 +++
 Documentation/git-sh-i18n.txt           |   57 ++++
 Makefile                                |    2 +
 git-sh-i18n.sh                          |   17 ++
 sh-i18n--envsubst.c                     |  444 +++++++++++++++++++++++=
++++++++
 6 files changed, 559 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-sh-i18n--envsubst.txt
 create mode 100644 Documentation/git-sh-i18n.txt
 create mode 100644 git-sh-i18n.sh
 create mode 100644 sh-i18n--envsubst.c

--=20
1.7.4.1
