From: =?UTF-8?Q?Daniel?= <mjucde@o2.pl>
Subject: =?UTF-8?Q?Re:_checkout_-m_dumping_core?=
Date: Wed, 06 Jan 2010 09:11:42 +0100
Message-ID: <2b9e2ea1.461a9565.4b4445be.38bda@o2.pl>
References: <4B4381CA.1080504@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: =?UTF-8?Q?Git_List?= <git@vger.kernel.org>,
	=?UTF-8?Q?Tomas_Carnecky?= <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Wed Jan 06 09:34:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NSRLP-0001e7-At
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jan 2010 09:34:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755417Ab0AFIeO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Jan 2010 03:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755367Ab0AFIeO
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 03:34:14 -0500
Received: from tur.go2.pl ([193.17.41.50]:42859 "EHLO tur.go2.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751034Ab0AFIeN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Jan 2010 03:34:13 -0500
Received: from mailout1.go2.pl (mailout1.go2.pl [193.17.41.11])
	by tur.go2.pl (o2.pl Mailer 2.0.1) with ESMTP id 994B3230C29
	for <git@vger.kernel.org>; Wed,  6 Jan 2010 09:12:34 +0100 (CET)
Received: from mailout1.go2.pl (unknown [10.0.0.104])
	by mailout1.go2.pl (Postfix) with ESMTP id 8F80430007;
	Wed,  6 Jan 2010 09:11:43 +0100 (CET)
Received: from o2.pl (unknown [10.0.0.37])
	by mailout1.go2.pl (Postfix) with SMTP;
	Wed,  6 Jan 2010 09:11:43 +0100 (CET)
In-Reply-To: <4B4381CA.1080504@dbservice.com>
X-Originator: 153.19.128.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136251>

Tomas Carnecky <tom@dbservice.com> wrote:

> git version 1.6.6.78.gbd757c
>=20
> HEAD points to a non-existent branch refs/heads/master. Normal checko=
ut=20
> origin fails with:
> error: Entry '.cvsignore' would be overwritten by merge. Cannot merge=
=2E
> (the working tree does indeed contain this file). So I tried checkout=
 -m=20
> and git crashed. Workaround for me was reset --hard origin; checkout=20
> origin. I have the repository backed up in case someone wants to try=20
> themselves.
>=20
> $ gdb `which git`
> GNU gdb 6.8
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later=20
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show cop=
ying"
> and "show warranty" for details.
> This GDB was configured as "i386-pc-solaris2.11"...
> (gdb) run checkout -m origin
> Starting program: /export/home/tomc/local/git/bin/git checkout -m ori=
gin
> warning: Lowest section in /lib/libpthread.so.1 is .dynamic at 000000=
74
>=20
> Program received signal SIGSEGV, Segmentation fault.
> 0x080788fa in cmd_checkout (argc=3D0, argv=3D0x8047538, prefix=3D0x0)=
 at=20
> builtin-checkout.c:450
> 450                             merge_trees(&o, new->commit->tree, wo=
rk,
> (gdb) list
> 445                             ret =3D reset_tree(new->commit->tree,=
=20
> opts, 1);
> 446                             if (ret)
> 447                                     return ret;
> 448                             o.branch1 =3D new->name;
> 449                             o.branch2 =3D "local";
> 450                             merge_trees(&o, new->commit->tree, wo=
rk,
> 451                                     old->commit->tree, &result);
> 452                             ret =3D reset_tree(new->commit->tree,=
=20
> opts, 0);
> 453                             if (ret)
> 454                                     return ret;
> (gdb) p o
> $1 =3D {branch1 =3D 0x8047650 "origin", branch2 =3D 0x0, subtree_merg=
e =3D 0,=20
> buffer_output =3D 1, verbosity =3D 0, diff_rename_limit =3D -1,=20
> merge_rename_limit =3D -1, call_depth =3D 0, obuf =3D {alloc =3D 0, l=
en =3D 0, buf=20
> =3D 0x81643ac ""}, current_file_set =3D {
>      items =3D 0x0, nr =3D 0, alloc =3D 0, strdup_strings =3D 1},=20
> current_directory_set =3D {items =3D 0x0, nr =3D 0, alloc =3D 0, strd=
up_strings=20
> =3D 1}}
> (gdb) p new
> $2 =3D {name =3D 0x8047650 "origin", path =3D 0x8166438 "refs/heads/o=
rigin",=20
> commit =3D 0x8168f48}
> (gdb) p work
> $3 =3D (struct tree *) 0x8174f90
> (gdb) p old
> No symbol "old" in current context.
> (gdb) p result
> $4 =3D (struct tree *) 0xfefc81be
> (gdb)
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

Does this patch help?

---
=46rom b2203bded22db1a496ee3c9f6f5f4a384a8ccefa Mon Sep 17 00:00:00 200=
1
=46rom: Daniel Baranski <mjucde@o2.pl>
Date: Wed, 6 Jan 2010 08:58:21 +0100
Subject: [PATCH] checkout -m: Fix SEGFAULT if HEAD is not valid.

Signed-off-by: Daniel Bara=C5=84ski <mjucde@o2.pl>
---
 builtin-checkout.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 64f3a11..0ab59b2 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -422,7 +422,8 @@ static int merge_working_tree(struct checkout_opts =
*opts,
                        struct merge_options o;
                        if (!opts->merge)
                                return 1;
-                       parse_commit(old->commit);
+                       if (!parse_commit(old->commit))
+                               die("Couldn't parse commit '%s'", old->=
path);

                        /* Do more real merge */

--=20
1.6.5.6
