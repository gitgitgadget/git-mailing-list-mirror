Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D23F207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966080AbdDZTP7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:15:59 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35949 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966065AbdDZTPv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:15:51 -0400
Received: by mail-wm0-f66.google.com with SMTP id u65so3746428wmu.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j3/BUx94fRzZ0adeALOwNf8BWF+yzr3SuY2rFfIb+0k=;
        b=jchax0n+lXmF7aiN69oHSYx+k9xK3x7RC/JAyxOk1J+98vHYUnZxzM8RJXfT+1AjSe
         J1mOvGlFSylYXiDhhLcez+uvjKr83LS63RQIJLNMondz+mdFx5dLas33F43UgoHczRMC
         /fmIRdJq6/vOr1kfMD0Wbk/12t8vA4EYIlXsizJfTX/X87OeRBtl3vvmRxfdc1zGzAP6
         Opzaqw05L4DwKA9/u408SINQZrLfziWSHvVgibloZq6OjVHIExOLwaa4TKCeXpEg7ljM
         6lcK5MoknnDBJi0aWw9g7QYwX9qbpCm8EkAg6TvYPPzxUM/4TB316iTOxMYdG7+H/SiC
         2o1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j3/BUx94fRzZ0adeALOwNf8BWF+yzr3SuY2rFfIb+0k=;
        b=N0N9dAIDCzycaswciFQotJaZNRTBxyKpuhTaVul/lIX4CadMTHFmydhY5lvYm4dv6R
         wRdagnkhcp1uTfxagma41rhQ/9qvNPR421qsDrcsasqwxfGKnMfbOvy1FgYejIOXcpRQ
         FFWSVI3oGtkm6KgkjleHotWRr5zqeFd667rhV5oMUo89fnKxhwlLILdrPBxvZEEU9haq
         jd/M17lkrkfhfPK2enoZYitje0pYRN/yLH6e/pREJ5eAPsQWwho7ZFLMPiNP/i2FLs9Q
         DWWOw0aPXpBRh3yS8Ry/lAST8J66SWHyGGTvlzFel6KxXZ7TkvFuZ7/Ug55hgSuxu6VX
         q2FA==
X-Gm-Message-State: AN3rC/6l7ZRXh3N1mrh5GYiwTnaY2I8SV06zHKZ7m7j8eiBRL7Po3K/P
        Ga/ayPeSz0J8Vg==
X-Received: by 10.80.196.76 with SMTP id w12mr2024894edf.155.1493234150191;
        Wed, 26 Apr 2017 12:15:50 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n40sm275426edd.12.2017.04.26.12.15.49
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:15:49 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH v2 3/4] travis-ci: check AsciiDoc/AsciiDoctor stderr output
Date:   Wed, 26 Apr 2017 21:15:44 +0200
Message-Id: <20170426191545.27552-4-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170426191545.27552-1-larsxschneider@gmail.com>
References: <20170426191545.27552-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

`make` does not necessarily fail with an error code if
Asciidoc/AsciiDoctor encounters problems. Anything written to stderr
might be a better indicator for problems.

Ensure that nothing is written to stderr during a documentation build.

The redirects do not work in `sh`, therefore the script uses `bash`.
This shouldn't be a problem as the script is only executed on TravisCI.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 ci/test-documentation.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/ci/test-documentation.sh b/ci/test-documentation.sh
index 58962d668a..6214e6acb4 100755
--- a/ci/test-documentation.sh
+++ b/ci/test-documentation.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 #
 # Perform sanity checks on documentation and build it.
 #
@@ -9,7 +9,8 @@ make check-builtins
 make check-docs
 
 # Build docs with AsciiDoc
-make --jobs=2 doc
+make --jobs=2 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
+! test -s stderr.log
 test -s Documentation/git.html
 test -s Documentation/git.xml
 test -s Documentation/git.1
@@ -17,6 +18,8 @@ grep '<meta name="generator" content="AsciiDoc ' Documentation/git.html
 
 # Build docs with AsciiDoctor
 make clean
-make --jobs=2 USE_ASCIIDOCTOR=1 doc
+make --jobs=2 USE_ASCIIDOCTOR=1 doc > >(tee stdout.log) 2> >(tee stderr.log >&2)
+sed '/^GIT_VERSION = / d' stderr.log
+! test -s stderr.log
 test -s Documentation/git.html
 grep '<meta name="generator" content="Asciidoctor ' Documentation/git.html
-- 
2.12.2

