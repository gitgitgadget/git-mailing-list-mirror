Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5559DC636D3
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 11:31:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjBALbs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 06:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjBALbp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 06:31:45 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA7F5CDC6
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 03:31:44 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id z1-20020a17090a66c100b00226f05b9595so1721145pjl.0
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 03:31:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=d/+jBufBzqSO8AXH8OHLDAdrF5XD4WcFghNgoMuS2J0=;
        b=KUAXAiiVo6DJFM8Rd5YAQvNDa07A9JWRC+hB2VRVUNN+6HSaCsmdMQAy4s5hkJm7h5
         9o/9TpaJ/vE7xzJn0Xnm37FLlxoneeX2m0uNIapUHglnSjr/oXDQ5EvTsVnKdo5KKvjG
         du4U7vn04QQtes/hd3luPFD09FjvHPLHVVOKMC8QWgjgxtPizA/+Lh9pJgcg3uyoi94J
         mkAzrRJdRK5ZYOTrGd+RAeIDlpH6bpUcyZZF1fQc25fTXMeQI01pCFmk5gAZpeAZsIb1
         9wB2qMvxlmy3ML+FOIuw1T9zqGVrnixALp3XvDV7zYuPiWGE4qwUK5WofVA7tzPGB/BO
         EvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=d/+jBufBzqSO8AXH8OHLDAdrF5XD4WcFghNgoMuS2J0=;
        b=H9U/L46zg5M3WYWdAa2ZKjlurtWSQWieSZVY1kHuZO+6AW0w467K+Qa5jPDMBddi5O
         Pkqc3eSgAS4XSHwfHAoy/Gw7XtR12OIR2vEWu6uIK4lcGuCoETW+MRCrncel8ummUiP0
         s4PdbLkqDK2dEXkJ8VPRGYlgitz7kZBE+QQOpXw3NR9uXVET7VA8152GxhsvzDilnB9S
         dJzP9q8+LLmuxCsiz2PjBo1pw8X7nzUAtcSjDkNgk2/l14MezIOjsPIBSH2ihblVP1oo
         tx9nH/QkLa9tAHHitqiHq5N+UbH9p1aDSBOCV4fZdB10+m4CnGjFdj+pt9xLDeLXtvvD
         Fs/w==
X-Gm-Message-State: AO0yUKXTOBee1v8nDGnhpHn9W+74G4bXsxNM5uRcUkxWchlKUd7/8mlL
        X7mP8ZEnnFrBy6E946cGyxz5v9gz7qw=
X-Google-Smtp-Source: AK7set92FEjoTeDnRzGCR2lAFUGEC2E2b4g6lnsP447InS7LfFdjDQeHpjX+rciViwT4kWHSBec9vQ==
X-Received: by 2002:a17:902:f543:b0:196:5f76:1e51 with SMTP id h3-20020a170902f54300b001965f761e51mr1978843plf.64.1675251104002;
        Wed, 01 Feb 2023 03:31:44 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902c74500b00195f0fb0c18sm11641579plq.31.2023.02.01.03.31.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Feb 2023 03:31:43 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Bernhard Reiter <ockham@raz.or.at>,
        Remi Pommarel <repk@triplefau.lt>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 1/2] Makefile: not use mismatched curl_config to check version
Date:   Wed,  1 Feb 2023 19:31:32 +0800
Message-Id: <20230201113133.10195-1-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

We may install different versions of curl, E.g.:

 * A system default curl, which version is below 7.34.0, is installed
   in "/usr", and the "curl_config" program is located in "/usr/bin/".

 * A higher version of curl is installed in "/opt/git/embedded/", and
   the "curl_config" program is located in "/opt/git/embedded/bin/".

If we add the path "/opt/git/embedded/bin" in search PATH, and install
git using command "make && sudo make install", the source code may be
compiled twice.

This is because when we run "make" using normal user account, make will
call "/opt/git/embedded/bin/curl_config" to check curl version, and will
set variable USE_CURL_FOR_IMAP_SEND. But when we call "make install"
using root user's account, we call the system default version of
curl_config to check curl version, and will lead to a different
"GIT-CFLAGS" file, and will recompile all source code again.

Append "$(CURLDIR)/bin" before the "CURL_CONFIG" variable to use the
specific "curl_config" program we want to check curl version, we will
get the correct "CURL_CFLAGS" and "CURL_LDFLAGS" variables, and we can
also have a stable "GIT-CFLAGS" file to prevent recompile when running
"sudo make install".

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Makefile b/Makefile
index 45bd6ac9c3..f4eaf22523 100644
--- a/Makefile
+++ b/Makefile
@@ -1597,6 +1597,7 @@ else
 		# Try "-Wl,-rpath=$(CURLDIR)/$(lib)" in such a case.
 		CURL_CFLAGS = -I$(CURLDIR)/include
 		CURL_LIBCURL = -L$(CURLDIR)/$(lib) $(CC_LD_DYNPATH)$(CURLDIR)/$(lib)
+		CURL_CONFIG := $(CURLDIR)/bin/$(CURL_CONFIG)
 	else
 		CURL_CFLAGS =
 		CURL_LIBCURL =
-- 
2.38.2.109.g8b8c02ffae.agit.6.7.7.dev

