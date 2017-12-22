Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0C7F71F404
	for <e@80x24.org>; Fri, 22 Dec 2017 08:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbdLVIOO (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Dec 2017 03:14:14 -0500
Received: from mout.web.de ([212.227.15.14]:49602 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751887AbdLVION (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Dec 2017 03:14:13 -0500
Received: from [192.168.178.36] ([91.20.60.211]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LkyXt-1f0WpD2bCP-00aqK2; Fri, 22
 Dec 2017 09:14:10 +0100
X-Mozilla-News-Host: news://news.public-inbox.org:119
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] send-pack: use internal argv_array of struct child_process
Message-ID: <d532a23f-cf73-615c-976d-f4fe83309feb@web.de>
Date:   Fri, 22 Dec 2017 09:14:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:XFwvJ80V4M5CmBPXS+L1zzhMrjeF518/TWmr07qhB3C9USp1hfP
 IleUeRkn+9SdCs3kd1BxOITMgUUXeqKf9+t5XzfeA20g3OsUyr2M9f0o6AEYVmAqTYqWbLX
 tTYYMhJXzDgcDcW/g4DtKHr54EZbfpo8mT4eZCYxvgR8Uy4fAdiwbq6lLCBO5l1fJ2MX4Vb
 YyjaVTm2yzLv2u1FtGTSQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:jDPgLJ30ZXY=:TZ2207gwl1RwLq2T99Uzsm
 y7nts9HQ1ow8drBeObkVQaTAQRH98eEsyfTEKsgQGSbIC4wCLuKxY5ruO491SuCKxh9syokj9
 kLDQjG0zoSAWptSDGLbx5SOJMhbpnKTBIea4Mwf/s/ki06AEHntmDh/1NJr0B0eT/o7qkVAgT
 1sA+qJHEGFXNKhTBRehlDXuXzEdh3/HesO22hCwKtTnfaePO5en1HSICWG/43oDv+T5VhVMKP
 v0GRZfGP0OKnMMDIDf7Q8LMxfxfjC1eGJIQAxZ32feMLnYB6QskfXUFDWvIaDdLKfkM7Vsf8r
 AFYRWtZ8DAAY9DU+gfg8lgbeIeATq1/PmOxSJsA+BK3MiNCBDBFPg4sJzzOGNIncwtXUz5tGg
 AMRPeT6mcZQJkHSSgBudBWuy9Ojw0HUgiAFkVLkf9m+v7wJuVF0/53spOnubeRgrRr2Up7Gmy
 v3kEFRGmmdePOGjdxMD8wiqw9J1xHw0FKR6g90nSX9zEjcUmMq951rgdCkSmWFB7rcS9CkRwF
 O1VYFP34dkMcrbbdDoFPgvtZ+YUkfvkDWtR+tcIzTc/Y59Qn/EsX90cnonoYShj0fkc6wZeGQ
 MPODHXYRwclcOWi1KWtng3UfZxTi8FSVfh4iLgUEP2H8bT0noFkmIz6fH5mBqcf21LDa54W4G
 ZDRjb/1+LFeVRcPOpHsGsMyWmFHpfJA0YbIQ40GfB2d4fj7fCVqeryMqKRXXncjLQtl+Cpu0I
 xJY/FlsD0omwOGbJXL31xucRKP+Ahw83bcNejBdg6Bk3WyDBxBSzh3L1tZMnyoD2OtEqqN6C/
 8TxjLd6jpr8HSrE4l7oM2emtEtJmIDqHtiWLU0H8aB7luMng2CLTfIv51s+sTtJ0Cj8tZ9x
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Avoid a magic number of NULL placeholder values and a magic index by
constructing the command line for pack-objects using the embedded
argv_array of the child_process.  The resulting code is shorter and
easier to extend.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 send-pack.c | 28 +++++++++-------------------
 1 file changed, 9 insertions(+), 19 deletions(-)

diff --git a/send-pack.c b/send-pack.c
index a8cc6b266e..2112d3b27a 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -58,35 +58,25 @@ static int pack_objects(int fd, struct ref *refs, struct oid_array *extra, struc
 	 * the revision parameters to it via its stdin and
 	 * let its stdout go back to the other end.
 	 */
-	const char *argv[] = {
-		"pack-objects",
-		"--all-progress-implied",
-		"--revs",
-		"--stdout",
-		NULL,
-		NULL,
-		NULL,
-		NULL,
-		NULL,
-		NULL,
-	};
 	struct child_process po = CHILD_PROCESS_INIT;
 	FILE *po_in;
 	int i;
 	int rc;
 
-	i = 4;
+	argv_array_push(&po.args, "pack-objects");
+	argv_array_push(&po.args, "--all-progress-implied");
+	argv_array_push(&po.args, "--revs");
+	argv_array_push(&po.args, "--stdout");
 	if (args->use_thin_pack)
-		argv[i++] = "--thin";
+		argv_array_push(&po.args, "--thin");
 	if (args->use_ofs_delta)
-		argv[i++] = "--delta-base-offset";
+		argv_array_push(&po.args, "--delta-base-offset");
 	if (args->quiet || !args->progress)
-		argv[i++] = "-q";
+		argv_array_push(&po.args, "-q");
 	if (args->progress)
-		argv[i++] = "--progress";
+		argv_array_push(&po.args, "--progress");
 	if (is_repository_shallow())
-		argv[i++] = "--shallow";
-	po.argv = argv;
+		argv_array_push(&po.args, "--shallow");
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
-- 
2.15.1
