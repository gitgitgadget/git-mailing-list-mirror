Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEEBA1F403
	for <e@80x24.org>; Sat,  9 Jun 2018 22:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753469AbeFIWtU (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 18:49:20 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:36304 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753433AbeFIWtU (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 9 Jun 2018 18:49:20 -0400
Received: from genre.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:54a4:7f2e:59a2:6beb])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id CFBC560129
        for <git@vger.kernel.org>; Sat,  9 Jun 2018 22:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1528584559;
        bh=tnjXWGjbE1vdP9TF00rMRCiELKQOxaG2yqmSI9+QcdY=;
        h=Date:From:To:Subject:References:Content-Type:Content-Disposition:
         In-Reply-To:From:Reply-To:Subject:Date:To:CC:Resent-Date:
         Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=sFDGCPUTlA3D/GFrzvtCtNawZlPOwYLQ8CBU8Wuq96GauhFKYvaxiSpccgdAGt87y
         BxKi+BDM49smlkwJfJeOaQXJOou1ry0ScB5vHOeKWwRYIYNxPe1wZvk4Do/hj/cTtM
         MJzRTX3P6CBSeZv0t61PMRdWnYUg4PTxvZfGwlExlLJ9irg9V1D+DcCzjl/eos464X
         NoYc3EK+XBPVb3l+Z0+BRcdOpMmB4XEG+lzdJQ8GSv4pUXp0sr0njGhCvZNTVK+fJb
         EdSgWokSFCdHzSdH6Vo76Xjc6AnahMk4fvKBwV8yYEloNPS/MCDaldfsRnaLlwgQB/
         8LgmMtqm0/CfW10xzxPq8modelyPldRh/uCpsXQFml6uEgsDrzCnvvSpsi30mMmLk6
         mupdUu+0aoXjyJXzD9eEJePQxp4U9xNO9AjNolnSEqDwf7PHn636G8l535C0Axn/3w
         q1vxIwIr3pdvewQGopGg4npMzkyC5vjYoEf4kWsEgp57BAWXfe5
Date:   Sat, 9 Jun 2018 22:49:13 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     git@vger.kernel.org
Subject: Hash algorithm analysis
Message-ID: <20180609224913.GC38834@genre.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Content-Disposition: inline
In-Reply-To: <20180609205628.GB38834@genre.crustytoothpaste.net>
X-Machine: Running on genre using GNU/Linux on x86_64 (Linux kernel
 4.16.0-2-amd64)
User-Agent: Mutt/1.10.0 (2018-05-17)
X-Scanned-By: MIMEDefang 2.79 on 127.0.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=3D=3D Discussion of Candidates

I've implemented and tested the following algorithms, all of which are
256-bit (in alphabetical order):

* BLAKE2b (libb2)
* BLAKE2bp (libb2)
* KangarooTwelve (imported from the Keccak Code Package)
* SHA-256 (OpenSSL)
* SHA-512/256 (OpenSSL)
* SHA3-256 (OpenSSL)
* SHAKE128 (OpenSSL)

I also rejected some other candidates.  I couldn't find any reference or
implementation of SHA256=C3=9716, so I didn't implement it.  I didn't
consider SHAKE256 because it is nearly identical to SHA3-256 in almost
all characteristics (including performance).

I imported the optimized 64-bit implementation of KangarooTwelve.  The
AVX2 implementation was not considered for licensing reasons (it's
partially generated from external code, which falls foul of the GPL's
"preferred form for modifications" rule).

=3D=3D=3D BLAKE2b and BLAKE2bp

These are the non-parallelized and parallelized 64-bit variants of
BLAKE2.

Benefits:
* Both algorithms provide 256-bit preimage resistance.

Downsides:
* Some people are uncomfortable that the security margin has been
  decreased from the original SHA-3 submission, although it is still
  considered secure.
* BLAKE2bp, as implemented in libb2, uses OpenMP (and therefore
  multithreading) by default.  It was no longer possible to run the
  testsuite with -j3 on my laptop in this configuration.

=3D=3D=3D Keccak-based Algorithms

SHA3-256 is the 256-bit Keccak algorithm with 24 rounds, processing 136
bytes at a time.  SHAKE128 is an extendable output function with 24
rounds, processing 168 bytes at a time.  KangarooTwelve is an extendable
output function with 12 rounds, processing 136 bytes at a time.

Benefits:
* SHA3-256 provides 256-bit preimage resistance.
* SHA3-256 has been heavily studied and is believed to have a large
  security margin.

I noted the following downsides:
* There's a lack of a availability of KangarooTwelve in other
  implementations.  It may be the least available option in terms of
  implementations.
* Some people are uncomfortable that the security margin of
  KangarooTwelve has been decreased, although it is still considered
  secure.
* SHAKE128 and KangarooTwelve provide only 128-bit preimage resistance.

=3D=3D=3D SHA-256 and SHA-512/256

These are the 32-bit and 64-bit SHA-2 algorithms that are 256 bits in
size.

I noted the following benefits:
* Both algorithms are well known and heavily analyzed.
* Both algorithms provide 256-bit preimage resistance.

=3D=3D Implementation Support

|=3D=3D=3D
| Implementation | OpenSSL | libb2 | NSS | ACC | gcrypt | Nettle| CL  |
| SHA-1          | =F0=9F=97=B8       |       | =F0=9F=97=B8   | =F0=9F=97=
=B8   | =F0=9F=97=B8      | =F0=9F=97=B8     | {1} |
| BLAKE2b        | f       | =F0=9F=97=B8     |     |     | =F0=9F=97=B8   =
   |       | {2} |
| BLAKE2bp       |         | =F0=9F=97=B8     |     |     |        |       =
|     |
| KangarooTwelve |         |       |     |     |        |       |     |
| SHA-256        | =F0=9F=97=B8       |       | =F0=9F=97=B8   |  =F0=9F=97=
=B8  | =F0=9F=97=B8      | =F0=9F=97=B8     | {1} |
| SHA-512/256    | =F0=9F=97=B8       |       |     |     |        | =F0=9F=
=97=B8     | {3} |
| SHA3-256       | =F0=9F=97=B8       |       |     |     | =F0=9F=97=B8   =
   | =F0=9F=97=B8     | {4} |
| SHAKE128       | =F0=9F=97=B8       |       |     |     | =F0=9F=97=B8   =
   |       | {5} |
|=3D=3D=3D

f: future version (expected 1.2.0)
ACC: Apple Common Crypto
CL: Command-line

:1: OpenSSL, coreutils, Perl Digest::SHA.
:2: OpenSSL, coreutils.
:3: OpenSSL
:4: OpenSSL, Perl Digest::SHA3.
:5: Perl Digest::SHA3.

=3D=3D=3D Performance Analysis

The test system used below is my personal laptop, a 2016 Lenovo ThinkPad
X1 Carbon with an Intel i7-6600U CPU (2.60 GHz) running Debian unstable.

I implemented a test tool helper to compute speed much like OpenSSL
does.  Below is a comparison of speeds.  The columns indicate the speed
in KiB/s for chunks of the given size.  The runs are representative of
multiple similar runs.

256 and 1024 bytes were chosen to represent common tree and commit
object sizes and the 8 KiB is an approximate average blob size.

Algorithms are sorted by performance on the 1 KiB column.

|=3D=3D=3D
| Implementation             | 256 B  | 1 KiB  | 8 KiB  | 16 KiB |
| SHA-1 (OpenSSL)            | 513963 | 685966 | 748993 | 754270 |
| BLAKE2b (libb2)            | 488123 | 552839 | 576246 | 579292 |
| SHA-512/256 (OpenSSL)      | 181177 | 349002 | 499113 | 495169 |
| BLAKE2bp (libb2)           | 139891 | 344786 | 488390 | 522575 |
| SHA-256 (OpenSSL)          | 264276 | 333560 | 357830 | 355761 |
| KangarooTwelve             | 239305 | 307300 | 355257 | 364261 |
| SHAKE128 (OpenSSL)         | 154775 | 253344 | 337811 | 346732 |
| SHA3-256 (OpenSSL)         | 128597 | 185381 | 198931 | 207365 |
| BLAKE2bp (libb2; threaded) |  12223 |  49306 | 132833 | 179616 |
|=3D=3D=3D

SUPERCOP (a crypto benchmarking tool;
https://bench.cr.yp.to/results-hash.html) has also benchmarked these
algorithms.  Note that BLAKE2bp is not listed, KangarooTwelve is k12,
SHA-512/256 is equivalent to sha512, SHA3-256 is keccakc512, and SHAKE128 is
keccakc256.

Information is for kizomba, a Kaby Lake system.  Counts are in cycles
per byte (smaller is better; sorted by 1536 B column):

|=3D=3D=3D
| Algorithm      | 576 B | 1536 B | 4096 B | long |
| BLAKE2b        |  3.51 |   3.10 |   3.08 | 3.07 |
| SHA-1          |  4.36 |   3.81 |   3.59 | 3.49 |
| KangarooTwelve |  4.99 |   4.57 |   4.13 | 3.86 |
| SHA-512/256    |  6.39 |   5.76 |   5.31 | 5.05 |
| SHAKE128       |  8.23 |   7.67 |   7.17 | 6.97 |
| SHA-256        |  8.90 |   8.08 |   7.77 | 7.59 |
| SHA3-256       | 10.26 |   9.15 |   8.84 | 8.57 |
|=3D=3D=3D

Numbers for genji262, an AMD Ryzen System, which has SHA acceleration:

|=3D=3D=3D
| Algorithm      | 576 B | 1536 B | 4096 B | long |
| SHA-1          |  1.87 |   1.69 |   1.60 | 1.54 |
| SHA-256        |  1.95 |   1.72 |   1.68 | 1.64 |
| BLAKE2b        |  2.94 |   2.59 |   2.59 | 2.59 |
| KangarooTwelve |  4.09 |   3.65 |   3.35 | 3.17 |
| SHA-512/256    |  5.54 |   5.08 |   4.71 | 4.48 |
| SHAKE128       |  6.95 |   6.23 |   5.71 | 5.49 |
| SHA3-256       |  8.29 |   7.35 |   7.04 | 6.81 |
|=3D=3D=3D

Note that no mid- to high-end Intel processors provide acceleration.
AMD Ryzen and some ARM64 processors do.

=3D=3D Summary

The algorithms with the greatest implementation availability are
SHA-256, SHA3-256, BLAKE2b, and SHAKE128.

In terms of command-line availability, BLAKE2b, SHA-256, SHA-512/256,
and SHA3-256 should be available in the near future on a reasonably
small Debian, Ubuntu, or Fedora install.

As far as security, the most conservative choices appear to be SHA-256,
SHA-512/256, and SHA3-256.

The performance winners are BLAKE2b unaccelerated and SHA-256 accelerated.
--=20
brian m. carlson: Houston, Texas, US
OpenPGP: https://keybase.io/bk2204

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.2.8 (GNU/Linux)

iQIzBAABCgAdFiEEX8OngXdrJt+H9ww3v1NdgR9S9osFAlscWWkACgkQv1NdgR9S
9othGA/6AuO/rvIUFke8OWHmpOqlJlJu0+r724PK9D7Fn/Vc0rDUy7fQ+BJdjIRe
sgA09x0YXD5dV/pyLCfzDy1Fd2bOyy69glOc6fRvF0olXlAPwJO6COOongL0GQZE
g1XsolCVaDPP3k/hlgXsoU3PWQcL1/vrs97+jNy9HaA3gStadmo3NfRJDO+zs/7O
iXAJTHf9F8U/65HaRkpcCDc8w8O808iNt0ctvTP9Xit9qqlLKv2l8DoqnhKLo9K4
2WcN55dRpyBV9kGhVrP2KA4pfNIIjug+LfqalAzAWbuSdbq09YTrIopOzMUgYFYb
JOK4PHSzXpUUZI6pBzrsxJqTmqKIFvEDNcpNell3o6dMLqzP0rJ5kEUeD8jGkNMU
vAl26VNm/gmqxsDzJNrI6qb9v+S4UAjkxMKrHhbUkFsin0PpNd1spg7TpPW6stvP
NCDDb6hM1CBJo5j1M34IHgqKIzzYWAs7F5HizrYZMJk/E2fTANPv22O2IcWiAlGb
lPDf69OSVbIEuT2rfOfJaWzoSn1kIA41XeJ8LSXYdXAKwawBE91Hwlea3Vu9kmH+
z8FjiklOll8CB8sWvlAxfyO3C2vDLOiOsBHXN9G3MLn5GDGJHd3Atf7E7r6kQfro
waAXFpTmT/7UA8PJ3U8qdLLPQ5dmIR9Pl5GxzuB7Nppwol1/zWk=
=kvaW
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
