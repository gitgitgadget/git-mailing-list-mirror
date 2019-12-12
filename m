Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F987C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FDFF2077B
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 19:46:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lYGQ6A1/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730735AbfLLTqd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Dec 2019 14:46:33 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:39400 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730722AbfLLTqc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Dec 2019 14:46:32 -0500
Received: by mail-wm1-f68.google.com with SMTP id d5so3924641wmb.4
        for <git@vger.kernel.org>; Thu, 12 Dec 2019 11:46:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=nWkCTJZjSMSdLs+XSch9fbFow4sltXqZMPDCgnvReps=;
        b=lYGQ6A1/Zy1mrGqbWVUxRRU4mUZPaR3Wb0ej3Pbzi71AWreqrXwiJjLCJTdEuj/O8V
         mkjOYP1wUHC5BMqLMgzlPJmOqt3vVvCpsvBX3XV/Lvso4+c6xOyJczcsunq0dZL75VKd
         /K3u0HDvRDlgE8sa+F147xnbUPQABgPj5Gnek5McEYN/p4eoDCIq5QEbYF2BzCS3jxYb
         v0PtyyBRsyT0gI8TWVzV/QVh2wDZ7I1R4lWAtPhmXfdEe7abOp/0TmzZFVeiTEnOWSfN
         j70GaPZsxRiRguaGHI0KBO0xB2ueCP5Gp9cq9OGcgRI3w00htolGm4DScPvAcCBnZPTa
         vrAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=nWkCTJZjSMSdLs+XSch9fbFow4sltXqZMPDCgnvReps=;
        b=i3v/ViR2fBFAqe+d872hdNrC9p9w62ckwsGvXIbkK8/eQ9jCkujb2GQap5xy1D8PxX
         ag0OkStzXSf5/HC2cdtkT0ulCf5YAn6/vlLc/kptZvd3lHiCv8fD9EDzvkiblz9kaDug
         sUjmD1PK+pt2wKaB6UPxJ0JZ44AxXhOU6aPdUb1Heg0OYpnMeZ8W/yh+X2JlOH+9q6Qv
         O913oRwKoJ8O+3ht/uoUb9IRdtJjFUwFXUHafSlPjc3AwbRLsVTiBJNWgBYPsV4Ih1oe
         1XfzR5+X6NNEFTl9RwrXxJZK8gqqnSw4vpkC+k1zAcH9NbaofEUm4h+upC0AEICOpfJw
         tG8Q==
X-Gm-Message-State: APjAAAXqEDIvGrZO0ZEhbc+Y44FVe1Y/XYpOtAmrhUAvu4Qx/Ms253IO
        cXyG0iveuM4FeurPFb37P8RWmzqW
X-Google-Smtp-Source: APXvYqxDDRaDH7cpcnTxzzZJ8ZB0o9sAg0UVjXIEhvxHb4Br/X5S1wz2c5ZvYUPc+Usrq3D4tPHdQA==
X-Received: by 2002:a05:600c:2144:: with SMTP id v4mr8993524wml.31.1576179990548;
        Thu, 12 Dec 2019 11:46:30 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a16sm7037580wrt.37.2019.12.12.11.46.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Dec 2019 11:46:29 -0800 (PST)
Message-Id: <5c5c9816322583e36b59cb0649bb03fb6e06e8a7.1576179987.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
        <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Dec 2019 19:46:25 +0000
Subject: [PATCH v3 2/4] git-p4: show detailed help when parsing options fail
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

When a user provides invalid parameters to git-p4, the program
reports the failure but does not provide the correct command syntax.

Add an exception handler to the command-line argument parser to display
the command's specific command line parameter syntax when an exception
is thrown. Rethrow the exception so the current behavior is retained.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index a05385ee2a..45c0175a68 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4145,7 +4145,12 @@ def main():
                                    description = cmd.description,
                                    formatter = HelpFormatter())
 
-    (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    try:
+        (cmd, args) = parser.parse_args(sys.argv[2:], cmd);
+    except:
+        parser.print_help()
+        raise
+
     global verbose
     verbose = cmd.verbose
     if cmd.needsGit:
-- 
gitgitgadget

