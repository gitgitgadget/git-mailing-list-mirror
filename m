Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1030C433FE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:33:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5FDA0238EE
	for <git@archiver.kernel.org>; Tue,  8 Dec 2020 22:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731091AbgLHWd1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Dec 2020 17:33:27 -0500
Received: from avasout02.plus.net ([212.159.14.17]:60696 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726421AbgLHWd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Dec 2020 17:33:27 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id mlXdkHHom0K1OmlXekvn97; Tue, 08 Dec 2020 22:33:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607466786; bh=WhZNZiIrLxcBfvXg+bO5LM0/I90b6D2oGcKheammcmA=;
        h=To:Cc:From:Subject:Date;
        b=Ujduz3zeGP1zw0rmCZv8TaZX6STeA5uy09OfBM4w+iexsZkOo1RJc2lEYVAUBT35Y
         YSuT7yFVUPrlnzm/11W5TMXngnIpMhSpU1anIgnm3jMBumr7lrRPVu7bvgyi+hmeUn
         oOT3u9ekXueYbUt6jXoAM+A18q9ejn4F9WpiK0Es5myAdsVavLBrRJ19UZAny1p/Ry
         rW7/zTUP9TBqAzTNMlVSCN3ZRrq+P7K1QoArlJeYDRU6J5L39ENqLUGhbzCRU80YLA
         eViwlWfravOYh1H+XZvswhqkQ+xjqoC89E28vr2FGeqq29NwEme8IC4N+MWvv5FMcb
         rEKQauLckoq4w==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=QaP9QvTv c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=lLT4iZDIu0lhsO9_-yEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=nt3jZW36AmriUCFCBwmW:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>,
        Felipe Contreras <felipe.contreras@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v3 2/5] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <7ada81c3-bb8a-6d63-88a9-e24ba11f1138@ramsayjones.plus.com>
Date:   Tue, 8 Dec 2020 22:33:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfDR0L2aI/dElOrBiPRYNE20Purn38WaD46zbcFZaN3nSPmavmllt7EnUtBHpE9D6EL3eh3dGmmXSWcxZaTJuKJ1qK5mf9bf7h+Mt4mkIQeuMjAWQEQDV
 1h/92klnWRyGzIkRFVDL3SdnUUqrIJW2mqTSsEh4ZUhW2N/2Vwtu3qpSkIxFi3a/aMrLts2n6YQO7g==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is still noticeably slow on cygwin, despite the
substantial improvement made by the previous patch. For example, the
second invocation of 'make clean' below:

  $ make clean >/dev/null 2>&1
  $ make clean
  ...
  make[1]: Entering directory '/home/ramsay/git/Documentation'
  make[2]: Entering directory '/home/ramsay/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/ramsay/git'
  ...
  $

has been timed at 12.364s on my laptop (an old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the 'clean' target is making a nested call to the parent
Makefile to ensure that the GIT-VERSION-FILE is up-to-date (prior to
the previous patch, there would have been _two_ such invocations).
This is to ensure that the $(GIT_VERSION) make variable is set, once
that file had been included.  However, the 'clean' target does not use
the $(GIT_VERSION) variable, directly or indirectly, so it does not
have any affect on what the target removes. Therefore, the time spent
on ensuring an up to date GIT-VERSION-FILE is wasted effort.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
target is not 'clean'. (This drops the time down to 10.361s, on my laptop,
giving an improvement of 16.20%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Documentation/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 652d57a1b6..5c680024eb 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -272,7 +272,9 @@ install-html: html
 ../GIT-VERSION-FILE: FORCE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
+ifneq ($(MAKECMDGOALS),clean)
 -include ../GIT-VERSION-FILE
+endif
 
 #
 # Determine "include::" file references in asciidoc files.
-- 
2.29.0
