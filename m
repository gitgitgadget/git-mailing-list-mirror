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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC845C43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93D0E61026
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhD0Kjr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238084AbhD0KjM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:12 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C99E8C061760
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:27 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x5so8650635wrv.13
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nmHtFWqQnBy0eZun5UNXWPvZ+9Qf4vYv8kZyys5IeM0=;
        b=nlR4B5DnF+aLWgQ0qxbNKudu45IxNOYErakP7NQWb5zwQaFWleFhwNEjye2psHc1Gz
         lg/C4rD6s5Ha/OvMT87rY3qX+i4VRTqkRCGn076jCqnE0Y79O9RYL7gHJNrDVushPwWO
         mP3VeMYGVmmRD/qQEmVro6irArI3AC9o4PehVgq1uDBlYbE5xikyiSHmxCU/gSBMewQT
         qJRqJ+B9duKXdPqYBH2b+qAtJQlSaM3tQhWyIyTEq8VVjWAy5CYow3oVmKIMFyJU6r0X
         bfCZ5kOXl+LbVOqHDlM0zQfipg3zEwsBmdMjnYEoWREyHs3TXOdanZ8YW8W5W/0oGgEl
         EQEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nmHtFWqQnBy0eZun5UNXWPvZ+9Qf4vYv8kZyys5IeM0=;
        b=ZwUHcYNQtCrWSMwUoTyJ+Fihviu4brmL9ZZfSP0pU2JRKF2Ssujyvhmt7YDO6Dd/PA
         p2eOXsF76bG4b0H6wT0ed9WdtQU3LGohqNbUccP2fQS/cTCtHpwQzQoxZPh1cyYzUon3
         /Xf6ccF+5YUvlneUZQq7+7ZOt5rXKEyNCG7T/yoUFT0PZWD/3ScgO9Z/l7QwWtMDIY+E
         f+rcmpHwVhpWmNwTgLtsXuVy0SvBDRZIfFvZhN3U1ct7uUWcHQszpzLuF5SqM8pjXvIo
         sk9+f/V75/CXImVDn967tRrIHbepydHXX3RwNhbLuDbXQxumE+26mTk9MSk0PQG9q6PA
         oj2g==
X-Gm-Message-State: AOAM533xUBRoB/cty5HfwfFhU2iLyEhRh1LXsW2soZmJTQ8VT0vpvNvS
        +qgs2FgongcNiNeAZaMjdmJ/Wm1VDB4=
X-Google-Smtp-Source: ABdhPJz3iOMWypyoBJT4VrEaPcoY8AvGDLRYYLbTvPPK8DliKIELymq47JZSB/7BZpYSUd0hSR7Idg==
X-Received: by 2002:adf:e885:: with SMTP id d5mr13870999wrm.261.1619519906627;
        Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c8sm1952300wmr.48.2021.04.27.03.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:26 -0700 (PDT)
Message-Id: <c5855b0caa7320c8b3f1ad5c5904ae73b1decb97.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:04 +0000
Subject: [PATCH v2 03/21] t9300: check ref existence using test-helper rather
 than a file system check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t9300-fast-import.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 5c47ac4465cb..1aea943bef72 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -392,7 +392,7 @@ test_expect_success 'B: accept branch name "TEMP_TAG"' '
 		git gc
 		git prune" &&
 	git fast-import <input &&
-	test -f .git/TEMP_TAG &&
+	test $(test-tool ref-store main resolve-ref TEMP_TAG 0 | cut -f1 -d " " ) != "$ZERO_OID" &&
 	test $(git rev-parse main) = $(git rev-parse TEMP_TAG^)
 '
 
-- 
gitgitgadget

