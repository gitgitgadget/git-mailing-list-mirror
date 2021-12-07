Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62B5EC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 17:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240156AbhLGRtD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 12:49:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240150AbhLGRtB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 12:49:01 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F8FC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 09:45:30 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id t9so31088823wrx.7
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=DP5x+9ZJT8qMmvm2TnbH+JxFgHH9ct5RJc3P7Vzz8vvuQ6vV26pIaAJXqG8RsypIOw
         dPHBmltazakLXmHb8keCv2Cx4wgYhD7zoIcVBSv9UxacBgkzfMk1t7rGipBOReFvq9t2
         kFOQv796gjF3xqurZYPeeK6w3eKRXFrg1ltRTO2LgevkEF8KDn/6OzKosx0UYHgCknVt
         41vRNZgDyjlCmMmS0ShZxk1cEi3TshdiEwADuuzlGM1XxNvjQ4QSb7UgDDZ6uNPnnfoD
         HWoLP+zEwtI6lurVm6/8QXeiYBFce5pvJ3xAr6MgXQx8xKWiazsPfj6xIJhwD1G6oOxs
         yeZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=6v0+JuvgL+rkV6+ZUY0aCiH0eSlBA7tjh6rJWXdXHEw=;
        b=GulLa/9tcng6N3PPt++xetPJCHGwsVVYs5l+xyCv1fZ2veZrTm3m/nFtYiWohW8/Px
         lHPFOb2mwaFiLO3l+5IarbK2cgvtBl3rfmobjo2R4CKPFttOSaJj5UgBr8kwilvjPpA/
         qoARLzCFW7gT4UEZKb9qfOudGplbbnaaQE+VU5uQz8L0ij/9yaMXl+wvz8JgkV48WjG8
         WK9aHNIgQpKo151OGz4zofzdnbgs9TWl6yepdZPXm1pu4ps0YDUGUcXETh9LP/4mytFo
         EQLvCRU2VRTg9qjMwUp6WLCP2fOCmjqEpskXt4Mo9QnN+Xm31K7nfFUYSOeup1XTfDWW
         WpLA==
X-Gm-Message-State: AOAM530Hm7Ec00jqbxmHCVSOexIJoh+HMLeoft0lxilmkjwBZ8ITqi1n
        gfFip/cwHY/gGi939OKge3wzEGNP5P8=
X-Google-Smtp-Source: ABdhPJz+kmtvwerSRBp2ToAABsjZIgrXja2fPflSA4qQSu/2VnP4ebkeDQIt/gSvcavjGbDon6ICTQ==
X-Received: by 2002:adf:f486:: with SMTP id l6mr54059735wro.596.1638899128887;
        Tue, 07 Dec 2021 09:45:28 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l1sm366455wrn.15.2021.12.07.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 09:45:28 -0800 (PST)
Message-Id: <9288289ebcb7f7db0bfeef80f3150e1205dc1d62.1638899124.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
References: <pull.1152.git.git.1638899124.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 07 Dec 2021 17:45:18 +0000
Subject: [PATCH 04/10] reftable: check reftable_stack_auto_compact() return
 value
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

Fixes a problem detected by Coverity.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 reftable/stack_test.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/reftable/stack_test.c b/reftable/stack_test.c
index eb0b7228b0c..d628420e63a 100644
--- a/reftable/stack_test.c
+++ b/reftable/stack_test.c
@@ -814,6 +814,7 @@ static void test_reftable_stack_auto_compaction(void)
 		EXPECT_ERR(err);
 
 		err = reftable_stack_auto_compact(st);
+		EXPECT_ERR(err);
 		EXPECT(i < 3 || st->merged->stack_len < 2 * fastlog2(i));
 	}
 
-- 
gitgitgadget

