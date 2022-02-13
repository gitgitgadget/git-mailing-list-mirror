Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 003B8C433EF
	for <git@archiver.kernel.org>; Sun, 13 Feb 2022 00:40:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232735AbiBMAkM (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 19:40:12 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232724AbiBMAkH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 19:40:07 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B409A60054
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:02 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id v12so21213481wrv.2
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 16:40:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=1rnONSHMUvxE7YK2UJ2Br18QguH0y2A+FDjiLUSsvRw=;
        b=nYrmNTV1xMyjv5/61HkHxoD2o/nt9DXJwUgLVKNvrkJo7lwoIQzVEMogyk2eLk9T04
         GTwE1tlbOhEGU6uMs9y9iIpWJ2jXRGxkagAPGNb4wMSGxuZ9Q5KI91vJeZeI0vVq1O1e
         R1xZDzny5LHgSFVBlcKkG+it92vif3NEZZ1/+XB+m/v8j7x3IVJcotMdC74vYp5nXGbB
         e1SlQdKlUGqcuLcmrZb9in56Sk8X4eq5PIQNszGqBYW2ZMl3pVv2zyx6wyNsqd5gthHr
         eef6l03CJa5TJhKgztRX/VSvpy9x/H6r5eqnvoYsKcxK++jIS0IkIsZTRDeA2Jpn9u62
         DrKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=1rnONSHMUvxE7YK2UJ2Br18QguH0y2A+FDjiLUSsvRw=;
        b=KEHYuxd3DCzLHnEFFEMoQAju4wWQi1hVu9N/+GgkT6aE61dfj+Zn8xqwBir5R4ddMj
         g4hbkVsYboc7nfuiinPI2cguCL9GiJLDk1QUw2SPKMEcP1MBc9q1UZnuV8dwSX6wEkEa
         7K8mh8K6on/Hj3R8Iw5wMl+bzXQQOqSRGJt8yFzzTg9MCfveXl3ZeZB+aN0R0POwACYu
         6AO4l8s65ydpDdJWJb2RTp3/d8mPfTwY8VQNYIVMsTJDHJpaysaK5fdn8Eb7ly2cGL+Z
         rhaVXiqtH1NXlfSyfRmpKEf4pfpqGBz5jOkKBGFU09YZ+hWIcbUpZAzvJUd4QQN8ZE1y
         mH8Q==
X-Gm-Message-State: AOAM533ABiozA0gdlq3lVDcztvDMRVek40VwdyZXi10Ye2xRgJa3dO+C
        VWtOniH0++PlVTGj2Obm1x9gXeqjkm8=
X-Google-Smtp-Source: ABdhPJyY/TwZwc9YZDfp0rCNdzX5u3HaNHhUIz9s6W+5YUHIlWtBz3wu2Gzu9bDwZRGIp3XCd4/LtQ==
X-Received: by 2002:a5d:6452:: with SMTP id d18mr6156301wrw.493.1644712801127;
        Sat, 12 Feb 2022 16:40:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bk5sm13253148wrb.10.2022.02.12.16.40.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 16:40:00 -0800 (PST)
Message-Id: <3bab59604046facb1e31ff1496e5bdb1afc7bf22.1644712798.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
References: <pull.1118.git.1644712797.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 13 Feb 2022 00:39:52 +0000
Subject: [PATCH 2/7] sparse-checkout: correctly set non-cone mode when
 expected
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Victoria Dye <vdye@github.com>, Derrick Stolee <stolee@gmail.com>,
        Lessley Dennington <lessleydennington@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

commit f2e3a218e8 ("sparse-checkout: enable `set` to initialize
sparse-checkout mode", 2021-12-14) made the `set` command able to
intialize sparse-checkout mode, but it also had to function when
sparse-checkout mode was already setup and the user just wanted to
change the sparsity paths.  So, if the user passed --cone or --no-cone,
then we should override the current setting, but if they didn't pass
either, we should use whatever the current cone mode setting is.

Unfortunately, there was a small error in the logic in that it would not
set the in-memory cone mode value (core_sparse_checkout_one) when
--no-cone was specified, but since it did set the config setting on
disk, any subsequent git invocation would correctly get non-cone mode.
As such, the error did not previously matter.  However, a sbusequent
commit will add some logic that depends on core_sparse_checkout_cone
being set to the correct mode, so make sure it is set consistently with
the config values we will be writing to disk.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/sparse-checkout.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 510cb89b544..8d595189ea3 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -399,6 +399,8 @@ static int update_modes(int *cone_mode, int *sparse_index)
 		core_sparse_checkout_cone = 1;
 	} else {
 		mode = MODE_ALL_PATTERNS;
+		if (record_mode)
+			core_sparse_checkout_cone = 0;
 	}
 	if (record_mode && set_config(mode))
 		return 1;
-- 
gitgitgadget

