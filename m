Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCA1C433EF
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:04:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B60760EE3
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 04:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237387AbhJHEGr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 00:06:47 -0400
Received: from mout.web.de ([212.227.15.3]:37271 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237160AbhJHEGn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 00:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633665883;
        bh=NAJnOPJHM4rWarUMM3Iq3UdU8ic7qASqEnCUAZGJV3E=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=q0iPfGJ79+I+sIg7CnHRknQIvn2VHhX9CDk8KU05221/N+tQWDaTHa4rBvGE8Nxc/
         lzJ50RObga1fnZwdHRKJ+8kzcehvUV1GhzpQYJ/5cpCuXkZs9Ww9OnE9zXTmxvfZUA
         hjbVjb3oisrPilIQa0bl7MIHrXRL7yCl8qN6461U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0MYq7X-1mKeLo3C1T-00ViBS; Fri, 08 Oct 2021 06:04:43 +0200
Subject: [PATCH 10/9 v2] test-mergesort: use repeatable random numbers
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
 <522fba5e-1048-3377-45c1-7107b55dc6e1@web.de> <xmqq7dew7aqd.fsf@gitster.g>
 <87o887q0s9.fsf@evledraar.gmail.com>
 <850aa059-61d9-0eba-5809-e0c27a19dfb4@web.de> <xmqqee9210a1.fsf@gitster.g>
 <a3eeb255-56e3-eb22-ebf7-e9f04c95fa44@web.de>
Message-ID: <b73452fa-f5b0-0ab4-25e8-7494637c49f5@web.de>
Date:   Fri, 8 Oct 2021 06:04:42 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <a3eeb255-56e3-eb22-ebf7-e9f04c95fa44@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4X7VE5zOxB4gh+T8uaJfcTCq3SvlxuZrL621l+GsRsYB57xELoa
 1GTh6k7kpZqXKZ7QTj4vNcv01n8EYYG9vRRYtxR+9cB5puZVQrFq3bSlCJSw9eVTPICvvyP
 dGQm248LlFTFaICgIuPNQ7lWdbvG/B+AASwP68YkDXCup1Frn8zVMgHtlcelTslZC70rmiY
 n+fwgrSTfvvvCdXtEhRJw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PiJs9it9MXc=:+QgvUCcYsXQ1Uu0u7NyP93
 im4fCPqEk6oC2SDmifBLxEqVVV9eBBhmP65/+tUKWG+/vbRQIqcUjKX+RtzTJWy5ueKw/bQfo
 kIxH471SNNogOEX+2+V4VucFg5qMvhTucqzYKYDgaX5wX0zE53ojH6ihFA9ZZ4ibMSNbSYBIc
 yTZddZ6cu1y47kj6KHhn1dKaXGQO6wjq4VzhzMtTVfgKN8rRT4/oa3A6f092AKS4JPlfnnp+c
 HGvvPb22y+smr83NtamCcJovdnh/bSQUe6gy5Mq67wtXYgDCTdxHTJnYYq8428ScHHEJsEZ9M
 ZRBCHtZe+3IbUmHoq2yRmkEt0/0/r1j9iAxYEzHuhUiFYt3MpsHyxfVyldlN01RZD8EGY5hOq
 XKqCbwmY7It58PLlNddgHAtR+44cqobm5KGRNgyEomjvKNcYU8VB5leVit64Pd8cJFdIWkwkY
 krW++rHInS7e518MEM2r8TXC/VSzmQK6ZRSNxHaf5fVa/t2lQ9lapt3HsZxKEMcZAdyJalcHU
 PHyZ2akxJ5mgZasCLCNyZ3ywBYJ6dnyLPuGiasVMqbGv00ieo+RbgSsiIgggc0pBBBfNs8amX
 6N2BvP7SY0KlEbGOw3PUw7J9r0A3TIuVOZhj3+FYqJNSpW7CB0Gi541V1V+Q/d/exNcCmfdu3
 7J38zBmL0QLo/p86IVoJFuRt45itYBFWBnesKdMRgv9xcmjuIalyN/ovEs4YCij+rp/Xln3BN
 BBOf7n2QyrlFf+z+ro2zXXni/2lWlea+9X6eysENQEhzmVlgBTJNgnKxHJTNXV4mAlWgIlg25
 VEDDKWeXsGwCsrJaIvi+WkbylBfpOqdyOLstuM2M0iw2YVXm96V2dfBNjb1XHPKN3oafX1Tuk
 FZ2jgX8gzuiX6GNjy3XSBYXg0EJAUBbLkHyxx0RFcPtMMWkccmNjzaRYZaqpjxpaGrFCHrO1S
 TQAfeoDr77SZPd3ojw/+O0zrmvOrGtDFlRf9hg0yDWONf1lP19caicNaHin0s4UA6w8JUtUAK
 lhsfMppprmTRSyYsdpze9RNa6k+bOZYZV1QiHzkyvO+LqF5vrtxE4z+iqa6LrJHVYhJr+nrcW
 SYH0fBFsnnGlAs=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use MINSTD to generate pseudo-random numbers consistently instead of
using rand(3), whose output can vary from system to system, and reset
its seed before filling in the test values.  This gives repeatable
results across versions and systems, which simplifies sharing and
comparing of results between developers.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Change: Use uint32_t to avoid relying on unsigned int being exactly
4 bytes wide.  D'oh!

 t/helper/test-mergesort.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-mergesort.c b/t/helper/test-mergesort.c
index 29758cf89b..c6fa816be3 100644
=2D-- a/t/helper/test-mergesort.c
+++ b/t/helper/test-mergesort.c
@@ -2,6 +2,12 @@
 #include "cache.h"
 #include "mergesort.h"

+static uint32_t minstd_rand(uint32_t *state)
+{
+	*state =3D (uint64_t)*state * 48271 % 2147483647;
+	return *state;
+}
+
 struct line {
 	char *text;
 	struct line *next;
@@ -60,8 +66,9 @@ static void dist_sawtooth(int *arr, int n, int m)
 static void dist_rand(int *arr, int n, int m)
 {
 	int i;
+	uint32_t seed =3D 1;
 	for (i =3D 0; i < n; i++)
-		arr[i] =3D rand() % m;
+		arr[i] =3D minstd_rand(&seed) % m;
 }

 static void dist_stagger(int *arr, int n, int m)
@@ -81,8 +88,9 @@ static void dist_plateau(int *arr, int n, int m)
 static void dist_shuffle(int *arr, int n, int m)
 {
 	int i, j, k;
+	uint32_t seed =3D 1;
 	for (i =3D j =3D 0, k =3D 1; i < n; i++)
-		arr[i] =3D (rand() % m) ? (j +=3D 2) : (k +=3D 2);
+		arr[i] =3D minstd_rand(&seed) % m ? (j +=3D 2) : (k +=3D 2);
 }

 #define DIST(name) { #name, dist_##name }
=2D-
2.33.0
