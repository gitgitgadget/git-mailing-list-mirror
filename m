Return-Path: <SRS0=KwJF=EL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E9C388F7
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7703820719
	for <git@archiver.kernel.org>; Thu,  5 Nov 2020 21:06:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=plus.com header.i=@plus.com header.b="b1X7tFR2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732099AbgKEVGZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 5 Nov 2020 16:06:25 -0500
Received: from avasout03.plus.net ([84.93.230.244]:34073 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgKEVGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Nov 2020 16:06:25 -0500
Received: from [10.0.2.15] ([195.213.6.50])
        by smtp with ESMTPA
        id amSdkLtC199nqamSekhVgr; Thu, 05 Nov 2020 21:06:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plus.com; s=042019;
        t=1604610384; bh=v/tAPInQN3S84iLXAxw5kJVjQ7pwIBixITmBp9bkq6g=;
        h=To:Cc:From:Subject:Date;
        b=b1X7tFR2yYb2n9F9/JjMP3Y8nfpCoPszxVxS35CMfcdBD8Jju4JBZoWsIDyYj+XDl
         Bscf3lNtcjGJQTHYZwcdq3xQARv+FrriojNMivrfLFl56GCyiF2dr3aAzVkDVkajsW
         sXJdd5rnGiX3aX34fCZImtCF7/LmiNVwKPHTR3+BvYEMVM5UA4GiqUG5SnlcPGBczh
         fCQ2xROYrfNN1chla4wM80GkpYl41irAlPhbdvI7QsSA9Fsec788by4v/DIGvx3Jzi
         XQY8UZfOylvAquF40vaHiWlEHQr9EGHflQYuZQAEDLiOr0+3GztfqjfVlRHdTF5n3V
         Z0+J7b6rFjPvA==
X-Clacks-Overhead: "GNU Terry Pratchett"
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uoz4y94B c=1 sm=1 tr=0
 a=n8v6pzUV7wpcOOJT0hzGjw==:117 a=n8v6pzUV7wpcOOJT0hzGjw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=gATyBR-rywtQC92RBn8A:9 a=QEXdDO2ut3YA:10
 a=yJM6EZoI5SlJf8ks9Ge_:22 a=pHzHmUro8NiASowvMSCR:22 a=xoEH_sTeL_Rfw54TyV31:22
X-AUTH: ramsayjones@:2500
To:     GIT Mailing-list <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH 4/8] git-gui/Makefile: conditionally include GIT-VERSION-FILE
Message-ID: <f4e1a949-f543-7d2e-6cf3-d09a42d9c9f4@ramsayjones.plus.com>
Date:   Thu, 5 Nov 2020 21:06:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfPpwq/lKd/d3cPj1buu1VJOEkdxmizAVBvqF3qk9YpKuhZSlCTO4NmSgRhC2I2HdaOHf8nGKqMwdYOSbllHynrdgEDEbTAtaDpR9IbNhFc/4KzbXHVVd
 QaAEM/SqR4TG0xk7kDxY0g/cYFVS2A0Sa4W659hk6YE5luvOQarxiXC5+B9GDKEvflUjPpw/lb5Dvg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


The 'clean' target is still noticeably slow on cygwin, despite the
improvements made by previous patches. For example, the second
invocation of 'make clean' below:

  $ make clean >/dev/null 2>&1
  $ make clean
  ...
  make -C git-gui clean
  make[1]: Entering directory '/home/ramsay/git/git-gui'
  GITGUI_VERSION = 0.21.0.78.g38c2a
  rm -rf git-gui lib/tclIndex po/*.msg
  ...
  $

has been timed at 8.430s on my laptop (on old core i5-4200M @ 2.50GHz,
8GB RAM, 1TB HDD).

Notice that the Makefile, as part of processing the 'clean' target, is
updating the 'git-gui/GIT-VERSION-FILE' (not to be confused with the
similarly named file at the root directory of the repository). This is
to ensure that the $(GITGUI_VERSION) make variable is set, once that file
had been included. (The Makefile target uses the 'git-gui/GIT-VERSION-GEN'
script to generate that file, which should also not be confused with the
similarly named script at the root). However, the 'clean' target does not
use the $(GITGUI_VERSION) variable, so this is wasted effort.

In order to eliminate such wasted effort, use the value of the internal
$(MAKECMDGOALS) variable to only '-include GIT-VERSION-FILE' when the
target is not 'clean'. (This drops the time down to 6.454s, on my laptop,
giving an improvement of 23.44%).

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---
 git-gui/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/git-gui/Makefile b/git-gui/Makefile
index f10caedaa7..56c85a85c1 100644
--- a/git-gui/Makefile
+++ b/git-gui/Makefile
@@ -9,7 +9,9 @@ all::
 
 GIT-VERSION-FILE: FORCE
 	@$(SHELL_PATH) ./GIT-VERSION-GEN
+ifneq ($(MAKECMDGOALS),clean)
 -include GIT-VERSION-FILE
+endif
 
 uname_S := $(shell sh -c 'uname -s 2>/dev/null || echo not')
 uname_O := $(shell sh -c 'uname -o 2>/dev/null || echo not')
-- 
2.29.0
