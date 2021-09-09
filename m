Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD31C433EF
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:50:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFCF3611B0
	for <git@archiver.kernel.org>; Thu,  9 Sep 2021 21:50:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346952AbhIIVvs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Sep 2021 17:51:48 -0400
Received: from mout.web.de ([212.227.15.14]:32931 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232371AbhIIVvr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Sep 2021 17:51:47 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Sep 2021 17:51:47 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1631224236;
        bh=uZGBxqA9UdWCYvTqNC0mLipS2JMCyS73ycBMUkmYYzc=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=G0Gks0Y7NhzqOkW38RH7B3eTsgFV/jAtRsHWD/Jy7Q49lDDUdJJb0YREO/edzgATc
         IZ3hufkFoK1iy2WZtod7H7beNyfrRjLsKRv94iqhoffzWljoP0AfTcqAr0Rz8ttkoC
         goiY6SjQRycoflveqpxl9Mw0fMoVQkZVMlrLEK/I=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb004 [213.165.67.108]) with ESMTPSA (Nemesis) id
 0LuqfJ-1n6gg70g9B-0108pm; Thu, 09 Sep 2021 23:45:30 +0200
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] setup: use xopen and xdup in sanitize_stdfds
Message-ID: <2431d9cf-a2ed-ba4e-f7e5-a8427d9f9860@web.de>
Date:   Thu, 9 Sep 2021 23:45:29 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:oc1B1NRCVtjGJ1fHM0De/Xm/dMCT/wiSOaD5Y6Dazu4OSJOL4+L
 /THZ1c9sQCosoY127xgr9i5tlCUlorJ7b8OPd4fcxU2VpKadECnvz4DLWgiw2aEjvvoWhVG
 r1ETOgyGshekNOz1O7J9hMDKSej5srknKMLTpniCDnths8mZKUDw+l1SZi1DEE4xSYO/05Q
 f/fyAvlD8oDiKu4qOqJkg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:616DxjA+34Q=:eWXVEsdbX/i8VS+qbCp8kD
 AWbXSXYelpfs/MEwqtBvA1HTjFRAB8+mTCu4NiFfCe3clpq1krnQj0p/nev9lVYtHYpwOuQr4
 aht+LpNM9twLeEOdIRhn/gTROWJ7s2IQRxzGvwZxBmkCRvDJKHCUDnNR7mLu1Pgk27tIn4q1X
 Ah0T97IsnphnORbjZsvMwYmHCt3V+yc0cwHIwTOZMKpjN3gqTsa8aLB7Dr0/10NswMKrdRewM
 F9tIKvLIo1VmqNTdyPcJ3TCXvQ/X+FBCcYoukrHbKyCKnb03SbLcvp1kirBnJcIvn/Epc+Ap0
 KGA4+ywoEP3awPW5Ew0E7hFlY5H5Ks8x+Cl5aFwacJ1KLkiAhk2/2KUve8HP28ApX7z2a+QI2
 F9jpSCl4XLcppP9T5lTOYQuZdzQYz5lEg7yYoY3UcTdCu6ZhQkv6qE9OstFkEz69PESdSg+5w
 i2DAPyv5KonGPGTJzCWwFwP7xA2Ebm9XraMjR/0JHWHdU8oE10FR9ln4+2HNFWXaaBmMMn/8c
 rlChuvbghnTNT944iyXK7omf0xXZEEdrC+mEIEWWHJH5Cl0nWGWiV+OWRoMVGpAkP/UeWjq9o
 cqL9RIxqbMYWHG/Y3wfpY+XOJEt7aYs9N1O2ykk7ac/fJ2vq/zpjwoIGlEXXZxEwp4e2tVCzF
 Yt55USST7YmkViJ6nZElV7VLQ9Q0iZssaztAlIW/kCixqe99wTKG/3Rfx4ICbNYWeeQHaTdfw
 vxBpKy0z7Q5kYPUaCwV0pTFz+qq6OczGzwQnMSm2c6eiZhgEIYTLj6W4gC0wEVtaWifr6u4Up
 KVf0QCeL3NbHlj3FhDHwoDqbsFNeMpcHlZdeQZ4pshIcJJnGMMYYfHghhJ3k9Gqkq+G3ERk7r
 KL8fqx6sqc0ydFt/zRmRUjsCCzjwNsJiPJu6+g7l9uyQqwPg90Mb80d+OxoaJ7m9nu/5iqOFt
 VaJqWk3hRaSk/GtJ6IYivvAYfaV1Z3mtwQhapdyfXzdtewfAcbloU0SO9de7o6HtHAWbllDRU
 8y75lSk/8J1kc+Kz3Km+Fal2+2kwDcR8b6LIulTEED5c3ys3I+rgeKsP8AmDWP0sDg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace the catch-all error message with specific ones for opening and
duplicating by calling the wrappers xopen and xdup.  The code becomes
easier to follow when error handling is reduced to two letters.

Remove the unnecessary mode parameter while at it -- we expect /dev/null
to already exist.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 setup.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/setup.c b/setup.c
index eb9367ca5c..347d7181ae 100644
=2D-- a/setup.c
+++ b/setup.c
@@ -1423,11 +1423,9 @@ const char *resolve_gitdir_gently(const char *suspe=
ct, int *return_error_code)
 /* if any standard file descriptor is missing open it to /dev/null */
 void sanitize_stdfds(void)
 {
-	int fd =3D open("/dev/null", O_RDWR, 0);
-	while (fd !=3D -1 && fd < 2)
-		fd =3D dup(fd);
-	if (fd =3D=3D -1)
-		die_errno(_("open /dev/null or dup failed"));
+	int fd =3D xopen("/dev/null", O_RDWR);
+	while (fd < 2)
+		fd =3D xdup(fd);
 	if (fd > 2)
 		close(fd);
 }
=2D-
2.33.0
