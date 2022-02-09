Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C806EC433F5
	for <git@archiver.kernel.org>; Wed,  9 Feb 2022 12:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232136AbiBIMFF (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Feb 2022 07:05:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231707AbiBIMDf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Feb 2022 07:03:35 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31217C0302CB
        for <git@vger.kernel.org>; Wed,  9 Feb 2022 03:29:43 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id k18so3429310wrg.11
        for <git@vger.kernel.org>; Wed, 09 Feb 2022 03:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Sb8XReLDAwCFCQ70Zzgp55KlELCyx25F8VXu3Hjmtyw=;
        b=KaboyJSuEL7vV42vmIDYYFkt9EFQhfgJl1KaH7u7ODekg+h6ig11M6sH6tXAizX6l0
         hd2wiA4OXrIzaNt+a5zlJLzXsKz1PxY/bNiDXywm2PjiS044yIVx4+YsnC8AuVxhqwxG
         b/YcIt9hlsYWr/KMcldNjwf61YjBbqrxwJ/P/v8kM4vKXYH+iBCUB8e5/2F3/Apm/zEq
         YGLm1+VC0y/+uOn8sLJm3aagtVjYfumn4CpHkRjtNPCDIEE3jN3TGpx3iw4C04n5T4nX
         JNj3rR+5GSv/kXPQEanEL8Jxvk4LvWVd5yzdz30lEh9w3gJZzH3HEyMwcUY4rsk0HIsG
         1mOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Sb8XReLDAwCFCQ70Zzgp55KlELCyx25F8VXu3Hjmtyw=;
        b=AAgRBU8C++ORWl0yVMkNEv8rNZugYs3XfG0UEj+3txIaXeX4ByjHIKo6/0uDcwvbq2
         z+PisNIER9ksE6OSw1U52uBxGgqdNt76xOIMoBZeAQekmBzVPW+Tp4faie5MlVYhmCrh
         DCUG3qL5t4W3ZRMN8GXXY6iUs5eVj2R2UCrwF4klS7jVFTpo07YpgT3KBb9x6vbnbD8I
         XERgAS6sI9KPbA1Mfax7YOUVDrO/bGvb4uPMJEEHljh5dt/PVGRlKa/07mBSZ/M840cI
         M2M+1UREHDTcbWlhA6+1nuU5gS2nK5dBRyERj+NtxFgcxxZeAkGRz45Ir2DXch3yf9+U
         cvSg==
X-Gm-Message-State: AOAM531ewnFj3Xlfd1ZlPbQv2gKY6+zLLetAz+cKCxwxEMi/OUkrMt3v
        Rls09vJF5uR4pqwV8KHR203n80BpQfw=
X-Google-Smtp-Source: ABdhPJwBY+Ppo9ZfIdfG7sA+hMxCDNLvU4ytW1OUUxcmhqhWToP90gWMBp6ubHyxeMxxjZX+3gF4qw==
X-Received: by 2002:a5d:5850:: with SMTP id i16mr1682570wrf.519.1644406181682;
        Wed, 09 Feb 2022 03:29:41 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm4352586wme.25.2022.02.09.03.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 03:29:41 -0800 (PST)
Message-Id: <0a30941261b71cf47f8f846feb7b3bafe7d69fde.1644406180.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1213.git.git.1644406180.gitgitgadget@gmail.com>
References: <pull.1213.git.git.1644406180.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Feb 2022 11:29:39 +0000
Subject: [PATCH 1/2] t1410: use test-tool ref-store to inspect reflogs
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This makes the test compatible with reftable (it doesn't pass yet for
other reasons, unfortunately)

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1410-reflog.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index d7ddf7612d4..36f6693d9d3 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -418,7 +418,8 @@ test_expect_success 'expire with multiple worktrees' '
 		test_commit -C link-wt foobar &&
 		test_tick &&
 		git reflog expire --verbose --all --expire=$test_tick &&
-		test_must_be_empty .git/worktrees/link-wt/logs/HEAD
+		test-tool ref-store worktree:link-wt for-each-reflog-ent HEAD >actual &&
+		test_must_be_empty actual
 	)
 '
 
-- 
gitgitgadget

