Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 95AA520248
	for <e@80x24.org>; Wed,  6 Mar 2019 00:11:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbfCFAL0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Mar 2019 19:11:26 -0500
Received: from avasout01.plus.net ([84.93.230.227]:40133 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727570AbfCFAL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Mar 2019 19:11:26 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 1K9ThOgJ5zxF51K9UhyZBs; Wed, 06 Mar 2019 00:11:21 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=UqFNyd4B c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=4OhujA1bs1H5SJ2K9coA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: fix 'hdr-check' when GCRYPT not installed
Message-ID: <afd21027-52a7-7b4f-bf9c-024cc787b57b@ramsayjones.plus.com>
Date:   Wed, 6 Mar 2019 00:11:13 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEqrfBPYJoP7kXakSk8BdZ9K+Qq7S1vJH9tb9eFEFBpiA0GlEQiaVUccl6QN8FMeqc6OwisWEm53KpXWZIGyqDSOtC+63IALLZDMDQskiwZMfDL8NCix
 v0cUdO2siRjN4XLdK4v/3g9uaNxxWGNkOP+VmT9MicGK0pz3k8T6+NFO/wM0lqWWtLQu8R6D5Ly3eQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


If the GCRYPT_SHA256 build variable is not set, then the 'hdr-check'
target complains about the missing <gcrypt.h> header file. Add the
'sha256/gcrypt.h' header file to the exception list, if the build
variable is not defined. While here, replace the 'xdiff%' filter
pattern with 'xdiff/%' (and similarly for the compat pattern) since
the original pattern inadvertently excluded the 'xdiff-interface.h'
header.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

In my local 'hdr-check-fixup' branch, the gcrypt failure is fixed
almost by default. However, given that we are going the 'git ls-files'
route, this patch will fix it up.

Thanks!

ATB,
Ramsay Jones

 Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index c5240942f2..fbc84cb541 100644
--- a/Makefile
+++ b/Makefile
@@ -2736,7 +2736,10 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 sparse: $(SP_OBJ)
 
 GEN_HDRS := command-list.h unicode-width.h
-EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
+EXCEPT_HDRS := $(GEN_HDRS) compat/% xdiff/%
+ifndef GCRYPT_SHA256
+	EXCEPT_HDRS += sha256/gcrypt.h
+endif
 CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
 HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
 
-- 
2.21.0
