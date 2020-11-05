Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD09CC388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:03:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EB9020724
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="VSegxrTv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731965AbgKEVDv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:03:51 -0500
Received: from avasout03.plus.net ([84.93.230.244]:33938 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVDv (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:03:51 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amQ9kLt1i99nqamQAkhVf5; Thu, 05 Nov 2020 21:03:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610230; bh=Af22eD85dsghLR2PX3f0Ji2nUV9RZXl+pRkRnEP/kYM=;
        h=To:Cc:From:Subject:Date;
        b=VSegxrTvXZZEZ1hEVJ0lnHEvT4izoUb6C6eRG0UZYrsPBR2UcXX9R8pEt7YQ1laPF
         uVRMle24yUQ1QkbqHT0YrTbqD6dASqYJo0l25pgzmEuJhNB5lpUTQdA9QWp+B5nh8m
         yW2M61XRqG9KhMR1SVtHrJ5EJYYArRSm+VEc1WPNqVkgbxfNWrKgWWHL07ZYm9I3JM
         REm9i3YUTS/hWDSBjvzslWS3x3++QrfCueuIJVreIA8GNaau0+NGYcMPyamEn7wNSw
         iwrfjgmzkNlQ1nTOMpac1HWe6gMvifUu055GiFboW/AeW69ankzt+tx5lFPeDexsJM
         xtB8UY0G4B0ng==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=lLT4iZDIu0lhsO9_-yEA:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=jd6J4Gguk5HxikPWLKER:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 2/8] Documentation/Makefile: conditionally include
 ../GIT-VERSION-FILE
Message-ID: <32b7e1dc-8cc3-2236-08b8-4d268bbf8c0b@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:03:49 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfC7SVfau2NGjN3xNxprb22sq1/ctpPxdwrCMPlFip7KOgy3YIhp1uNHJFiYeFa+KqTyN2f6g9n6muFRkE8e1k7UP6N3GhCVicgTqgzywotqKRCYewH3p
 fYHcWoOvqAhQUJBt/qU5EwkjcZsRE8VDAehYx2fV/C8U19j7CAyMVbhDlEJyamVSCnkiXsxNjVg7Xg==
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

has been timed at 12.364s on my laptop (on old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the 'clean' target is making a nested call to the parent
Makefile to ensure that the GIT-VERSION-FILE is up-to-date (prior to
the previous patch, there would have been _two_ such invocations).
This is to ensure that the $(GIT_VERSION) make variable is set, once
that file had been included.  However, the 'clean' target does not use
the $(GIT_VERSION) variable, so this is wasted effort.

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
