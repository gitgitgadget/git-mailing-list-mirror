Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3959DC432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EC07120880
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 01:29:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="RPvaZ0Wh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727176AbfK1B3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 20:29:03 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:37070 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727088AbfK1B3D (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 20:29:03 -0500
Received: by mail-pl1-f193.google.com with SMTP id bb5so10810997plb.4
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 17:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1bz03o7XITNB/GLOtm5mw+EOiU5ulw05JqkSmsoKRg=;
        b=RPvaZ0WhS6/7gTXgkOim7YOSlEXWGPXVQ0JNblx7+yLG+ZKry9CvHnwx2uqz99noGu
         Yptai6pBFAfKljIZcBedgH8AKgUHvGREmskum1UUfPrChzG4e83ajG9Nl662qG0BsBPb
         kgx9gtmv6Dli2ZFrcNUY5GW4WH4Z34CtrOjf2SF2mFs8TM9q9B7vzPToxHrPHg5teDpC
         Sv490LFe0gpGIYIemq4t93wyFRdoNxitXGmvYJIrf4gOxnZkmQc+nc6c/+YJQ8jUNDOH
         BwZfilQiZ7NALzJ6tAvkeineHhS162M03T3hjTkyurU6NVqA4MMkINtFIr2q1RBPW6eA
         1nYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=j1bz03o7XITNB/GLOtm5mw+EOiU5ulw05JqkSmsoKRg=;
        b=tzGP/Zw3a6HI/DaFSD8V9Fr64wnWwK2mTBcgLMoCnf6LK0NIvRTCqOHnV9jWZiHwGC
         DKkIrWl1bLYSf1g6/7Lby11RR+ZRryCuKw9QLKWktSQpHVR90sj+FBonigxaqArSceEE
         IxZdxEiS3YQSkiaquRvjyw4RzpafUhIp22KuPuucTjlADQPYaR5gFNtm9KqI6y2xjSUo
         V15pDEN5Vm3C6Z4kfLdlfqUTGybQKnKzfoULqt/NQ2Y3qPhE0ZQqpgDSXnOjUkXmOqPD
         4B2IeW0IZAQ2mDA9BiHntQBEn8ugl3wXHUSM3zwhaSsPQ/AXJZNSdqqyQhjiEzdVi9LJ
         dhWQ==
X-Gm-Message-State: APjAAAVmKJ5oDW0V9GMMz+ncIq3AkwXlu0QWB2b4YOUO5TV7aLuiwURT
        xvxbFfdfXL7pcQnmWUU96a80N0xrkedbNg==
X-Google-Smtp-Source: APXvYqwuar3EOVjvireEFR1y9qJUSw1yfjDdfia5IgVMBkOk2m5728Z8qi22ZJzjFfh0g65EKyKrcA==
X-Received: by 2002:a17:90a:bc41:: with SMTP id t1mr9874935pjv.89.1574904542454;
        Wed, 27 Nov 2019 17:29:02 -0800 (PST)
Received: from SBL-PC-YZHAO.skyboxlabs.local ([184.67.13.114])
        by smtp.gmail.com with ESMTPSA id w15sm17507215pfn.13.2019.11.27.17.29.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Nov 2019 17:29:01 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [RFC PATCH 0/4] git-p4: python 3 compatability
Date:   Wed, 27 Nov 2019 17:28:03 -0800
Message-Id: <20191128012807.3103-1-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patchset the necessary changes to have git-p4 run under python 3.

I'm submitting this as an RFC as the changes are not exhaustive. I do not have
p4d available, and therefore cannot run the tests locally. I have made
best-effort attempts to test the changes against a repo I do have read access to.

Yang Zhao (4):
  git-p4: decode response from p4 to str for python3
  git-p4: properly encode/decode communication with git for python 3
  git-p4: open .gitp4-usercache.txt in text mode
  git-p4: use utf-8 encoding for file paths throughout

 git-p4.py | 58 +++++++++++++++++++++++++++++++++++++++----------------
 1 file changed, 41 insertions(+), 17 deletions(-)

-- 
2.24.0.windows.2

