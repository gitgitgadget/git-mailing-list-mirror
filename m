Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76C0C27C76
	for <git@archiver.kernel.org>; Sat, 21 Jan 2023 09:36:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjAUJg2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 21 Jan 2023 04:36:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjAUJgY (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 21 Jan 2023 04:36:24 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 132A64DBE8
        for <git@vger.kernel.org>; Sat, 21 Jan 2023 01:36:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1674293771; bh=ZsCu4HdlbTBS/HDXiq2KmZl+Yd4T1I0kWrblazCjH0g=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=JyKp+cJNlOigHHk3J3x1mJnY4tIrwxSN22d4HOmzFIvWWMs6ylVznMLcemUkRocRB
         ijvOVOAtntOGM5hO2MJq40abyV7FtP0ysIVUc8MnWFPlPnXgkqmt57XRg/rpeBOSe3
         QnDZC8axqfAiQFQqD85eACw9fhvJCROsF3oizY2NAMt7t2+dseQ8eZlGv5gZ+S+9w/
         +tB+o5Pp4e+ev/M/9GvF8szWxaJRuKSBE/Ice2oktEOBFwm00x4W7yOfSkAU+XXJCN
         PeeKEY5CZ8qdWp4a99O65WWDHAbD3f+HNtXy50L0fCiXS65K0wiXmZDU9bxtNyTyjF
         FDGrAMrDgCU1g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.22.223]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MGxMN-1pVUF73SBn-00E5ig; Sat, 21
 Jan 2023 10:36:10 +0100
Message-ID: <d673fde7-7eb2-6306-86b6-1c1a4c988ee8@web.de>
Date:   Sat, 21 Jan 2023 10:36:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] tree-walk: disallow overflowing modes
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:TpBniwBIp7jVEiLhyPe5Fy11C0RwJb7teKIfAeWRKAEsFLMaJEz
 X0TMLH3g7p1GxvYkr30uWHOdAlh1hEkQ5Kdn6NpZO2otOigsfoQUrDSI0ZHiq0ntWd5Z8XB
 dpHoEDUuNVFI5W5VEQxb+MnU6GA+X5toU36d9knbNaJqDme9Ho5nHU4McmfZpgJBqM1cx0K
 kDBH1U88e+4s1UAHUoAnQ==
UI-OutboundReport: notjunk:1;M01:P0:L9buMgVT7qA=;AZt9GBBdCWktfRu5QBddthCJ2re
 n2FXMUCcWLiQoKSgKTmiJFddVmXw3m4m70cc4iomAe+UMp1yRPxHCvGKzlgLKKyz8BnDAB6aq
 xVlcQj9aTfOzhVVGbjogJsGFWQWLZAwMuTd7BC9mkKdUim04y6bLvoSmbdeelQsnXCJxSlhiA
 JcrRtDyFId9Qsm7x3J+UEY6vlDwsLz2jQV2yZDAui+CzRlGPgCiEqNVGkWSIQi8cBht/LUAQV
 6ZbHQdOUyRUXQ2vqRi6r8y+r+BSUUSsqXGbGzC6iEjkDxPNTz37riNI4i2FhLqv3yUcrPiMiC
 Pczl6dLclS6JergDn6ODwozCrEklDTJkwtJr9IhDRTNY1AD7TfLII5QPlJOKTl9w0sywHcJXs
 I9/OKSVzWTrQnQmQz/iGnT23jjyxzlVfOAf4iS0NHjPhRMexikvKlUVm6p5TUfS+l48DC91bo
 8CTyXmAiHlxnmm3vLbdMVM45gr9sOgOxUhD8gniVIquJ2x00x8jM/WElHCi+PKrOrkYlAc2jI
 DbDwzzPl5KPAwPah3mikjJIs1NmPF9B3GlVHQLpG2ZF+omp0JhJfqXYynNZVzQJgbZEiYulZV
 gjBT3Ae1Qp3VzezaxBT+B/ISdggduz1d5opmlwLB/podbGZKAnEBMaFOHWIQ/qh4gFnkCVyN9
 /f4QL/q2pwnwF5TVdhbExJK1JrSaAIBtzNPIrxldMHSDtd9VwyjTalM6L7f0ra2Mcc5Szya2s
 ikTnTf8NPg4mMqUJolDfQu67HD6uXpTsA0bL0U32WZdymuQzyKajwPx6VJHykZ0XEDmKdo1aZ
 ipIi5ZcDbPkHM1KesNJdR6wgJHoaHDQ+nMo/EaL9zgV0cQWhb+XCQ9OmMStSQHckn0h9Xxd88
 C6+IP4TPFNP4vlGSpli/6Ofj3O/4iijwl+QBjpAYHKmn7t4/Buc6o/+DNgJ53yQOl207PDIvu
 +AOuoA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When parsing tree entries, reject mode values that don't fit into an
unsigned int.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 tree-walk.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tree-walk.c b/tree-walk.c
index 74f4d710e8..5e7bc38600 100644
=2D-- a/tree-walk.c
+++ b/tree-walk.c
@@ -17,6 +17,8 @@ static const char *get_mode(const char *str, unsigned in=
t *modep)
 	while ((c =3D *str++) !=3D ' ') {
 		if (c < '0' || c > '7')
 			return NULL;
+		if ((mode << 3) >> 3 !=3D mode)
+			return NULL;
 		mode =3D (mode << 3) + (c - '0');
 	}
 	*modep =3D mode;
=2D-
2.39.1
