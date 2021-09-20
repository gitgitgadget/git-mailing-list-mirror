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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8FB8C433EF
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A511E61019
	for <git@archiver.kernel.org>; Mon, 20 Sep 2021 23:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242252AbhITXir (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Sep 2021 19:38:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238665AbhITXgr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Sep 2021 19:36:47 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919F4C0EDAF7
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:43 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t8so25035276wri.1
        for <git@vger.kernel.org>; Mon, 20 Sep 2021 10:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RBzcbjRmUFju4/2SfeXbRU/+F75G5LRmbXMUpPAFelo=;
        b=ij7b4RLgEEsm3E24lbhUT8ZjM0pQ3MCvharUpKzmtBGdPCAMHfsgL75mQz+ZtQ+gaW
         xzK//l7qI6SUeXRg1WUQYjRybABCqI0wiE3jiPmM2X5KqfpilWe3w2uDai/qyZJ+SxK1
         IydrhljZEVDgbdQOuFaJn1inHd6uQ4NVeRtW5nBLCfWKny99PmIuGSJgklLRM2xXza1K
         42RE/N21VH/wwrxmraw1i7ZYtiS0SMQ1ZHX8ZgFTtIEfXA7WDJXHMi9FeuKl2Vpi2eI5
         0D+x1Y2F7T4XY6Y/HSde5MGWc7+VCg9lngCsmKYUvVFE2P0vS7Jnd7cB3jaFWzRIjU0I
         Uyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RBzcbjRmUFju4/2SfeXbRU/+F75G5LRmbXMUpPAFelo=;
        b=u5TH7gmabp67pmb6cxwyNJz3+6uWxgg7pO9MvXTYwiyhTd3hMPM32+WiXnkVRW+A5W
         K4jJH25uH8PJK3JJ4fCKbxr5CvZryk4tztycDcM6CC+UEXK+q42g17pDxBaBDFmp0dFJ
         FQxChBx+JBjdk6GoEUnpAQWLzUVfnw5bx/vDHHVpqm7y4F1n3+vUZ0hHYG/ArSFvSu+S
         kPYmxKWBtgApiHcivjS4huxz1JDfiglRAiUtpVaUqaRJzGovicAdNcxK1aLBv7FhHDVw
         O8Kr2PlcntJ+OohwbRSYsxCRcdqED3ZytjU5ZqzZDNBscU5PYc9DUvWkPm95bxTjtgpa
         51iA==
X-Gm-Message-State: AOAM533BoPqfklQyqfrqfaZ+LHdApGC3FnnAjccGRJOmtTPEX6cqyi70
        5KqyT08hlA72LdNbvNKGmw4qOwTxDko=
X-Google-Smtp-Source: ABdhPJzarZmp9LHlzPNI666q24vopz697uSshHvwIPjlR3NId8ckpujvvwzRAPgKc8IfIkd6p4Jmbw==
X-Received: by 2002:a05:600c:3b1b:: with SMTP id m27mr256974wms.15.1632159942281;
        Mon, 20 Sep 2021 10:45:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z79sm204924wmc.17.2021.09.20.10.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 10:45:42 -0700 (PDT)
Message-Id: <c6d17df5e5d94ab6b53663dac419c20b5e7ae824.1632159937.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
References: <pull.1018.v2.git.1631453010.gitgitgadget@gmail.com>
        <pull.1018.v3.git.1632159937.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Sep 2021 17:45:28 +0000
Subject: [PATCH v3 05/14] dir: fix pattern matching on dirs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com, matheus.bernardino@usp.br,
        stolee@gmail.com, vdye@github.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
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
index 9ea6cfe61cb..174d336c30e 100644
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

