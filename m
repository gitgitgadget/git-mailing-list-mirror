Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D5AC433F5
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 21:50:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhLHVxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 16:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbhLHVxZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 16:53:25 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 339EAC061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 13:49:53 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id o13so6403725wrs.12
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 13:49:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=R+c9uwgWKTJdxpPDVAcNaECEciLE7541l6VfZWljJ7HKZn48Lhql0i/uJ4QEm/ESQS
         vsZu9CRK1wHsNnAYx8vCqfMBDXw0hiIEq3FlQ4YZqP53ejM3d5QyKT0bCiuaUhca4CMf
         VCIoaSmFTR8W6nXpQk+k0LFRFTh2zuA/9ehZNYnzgamh2Njs3NLdaBizPfCcROUkCrXh
         TpVqL5SpPPkxeAboK9mQ5zCroi0xkZgMM1m4s5HxfEHnm7myKM0JVV0mC2uHD3c8tN5x
         YnROrgJ80+KP2wbhaI0uWWCJuiTIVKiynL2kAHFOXHMbkSqQ/R9Urm3irw0A+BUWcFvh
         ufwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J9jVqwMPaNdDSNjujdVEAD8serufDJ5UG7qKldS2NTo=;
        b=5K80O4/ItToJAv08n9KppuLhHOCm8SfdovkrI+6FvBYzsEqHbD64E+TnVWkRuPQi7t
         CTYhVumxQykQHqNTygBP/wDImbPbtIZJx2xhqQExeetvd7s48/6CKifo/CgqDwL1iswO
         R6MEGgm8ohNipXCVaJZT9F+LpmimOUNKkbj6GmRHf9+hoNquARgJmfm31wucqZA55WHg
         RDHH77vFTou9L/ElPWV4sthWIUC5fUuYyVC29AUWjk2KN1EJ0bOPUNgQWmebzNnWUQdA
         iwdoy4fMySSOD4eUJpQ8JgE1PRxbRFGxeu3WDXeT6uvt5x38QVcyQP9sWObbq8TzsVMH
         aY2g==
X-Gm-Message-State: AOAM5337/AWP84NQeuoZ+xZOQ1tKdjqLjAZ7wKK5zXFJL6EJ/KTfSZGv
        thg/y6uMVOev9GaLsEuLT8YSQKj//HU=
X-Google-Smtp-Source: ABdhPJxNDXuyBsQyM6fYo3VrLGVyBSxS28SdhV3c68oj8Ni36A+RNnQ/yea6J2QljM1nh7B/y2gA7Q==
X-Received: by 2002:a5d:6091:: with SMTP id w17mr1541217wrt.65.1639000191675;
        Wed, 08 Dec 2021 13:49:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d2sm7366260wmb.24.2021.12.08.13.49.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 13:49:51 -0800 (PST)
Message-Id: <5020be156aeb5efe08c0377f15d8c27fa5c4d588.1639000187.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
        <pull.1152.v2.git.git.1639000187.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 08 Dec 2021 21:49:40 +0000
Subject: [PATCH v2 05/11] reftable: ignore remove() return value in
 stack_test.c
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

If the cleanup fails, there is nothing we can do.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index d628420e63a..4b7292945c3 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -89,7 +89,7 @@ static void test_read_file(void)
 		EXPECT(0 == strcmp(want[i], names[i]));
 	}
 	free_names(names);
-	remove(fn);
+	(void) remove(fn);
 }
 
 static void test_parse_names(void)
-- 
gitgitgadget

