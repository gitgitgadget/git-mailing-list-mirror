Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CC32DF137
	for <git@vger.kernel.org>; Sat,  6 Dec 2025 13:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765027280; cv=none; b=df8bcUPABvjswxUHCITssymXcTIYv2g3zk4+J3YcJqN2Jk0lXIteq+liWUNFZhYZr46ciOo6GD2Rqr2APKZXfhwPTIAy26nQqxEfssV8JOcgw4VTYFuEWYV03NxRDAs7qsN5a58tkRw0AoacNL09y8BwzQNfSCWQrl66UqKUEsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765027280; c=relaxed/simple;
	bh=noWTdnVa+BSwRvkbLwZL8lplwp7uzVRk/SsRXUEFlZ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:Cc:
	 In-Reply-To:Content-Type; b=ineHzsXryywukm6rImBBzv8IVj6kQcdeVW3Q38naq92oEWRtoHjocKuk37uVQiaHunm9jX8ojeMVLtk8BFiN4v4ZgvFznmFx1/9SCx0ExhpR3TqD/g0IrPCVBbsGSN9sXzIiTUpzYr9iDuXrY0TzQMdUsvMW7kvnRYRwYprAYIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b=NVrnB9e2; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=l.s.r@web.de header.b="NVrnB9e2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1765027267; x=1765632067; i=l.s.r@web.de;
	bh=86Z/r1fQdSb2T5vXgQT25WceZVXe+U+gfgmIVA6+oRk=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:From:To:
	 References:Cc:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NVrnB9e2KiHjZeZWnYzF9lt2HZDURxgb9IYNxGfFCqYQUIWlCga8r4euEgARFeNL
	 723Jvyg5/hZmX4a4DsUZWtAR4vBT3l+tfD6XAE8HsGzsg0+GH0flZ/EhJJ0ccMqs1
	 AVq182IxWypL5lnBXm4lKhJAYrKxcn3tYzEuaEMbo50DfIIuK5B/2d+62kytVDID1
	 QzK+ITo3punN/X2fp79q+uC3oFag3JrOb/IpJRDdIWzHLDOuMmWNwubxoFb4RFP+k
	 YehAPaOP1QYEvhZFRIo8EKiBD+O05uwmkpTEync3lCy+OGuMcYavD+Tr9LmMNbVF5
	 sLOMxkQHtBp0HCkGfQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.2.31] ([79.203.21.144]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pYS-1vP88b0lI6-001QNW; Sat, 06
 Dec 2025 14:21:07 +0100
Message-ID: <64e62623-b911-4ddd-a481-05191853c0a6@web.de>
Date: Sat, 6 Dec 2025 14:21:06 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 0/5] ban mktemp(3)
From: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
To: Git List <git@vger.kernel.org>
References: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Language: en-US
Cc: Jeff King <peff@peff.net>, Chris Torek <chris.torek@gmail.com>,
 Junio C Hamano <gitster@pobox.com>
In-Reply-To: <784f495a-4b1a-4acf-96cd-599243ef9e27@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:GzaKAR2fNLpDaaURxjlGUdT4mV3qDdPW05bgtP06p8QdsAQmrSE
 zIeNIYahPqMMIEaCl+Q0CW7BnEHz+ZMOq8LG0H/4owAs4t6v4ma6prIJ18A5onL70f7y7nb
 PIt/u6kam5yZ1sSCaXdLvSrPT11lHCFlfu63RQ7xDsfBigtwFeHCq0rYU7/6pGZvOvutfK4
 Zcg3U+wu9278gJfa5RIlw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:qcdotS1+U2o=;qZGJUVpe3Aqqv7LAnl2+QDOZSh2
 WOCEcHrYRg+nkEVh/41pKxQRxc7COWpJy36feWreUL9+bM5aqEzhYkK5M1uLWR9HgvbqLen5b
 HpYq6M222+/rYwgifBmh6BmwsrSMRZC1OdhKFKUDLmuKT++0fkCU4Mze7iHndRkuWGhRcOYKq
 2GnWKVeQiBRIL0wzgo2MuWB8FpRBIouIFiLmh+a+1wDPPtQ5Mftj0ZKyNVuBwo/O7G7ksL7Zl
 Wh3JCMv2r0245+Whc25SmcWsA8QJBDWxCACCz/l9GClWHJwgAzp2CHEJPU99kxZNEgsuGSyiA
 c7cpy5234b7Zim3vi0ri2kDr3XRUeqlc6ftqp7QpyAU1FjOGpRKcTnkCT+GfmZDq9KP99B9+H
 GtLc5ZCvCR9FQB/hA1VtZsKn3DRZtYTeeyVOCA9PnLrA8RTT/7AyWTxcJ1mUvLMgusAthK2r8
 sFjQu0QTzD32Tlt2EAh1gK9RrwjE2LLflg19nG9YFO+sB6MjZYjnf1a60ar+7VxoAcnezIV2T
 W3SYIc4MrHCC2RXEI04fpFD1RKMogCr/rPPMWSyPeFQWh/DFODEubAQuOXKgHgNF7KU1e0Pzn
 mAuW27yqO6PugdSkGMIYFLzyOPlXpjc+epzVcJgOS44Im5tWCFlcvSCBiV5M/gNZIpWrGbiId
 12FhmRMF83P+L5IR7iH9UMmZ4BQyDVaw6KculpYGZ4AzNc+t9Ar5K7aVhVb6Ly99xHAS1wkic
 6b3G3x9NVme00PO3FPF6SnTvjGwLq8x5bACmBjC/5ErpNd2EJk4YH4KNZZn/uXsuczVIGhv2d
 WvcGPjBSx25WIPfEC7Cl7BCQi7N9/qOF9rp6JopcspX5q4ILFVRKivSLllimGbjPQPzdDr8ZV
 2+8vW7u8yB4o99/mf8SCRHEw/BCPqe+uBj8BQFl+l8qKXdM4T+j6fx2102cN3i76NuWrvItWU
 Mr68ONbvmqafDnI4jRt9lVLftbxVgvIfASu4RoJDbpJImXTj9INKH2HnRMV6WsDVtVcdXs+rC
 /fb2H4NdIHZTLo8EtM+PhkG8qUF9CZqD8dj1jW86MNkAas2d1CZpwhdD/6jwXq4Uwfr8P4wEz
 C6ZiID7bhcpnuBrAE+PGhMrnlr2x/F7PBe+ZpJQPW0vqCUvnrz0Q6SXXrYhx+nvJYwylQBwOM
 97lGIVdBagon7yxGsOuoZP23gmHzA2NlVO91RxFZ8/uEYD6l1/FJmdGrRRaiAnaEtcyKMam5e
 PlpxELHRgTDce8Duv4ovQZwTSMRXcQwD7GJNRIuvkQGhuLFPVnKruzI+jm6p65Ksx8toiCYc3
 gjgv4RUdKyK+9fsZvRbusZLcLW4Qd8xegKhi/ayrwXc7lQjvw0Rjg8QAHLm1PKqzzbyW7728B
 25udIxF5w8b0TsM6VytOsbCephivQxmAoKpmWtY/NEtEZqgX/zkVQ2R+wDFwnaQR7MKIqiFfh
 XQXdElsZRuu09600dZcjaOwYOvG069xikoD3iJrUHEqq0FQ3A/8jqEubb62NVbYANayBMAcSb
 9nzY+ZNPdTWKn1dPI5JnDpbL+ntlVWHFCu+80uMhDnUNmtnk4r8E7A1pRpfO13MpEKSJdeKFT
 3JQJ/dYwa+nrh5j9FME62kU7R4kMJw9SAcKjTjYNEtIX6XZyHBWHOo7uL2EPVuccfgEgHnVuq
 m9o+u/Hu9wH8cAHTuK/cqLcARibBwfP1aI2gYuWxtrbrXTz5/2irLHqPN+cdrPpz0gsygWqRd
 YCTSoNpxv3kAF2WMOZD9Jd8hYByzGPXu+ISrto0sS70GN99bkKUnTEL2cCBS2JnVE9o4if0IS
 qTEHMdziQFVOtqGCuTNjzObH6/AlCEzKBuksB+55yGBQwNT1XHzyBjJujAJ4pQsegEiMHxUfx
 KQP+7R25KRL3pz0zRTvL1KDbS2zU4htewsPIPEC6irP2Dy3V2RElY7ulNn6wlLl3ZG4yy6OTQ
 YgqsIY9zo4ZJlJWTY4eHhONTo5yreTF1I+75W07PN2Qmq13cOUBDh9pPLDK+aTAaXa6pEDv59
 wbNR3nK7t5mN0sSzeOQ8URUsciLfx2mLTkoOGPGuRRJqr67D4oMYV+MbLthMFrgrb3n1cy0u9
 wenG+XUqsBvWY2RDviad39rfcQtiJShq/i6MjxH9Eo9lgXL9u9cEiYMUubLioSKU1RZBXDeGr
 nGHxAZK6zCrQaC/M7e7kKDK1WWt53FF/rc3Cvc1ImGVtvM6/rvC0iFTiwaX+jbnOU3VsPSxvN
 22u0nrGMkvKY1JVjcz+Ch8HrHH9zCSqX5j5KxC6pJOqiNlzQhgdiQttUyKMi8ldQCISDw94O6
 NFs/tyUiav57P5+VxMR8NgZbKSUME5OjTMKGwZU8ysc2Gg3xir9z3E+jZ3d/TtUrZnZztdCBt
 n1skHLW5eGQfB3Im6V4/Sp23F2rbavo/Ytc80p3eIe2P2fyses+SpO/x7a4Pfl3s3d+5IpBYR
 gjvO8LPHoIFkacBmhTzF7/vgdHAqNC/i3nPdBA40O5dxXjA7lQFqsTmmw2gWjeeF+CduhKRmX
 iqCQEzYvsDkJwEv+p/YEBqh9tz9xPAHGkDnqK174xRlaQ4D6uMEe9ogbl0t7rz4BQYJNgYDQ9
 yGBkMiMtMaJQ36fSgkfMu3Ihz/6yTwtsdAlHen8nixRGVLX3oRQChiLVDwYqHiJ9rlGX8H/X1
 m90wlMjYCTmwnO8sPQfUOWeA+qV+JzShTkovBSqQq9Guodwpsg81s7oh02V3Y5U1QN8gPfNL/
 LxY2NqvZEBr4QuV35jOm+HLltmB5IYsLQvSUtlgETD1fq4QolIgzBtZxwTI9cYVfbs238Wbu4
 2wr9S2yPQloFMNxglgEp18A3woB8TkR/GV0J4nx+zZ32EhXK7iTQWTHoIfTTVyqGIqjalC5vi
 HEVDNNZ2P0eAb9JKA/xN3vE42Vg7OK5ZXR3aKx+l/soPpxwYfVcZSmR2JfJZSjMxn4xmc2ERo
 g3ZAhAk1tpsCkH3gp950MzwF1Zus7g6tY3/3FCQ9o1K32GQd4RhFv0pZ4vloaUpBsgNWPC3WF
 R4iUdZV5Pk55t/yjIhqfFBfQf7/0IqBHWrmeu/Guk3OXFrWecN6p5bRnHkOavyq0A8FKIkKRB
 o4HmVCF8XYzjR9Nf+QO5D61XRK6+rcCVZ4CLKARMpLpS30T7IfVXOi6hqYd5XENaOU18lklVu
 fmc2+VOIu58Va75E48obXduxOe8XO0zXmm26Joxx8h2Z3rTssQgzhThuo12noGreiHlK4mxJf
 ingRUboE4HVeI9SknocM1Nd/kSx3S6LXzqNAOyURMpH0/6un8K6H7RwbeTfDQqi3iBHtoc2gm
 KjQL4r6r4IIQWZPPEsPNIDczByLtCwRgpQ7teAfxnxI2gRTxgwvPzcA6Y43b6gxZ5uT8rkqKW
 n/zZyLhH/0lW/L4yr+5o8z/PsGmF4jvxeuGemrue4mtEB9XBgz5eW4CjIvCMy04QMicz+C+4+
 zKH1osvuUvSPhdAgWk4tecID5JyyP8rjFV9KMTfJVMrzhJM3kqziNb3no/zgISfipqVA+iAVr
 dJzV9HNlgnpVVSx2mYHBpCsyrAAiuswq2tKOJWt9vMhYsdDaf7IIA6CZVLjskKScx4U5jy41C
 MmXMhHkFzlngZZYxHxzRrjz4CPdvsLt61BBnTvuIpdsn69jNp8Ze6GCBj0I2Pv4v0bD+ELMPW
 EvedPfc8x6TDHeV/sf2IkuurCfZ/J+RHVOa/z4u+OUP7xk9WkZU/L73ZHvF1AvdQZIi86QbCp
 VQa4ieRh08HwRscB+Tpg+LG7yPLBaWe5Bi6/SwDgWAvRKy6vv2mH8DQ8tq2DKcG5tWs3n+gwq
 GgwangzoNGc+HZk+DJG3xjHDoVHA8HkHQWHd8GD0CGaV0tyJr2KLDg0o+Zh50IbhZlOX/8BoW
 7gvtvI1F7zlibuc/EeDcTw3xqG9pVonWqp+24fWyQ5jWORNmQXFXtirxnYg1a1pPoMyKztuD/
 JfnpZ+RTWnX+n+EUvZlVcpWG6j9+AJjfHlY48g+ztYMV36N9Bp1kn6AAFddPeUoGl4/DMDA+X
 98TjQKTxFo5dHDcap3IPkWVJ5vVkMbXpbae9kavV8Z6FG3ErCOEL320fr2R2cE1cgbg4Z0d4s
 ysh0FzVOfPNIk8XQiows/UEPsl34LG3dGtnA31TeOwWlDrmNJKP6lfiBOowgFzbTqGJrT7OpY
 eortEsVD+KecXQwvm6w4AqnMGFbSYIR2brYITEB2X9nEDby4RSbr0IVpxwhKo4VeCafv5YwJn
 B26KyPDkrFaBKubwQYO4T+30sv9/3/2BJryvvo10Y/vyc10jGyXEKmvqENbQmnjz4pneL8Oa8
 fdvide/HB42JmP3DZhd/xEovI3o2PIqNyOZOHqz6/iE+6xC+EOpKQ7YUm0rk4GmL8OUjaCr6n
 zj9hXek/wco7F2e0vTRmtOSUlUqT+TFz+zGzNlDT8avb+GRYw3T0Z61iRDfnBFAD8GOCaLEjZ
 tqjl+7sWfRq4GAOSa74o/BeMgDzCo8ilVwrgr/h6bxZ+5byh54JDnDfdl2ctmA66TDKSS1//k
 QTexR1459JWrCww8NBlBYchE7RaPY6+XhFksfhfkeamA5bgmjBR0AOSFi7X8IFhBr9pZiBGlT
 0Zb322RZy315EeHEFRA5jrNRm7q8AGHnV5MNbgly2dOukhzTDfcJqv7EYvbxu8HoFMHTeLRX9
 CMEeAl6E2b070L+/S2QgqQfojZRJ5mpwmuTN1lM+Macuaf58Ock8iatc12xIQUj51SYqDkgC5
 2gIxAY93HjCEj5Q/23vf7UTlrN9U1rmc0bq8kh63aW5YKU5mJ7LkDm6y79+mHKXtDbGztqBJm
 mlycVGjhZDhLlDPib8llXNJVlLFaXxXKiOxE+zSYXEUJT2ZLXBjjAUbcdZz/BtZuZ7YnzhdJ3
 0uUoEK/SiKQEwrqGo/nmmHRe0OoRmwObrQynliJ7V1W/uaCkxnxD5/qtnFZFy59tL09Y01MGZ
 2KIVOeXICk0Se9iKVtW0avTZuaXuF0pEsG5SlCSNobv1Hz8Qp06Rrl/hd3jPQ3XrNTRv1qZ4J
 2eiM8sMTm2Mhg2O7YWyUVSU3Pl/nyfch3MuMGaNjxpA9uSz

mktemp(3) is insecure and POSIX.1-2008 no longer specifies it.  Stop
using it.

Changes since v1:
- add comment regarding return values of git_mkdstemps_mode()
- add patch to drop trivialized gitmkdtemp()

  wrapper: add git_mkdtemp()
  compat: use git_mkdtemp()
  compat: remove mingw_mktemp()
  banned.h: ban mktemp(3)
  compat: remove gitmkdtemp()

 Makefile                            |  1 -
 banned.h                            |  3 +++
 compat/mingw-posix.h                |  3 ---
 compat/mingw.c                      | 12 ------------
 compat/mkdtemp.c                    |  8 --------
 compat/posix.h                      |  3 +--
 contrib/buildsystems/CMakeLists.txt |  4 ----
 meson.build                         |  2 +-
 wrapper.c                           | 21 +++++++++++++++++++--
 wrapper.h                           |  2 ++
 10 files changed, 26 insertions(+), 33 deletions(-)
 delete mode 100644 compat/mkdtemp.c

Range-diff against v1:
1:  830e6375aa ! 1:  413131caf6 wrapper: add git_mkdtemp()
    @@ wrapper.c: int xmkstemp(char *filename_template)
      #define TMP_MAX 16384
     =20
     -int git_mkstemps_mode(char *pattern, int suffix_len, int mode)
    ++/*
    ++ * Returns -1 on error, 0 if it created a directory, or an open file
    ++ * descriptor to the created regular file.
    ++ */
     +static int git_mkdstemps_mode(char *pattern, int suffix_len, int mod=
e, bool dir)
      {
      	static const char letters[] =3D
2:  889903eaa2 =3D 2:  f8850b2a92 compat: use git_mkdtemp()
3:  255b97254f =3D 3:  6986b4b6bf compat: remove mingw_mktemp()
4:  8300d2e224 =3D 4:  f34252f411 banned.h: ban mktemp(3)
-:  ---------- > 5:  d106855a23 compat: remove gitmkdtemp()
=2D-=20
2.52.0
