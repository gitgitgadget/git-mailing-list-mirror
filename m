Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6D26C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 09:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232752AbiGUJF7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 05:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGUJF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 05:05:58 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D688B6
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:05:57 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 70so1205449pfx.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 02:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VOe7rN87LJPtdJaAl4/bg9TxAy3DGJ1d5aXWZR0mBVk=;
        b=WZa+VDzs13EZYreIbW18ZyPYRmPgP6GO32WwrOJkpqYB6wHU+6c93wFvjcse/ApvLg
         7vVIxi9Qd8L+oeU9Z9Ux9KvN5e9vQRAVqgme5dBEIAAqmALEfaMw5BNRENeUw/zmGa4L
         M1N2HIwzMNL2snGQQejrOS45TMigMFczr7H5glejBVcjISfpA1N9PE9gRSbEowe6+URn
         7bihWGgZSuIIOGcVUFmFTAVTrP7g/AhuXW6aATIqkiHG/zm0X438K8GUddb0ZlnbxgiR
         EPplkUUFDL/eNoE5UfZOYNypOT1GCcc8JiDpOQ7CeKUE7tfNmJU5iv+wVrWrkZp1QFsO
         oPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VOe7rN87LJPtdJaAl4/bg9TxAy3DGJ1d5aXWZR0mBVk=;
        b=q07AqHHTSaFNdkrUXR9PO4jvl2Pf6vnVU5aLGinXn3EqJ9m2oMRXBuQ1Pf5tpfxBS8
         yBVnmER/GloWvCAYzlwwsdQpJRTF10cUskYH+lMyu1SuKMjUAqlkpauRR4CchtQfKQ32
         U9/sdxvxYoY1huXWaBjOh2rUpYcfhZj9etkM9Uslrfoo0FWr0SIi9cE3ZkCv70XPWm+F
         lh7vtJwgk6xMt4WVPBzMZbhavAEvP71T4z9yZh2NhK/zDQSAn3ZVCziupBUDttnSK9r1
         ScqFwKZxFeXTn/CQS+oYoRmH8qfiNbCprf27r7jeyMPnlvxLB8mOw7scNhaY8sI8F6VQ
         f10A==
X-Gm-Message-State: AJIora+MZjCg/6TXRkgrgYqKs4KPpVaTA2fRRGTG9Ocy+pqZSTV8zzND
        35eXMaREM0VSOarzUX9RbOVlqShWCGE=
X-Google-Smtp-Source: AGRyM1teGJfw+hR3Ya2VQI+B1LVkS5VlRq1Ng9f5cHLOAI23WMqNT+dlT08yqNqCqxzhl03w6LdjGA==
X-Received: by 2002:a63:ba18:0:b0:412:afd5:1260 with SMTP id k24-20020a63ba18000000b00412afd51260mr38279565pgf.617.1658394356931;
        Thu, 21 Jul 2022 02:05:56 -0700 (PDT)
Received: from localhost.localdomain ([205.204.117.102])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090322ca00b0016c9e5f291bsm1127291plg.111.2022.07.21.02.05.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Jul 2022 02:05:56 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@tenglongtldeMacBook-Pro.local>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@jeffhostetler.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        tenglong.tl@alibaba-inc.com
Subject: [PATCH v8 0/6] pack-bitmap.c: optimize error messages
Date:   Thu, 21 Jul 2022 17:05:42 +0800
Message-Id: <cover.1658393855.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.679.gc613175da2
In-Reply-To: <cover.1658159745.git.dyroneteng@gmail.com>
References: <cover.1658159745.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Teng Long <dyroneteng@gmail.com>

Changes since v7:

Remove [7/7] and will move to another separate topic.

Thanks.

Teng Long (6):
  pack-bitmap.c: fix formatting of error messages
  pack-bitmap.c: mark more strings for translations
  pack-bitmap.c: rename "idx_name" to "bitmap_name"
  pack-bitmap.c: do not ignore error when opening a bitmap file
  pack-bitmap.c: using error() instead of silently returning -1
  pack-bitmap.c: continue looping when first MIDX bitmap is found

 pack-bitmap.c | 103 ++++++++++++++++++++++++++++----------------------
 1 file changed, 58 insertions(+), 45 deletions(-)

Range-diff against v7:
1:  a01ae8478d < -:  ---------- tr2: dump names if config exist in multiple scopes
-:  ---------- > 1:  7426b277ba pack-bitmap.c: fix formatting of error messages
-:  ---------- > 2:  4e493426a0 pack-bitmap.c: mark more strings for translations
-:  ---------- > 3:  263f45ba96 pack-bitmap.c: rename "idx_name" to "bitmap_name"
-:  ---------- > 4:  d11ea092d5 pack-bitmap.c: do not ignore error when opening a bitmap file
-:  ---------- > 5:  f60efe78d6 pack-bitmap.c: using error() instead of silently returning -1
-:  ---------- > 6:  83090308ad pack-bitmap.c: continue looping when first MIDX bitmap is found
-- 
2.35.0.rc0.679.gc613175da2

