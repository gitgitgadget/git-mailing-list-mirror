Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97606C43603
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7AE80206EE
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 23:53:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=skyboxlabs-com.20150623.gappssmtp.com header.i=@skyboxlabs-com.20150623.gappssmtp.com header.b="XP1tkT/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726590AbfLMXxc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 18:53:32 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:35406 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbfLMXxa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 18:53:30 -0500
Received: by mail-pl1-f193.google.com with SMTP id s10so1897314plp.2
        for <git@vger.kernel.org>; Fri, 13 Dec 2019 15:53:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skyboxlabs-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oF6M98V6kq+d3Xs7wzwAw78C3NoRnbRxgo7xe43Its8=;
        b=XP1tkT/+DZdFuBj5Ptmob4oBWKPo9eb1VzyRLxuQjScS/IV5AgG5Q1vWpaOgFjk37p
         ChuyTK4HK0AxuBI1hkVkOvIKtlE4tD4WdW0UCDjykuUc/Jbr7IAmY8LCNpZFbeRm/2+O
         FgGY2Cl6v7FTRmjtBUEOSnTDF4p8vu4FH38xRJc7xA49QOXFDEgI4alNJDJ47PyyC99f
         VfHpXan/1rf1VkDzcV8SeIikjCYc7I2ha8H9PLjgJfiqLLe2Ls3XQVDOxj7HAVndt1Q5
         J3ca8co34e9Mg6E5x+YT/d3KT1RA9zVRbEC3ere9zFJkV+BcU1sdsmu2yIkYeXvQu7Mj
         7JsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oF6M98V6kq+d3Xs7wzwAw78C3NoRnbRxgo7xe43Its8=;
        b=HPTxA3A1zktrUWhWN2MD7ScQsAII2bD7W2WV0Ff+YJqDIYNXmnfHibMg8kn06Embb3
         /Mc2QCbKcUkCb3DmKR4HeN7+9f3ff5cP3f83nWqc2tSegxShhM+0bldvPkbzqn2dBtfH
         cCapee6rffKYW9moAF4lXel0EMY5kGH7pR4SUof9uuhKfGIdFHRZu/LQlpcoTcHh7eCd
         4TGzVoqJH7iBnck9B1jmYYyOmG8UyBTP5Qr0pa0RmjeGAdHS/DUejbPnxdfrJErHzGxf
         Dz3qa1uoZlsYlteWcZtx3kW9awqHaL0pAz62Kup/X++Y1wE+Z1uzUC0KPAkijdFb4zlq
         tb0Q==
X-Gm-Message-State: APjAAAVEA9Bc+O+O7Ii2Bv/0O+kL/TZR7E15w+p6wkfnN31XA7zZSMCW
        2bY9Gidenac6qD00gYCkm42Hd7lXpblrGoNy
X-Google-Smtp-Source: APXvYqxinHrmsLlOnJq328moY4jN09nAelqI8yQT903oauzti/unURHFthizZfrKUbGIWDoDmaQpNg==
X-Received: by 2002:a62:4e4e:: with SMTP id c75mr2432523pfb.144.1576281208808;
        Fri, 13 Dec 2019 15:53:28 -0800 (PST)
Received: from SBL-LP-YZHAO.skyboxlabs.local (d173-180-108-168.bchsia.telus.net. [173.180.108.168])
        by smtp.gmail.com with ESMTPSA id r2sm11926036pgv.16.2019.12.13.15.53.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Dec 2019 15:53:28 -0800 (PST)
From:   Yang Zhao <yang.zhao@skyboxlabs.com>
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>, luke@diamand.org,
        liu.denton@gmail.com, seraphire@gmail.com
Subject: [PATCH v2 09/14] git-p4: fix freezing while waiting for fast-import progress
Date:   Fri, 13 Dec 2019 15:52:43 -0800
Message-Id: <20191213235247.23660-11-yang.zhao@skyboxlabs.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
References: <20191213235247.23660-1-yang.zhao@skyboxlabs.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As part of its importing process, git-p4 sends a `checkpoint` followed
immediately by `progress` to fast-import to force synchronization.
Due to buffering, it is possible for the `progress` command to not be
flushed before git-p4 begins to wait for the corresponding response.
This causes the script to freeze completely, and is consistently
observable at least on python-3.6.9.

Make sure this command sequence is completely flushed before waiting.

Signed-off-by: Yang Zhao <yang.zhao@skyboxlabs.com>
Reviewed-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-p4.py b/git-p4.py
index c7170c9ae6..68f9f4fdc6 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2641,6 +2641,7 @@ def __init__(self):
     def checkpoint(self):
         self.gitStream.write("checkpoint\n\n")
         self.gitStream.write("progress checkpoint\n\n")
+        self.gitStream.flush()
         out = self.gitOutput.readline()
         if self.verbose:
             print("checkpoint finished: " + out)
-- 
2.21.0.windows.1

