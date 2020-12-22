Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9313CC433E0
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 15:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5178822B2B
	for <git@archiver.kernel.org>; Tue, 22 Dec 2020 15:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727952AbgLVPdF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 10:33:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbgLVPdE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 10:33:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6837BC0613D3
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 07:32:24 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q18so14935592wrn.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 07:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=r5z/E12NYzETvfw6QUyONvXhaTnymkv+1GGfE/Hgjew=;
        b=XD8i4qk8seU7bXYn2vq2YWKLzFH5Xf/rDTFDcBs0CFk3CLA3eOd6Xn62DfZ/NlCxZV
         crtyHtciRh0bUwoiw7LY6RNLQQa4J1rk+1lQJxhwhqIP04cLkzQbOrdyoq/J+FkGLypC
         bhefpinkvUdGpQoq9Tpey9BxtiDdnF6je3/sVcUCEm8dTwqaCyCsxo5N12dmXC2j8lqp
         Hzu042vX8p6iLePLjnQD8b7RPAgNiQVVpAYQmMAtmJkkBuAUXnDwc1jlI6FA6K/dEOsL
         a4K4/rhsWpnEXW2B//a7ZQsmGveaB7qBLIMDAKcDKzaQJFbYE7xEvDXHHBW1RSPXhwcF
         VQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=r5z/E12NYzETvfw6QUyONvXhaTnymkv+1GGfE/Hgjew=;
        b=fSZfDg8VFbbB0heaNC8N5o/9zhGmSMApW4TgO0DbmvG8jh6hN1rJ1tUCUqv3+4KA8G
         PxHIjjdUKYn1Nd/kjAb+4WJ1Ra/r2TMc0taZnLVwDejqam+S2Kc6HEYp4ahh8GHJwL6w
         EkwuC1+j2LnFvEoVsEjGTinNbM2Q7TxUIgoJ2T4npUAIe9TBMpAnGetGMFxEhhej4clY
         Rfxp15k0Ats0HcTFH46vtIVIy2fet0XQVsBiGItAJ+4l7Gx5dISJqjO3HD6IBMnHk2ME
         d1tWqmWygfQXXKGNdRoQOj2/8VQ4v6G2vqNGtEQoZFID2fHB1fXhfGyEgQ6u3Edq3JfB
         OtkQ==
X-Gm-Message-State: AOAM533KYuWjQMf1nnCUwnqbq/nuO4HLx7Ujbf9bjguE0nTYUIDCIiZM
        xTmwjo2lVk+LThjypkru7k0ixx3amz0=
X-Google-Smtp-Source: ABdhPJxodQCqM3+S4jNAwMbqI4oJemeI2klR/r29h8o32dXn/1vJUwLZZdKaUpfCOdXU3ixDyPAa9A==
X-Received: by 2002:adf:fbc5:: with SMTP id d5mr24523422wrs.82.1608651141846;
        Tue, 22 Dec 2020 07:32:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x25sm26787983wmc.3.2020.12.22.07.32.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 07:32:21 -0800 (PST)
Message-Id: <pull.934.git.git.1608651140403.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Dec 2020 15:32:20 +0000
Subject: [PATCH] git.txt: fix typos in 'linkgit' macro invocation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

The 'linkgit' Asciidoc macro is misspelled as 'linkit' in the
description of 'GIT_SEQUENCE_EDITOR' since the addition of that variable
to git(1) in 902a126eca (doc: mention GIT_SEQUENCE_EDITOR and
'sequence.editor' more, 2020-08-31).

Fix that.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
    git.txt: fix typos in 'linkgit' macro invocation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-934%2Fphil-blain%2Ffix-linkgit-git1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-934/phil-blain/fix-linkgit-git1-v1
Pull-Request: https://github.com/git/git/pull/934

 Documentation/git.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index c463b937a86..aaa3668a7e9 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -609,8 +609,8 @@ other
 `GIT_SEQUENCE_EDITOR`::
 	This environment variable overrides the configured Git editor
 	when editing the todo list of an interactive rebase. See also
-	linkit::git-rebase[1] and the `sequence.editor` option in
-	linkit::git-config[1].
+	linkgit::git-rebase[1] and the `sequence.editor` option in
+	linkgit::git-config[1].
 
 `GIT_SSH`::
 `GIT_SSH_COMMAND`::

base-commit: 6d3ef5b467eccd2769f1aa1c555d317d3c8dc707
-- 
gitgitgadget
