Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D3ADC00454
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8650D206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="K6YPs6Z6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbfLMXxg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:36 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:44668 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726831AbfLMXxe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:34 -0500
Received: by mail-pf1-f195.google.com with SMTP id d199so2280643pfd.11
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OEk0DorHiKYXJBKppQcBNfdw2rH99FD8zEg6SjEwr9I=;
        b=K6YPs6Z6Go8zbsd2T8J18nVNuGpQbZZyrAT3knPU4m/hCS5fYwRCaI69P1L8btyvvG
         s7bcOZt+Qsy6SFp8p2aJh/CM9czo2DBmnnhAETlZrAPpUY0kHNzEIjeJeCu5RC+SP++G
         Fj2ie1dWVB6ksCe10wppO7fQOzEJgAPVAhWBUzuSbgacePFF6HBx+HlGRRD1/d9L2Pza
         3NVFT8LuKJlb55x+PoayIp5WPBP4ovrLrKqQwYKFuiJ+Ir1TV0YxSDD1xiFdA8PCdSBx
         rtQOJRYhqxe9Oq/s/cAl5giLQAAgFkJW0F9vzFDblxKBEvUtbiT5C1jvELJtC9qdnHIY
         nhuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OEk0DorHiKYXJBKppQcBNfdw2rH99FD8zEg6SjEwr9I=;
        b=S7nHm2/hED2tvCQ88AAxnufpusvpHlBM+3rFm+2mYZPZKdf/GS97s/AhkSLMUbH3Xb
         Ct130HnS7OMasXmu0P4XRtHt8fJo6fBYt53+EkFl8uVgitiHOmhv0KsbbKTvt5bd2eKs
         SwXN5b7//OYVwLKnTkkyki1WI4OZZCXub+qwqkoi13+TA4LHcSlwJgRX8GOu7C5Vs5Hb
         WVGwNLClbztiwxICoa7zjY7DB/uCCb1BjKF2+CNi2/0QQO9YgWoQJkCR3eoZS3k8QJv8
         vQ1+ahcqcqjb19ScSp+93NZjC6NxphEvLQyZgy7/txX77gBBJs+hkM9o8IgPfvRpTAKb
         m6dA==
X-Gm-Message-State: APjAAAUlwuF+u9nsqAaEsWuJNH1ss3VxRUJsXuTlykpdBBTaKE/gL/Mn
        uImlNy59tEX6cDNNym9sBhlcUYQGWvWa68q8
X-Google-Smtp-Source: APXvYqwx5aZJRbj+tIBEdxjBkQP5HcOZu0OH7/NPHD8GVWrZs6FAocoNeNZ7r2esCdGiNjRri30MRA==
X-Received: by 2002:a63:e953:: with SMTP id q19mr2420825pgj.256.1576281213923;
        Fri, 13 Dec 2019 15:53:33 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:33 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com, szeder.dev@gmail.com
Subject: [RFC PATCH v2 14/14] ci: also run linux-gcc pipeline with python3.5 environment
Date:   Fri, 13 Dec 2019 15:52:48 -0800
Message-Id: <20191213235247.23660-16-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4.py includes support for python3, but this was not previously
validated in CI. Lets actually do that.

As of writing, python-3.5 has reached end-of-life, but has been updated
recently enough that it's reasonable to attemp to support it. We do not
have a pressing need for features only available in 3.6 and later.

Usage of python3 is limited to the linux-gcc pipeline on Azure. It is
assumed that passing both python2 and python3 tests on one platform
translates to doing the same on others.

Travis-CI is unchanged, as no tests are run in those environments.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---

There has been some desire to make this more generally applicable instead
of being Azure Pipelines specific.  There may be some significant work
required to make that work for all platforms where t98** tests are being run.

I most likely won't have the bandwith to take on that task in the near future.
If this patch is deemed insufficient, I would perfer it be dropped form the
series rather than become a roadblock.

Previous discussion thread here:
http://public-inbox.org/git/20191210103014.GF6527@szeder.dev/

 azure-pipelines.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index af2a5ea484..c473365812 100644
--- a/azure-pipelines.yml
+++ b/azure-pipelines.yml
@@ -331,7 +331,18 @@ jobs:
   displayName: linux-gcc
   condition: succeeded()
   pool: Hosted Ubuntu 1604
+  strategy:
+    matrix:
+      python27:
+        python.version: '2.7'
+      python35:
+        python.version: '3.5'
   steps:
+  - task: UsePythonVersion@0
+    inputs:
+      versionSpec: '$(python.version)'
+  - bash: |
+      echo "##vso[task.setvariable variable=python_path]$(which python)"
   - bash: |
        test "$GITFILESHAREPWD" = '$(gitfileshare.pwd)' || ci/mount-fileshare.sh //gitfileshare.file.core.windows.net/test-cache gitfileshare "$GITFILESHAREPWD" "$HOME/test-cache" || exit 1
 
-- 
2.21.0.windows.1

