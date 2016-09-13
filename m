Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE19220984
	for <e@80x24.org>; Tue, 13 Sep 2016 21:46:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754940AbcIMVqF (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Sep 2016 17:46:05 -0400
Received: from hahler.de ([188.40.33.212]:34553 "EHLO elfe.thequod.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753382AbcIMVqF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Sep 2016 17:46:05 -0400
X-Greylist: delayed 357 seconds by postgrey-1.27 at vger.kernel.org; Tue, 13 Sep 2016 17:46:04 EDT
Received: from localhost (amavis [10.122.1.24])
        by elfe.thequod.de (Postfix) with ESMTP id 9EE6562088
        for <git@vger.kernel.org>; Tue, 13 Sep 2016 23:40:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=thequod.de; h=
        content-type:content-type:mime-version:user-agent:date:date
        :message-id:subject:subject:from:from:received:received; s=
        postfix2; t=1473802805; bh=MCezf4riC4hNO6xfWgL3I3KagfdvJaX8EaH3N
        mg7Y0I=; b=SG13q5HK3GhTul41xsMvKJ/sbqaIOMePvHPtDrre3NSt17AEVscAu
        v5AA4IcmCD5xnUNCsvnOO0motNCmLcPOkA0NP4lYU3/Am25BJC+wlI9E7+SMPir5
        lx/kRLdAirYBOlvBLV7iUIzaLjFdJkcej/h6ycJKZzdk5ey3mdSXzg=
Received: from elfe.thequod.de ([10.122.1.25])
        by localhost (amavis.thequod.de [10.122.1.24]) (amavisd-new, port 10026)
        with ESMTP id dd22t327aEah for <git@vger.kernel.org>;
        Tue, 13 Sep 2016 23:40:05 +0200 (CEST)
To:     git@vger.kernel.org
From:   Daniel Hahler <genml+git-2016@thequod.de>
Subject: Left with empty files after "git stash pop" when system hung
Message-ID: <5b203a8e-faa8-9f6e-8cdd-1024194e74a3@thequod.de>
Date:   Tue, 13 Sep 2016 23:39:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="s8p2mpb29rSaOjmnNNiuFFOisxHlbQ6P4"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s8p2mpb29rSaOjmnNNiuFFOisxHlbQ6P4
Content-Type: multipart/mixed; boundary="ptlkigkub1PVUQgrbARigeFR8TesDua1k";
 protected-headers="v1"
From: Daniel Hahler <genml+git-2016@thequod.de>
To: git@vger.kernel.org
Message-ID: <5b203a8e-faa8-9f6e-8cdd-1024194e74a3@thequod.de>
Subject: Left with empty files after "git stash pop" when system hung

--ptlkigkub1PVUQgrbARigeFR8TesDua1k
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

I have used "git stash --include-untracked", checked out another branch,
went back, and "git stash pop"ed the changes.
Then my system crashed/hung (music that was playing was repeated in a
loop).  I have waited for some minutes, and then turned it off.

Afterwards, the repository in question was in a state where all files
contained in the stash were empty.
"git status" looked good on first sight: all the untracked and modified
files were listed there; but they were empty.

  % git fsck --lost-found
  error: object file .git/objects/04/1e659b5dbfd3f0be351a782b54743692875a=
ec is empty
  error: object file .git/objects/04/1e659b5dbfd3f0be351a782b54743692875a=
ec is empty
  fatal: loose object 041e659b5dbfd3f0be351a782b54743692875aec (stored in=
 .git/objects/04/1e659b5dbfd3f0be351a782b54743692875aec) is corrupt
  % find .git/objects -size 0|wc -l
  12

I would have assumed that the "stash pop" operation would be "atomic",
i.e. it should not remove the stash object before other objects have
been written successfully.

The filesystem in question is ext4, and I am using Arch Linux.

I have removed all empty files in .git/objects and tried to find the
previous stash with `gitk --all $( git fsck | awk '{print $3}' )` then,
but it appears to have disappeared.

Please CC me in replies.


Cheers,
Daniel.

--=20
http://daniel.hahler.de/


--ptlkigkub1PVUQgrbARigeFR8TesDua1k--

--s8p2mpb29rSaOjmnNNiuFFOisxHlbQ6P4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iEYEARECAAYFAlfYcjUACgkQfAK/hT/mPgAfQwCfRfc8TrZQ5MICzLe6pSRos2lJ
Bq0An3rN1M6UT0Ol87u6AxrWIfaEdFnF
=TQjg
-----END PGP SIGNATURE-----

--s8p2mpb29rSaOjmnNNiuFFOisxHlbQ6P4--
