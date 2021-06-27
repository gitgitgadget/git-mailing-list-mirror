Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C318C49EB7
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1901261AC0
	for <git@archiver.kernel.org>; Sun, 27 Jun 2021 12:36:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbhF0Mii (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Jun 2021 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbhF0MiY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jun 2021 08:38:24 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E39EC061574
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id r8so3269702wrx.5
        for <git@vger.kernel.org>; Sun, 27 Jun 2021 05:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r7Z6d5ifsh1v6IjHQmKUm8lmxTGmT95I9U09SdFQEqM=;
        b=u+X9qq33M2bM0CkNLgkpPjcquWjaqAnSyKLVrNGjdwfsyj+qC/CpdeyB8nxfK/JdgU
         0nmSfpgVu+DUFeM1B5EzJkj8sjlx8+BJvgXICWdP+TCJSfA2lnqKpiOuU8RDvfcKWen8
         3dBVxTgInyxIw6qerWefAaZUpkcTqFgDWNTtTqy1UVh0VK1zrs8lx/dIdERLmrolM8Rb
         BZxxyNk8DnWKGh0TKGJiovwiTsAOIazQkqJbwGWANYkCTlOnLYvFz0Ytc/3B9CcIZCyz
         Zxz4kAsjSg+m/ZKw5dfMrqd3RKEdXegP041hXmkzdVfVf9LOWg12Tn85OXpOVNI7dI+x
         yoxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=r7Z6d5ifsh1v6IjHQmKUm8lmxTGmT95I9U09SdFQEqM=;
        b=m/Nq3saaf3Q7w/22MxYCFHtFfecAnesBhfUtZwJc8X5F8H0qA+8aBzzdOr8FIVcOo3
         V4WzJq+DuQnVi7AwFmaaC1f4/PxmvXYhA4Ze6+C9TsyqX+yxiOZEcRBop8VR1lLS3QZI
         fnLMHnygGNH0n2Aff3QJejDZ1gIG2CNmxEeYZu0r6cR77i3yqyf9Y61sRvXDKWrCrgPv
         CY+maPPoOsmACJl1997L0IJ6A2EEH01Ud9sXJDXrcJ3Ai7Y8kBJfAvrcFjn6/a2fFEUq
         Dp+tGYS0Jg3bAauRAQ/WdS7TQCi2fWsWBLJrvL5CPWvA8m6cimm5zEM8JhAcxEi0R2Bc
         mH7g==
X-Gm-Message-State: AOAM5333HiCRgaJITczaXjO1JPRo4O34nHUPhsjzsFJ9eXlX1eGmPIRq
        LJK6io0yj16SSwECprrNBntIs3B3j1s=
X-Google-Smtp-Source: ABdhPJzF4JV/x8tJsLVszijMpSgxEwyYEU5YRIZJfKwVuLpLemSXd5glVcDNSxCHYvb8Nce5VE92GA==
X-Received: by 2002:adf:e384:: with SMTP id e4mr5591549wrm.317.1624797358332;
        Sun, 27 Jun 2021 05:35:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t11sm11389625wrz.7.2021.06.27.05.35.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Jun 2021 05:35:58 -0700 (PDT)
Message-Id: <6037295ee58b9bfb5020f26776728fd12b9fbece.1624797351.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
References: <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
        <pull.980.v6.git.1624797350.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 27 Jun 2021 12:35:45 +0000
Subject: [PATCH v6 10/15] [GSOC] cat-file: add has_object_file() check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

Use `has_object_file()` in `batch_one_object()` to check
whether the input object exists. This can help us reject
the missing oid when we let `cat-file --batch` use ref-filter
logic later.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
 builtin/cat-file.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 5ebf13359e8..9fd3c04ff20 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -428,6 +428,13 @@ static void batch_one_object(const char *obj_name,
 		return;
 	}
 
+	if (!has_object_file(&data->oid)) {
+		printf("%s missing\n",
+		       obj_name ? obj_name : oid_to_hex(&data->oid));
+		fflush(stdout);
+		return;
+	}
+
 	batch_object_write(obj_name, scratch, opt, data);
 }
 
-- 
gitgitgadget

