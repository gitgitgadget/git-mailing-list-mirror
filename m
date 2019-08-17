Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 789921F461
	for <e@80x24.org>; Sat, 17 Aug 2019 16:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbfHQQYG (ORCPT <rfc822;e@80x24.org>);
        Sat, 17 Aug 2019 12:24:06 -0400
Received: from mout.web.de ([212.227.15.14]:53403 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfHQQYG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Aug 2019 12:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1566059041;
        bh=paqw9ABYIxXOwh+DkcFguvyQFjXNjPUjLVRxMhZZaPI=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=fEq9u14R6olSvMkr9MG47f6q4YUlk1sifaKeu75YYGUB5u5MQJPsNgrKuTZxCTe0l
         dDL2zT7UDRb+EYTkklfqrdmEG/Ei89tCE+fQuRnosGm9i8xe6GHoYoDaCmja8BLCj/
         pfukGo8XC+A9HhK9vZ0hkhG0wa8hHsanyqB+Plg4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.23] ([79.203.24.71]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lmchn-1iZBOU3Gt9-00aE4V; Sat, 17
 Aug 2019 18:24:01 +0200
Subject: [PATCH 2/4] archive-tar: fix pax extended header length calculation
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Message-ID: <4b04cf3f-966a-3aa9-6a30-7ac3a234e1ed@web.de>
Date:   Sat, 17 Aug 2019 18:24:01 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <c77a0081-93ab-7b97-e322-9616f6e7f86c@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MLvEs83HScZGu58cHBO8L8IvwMlZdBsbBLskf7YZMUUUjfNi5d9
 KhML3a8ZOUOfFbSoidOwfazcx/xqca7Ko9xL5MFyajCz85JgYXrsdxL2VXgQNsqveqWUINx
 IXCZz2iSYgsiHEj5TFpS91y1cyfUXSLFRCsuQNJkWfddcS0EjVST2InXimo5KShBpeMQEM0
 VYUeEhXI3reTXH2cj28qA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Oe5J+b5MT0Y=:McZT0Eb6P91SLPCdMEZZUA
 aSfS6ulpA3/GQJKUf2zDFmPofK2Ii7QGIq2BWLHJ34MULS6Nxh9yezGqYFiV84CVs4CctUktV
 Qzzj44v0ZAgROSwVkNh2GAK5Ej1Jqr5HcvpjeyINWSWMPxg/iZwb7Yu0rvNDwFfHSijCD+nH1
 udmMV1lvwr7RU81N/YScWNyv7HmKRxgyGSyrtYkL3oxGtY9bpEYET4V47q06SWUEKRXnRNAxR
 wHDaNcprrTbii9Xwbx9JNAOOL4pCpZ4SIS5M5LnWotiRHrHUDsAS+PDamsbsbGidP6C/fEe03
 4G+Hh5FkSZEXgG3LwauzaXSAEj+5PUdYZbYW61C5F7lto8EkYdx5FnTG5feiqNOxuBYEXMDAe
 sVnwUtDKF44SHVqLDxd0F8Yh0qFMthOYUoswrRb0QduQHO64ejLGFxQPi56qhyzktl5WJj+vO
 r0/MYocHvK7jKWrorvEFQlshPMPxUupG85rfpNwLcYkoZk+QI5nlIlVUnRCNdcWmEGiqWvU9u
 awqOeBY5xZfV5a1Z8+/d43Smp0396M/jTQFSEjKPcl4ClVcv7NcodpROaBJWHoq1dzQAfp0rW
 KqV3q7jHu3AwsVxpPi0N7pHBQoy713ZzhAltq1n54thcjQA3qkRkWkYXjCNbPRB3ySertg2Vq
 g+2vMWUjB2ZmHirzawV/rJr4fXtAaoBskBRFkdq1QBBOCcwuPNJ9nhbN4LgMtPV0vufu9HnwC
 WLT3PwIZ7jFRDCiPLzCoBx2mDvK4t4QYVkPKO9wpc1GXrbslMruiteW3rfo2DDL2KwKy2WaFw
 /2nMMzn2JUwuXcWlvzDApbiJ1BZu2cjXEZpGC9xS2qYJG8q4rEqfshBeopEYhBcYI/wM6HoPT
 Zf4qzgX9Yt54ImpAM6FqIryVVPohwvKXMZGQOPJl7745MTdAISACVn3vDHtFcUyUXH5myi02v
 sdJ7O2GiTH+5MbdaM1SaojlmbMukUPeRCITVuF8mwxTf4zZQPVVwYnYaD6gwpdlClqms+++05
 rqpFK1NeKHCjmqtzF9nZ3BuiJpaOo9uPEHV2yhrVzhqpbRnvmxMh0Zu7haLuDhZ0Sq1t/ItGd
 /a6ku19rXFMsTbhgF1Dt2pFntZAhmDkj1+k/Z8tJBh6TrZZNMba+0SW7p3fxC/xbSmLZ0Jnu8
 ogBEo=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A pax extended header records starts with a decimal number.  Its value
is the length of the whole record, including its own length.

The calculation of that number if strbuf_append_ext_header() is off by
one in case the length of the rest is close to a higher order of
magnitude.  This affects paths and link targets a bit shorter than 1000,
10000, 100000 etc. characters -- paths with a length of up to 100 fit
into the tar header and don't need a pax extended header.

The mistake has been present since the function was added by ae64bbc18c
("tar-tree: Introduce write_entry()", 2006-03-25).

Account for digits added to len during the loop and keep incrementing
until we have enough space for len and the rest.  The crucial change is
to check against the current value of len before each iteration, instead
of against its value before the loop.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive-tar.c                   | 2 +-
 t/t5004-archive-corner-cases.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/archive-tar.c b/archive-tar.c
index 355c8142c6..4395a29ffb 100644
=2D-- a/archive-tar.c
+++ b/archive-tar.c
@@ -149,7 +149,7 @@ static void strbuf_append_ext_header(struct strbuf *sb=
, const char *keyword,

 	/* "%u %s=3D%s\n" */
 	len =3D 1 + 1 + strlen(keyword) + 1 + valuelen + 1;
-	for (tmp =3D len; tmp > 9; tmp /=3D 10)
+	for (tmp =3D 1; len / 10 >=3D tmp; tmp *=3D 10)
 		len++;

 	strbuf_grow(sb, len);
diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-case=
s.sh
index 2f15d1899d..4966a74b4d 100755
=2D-- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -217,7 +217,7 @@ build_tree() {
 	' "$1"
 }

-test_expect_failure 'tar archive with long paths' '
+test_expect_success 'tar archive with long paths' '
 	blob=3D$(echo foo | git hash-object -w --stdin) &&
 	tree=3D$(build_tree $blob | git mktree) &&
 	git archive -o long_paths.tar $tree 2>stderr &&
=2D-
2.23.0
