Return-Path: <SRS0=sf8h=ZQ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3C7FC432C0
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 13:09:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 949DB2073F
	for <git@archiver.kernel.org>; Sun, 24 Nov 2019 13:09:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InfC9bTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfKXNJ1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 24 Nov 2019 08:09:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40406 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726719AbfKXNJ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 24 Nov 2019 08:09:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id 4so10855855wro.7
        for <git@vger.kernel.org>; Sun, 24 Nov 2019 05:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Utcp+8RKL/2qCVWxzMAmG3tbKk8NZgypzeoOABUwLC0=;
        b=InfC9bTz3u/IlWlz0E/UugrHdBpuXxA0Qwh7oNmWvem+8jIm/OUZEzrgGfwBAywLfY
         DgjLUKKTBUzNFtg9lu95bJG+qHVGhcx/oTmKbz06PXXa5bvnOhx0b44Z7fdeE5V5XB/C
         La5Lve4ZHE5xliVHKlnVJaHluK2Z9FzzhZhddKRFfSMjtAqW522MYTRkx/GYIyBf+FlE
         09FnG5oq+wzv5k0A4CvS2JlFFyrhnL/MtNzRaBs2gXVhIQS+KPeVgeYOZJODXBAgP2Ai
         9c0AIc8xi+HqbwmkYYY6sE4Mjvzt8ZRD2v2btrkx15vXOy7YyTmiTBIuFulcHX0jtSqT
         L8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Utcp+8RKL/2qCVWxzMAmG3tbKk8NZgypzeoOABUwLC0=;
        b=AURbcekXkIBcYHtX7I6qaSTcFRwDR/6tZk7gjmObNlpfRz+MqkCc8+gVgsawzsVUze
         QWGy35BpDGv92CiqUNiLWCo6hwPWjqFNEYoFVfsFPVKlpMEdFsWDrEqeY2b6tkM+OTuD
         u3Dz3ts/rlXkb0Y61aikYZh6T3T2qJBH0ut8Rb5K3byhG8nCaG6/tG8StcZIycYJ6ipR
         YOZ+hoTpEMlpalfrCz5X+YbB48UthkK+vzPsIrWC/VGmmeUNtYXo9gUZmsXvZnTW/w/z
         ejf+zzpM1FKauwMEyNJOS+lFL05x2/iPoBQuCNfseyhawEXNvXzAGTM09XgGEvoyb5wS
         rnLg==
X-Gm-Message-State: APjAAAU8BImQW5eH/Oyb304eZwvcE8sIqqqaK+XQElnC8Qh8oQxus85j
        /kc7j7XNvJITp8QfXG/qCrOusNED
X-Google-Smtp-Source: APXvYqwCUt8xEXHA9KV1dGjP8u2eoFu/yPEwbDK6xtXc2Z4hHTevZxmtaPo91XG1vHfu6Lxh0W9jwA==
X-Received: by 2002:adf:f651:: with SMTP id x17mr27872104wrp.114.1574600965360;
        Sun, 24 Nov 2019 05:09:25 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s11sm6186573wrr.43.2019.11.24.05.09.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 24 Nov 2019 05:09:24 -0800 (PST)
Message-Id: <177deddcf83c2550c0db536a7a6942ba69a92fa5.1574600963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.473.git.1574600963.gitgitgadget@gmail.com>
References: <pull.473.git.1574600963.gitgitgadget@gmail.com>
From:   "Hariom Verma via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 24 Nov 2019 13:09:23 +0000
Subject: [PATCH 1/1] git-compat-util.h: drop the `PRIuMAX` definition
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Hariom Verma <hariom18599@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Hariom Verma <hariom18599@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Hariom Verma <hariom18599@gmail.com>

Git's code base already seems to be using `PRIdMAX` without any such
fallback definition for quite a while (75459410edd (json_writer: new
routines to create JSON data, 2018-07-13), to be precise, and the
first Git version to include that commit was v2.19.0).

Therefore it should be safe to drop the fallback definition for
`PRIuMAX` in `git-compat-util.h`.

This addresses https://github.com/gitgitgadget/git/issues/399

Signed-off-by: Hariom Verma <hariom18599@gmail.com>
---
 git-compat-util.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 607dca7534..ba710cfa6c 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -320,10 +320,6 @@ char *gitdirname(char *);
 #define PATH_MAX 4096
 #endif
 
-#ifndef PRIuMAX
-#define PRIuMAX "llu"
-#endif
-
 #ifndef SCNuMAX
 #define SCNuMAX PRIuMAX
 #endif
-- 
gitgitgadget
