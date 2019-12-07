Return-Path: <SRS0=g+dp=Z5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9914C2D0BE
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C1D1624673
	for <git@archiver.kernel.org>; Sat,  7 Dec 2019 17:47:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IS9iNi8Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726552AbfLGRru (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 7 Dec 2019 12:47:50 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41772 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbfLGRrt (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 7 Dec 2019 12:47:49 -0500
Received: by mail-wr1-f66.google.com with SMTP id c9so11318093wrw.8
        for <git@vger.kernel.org>; Sat, 07 Dec 2019 09:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=02wPiKcxW3MLMy/ukr6QS7zsK/Dkfk9fBmn17gWfJQA=;
        b=IS9iNi8ZoentsM3ihrcWileJB0C9Lbz7x+aRP2+Q7tQbyx1qQMcLPV6cksJ42MBMd0
         vMLMHJUs4QhRQsMwEaK4cQ6Bc5oFXZLMeApk+BgdWJmfoMA99m9i7KpJ04NrbFQD1OwT
         iTM4NxKaQbDQVW8m0psfpkk6jtWzL92ZwFJ8TRy5+f3piwtjZHsGLdgl3nc7ZqaVVgMX
         UT2wMt9ATlcNdMMki6UijHxqfn7Ubi0stVL3W3NcjxOBB4PwFUmtz/+CNsWpd6HJNISl
         sYDNxBLQObAJnsKJF4de4Poq1ayksscBUQYNvL0Fyvhij3Pnp95C6GfjA7fc2oH6zN3A
         Q3Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=02wPiKcxW3MLMy/ukr6QS7zsK/Dkfk9fBmn17gWfJQA=;
        b=gVJD3d1zJIjNFSUQC9aijUu50yjiexHHWvpSgCel1/uuwnhbJKdAwy6Sa2QbdYqx7A
         Y2jmDRcWzchC8QAPUvD6y36s0zdemMQpjDEooVzc20WGst2pA2y+nVmlPIdQ2xegoMlv
         VfCzN0w6g8YNeTmQ0eys0SJlsUlbwHCCZ2pItrTlSyfc3UW+zVEpn1eVxu6VwRqjsQH3
         TSXfGwiRobq4njP9fTWMhKdPu6HxhYg9CsqHMz+TIWiFUz8SQje2VhBoh1uYENZkV2sB
         QggzdhcqtIrUooJ2NQivvtN97sCawzEJXFb79y2sH0HnmHg9sJjTg7gMsAakbVM4cr8I
         K0oA==
X-Gm-Message-State: APjAAAXyqOSBZhjuAk2zdU9RIZU7sZKX8g8DvXlT0og0oUC6gSTptlUZ
        8gJOpwsktFzFdtPY7I5cMdDY6M25
X-Google-Smtp-Source: APXvYqyrOEOeGrlQ2cicyfI0Gq/INE6+drn9OCt8+Eve25wiPlQs1EeNTgpNP5H9J5gcoW1Z68LoYg==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr23210063wrx.26.1575740867415;
        Sat, 07 Dec 2019 09:47:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w22sm7181937wmk.34.2019.12.07.09.47.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Dec 2019 09:47:47 -0800 (PST)
Message-Id: <e425ccc10fbc1f5e135eb59ffc84626f9d0ae4ff.1575740863.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
References: <pull.463.v4.git.1575498577.gitgitgadget@gmail.com>
        <pull.463.v5.git.1575740863.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 07 Dec 2019 17:47:31 +0000
Subject: [PATCH v5 03/15] git-p4: select P4 binary by operating-system
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

The original code unconditionally used "p4" as the binary filename.

Depending on the version of Git and Python installed, the perforce
program (p4) may not resolve on Windows without the program extension.

Check the operating system (platform.system) and if it is reporting that
it is Windows, use the full filename of "p4.exe" instead of "p4"

This change is Python 2 and Python 3 compatible.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 60c73b6a37..65e926758c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -75,7 +75,10 @@ def p4_build_cmd(cmd):
     location. It means that hooking into the environment, or other configuration
     can be done more easily.
     """
-    real_cmd = ["p4"]
+    if (platform.system() == "Windows"):
+        real_cmd = ["p4.exe"]
+    else:
+        real_cmd = ["p4"]
 
     user = gitConfig("git-p4.user")
     if len(user) > 0:
-- 
gitgitgadget

