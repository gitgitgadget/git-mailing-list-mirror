Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD40C433DF
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F0F5C20738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 14:37:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="rBNq/LZi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgHBOhP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 10:37:15 -0400
Received: from mout.web.de ([212.227.15.4]:33961 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725778AbgHBOhO (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 10:37:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1596379022;
        bh=RWIkkuMeH5CzyidlJDP7HykNknhAhgRCcLjwDXatJ6U=;
        h=X-UI-Sender-Class:From:Subject:To:Cc:Date;
        b=rBNq/LZip46e7/NUd+bZFfZ8JuU/RKoVrl1ffrFwOndgwlLgtrS8ziYH651rRIUAc
         qMF9bekioi2fDgKwTa+ShTBCRJHrRP42T5Lf+2xVltE1keKbDjNfJZeQ9ix87Yfz+7
         ofsMeKFltNZijr1CwQc6BR7qlBIefHHxW1yi1Sbw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.26.151]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MTfon-1kCMwV22d3-00TzrM; Sun, 02
 Aug 2020 16:37:02 +0200
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [RESEND PATCH] bisect: use oid_to_hex_r() instead of
 memcpy()+oid_to_hex()
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Junio C Hamano <gitster@pobox.com>
Message-ID: <632682d5-e343-c069-f4b4-0451072d54d2@web.de>
Date:   Sun, 2 Aug 2020 16:36:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:gvYVQXAeqUhv7L4ofcUzPcIkRDaYbrAML9rSpfSg6aVJO4J/sSv
 cEuPLsjPpU51vXesToyXr8PgjvH+MvcC2DoRmtG0Xr6bZIEQqoKJtGYLIuK36Ff2oWdRGbs
 V72ruKzZetRIh3Sxr9N9AS/PESaRKw3Px43MBxFMZ45f2fHt8qwtMMmwpIv3nM3cRbjfssW
 hbpG0NiqlEYGl8haUvvIQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:vJwEknzpT1I=:naUPGU1AdXsmBRH76AkLH0
 rjao+tngJPdMmywmLRy8WE2xRdora6C9AMupzRQclUb+LYf6RCPgVLB3B0P4EfgaL2YijYlKc
 +/UT3U/+i3s2+iR5PeCU2WxFRTT0WM3ewzL6sd6dSnDPxE9QMI3Sk+b/UGu7tW8OtEewQ1PJf
 Cq/s1N31Ml62zeHu4bH8GWHS1tyeY62FtKkN+YpcemP20ZtR/SpvxaH0H2/nINAhQvdhZQI3c
 qlbb2rUzXBLQ5pwbxBMzeHsH+lszlI5nIOpJ6rkQJ1+VJI6qVHPbjgQFFDZqR3P1zwC5Klnja
 GQVViHJ6wLPIecugnfiHb83IOxngcOaLLpGlFpon8eLYniMMqnZ9KfJ39gE9Fkhd6itj7/2+t
 CTnM9wzHSRSrglIIyybqF371MyyIwS4ncv1gwgZt0uKYjc0nea1DtlNJGh8/8/Uk8PCEPjYWf
 HRKesqd42lH8LfMS7XXW0op+ki/Ytx2rbQm7hVRnzT2aIouK8ksthBNp/UtTuNbL0E179V3+v
 vQY8gDO5zGm65VbIPwplpkQHrB9kIm7JbmkDhzdty1U9pJZAyhxUVo1loWY3hLu69LYHdcp15
 Evi1ieXNET5I2S59YGyIu9T1D/2zLSdBljBEGHBec/9inPFfZQSL02fwxeetFE6SZVgaKbxLE
 /vpLDIqh8a9YH4ZgIr0PIt1dm3yYpm0a8F1xuJH4OhGHK3giVZiDO1uCaAnbGmz70j19e6p2/
 qoY542t6uK/cs0zjLUJp7WQA0a1/Yq5wnjh0tjSXzrfNQ0vvoa7w26J1njJYu/+IHLomyxbMY
 G8xQz8X/CKl+4dIB+dKOrvcVasoFSqxh6avnn7AuTaadH6BxONQgOFsGJmaj2WGubpbEMHdb8
 +UeVZ7Ob0WUDtvkgGUryLb78zjJ9eLWg0C3oP9h0jM2gJn5BrthU6xkYy4teKCMoRIeCWZUZa
 GcW2p379KXjqCTi6z+qhYs6d1DYQMTGvwS4tUe4syFLRWxBPYTBqY5cLd+t7/6VYtUslba2xB
 fZOl5PGLnWA7gv264E6qKeFu1CKacXTww/lVoTRxSNdU+d1KjQobnF9IA9a1d+WnLz1LbLKDV
 8wOBJ4kyfADL2WxzzZReqe8S/q+8YpIEOcoDfwZMlE6Scj4P8fjXhgkT7Opykue0zWpDkzaj6
 8xcodcW0modWU/qAK+6+HN2qbbFOu1KixYWJpJ0CKtUtaWwm24TSyRQstybRkAM6j66L8UYPv
 DMdwJfbYvZgAqxF1H
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Write the hexadecimal object ID directly into the destination buffer
using oid_to_hex_r() instead of writing it into a static buffer first
using oid_to_hex() and then copying it from there using memcpy().
This is shorter, simpler and a bit more efficient.

Reviewed-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
Original submission (forgot to copy Junio):
https://public-inbox.org/git/c2f9ec40-71f5-122c-add8-08d6a4bfa859@web.de/

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
