Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D101AC433F5
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B042361158
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 01:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349146AbhIIBTQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Sep 2021 21:19:16 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:33334 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349181AbhIIBTP (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 8 Sep 2021 21:19:15 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:a6ae:7d13:8741:9028])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 1B48D6048E
        for <git@vger.kernel.org>; Thu,  9 Sep 2021 01:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1631150286;
        bh=dLg5OQma8OmjfohpjaInVQHMUdr7QZhwnobVYAOTUPQ=;
        h=Date:From:To:Subject:Content-Type:Content-Disposition:From:
         Reply-To:Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:
         Resent-Cc:In-Reply-To:References:Content-Type:Content-Disposition;
        b=mtt/M+3bm5YqpA418Yb6N9Y0A6Zwr36aChoqpLjssPCz1unYV42lXIVgWCvzgW3tU
         48GauYo6keTns62QGzQLpmdneoS9G5SrjqrH/NiZcnml2Zm+Vo8MOVuoeps5+Kmkc0
         DJwWWyhyXVTHWYnrN96vSHHPrZQ0lRUAcxQLpcNw3SFwoEnWDnfvSVaqfJnpwUewx5
         xUTcsfPjj94FPIMIa1nONT0rpU09QeR6Cve3vLwD+jgfekoq3MhdGLmrLXH5RbC/Lf
         rifN9Nt1nfRb/jK9e4t7B973+oVRIdaSJtyEeuiQJXDCpwJI9bmK1uNen8oXBXoqSL
         hg6EOml5MUuujdpJ+fR33TcrqAqlJz2jOVfzlW722ZqYNxlZDuNj/eO89+mK8wK1R+
         WtxfbYpHWCUw574kJ+pB+d9VtObkaOK+THCLOQ0kff1UjH3PC2er9oeiOQxN580Zwg
         4WP/9Jiw3NuLrek8UonFKI3iVdqFzdhB/TwMrpvNNRRSPcYAPPL
Date:   Thu, 9 Sep 2021 01:18:00 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Segfaults in git rebase --continue and git rerere
Message-ID: <YTlgyHnD3fFWwLu3@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8BqXWqIlqc5qW9J6"
Content-Disposition: inline
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8BqXWqIlqc5qW9J6
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm having a bit of a problem with segfaults using
2.33.0.252.g9b09ab0cd71.  I was in the process of running "git rebase
--continue" with that version to resolve some conflicts in a project I'm
working on.  At that point, it segfaulted, and I got this (apologies for
the French):

  error: impossible d'analyser la section en conflit dans 'scutiger-lfs/src=
/bin/git-lfs-transfer.rs'
  error: impossible d'analyser la section en conflit dans 'scutiger-lfs/src=
/bin/git-lfs-transfer.rs'
  Pr=C3=A9-image enregistr=C3=A9e pour 'scutiger-lfs/src/bin/git-lfs-transf=
er.rs'
  [HEAD d=C3=A9tach=C3=A9e 5134185] scutiger-lfs: move BatchItem, Mode, and=
 Oid to library
   2 files changed, 74 insertions(+), 9 deletions(-)
  Fusion automatique de scutiger-lfs/src/processor.rs
  Fusion automatique de scutiger-lfs/src/bin/git-lfs-transfer.rs
  CONFLIT (contenu) : Conflit de fusion dans scutiger-lfs/src/bin/git-lfs-t=
ransfer.rs
  error: impossible d'appliquer 2cd1615... scutiger-lfs: move download and =
verify actions into backend
  Resolve all conflicts manually, mark them as resolved with
  "git add/rm <conflicted_files>", then run "git rebase --continue".
  You can instead skip this commit: run "git rebase --skip".
  To abort and get back to the state before "git rebase", run "git rebase -=
-abort".
  error: impossible d'analyser la section en conflit dans 'scutiger-lfs/src=
/bin/git-lfs-transfer.rs'
  zsh: segmentation fault  git rebase --continue

I can provide a tarball of the broken repo upon request.  It's 108 MB,
so you'll need to provide some place for me to drop it.

At that point, I needed to remove .git/MERGE_RR.lock (which is empty),
and I ran "git rebase --abort" (because I realized my resolution was
bad).  Upon which, I received a second segfault (traceback from tip of
next):

  #0  0x00000000005b6e6b in has_rerere_resolution (id=3D0x229b3a0) at rerer=
e.c:162
  162             return ((id->collection->status[variant] & both) =3D=3D b=
oth);
 =20
  #0  0x00000000005b6e6b in has_rerere_resolution (id=3D0x229b3a0) at rerer=
e.c:162
          both =3D 3
          variant =3D 0
  #1  rerere_clear (r=3D0x722880 <the_repo>, merge_rr=3Dmerge_rr@entry=3D0x=
7ffe8c703810) at rerere.c:1239
          id =3D 0x229b3a0
          i =3D 0

It appears to be because id->collection->status here is NULL.  It's
unclear to me why that's the case, but it does appear to be linked to my
=2Egit/MERGE_RR file, which looks like this (xxd -g1):

  00000000: 30 34 39 62 31 34 32 39 34 65 64 30 63 30 65 66  049b14294ed0c0=
ef
  00000010: 62 65 39 32 66 34 66 64 33 31 31 63 37 63 34 30  be92f4fd311c7c=
40
  00000020: 39 30 39 34 65 63 64 65 09 73 63 75 74 69 67 65  9094ecde.scuti=
ge
  00000030: 72 2d 6c 66 73 2f 73 72 63 2f 62 69 6e 2f 67 69  r-lfs/src/bin/=
gi
  00000040: 74 2d 6c 66 73 2d 74 72 61 6e 73 66 65 72 2e 72  t-lfs-transfer=
=2Er
  00000050: 73 00                                            s.

The corresponding directory under .git/rr-cache is empty.  This
specifically seems to be the problem, and I've included a snippet of a
test below that causes the same segfault.  My guess is that the original
segfault left the MERGE_RR file present but the files in the rr-cache
directory absent.

Since rerere isn't a strong suit of mine, I'm not sending a patch, but I
am including a failing test[0] which indicates the problem (and to which
anyone is welcome to add my sign-off) in hopes that someone more
familiar with this subsystem can figure out what's going on.

----- %< -----
diff --git a/t/t4200-rerere.sh b/t/t4200-rerere.sh
index 9f8c76dffb..c44dfe248a 100755
--- a/t/t4200-rerere.sh
+++ b/t/t4200-rerere.sh
@@ -623,6 +623,7 @@ test_expect_success 'rerere with inner conflict markers=
' '
 	git commit -q -m "will solve conflicts later" &&
 	test_must_fail git merge A &&
=20
+	cp .git/MERGE_RR merge_rr &&
 	echo "resolved" >test &&
 	git add test &&
 	git commit -q -m "solved conflict" &&
@@ -645,6 +646,13 @@ test_expect_success 'rerere with inner conflict marker=
s' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'rerere clear does not segfault with bad data' '
+	res_id=3D$($PERL_PATH -nF"\t" -e "print \$F[0]" merge_rr) &&
+	cp merge_rr .git/MERGE_RR &&
+	rm -f .git/rr-cache/$res_id/* &&
+	git rerere clear
+'
+
 test_expect_success 'setup simple stage 1 handling' '
 	test_create_repo stage_1_handling &&
 	(
----- %< -----

As an aside, I generally find Git's codebase to be of exceptionally good
quality for a C program, and so seeing two segfaults back to back led me
to downgrade my recently upgraded version of glibc to see if somehow
that was the problem.  Unfortunately, that was not the case, and we just
have two separate bugs here.

[0] The test uses perl because the MERGE_RR file contains a NUL byte and
therefore cannot be used with standard POSIX utilities.
--=20
brian m. carlson (he/him or they/them)
Toronto, Ontario, CA

--8BqXWqIlqc5qW9J6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYTlgxwAKCRB8DEliiIei
gUQXAQD1HHViq+qCC6pvIyM/Sx8VH0y/8epM95U+qE5Mz1Z8uQD9G2yFQazeL+aH
65eRSSjnWwgqbhLd8r/rZfn1iPwucAM=
=KyiX
-----END PGP SIGNATURE-----

--8BqXWqIlqc5qW9J6--
