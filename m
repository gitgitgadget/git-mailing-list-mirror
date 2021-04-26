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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB56C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91B4661078
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 19:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239864AbhDZTB2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 15:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240334AbhDZS7z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 14:59:55 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F4FC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:59:13 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x7so56945801wrw.10
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 11:59:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=SYSV8YN05/nny5XJ9WGc6MsLTSxfNGoq6L3RAtESHL8=;
        b=MjiQZ7K+3whHdsiVy/PEo1T9LIX4CKgLpqEHr28awrzKKj9bJKrEyI8xW3VNYYs9Cv
         Ph3x2HwdZiVj7ZsEfEEF2FzxXIg6feWZyZuasKIR+wPg8l8Ufh/GSxWq/oNhpsEuDNwH
         Mw8BqmCwNMdnTNLAy5VxV/pry2ubC/JYkvtAK5ERQ8prA4hie3vty2e0dPzRnr7u16og
         o6qXZm7l8L+S6IuaNm4GgluKhpz5nJOiVDmsS1865iGHuKwC8BddG+DsUfYXmb/9VIhT
         rEep0YiKMqhABwEZjal0UU8Jb4Q7tKScv3aEXcagULlzDMYok1RJ7v2gqpRSJlKVOBLO
         WHcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SYSV8YN05/nny5XJ9WGc6MsLTSxfNGoq6L3RAtESHL8=;
        b=a0QnroiJGof0GYMJ7ej66AVzltnv3lmFAqJc/uMlSLGJuKOZ8o72jTJJjA1K3oi/tX
         0Fe9NoubV9ViQwIC2emC0lrxryGgRrJ/Mnz6cg0o9jQnYsg8uw5KjpMHxtU9ckDMBWXk
         DhfLVoxblAPsgcPvjv5BxvxwxQJpbV3dS/LpAYbYJBjXspQjLUpGEoLWgaldDslevLaT
         /6j4WM+eVdObR4ouG3ZH5wT49tkZoVpV2zlSveq8WMwrRX3SvoAa2wK8XoNL3gXN4tJ3
         cJZxa/fhP0wswJUXzV5N573VKO4rxIMwif6fVR8UqLuZRja74BdOTRBbs15SZd4QC02t
         yfmw==
X-Gm-Message-State: AOAM531NHwRZVgQvOJa8Sr/FVeRtwxbX/gebOVZQycUeYgI5cWGE0SP/
        jZWkL4yDG5oygRPBtbZnTuTNI8B6hIE=
X-Google-Smtp-Source: ABdhPJy9HgZChvA+kpI1HuKH4w+xKE3WGmphftJpBty2mvYiuTpzjbY4thImzqpPIzGTgwnBi/qtuw==
X-Received: by 2002:adf:f707:: with SMTP id r7mr6248984wrp.54.1619463552037;
        Mon, 26 Apr 2021 11:59:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u8sm1201127wrp.66.2021.04.26.11.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 11:59:11 -0700 (PDT)
Message-Id: <pull.940.git.1619463549689.gitgitgadget@gmail.com>
From:   "Peter Oliver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Apr 2021 18:59:09 +0000
Subject: [PATCH] doc: point to diff attribute in patch format docs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Peter Oliver <git@mavit.org.uk>, Peter Oliver <git@mavit.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Peter Oliver <git@mavit.org.uk>

From the documentation for generating patch text with diff-related
commands, refer to the documentation for the diff attribute.

This attribute influences the way that patches are generated, but this
was previously not mentioned in e.g., the git-diff manpage.

Signed-off-by: Peter Oliver <git@mavit.org.uk>
---
    doc: point to diff attribute in patch format docs
    
    From the documentation for generating patch text with diff-related
    commands, refer to the documentation for the diff attribute.
    
    This attribute influences the way that patches are generated, but this
    was previously not mentioned in e.g., the git-diff manpage.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-940%2Fmavit%2Fdiff-gitattributes-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-940/mavit/diff-gitattributes-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/940

 Documentation/diff-generate-patch.txt | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/diff-generate-patch.txt b/Documentation/diff-generate-patch.txt
index 2db8eacc3ec7..ec506155fc74 100644
--- a/Documentation/diff-generate-patch.txt
+++ b/Documentation/diff-generate-patch.txt
@@ -11,7 +11,7 @@ linkgit:git-diff-files[1]
 with the `-p` option produces patch text.
 You can customize the creation of patch text via the
 `GIT_EXTERNAL_DIFF` and the `GIT_DIFF_OPTS` environment variables
-(see linkgit:git[1]).
+(see linkgit:git[1]), and the `diff` attribute (see linkgit:gitattributes[5]).
 
 What the -p option produces is slightly different from the traditional
 diff format:
@@ -74,6 +74,10 @@ separate lines indicate the old and the new mode.
       rename from b
       rename to a
 
+5.  Hunk headers mention the name of the function to which the hunk
+    applies.  See linkgit:gitattributes[5] for details of how to tailor
+    to this to specific languages.
+
 
 Combined diff format
 --------------------

base-commit: 48bf2fa8bad054d66bd79c6ba903c89c704201f7
-- 
gitgitgadget
