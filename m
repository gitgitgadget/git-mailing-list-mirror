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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B12EC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A196246B4
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 23:36:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaaMvWH3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgKRXfs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 18:35:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgKRXfr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 18:35:47 -0500
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50AC0C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:35:47 -0800 (PST)
Received: by mail-wm1-x343.google.com with SMTP id p22so5123915wmg.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 15:35:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FQF+ROJVDM7lAHjqM81W5GX6XbNAC3KY7LMI/8Fgo8s=;
        b=MaaMvWH3XfVrCLPNkEjWTd2AItfVhbMInbSZfqcgHvN4dRiNIhP6xR6Jg58u0sl/sM
         2arDWJhK17/eyHcbGCf9Kixl29QHWO006sL2bpheRmWZ6yhWckLcYJIMNvgxUvh/VyXN
         Mavkj7li604bPzmScc3gsXuYKESBS8+gVgaTfoT0n6aLgvoNO34NuK5aNv3cKlUA0G+m
         U1VZYs+9tHfSdvjVFGG4p2/mZfcL/YWQgnDREwNBLNBzB3VbkbsptGf9Tnn0nNnTuDrZ
         cHRCPq0l1PLI533GPCDoW7d8lBWYqt4UiUjUUzMHwpwpqaVtvPHHhb4uSr8nnE66ry3d
         x3gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FQF+ROJVDM7lAHjqM81W5GX6XbNAC3KY7LMI/8Fgo8s=;
        b=fUDI5XYKDpFsUjOq3pvyeELUHbthpnuQ1sZcJo3LU8DBfp+p7d3xtlFhbhx7t2ZJXX
         Kvj+rPAD/G67ZbkgSPrlvI9nxHaluGgta9yisLcWKIBhTvBATLFEc9Drkqx0PJq2mHla
         h3ljyKYKJcFGDsRb9yEUseX5DgUBszs+sMTXi68aNxWfr136iPgi6Y/LrtWtXJjS07Xq
         N50578lyUfeWPDauo+geBF3e12PdYkF9EM277ir1WhIZUcsV4edt0Gs/lslnjbv4SmZe
         2zF6ofRQTU2eo5ntTFy3NZiM3N0z5BN6XXG0qf8iL7qZqBuea7Jn8iwm1LnI561TdbmG
         Yl6A==
X-Gm-Message-State: AOAM53383id2RRnxMss1ghe3yDgXWNHbwlz1KSd3eQ4fr7yH2+jDNYub
        G3/J93b03q0NPOkX+FRtGl/Gs7Bfpy4=
X-Google-Smtp-Source: ABdhPJwiIgDTi1ereJ6MsaAwQ6wl6fjqx4o9Mjc6P4r89oeaBvL9R8WohW1mJ7RHWu5JLzKMP5TJJg==
X-Received: by 2002:a05:600c:2119:: with SMTP id u25mr1448019wml.53.1605742545887;
        Wed, 18 Nov 2020 15:35:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s4sm34835687wro.10.2020.11.18.15.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 15:35:45 -0800 (PST)
Message-Id: <pull.794.v2.git.1605742544801.gitgitgadget@gmail.com>
In-Reply-To: <pull.794.git.1605727594021.gitgitgadget@gmail.com>
References: <pull.794.git.1605727594021.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 23:35:44 +0000
Subject: [PATCH v2] t4015: let the test pass with any default branch name
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We do not need to hard-code the actual branch name, as we can use the
`test_commit` function to simplify the code and use the tag it
generates, thereby being a lot more precise in what we want.

Strangely enough, this test case would have succeeded even with an
overridden default branch name, obviously for the wrong reason. Let's
verify that it passes for the expected reason, by looking for a
tell-tale in Git's output.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    t4015: let the test pass with any default branch name
    
    Aaaaand another issue, also found while working on 
    https://github.com/gitgitgadget/git/pull/762.
    
    Changes since v1:
    
     * We now use test_commit and the tag it creates, rather than the
       reflog.
     *

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-794%2Fdscho%2Ft4015-and-default-branch-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-794/dscho/t4015-and-default-branch-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/794

Range-diff vs v1:

 1:  5467cae0dd ! 1:  2f6d07fe90 t4015: let the test pass with any default branch name
     @@ Metadata
       ## Commit message ##
          t4015: let the test pass with any default branch name
      
     -    We do not need to hard-code the actual branch name, as we have access to
     -    the reflog and can be a lot more precise at what we want.
     +    We do not need to hard-code the actual branch name, as we can use the
     +    `test_commit` function to simplify the code and use the tag it
     +    generates, thereby being a lot more precise in what we want.
      
          Strangely enough, this test case would have succeeded even with an
          overridden default branch name, obviously for the wrong reason. Let's
     @@ Commit message
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## t/t4015-diff-whitespace.sh ##
     -@@ t/t4015-diff-whitespace.sh: test_expect_success 'combined diff with autocrlf conversion' '
     +@@ t/t4015-diff-whitespace.sh: test_expect_success 'rename empty' '
     + test_expect_success 'combined diff with autocrlf conversion' '
     + 
     + 	git reset --hard &&
     +-	echo >x hello &&
     +-	git commit -m "one side" x &&
     ++	test_commit "one side" x hello one-side &&
     + 	git checkout HEAD^ &&
       	echo >x goodbye &&
       	git commit -m "the other side" x &&
       	git config core.autocrlf true &&
      -	test_must_fail git merge master &&
     -+	test_must_fail git merge @{2} >actual &&
     ++	test_must_fail git merge one-side >actual &&
      +	test_i18ngrep "Automatic merge failed" actual &&
       
       	git diff >actual.raw &&


 t/t4015-diff-whitespace.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 8bdaa0a693..47f0e2889d 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -877,13 +877,13 @@ test_expect_success 'rename empty' '
 test_expect_success 'combined diff with autocrlf conversion' '
 
 	git reset --hard &&
-	echo >x hello &&
-	git commit -m "one side" x &&
+	test_commit "one side" x hello one-side &&
 	git checkout HEAD^ &&
 	echo >x goodbye &&
 	git commit -m "the other side" x &&
 	git config core.autocrlf true &&
-	test_must_fail git merge master &&
+	test_must_fail git merge one-side >actual &&
+	test_i18ngrep "Automatic merge failed" actual &&
 
 	git diff >actual.raw &&
 	sed -e "1,/^@@@/d" actual.raw >actual &&

base-commit: e31aba42fb12bdeb0f850829e008e1e3f43af500
-- 
gitgitgadget
