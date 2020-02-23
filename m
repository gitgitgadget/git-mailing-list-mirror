Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D205C35671
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 16:56:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3804D206E2
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 16:56:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="ZT2rKDyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgBWQ4y (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 11:56:54 -0500
Received: from mout.web.de ([212.227.15.3]:42949 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726208AbgBWQ4y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 11:56:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1582477006;
        bh=bAX7+Mlt5QJoD00j7BwqalukQln+4tRW7KduPZarl1w=;
        h=X-UI-Sender-Class:To:Cc:From:Subject:Date;
        b=ZT2rKDyqVTaxkhGkph+pCMy/Lpbag9mKjtT4d3FWLSP5FqMtS4BRB8Ajd20BrpwXX
         77lgXYQ6t+hVf0N0iKT/w25Px9k4EuUH7unAE7uzzk3FjUgosHmaIVxKBkh16JX2Q1
         Po6ex4NTnnIeUbNRthBQQKg3gdMwCPZ/EeNMzKm0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.21.89]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LyE3J-1jTC9L27SX-015Ziv; Sun, 23
 Feb 2020 17:56:46 +0100
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Barret Rhoden <brho@google.com>, Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] blame: provide type of fingerprints pointer
Message-ID: <22735441-50e1-5f00-ba12-539b3e9e4916@web.de>
Date:   Sun, 23 Feb 2020 17:56:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:w4z8oGBNTjNj24TbCt/AhU9fQDbd5kGU9efUo/7H64DUYlEACdE
 sG1m8VrW2EJbSlHcl8KJkL2ZQ2LQZrDdHY49Ko0zuH80tngNy2z1aBlWNnNpkBKie8gKSUZ
 i6KJtqKVOyJ024QhrRO/4XHyGs0SZwNeyNpOOgUrWOZo7gazZ1HuOrexI6aTtZVBYDRI02l
 sl1SEspOvVxGSMHX8muXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VN2spPGKoHY=:LI0vct1ujIlodGMDBoExHi
 RSWHYLm+uHdTVWd0nPxsgm2vUa1ZgJX+DsQaTmq2ZqzS2BMXLL4k1lCiOPByRpq+/pwtRRW8z
 2W6KV+/OBhib/5AIl3mEBI5lneSwxzOhEfUP1Dpd0nXQ8a/Gus+PAkQ9wP5EMeW5wjEUJqSad
 Ogms5WEgIqiMds0/yBzgSAl37+tzWqUEzfGTED6shtO4isGOFI6NLWzR62Ui0/BfD+hhuV+vm
 /U2lWxO8vMJ0CdB4xBMD7r2YbxKCq8OnqP6cis699TdXPA5C3xBR2cGPAcStsXse5tftmy/WB
 JEjqBNQ4hFNlJUzB/qzrKBWOCc7nvj07wR7LL4PnsGDO/rFPbiI2p9YALEVmeIrErTkoeTjZm
 /UNBDxANtPsInkHTmiBotNtos1JnMK9vb8W+x7wTl2iSWBDaYi3gM5d7MbVoEEY7faBgSm7gj
 0zYUa6VBjIwRuSlc4R/hSXImQ3n8S/HwzaFTPaaGs5mROCUPePAtmDKiC0GUzv2kTRJpLG/O5
 DsPnuPFwnSBhcUDsrUTL2abkCB4EW/U7OxJjkZF80uHjvYv0N5U7rzhom0CqTliOzjWVPivAf
 fmXLPyn5mZgWCJTNKFEx8KRn3C/Huqb6sI7pzOtcPZZZZEU4+GCyJdXmxda3AvM6BHOVNoLnQ
 GZK6J9J6xU8pYbQqtYv6rbfRmpoQgWN8cAAfGo8yI2YpeibNsyAiyIIbTSityXGSP0xI9/DCi
 sdBoeh/xzS2DrPhvVltzPeFANcKMnFTbRjXdZwbvhkR1+dkynJMV2DRiiIFWjt0akto6A/psb
 lQUb8coYKNvjxQkAy8XHs46T+ly4pMc4TacEOJLPdpv+Yekcn+Y+nmBsCdYJwOMkOHfNghgJ2
 2FzqqpCInK5qGkOxHtMc9f8L3qWhLhkXJr9ce4sTuVbVFcHy6fJ33YC/Yzpa7j2B58Ny5Ugq1
 0emvMpfg1zHGtZpBoTx6qir/IObRliSoSADKHv5krMgV1qLL59MRpHoffvPif4oZz+PW8zIAR
 pTHxEUL8Mhd/Dm9/DZJUCFwzmzVWoTiJ+AALdbp6BU7DP7FJPV2VkgDziJ6dlajOsFa11Ds6X
 ECiG+XMrH5KH99suqRZaIMIqrAx0v9RavKWn4hDOwehE8KaNd5viy+QEcsvUqiKPSf62+o4OF
 qmGCvsUGV2LDXinPqfTD2Px/2U29aLF+gVhSQnxhuXWTGe9evZe1tyCYbxZadhNWoghZ8=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The fingerprints member of struct blame_origin is a void pointer that is
only ever used to reference objects of type struct fingerprint.  Declare
its type to allow the compiler to do type checks.  We can keep its type
opaque in blame.h, though -- only functions in blame.c need to know the
actual definition of struct fingerprint.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 blame.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/blame.h b/blame.h
index 4a9e1270b0..089b181ff2 100644
=2D-- a/blame.h
+++ b/blame.h
@@ -16,6 +16,8 @@
 #define BLAME_DEFAULT_MOVE_SCORE	20
 #define BLAME_DEFAULT_COPY_SCORE	40

+struct fingerprint;
+
 /*
  * One blob in a commit that is being suspected
  */
@@ -52,7 +54,7 @@ struct blame_origin {
 	struct blame_entry *suspects;
 	mmfile_t file;
 	int num_lines;
-	void *fingerprints;
+	struct fingerprint *fingerprints;
 	struct object_id blob_oid;
 	unsigned short mode;
 	/* guilty gets set when shipping any suspects to the final
=2D-
2.25.1
