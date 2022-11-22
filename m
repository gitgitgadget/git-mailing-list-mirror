Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2077C433FE
	for <git@archiver.kernel.org>; Tue, 22 Nov 2022 20:27:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiKVU1s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Nov 2022 15:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbiKVU1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Nov 2022 15:27:46 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0DCF5BB
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 12:27:44 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id t4so11620855wmj.5
        for <git@vger.kernel.org>; Tue, 22 Nov 2022 12:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=B7x7WdnO1tzsXNMW/nWgD+/B866p4sIK4INEvYOhz3A=;
        b=A7uOStjsxXGfp5Fs4vyIGTY3v9bh3EoyaCP8Dz5ZBxwGQu9LzV6r6OjkekOzV1DClp
         I2cB9uYBjNjCU+R+J21tlhc9X6vWfsdoWz7NLjIrOfW57f8S/5eLXRtHP+c0vHTXbQBr
         3fds7duooLIEOhNSVb54zajop5r/LO2W2r8AmGBVBUKKJxnRemoHJ+Fz7mzrPNqa4p+W
         ItP8k8fwMmiwbBTqFOXLy+1hGBQKBZwfRY6EOIKUYQPlmXD2VRxLUM61OLf4xJY0EWpV
         pjH4QuV4m2EPcauMAa5Z4TBdaqYJuZluZU+kMhrGPXc9g+lVCwyV0yzaxO2eWsYDoWLL
         5/dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B7x7WdnO1tzsXNMW/nWgD+/B866p4sIK4INEvYOhz3A=;
        b=J3Q6Ll1J3DXdMx+HPZfRd9iK14H8AM1TXR8/kCQZzFczKJtOFkQOtCWYuXt6LOwRtr
         NMh2obzTWkxqCnIq21afY02mR+KJT+ktNES/aeivyYf9E0MEhSKg6uXQLazV+ecci1uj
         1NvD6ZKFas7JH97Jwqn/+kB2Z+TpEJ209fpqYPF6wELB1Ac961mm/UahCHUh1OPeAR3C
         +pW8aRaP0n/QbGlb6R+kBXDvgL1p73mHtTqIvxy8mlaL4OZp0KL4bOL0bM2RLFTPdYoT
         V4L0BNwAUl5Dlkgd744aCmMJdYtCmisxsdQdgFunJyMdG88TorK3X1fRMnSxE3yXNIY1
         yXjA==
X-Gm-Message-State: ANoB5plB8gKoUePd+hLP+CPwwpcafMpTIs1HDHx999kMSwFRaTWI/b4+
        q2Fbr3hZNx7HdJjx2zlqLXc98MCPNWc=
X-Google-Smtp-Source: AA0mqf6YarXv6kw1mjVOTKAJPkLnepKpAluzC9NdoOWvEAs1dGdEpwOLjc3sAatOJ1+o8ApQb3r8Bg==
X-Received: by 2002:a05:600c:3d1b:b0:3cf:670e:63cc with SMTP id bh27-20020a05600c3d1b00b003cf670e63ccmr21997202wmb.150.1669148862796;
        Tue, 22 Nov 2022 12:27:42 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id k33-20020a05600c1ca100b003b3365b38f9sm20140334wms.10.2022.11.22.12.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Nov 2022 12:27:42 -0800 (PST)
Message-Id: <pull.1385.git.git.1669148861635.gitgitgadget@gmail.com>
From:   "Andreas Hasenack via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 22 Nov 2022 20:27:41 +0000
Subject: [PATCH] chainlint.pl: fix /proc/cpuinfo regexp
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Andreas Hasenack <andreas.hasenack@canonical.com>,
        Andreas Hasenack <andreas.hasenack@canonical.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Andreas Hasenack <andreas.hasenack@canonical.com>

git commit 29fb2ec384a867ca577335a12f4b45c184e7b642 introduced a
function that gets the number of cores from /proc/cpuinfo on some
systems, notably linux.

The regexp it uses (^processor\s*:) fails to match the desired lines in
the s390x architecture, where they look like this:

processor 0: version = FF, identification = 148F67, machine = 2964

As a result, on s390x that function returns 0 as the number of cores,
and the chainlint.pl script exits without doing anything.

Signed-off-by: Andreas Hasenack <andreas.hasenack@canonical.com>
---
    chainlint.pl: fix /proc/cpuinfo regexp

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1385%2Fpanlinux%2Fupstream-fix-cpuinfo-regexp-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1385/panlinux/upstream-fix-cpuinfo-regexp-v1
Pull-Request: https://github.com/git/git/pull/1385

 t/chainlint.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/chainlint.pl b/t/chainlint.pl
index 976db4b8a01..31cc086f964 100755
--- a/t/chainlint.pl
+++ b/t/chainlint.pl
@@ -656,7 +656,7 @@ sub ncores {
 	# Windows
 	return $ENV{NUMBER_OF_PROCESSORS} if exists($ENV{NUMBER_OF_PROCESSORS});
 	# Linux / MSYS2 / Cygwin / WSL
-	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor\s*:/, <>)); } if -r '/proc/cpuinfo';
+	do { local @ARGV='/proc/cpuinfo'; return scalar(grep(/^processor[\s\d]*:/, <>)); } if -r '/proc/cpuinfo';
 	# macOS & BSD
 	return qx/sysctl -n hw.ncpu/ if $^O =~ /(?:^darwin$|bsd)/;
 	return 1;

base-commit: a0789512c5a4ae7da935cd2e419f253cb3cb4ce7
-- 
gitgitgadget
