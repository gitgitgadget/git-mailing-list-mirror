Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A347E1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389230AbfIEWtL (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:49:11 -0400
Received: from mout.gmx.net ([212.227.17.22]:41493 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733259AbfIEWtK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:49:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1567723739;
        bh=QNlyjnAhXTvdbsnSEyeqz9K7nHQayEVHYE2mXD0rOMQ=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=JHD7+AE1iFm6fcHynBXfEMpRltr+MkXv8X6rXRuMF3PS1intvEUC+uqjzJHXsj373
         51vDYtFTifVm11dpX7SSq4dHM9s6DIF0dNKj6gJvb4ldNK+vBMf8tHoxAR44xEqc+V
         R/L1Hn6cfxs6hjmC7B3nHHsV8kNHo5nRk/wiEULI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from localhost.localdomain ([88.70.128.63]) by mail.gmx.com
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MV67y-1hhMwX25UU-00S5HN; Fri, 06 Sep 2019 00:48:59 +0200
From:   Stephan Beyer <s-beyer@gmx.net>
To:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>, Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Shawn O. Pearce" <spearce@spearce.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Stephan Beyer <s-beyer@gmx.net>, git@vger.kernel.org
Subject: [PATCH v2 4/4] Silence false-positive maybe-uninitialized warnings found by gcc 9 -flto
Date:   Fri,  6 Sep 2019 00:48:33 +0200
Message-Id: <20190905224833.24913-4-s-beyer@gmx.net>
X-Mailer: git-send-email 2.23.0.43.g31ebfd7ae6.dirty
In-Reply-To: <20190905224833.24913-1-s-beyer@gmx.net>
References: <20190905224833.24913-1-s-beyer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DG4+s+65E+ciFPjhqAHsYTroDv9hecMRwfPuF65a5s6fKhJQAxn
 NoetD5UWpRf1qjIk/S9tX8HyrBHt+00VinTYqbLhjrGHX2kPM7OuzW644LHFvZmG/DF/RH3
 JMBmUtdt6+vieGkx+tmdsAWxHGsm82VOn9kkjWDoPgBMfVfVpeTrPcPoiZ5yRZy37P9QnZT
 uvXQvgxWOYIClg8Mlll/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:23EomXmCFOo=:t2jWowwKDi88PVNokCoXWe
 +ntfAeoM6/yG3jkjngrlCSsA7ctFIxlExH0TThoDJm/oRCZTrJ/CyKAYDBWgsM410tGHbas7Z
 4nSRAW2/salCiXFM8ChUyH4MavE605W0MecR56TRpz4MoBGKkhmlPJErfovNyWaeuPigYIvM2
 4EIcM/Ar7CA0Da8t7QpayaRE6kDcWNYmDaFP/kXS9bm0+aFMyKat/iMX1GeVn7Ovr6DrBcxA6
 qjdvy16kBu2GacrqrZUDMxW8F0N8RnQIdFfC8i+01S7pSHZ87Hus+RQNqgE1tz2yhCrdD9jp0
 CH+sZWiUglJKc7nTWs0mvBb2I58LQk6GpX3oWRKzOJs14UpfK7rBNLTU6cyqrK6uvlWUkQ3zO
 08E7If98GELAw9RG+UK2wuG6DiYi5LxNqKU2MnCDBkp6ca0U/PJTF8kFOvt7H1LLOFCUD/N1W
 1fYmje6U6MS60D3hxOHOOONn+V9+7LXILaNcppqOwn8kLARN2pojqqocqN5nrYVMNUoKmfX1e
 qM2kemUvMyppm4TQf8D+236ct1siVN7urnuo2qjQ/fDn2LG1NUxoJJ4DgPItIvxz8/sir6q9H
 BG4Jb4az7OT+9eHt1jclGnSeG7EmYlaUxoAoMbAjvktb5TcidK7P65wphAmGi4GOAv1gXMG9a
 AWlVKTp+PTo5kc8Nrugc9E79vMmnwhgZiBIOLQZajyBVRrGPpzHkF0XXb3+qhPH7qfGYPCVlZ
 jP62B9a0RDLj1hP/n7oTcvGDxN/dbkWaGv/nQapqQLr3sZFRKN6tI/SrmPLwnMiAiuDMXtIur
 negdOJAwPOUrmmvyXlROJXpUJIZ5UampiEMioMQvCQ4J1hz94QEUaNVSgT8RmN8gSnMeQDZ/f
 k4nhBD3nBFMzTwETz8mn/HsVMgeEezAitmYbzgyxtjB+XQlWCnj/iQYDR6LD49BiBj2+P2497
 U6x5m86f3MNGgmeCOpZtr49tROdKFDUMP5nPntqUfQeXb6JDqmOyZMLg6a7FoxAQAsUV58qbG
 moLYex+Kk8TaGNhYxtjLz6vVMWrP3otlA2yGI7GaLAU0InTi1LNG3dMCOk/vgLzmGTwbpZ+OX
 4yIV8FUKzAVlSvxTXRocAawW/Hnow86eOqizFSybCwehWnkXL3V04L/dJYnOHVWX9EvUfY15F
 R7VTsY18C8cA5wJxWqc4zISrcudICSV2iBuKWIwvBiEawjlgY4d/rKTV+s9NgKIRGdbkC4tDv
 6sDNOExnz5t+bmDNz
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

gcc 9.2.1 with -flto flag suspects some uninitialized variables which beco=
me
initialized in every code path where they are used.  These false positives
are "fixed" by this patch in the most na=C3=AFve way.

This allows to compile git with gcc 9, link-time optimization, and using t=
he
DEVELOPER=3D1 switch (which sets -Werror).

Signed-off-by: Stephan Beyer <s-beyer@gmx.net>
=2D--
 bulk-checkin.c | 2 ++
 fast-import.c  | 3 ++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/bulk-checkin.c b/bulk-checkin.c
index 39ee7d6107..87fa28c227 100644
=2D-- a/bulk-checkin.c
+++ b/bulk-checkin.c
@@ -200,6 +200,8 @@ static int deflate_to_pack(struct bulk_checkin_state *=
state,
 	struct hashfile_checkpoint checkpoint;
 	struct pack_idx_entry *idx =3D NULL;

+	checkpoint.offset =3D 0;
+
 	seekback =3D lseek(fd, 0, SEEK_CUR);
 	if (seekback =3D=3D (off_t) -1)
 		return error("cannot find the current offset");
diff --git a/fast-import.c b/fast-import.c
index b44d6a467e..58f73f9105 100644
=2D-- a/fast-import.c
+++ b/fast-import.c
@@ -903,7 +903,8 @@ static int store_object(
 	struct object_entry *e;
 	unsigned char hdr[96];
 	struct object_id oid;
-	unsigned long hdrlen, deltalen;
+	unsigned long hdrlen;
+	unsigned long deltalen =3D 0;
 	git_hash_ctx c;
 	git_zstream s;

=2D-
2.23.0.43.g31ebfd7ae6.dirty

