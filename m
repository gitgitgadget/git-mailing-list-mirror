Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BEFFC433FE
	for <git@archiver.kernel.org>; Thu,  6 Jan 2022 22:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245156AbiAFWfG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Jan 2022 17:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245134AbiAFWfE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jan 2022 17:35:04 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4840C061245
        for <git@vger.kernel.org>; Thu,  6 Jan 2022 14:35:03 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r9so5806990wrg.0
        for <git@vger.kernel.org>; Thu, 06 Jan 2022 14:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FdaLq2g91xR8v/nESoeGXauk+rr++iaeFdoli+1AYtQ=;
        b=DtS8R9ei7UI/f5wiIhZIZC5Q9wYhCNLUZ+kJVlsoMwBTpaiQrwD5soVJajXQYQA7hq
         zhma6E6iDUxjrhKwDlMID91vx6obR+PD9/ZBOSFUZGB/4G/SevuUeqZzSxHQorQSpKuf
         RUZE0LrAXGpdhKcu+N6HdfCt45Vr5r9bOVX9fd9iG/yy5HfDWyoLEyPG8ZlESNiyFw5e
         /RjIHriwi97Dojc+7/9phXg1ZVwzzhpjTYJwENcb/Nfw4owbtkE2wxWoiUd2g3cWppA5
         MF/Yv0TV7NP779013vdxzYikXaMJgDEXyibMXXinIxamC6CrpZh4JNiCa2O7nQK8pdNN
         jdlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FdaLq2g91xR8v/nESoeGXauk+rr++iaeFdoli+1AYtQ=;
        b=xKmbY7kprbZCNrzJDkHHiqzXxTU8++pFGbiYAdZZZ/EYKvxa8PfOHv1Hhc/4b9k4Qn
         QtRYKI4r/J3bl+CiYXLFAzM0G+hLokWFNRB2RwdCKsR4tCRQgzKo/0X+gxe/1RzuM5Ie
         1hgdqtqCT+uyfg+0h1fXmC04eJVzSPPGGDcJIS9JO7trn1xgVzRGDtscqbpvXvjETErY
         bY7lCulNspEQ2Ks8d4Tswx1vgMFQW93POg9jga7/tZC/+Goy70Y0E9jZFWOfhRIPYKlK
         JgOTK5J6XaL5N8/3UmUlJ8nVobETB4lbsyQ45qFFJsjBleBEJZGhSt3rKa4YqjbEfxjL
         dglQ==
X-Gm-Message-State: AOAM5318bzsYdqqNjhWusGIm2bbVHLSj0F/4bZQJtDkTk0CIT1H7oSvb
        DPzxy/Ua1vNVCnxrse98tlddqIDlZAI=
X-Google-Smtp-Source: ABdhPJyJWxIGt8fPxItTKOen97gRK1tnXLazgPNUQExajB1uiIDIj2hv7qp8G5e/RaWuw6gxREDVUQ==
X-Received: by 2002:a5d:4acb:: with SMTP id y11mr53000934wrs.64.1641508502181;
        Thu, 06 Jan 2022 14:35:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z6sm3725428wmp.9.2022.01.06.14.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 14:35:01 -0800 (PST)
Message-Id: <3567ef91e7a91f4b0fc04884f0748c1f7a918a58.1641508499.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
References: <pull.1105.v2.git.1641388523.gitgitgadget@gmail.com>
        <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 06 Jan 2022 22:34:57 +0000
Subject: [PATCH v3 3/4] t7508: add tests capturing racy timestamp handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

"git status" fixes racy timestamps regardless of the worktree being
dirty or not. The new test cases capture this behavior.

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/t7508-status.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index b9efd2613d0..2b7ef6c41a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1654,4 +1654,26 @@ test_expect_success '--no-optional-locks prevents index update' '
 	! test_is_magic_mtime .git/index
 '
 
+test_expect_success 'racy timestamps will be fixed for clean worktree' '
+	echo content >racy-dirty &&
+	echo content >racy-racy &&
+	git add racy* &&
+	git commit -m "racy test files" &&
+	# let status rewrite the index, if necessary; after that we expect
+	# no more index writes unless caused by racy timestamps; note that
+	# timestamps may already be racy now (depending on previous tests)
+	git status &&
+	test_set_magic_mtime .git/index &&
+	git status &&
+	! test_is_magic_mtime .git/index
+'
+
+test_expect_success 'racy timestamps will be fixed for dirty worktree' '
+	echo content2 >racy-dirty &&
+	git status &&
+	test_set_magic_mtime .git/index &&
+	git status &&
+	! test_is_magic_mtime .git/index
+'
+
 test_done
-- 
gitgitgadget

