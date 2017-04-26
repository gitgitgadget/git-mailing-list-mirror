Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5ED0207BD
	for <e@80x24.org>; Wed, 26 Apr 2017 19:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966084AbdDZTQA (ORCPT <rfc822;e@80x24.org>);
        Wed, 26 Apr 2017 15:16:00 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35967 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966056AbdDZTPw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2017 15:15:52 -0400
Received: by mail-wm0-f67.google.com with SMTP id u65so3746507wmu.3
        for <git@vger.kernel.org>; Wed, 26 Apr 2017 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Mz0/xt9n0QOCql12CpMiq5ojxUtjjW56bcX1w3jchpc=;
        b=m4rwonUm3kbnzFu3hBksO5XK6fufFPtIpich6jG9jRZTX0Y+PPWtZBQveRA9VSuRey
         paDocRYPHcTst5lB3Rn/FglXvojK+65rS17wt7zu4q5Noxv0MLckIa3MwIXIztdWPVMA
         j7GCNyz0PqWoxxouHOO/RYiMnLvqzA9lkQBPukcINb4dbdAaOOUihF/k4627FKXNJmVt
         G9Zja62RYjBQZRWtbyOF6TSvRax54MifqXTwhKldOZvcNpnDd6MHqNUuaySc3pejbD2n
         v6XzsoCVxk1Xf/tj2nSbKrmn56kOebqGBxfjeCW5ixUmZ5FPrYUaRIJvNg3gSOfoF5r0
         byyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Mz0/xt9n0QOCql12CpMiq5ojxUtjjW56bcX1w3jchpc=;
        b=G7dwrtl9E5bNsYNlvndenAmil7Wd4IruEKG9CRSF2Id2LRmjEg49ytHYHj+rTdA1wI
         oucNB/yZHsuX9NZ4V7oTnaE5sXBMAIsKMuoA8QmOuKKQWo92gUYD3wJpPgae5n4uSgMv
         Lk5igJuiRN9fzLShnK0fcVTBFMTP0onZFTK2l2tYM5dFOYxqlnjWtMrv3nAdl1mxyeg5
         z0Wu9FVC2JJhQ3PGn5++VJlR8jCWC4XWS0wfhC76qZ7+BOVtCSKoN/W1aVOkiyc8oeaU
         u1dmzQOlA9oR9X+BUDhBAr7ctWMnmnHw/KYfDTEhxFV6gvjeuHfuv7fZDv2kp8Q52q47
         SETA==
X-Gm-Message-State: AN3rC/5gYLAO+I+6tMItWtfn5yOZSS2QaJuV8GuioowlPqQXt9m5SS/8
        1h4zLoPD83LDUg==
X-Received: by 10.80.184.2 with SMTP id j2mr2019520ede.176.1493234151039;
        Wed, 26 Apr 2017 12:15:51 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id n40sm275426edd.12.2017.04.26.12.15.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 26 Apr 2017 12:15:50 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com
Subject: [PATCH v2 4/4] travis-ci: unset compiler for jobs that do not need one
Date:   Wed, 26 Apr 2017 21:15:45 +0200
Message-Id: <20170426191545.27552-5-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170426191545.27552-1-larsxschneider@gmail.com>
References: <20170426191545.27552-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

TravisCI does not need to setup any compiler for the documentation
build. Clear the value to fix this.

The Linux32 build job does not define the compiler but it inherits the
value from the base job. Since it does not need the compiler either
because the build runs inside a Docker container we should clear this,
too.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index c26f3bf789..e5e7c3edd7 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -41,6 +41,7 @@ matrix:
   include:
     - env: Linux32
       os: linux
+      compiler:
       services:
         - docker
       before_install:
@@ -62,7 +63,7 @@ matrix:
         # root@container:/# /usr/src/git/ci/run-linux32-build.sh
     - env: Documentation
       os: linux
-      compiler: clang
+      compiler:
       addons:
         apt:
           packages:
-- 
2.12.2

