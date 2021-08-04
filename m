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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5B7C4338F
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 173FA60EBC
	for <git@archiver.kernel.org>; Wed,  4 Aug 2021 23:51:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235872AbhHDXvS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 Aug 2021 19:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235799AbhHDXvO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Aug 2021 19:51:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B482C06179A
        for <git@vger.kernel.org>; Wed,  4 Aug 2021 16:51:01 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id c16so4052344wrp.13
        for <git@vger.kernel.org>; Wed, 04 Aug 2021 16:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=UZHlq8zwzuLvJo2qCceq3MR5jTd+LMYshSdZHCnpgqk=;
        b=b+A019F8o8ZJurmKt5oh3ij8ynpAfVwIqiRZL19qcNRAzpE1IKQRlLggVkZkdOsZ/A
         q0SzTMU6fx/XXDYNCzUP38MPUPcBpIwRzGroDWlykwOvmQuTdFR5nkquBnunNAD5nEQB
         LpZSgVwZdKs1GwO4Km5KMQMIQSBI0UOmwcyialdeZYGBZbYLip91T8hr6Gj8aDhc/+gu
         AqCcVplwONYmsMYaxzR3hI8irPF9DG1arTKs9oAPOqSbJKcXBZ/s2r6zvhjhKjxskTwD
         H0ksJ9Srg836tVXDmJFrCjZx3fvNf1Y0/Y8rfZxlaLyYDanafNpERkblq51+RWkqWHIk
         dwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=UZHlq8zwzuLvJo2qCceq3MR5jTd+LMYshSdZHCnpgqk=;
        b=oFfp+3aM4nelgEXOBL+gG8IdC+qSrHrZcvQYOxfe+lJ8lfMpHeH3Oc93yjugtaMTAu
         NiA4ysnErEFCxaVdncEoS2DFg5eKJt7N5M+Y6CXNeJ6RaIfZi3IfYlD+N6RqPTWQLT7a
         w8IVkyhYCU1EPseBTDTF4ujrihgXDNxypDyt2vmStxlLLqFMxhvN/L6tfRzhODm68LXp
         In2w/NKEPdR9yiNSjLNjcrSYWiiMTdR8hhMMt6kdoESmJKHCPDG/c5gB0Ph5mRaHko+v
         7QVP9xa9dDMcoF/olOd2WDt3iYvFeU6bD59xCqp2pI5Pm4jqPrGzUxHwh1mENmSqept8
         VuCw==
X-Gm-Message-State: AOAM533Tal9I11ueUPs1yxJc6320dofqwVJ0VwlseWhoP6B5DQ+91XCm
        AHrI2TDb4KO+QboCf+TfZ7z8xFmx24c=
X-Google-Smtp-Source: ABdhPJzFMLC34aQOLkaucTM0oiMaK/y/XDUgS/hrRV6e8xLcjeMU8OLtMMOphxqpj5VrsRpYCr3UKA==
X-Received: by 2002:adf:f8c8:: with SMTP id f8mr1781952wrq.204.1628121059983;
        Wed, 04 Aug 2021 16:50:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e3sm4243152wrv.65.2021.08.04.16.50.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Aug 2021 16:50:59 -0700 (PDT)
Message-Id: <a8381a89065e8fb428ad8f980cae34f3231d9a77.1628121054.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
References: <pull.1059.v2.git.git.1628054935.gitgitgadget@gmail.com>
        <pull.1059.v3.git.git.1628121054.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 04 Aug 2021 23:50:50 +0000
Subject: [PATCH v3 06/10] merge-strategies.txt: avoid giving special
 preference to patience algorithm
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

We already have diff-algorithm that explains why there are special diff
algorithms, so we do not need to re-explain patience.  patience exists
as its own toplevel option for historical reasons, but there's no reason
to give it special preference or document it again and suggest it's more
important than other diff algorithms, so just refer to it as a
deprecated shorthand for `diff-algorithm=patience`.

Acked-by: Derrick Stolee <dstolee@microsoft.com>
Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/merge-strategies.txt | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
index e2988124581..b54bcf68f2d 100644
--- a/Documentation/merge-strategies.txt
+++ b/Documentation/merge-strategies.txt
@@ -37,11 +37,7 @@ theirs;;
 	no 'theirs' merge strategy to confuse this merge option with.
 
 patience;;
-	With this option, 'merge-recursive' spends a little extra time
-	to avoid mismerges that sometimes occur due to unimportant
-	matching lines (e.g., braces from distinct functions).  Use
-	this when the branches to be merged have diverged wildly.
-	See also linkgit:git-diff[1] `--patience`.
+	Deprecated synonym for `diff-algorithm=patience`.
 
 diff-algorithm=[patience|minimal|histogram|myers];;
 	Use a different diff algorithm while merging, which can help
-- 
gitgitgadget

