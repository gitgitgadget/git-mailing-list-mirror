Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F166207B3
	for <e@80x24.org>; Fri,  5 May 2017 15:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbdEEPk7 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 May 2017 11:40:59 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36529 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751951AbdEEPk6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2017 11:40:58 -0400
Received: by mail-wr0-f196.google.com with SMTP id v42so1056917wrc.3
        for <git@vger.kernel.org>; Fri, 05 May 2017 08:40:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hJgZasKUpo1XXf3ahRN/XLDCPnLwze9rCopaW5W4TG8=;
        b=aVVp1uqoO4gg/KR2TSqfLvsd2g4BFAsEBuwo5Cg4YLF9XId2PNTneq6c0Z9vEHZoSE
         8OImAggwaDPABVhf701wkYPMXYF6aUYwpHFI2IxFhFa6rPCv36Xgk9qUYSA42fRbye0v
         03hK7p/0g7ud2/vrUsrjZsCh7eBAyjci51Ad2jTjuwQQYH/YT4eCEQMln1JaS3Zb+vYN
         HfAbtO/zrQNkaRPcczR2Mg8KRNzibS0aDdshMGmslWHhWwO58sebIyU+nFWXP4uEdfJs
         D0nT+YD4NZ5RqHErm2w9jrs4z7ofz5uTgiTPZ7hKew7G57FD4c6RzZ05DH5G5E2E50aY
         W0AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hJgZasKUpo1XXf3ahRN/XLDCPnLwze9rCopaW5W4TG8=;
        b=c/hEIIyvOAN+TNuR+p+RPk97uUBpe4AfuerK2SxCfVDS1oQKICDX/676/C/WYW2qps
         m6JLNFDt7bLFqHKP1Yn26w+TOWs41YJkOOFYlNnXB3kx+CI519WRB/lVS4HDFikz7of+
         uX3hvIidtepwADnWr38PY871l9hEpZ8YQdjb42AEzoC9um1x3InjsmcYCqwaBMECtz0j
         TRZHQqRSqmDP1aZpScO6+FAAKDPPdsAmjHBMOHWLTE1NtaD0c4aFKL2xNe3Exrrb6Ati
         07nIwAKuOOiSahAOSaABy7Zvjhb1ZC6ZuV4y3vF9141DLGpX4uXc2qoy8LRcCBq5dJv8
         LEmA==
X-Gm-Message-State: AN3rC/6YVHo2yQNKVBoClEb4hYXc1CeBEkNbMzMP8TWXajcLWw7E0PS1
        G4LIb21PV01b8Q==
X-Received: by 10.223.143.13 with SMTP id p13mr31642837wrb.3.1493998857210;
        Fri, 05 May 2017 08:40:57 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id f63sm2531979wmh.8.2017.05.05.08.40.56
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Fri, 05 May 2017 08:40:56 -0700 (PDT)
From:   Lars Schneider <larsxschneider@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com
Subject: [PATCH v1 2/2] travis-ci: add job to run tests with GETTEXT_POISON
Date:   Fri,  5 May 2017 17:40:53 +0200
Message-Id: <20170505154053.58128-3-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170505154053.58128-1-larsxschneider@gmail.com>
References: <20170505154053.58128-1-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a job to run Git tests with GETTEXT_POISON. In this job we don't run
the git-p4, git-svn, and HTTPD tests to save resources/time (those tests
are already executed in other jobs). Since we don't run these tests, we
can also skip the "before_install" step (which would install the
necessary dependencies) with an empty override.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 .travis.yml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index aa03f8eb82..278943d14a 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -39,6 +39,11 @@ env:
 
 matrix:
   include:
+    - env: GETTEXT_POISON=YesPlease
+      os: linux
+      compiler:
+      addons:
+      before_install:
     - env: Windows
       os: linux
       compiler:
-- 
2.12.2

