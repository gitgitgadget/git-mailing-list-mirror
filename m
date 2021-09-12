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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFF01C433FE
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 960F06113E
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 13:23:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235545AbhILNYz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 09:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235291AbhILNYv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 09:24:51 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4A5C06175F
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:36 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so5232164wrq.4
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 06:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NIWHJWvBiXtXaJEPmJtf0dHB0etFMwiF78iEbq7VnQc=;
        b=AhLH0HBi0Np931Ry/AnPRyQ0p6A6Lfw1axtcDBzE4IK/9GAHV+32Ucl0GICYq9l5ho
         whj3tnIWu5RCAkd2EqKu3bO+YcBL8larpIYDUSnecFl40tbXe9Y2ksVtMgMt3EYR2xbx
         iMTKFHdWfPWVsolzzF7sFPWTHZOEiCucEAS451b80LJYYcQZ3MgnHJASXHTViUVEVg0R
         bNNGZiH1HoSHIZdFbJjKlj8fQctg2Kn7txgM3eWt72Cz9Y5JDVeu0ODTp2BKtn++dkY7
         zBP3dLXE2d1nXobJWW141ZfR9W0gArLHX/pR5LzczdRwMH2q+5MGnI70SIQbilg1UMhp
         GivA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NIWHJWvBiXtXaJEPmJtf0dHB0etFMwiF78iEbq7VnQc=;
        b=AAtjyVkqxMVzxQUUzGRyU6g19JrIluX0sr5LqHIqBkN3lPOtu6sBm/C/S7dtSt/arz
         1AACp23+0TD546esldYH61AIN4NjubBIVV7duhyUrMeY0CMqQwZow+bLbI4ORONuUTeV
         Qy5AwV0g5hOvBJ6e8w069D0qa3kJ6GdMKvdcjvJnkbifHqLtmGPAdLqwS8CaeKYhcD7M
         XmkvKkGP1z7xecFf9XRzqgJwycaatsInsBmWWML/8QkxrPPqLmOOqE893T3lamdyjsJl
         w83Ik218yi/z2AVGNSKgT79O3KzS55M8japmSN7LN62TwISqEkJdIWczSnLFZGfRENyP
         dv9g==
X-Gm-Message-State: AOAM533FpFgXTnA/5LPCLRbfdL0UmxYj6OYDg73bqfPw2dVa1zTI78VP
        /AIuc/eY/kV4KzvfHaJm9kD15172WzI=
X-Google-Smtp-Source: ABdhPJwQ/jX3d4b4acFgAqpQE5IrrV2hSpftlfiHDzXvrcbWk+A1aC2XVXJrNHZgdVbn5dLt2Cgmeg==
X-Received: by 2002:adf:c501:: with SMTP id q1mr7523652wrf.150.1631453015231;
        Sun, 12 Sep 2021 06:23:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m4sm5308822wrx.81.2021.09.12.06.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 06:23:34 -0700 (PDT)
Message-Id: <ed2472d33f12956dcafb0b600db9d7a6aada8cb8.1631453010.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
References: <pull.1018.git.1629842085.gitgitgadget@gmail.com>
        <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 12 Sep 2021 13:23:21 +0000
Subject: [PATCH v2 05/14] dir: fix pattern matching on dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        Derrick Stolee <derrickstolee@github.com>,
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

