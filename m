Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D56FC2BD09
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 012A72245C
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:33:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="ruiNDs87"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbfLGAdr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:47 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36308 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726388AbfLGAdq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:46 -0500
Received: by mail-pl1-f193.google.com with SMTP id k20so3409528pls.3
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vbE+YDAzXoZ3rSFqVfVwZCsgRh7R2WBbV1iIGX0bo+c=;
        b=ruiNDs87aEngud/Lo4tZ2ajUet3h0pUt617apr8tpqt/I4kkkxZzjs1SyFdj900jrU
         g5TfgFP4CWK0uElF4zXrQoYxXNXJqhzXxA1Ku1L2Dq5NmhjkljWK8owR6PGHA8nqPuNY
         4LR2Nas0djAtSIbxQDxdYu0DLR74Ry7spNoqz+gRgkorhDOJpqetQNsf7n2Aq65OtCOw
         i2LOY2oM1Li2cjOZe7Nf3PNiiHHli//lFHWOBg6Um0TtRiurB/imQeJllwXpQhkQWwSc
         GCsAG3aYICSzw9jq0ThRjH7v/Llon4RFJqfrQOohifZWs3mUfeDf9bou9z43j9N2TF9Y
         2lAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vbE+YDAzXoZ3rSFqVfVwZCsgRh7R2WBbV1iIGX0bo+c=;
        b=ZQHHwF/fNJW8dUsFLk0wQvzeTFAtv9yil944Cg458VBnKJKcRR+YUW0i9N1d0SlKEF
         2e831YoZ+fWQIJP31sF4ieXEm8zzjN123QQOEMR70RmTahYkuo5mKAzCCCiFVdrvVSwg
         BIXQ4kQlA7D7J6v9C5ZrEJ+oJX40rGf32CyQcJBDfod8+HkUfPiNizykxNhqGZd3uP7r
         HsHTg4+5ThmIe+jx9Icc+8HdfkdACWxfEZq+609DeoY/OvnWLt6RG65oJGlrSwnMeK7C
         UJDxkHPiUb1yZuMEn0XYxRTvmgP/hBlGQXTff+y9QIacr8gxunMXzTGHAr3wIcVRNN3K
         9w1A==
X-Gm-Message-State: APjAAAVw1fS2J9GEpp4D/5fXPphWCDeSt7KLS7cky+WHwCeYQ0mL6MG1
        mhD4V6K3G9izktAjU0P+CV1rrrsfOpFGrw==
X-Google-Smtp-Source: APXvYqx89y9MBhacuTs4uzj9eQkc4oCukeiiy8CrKuFmvkRyoCBZsahz4CLCfiI9jtyHzOSInH1d0Q==
X-Received: by 2002:a17:90a:8a98:: with SMTP id x24mr19408084pjn.113.1575678825429;
        Fri, 06 Dec 2019 16:33:45 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:44 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 01/13] ci: also run linux-gcc pipeline with python-3.7 environment
Date:   Fri,  6 Dec 2019 16:33:19 -0800
Message-Id: <20191207003333.3228-2-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4.py includes support for python-3, but this was not previously
validated in CI. Lets actually do that.

There is no tangible benefit to repeating python-3 tests for all
environments, so only limit it to linux-gcc for now.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---

I assert that we don't need to run python3 tests on more platforms,
but is this actually reasonable?

 azure-pipelines.yml | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/azure-pipelines.yml b/azure-pipelines.yml
index 37ed7e06c6..d5f9413248 100644
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
+      python37:
+        python.version: '3.7'
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

