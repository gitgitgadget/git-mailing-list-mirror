Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1B6FC77B76
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 06:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbjDRGMP (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 02:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjDRGMN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 02:12:13 -0400
Received: from mx1.emlix.com (mx1.emlix.com [136.243.223.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23001FCF
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 23:12:10 -0700 (PDT)
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 5F9705F93E
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 08:12:08 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     git@vger.kernel.org
Subject: gpg-related crash with custom formatter (BUG: gpg-interface.c:915: invalid
 trust level requested -1)
Date:   Tue, 18 Apr 2023 08:12:03 +0200
Message-ID: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4824076.31r3eYUQgx";
 micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart4824076.31r3eYUQgx
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: git@vger.kernel.org
Date: Tue, 18 Apr 2023 08:12:03 +0200
Message-ID: <5926995.lOV4Wx5bFT@devpool47.emlix.com>
Organization: emlix GmbH
MIME-Version: 1.0

I use this one:

[format]
        pretty =3D %C(yellow)commit %H%C(auto)%d%Creset%nAuthor: %an <%ae>=
=20
%C(yellow)% GK %GS %C(auto)[%GT% G?]%Creset%nDate:   %ad%n%n%w(0,4,4)%s%n%w=
(0,
4,4)%+b

When I now run "git log" in a repository that contains commits signed by=20
people not in my keyring (e.g. the Gentoo git) I get this backtrace:

BUG: gpg-interface.c:915: invalid trust level requested -1

Program received signal SIGABRT, Aborted.
0x00007ffff7d69d7c in __pthread_kill_implementation () from /lib64/libc.so.6
Missing separate debuginfos, use: zypper install libpcre2-8-0-
debuginfo-10.42-3.6.x86_64 libz1-x86-64-v3-debuginfo-1.2.13-3.4.x86_64
(gdb) bt
#0  0x00007ffff7d69d7c in __pthread_kill_implementation () from /lib64/libc=
=2Eso.6
#1  0x00007ffff7d18356 in raise () from /lib64/libc.so.6
#2  0x00007ffff7d00897 in abort () from /lib64/libc.so.6
#3  0x00005555558041fe in BUG_vfl (params=3D0x7fffffffb9e0, fmt=3D0x5555558=
95608=20
"invalid trust level requested %d", line=3D<optimized out>, file=3D<optimiz=
ed out>)=20
at /usr/src/debug/git-2.40.0/usage.c:313
#4  BUG_fl (file=3D<optimized out>, line=3D<optimized out>, fmt=3D0x5555558=
95608=20
"invalid trust level requested %d") at /usr/src/debug/git-2.40.0/usage.c:330
#5  0x000055555576a816 in gpg_trust_level_to_str (level=3D<optimized out>) =
at /
usr/src/debug/git-2.40.0/gpg-interface.c:915
#6  format_commit_one (sb=3D0x7fffffffbf40, placeholder=3D0x555555936b65 "G=
T% G?]
%Creset%nDate:   %ad%n%n%w(0,4,4)%s%n%w(0,4,4)%+b", context=3D0x7fffffffbde=
0) at /
usr/src/debug/git-2.40.0/pretty.c:1617
#7  0x000055555576ab1e in format_commit_item (sb=3D0x7fffffffbf40,=20
placeholder=3D0x555555936b65 "GT% G?]%Creset%nDate:   %ad%n%n%w(0,4,4)%s%n%=
w(0,
4,4)%+b", context=3D0x7fffffffbde0) at /usr/src/debug/git-2.40.0/pretty.c:1=
844
#8  0x00005555557cfc44 in strbuf_expand (sb=3D0x7fffffffbf40, format=3D0x55=
5555936b65=20
"GT% G?]%Creset%nDate:   %ad%n%n%w(0,4,4)%s%n%w(0,4,4)%+b", fn=3D0x55555576=
a8d0=20
<format_commit_item>, context=3D0x7fffffffbde0) at /usr/src/debug/git-2.40.=
0/
strbuf.c:429
#9  0x000055555576af0e in repo_format_commit_message (r=3D0x555555928540=20
<the_repo>, commit=3D0x55555594e2d0, format=3D<optimized out>, sb=3D0x7ffff=
fffbf40,=20
pretty_ctx=3D<optimized out>) at /usr/src/debug/git-2.40.0/pretty.c:1910
#10 0x000055555571ad10 in show_log (opt=3Dopt@entry=3D0x7fffffffc570) at /u=
sr/src/
debug/git-2.40.0/log-tree.c:781
#11 0x000055555571bd17 in log_tree_commit (opt=3D0x7fffffffc570, commit=3D<=
optimized=20
out>) at /usr/src/debug/git-2.40.0/log-tree.c:1117
#12 0x00005555555e9638 in cmd_log_walk_no_free (rev=3D0x7fffffffc570) at bu=
iltin/
log.c:508
#13 0x00005555555e9d5a in cmd_log_walk (rev=3D0x7fffffffc570) at builtin/lo=
g.c:549
#14 cmd_log (argc=3D1, argv=3D0x7fffffffd7c0, prefix=3D0x0) at builtin/log.=
c:883
#15 0x00005555555782bb in run_builtin (argv=3D0x7fffffffd7c0, argc=3D1,=20
p=3D0x5555558fa000 <commands.lto_priv+1440>) at /usr/src/debug/git-2.40.0/g=
it.c:
445
#16 handle_builtin (argc=3D1, argv=3D0x7fffffffd7c0) at /usr/src/debug/git-=
2.40.0/
git.c:699
#17 0x00005555555787e7 in run_argv (argcp=3D0x7fffffffd50c, argv=3D0x7fffff=
ffd530) at /
usr/src/debug/git-2.40.0/git.c:763
#18 0x000055555557464b in cmd_main (argv=3D<optimized out>, argc=3D<optimiz=
ed=20
out>) at /usr/src/debug/git-2.40.0/git.c:898
#19 main (argc=3D<optimized out>, argv=3D<optimized out>) at /usr/src/debug/
git-2.40.0/common-main.c:57

This is not absolutely new, it is broken for a while but I was too lazy to=
=20
report (sorry about that). It has worked in the past, i.e. when I created t=
hat=20
formatter (IIRC at least 2 years ago).

System is an openSUSE Tumbleweed installation on amd64.

Greetings,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart4824076.31r3eYUQgx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCZD40swAKCRCr5FH7Xu2t
/OW0A/9o7dPhBTgcksYTiWR6BHqtXA6C5Jd2sLsmJ1BU7xcUpl2ewP1KYFvxk774
psj17RO8oIGlrIr2Xhz3zJGipI94b212QVlQpVQEDeH3/Y+yk8X80O4oJrW7hrwd
mKoa+jclCr64EhVLrHkCj6NIRm9hohrKtX5NllMCXehV0YxHyw==
=BgQX
-----END PGP SIGNATURE-----

--nextPart4824076.31r3eYUQgx--



