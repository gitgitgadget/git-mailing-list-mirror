Return-Path: <SRS0=G1/z=CD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BA30C433E1
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D2F32074D
	for <git@archiver.kernel.org>; Tue, 25 Aug 2020 18:34:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGKnO3OW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgHYSed (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Aug 2020 14:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726541AbgHYSeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Aug 2020 14:34:00 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10458C061795
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:34:00 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id p17so8155322wrj.8
        for <git@vger.kernel.org>; Tue, 25 Aug 2020 11:33:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=3BP+V47fkAW0XOrc+qRv9CzrUpLDeEi54vnAws/gvxo=;
        b=cGKnO3OWGxDmGFVmOOclzON5s9MChrvgP1DIL/G+xcCu9vjMv9v/XX0I0ZDQtjllc/
         m/BPfDEr84EQQu3nomvQAvSq7GJkhKbdSdkRHElXoqcPhgEPf+ueEY5g/TQV/uoLMXTe
         +EinptKagd5tm/IpOyFjzJ3AYZax4pDj9FgzfsNPQo7m4gQSqXJjOwETNZkLcXFApX5V
         WihvqpphjujzlHDcnOg51Jq2hzHYjUd2EjNRyNEj7k9hKoRf39LUnA4Jf68iBjErsmI5
         4058PkDl3hZ9gBjp4pjf0HizhOqe2yeiT1gj/mA4GVnp3SPsBKUNgFFmBKrlWqWWj+bZ
         6lEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=3BP+V47fkAW0XOrc+qRv9CzrUpLDeEi54vnAws/gvxo=;
        b=UsODAy317HcKgYMkfjmXB8s9iJU2UogFyM+yS2ULlmR1AZhG/peHs+CZQsJkzDgCjU
         4zsgfemUlRdS8228wFRl6wngvxd2dDKyFpWqMDN03s5zfSctFPTrIZ0nvB6RyCFCLKqF
         oz/K3a9FVrFSaZdLWLclt3uDjN2//qH9074Kww9XHIdtRtjLrAtNL/dPHW6Bhf4a00K9
         bnc2j1/9ohx5+rrh9m+m3Y28fKSgXLJaxjKINUnFA18hiU1xWkrG4ZafNyhIJCPDEjxB
         JBFxt6FDY5YlXr2EhlbxcnUnD48T6bSI3uQSP8EEqaH/7P/JP2KtQgAOLd6eR7XhQjyI
         zMKA==
X-Gm-Message-State: AOAM533dxW2/xFAL1/+CDRbY1ozx9xSpADs3SX1PMn/sHOiNgk9mMeKK
        bqW/x458oGIZEcqP6NsgR4RVkHrlF2s=
X-Google-Smtp-Source: ABdhPJyTqUZQuZtFNElpR/NtbK3UPLyvBezBimQE//2KA5dnLIgouv+V2wh0mkcEefJW/dVepkklyQ==
X-Received: by 2002:adf:e90f:: with SMTP id f15mr11684090wrm.310.1598380438676;
        Tue, 25 Aug 2020 11:33:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f3sm7355228wmb.35.2020.08.25.11.33.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 11:33:58 -0700 (PDT)
Message-Id: <652a8eac57d04a51820c7a5b45031b50c5188e7b.1598380427.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
References: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
        <pull.695.v3.git.1598380426.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 25 Aug 2020 18:33:46 +0000
Subject: [PATCH v3 11/11] maintenance: add trace2 regions for task execution
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, steadmon@google.com,
        jrnieder@gmail.com, peff@peff.net, congdanhqx@gmail.com,
        phillip.wood123@gmail.com, emilyshaffer@google.com,
        sluongng@gmail.com, jonathantanmy@google.com,
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
index 8c4edf19ba..c3bcdc1167 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -927,10 +927,12 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts)
 		     !tasks[i].auto_condition()))
 			continue;
 
+		trace2_region_enter("maintenance", tasks[i].name, r);
 		if (tasks[i].fn(opts)) {
 			error(_("task '%s' failed"), tasks[i].name);
 			result = 1;
 		}
+		trace2_region_leave("maintenance", tasks[i].name, r);
 	}
 
 	rollback_lock_file(&lk);
-- 
gitgitgadget
