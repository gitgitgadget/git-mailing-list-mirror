Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2945C4741F
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:05:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2EE20719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:05:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="kXL9smls"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732046AbgKEVFQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:05:16 -0500
Received: from avasout03.plus.net ([84.93.230.244]:34011 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVFQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:05:16 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amRSkLt7K99nqamRTkhVg4; Thu, 05 Nov 2020 21:05:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610315; bh=ZspPBG9L2bMOreAQiDuu4CEWxyFOfFvQ+r3+w37A2ws=;
        h=To:Cc:From:Subject:Date;
        b=kXL9smlsQYcF1JwsCO43hQ4Zs7gLjSFe9Jh9czBjEtB3yQaRzIbbJSuocedlCaWsu
         1KrqCfEM2pfG69490U4CdaCvPWoxpHEcghMyR2v5RaXAHlrB31/dp3d3L1OBlLaecy
         C85Zk2/vlZc2+MarBkfZ/gw5WrFp+uLfJuFzpl+HrEyFK8/x8QXnJ0xjlJ23tI+GHB
         VpFlxz2FlczvZr0WrkjDk+8ftpg1fafwEeohyI0bqucXhxuDWaWhWvdgIEDiSzI2Aa
         msZMpON9prXuVfH5a10C/R9qfS9PfTIEsLQXgtVjH5UaKVL299yKRi4caBhko5shOf
         9k7bQtZz2Ws+Q==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=awHaz76ZRxkwiDev0AUA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 3/8] gitweb/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <7f4f6db9-2573-6b7c-7858-7457fd2575de@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:05:10 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfNcOe/B+jLnV/ZHLVdoeA6iojRXfe2r8aEaKtWtkVQ4NSvB3AVxfXHZ1VHGFT7dLPc92Cn5SyJZWAj7hINkV8LE712p6HCH2vJCJOj8wSA0tpbbVygcp
 dNC4vv8Gci2o6RSR6Y8XOPFFv5Cf2zcmkMcwPs/CLKDa9dzy9WOivzKEzZc61WvcklaYmZwSASmsMg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is still noticeably slow on cygwin, despite the
improvements made by previous patches. For example, the second
invocation of 'make clean' below:

  $ make clean >/dev/null 2>&1
  $ make clean
  ...
  make[1]: Entering directory '/home/ramsay/git/gitweb'
  make[2]: Entering directory '/home/ramsay/git'
  make[2]: 'GIT-VERSION-FILE' is up to date.
  make[2]: Leaving directory '/home/ramsay/git'
  ...
  $

has been timed at 10.361s on my laptop (on old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the 'clean' target is making a nested call to the parent
Makefile to ensure that the GIT-VERSION-FILE is up-to-date. This is to
ensure that the $(GIT_VERSION) make variable is set, once that file had
been included. However, the 'clean' target does not use the $(GIT_VERSION)
variable, so this is wasted effort.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include ../GIT-VERSION-FILE' when the
target is not 'clean'. (This drops the time down to 8.430s, on my laptop,
giving an improvement of 18.64%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 gitweb/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/gitweb/Makefile b/gitweb/Makefile
index cd194d057f..f13e23c4de 100644
--- a/gitweb/Makefile
+++ b/gitweb/Makefile
@@ -48,7 +48,9 @@ HIGHLIGHT_BIN = highlight
 ../GIT-VERSION-FILE: .FORCE-GIT-VERSION-FILE
 	$(QUIET_SUBDIR0)../ $(QUIET_SUBDIR1) GIT-VERSION-FILE
 
+ifneq ($(MAKECMDGOALS),clean)
 -include ../GIT-VERSION-FILE
+endif
 
 ### Build rules
 
-- 
2.29.0
