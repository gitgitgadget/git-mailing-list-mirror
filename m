Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 798FC1F78F
	for <e@80x24.org>; Mon,  1 May 2017 18:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750910AbdEASBQ (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 May 2017 14:01:16 -0400
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34379 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750883AbdEASBJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 May 2017 14:01:09 -0400
Received: by mail-pf0-f173.google.com with SMTP id e64so40121798pfd.1
        for <git@vger.kernel.org>; Mon, 01 May 2017 11:01:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=+iyhDym8aoRzhoyzbuA4we3qgEcKX89tur/DGDTxW/s=;
        b=GYkAIE3tXwxO5/EV+S4fOntX5Hp85RbFnPRz5QcZzPi7tZkzfjqf4M/ogfJiznbRBm
         pSeJ/ZmN9yAo6iiH1UC7BXSFgOF0TZ4HDQdR9tlhlE6cpkidGeW1Fj+vLNNeWJCt/V8i
         RekHcQnWu6aGunQXFIvZu6uEXtCpsLxa2zhHuUjZve9WpaEI+E+23yTRAlVwj3Vyj0Ih
         wUPLzq/jUp9eZOYZzLrW83RWZm3aovHaw42ov/GE/AEh8SeJ4WCk62udiy0otBBrd6Vb
         eSXNit+bTPwUoHFlG4T2caTfDaM1T4jf9UgMWgR1XQUk6dJcHYizLo7NZ8OvviiKriK8
         A30w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=+iyhDym8aoRzhoyzbuA4we3qgEcKX89tur/DGDTxW/s=;
        b=eWAaYSYfto4r/YPc5Z7d52q/WCbXAJ6IiljXzLVfYkpvWvTa0eJHEQaaV7Hb5R9s9h
         5g+xrReOQ//VWHNt93RdlEyLxfKMXntBdhf7hZcNrZ3QjuihNZ/UOJ+vPH8EmCnogkr3
         cr2Tw5FeD+Nhr4mmdbtgo4LzRtGaRefbzSGAX7gxoKcEevJT1ssN+FzCrp+g1I3gOqUI
         U4oLDsnVye+nqsInYrnZjcCECKBuPlkeITenKRGDFJizuwt23937ejfKf8Vcwkij1rpl
         LMeEKjPkDYDOMSkyDWSn1uPy7avJfF9D/bmjTCYtZaRH996zB49oDb6zNkiG8BuHkbxr
         8H4w==
X-Gm-Message-State: AN3rC/7egmvLV20BEzjCWCtAKUHZhm8+8AZWgEyrcQiBWSuTGAydO/G1
        h+p4BPRlJO76Nc0b
X-Received: by 10.98.213.138 with SMTP id d132mr27862822pfg.172.1493661668762;
        Mon, 01 May 2017 11:01:08 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c4be:9746:6a14:c7a4])
        by smtp.gmail.com with ESMTPSA id g66sm7765837pgc.2.2017.05.01.11.01.07
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 01 May 2017 11:01:08 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jrnieder@gmail.com, bmwill@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/5] submodule_move_head: prepare env for child correctly
Date:   Mon,  1 May 2017 11:00:55 -0700
Message-Id: <20170501180058.8063-3-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.rc1.1.gbc33f0f778
In-Reply-To: <20170501180058.8063-1-sbeller@google.com>
References: <20170501180058.8063-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We forgot to prepare the submodule env, which is only a problem for
nested submodules. See 2e5d6503bd (ls-files: fix recurse-submodules
with nested submodules, 2017-04-13) for further explanation.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/submodule.c b/submodule.c
index cd098cf12b..c7a7a33916 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1476,6 +1476,7 @@ int submodule_move_head(const char *path,
 			cp.no_stdin = 1;
 			cp.dir = path;
 
+			prepare_submodule_repo_env(&cp.env_array);
 			argv_array_pushl(&cp.args, "update-ref", "HEAD", new, NULL);
 
 			if (run_command(&cp)) {
-- 
2.13.0.rc1.1.gbc33f0f778

