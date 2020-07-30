Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F615C433E5
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4232083B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 22:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RnuJHuXg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730543AbgG3WZD (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 18:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730486AbgG3WY6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 18:24:58 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A5C061574
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:57 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f18so26297401wrs.0
        for <git@vger.kernel.org>; Thu, 30 Jul 2020 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jx8IG9PgjEZR5kIR5xlj7FzwV3s6UaKdizKrQv/+zQ8=;
        b=RnuJHuXgo1SQxt3yo9hzbMO8FQVMnXZYt2IrGiIb/SYSHaaIGlLDRq5njFM352l+J7
         Yt0KwaJObijUlbOM7yw+BHH5Eedzy+3vaII9nnXo+jtd5q9sk975t3HMlU8vd4XQKdgl
         RJkEbSMgOvVElKN4657yqR8qxLuuzUzD0ZFbL2jVvW6vNeQyYnKboxsiOWUJh5S0rc1+
         qOxF7Gh3SRv0mhWeUCb3g6znSeMGVFVb7oyEHNVXUcA6w3+LjQNq7SCScOdIsvCO0HqV
         jkcKRBbicw3BGlqA0t+2OABs5rXtWIBKPQxxtrNoZWHJ/MbcVce2DE+zrt50QyK3bgU6
         4O/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jx8IG9PgjEZR5kIR5xlj7FzwV3s6UaKdizKrQv/+zQ8=;
        b=Zqg+V7+6zVeHZEQ3TDWLs05MFjrYrzTd/j07gTnPiLAnIYcoL+t421OW6L5y5FZ9VF
         HnLHlW+RwK3fHa7epoZbvyqE0oFMv3YiDqD7hkoYdDSHPll/W1uhpG4CtW1dmVbHCLaT
         EFMFBFokjaosev/dGl8tbva2Ha1iFEBatJ4HOJYbqLF6Gy5TxQ6UETmf0D0r0t6e8gVa
         jOyCuZf7lT23P82UQmT//B+jNVpDnjkLeiwUcHs+23rlS2Bwf+5HhgFtcd6zQNiPzBcw
         OANZNT4AS8d00dp0jS8NJgcBlsGxAhzH0E7cM5vbQk3Bb+ITDatNZHIL9IhuYJucO1xs
         LklQ==
X-Gm-Message-State: AOAM531smnKIyQr6hN+Xy9/4Kzk+GJ0M7XnFOYnqHmgCGR7MwzcFNnYq
        GfB4Nzuf/97VrTIYhuPqHLEm32Md
X-Google-Smtp-Source: ABdhPJxQxIGx22PP+8khgwDq4HPMi5i/Ay7mGXhqI+uMMdtvaixYlovuycQcS7Fii4k1Nzpo/uTUqg==
X-Received: by 2002:adf:de8d:: with SMTP id w13mr675013wrl.129.1596147896493;
        Thu, 30 Jul 2020 15:24:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a134sm12087309wmd.17.2020.07.30.15.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2020 15:24:56 -0700 (PDT)
Message-Id: <39eb83ad1efe4dc521f5fc3838f47c7cdb507fc7.1596147867.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
References: <pull.671.v2.git.1595527000.gitgitgadget@gmail.com>
        <pull.671.v3.git.1596147867.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Jul 2020 22:24:26 +0000
Subject: [PATCH v3 20/20] maintenance: add trace2 regions for task execution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, sandals@crustytoothpaste.net,
        steadmon@google.com, jrnieder@gmail.com, peff@peff.net,
        congdanhqx@gmail.com, phillip.wood123@gmail.com,
        emilyshaffer@google.com, sluongng@gmail.com,
        jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/gc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 6ccc0cca19..33e889bc71 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1312,10 +1312,12 @@ static int maintenance_run(void)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		trace2_region_enter("maintenance", tasks[i].name, r);
 		if (tasks[i].fn()) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
 		}
+		trace2_region_leave("maintenance", tasks[i].name, r);
 	}
 
 	rollback_lock_file(&lk);
-- 
gitgitgadget
