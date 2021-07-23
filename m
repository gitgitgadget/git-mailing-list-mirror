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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BC62C432BE
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B1260ED4
	for <git@archiver.kernel.org>; Fri, 23 Jul 2021 12:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234819AbhGWLeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Jul 2021 07:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234612AbhGWLeB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Jul 2021 07:34:01 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAECC061575
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:34 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id e2so2126106wrq.6
        for <git@vger.kernel.org>; Fri, 23 Jul 2021 05:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lF6XRer7oES/OwiaJHCWeMxdegSRO8OZ/owLXbNfJRU=;
        b=HjSzPSGu2rMZZJABEKRHFbLoOtIMrLoTcKC6oF61Jfn3qGmN+i9Cfe2iQZZ/hqGc2q
         jRA3n46yGyW4B8uSNbbUhqP96G+olch49DqvclOUJZGZutrKTHgQ3ftlcmmUQX5+1GUI
         hxlMoNkFZR2RmiN4EfxtvLjSsK70IyC1sg6L/oYuEiPfNKqSNlbKr/JVoAYWSj29ItEk
         3PFqoAZGB89dMaW+ximUK7nB0+lTFg3bmIbpZA5oBplitgoBfuid9gmaG01QVmTpn1Tk
         sEH6Ghd7yF8D5ACd9JkdHBKXSvYDHoThjEpxzgaq6CgUQP0K1Pl9ZyhLY5tUInriApFB
         WQ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lF6XRer7oES/OwiaJHCWeMxdegSRO8OZ/owLXbNfJRU=;
        b=eb2hxu/4b0oruRYA+Cy1GUAL3noyfsuQISOzS+HvipR+E6mS3qpABjrTez42MEzH7D
         nR0cW8GOiBpWohxl/ABenJOLpuTJjoZWqDTciucmxuSnaOGlt8X9H2XG2BRH5xxhE+9B
         7es7SxXMOGTAogGzCslZ0+4J8MNOoKc6mmA1sSizsA1jbh4hQjCvcmYmGmMP1f4z8dpO
         PA6OLIDramD7q86WbHOZkJHAKVeLAb2I9IM/PN4uL3A8UO/HwNXECHA6nU3Gfz55ohJK
         WKRPRUfk7TfR2uGGpoi/VfbM7KzYT2f9qpQpTnBSOMqJ/A3SLMIMiV7DulEmXdRHKEGN
         6qeg==
X-Gm-Message-State: AOAM533S0F743VUk7KqUzmli/u9FknkEEM5yryiFY8YOTMKod37yBj9Q
        /T2ixMC9JL4DOVnomPPW4znhPiwryYI=
X-Google-Smtp-Source: ABdhPJzY/MoXmRiIXQmugAyWuE12cDqrqusJHaP1jV+eA9mYQdrmR6ENF6OuGMkz4Tl5ZR9R2HNHjw==
X-Received: by 2002:adf:b318:: with SMTP id j24mr5195331wrd.361.1627042472987;
        Fri, 23 Jul 2021 05:14:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id b12sm33240217wro.1.2021.07.23.05.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jul 2021 05:14:32 -0700 (PDT)
Message-Id: <5d3d95c9cb978ee02d9e39c5eb70b49ecdbd218f.1627042470.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
References: <pull.1002.git.1627042470.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Jul 2021 12:14:28 +0000
Subject: [PATCH 2/4] Documentation: define 'MERGE_AUTOSTASH'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The documentation for 'git merge --abort' and 'git merge --quit' both
mention the special ref 'MERGE_AUTOSTASH', but this ref is not formally
defined anywhere. Mention it in the description of the '--autostash'
option for 'git merge'.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 Documentation/merge-options.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
index eb0aabd396f..52565014c15 100644
--- a/Documentation/merge-options.txt
+++ b/Documentation/merge-options.txt
@@ -154,7 +154,8 @@ endif::git-pull[]
 --autostash::
 --no-autostash::
 	Automatically create a temporary stash entry before the operation
-	begins, and apply it after the operation ends.  This means
+	begins, record it in the special ref `MERGE_AUTOSTASH`
+	and apply it after the operation ends.  This means
 	that you can run the operation on a dirty worktree.  However, use
 	with care: the final stash application after a successful
 	merge might result in non-trivial conflicts.
-- 
gitgitgadget

