Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42AC9C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 09:29:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJKJ3u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiJKJ3s (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 05:29:48 -0400
Received: from mout.web.de (mout.web.de [212.227.15.3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E38DD13DD5
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 02:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1665480579; bh=RY2mO4piFZQu8YN4XN0A0jbcS4bZoNqN+byf26Va3N0=;
        h=X-UI-Sender-Class:Date:To:Cc:From:Subject;
        b=ZFJRLY5K8wc1kXRR0m13vp2T025l38NApUoKtL3zQBGnimNqmNy+DTwPGfDNPd6mr
         7DpnoYJ0GDG4yDzaQJ4q3dOEex0Qk4M+FqOOIqKKH5JHBDURdkKYlhIpEe2V0AnRer
         CjWi8IBdFc8AQI69ssko2ts23wcKU1qgZNNOxYsfWZox7UVZE1P4EKT2gKKOOzkhoQ
         ESsoYhi2ntEwcYaknCIyAOPGvDmEWThoBgxaco5nI24rnTwKfNB5RZIRnDAmDm2vjd
         vuBkJC5GxECQPtcRB8i3YwKyfoI2GIaMJmNT6PrwlStx599LmEALOpZZK2mdFGnm95
         m/IXcPE9zToHA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([79.203.23.161]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1N7QUL-1pDxza08SL-017bIY; Tue, 11
 Oct 2022 11:29:39 +0200
Message-ID: <af5611aa-8662-7508-4f00-7fcf4e9cbcc6@web.de>
Date:   Tue, 11 Oct 2022 11:29:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.3.2
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] archive: deduplicate verbose printing
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qrC96fqTfSAqBEes7tO8r6iaTYWHLzg8BURT3+k4yc5ZSy1HNu/
 0kkKflGKHrBtJ71lfw2/S0XkovdefWhb6lgYs5vQOPViKL4ISFGFROa6RndEhCBM4+rOczo
 8Yoj5AtCLeME9/ydQ2Noh/+L2/503rP4iRFphRccfdX7X7/jyhQ+wGDrlOC50Uo2a7JWASH
 G7I7Ao4EKehEGQNO5SQ4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:W6wyGrM2ssM=:e+UYgRIs8mH3isVfCkz3zT
 rZZSpu5wNBEKlwlt/8uM00GNK1rwlHOpqLlbVtlYzhHc2hFC6qD4/gI4GzqJKl1o82hYOS3Q6
 ZPVOrnbr48crZisoekjjEW4UHVE6Xl9kA3aYN6Hf4+Epa+mlyVEhxxhgyXsLIiBs8/+UKZ3J5
 HWojJkZYWnNTUyR4kckwsklDcM3iVnMpGmfmnyM99qcsdP5L0iGQqb/dEC7W9AG6NZ48hVFUB
 3QRvwhRKIbhCNBGQqWUBN9HsWb9Hq1rSjeeXtUQabi+jdCLhzMaAz1a/vNBDxrvf3W4X2eTWH
 NI4c5/rOs3Lyxkl9y337wJRETLhs8ubdYV8NTXkG4UtAFlNiyS1CB4p8NhyosBnPFTq3+2gVk
 uATA9nDcchP5lR9wSYCPvqtzWji/MdsA7+3fGldGlslwou46h/bo1Y61/FBh7B5MVnWoTVNZs
 lbio4aygRlRkEZVlbK07rpNEDlDs0bpa1qTmLw9gUsbsV1tXw+ZiArRMdg+5cUQ5m6EDMmafc
 2fM8+xRmbzELYwf5bKQU5XyI03vTF+6g49EuFm1Y+H9dwcStVfJQICiKFt6ZeKZKDWvQPDRIk
 URbPv5dggmvbQpTgzyPiwlXLYfJumb5I8uOFjssHCnBjPOOU2WMNN7W5OgRvuDVlYScn8gGSO
 nwsk3fG+B0RRxnUypOw2mUegiHd5G9gIpGsUR3TsZnullf7mPPhBLxKw2SraXZecdxnk5iB5o
 7rxajfT/Y2sINcX0+zQqto8vELEwLJrFG97YJmSrfa1JaCXXE/h1SM1N4ZMJPIthwSRqOyaMZ
 4I/zMKczNpaeKOEZ6N95hQIEkeh9EZZn9+oAxW3JkyuR8DkvxXrmetmf3hMF7Xq0+xWoG4FDS
 LP6O1UTpJNV5cIkhnDEipiz0vMBEBifU3Cfu3VMSZ8WwB3gBDtgj0wKWEcZY0iSQbEQHCdRTN
 9rLRTLDd3UVXui1NnJCbrCjKActoFA64lCF5D1BmVA7JH3OqrPgP/DcDnUsjHx9n5+pZqYHSK
 U554110Fjwo6TZD+QbC+QrmlF5osCPGQxbG3qVGGKHIITw27wrWEDkuqrZ3jx0ntlo9mPlrki
 9NSN7peKA3OSs6mBrMtKAFBwpjVFt8cFkdlG5tv+ANUY1dgjSgNr4hOirwvGfCRevvsSJENMb
 RsvU0cmNwr85LW8jG/K2eF9Sjc3Bpw0I0sRrjBH1JiMM4i+rGsLTRwQeLiAHpR1t1ESZdx71o
 f3JPJBWzLNe/FH5Zhkf5XLQSLShEPupYmrB/rjJITaHLJBvUI/ZxZO9sYru0Xymonvb5E4b77
 pUEID9U2ZsRXEBiQy4mBENSKF+KMzZoILObEUR8sBtmZFzIBVtb20tLj8q5wfyKbSLPd0eA/7
 dL74c9HVLinHBIBIvfZUsvqmbklsehfHgKYgcBypv7j4mEfKiVHuxXTvXViowIYBaEwCG5sXg
 Rft+KNluA95BRFr3S/9licKT5fQzHO9XYaBxirwVilaaUcRniIAqUJoozaT/CQiKi0+xXok1O
 7rVBu3aQdnpkEfITFaUczHW7CY6x/sMqc31nf8h9gyX35
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

94bc671a1f (Add directory pattern matching to attributes, 2012-12-08)
moved the code for adding the trailing slash to names of directories and
submodules up.  This left both branches of the if statement starting
with the same conditional fprintf call.  Deduplicate it.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 archive.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/archive.c b/archive.c
index 61a79e4a22..cc1087262f 100644
=2D-- a/archive.c
+++ b/archive.c
@@ -166,18 +166,16 @@ static int write_archive_entry(const struct object_i=
d *oid, const char *base,
 		args->convert =3D check_attr_export_subst(check);
 	}

+	if (args->verbose)
+		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
+
 	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
-		if (args->verbose)
-			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
 		err =3D write_entry(args, oid, path.buf, path.len, mode, NULL, 0);
 		if (err)
 			return err;
 		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
 	}

-	if (args->verbose)
-		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
-
 	/* Stream it? */
 	if (S_ISREG(mode) && !args->convert &&
 	    oid_object_info(args->repo, oid, &size) =3D=3D OBJ_BLOB &&
=2D-
2.38.0
