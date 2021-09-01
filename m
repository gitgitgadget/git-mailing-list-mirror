Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F396C4320E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E44961026
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 11:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243936AbhIAL6U (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 07:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243923AbhIAL6Q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 07:58:16 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8525C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 04:57:19 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id u15-20020a05600c19cf00b002f6445b8f55so1377444wmq.0
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 04:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pKPQH7LwQtfFgrYlegGI8c5fEAyto9CC1WAj6hyGcrE=;
        b=QTry7Z/XeqpvY4Ql/bdTrW9KtHGzi4mTzayXZ3R0vH/kB6mt+dHFHWK7O94rrc+aml
         sTLi66LwkJLV2UN4Cb3uHOtcVmyFtQ9yAPGkMDy6W2LXEApM4gOi4HNeqwUg/aJZorLu
         s/CQJgSg8Ocjppm1RTztHrZG02CjFeaT1TS1+GOX1rKsfuTPJqrVeYJqkdNGpfV4WL5g
         1WyFO0okV6hBzUpnU9IRoMu1TZ88cNGXOij96zYwSzBZx4YGQ+fB+Q6GcP8vo7cxXIUl
         CSftpumsbu/hxOwri9dMMX4upJdJ+6HWfYfa0vtD3QpEHb+W/PmpmEodEPRGpRAddMyn
         V3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pKPQH7LwQtfFgrYlegGI8c5fEAyto9CC1WAj6hyGcrE=;
        b=Plk8XTGz0suSQz5vkJKZ+uyFzi5yp2epYEOlenC1oPZ7JbnXtD3r7MEL7RexlcyP8e
         lXShzZuMZwuHe8PTHzrhk7d0xfmvmFpOzbgJy+80L3kmMsr1pantKsArrf6Av3lCe8d3
         NkcFFykiIXD7DOG3SKPJPd5sJaHyxtgxZ7IauBWN1zOeyPiZZPN8LdzjIEIXIGIpCOOY
         HPzKT9acuVHrQwrPqo3Oa/qHBL6BChl4A6886Uln00s8BIxtiFxOjqfGTXF4Rju264mS
         qaqorvQMHvi30uyI+aOiJ5Gl0hJXZUENYTdi913UDbTrVey7lzbmgmDxp7f8BvGe+h5q
         JKLg==
X-Gm-Message-State: AOAM533eh8HEiVbs7k9BVPXpxCO5OMB8Nu3hXMSfSwRl1sw6KxNXwHb0
        QvkyWB85aLoXni8/+zqLdMGBKIZJVeE=
X-Google-Smtp-Source: ABdhPJwgUgT9LzXqhMqXB3iRD/GCFjYTCZgRAvU6XjVrZ3BEyil/LktVQPRSAPjkd/Gsqmxl3q4WdQ==
X-Received: by 2002:a05:600c:4f94:: with SMTP id n20mr9246670wmq.110.1630497438099;
        Wed, 01 Sep 2021 04:57:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h11sm25255939wrx.9.2021.09.01.04.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 04:57:17 -0700 (PDT)
Message-Id: <acda0f599475c07c6c1a5e75384e0cff98d2c19f.1630497435.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
References: <pull.195.git.1574542242.gitgitgadget@gmail.com>
        <pull.195.v2.git.1630497435.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Sep 2021 11:57:09 +0000
Subject: [PATCH v2 2/7] remote: warn about unhandled branch.<name>.rebase
 values
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Wong <e@80x24.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We ignore them silently, but it actually makes sense to warn the users
that their config setting has no effect.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/remote.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/builtin/remote.c b/builtin/remote.c
index 7f88e6ce9de..5705e088e5b 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -318,6 +318,9 @@ static int config_read_branches(const char *key, const char *value, void *cb)
 		 * truth value with >= REBASE_TRUE.
 		 */
 		info->rebase = rebase_parse_value(value);
+		if (info->rebase == REBASE_INVALID)
+			warning(_("unhandled branch.%s.rebase=%s; assuming "
+				  "'true'"), name, value);
 		break;
 	case PUSH_REMOTE:
 		if (info->push_remote_name)
-- 
gitgitgadget

