Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3DD9C433E4
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 928EE207D3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 14:24:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RO7hsi/+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726845AbgHROX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 10:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726731AbgHROX1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 10:23:27 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72577C06134B
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:22 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g75so17174586wme.4
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 07:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CnLjXOJlzWTb8DhmLa2BUbqj9NUjX6DalUVKu7VYcx0=;
        b=RO7hsi/+uwvX1SZDrRSBsGLEkjDvl1BvXnqWRRC8o0213u8qkTyOUp0kU75d+sy4It
         rEhfhgwLX2iWqaPZ1cMx5JCsM0mImhALoRybb4KnM8JUUEwyyt+YLln9iMZeB4XI28FQ
         mIvIYa4N2Eyc9oVisVpREFbh9Bd0opxtE3dRxrOjqSQGEuqBg/Hl6tfuGC8lWeQFjW7q
         a9ywV6iNhmXN8KfZ8EXc6WEQ3RKXNK22LlNsl/NAfFjuf8YxXd+3qn3MCxxdSqJQuFM+
         CbP3WtnOJbCTZsQqVn1s15vHmnnjAO1U8qL3YPccApcwYuwtbMg3/ire/hSZpDQm+b0d
         NuWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CnLjXOJlzWTb8DhmLa2BUbqj9NUjX6DalUVKu7VYcx0=;
        b=UnDIeKht66MbwYsFFLxkUPt8ZiLNfDuAvjqipg1eVM62beLJhY4Huq+np8OStyLIP/
         QxvfvZUFOqLQhukhvAylj/30qhZZD2wuUiddvrrl2gGTeG2Gxyzlj0UyI0gPyHd6AY8h
         AwpNOQdvXWDp/saNYRY53TT0xTbjGaipyJQ2/Pu1ocwHesNR4NGW9nQkb6/zP8Hb/fee
         PA1wrfq1DI8zo0V2d2WFMZHcwjjIFimGi+5xp534SVLJbO03tJ0FRkCgRrN5Y82oO0Hj
         PlemeLOscJZdf71w/VvDzz16t62a24YhA3sI/AEFKNoL1Oo8mvTKE/EXuIwBy4c/SX5t
         XHTw==
X-Gm-Message-State: AOAM531xVoMyQuX6YJ3bAjXDTbFCRZ+C/fy5RGWzmH1PKGjnd86SOHjv
        UCLjr54ieOz8LdhcQyOnBYNXvpubtaw=
X-Google-Smtp-Source: ABdhPJwrV46J7wv8qHoKUUF3WdvlPixKXUNVDb9Su3kNLPLxFdgCJXXQ/aJ8iPHqMxomBFefBDPCIg==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr158168wmb.57.1597760600846;
        Tue, 18 Aug 2020 07:23:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w132sm126175wma.32.2020.08.18.07.23.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 07:23:20 -0700 (PDT)
Message-Id: <46fbe161aa154de9406117ee916b1bd5f549905c.1597760589.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
        <pull.695.v2.git.1597760589.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 14:23:08 +0000
Subject: [PATCH v2 11/11] maintenance: add trace2 regions for task execution
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
index 73e485bfc0..3fdb08655c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -953,10 +953,12 @@ static int maintenance_run(struct maintenance_opts *opts)
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
