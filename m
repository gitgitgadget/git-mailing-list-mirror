Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4E4C433FE
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:35:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D2DD22ADF
	for <git@archiver.kernel.org>; Mon,  7 Dec 2020 00:35:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728356AbgLGAfr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 6 Dec 2020 19:35:47 -0500
Received: from avasout01.plus.net ([84.93.230.227]:33556 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726046AbgLGAfr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Dec 2020 19:35:47 -0500
Received: from [10.0.2.15] ([147.147.167.100])
        by smtp with ESMTPA
        id m4UvkwQiCn8O7m4UwkbbRW; Mon, 07 Dec 2020 00:35:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1607301327; bh=jS9aItPTGFd99axC16npJeCBC+2in31YJk0L/OEAfuc=;
        h=To:Cc:From:Subject:Date;
        b=WPBTZTvzTkyqtHOz+qFn64PXopBdTlvklCfoaRSGU2g3whtDo7TkEGLW+7EdYlheX
         VPtXvX2bvrFbfncsRcNNAQqgtDwQazK0YcFV6j0NFVlKW/sZPQ1X8sFBxkNfIs76J3
         J5k7GIe08vaXm82ugBcEdvXLpxFfdcRKD3aCOwKOE9schiEWT3mJIAmer2n5GlIG6M
         2HBGBM2ZkShVQCAd68gxuUJ+eUUOlovoDJgO31uHMgM2XtetDVyPd+pl1Xpo3f80wW
         5wF/F/SbXO+I0RZxYEEaN9s8S9Izol3NcV7d0QtGT4TUKlaA+RF18Zk7Ghj/3cqQYj
         W08eZmccqhvjw==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Ld6nFgXi c=1 sm=1 tr=0
 a=qL5TBQHgqnWGdG4DsQFN/Q==:117 a=qL5TBQHgqnWGdG4DsQFN/Q==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=WC_maC_QWPM366MBaKIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v2 4/5] Makefile: don't try to clean old debian build product
Message-ID: <c9b95f23-085e-af17-727d-698b3179e54e@ramsayjones.plus.com>
Date:   Mon, 7 Dec 2020 00:35:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfLla+y765R6MmsU8BeKMfWoMBBIfFEISMvkuG+Lty67iALps6KOaCyaOThRAhjOBhz138L+FF9sL34vM7kBB5oFlZIkDnU8DK3Kt6m3IyHD72Sui98+j
 gXbUtgt1wFEJCIZZMLDTqOcGcwXD/FFWFtScOEjUXuwniPwM4IvJDtJQoZZkhUFft2VAKZcHmDr1lQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target includes code to remove an '*.tar.gz' file that
was the by-product of a debian build. This was originally added by
commit 5a571cdd8a (Clean generated files a bit more, to cope with
Debian build droppings., 2005-08-12). However, all support for the
'debian build' was dropped by commit 7d0e65b892 (Retire debian/
directory., 2006-01-06), which seems to have simply forgotten to
remove the 'git-core_$(GIT_VERSION)-*.tar.gz' from the 'clean'
target. Remove it now.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 95571ee3fc..09d6f23b88 100644
--- a/Makefile
+++ b/Makefile
@@ -3150,7 +3150,7 @@ clean: profile-clean coverage-clean cocciclean
 	$(RM) -r po/build/
 	$(RM) *.pyc *.pyo */*.pyc */*.pyo $(GENERATED_H) $(ETAGS_TARGET) tags cscope*
 	$(RM) -r $(GIT_TARNAME) .doc-tmp-dir
-	$(RM) $(GIT_TARNAME).tar.gz git-core_$(GIT_VERSION)-*.tar.gz
+	$(RM) $(GIT_TARNAME).tar.gz
 	$(RM) $(htmldocs).tar.gz $(manpages).tar.gz
 	$(MAKE) -C Documentation/ clean
 	$(RM) Documentation/GIT-EXCLUDED-PROGRAMS
-- 
2.29.0
