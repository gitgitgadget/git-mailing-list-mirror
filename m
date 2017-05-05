Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1C77207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:41:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752677AbdEEPlA (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:41:00 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34563 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752007AbdEEPk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:40:58 -0400
Received: by mail-wm0-f66.google.com with SMTP id z129so2095130wmb.1
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:40:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4am4UUukk4tYDOcpDYVtl4NVayTE7OD5V8JFdw1kDSA=;
        b=UgedlErcuuCKZeQ3l+MwezWjBEYl358cIPI0Sm14qdRqEn+OWmGevBNe93/rVp9adk
         k2JgP1hvjWiXT1T04fufh9BoE4V+MLG/6Rjnv+U2n4+ASl72XiaK1RX8ICbHdlpIXtXn
         0liW5hg9sxcHTIsckhJkajkX1ZNwL5nxH6VpuKKUvIor2GBcqQUHF1Y0XbaDbsE+pN9V
         z2/2Oz8Zsn6FWZauFFEe6yy1VJc24tD0u4WucGtUCOs+JjYMysbbBzZQT49/OI21JZSc
         TXiJ/B1viq5s79IEkhqmkgnobqKbP4KAIuCks3e/vOSQ862lAHXJ1+iFgn8Z7PC5fmeo
         bEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4am4UUukk4tYDOcpDYVtl4NVayTE7OD5V8JFdw1kDSA=;
        b=OcSEROPPDGfZz1okzd9wjA3SP7//wIzOKCss/gjzAo6cbIFkkp0/LFerrLdJg6BMhT
         KotFtwFqfAHmDHYqhjM/JSC7UrN3nILXSdrhLt6x6nyVZloXFiBLn+Ebw+/UZvI02HqB
         vTsGY9iJBM+4/PcmwABTPWoZsGZ5VhE3Gt48Kh4hCoy0qPApFsg4h5c3VcjmSbfbOCUx
         OKkdwxxyuLhVDyGky1VXUC+d0HOtJS+gTEJoKvrOjDYbfKB35WdAm0NLDwjuJgQnq6Ct
         9oQLZURNTEvpaFNstb8WSsbvu0UJ9t8waE/iWpH42anLSs9hCXkU2UzTnmEV27eujdZD
         rDSQ==
X-Gm-Message-State: AN3rC/5MPaFoLqDPRFG7cXU0XaiyTs7l6KjwI3QfZ5PQhU41vkKDCzpm
        7jKRfXINfIinFeB8
X-Received: by 10.28.217.66 with SMTP id q63mr5445005wmg.10.1493998856478;
        Fri, 05 May 2017 08:40:56 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f63sm2531979wmh.8.2017.05.05.08.40.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:40:56 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v1 1/2] travis-ci: setup "prove cache" in "script" step
Date:   Fri,  5 May 2017 17:40:52 +0200
Message-Id: <20170505154053.58128-2-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505154053.58128-1-larsxschneider@gmail.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command that made the "prove cache" persistent across builds was
executed in the "before_install" step. Consequently, every job that
wanted to make use of the cache had to run this step.

The "prove cache" is only used in the "script" step for the
"make test" command. Therefore, we should configure the "prove cache"
in this step.

This change is useful for a subsequent patch that adds a job which does
not need the "before_install" step but wants to run the "script" step to
execute the tests.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 48cb00a581..aa03f8eb82 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -135,12 +135,14 @@ before_install:
     p4 -V | grep Rev.;
     echo "$(tput setaf 6)Git-LFS Version$(tput sgr0)";
     git-lfs version;
-    mkdir -p $HOME/travis-cache;
-    ln -s $HOME/travis-cache/.prove t/.prove;
 
 before_script: make --jobs=2
 
-script: make --quiet test
+script:
+  - >
+    mkdir -p $HOME/travis-cache;
+    ln -s $HOME/travis-cache/.prove t/.prove;
+    make --quiet test;
 
 after_failure:
   - >
-- 
2.12.2

