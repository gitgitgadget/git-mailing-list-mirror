Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ADD9C4320A
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 467E7613B1
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 21:54:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbhHXVzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237950AbhHXVze (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 17:55:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1773FC0613C1
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:50 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id x12so33325197wrr.11
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 14:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NIWHJWvBiXtXaJEPmJtf0dHB0etFMwiF78iEbq7VnQc=;
        b=IJxxcNVwKhRZzYFesPVptaThtbZpS08tSz7du7aYV1O/Q3WZW+mcqH8usgm2vaKT9I
         h2Y5aJIpFbOrMfzDAK+wmuAlEuupPJNoNhiIJRnoQwAXcJriR9cRQTQTimpCCgjZh7A7
         ep+qsKa/GwCjACM85/B7D55jr3d8MecuccY7dPX/2vQ7lKWitSAFRa6pPN0y2LPE8FVr
         mqi9UWv/s0I2Q7xRu08Wdv81ZD6TzxSrBFJ2I6i50yJNwj5haX/XN9Re5OIHfj8NazUC
         9+3WQ1hss0DaKYTghbLLKfIoJYRww1LXzdg/w3RLYrBOZpmWh94X+JND8zBa+/6b4qbD
         Ayvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NIWHJWvBiXtXaJEPmJtf0dHB0etFMwiF78iEbq7VnQc=;
        b=ntQWbjkz4HG+lYJjfdFwz9ddrk9kA5cYTMIcaAIunWLVpNNPJ6Rk7kqn/Y9y4/D3KP
         BXBaeRG7EL+SQKcCXhtAhoIQF7W540JhUt2Fgf5LfEsBtJ2dG+9bOBNLDAt2BzUc+6Fp
         iBugtazxXCR7xU5ODT/hhcamdJ29gxqloKO+UsyPPRayzkRrKXaqxT0k9//cZzblYSYv
         gh0ULW1fAHZotWL1GIHrcvbPqXDbZCC9/uYvE/7cdFbI5O6vYgmOAU5F2HbcY7htNXj5
         lPvQzOEj3Azah7i0/wqvRbWI4XzZ/ZTH79OQ6avjX62XYrNsdvboVe/rvIhqaT+hH/u0
         3yTA==
X-Gm-Message-State: AOAM5332TiremRfK2Xzmn2P1qRzAH2sNH4KWM9x+O4YuH1uIZwb1hTIa
        zXIYB6Mln3HKr1LMDe9j14bTyUiOtuM=
X-Google-Smtp-Source: ABdhPJy8d/6ihTZ7NTk86V4DsVSV9VCKS98OK2BbGxeKgcyHN8XaGDJkVokPfXukAdH2WcPeqANeXA==
X-Received: by 2002:a5d:4311:: with SMTP id h17mr21495490wrq.263.1629842088731;
        Tue, 24 Aug 2021 14:54:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17sm2231583wrh.67.2021.08.24.14.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 14:54:48 -0700 (PDT)
Message-Id: <58e7df44982965234c028174ff108a0abeb9862b.1629842085.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 24 Aug 2021 21:54:36 +0000
Subject: [PATCH 04/13] dir: fix pattern matching on dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Within match_pathname(), one successful matching category happens when
the pattern is equal to its non-wildcard prefix. At this point, we have
checked that the input 'pathname' matches the pattern up to the prefix
length, and then we subtraced that length from both 'patternlen' and
'namelen'.

In the case of a directory match, this prefix match should be
sufficient. However, the success condition only cared about _exact_
equality here. Instead, we should allow any path that agrees on this
prefix in the case of PATTERN_FLAG_MUSTBEDIR.

This case was not tested before because of the way unpack_trees() would
match a parent directory before visiting the contained paths. This
approach is changing, so we must change this comparison.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index fe5ee87bb5f..80fd0ad2fc0 100644
--- a/dir.c
+++ b/dir.c
@@ -1294,7 +1294,7 @@ int match_pathname(const char *pathname, int pathlen,
 		 * then our prefix match is all we need; we
 		 * do not need to call fnmatch at all.
 		 */
-		if (!patternlen && !namelen)
+		if (!patternlen && (!namelen || (flags & PATTERN_FLAG_MUSTBEDIR)))
 			return 1;
 	}
 
-- 
gitgitgadget

