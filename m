Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1E01C433FE
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 20:34:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353384AbiCUUft (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 16:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238538AbiCUUfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 16:35:37 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D878255225
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:08 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id m26-20020a05600c3b1a00b0038c8b999f58so274449wms.1
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 13:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=nls1zqboNWuu5wUJ2DIO+lCelR5/1stGOVoxd1jtrW8=;
        b=V6wNpd9mVOcpA9dtsMyiNfwo3WNhoerUUjP0Ar54uQfpJuRp6NCF1IH+72rGrYX3ZK
         5ECfltGvfU51191LfwIRw4HNU2fRBJhIphTlxACEbX+cs/BABQZkcM51dqMsBe/7DKFV
         Y30GP3TBAwzg/4NGumx/qDbk4olub5AhKGq8ewGSiHlEGAgf8s0yNH48DVOYMerH2Twt
         wocuAIQBHy+wowS/ni4ze7x1f5KUMVYgGk4id7JLn9D0HE82W+9MZSsbkMpsF8QWxRQD
         WVUMRR8rbfU3HtFYQOnnr2Ac3roZT5r4u1CVjyrOWbU77GlWHi/xYQKSDrUJTn4CP01X
         FlgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nls1zqboNWuu5wUJ2DIO+lCelR5/1stGOVoxd1jtrW8=;
        b=fTUEhTou8xsdee5nzz8viFGb6wr24ayGhRIpRrY8fgRS2lOtUgn/swB5PPFW6B7Ki6
         OoM3kJyR9ihWqGqdWJMr+a31xLSS4dgkk4e1dwK+hYoWM6hV5So3KoO7ms9pOb877mV/
         nQv5CBTVkgkdbcW5oVb9c8Hf0mxyBsjP3fnExOl5JW20ejcIlYT2uYAf6Ta8GUNWMg3t
         ++Z7B4Hf2b1sLbPl4Gmhwce7GezOIFWTnoUU4ou29yvuBXSNQGWha7SMBpX+cawWbjVd
         UFJMFx1XhBrd3xvUA1Ywux2yWplNAymhulfJ6wQLuhj8ZgCXa7QRHn95M7d36PN3L2Ot
         VvdQ==
X-Gm-Message-State: AOAM5338wewo/8bX/I+XtYOgZNWj8lmjSWWwAsMqesc4h9FmPUwVjc6Z
        RLR6rXFtJKGaEBWXCKFKOGddKxyWxRE=
X-Google-Smtp-Source: ABdhPJz9MN5AqnRYAJUlu87R2vjiKB3lv37vD84GFb83W/iLid3RqacTjBwF0Qq9sb7aBOKqVEg4uQ==
X-Received: by 2002:a05:600c:5024:b0:38c:a426:8ea6 with SMTP id n36-20020a05600c502400b0038ca4268ea6mr728212wmr.193.1647894847188;
        Mon, 21 Mar 2022 13:34:07 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm514750wmp.13.2022.03.21.13.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 13:34:06 -0700 (PDT)
Message-Id: <pull.1185.git.1647894845421.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 20:34:05 +0000
Subject: [PATCH] test-lib-functions: fix test_subcommand_inexact
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, chakrabortyabhradeep79@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The implementation of test_subcommand_inexact() was originally
introduced in e4d0c11c0 (repack: respect kept objects with '--write-midx
-b', 2021-12-20) with the intention to allow finding a subcommand based
on an initial set of arguments. The inexactness was intended as a way to
allow flexible options beyond that initial set, as opposed to
test_subcommand() which requires that the full list of options is
provided in its entirety.

The implementation began by copying test_subcommand() and replaced the
repeated argument 'printf' statement to append ".*" instead of "," to
each argument. This has a few drawbacks:

1. Most importantly, this repeats the use of ".*" within 'expr', so the
   inexact match is even more flexible than expected. It allows the list
   of arguments to exist as a subsequence (with any other items included
   between those arguments).

2. The line 'expr="$(expr%,}"' that previously removed a trailing comma
   now no longer does anything, since the string ends with ".*".

Both of these issues are fixed by keeping the addition of the comma in
the printf statement, then adding ".*" after stripping out the trailing
comma.

All existing tests continue to pass with this change, since none of them
were taking advantage of this unintended flexibility.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
    test-lib-functions: fix test_subcommand_inexact
    
    This fixes a concern discovered by Junio in [1].
    
    [1] https://lore.kernel.org/git/xmqq4k41vdwe.fsf@gitster.g/
    
    Thanks, -Stolee

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1185%2Fderrickstolee%2Ftest-subcommand-fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1185/derrickstolee/test-subcommand-fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1185

 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 0f439c99d61..8f0e5da8727 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1811,8 +1811,8 @@ test_subcommand_inexact () {
 		shift
 	fi
 
-	local expr=$(printf '"%s".*' "$@")
-	expr="${expr%,}"
+	local expr=$(printf '"%s",' "$@")
+	expr="${expr%,}.*"
 
 	if test -n "$negate"
 	then

base-commit: 74cc1aa55f30ed76424a0e7226ab519aa6265061
-- 
gitgitgadget
