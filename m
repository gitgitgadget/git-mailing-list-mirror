Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26364C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:13:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C656423B99
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387513AbgLITMv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:12:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733289AbgLITMu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:12:50 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A8AC0613CF
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:12:10 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id x22so2496458wmc.5
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:12:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JkAeqA5yWCve78SCia5B6zbaWS8Ay+vkRf7jweSf0Sw=;
        b=CyBaDIroQgt68Wiai0ijWf5Rfo9ElowoMUqwQrhoRMCqAvJAXdJLazsxr4SSSNDboS
         p7F4u9tSKLOZdDlHLNvVJ3S7zY/JxLVKo3q1Q8dKNWDNqjt9OdAXqPCrkTXsmz0Spssi
         OBxx6W0haXQdDsUiyE9uBgULe99zSI2mtjNNXbmokzpMZ9fC0Kah5D4QCdx0xkZknvly
         8/2f06NNqN33tRVKG/00wDTbN8up97/CkzoIa/IENfdsM0cbLQ5kdIKluTJZMtDS3fnl
         MhEAjeqwQOR8jO9hkc8pa6aezh9HY1BjxoYpifGMDZj2Dl4Gno3rQzdF+KuH7J1Ccw8L
         3z1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=JkAeqA5yWCve78SCia5B6zbaWS8Ay+vkRf7jweSf0Sw=;
        b=h49LAVkl4Wls4mbMt1u0byev+0JK8XUbFUbXef5AWStIbGzH1H/MTM0NLh8LJ5o0+j
         7w2+xoCdPRsjJHErlTJ//MP4k30uncH0R1asK5/a0lVQluffEVklL6+T1e7re9sE/fFk
         p6OIZu5p64Sn47142fG3ZWPr2KpOomfh3F2o1IJ9+9cCsrzK5fQCTzGNBZ/kQBdEfa2+
         y4YMlcykist5izfmLrFGDmsXWVdBnau+UU9g2zPy0OVfOrcX9OY13ZcTlhTjy1iVqUrc
         WWcJfFh6wFUituEFAGmqMTYzw0b8BDdqDOfqSiNrBfAUTDkL1aJf3mynC1hbKr7H5w5b
         0EPQ==
X-Gm-Message-State: AOAM530sHxD7DtsA9vS7zHBIoyf6wNjCdpxo+SYF6W9JnLNYDCDwCCpk
        Zli8ycDPqA704JUXLun7L6ciTnNt8Ic=
X-Google-Smtp-Source: ABdhPJwZzoywoWi8JLT+cITChY9vF3khItExu571ERkJ+eEvckAEsvfBgiib4xRkR2C5XB39/xskgA==
X-Received: by 2002:a1c:6689:: with SMTP id a131mr4291661wmc.33.1607541128668;
        Wed, 09 Dec 2020 11:12:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e16sm5591483wra.94.2020.12.09.11.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:12:08 -0800 (PST)
Message-Id: <pull.930.v2.git.git.1607541127701.gitgitgadget@gmail.com>
In-Reply-To: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
References: <pull.930.git.git.1607501616914.gitgitgadget@gmail.com>
From:   "Julien Richard via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:12:07 +0000
Subject: [PATCH v2] doc: 'T' status code for git status
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Julien Richard <julien.richard@ubisoft.com>,
        Julien Richard <jairbubbles@hotmail.com>,
        Julien Richard <julien.richard@ubisoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Julien Richard <julien.richard@ubisoft.com>

Git status can return 'T' status code which stands for "typechange", fixing the documentation accordingly.

Signed-off-by: Julien Richard <jairbubbles@hotmail.com>
---
    Document 'T' status code for git status
    
    Git status can return 'T' status code which stands for "typechange". I
    can't document more the behavior but it would have helped me a lot to
    see that line in the documentation so I guess it can help others too.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-930%2Fjairbubbles%2FgitStatusTypeChangeCode-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-930/jairbubbles/gitStatusTypeChangeCode-v2
Pull-Request: https://github.com/git/git/pull/930

Range-diff vs v1:

 1:  ee106c427a0 ! 1:  8511a2d4f10 doc: 'T' status code for git status
     @@ Documentation/git-status.txt: codes can be interpreted as follows:
       * 'R' = renamed
       * 'C' = copied
       * 'U' = updated but unmerged
     -+* 'T' = type changed
     ++* 'T' = type changed (e.g. a symbolic link becoming a file)
       
       Ignored files are not listed, unless `--ignored` option is in effect,
       in which case `XY` are `!!`.


 Documentation/git-status.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/git-status.txt b/Documentation/git-status.txt
index 7731b45f078..21c406a812c 100644
--- a/Documentation/git-status.txt
+++ b/Documentation/git-status.txt
@@ -197,6 +197,7 @@ codes can be interpreted as follows:
 * 'R' = renamed
 * 'C' = copied
 * 'U' = updated but unmerged
+* 'T' = type changed (e.g. a symbolic link becoming a file)
 
 Ignored files are not listed, unless `--ignored` option is in effect,
 in which case `XY` are `!!`.

base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
-- 
gitgitgadget
