Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA06BC43334
	for <git@archiver.kernel.org>; Fri, 22 Jul 2022 17:32:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiGVRcv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 13:32:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236045AbiGVRct (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 13:32:49 -0400
X-Greylist: delayed 506 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Jul 2022 10:32:45 PDT
Received: from kitenet.net (kitenet.net [66.228.36.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B42A99C26F
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=joeyh.name; s=mail;
        t=1658510654; bh=LFvqXHAajO8tV2kF8qCQDgCFmtDKPUDOyGpUTT+UBfI=;
        h=Date:From:To:Cc:Subject:From;
        b=f5gkx/GDC8GuuoMp6AGD0fCeTDuR2FamEIL8U5hmK8DQo+5csOUIcpZlzkS/Ughk0
         601TbnkmIHhGVz7YW5MTanqdCe4PgeyUaAP1GFN7QOGBtBenoU7FRuTuIu29oZXIxd
         TYzSFW9453awjDoJySKh1jY1at48FB06OGxsvVkg=
X-Question: 42
Date:   Fri, 22 Jul 2022 13:24:14 -0400
From:   Joey Hess <id@joeyh.name>
To:     git@vger.kernel.org
Cc:     Tao Klerks <tao@klerks.biz>
Subject: git write-tree segfault with core.untrackedCache true and
 nonexistent index
Message-ID: <YtrdPguYs3a3xekv@kitenet.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6ZF/ncQPJYmsa+Sk"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6ZF/ncQPJYmsa+Sk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

	joey@darkstar:/tmp>git init emptyrepo
	Initialized empty Git repository in /tmp/emptyrepo/.git/
	joey@darkstar:/tmp>cd emptyrepo/
	joey@darkstar:/tmp/emptyrepo>git config core.untrackedCache true
	joey@darkstar:/tmp/emptyrepo>git write-tree
	Segmentation fault

I'm seeing this with git 2.37, 2.37.1, and HEAD.=20
2.36.1 does not have the problem.=20

Note that the index file does not exist prior to git write-tree in the above
test case. When the index does exist, it doesn't segfault. Before, it would
just generate the empty tree when the index did not exist.

Bisecting, e6a653554bb49c26d105f3b478cbdbb1c0648f65 is the first bad commit
commit e6a653554bb49c26d105f3b478cbdbb1c0648f65
Author: Tao Klerks <tao@klerks.biz>
Date:   Thu Mar 31 16:02:15 2022 +0000

    untracked-cache: support '--untracked-files=3Dall' if configured

--=20
see shy jo

--6ZF/ncQPJYmsa+Sk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEKKUAw1IH6rcvbA8l2xLbD/BfjzgFAmLa3TsACgkQ2xLbD/Bf
jzgUGw//fTwKnyeDKGkrv7s7loLhBj/H5O6jtDSFreE85zRMx+AsK/2xN/6yWtwk
P9x5A83W7lE+/KVUvAnPU9WZqV2WALSrQsJtO8CTdojUlQMxleFsk0ALmXZIBqnS
m5S3BVX/D67mUGmAYyB/jmvLOfkHWr/108u19BtBV0g5k45wxMixV/7nyeL531Ej
MgrWSjvBqefdTe/OflVBjIZWY3Zj6qydHVW1cbPVHsYFKf+Jz0S36Kdg/jK7KZmU
2mFrMOLTcshHYh6U1WO70VS7c7cgjYZi+l2IPf7UNhPUO50CPVdrr+fcz/9cfBqY
lVIefX7lmgcEN45bm7RnNrURZfVe8mYnan4uBc61WQtwmNCNowuva+NgCjt/HKaM
UsESaGKmL3NenlEajV6Q8cR+sTN8vw/AjWzee35T4NUns4Nu81pVx4BO1qu8hini
zUcHUq2jP9xvJkyKP8Q4g+/11pvHYp/ZQ2xXWJgPgat5nSevu5PWyaWVq/Ufi93+
j+qOOcl+uZLkULaoPtaj1UGUdxAOJfV4MrV7Z8gLZp3hcGjzJTsPxHnfcqDGTQOm
ZUtGOZKhm3sR9WuJxAm5Jq9MfAi8chwEp7EmdzWZhgruZotxv1XqrZwlyyzqzHJ9
uA8X9LddaBu1QVcFxPCLU3pCJT4FRffi7aArDkDBjLuO3PDC40Q=
=hBSO
-----END PGP SIGNATURE-----

--6ZF/ncQPJYmsa+Sk--
