Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4C8642027C
	for <e@80x24.org>; Thu,  1 Jun 2017 09:19:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751277AbdFAJTE (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 05:19:04 -0400
Received: from castro.crustytoothpaste.net ([75.10.60.170]:47148 "EHLO
        castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751202AbdFAJTD (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 1 Jun 2017 05:19:03 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:254c:7dd1:74c7:cde0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 4D0DF280AD;
        Thu,  1 Jun 2017 09:19:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=crustytoothpaste.net;
        s=default; t=1496308742;
        bh=jnIUA1lLfUabJlEN0rOpA8hEXp2NFkaEDz2BaP7Q6K4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=T6Fy/ZZIGBlvtPAkiRxprD5nu1pLTSY8yws7FbF/SZ/7+6aDm6H+MhEmAiK7o1bsg
         VgzqLAlXJxHfyGNA/n/eznoOghiUab56gwjN8/2yOJoIQAAoUspYS2z2o3y6bcc7Hu
         uSnJNZvTUnwa4Fi9Zhsoif2SRluuSuvgrHoNiy8ekTfH9l/Ubk6hSwTDvsWOjSQkuv
         cWZPiUqaFmKY5OucYLBuW7Wwp2AHAtkpUFLnYEoK5jhrqOzE/m/HJxJ5aWQ7njaXO1
         0M/QcUugPRHevti81aqXxzwja/u7AH5p3ghFQoBakYnuaeicEGoNSO3LdjOhEdfLtt
         Kv+kRq+N1DECl/yG0SYLFCmzOxbMcUv5JRyxaS6gGfLu2GLoa2Lo+EzfOA3kese44V
         +TMyOrbNmfobzPCgqMkZIRenzp2iwMgcF0K2l+7QHeei8/d8SMc400ZevYcrYVImO6
         mnOlvcdqjijM7Iv4qDCjhItd4kd5eLqNjlOHKxAfaSfP8bwXvBg
Date:   Thu, 1 Jun 2017 09:18:57 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Andreas Schwab <schwab@suse.de>
Cc:     git@vger.kernel.org, Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: Unaligned accesses in sha1dc
Message-ID: <20170601091856.r3oaddwzsndniyfa@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Andreas Schwab <schwab@suse.de>, git@vger.kernel.org,
        Marc Stevens <marc@marc-stevens.nl>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
References: <mvm4lw0un5n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="q25wf3yvrpnswkwz"
Content-Disposition: inline
In-Reply-To: <mvm4lw0un5n.fsf@suse.de>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.9.0-3-amd64)
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--q25wf3yvrpnswkwz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 01, 2017 at 10:28:52AM +0200, Andreas Schwab wrote:
> The sh1dc implementation is making unaligned accesses, which will crash
> on some architectures, others have to emulate them in software.
>=20
> Breakpoint 4, sha1_compression_states (ihv=3D0x600ffffffffe7010,=20
>     m=3D<optimized out>, W=3D0x600ffffffffe70a8, states=3D0x600ffffffffe7=
328)
>     at sha1dc/sha1.c:398
> 398             SHA1COMPRESS_FULL_ROUND2_STEP(e, a, b, c, d, W, 21, temp);
> (gdb) n
> 403             SHA1COMPRESS_FULL_ROUND2_STEP(d, e, a, b, c, W, 22, temp);
> (gdb)=20
> 408             SHA1COMPRESS_FULL_ROUND2_STEP(c, d, e, a, b, W, 23, temp);
> (gdb)=20
> 413             SHA1COMPRESS_FULL_ROUND2_STEP(b, c, d, e, a, W, 24, temp);
> (gdb)=20
> 418             SHA1COMPRESS_FULL_ROUND2_STEP(a, b, c, d, e, W, 25, temp);
> (gdb)=20
> 291             SHA1COMPRESS_FULL_ROUND1_STEP_LOAD(a, b, c, d, e, m, W, 0=
, temp);
> (gdb)=20
> git(21728): unaligned access to 0x600000000009f8d5, ip=3D0x40000000003336=
d0
> 423             SHA1COMPRESS_FULL_ROUND2_STEP(e, a, b, c, d, W, 26, temp);

What architecture are you seeing this on?
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
https://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: https://keybase.io/bk2204

--q25wf3yvrpnswkwz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1.21 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlkv3AAACgkQv1NdgR9S
9otiGQ//ev6a74LX3rWOlJEX3leLbh9ONEN9UOIk/O7w0jFhy8GpQAxHkNgHAgNK
Ihw/fnnjQNR/ExsRhtruJJOiZD843ejJHPZk0nxrA64j/GTmmAoj5AOV5MsMloBc
9P3m5Uaeyra+9eLTiFiPGl3kOjzfFe5nb7CQXUMSpla9sQrb3egah0a1ld1xPz0N
aHbKB4aXwStAC/zzLDEi9KUI16m3cJxgXnEdp4GBYlncpmbwreMYNI3d4IDcBPsu
SfMKdpbcfGJwzm/3ea3bT1n4d+2G6C34NW54xXQ5VBWCmVVV2wniFl8DoE4HykM2
PYArn8kxExepItSMKukMQpQDpYYzXkJsOtHSgCLeagIqmz91Rg0cHHMi+zKwvZ63
QJPgoDCdrkNQCPf+CwDbJ3orNi9JIhTt/2EWClNqFiPHSza8EHHCcsPHNv5F/Jhr
v3PROejAZ2DxLpEWaiWiYzx+ubEeXk99U/fLkn3XDTg73jkFAAQe1rUq6gQqt3ZA
gqzNvUenSFowi3NxzVmIOzpBUtwBzypW69VS74OzHBthPTd8MUfttffK1wbd1NFs
a8SzxzvxvUpu2KDtdeH//qGvyxqcJOKUEUcU8fu8LUUmR4/YAvIkB1Wvy+774rMl
vBVTNrIscEelwhFKk9Wk+L6C/LxVOs64qWXJLSTyjD3zmNNObC4=
=sViG
-----END PGP SIGNATURE-----

--q25wf3yvrpnswkwz--
