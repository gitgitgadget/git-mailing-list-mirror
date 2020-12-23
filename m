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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C27DC433E0
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 12:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAC6922482
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgLWMtf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Dec 2020 07:49:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgLWMtf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Dec 2020 07:49:35 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41C9C0613D3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 04:48:54 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t16so18532782wra.3
        for <git@vger.kernel.org>; Wed, 23 Dec 2020 04:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=Oqg0GwYHx42H4vPP/iEn2b6Xus3THcH+/ec7W4fKEb8=;
        b=o5dUvkOeRdCxd7cVuY69hfjkM9V+0Tc3psqGhoviNDpozuYMOEgmj6uUwduxMf/AYW
         8DH8kK3fhqn4uhIKRp4lb8nrWiuW2p9DRFQhUsmq4ekGGHMyCDya31fMNh6D1Wf/8MT/
         S18LM32sn9mo4nF6DIyjJHFflS/XdX52r6U94zmwgvEFATpUZfDjvDGF+KSEAmh6Pz2Z
         P+3KVlIAH8S+CYG9F25ihP6dzQl2ay78gBQyuiHgE4VCVzPHn4e3QdudOQU7hmz4r2f/
         xeZezN1g1ZAR7j5A2jT+pwHLUhad7CiTryPc9b94zPMQvqhbIe9hFaOy+hWwc+QEVsuv
         ixhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Oqg0GwYHx42H4vPP/iEn2b6Xus3THcH+/ec7W4fKEb8=;
        b=Pfh9VIJHKdynrI+aK2usyeJMNbH+yuhu3L14Sdt0EgeH5dHblDSO5f2AFQ6uKjUQ7E
         WVZKJZKj08J7gj/0erQ+0kUBU2PPhoI32yX9/rsR+URogaXd6xkz77mEQnoOgt9CmFqv
         CTdXn9BnkpcCxm7pFnP4effKy9r6NsTRj0NtJZXE5sjcbvsSpgPhJXYLldWQInfT06SY
         Y9w2XpOzp4EKXz8Woxv50uMQrab+iUvxj8yCFMk1GC8jZrU44AH2GA9pm4SFKh+JD4Qy
         eEKyNbYFekOxo2kDIU5brQYe4pG7a7CcexdxkQLkfkK9GDTI6GGuPp+F+JmPZpxYuSxk
         j1GA==
X-Gm-Message-State: AOAM532LbEytrdsQCuo3+jwo7cxl/8ol+QBr0hbAMcE4GcKdmIVmowUj
        5AV7omrC/MX309VRGOSF82uqgcjxmeA=
X-Google-Smtp-Source: ABdhPJxPMf/s9gJcUKXgJR7e/4iA84Nzdb0YHWHU6OH/qlc/1dlcqRvaEiao0D8bd1EJ7FeoN0dXfg==
X-Received: by 2002:a5d:464b:: with SMTP id j11mr29223969wrs.227.1608727733192;
        Wed, 23 Dec 2020 04:48:53 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n12sm37393083wrg.76.2020.12.23.04.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Dec 2020 04:48:52 -0800 (PST)
Message-Id: <pull.823.git.1608727731733.gitgitgadget@gmail.com>
From:   "Daniel Levin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Dec 2020 12:48:51 +0000
Subject: [PATCH] git-p4: fix syncing file types with pattern
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Yang Zhao <yang.zhao@skyboxlabs.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Daniel Levin <dlevin@roku.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Daniel Levin <dlevin@roku.com>

Example of pattern file type: text+k

Text filtered through the p4 pattern regexp must be converted from
string back to bytes, otherwise 'data' command for the fast-import
will receive extra invalid characters, followed by the fast-import
process error.

CC: Yang Zhao <yang.zhao@skyboxlabs.com>
Signed-off-by: Daniel Levin <dendy.ua@gmail.com>
---
    git-p4: fix syncing file types with pattern
    
    Example of pattern file type: text+k
    
    Text filtered through the p4 pattern regexp must be converted from
    string back to bytes, otherwise 'data' command for the fast-import will
    receive extra invalid characters, followed by the fast-import process
    error.
    
    Signed-off-by: Daniel Levin dendy.ua@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-823%2Fdendy%2Fp4-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-823/dendy/p4-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/823

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 4433ca53de7..90b02f6b22c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3031,7 +3031,7 @@ def streamOneP4File(self, file, contents):
             regexp = re.compile(pattern, re.VERBOSE)
             text = ''.join(decode_text_stream(c) for c in contents)
             text = regexp.sub(r'$\1$', text)
-            contents = [ text ]
+            contents = [ encode_text_stream(text) ]
 
         if self.largeFileSystem:
             (git_mode, contents) = self.largeFileSystem.processContent(git_mode, relPath, contents)

base-commit: 898f80736c75878acc02dc55672317fcc0e0a5a6
-- 
gitgitgadget
