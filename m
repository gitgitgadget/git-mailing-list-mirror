Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46DA8C2D0C2
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0AF75205ED
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 00:34:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="MIlkw5xm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbfLGAd6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Dec 2019 19:33:58 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35836 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726642AbfLGAd5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Dec 2019 19:33:57 -0500
Received: by mail-pf1-f194.google.com with SMTP id b19so4202144pfo.2
        for <git@vger.kernel.org>; Fri, 06 Dec 2019 16:33:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqltTGL002GBLQBDqp/dy8Ld/1ou8CKL0hBJ5HgFgtY=;
        b=MIlkw5xmgDgKVHdkbHA1UFrXU5278nH0jwB8J5uZjMykGXIQn5wo9zWhyxVCUpCBX0
         BRreDcyf1qWofIfBJ8WCiCXsp2QlhILMj4Omhdwtalj0fvkPHnrdoU1Ddvti4PtkhMJt
         1vXlyKScxDtKPUn6FS3n7hm4GIsdguDBNX9x5e7TXKZgf292As2s1jnXMVnFxZwnXSPN
         AqzMG+uqgPcnvYQBnvWyaPL2mU+icFlIiegcK7Prug2ykfYKMBZ7SH9Ptz4Znb1mgHJC
         NNho9+7ugyDYflSPuZ6GMtLljLP+pINBTPI5SpgWZZe4xDvbgFWQVfi+iTx/87hHMvXN
         Eozg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqltTGL002GBLQBDqp/dy8Ld/1ou8CKL0hBJ5HgFgtY=;
        b=BB2Zsn5Gp6IfTF/FUlHayLbHOYckTFmVeATgDrf3j+L2DzMWuksti2YnKjX/CUyRiK
         32CYk14OrRoBzCUFuc5lzDNBgR3Rax/527fu3fuHyCV4+cm3TmBg4YGF05Rrl0CNDnaL
         irHWIwBqmQBjh3PTqtejXwXXUeanMEqvt1oL1FNwh2HnfropAZ7KgKpLwH/CK+QpWWOB
         gAjrM3kzeJoM4HjToVX907MipAOIRil1aKzXi1qHoPrJC42e5+x+HamKQXZa8dzz9law
         qleFPb9kB5j7suvR/tY9l8PU18JNLtxv86xvmnO0hA5f19Kcyp7VLirAjlYd4sHhGt/B
         9xpg==
X-Gm-Message-State: APjAAAX3AJlXE2vOJesfYW2rXW6W+Qi45Y2q9GuX/Nk2IqJjBuu9a4aq
        8aPRzXTstw1Q+RZsEMXtmigVLESbmx3ftQ==
X-Google-Smtp-Source: APXvYqxzXGISeQxlVwCG2suVF8J0GDUDgnlxOvCz2lBG86JF18uG18oRbS5OkAJuxif/zNZq06MyUQ==
X-Received: by 2002:aa7:85d8:: with SMTP id z24mr18046547pfn.202.1575678836812;
        Fri, 06 Dec 2019 16:33:56 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id b21sm18708949pfp.0.2019.12.06.16.33.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 06 Dec 2019 16:33:56 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>
Subject: [PATCH 09/13] git-p4: fix freezing while waiting for fast-import progress
Date:   Fri,  6 Dec 2019 16:33:29 -0800
Message-Id: <20191207003333.3228-12-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
References: <20191207003333.3228-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of its importing process, git-p4 sends a `checkpoint` followed
immediately by `progress` to fast-import in to force synchronization.
Due to buffering, it is possible for the `progress` command to not be
flushed before git-p4 proceeds to wait for the corresponding response.
This causes the script to freeze completely, and is consistently
observable at least on python-3.6.9.

Make sure this command sequence is completely flushed before waiting.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
---
 git-p4.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-p4.py b/git-p4.py
index c2a3de59e7..1007b936c8 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2659,6 +2659,7 @@ def __init__(self):
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
+        self.gitStream.flush()
         out = self.gitOutput.readline()
         if self.verbose:
             print("checkpoint finished: " + out)
-- 
2.21.0.windows.1

