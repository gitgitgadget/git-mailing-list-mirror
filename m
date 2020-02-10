Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CBB1C3B186
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B20C2072C
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 22:06:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0zpV3WU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727546AbgBJWG0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 17:06:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42535 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727505AbgBJWGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 17:06:25 -0500
Received: by mail-wr1-f66.google.com with SMTP id k11so9696909wrd.9
        for <git@vger.kernel.org>; Mon, 10 Feb 2020 14:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=AcZ/GHBTLQHUEhFZVEEk2WrNfW0MFS1xymvSbdeYuUA=;
        b=m0zpV3WUmNDQqDQuxg1zejdfyW2sIqtpakmlh4asjl/LuGfkA9Oap1cDez+UYNvecF
         RtTklj6zQBGiJMjjI0VFJFzy3eAHvMsimfqll38LNg3es5dxcUDe5T+GfTzTec0Nj4jQ
         zKmcxQ7I9Ms0QzO63CtX0BZW3Z8iLVmdS7ypfZoYfNN6k/fNCXKEAKP+2sCe7/G74R96
         z410gQOQRk6zGXiZ07qN7ZwjdR5vsUYRkJ3am8MOfaAEwzf5eSMjIMpK7QtwIoRe8DIj
         W2oUXS3QeUrNyC+ODQ8WSkIP/7FGRqypBaDzwnY2SCO2+0iF0znyTrMYWnxkHA37NQYQ
         xbTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=AcZ/GHBTLQHUEhFZVEEk2WrNfW0MFS1xymvSbdeYuUA=;
        b=oLfsxKOY3O8E1GWu50ChzVugrynQOj+3URnlD7G8i6GQgQwHiKZ0oW8jEOeJzcMyEo
         2Y9Zh0gHDDxqyYfiApwt0AmZRHkqY/myOhnbCNeINDtz7dJ0W0bPvWvDXVBbKzL3TWHL
         Unw6SGWnbYZAUx9O1JqLv7HRvrZwT3nLYy2DP9hGVqfydTZZBYBgRluYBJ86aGqWXJwv
         WADOv2I7hgIn7T/WM7AGHm66gI/Sm2C71hEQefb25m/hKaWUEuU7fO4cPpPDO9m9QfIX
         sWQsGcLBGLHz7cm5OoliDGQmJ8btAd3phsYTKqK+SNPJ8hn2B8RsOf555qHaqMQhgMqM
         aZZA==
X-Gm-Message-State: APjAAAU29kp/iltmPFmOCvfn58uPzq7sSHz+slZd0uAfugL7IwIcceSw
        dL+fEhh9RgUeTmG9hBHV6vAG+c12
X-Google-Smtp-Source: APXvYqzTNkA0rNOgV1Y8qm/Lae17FMpl5WTMPa+mPjPYA0zHQK5In1Es6tNEVUZg8p/w2z0H5wPTDA==
X-Received: by 2002:adf:f302:: with SMTP id i2mr4078910wro.21.1581372383351;
        Mon, 10 Feb 2020 14:06:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d204sm894469wmd.30.2020.02.10.14.06.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 14:06:22 -0800 (PST)
Message-Id: <b92e017cb166c81f4675dbe65e0eba57ab1af1a8.1581372376.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
References: <pull.698.v3.git.git.1581002149.gitgitgadget@gmail.com>
        <pull.698.v4.git.git.1581372376.gitgitgadget@gmail.com>
From:   "Ben Keene via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 10 Feb 2020 22:06:16 +0000
Subject: [PATCH v4 6/6] git-4: add RCS keyword status message
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
to the files found in the p4 workspace. However, it P4 uses RCS
keyword expansion, this patch may fail.

When the patch fails, the user is alerted to the failure and that git-p4
will attempt to clear the expanded text from the files and re-apply
the patch. The current version of git-p4 does not tell the user the
result of applying the patch after the RCS expansion has been removed
which can be confusing.

Add a new print statement after the git patch has been successfully
applied when the RCS keywords have been cleansed.

Signed-off-by: Ben Keene <seraphire@gmail.com>
---
 git-p4.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 4b77879679..1c9c5270b2 100755
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
