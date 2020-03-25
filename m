Return-Path: <SRS0=ys1m=5K=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4083AC54FD0
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D3FC2078E
	for <git@archiver.kernel.org>; Wed, 25 Mar 2020 05:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rzCuA0II"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726086AbgCYFl0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Mar 2020 01:41:26 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:34364 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725832AbgCYFlZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Mar 2020 01:41:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id 65so1389646wrl.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 22:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XejBwmKcpOLGg4tlOd3xM3V6oczpPbgAOGYHVCwcIlM=;
        b=rzCuA0IIATfP2apPIdeywzxCc4f/ohy8OMYCn/oVlDjqHpJORk6LIthJSNqcWRZbll
         HjEDpxawrSNOFbgsfKL5CD98suyqZCwjx6QusBHVbUDAKDKTzmmeheKzjf+GXtOEjqcS
         embHk0WASJpCNgk0VxXChCqIWJNl3FTkWRWOY9v2FjGK004l0caX3xPBIbf8B92c0PuO
         6RBB/+tG4O2uU+EqIpXKtToM6s0/rcJVTlGKLm9s5pesImjyY3x1bSC57qgoZ7bLE371
         2Z6vT3caR6/l7A/OmmVvZV9igYLhhc8/aGlwOD4vEUe/FBIBOCwqv9pM55sPgK8n+V04
         WFFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XejBwmKcpOLGg4tlOd3xM3V6oczpPbgAOGYHVCwcIlM=;
        b=UKXKaACDK+RSlEsgJ93tliWzmhup5MOLvnzfWR/FINBYpdLgPgi0JYJLCJxbWtqJ0o
         oaarvydjoeYrgo/0PpDzv0jv6joBS72YcJaxVfN9QjVFy9PrWYjfCB0DWNNq6Nn/v6eL
         Pfq2Z/rD6tp7yXesJ2dRoGfgXUhu7Cxcy4K8hXWkHpntL9t3W4oajLhvWRdeND5Lt25K
         aAq1HhhqRWt0Je4tirrFiM7m/rvRdBB3R336Q8xQa4Z1L3e8dNXEX3wSiGcwik+fqlhF
         sLsaRuOnX/zwjUENJ+ZZiLPw8o+AYpA9ogjdcwx4BAGqtk5IFB8+B9DuLTnvaI3lS2Es
         SbVA==
X-Gm-Message-State: ANhLgQ064JeWDBEp2DfhIxpClxleRlMj3iZVac8LuaC+2/r8Xt34WZuu
        5Hyvvzx2PMzdSFhtXnPz/pH9RR+2
X-Google-Smtp-Source: ADFU+vvO6uFZ4H9w3J5MdbKrZl6BDL90FScfV5xGc7a8PMJGKcGQ1G6XlUyDAxr86hF2TVZQuMGhdA==
X-Received: by 2002:adf:efcd:: with SMTP id i13mr1360114wrp.355.1585114884044;
        Tue, 24 Mar 2020 22:41:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5sm1698883wrr.47.2020.03.24.22.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 22:41:23 -0700 (PDT)
Message-Id: <c1811d54190a62e3d35505e2b806c89238b56de8.1585114881.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
        <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Mar 2020 05:41:18 +0000
Subject: [PATCH v2 2/5] t/lib-gpg.sh: stop pretending to be a stand-alone
 script
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It makes no sense to call `./lib-gpg.sh`. Therefore the hash-bang line
is unnecessary.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 2 --
 1 file changed, 2 deletions(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 11b83b8c24a..4ead1268351 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -1,5 +1,3 @@
-#!/bin/sh
-
 gpg_version=$(gpg --version 2>&1)
 if test $? != 127
 then
-- 
gitgitgadget

