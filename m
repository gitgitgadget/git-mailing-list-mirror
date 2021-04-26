Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92AE5C433ED
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AD3461164
	for <git@archiver.kernel.org>; Mon, 26 Apr 2021 16:15:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234243AbhDZQQP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Apr 2021 12:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234299AbhDZQQN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Apr 2021 12:16:13 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED21AC061574
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:31 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id c12-20020a4ae24c0000b02901bad05f40e4so12398908oot.4
        for <git@vger.kernel.org>; Mon, 26 Apr 2021 09:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8q/9izTH3+b5FZjKSC9PHnw70ZDe7b7IJKIurTswaLU=;
        b=FAyJoDA91/xPH9dFj9TWfIfl1tUqlzbYVin6+yV9n29LZCSVxPK0AIev5f9U0TfTIE
         Doon/PVj6ZNarIxIqklSLBAyeSEiRpOKFDJ4jg3SmP7t5SwRXPWp2iHLXkBJFOkSZt8i
         +jzaqV6LdyTOT/5VjQxNhr/QteZ1+jXN8QCfL6G+YyVSkbOoYcbftc528ySeBg5j3gRS
         YrTCTZ9kzTZc3cXbGaSPF/7Ctk60K2fe8lX/tEzS3g7ri2I+KLHvWNU0iDCBjznA4wXV
         9fXf0Mopm7Y1VMeETkxqzHZmmfJC1EVuBJCHtGyeZHm9zHrscEFRrZ8xfOJALSWDRuvo
         eHEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8q/9izTH3+b5FZjKSC9PHnw70ZDe7b7IJKIurTswaLU=;
        b=DiUyTf4mcRX++jXKYFKfNcr5GQclQizbLbpWuE8RjYV2gjdogjV0c+rVNS8lnxwfOg
         iWVLQdePSBmHqlp35wM8bK8bmawrvN3DecEybSzD+92k8Nap7YI06c7QkDW4QmyEd8qc
         CmtZTsIgvnh/XrAhkGa48964ZtrnDTSusnWknd2Qol5DwtbvIRXPEbVwhjkKvdU5emyd
         kEK6fNcDtbbV3F2b4YQuNJdiaorOZjWwuN3J4IAxkf8Ja6BhuASbWSfGMH1KQBkA4FaX
         Y62L1HrOFmz4ND0HVBqzAx4vsdS9euXuY/8Wa7fIYZr6/YdDDteGWq2uAoznY0L5Szer
         FkIw==
X-Gm-Message-State: AOAM532sm56iIGZdHIWZS/j86r80I+ojk10WapNcSSIrBfmgU6uu/Qy/
        zBamsP7hmWRS7lamd7aq2RxIkofF8qzPgA==
X-Google-Smtp-Source: ABdhPJwNbzY2lCPJ/3uBvOUihRnDtfgD3g3xrW+nfmkCi2aTBzG3XAS3dl6xAA/dJWWzRPA23nE6JA==
X-Received: by 2002:a4a:3142:: with SMTP id v2mr13950400oog.9.1619453731142;
        Mon, 26 Apr 2021 09:15:31 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id j11sm63525ooo.45.2021.04.26.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 09:15:30 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v1 06/43] test: completion: fix currently typed words
Date:   Mon, 26 Apr 2021 11:14:21 -0500
Message-Id: <20210426161458.49860-7-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210426161458.49860-1-felipe.contreras@gmail.com>
References: <20210426161458.49860-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

They don't match what we are supposed to be completing.

No functional change.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t9902-completion.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
index 7fc8eed375..4d4bee20b4 100755
--- a/t/t9902-completion.sh
+++ b/t/t9902-completion.sh
@@ -489,7 +489,7 @@ test_expect_success '__gitcomp - option parameter' '
 '
 
 test_expect_success '__gitcomp - prefix' '
-	test_gitcomp "branch.me" "remote merge mergeoptions rebase" \
+	test_gitcomp "branch.maint.me" "remote merge mergeoptions rebase" \
 		"branch.maint." "me" <<-\EOF
 	branch.maint.merge Z
 	branch.maint.mergeoptions Z
@@ -497,7 +497,7 @@ test_expect_success '__gitcomp - prefix' '
 '
 
 test_expect_success '__gitcomp - suffix' '
-	test_gitcomp "branch.me" "master maint next seen" "branch." \
+	test_gitcomp "branch.ma" "master maint next seen" "branch." \
 		"ma" "." <<-\EOF
 	branch.master.Z
 	branch.maint.Z
-- 
2.31.0

