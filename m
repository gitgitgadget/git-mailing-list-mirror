Return-Path: <SRS0=BIPJ=BF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DEDBC433E3
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A3C206D8
	for <git@archiver.kernel.org>; Sun, 26 Jul 2020 17:41:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="Zh6q6TAN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbgGZRlP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jul 2020 13:41:15 -0400
Received: from mout.web.de ([212.227.15.3]:59765 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726117AbgGZRlP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jul 2020 13:41:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1595785273;
        bh=pm/rbGA9sbS5qaTTgZEdX/lMutxge5u9fcX+Xu3PLHg=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=Zh6q6TANWXX46Sdx5/3s7KMxWlIvussJvfBl7zyVJ85UzLjszp+6Dlb2pvr5HtWQa
         1+U6DtMEgV6Ln8g77Uho5egmu5y2uYFQsI+KnZ2M4GAaZchNKD8V50rkYWjOcCzWDX
         Xya78/HgGSShgOepaNgfYNrncN+1ikq4a7r2Xa7E=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M28WT-1jxHns1XEf-002bQD; Sun, 26
 Jul 2020 19:41:13 +0200
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] bisect: use oid_to_hex_r() instead of memcpy()+oid_to_hex()
Message-ID: <c2f9ec40-71f5-122c-add8-08d6a4bfa859@web.de>
Date:   Sun, 26 Jul 2020 19:41:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:KdMykYGVSrPYLtbKFzogEOPo2c7OajNv04n7FdTAPAzt8Y9bLuJ
 Z7RijhgYjQeG/dsUFqd/9304xNyDlLR0/cvZHjIa/xBaydRNtyt9fS65bGYbkXE2nolMdhY
 dylWat2CbDkZzFOxvmmA50pNqv4iBQ3zxdY0sZPt+UAUcZr24xAX7JlsLXuF7phG48/vLfO
 KsmoMI1deFQjOMt4QKnvg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:uViBVKNY1Vg=:lsW6qxLkTCLFx0qNwT10QK
 9SPyu73R6Cka3ugbKSS+CUwx45kBWwDNm0qhmNycXKxmHcUv0N7TvMZkLp8+c815Zqb7hT+zT
 RWV66mOFchJpT3ZfR/DeF6Lms16Q7/nuAeVyZ0lapgkuldZnBE10Jj2B7T7d7njmIka1JDbev
 +vPF7Gcq410KKDpmtbC0M/22MhrrsKUvmoqh1nf8q9bh15qNnf9MuwI9XL6joxyfeN8rF7riI
 2B4EQSX8SC2cksnOSfXBVcYnJW4ojC3pY0FQ6n/hHTfbyU3NxpxzWEWuB3HYAA/lah2q6ebb9
 9cwBmKkh3/bYsP+kiWXGen9B3l492N8RRC9sbb773YdPGRHkQ79KmVWe/vec3AquOmvja5d3v
 l2PJAspXBZEwO+MkXGailiBu+WTwtWakcwsjQyJFw9CXqrCrlxVOBmOO4iz14DkXdoDgDRW/s
 Z0fYo62NY+C1nwDxoxeytYRK+9/gFgF3nECk8BBk3sLnzrysvr9eptJ5rcqBYJIkPM14Bt9ZT
 ArDrUBnpc9lCt8V2ZvtgJUlDerA9WOAcz12KrfJ2BLSX+T1UuQ5cDiIdbc421kK3LkOjElB47
 hoOXOC+/YWsCEs3Dd94gVMNljji+1u9luGsJWevKs5YyaU5Xx9ERO71m619ksvhC5qmKhPIkf
 jFm45A+dMYagSAbKMiGBcd/kDTrzuIe4TsJb52JbKeeHCIQ5A1fhfSu58zvlDE344ZVHyYSyK
 Kj+aeqQYMUDl3fwn+m3FqUH+kmxllp121XL+Wp/OfdExjsOm6QmvCLanP5oLntvb2vyqtXka5
 xUEQP9k83bvFj8KIEch6HHG/9cyA6GWiNJsXcPzRc2B8J/F4kZUCrFmU/VIaaSJftibK3zOBH
 b2fJSB3yzcIb/xEmmoO22JR0V71OG/Z0Dzs+hspe7Ds7XNPB9odZygiGObf2uGmMVEATS0CQn
 9mu0/Mll44IpExLxtXMxJwgckHavB3V+9ldMHgNdsU5Kj1AmWvk0zjJo53OTOLM1ezrMMp9pX
 SbAg3X3hUWM6tE3Ycsq/FkUjmyVfAGivjNwyO/YqaGeMKIkEonRfx/UDV7ObOPP04RqzXC3oS
 ppu8XPbNADTLeN3SvBOprVsipff2VzjRaGJGrO+Xi0dpxiQFqjilvzQD4QrW2siIbSkVZfLBh
 FWfi+AHGMs0Wfjoxcd5eLzrRcUCX6JrF6U/z+/rnNqZ/xhbA+WG/nUMlsxpL/iiY4ploQqHQs
 JxQkTvIfn1dZcMd6v
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write the hexadecimal object ID directly into the destination buffer
using oid_to_hex_r() instead of writing it into a static buffer first
using oid_to_hex() and then copying it from there using memcpy().
This is shorter, simpler and a bit more efficient.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index d5e830410f..be3ff1e962 100644
=2D-- a/bisect.c
+++ b/bisect.c
@@ -709,7 +709,7 @@ static enum bisect_error bisect_checkout(const struct =
object_id *bisect_rev, int
 	char bisect_rev_hex[GIT_MAX_HEXSZ + 1];
 	enum bisect_error res =3D BISECT_OK;

-	memcpy(bisect_rev_hex, oid_to_hex(bisect_rev), the_hash_algo->hexsz + 1)=
;
+	oid_to_hex_r(bisect_rev_hex, bisect_rev);
 	update_ref(NULL, "BISECT_EXPECTED_REV", bisect_rev, NULL, 0, UPDATE_REFS=
_DIE_ON_ERR);

 	argv_checkout[2] =3D bisect_rev_hex;
=2D-
2.27.0
