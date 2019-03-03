Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8634E20248
	for <e@80x24.org>; Sun,  3 Mar 2019 22:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbfCCWXS (ORCPT <rfc822;e@80x24.org>);
        Sun, 3 Mar 2019 17:23:18 -0500
Received: from avasout01.plus.net ([84.93.230.227]:44586 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbfCCWXS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 3 Mar 2019 17:23:18 -0500
Received: from [10.0.2.15] ([146.198.133.33])
        by smtp with ESMTPA
        id 0ZVshJ7MbzxF50ZVthvyYy; Sun, 03 Mar 2019 22:23:17 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=UqFNyd4B c=1 sm=1 tr=0
 a=VCDsReDbrwk4B7AcQzWGLw==:117 a=VCDsReDbrwk4B7AcQzWGLw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VPZo48UgcjwAFGLJ4BoA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] Makefile: remove the 'hdr-check' target
Message-ID: <c1b1c37c-5476-4dc1-9e9b-b0c7363c5ae4@ramsayjones.plus.com>
Date:   Sun, 3 Mar 2019 22:23:14 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfEPVW/5t1CIUmJXHqiXydisPnuS8SQCmwo+iuMpIx3ZFcCCmXsBzjmX+nGGgVYmXSjjvPj81+4wnhIt3XvJGMYRaMsjAiLFmF+nIbfkazQk7U3DdgQrd
 V8aOuyRpyllFV7ZTbijAiXD66E4zXa06Je4USdqSEWOGVVg8+TNCRCGW5vGx3h5uoECI7PXEao8M6w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'hdr-check' target has proved to be costly for some developers and
platforms, depending on the configuration, even when not using this
target. In part, this is due to the use of $(FIND) in the definition
of the $(LIB_H) variable. This effectively reverts commit ebb7baf02f
("Makefile: add a hdr-check target", 2018-09-19).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/Makefile b/Makefile
index c5240942f2..dd3e38dc1f 100644
--- a/Makefile
+++ b/Makefile
@@ -1852,7 +1852,6 @@ ifndef V
 	QUIET_MSGFMT   = @echo '   ' MSGFMT $@;
 	QUIET_GCOV     = @echo '   ' GCOV $@;
 	QUIET_SP       = @echo '   ' SP $<;
-	QUIET_HDR      = @echo '   ' HDR $<;
 	QUIET_RC       = @echo '   ' RC $@;
 	QUIET_SUBDIR0  = +@subdir=
 	QUIET_SUBDIR1  = ;$(NO_SUBDIR) echo '   ' SUBDIR $$subdir; \
@@ -2735,17 +2734,6 @@ $(SP_OBJ): %.sp: %.c GIT-CFLAGS FORCE
 .PHONY: sparse $(SP_OBJ)
 sparse: $(SP_OBJ)
 
-GEN_HDRS := command-list.h unicode-width.h
-EXCEPT_HDRS := $(GEN_HDRS) compat% xdiff%
-CHK_HDRS = $(filter-out $(EXCEPT_HDRS),$(patsubst ./%,%,$(LIB_H)))
-HCO = $(patsubst %.h,%.hco,$(CHK_HDRS))
-
-$(HCO): %.hco: %.h FORCE
-	$(QUIET_HDR)$(CC) -include git-compat-util.h -I. -o /dev/null -c -xc $<
-
-.PHONY: hdr-check $(HCO)
-hdr-check: $(HCO)
-
 .PHONY: style
 style:
 	git clang-format --style file --diff --extensions c,h
-- 
2.21.0
