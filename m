Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A93E5C48BDF
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8E493613E2
	for <git@archiver.kernel.org>; Fri, 18 Jun 2021 18:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbhFRS2d (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Jun 2021 14:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236331AbhFRS2X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Jun 2021 14:28:23 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5C1FC06175F
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:12 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 102-20020a9d0eef0000b02903fccc5b733fso10578464otj.4
        for <git@vger.kernel.org>; Fri, 18 Jun 2021 11:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bbD5pl2lVnLaK08ia/VKbSbygyDTXnLrFUifoXgtAks=;
        b=c0A/f5bz0ZQLpv0xTP6V0b0BG/KjABvVI4QHbu5q6L0wyMTwTNkVpCrnAlK6j3dxU8
         kGLdBlaD6baJwgguEUgmra2ewncKU/VXK/g2mYQxaA1z0HHtrFsQHqC3IqgphsvaQiiC
         hY8mdAyfnYRcFexnQXKhHB4gQdgwOK8/1PAwrhQTxUPz4PJQVtJNnGVXZIRqxXtVOTeM
         l+IZ7zkGWMlXbEzv5rPaHArxHvPygSkEG7fyg/wPa+VMnmJPBFSRxV/GTMB0uageRObT
         Y4lHPf+xKn8H4Y/JpgP9dGJ05XpjItx+2r804YGJ4ow3asQmBvheLrtBV6aiZef4ff+z
         1wZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bbD5pl2lVnLaK08ia/VKbSbygyDTXnLrFUifoXgtAks=;
        b=BhC8ScSFyObzOWGit0EFp1mEDFUyQpH8fIDEDrB9SkgGKAGUJshDbv8zoYUDDgBWyC
         uHwJt2h43ubiwmIfoUUr5pYndSP+ZsemHOHrxt5AmDnrziFmktISmUipzOQmXXEELmsG
         IHH5Cj1RJBQl7QsroIxFHHFcapfzDYywVihS2uCLzxZwvqgY3ClIWOLYSychNQBN8aer
         S+qL61/yC2TiWdxM6ogBWyih6cgdyDFYoci9nOA2QD6s52AVdatmLRrUVqamnsivV2UX
         RIX6W80J/RUHD30hJmeF3QwKrVbjEZ+eJ3rHWxjQ+q088sngQfrJt5MMC+oNKDHz02Uh
         zJ9A==
X-Gm-Message-State: AOAM533KTjp0IshcME6yrsxlWehPHvEG6wiOK//AF+83h8/eFe8Af6nA
        I/A0ArmXyPW+AFUlp8m1v7m8E4CiUEeKWA==
X-Google-Smtp-Source: ABdhPJyigkfIYIZ22R8UZsWvtAQDyNvE+vN9DPGskah8CeoKRutRG/07byjxxIv3RATalkbJltNDDw==
X-Received: by 2002:a9d:1726:: with SMTP id i38mr10027538ota.51.1624040772159;
        Fri, 18 Jun 2021 11:26:12 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id n7sm1901842oom.37.2021.06.18.11.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jun 2021 11:26:11 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 27/45] completion: bash: change suffix check in __gitcomp
Date:   Fri, 18 Jun 2021 13:25:00 -0500
Message-Id: <20210618182518.697912-28-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210618182518.697912-1-felipe.contreras@gmail.com>
References: <20210618182518.697912-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We don't match the prefix, we shouldn't match the suffix either.

There are no functional changes since all the callers that add a suffix
add an =, and if $cur_ ended with that suffix, we would return
immediately.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-completion.bash | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index ebf8df94e8..e7308b212f 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -346,8 +346,8 @@ __gitcomp ()
 			fi
 			break
 		fi
-		c="$c${4-}"
 		if [[ $c == "$cur_"* ]]; then
+			c="$c${4-}"
 			case $c in
 			*=|*.) ;;
 			*) c="$c " ;;
-- 
2.32.0

