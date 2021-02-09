Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CAC5C433DB
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:16:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5D2364ECC
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 19:16:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233486AbhBITPz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 14:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233631AbhBITIW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 14:08:22 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BA1C06121F
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 11:07:06 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id v15so23361174wrx.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 11:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=4XMZpFMUtZ8+ERe8Svdj7qG2dc2YOmRuEyiBrplXsng=;
        b=GLUYMAcKc6Hr/AX8yboPp9bKXEQzYdfZlX+F62n9vN7NHs0Ihv+du3Lta70ivI62wx
         riw9kF/0nU7ZSqWJqcHLpCxTxojLcqNHYDWQxnbHB+8BENeobRkWwilYRuRqH2MZ/UKx
         te9/TgGYceh9Q6bk1LpI/axv67mu0jbRNmycOBziKRBwk1cTlYabxngsWGG/hjYRi7Zt
         taft7ibKvOmfDofL+TfGSwKBLdtNg+34qnKhG69K1kwzXe1X5b5bynSDIYsSQD0X0dW1
         PKYqNuU1zftTqMrVCb8GCtseEHTF62v1zVkmJGVP7ocIV6no/OTV2wqCnk46EFwucv1p
         C34w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=4XMZpFMUtZ8+ERe8Svdj7qG2dc2YOmRuEyiBrplXsng=;
        b=qgN58DTe6ona0aLoHdq4iXIDm+EkEgsKpXuSB5CvxRrj/xp9X50TddxvreVFE0w8SJ
         9kwVKOHozHHuqIINrGMpwrQw7r57bXe5DifVVRj8JXj+0tySHyART+2SnmEaABOT+29c
         RkuTgjxbzJNvZ1mg113VoftOPZyK51g1tznhJiqMByJzo/L8+KRR7cmIi0uy7vhy7fi3
         lceBRH85YPxsOuH0gCGEUSxG7uk2doVTCjykwkUyLggsFXIi/Yhq2EbzVY6tbVAOWkZI
         /Hya/zmBmhm0EXKTTPJPlGq++tWyTzEBN8MMkr2Igf6vHvdCeLyCS4ctgvHOIflCwQx7
         hzyQ==
X-Gm-Message-State: AOAM533os/xjG7WRy1dLxgxDiIo+Ta8+I+WCdGcHZCXOXFmGnE3fjJyn
        KuHRVuYkZrMthmM+MoBK50Be/pE26Ok=
X-Google-Smtp-Source: ABdhPJzjq0dxHITV7w/w9uB+wfFjUEO8yDWfBN31/Uj7Hs9UgglptF6J06Hexxt7ELNb48h3B079ag==
X-Received: by 2002:a5d:6189:: with SMTP id j9mr27067572wru.256.1612897625295;
        Tue, 09 Feb 2021 11:07:05 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o12sm37530458wrx.82.2021.02.09.11.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 11:07:04 -0800 (PST)
Message-Id: <pull.872.git.1612897624121.gitgitgadget@gmail.com>
From:   "Christian Walther via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Feb 2021 19:07:03 +0000
Subject: [PATCH] doc: mention bigFileThreshold for packing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Walther <cwalther@gmx.ch>,
        Christian Walther <cwalther@gmx.ch>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Christian Walther <cwalther@gmx.ch>

Knowing about the core.bigFileThreshold configuration variable is
helpful when examining pack file size differences between repositories.
Add a reference to it to the manpages a user is likely to read in this
situation.

Signed-off-by: Christian Walther <cwalther@gmx.ch>
---
    doc: mention bigFileThreshold for packing
    
    I recently spent a lot of time trying to figure out why git repack would
    create huge packs on some clones of my repository and small ones on
    others, until I found out about the existence of the
    core.bigFileThreshold configuration variable, which happened to be set
    on some and not on others. It would have saved me a lot of time if that
    variable had been mentioned in the relevant manpages that I was reading,
    git-repack and git-pack-objects. So this patch adds that.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-872%2Fcwalther%2Fdeltadoc-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-872/cwalther/deltadoc-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/872

 Documentation/git-pack-objects.txt | 4 ++++
 Documentation/git-repack.txt       | 4 ++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/git-pack-objects.txt b/Documentation/git-pack-objects.txt
index 54d715ead137..59150ded4bef 100644
--- a/Documentation/git-pack-objects.txt
+++ b/Documentation/git-pack-objects.txt
@@ -97,6 +97,10 @@ base-name::
 	side, because delta data needs to be applied that many
 	times to get to the necessary object.
 +
+Note that delta compression is never used on objects larger than the
+`core.bigFileThreshold` configuration variable (see
+linkgit:git-config[1]).
++
 The default value for --window is 10 and --depth is 50. The maximum
 depth is 4095.
 
diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index 92f146d27dc3..0a7038ec4ad8 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -96,6 +96,10 @@ to the new separate pack will be written.
 	affects the performance on the unpacker side, because delta data needs
 	to be applied that many times to get to the necessary object.
 +
+Note that delta compression is never used on objects larger than the
+`core.bigFileThreshold` configuration variable (see
+linkgit:git-config[1]).
++
 The default value for --window is 10 and --depth is 50. The maximum
 depth is 4095.
 

base-commit: fb7fa4a1fd273f22efcafdd13c7f897814fd1eb9
-- 
gitgitgadget
