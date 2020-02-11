Return-Path: <SRS0=9mHE=37=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0752AC35242
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD8672173E
	for <git@archiver.kernel.org>; Tue, 11 Feb 2020 18:58:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uXMukagN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730866AbgBKS6S (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Feb 2020 13:58:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:33737 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730832AbgBKS6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Feb 2020 13:58:13 -0500
Received: by mail-wr1-f65.google.com with SMTP id u6so13851574wrt.0
        for <git@vger.kernel.org>; Tue, 11 Feb 2020 10:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BSwyS9YvmnfToLZfeSQ4jy5MqtfPwz3CBOKhQd3KTp0=;
        b=uXMukagNThgM/Wjnnqt60bxiSHR4J5/a60xkkbsiprF471a+ByIQo8ME8jmBw7s3ck
         PYm1ew7Fyna0PYgs2fdUKa8yiW1WSIJ+/klwlO6BQ8AcIr+22c3qz2eieUYDNePe0vpq
         loQe/aMmbg+nsZjzzMj5vpiQAX5I3yIhfANobybxUk8JqCcyjhmqNS61jQeyMEhAsPx0
         iYMPmAWX7mYDIXm7ufHvau/ZPxpgGcKU+GG2tFEj7Mvv1dqabS6bkLOHNtZmogpquga0
         qk05JwwC6KtUri6Xmfv0MEAo1LXyeiOPcnh0zbT9VtDq3zUY3hvvwxkiVmyzZWs4sEUK
         WIaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BSwyS9YvmnfToLZfeSQ4jy5MqtfPwz3CBOKhQd3KTp0=;
        b=KrpmzkDuz2eIob0RyIm5q7M51SSQ+d1lLv/WKaJRcR2hzdUVcUKZARh+yxkvM6ssib
         j0Nt/YCm/cMtPI6L1erSSeVjbc6YyRu51eDaGs+/6KMV9u0UmcmsUjicPd2BGwLDCsXU
         /zgirmTzDGjPOf1YgmRkeNXP3GXcOO67tY6rRTgItj+Wi2HLhgEKMybN5bEyxRVW0aqV
         2DTtDpGhbi0PE7EG/BEzSBuH6wyFVP6gmDv8hXN2oB7Uj98Y0ZqUu+CKfh//ot4XvQa2
         eEVqe56UpgzVRDtJr67p25IAC+b5EcjfCkGUo7zqWd4OMCgcNZCYfZdh1ai0CurisMDv
         qPUw==
X-Gm-Message-State: APjAAAWddt24FnGZEIgAvwUo5Tf6veNA5nPOIL+kzo1Q1ZtVuSqh4X6l
        VgAQTXxkDn5qHOUox+u1p+rRt2bl
X-Google-Smtp-Source: APXvYqybNkbRkRHNXU0j1dc8BU0BVgTK3RN6s/FnQQZCBPKyrmCKlQTNvmg7dFMYKE9VY51T+W6qDw==
X-Received: by 2002:adf:ecc6:: with SMTP id s6mr10192437wro.345.1581447491522;
        Tue, 11 Feb 2020 10:58:11 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f62sm4967730wmf.36.2020.02.11.10.58.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 10:58:11 -0800 (PST)
Message-Id: <c0aca431858e403da58299d873e0124f12da43e6.1581447485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
References: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
        <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 11 Feb 2020 18:58:04 +0000
Subject: [PATCH v5 7/7] git-p4: add RCS keyword status message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Ben Keene <seraphire@gmail.com>, Ben Keene <seraphire@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ben Keene <seraphire@gmail.com>

During the p4 submit process, git-p4 will attempt to apply a patch
to the files found in the p4 workspace. However, if P4 uses RCS
keyword expansion, this patch may fail.

When the patch fails, the user is alerted to the failure and that git-p4
will attempt to clear the expanded text from the files and re-apply
the patch. The current version of git-p4 does not tell the user the
result of the re-apply attempt after the RCS expansion has been removed
which can be confusing.

Add a new print statement after the git patch has been successfully
applied when the RCS keywords have been cleansed.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index f14c71c97d..f1fb2222a4 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2025,6 +2025,9 @@ def applyCommit(self, id):
         applyPatchCmd = patchcmd + "--check --apply -"
         patch_succeeded = True
 
+        if verbose:
+            print("TryPatch: %s" % tryPatchCmd)
+
         if os.system(tryPatchCmd) != 0:
             fixed_rcs_keywords = False
             patch_succeeded = False
@@ -2064,6 +2067,7 @@ def applyCommit(self, id):
                 print("Retrying the patch with RCS keywords cleaned up")
                 if os.system(tryPatchCmd) == 0:
                     patch_succeeded = True
+                    print("Patch succeesed this time with RCS keywords cleaned")
 
         if not patch_succeeded:
             for f in editedFiles:
-- 
gitgitgadget
