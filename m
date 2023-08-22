Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B169BEE4996
	for <git@archiver.kernel.org>; Tue, 22 Aug 2023 03:34:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232498AbjHVDeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 23:34:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjHVDeg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 23:34:36 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92F4186
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 20:34:34 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id 3f1490d57ef6-d45caf42d73so3959647276.2
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 20:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692675274; x=1693280074;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jqQhE9MXQnKd0EKUnWPuBCpaaoKdp9SHjLRRvbgpu9A=;
        b=Nka5UY6FIbfrlZp4cn9k2Quin53tXUEI7kdBXscyDt1rmIqOmO+Tzib1i8rAnI4ZM7
         tohFZMLV+c7jhxHHUD1xfoA53HgwZeEpWwnZa2MLTJbeFlNhISE03y1KcDvMn/euiaPV
         noDdLUJ1Y41b5/O7e6VBczHiM3vcU9iVjz7q5SNieMLlJuV4aK2BsGeFzx6pwoaNkL89
         2NTz5Yfyo0opoa/SaU8rKmYMO/6WfCcxU3K37E8L45469rz+d2RzW9nohdw7zt0tPpsC
         1gNvtBroY6gQy8/ZhMQx3rUgDFz8p05FwBRtiMvag+gwchJ1RJxAi4UWx5GmlI/LUX3z
         KkFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692675274; x=1693280074;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jqQhE9MXQnKd0EKUnWPuBCpaaoKdp9SHjLRRvbgpu9A=;
        b=iKBnaGWbrW95ibYzg8qyqngkUx2FqhQYx31YoQ5ZZscIEr9N/IyO7kBZGAlrYocxya
         Z8km87koayydrMT/OhhFbePIiIYGxwH9tA1cCtdydb1ymgSBJPf8Iirz+SUf2DD6DdKJ
         tNG8fPVmnSUD+J4HFaiaTO+KWEcyHgeUUZZD8j2B0qcupXwD/Y9TqopVLRf1Y007shiP
         BIcgytaueEP3ZJghCTs1JUVv23lz2Oy5JY4gIHqOJ0Njp8LuTkt4iJo4dUs5fBZ/A85o
         E23lJs8kcwASsvRBaOVE8mFz6rJ8w1h08jqPdxZH2nM0+T5MIcEN1RBEIx8UyIKR52D8
         hgbw==
X-Gm-Message-State: AOJu0YyRSbLQSF9faXEF2YifgUBz0huYjvJZRt9ynIikZDUxx3MqM1oQ
        5RAfUEfnXQJ/0tPDcTr1StlWPHHtpdH7QCSj8hBDvQ==
X-Google-Smtp-Source: AGHT+IGPJg+u+PGjRQkwofQs0orsdVL8yZHf/Pj3IMHtt2clDHNoGGJjQlQBSvYSGXocgyd/FVio3w==
X-Received: by 2002:a5b:c4d:0:b0:c6c:e4f4:2fb1 with SMTP id d13-20020a5b0c4d000000b00c6ce4f42fb1mr8210671ybr.3.1692675273695;
        Mon, 21 Aug 2023 20:34:33 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x25-20020a25ac99000000b00d687cf69599sm2168930ybi.52.2023.08.21.20.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 20:34:33 -0700 (PDT)
Date:   Mon, 21 Aug 2023 23:34:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH] .github/workflows: add coverity action
Message-ID: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Coverity is a static analysis tool that detects and generates reports on
various security and code quality issues.

It is particularly useful when diagnosing memory safety issues which may
be used as part of exploiting a security vulnerability.

Coverity's website provides a service accepts "builds" (which is more or
less the collection of '*.o' files generated during a standard build
with "make") as input and generates reports as output. In order to
generate a report, we have to first compile Git and then upload the
build archive to Coverity.

This Action generates and uploads a build archive to Coverity when a
GitHub repository has configured the "COVERITY_SCAN_EMAIL" and
"COVERITY_SCAN_TOKEN" repository secrets, respectively. This enables
Coverity to automatically report on new changes pushed to 'master', as
well as any newly created tags.

A couple of implementation notes:

  - In order to successfully build 'git', we (ab-)use the
    ci/install-dependencies.sh script by faking in some of the
    environment variables to take on values specific to the main.yml
    workflow file in order to install the correct set of dependencies.

  - We could upload the build archive to Coverity directly with a
    straightforward curl request. But using the vapier/coverity-scan
    Action comes with some additional niceties, such as caching the
    (rather large) Coverity tool download between runs.

If the repository is missing either of the two secret tokens mentioned
earlier, this Action is a no-op.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 .github/workflows/coverity.yml | 35 ++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 .github/workflows/coverity.yml

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
new file mode 100644
index 0000000000..26b9145d9e
--- /dev/null
+++ b/.github/workflows/coverity.yml
@@ -0,0 +1,35 @@
+name: Coverity
+
+on:
+  push:
+    branches:
+      - master
+    tags:
+      - '*'
+
+jobs:
+  coverity:
+    runs-on: ubuntu-latest
+    env:
+      HAVE_COVERITY_TOKEN: ${{ secrets.COVERITY_SCAN_EMAIL != '' && secrets.COVERITY_SCAN_TOKEN != '' }}
+    steps:
+      - id: check-coverity
+        name: check whether Coverity token is configured
+        run: |
+          echo "enabled=$HAVE_COVERITY_TOKEN" >>$GITHUB_OUTPUT
+      - uses: actions/checkout@v3
+        if: steps.check-coverity.outputs.enabled == 'true'
+      - run: ci/install-dependencies.sh
+        env:
+          CC: gcc
+          CC_PACKAGE: gcc-9
+          jobname: linux-gcc-default
+          runs_on_pool: ubuntu-latest
+        if: steps.check-coverity.outputs.enabled == 'true'
+      - uses: vapier/coverity-scan-action@v1
+        if: steps.check-coverity.outputs.enabled == 'true'
+        with:
+          email: ${{ secrets.COVERITY_SCAN_EMAIL }}
+          token: ${{ secrets.COVERITY_SCAN_TOKEN }}
+          command: make -j8
+
-- 
2.42.0.15.geed1e1a32a
