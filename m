Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E9201FA7B
	for <e@80x24.org>; Thu, 15 Jun 2017 09:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751752AbdFOJVO (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 05:21:14 -0400
Received: from mail.centricular.com ([50.116.37.142]:37070 "EHLO
        mail.centricular.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750830AbdFOJVN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 05:21:13 -0400
X-Greylist: delayed 555 seconds by postgrey-1.27 at vger.kernel.org; Thu, 15 Jun 2017 05:21:13 EDT
Received: from localhost (localhost [127.0.0.1])
        by mail.centricular.com (Postfix) with ESMTP id 4C7DE58BE2
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 19:11:57 +1000 (AEST)
X-Virus-Scanned: Debian amavisd-new at centricular.com
Received: from mail.centricular.com ([127.0.0.1])
        by localhost (worm-farm.widgetgrove.com.au [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ZiiA7ipKWrPP for <git@vger.kernel.org>;
        Thu, 15 Jun 2017 19:11:56 +1000 (AEST)
Received: from lotus (unknown [188.117.216.123])
        by mail.centricular.com (Postfix) with ESMTPSA id 2339F58BA5
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 19:11:55 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=centricular.com;
        s=201701; t=1497517916;
        bh=UO6I+jnxI+Q1aNkJWlOqUe913j5E1KMhMI+75AZ43WI=;
        h=Subject:From:To:Date:From;
        b=sRUlHPsZjnJBsPg/GLpDas0egHUz7KbWMkMpczri85FL57NvWf0FLfxPXYDsk36Uj
         VVqF+ofCNx/Io85PGAbForELxM4FaEmym9pxgMoWgN2cSvq5IIyPPT2sfcMzv4s6Ke
         Tx2zanK9yHqxy9SfMwF0h887KOi1Fd73hANjQ+HQaY3XSVsSFMcPHzMi5OebchD8mF
         Al100Z0UHXa7qAAaep0v+2dtGmzo3UoCIvSfxrW/6+iJIc6lA186GyoEzTCRephB9X
         hugEbHj8WTtRGSif/5Z3ozx9El9wvIbi/Fh7ofKSpMCNwVGo9LdpMtmzl3SuPV18AX
         /nfloIa7Yrt3g==
Message-ID: <1497517910.2239.105.camel@centricular.com>
Subject: [BUG] git cherry-pick segfaults with local changes in working
 directory
From:   Sebastian =?ISO-8859-1?Q?Dr=F6ge?= <sebastian@centricular.com>
To:     git@vger.kernel.org
Date:   Thu, 15 Jun 2017 12:11:50 +0300
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-rcppVPBZ2NuVouJIP7dX"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-rcppVPBZ2NuVouJIP7dX
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

This is with git 2.11.0 (Debian 2.11.0-4) and can be reproduced with
the packed checkout here:
  https://people.freedesktop.org/~slomo/git-cherry-pick-segfault_gst-plugin=
s-good.tar.xz

$ tar xf git-cherry-pick-segfault_gst-plugins-good.tar.xz
$ cd gst-plugins-good
$ git cherry-pick 0421fb04470af90e8810e7e5e69955d3192896ba
Segmentation fault (core dumped)


Without local changes (e.g. after "git stash") it works fine. Also note
that the=C2=A0commit that is cherry-picked does not contain any changes to
files that have local changes.


Backtrace below:

Thread 1 "git" received signal SIGSEGV, Segmentation fault.
add_index_entry_with_check (option=3D0, ce=3D0x0, istate=3D0x555555993900 <=
the_index>) at read-cache.c:1012
1012	read-cache.c: No such file or directory.
(gdb) bt
#0  add_index_entry_with_check (option=3D0, ce=3D0x0, istate=3D0x5555559939=
00 <the_index>) at read-cache.c:1012
#1  add_index_entry (istate=3D0x555555993900 <the_index>, ce=3D0x0, option=
=3D0) at read-cache.c:1061
#2  0x0000555555646df6 in merge_content (o=3Do@entry=3D0x7fffffffd550,=20
    path=3Dpath@entry=3D0x555555a461c0 "docs/plugins/inspect/plugin-shout2s=
end.xml", o_oid=3D<optimized out>,=20
    o_oid@entry=3D0x555555a42adc, o_mode=3Do_mode@entry=3D33188, a_oid=3Da_=
oid@entry=3D0x555555a42af4,=20
    a_mode=3Da_mode@entry=3D33188, b_oid=3D0x555555a42b0c, b_mode=3D33188, =
rename_conflict_info=3D0x555555a45fa0)
    at merge-recursive.c:1727
#3  0x0000555555647a1d in process_entry (entry=3D<optimized out>, path=3D<o=
ptimized out>, o=3D0x7fffffffd550)
    at merge-recursive.c:1885
#4  merge_trees (o=3Do@entry=3D0x7fffffffd550, head=3Dhead@entry=3D0x555555=
9b7c98, merge=3D<optimized out>,=20
    merge@entry=3D0x5555559b7c70, common=3D<optimized out>, common@entry=3D=
0x5555559b7cc0,=20
    result=3Dresult@entry=3D0x7fffffffd530) at merge-recursive.c:1948
#5  0x000055555568a248 in do_recursive_merge (opts=3D0x7fffffffdcc0, msgbuf=
=3D0x7fffffffd510,=20
    head=3D0x7fffffffd620 "\246\256=D5=9Ds8J\273=DD=B5\241y\303#j\277\211\2=
66\\\n\377\177", next_label=3D<optimized out>,=20
    base_label=3D<optimized out>, next=3D<optimized out>, base=3D<optimized=
 out>) at sequencer.c:389
#6  do_pick_commit (command=3DTODO_PICK, commit=3Dcommit@entry=3D0x5555559a=
7c60, opts=3Dopts@entry=3D0x7fffffffdcc0)
    at sequencer.c:757
#7  0x000055555568baa3 in single_pick (opts=3D0x7fffffffdcc0, cmit=3D0x5555=
559a7c60) at sequencer.c:1329
#8  sequencer_pick_revisions (opts=3D0x7fffffffdcc0) at sequencer.c:1378
#9  0x00005555555d34cf in run_sequencer (argc=3D1, argc@entry=3D2, argv=3Da=
rgv@entry=3D0x7fffffffe0c0,=20
    opts=3D<optimized out>, opts@entry=3D0x7fffffffdcc0) at builtin/revert.=
c:178
#10 0x00005555555d3928 in cmd_cherry_pick (argc=3D2, argv=3D0x7fffffffe0c0,=
 prefix=3D<optimized out>)
    at builtin/revert.c:203
#11 0x0000555555566205 in run_builtin (argv=3D<optimized out>, argc=3D<opti=
mized out>, p=3D<optimized out>)
    at git.c:373
#12 handle_builtin (argc=3D2, argv=3D0x7fffffffe0c0) at git.c:572
#13 0x00005555555665a2 in run_argv (argv=3D0x7fffffffde60, argcp=3D0x7fffff=
ffde6c) at git.c:630
#14 cmd_main (argc=3D<optimized out>, argv=3D<optimized out>) at git.c:707
#15 0x00005555555655d2 in main (argc=3D3, argv=3D0x7fffffffe0b8) at common-=
main.c:40

--=20
Sebastian Dr=C3=B6ge, Centricular Ltd =C2=B7 http://www.centricular.com
--=-rcppVPBZ2NuVouJIP7dX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEf0vHzDygb5cza7/rBmjMFIbC17UFAllCT1ZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDdG
NEJDN0NDM0NBMDZGOTczMzZCQkZFQjA2NjhDQzE0ODZDMkQ3QjUACgkQBmjMFIbC
17XvpxAAqqgIBfRtoebEQ6hVk31w2ur4KZV/6tktEKkXttPDw7I7gJSqR0r1H8hd
//OIztpdDabl/JeY+mhMTIEirJ8NKiaPe20PPx8rFbDaiLxu87hzCpV3MeOtp6VG
Y7iRynK+Z1/RntaojWfYybgSSpr+a/L1V1hfQeCxFxLsmp81dh/AqDlth0sBYwcp
yDba6IrQI4ylWSFmWJXPTdxHddm4bQqfgxklIr+mimOaCw43lOXs61rNCJ0QFRNm
OvAY9TO91jrx2rwx8fhfsWi4LWZaAR0hpwl7Nm6PpHi10au+nI3fZzc/kUSvAoRB
iLN2CF895XQbDPJ4LOAqMMRxUM4mqhVDV3EA7FB9HnPJ+8e1sImoZSrhbSbtwHGj
6juR6geS8HAgL6TPBwftXdKrKs+YuboxXqo2WP6LTsjtdPiOShwlwJPwBYZTwyWG
EAOgPkdsYPbVvUGmJpl7JaA9NrokuIN0ppopzDpzcwlQ+BvwGGZXqk3VmeUSVEpT
7digUA7CqCgO5HGu2qL96YiTmcoEtFWI0CR0c3DqFyNTYLGopiwdlo1k4oS6lmV4
Y3YP3YbCGNQ1XK+KzyNDS9+xwBD+e97A0Hdb7SdvPjdGdyUYPm0dHphEyQAbrrry
s1MtGk53vfK19DpKBPxkKUZbqoy+shsaI+cI1lQQ3S9RFpe8hwc=
=xJ4Y
-----END PGP SIGNATURE-----

--=-rcppVPBZ2NuVouJIP7dX--

