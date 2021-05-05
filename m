Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE297C43461
	for <git@archiver.kernel.org>; Wed,  5 May 2021 21:18:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA278611AC
	for <git@archiver.kernel.org>; Wed,  5 May 2021 21:18:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbhEEVTq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 May 2021 17:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229893AbhEEVTp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 May 2021 17:19:45 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A25E2C06174A
        for <git@vger.kernel.org>; Wed,  5 May 2021 14:18:48 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id b5-20020a9d5d050000b02902a5883b0f4bso3043637oti.2
        for <git@vger.kernel.org>; Wed, 05 May 2021 14:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SH+tPzQybOaV1Gf7mS7ZAddFk1OAjJJZPiXyebOnz8A=;
        b=mmCvh0b4JIRRptoWEmD+dEhjtJ3ZACWsWFUzzWkWVEAyCBcvSvWtPSOmMPRyVr/G2c
         UkbSBNPXbyf/ZcgjR4dQxUQri2IMlsk5jcl6zePLUg0zz0IoxIvMu+4Fr/cG494MjR2k
         tSP27WXeDGKqJBjQdAcEONlTBeVgRGDw68eULkA5pzuZg4QgXWSRYSuGkIYzLjhZpL9g
         kHJoOt/WtOdL6fgoDapCN5heaDSKQzLWTtYL2/O+M00zzV5a7RLHw+XlWbY95KkJD1gt
         l8Rg4yIfySLU1BaDil1oc7uGaVDmjTzclgVim4m0Ba0TyvN5aFTj1LVTpkpo/OAAxrT2
         uRjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SH+tPzQybOaV1Gf7mS7ZAddFk1OAjJJZPiXyebOnz8A=;
        b=E/SmCRAwKlUPNMLOTLjAe66z0wPertxpBDZtiySqbpqYTYQsiikf5TQUUg1GP080ki
         dRKI2MR4Pw5WC61uEpHkqbFvIVR8Q0ZUwJJm0evl+rlbVsfJ2y+43+EU7aqWF/iMEBHD
         JT4wVrvmPRpqJpwZ/WlXmJmL8Oeqlf5t1hGCqvOTPc5iPOrm2svO/xzgX18AoUtKf7vi
         tD7v15N3vcnbs5tWH+AMSrOhyOJYJicIuw+jtHnik42ruXpXe8cvN1r6Wd48gMd0FXBp
         WVeoibPQEoPTVGnn5nolD3PEtOxtIuaWMEiQRA3rek7srw+QrT5oFVkSiPqun3BgDLZ4
         IspA==
X-Gm-Message-State: AOAM532rbBjFDpO/6/ybuRIQHSWD3E/D7bSL7RIwkYANo/KgBhbHP2dF
        5zh+ALzWTK/WkI1vQrPQc7kMgUZ6G1Ui4g==
X-Google-Smtp-Source: ABdhPJxnuOWNMzxo6Fr8rN3eIKbe8nZDAVvE2NgXnaC/GL9hAXD0NBtE24UzTmz0RBfyJoO/LjcU2A==
X-Received: by 2002:a05:6830:1d56:: with SMTP id p22mr531116oth.329.1620249527825;
        Wed, 05 May 2021 14:18:47 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:638f:a2c5:89ff:fe0c:1151])
        by smtp.gmail.com with ESMTPSA id r9sm123841ool.3.2021.05.05.14.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 May 2021 14:18:47 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Paul Mackerras <paulus@ozlabs.org>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] gitk: automatically cd to $GIT_PREFIX
Date:   Wed,  5 May 2021 16:18:46 -0500
Message-Id: <20210505211846.1842824-1-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If gitk is ran as a shell alias it cannot find specified files in the
command line if ran in a subdir (because it's ran in the top-level
directory).

  cd Documentation/
  git -c 'alias.test=!gitk' test -- config.txt

The simplest way to fix this is to automatically cd to the specified
$GIT_PREFIX in the environment.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 gitk | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/gitk b/gitk
index 23d9dd1..c7c6989 100755
--- a/gitk
+++ b/gitk
@@ -12505,6 +12505,10 @@ if {[catch {set gitdir [exec git rev-parse --git-dir]}]} {
     exit 1
 }
 
+if {[info exists env(GIT_PREFIX)] && $env(GIT_PREFIX) ne ""} {
+    cd $env(GIT_PREFIX)
+}
+
 set selecthead {}
 set selectheadid {}
 
-- 
2.31.0

