Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BEB8C1F404
	for <e@80x24.org>; Fri, 30 Mar 2018 22:22:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeC3WWS (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Mar 2018 18:22:18 -0400
Received: from avasout04.plus.net ([212.159.14.19]:55285 "EHLO
        avasout04.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752781AbeC3WWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Mar 2018 18:22:09 -0400
Received: from [10.0.2.15] ([80.189.70.162])
        by smtp with ESMTPA
        id 22PNfzuqYsD7b22POfGPre; Fri, 30 Mar 2018 23:22:07 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=CvORjEwD c=1 sm=1 tr=0
 a=zzlqjQC3YyNvDZl/Gy+4mg==:117 a=zzlqjQC3YyNvDZl/Gy+4mg==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=bO4OJ-axyUIRU8BvdioA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fast-import: fix a sparse 'NULL pointer' warning
Message-ID: <fdda3631-400c-1e6d-92b8-a68fc237a413@ramsayjones.plus.com>
Date:   Fri, 30 Mar 2018 23:22:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfL8vZ7vY9qS7h1BI3TbJovuH3Ta13zYef5fDIV6KdooX4PaZT4fN5L+SobWTNo/EgJ7oAbttLgs0XCg93RV+NCXtyAo+m0wDGVWssrHg0+Hx9Y9h2io8
 aBzxwZuvBQYACIgfukMgZ3eRGW13zgY2nOcJJ+yvp0Qwqg2Eos2A75MyBroPKkc0OZpC9fltHDZliA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Commit a8dfa11562 ("fast-import: introduce mem_pool type", 2018-03-26)
introduces a 'mem_pool' type, along with a file-local global symbol
('fi_mem_poll') which is initialised in its declaration. This causes
sparse to issue a warning, thus:

      SP fast-import.c
  fast-import.c:301:40: warning: Using plain integer as NULL pointer

In order to suppress the warning, replace the '0' used to initialise the
'mp_block' field (of type 'struct mp_block *') with NULL.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

This was going to be an email to Jameson, but I wasn't fast enough! :(

This was originally written against the 'pu' branch, but since the
'jm/mem-pool' branch has graduated to 'next', I have rebased on 'next'.

Perhaps this could be squashed into that branch when you re-build
the 'next' branch at the beginning of the next cycle?

ATB,
Ramsay Jones

 fast-import.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fast-import.c b/fast-import.c
index 0aa148ea4..38356e293 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -298,7 +298,7 @@ static int global_argc;
 static const char **global_argv;
 
 /* Memory pools */
-static struct mem_pool fi_mem_pool =  {0, 2*1024*1024 - sizeof(struct mp_block), 0 };
+static struct mem_pool fi_mem_pool =  {NULL, 2*1024*1024 - sizeof(struct mp_block), 0 };
 
 /* Atom management */
 static unsigned int atom_table_sz = 4451;
-- 
2.16.0
