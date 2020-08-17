Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C91E9C433DF
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F69820748
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 14:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZmIGXbpF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728737AbgHQOE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728512AbgHQOEy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 10:04:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2F8C061342
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id r15so5220814wrp.13
        for <git@vger.kernel.org>; Mon, 17 Aug 2020 07:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iaUPrfhWHGXEMnzRqcjvqanrft+YOmjrkZ6MGH/OBEo=;
        b=ZmIGXbpFnGwlCOKwp9zbBaMPFTa/jTi1T1Kv6OsVscpEEt9yKdURr9IiUzXvy09DrZ
         yTnY/5+eD+8eSTwITQRUE7xholNCx7Wzd6/U3+umESK0Eqc6SaNYriBK7/2EKuL7nXdk
         hzZC6J11LQvewN9OUo0054Rn6VYSg7m9n/u6lp0KizjwZjLe1YjF5e157snPAti1N7sh
         eHkVrl5lz05G5ZFLVl2D0RxGIxhw0qKPcfDxzsAjoIb7HJP+0o6te8AAxPPCwIw3FHLF
         wJdlOOOB6zzsgnGyRbtfXwqhg1FO9ZOTeVah9MXNeWNTaPaSzGG8blo985sz7EUhQs9D
         iA3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iaUPrfhWHGXEMnzRqcjvqanrft+YOmjrkZ6MGH/OBEo=;
        b=QQPDYEDAZoxSOWO/NXhGF9o9N+s21MLvFr0gyNmDoW83KA+lsjQy0r8p5PSYMWmwZf
         rHIa0Ynvrk7z3xtYNVKNjsGMBBJSk17U2QEVvtZMQ80gCdofgssueXwUdhBJ6ugbJSgx
         gPenLukY7+0tXFTsVQhJx2VsarmSzcl5Ou2RD04eZ3rAyHD4wdNvYBL024y9N0yAa4YZ
         DTlpBxJh4NS/9YmoI0zDo23QLGy7aYphV9xXfV4zMH05L9+H/W7tD7ADq1xUQ1MlAqHR
         pi25wVYU5bLKuQCW3PslNXhZti2aHHv1TPvGfcLcu4KjE1/QG80CxHLSWJX+MB6SbanW
         Qlmw==
X-Gm-Message-State: AOAM532xlCBC/nsPlvapeiUQ9esQx6HfGL6NzVCkKjQI1MqlRJ9LJ80y
        te7tpO4tVfaqCjNIcFP7DsqeWQOpp68=
X-Google-Smtp-Source: ABdhPJycmvjDTtcmLH2sVbgVLM2Uz9kDKdMZvCHozWeT/OkMdrm+MpifbWV0SCtDNIcr7k1NfeReGw==
X-Received: by 2002:adf:ec10:: with SMTP id x16mr15141985wrn.74.1597673092084;
        Mon, 17 Aug 2020 07:04:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n5sm30015984wrx.22.2020.08.17.07.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:04:51 -0700 (PDT)
Message-Id: <62e7247badffe64ac5cfa69e02057cf704c02583.1597673089.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
References: <pull.703.git.1597428440.gitgitgadget@gmail.com>
        <pull.703.v2.git.1597673089.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 17 Aug 2020 14:04:46 +0000
Subject: [PATCH v2 1/3] t/README: document GIT_TEST_DEFAULT_HASH
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     martin.agren@gmail.com, sandals@crustytoothpaste.net,
        me@ttaylorr.com, abhishekkumar8222@gmail.com,
        sunshine@sunshineco.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/README | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/README b/t/README
index 70ec61cf88..2adaf7c2d2 100644
--- a/t/README
+++ b/t/README
@@ -421,6 +421,10 @@ GIT_TEST_DISALLOW_ABBREVIATED_OPTIONS=<boolean>, when true (which is
 the default when running tests), errors out when an abbreviated option
 is used.
 
+GIT_TEST_DEFAULT_HASH=<hash-algo> specifies which hash algorithm to
+use in the test scripts. Recognized values for <hash-algo> are "sha1"
+and "sha256".
+
 Naming Tests
 ------------
 
-- 
gitgitgadget

