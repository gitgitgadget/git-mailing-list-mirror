Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6172BC433DF
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 16:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0D0B206A4
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 16:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=evermeet.cx header.i=@evermeet.cx header.b="be08l7M5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726952AbgFNQdM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 12:33:12 -0400
Received: from evermeet.cx ([77.244.245.66]:56962 "EHLO atvie01s.evermeet.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726905AbgFNQdM (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 12:33:12 -0400
X-Greylist: delayed 2962 seconds by postgrey-1.27 at vger.kernel.org; Sun, 14 Jun 2020 12:33:11 EDT
Received: from epsilon3.local (CPE9050ca186c33-CM9050ca186c30.cpe.net.cable.rogers.com [99.238.67.14])
        (authenticated bits=0)
        by atvie01s.evermeet.cx (8.15.2/8.15.2) with ESMTPSA id 05EFhkU4015787
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 17:43:47 +0200
DKIM-Filter: OpenDKIM Filter v2.10.3 atvie01s.evermeet.cx 05EFhkU4015787
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=evermeet.cx;
        s=d201909; t=1592149427;
        bh=9p/UbYDciH1+K46frRehd6mhTJ+MsWyS2aBs1jDYy4U=;
        h=To:From:Subject:Date:From;
        b=be08l7M5dc7qP0vFZ4Tsdw/xchSkFK3Q+soJJNoHJEC9gKHCCm35GGY+kNkDAbT7x
         xz8BwVNxYkQzIYfh+eU/QHnkMp0PNmmmLKk908DZbGIHG32wUzdiV3I2sc2w+JbVDm
         z1X4QbeQvWUCSbqaIZDeDtZ2rv0MYLoal0ozbJhxyUUD9FiTjyZlRZ1KP1NFqN0lbX
         kR86Qbq8WQW/g0n2Os8U4ZOPhH4RjcdiAYEqj2nb6YKBXf2WOMG7H1wQZcZSytuanW
         q0Y58nuKd9SUYoQvv6oXfnJpyhjSiM58mL7q85rU1YOTI62eQ/LI0t1ccsWou9tG/K
         yy65ffv62WJtQ==
To:     git@vger.kernel.org
From:   "Helmut K. C. Tessarek" <tessarek@evermeet.cx>
Subject: includeIf ignores subdirectories (possible bug)
Openpgp: id=8A5570C1BD85D34EADBC386C172380A011EF4944
Message-ID: <7aabac4a-ef75-74bd-01d9-5c6de27f9338@evermeet.cx>
Date:   Sun, 14 Jun 2020 11:43:39 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:60.0)
 Gecko/20100101 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="l86I2Jfn8UpzyuPbRBu4gaRxQJTGxHGX3"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l86I2Jfn8UpzyuPbRBu4gaRxQJTGxHGX3
Content-Type: multipart/mixed; boundary="nO8MPjBm5qkWl0XdNSC6sP13Jp6VlNUyh";
 protected-headers="v1"
From: "Helmut K. C. Tessarek" <tessarek@evermeet.cx>
To: git@vger.kernel.org
Message-ID: <7aabac4a-ef75-74bd-01d9-5c6de27f9338@evermeet.cx>
Subject: includeIf ignores subdirectories (possible bug)

--nO8MPjBm5qkWl0XdNSC6sP13Jp6VlNUyh
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

I've noticed a strange behavior, which might be a bug.

When I'm in a subdirectory of a repo, the IncludeIf is ignored, which mak=
es
certain tasks only possible in the root directory of the repo. e.g. commi=
t

Here's a minimal config:

=2Egitconfig:

[includeIf "gitdir:~/projects/personal/"]
    path =3D .gitconfig-personal
[includeIf "gitdir:~/projects/work/"]
    path =3D .gitconfig-work
[commit]
    gpgsign =3D true

=2Egitconfig-personal:

[user]
    name =3D Helmut K. C. Tessarek
    email =3D personal@email.com
    signingkey =3D xxxxxxx1

=2Egitconfig-work:

[user]
    name =3D K. C. Tessarek
    email =3D work@email.com
    signingkey =3D xxxxxxx2

Ok, now create a repo in ~/projects/personal/test/

then add a directory to that repo and commit

cd ~/projects/personal/test/
mkdir new-dir
git add .
git commit -m "new dir"

# committed with the correct user name and email, and signed with the cor=
rect key

cd new-dir
touch file
git add .
git commit -m "new file"

# error: name and email are empty, key is empty to

Run:

git config -l --show-origin

No entries for name, email, signingkey

Cheers,
  K. C.

--=20
regards Helmut K. C. Tessarek              KeyID 0x172380A011EF4944
Key fingerprint =3D 8A55 70C1 BD85 D34E ADBC 386C 1723 80A0 11EF 4944

/*
   Thou shalt not follow the NULL pointer for chaos and madness
   await thee at its end.
*/


--nO8MPjBm5qkWl0XdNSC6sP13Jp6VlNUyh--

--l86I2Jfn8UpzyuPbRBu4gaRxQJTGxHGX3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE191csiqpm8f5Ln9WvgmFNJ1E3QAFAl7mRbEACgkQvgmFNJ1E
3QBMmA//ScaQ53omQPgDWszBRshPpQ38tRa2BpgPJ11Jmiefd7bfRgL0Gsq1o7/6
9SvgAF8ZinIXVqQV3+aNcJiq19COGtrX28zxdfnHHoVjQBi8rZCzmiJ9CV9x55t/
mLZGDE/Cw08cjawtifwS9oumywRXQm7K1deHcYgIBptbPDlvdpnpTT42ZlQ2RTgo
5J0GVxOJwYSZJhGo0N55xQ4Thvp7WFdcMsX6+9UOTuVzGcrRmu/riLHH161hsYkH
GUoECxCMxS64fpy3zYL6eS9kAG3YSt+Rf1QcPGoDtglW4MmFhuY1kVVrevB2P2oJ
GSgpJ5ueymPB7QL9YiEuIM8NsZ3cjG9ZzzxpVmHydQX1bo4rdYxiP6apG3MJIDis
t8uI1SEXUk81pK/zPNmUuMPjVmsFsEqShVEa9RWxDMwIWQoIJBT3/dt+sn7Vt9f7
+yU9S4bPawfIftH7nTS/2TMC4vcGjbfXptSXtY+omrSSFKaHIBHGJvPSVSpYKFGh
MAaJ9EZQrtLqaoVUmSSEn8mD1/74dfFxRW+i8en1SixUHsWA9Vk8V7GW2DE/RJDm
gjVCvtJDhdjt7PY9stVrcC8iiwEjLsmcM2uBBwTXPGonY16WDTICQtIXAVQ6abE9
Y9hFbhy/hacWOu3ovFPNDVsa17bW6LvV0xGXyo8A54i5eL6KPhc=
=1ltA
-----END PGP SIGNATURE-----

--l86I2Jfn8UpzyuPbRBu4gaRxQJTGxHGX3--
