Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1CC7C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:07:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B5BE20728
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="GENrfXaL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731954AbgKEVH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:07:29 -0500
Received: from avasout03.plus.net ([84.93.230.244]:34140 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVH3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:07:29 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amTfkLtGM99nqamTgkhVhw; Thu, 05 Nov 2020 21:07:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610448; bh=jS9aItPTGFd99axC16npJeCBC+2in31YJk0L/OEAfuc=;
        h=To:Cc:From:Subject:Date;
        b=GENrfXaLtm0BexXtoWo4iKNCO39tQqgoLVBoUV7OQF3PbNWI7M6RJSyoK644fVkj/
         BL7CtxaEeyKfAglgDM0wN7zplCDw4BsLuIe/zUD62R8wlBpFY/Ra5m43gxoyVxTpsp
         +zfP1hIymiqvQXOJOhMjC7w8AYUhKy/p7BivFTkTbT9jIRJQw8tS3TEK8Vbpp9ytlW
         Y8IG7oeJqaLYrOTP2FV1Lpq0fCA2Prn/Qrr3iatGA5kZKvY2Hp9b4e6uqH97d6OVDz
         EfQbBa1Zp/SWaIglS24eQWpKgYASn74o+NBCqPGGoiE32Z9Jml2u4myKTNyOGkBVzI
         t86oQ0e0SVc6g==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=WC_maC_QWPM366MBaKIA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 5/8] Makefile: don't try to clean old debian build product
Message-ID: <866fb59c-7548-5212-2274-73348abc8513@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:07:26 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfAOhZKDc2aFVx/vS5zLhngd7hhqdZpYxft/ah8xmq1yY3A/IwhWBp8BsMLQM7kCPdJjLk2OTNPqBkd9eHlZ75u8nL9JVDhbWFgTPEnU4MeQKT+vLHYBc
 IfReKIleD5wqoJcn9ZZ+lfJCVuSv1PjKF2mQ94wqPlTqjBfYriGGOo7zTfKiAJ9o1+SZHgytuLFapg==
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
