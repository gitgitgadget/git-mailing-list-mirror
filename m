Return-Path: <SRS0=nsHh=4C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F32EC2BA83
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:45:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 26A9224649
	for <git@archiver.kernel.org>; Fri, 14 Feb 2020 14:45:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WqSrvnxl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387466AbgBNOo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Feb 2020 09:44:59 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:40395 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387435AbgBNOo4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Feb 2020 09:44:56 -0500
Received: by mail-wr1-f67.google.com with SMTP id t3so11185964wru.7
        for <git@vger.kernel.org>; Fri, 14 Feb 2020 06:44:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XZZUve2ddD5J23QBrcjCZHW5emJqSKctaadnUg1LmzM=;
        b=WqSrvnxlhEegWYtKoaFQGrIofhq+V55MlmzDN6IxzpPRiS2nBxtQLBYmgTHCHutlmU
         hG0bv19SCw0JM6NjhuvQnfllk8PJMSk1YEPnOAdQPjv3p84j9hDL6QJ9T+VG7oFLcxlb
         v7oVP3WHM+/vN74XwfHML3igpVAswwCql+zMchyp2MmL0m7RCVYNAqnHjLhW9MhHOWk7
         gGRx9hy5FDrrWjpRKyky5xVc3NgnA91kbczpxBkecnuO4+e2wEdq3tiNNzQTMfZAIV+A
         VwobJm2XMY0mq2o4ZrMkfGfEysNVRr5WHrixNykbFEMX6UDQZCfapdCNx9F4MB2uX9mz
         bPxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XZZUve2ddD5J23QBrcjCZHW5emJqSKctaadnUg1LmzM=;
        b=NmXa2I8okmsKoPYRGEKHZ5g7KsRA3rpzSoSSLKcnOnMqw0XBGvEqdjWV0bxSw8xWEy
         7tmM7PFrfIUDExLbEgi6bqVxBXbdpdBR6fhXL6IzMgEP2qhVUSXPdExARRL20xr02j79
         muf6NjDf7PYf3Vh2jLA4IJcefKwZMKC5PkChPq31iscqEpLR6PAzDUMtTv/pOcY2HfTu
         LDxxKu7jwlgCpBsPzBzGJTx6rxXy/z8REknIcGUbstuPB1FxVY3r0Em2qtsk/Ybkui9q
         KGRTX3JOnsx14tQh4wj+a3aSSoO0lRrlq2ddqd4xf2dHvFyjOot4u7N1f1A7+zKHhJhc
         CNSA==
X-Gm-Message-State: APjAAAUU8XOtkFXzDFOKORUmi0Ggw0OrHMzbpCiNw5jgi7YEvaw0HgvS
        p3U7xqWxXFoWXtckZXzC0vgjCWRl
X-Google-Smtp-Source: APXvYqzlKipi59vhXnHm7OhoWv7tRJcIJzMWErBeGAXKmQR3+VTaDmKD2s7IvxhcYWIl09uYEPh2CA==
X-Received: by 2002:adf:dd4d:: with SMTP id u13mr4669344wrm.394.1581691494595;
        Fri, 14 Feb 2020 06:44:54 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c13sm7302504wrn.46.2020.02.14.06.44.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Feb 2020 06:44:53 -0800 (PST)
Message-Id: <bdf07d8f7aafda4d900b2e088dda716c692b2bf8.1581691486.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
References: <pull.698.v5.git.git.1581447484.gitgitgadget@gmail.com>
        <pull.698.v6.git.git.1581691486.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 14 Feb 2020 14:44:46 +0000
Subject: [PATCH v6 7/7] git-p4: add RCS keyword status message
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
index 8761c70e1c6..258b9b98b93 100755
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
