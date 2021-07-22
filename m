Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C378EC432BE
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AABA060C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231925AbhGVUs3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbhGVUsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:21 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBCEC0613D3
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:55 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id q3so265449wrx.0
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KpLmbp75Sux4pwv8U+t0kPz7J/1D/BqHpfoLRrm2OjA=;
        b=GZ/oXuem2inxCFWMt2pVaXBltXUu8JHNxzK1pnoTmG2FWIIdHWfiPJQG8A11wWDUf0
         /9Nj9DLbt31RM90/s9BcpLEvpcBHRJwF+Ie/+T8A1ewsH1spsSMgIuKAnUksBK4gEWJj
         9j6f+tSg6cJvxDbGj0IHhxLkba/C4L55xUwgJNmEEGtOBV+op0MQf2oagAidgx6IrFO8
         X8dx8KE3WnFN1Z/ZEW+nEB8zFrMKheI6+l5JjltzT59BTMqckU5pi4Kxy10QMuTMvZm7
         xlgVqKiEFZCcHNwpfhY/m264E9g2n5yjJelZJ3v00Zlu/g/1oWCA483KbAYZcBgHBI+8
         k88w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KpLmbp75Sux4pwv8U+t0kPz7J/1D/BqHpfoLRrm2OjA=;
        b=hd45DOBeLuGNDCNJBbBuiFFZb06rdk4dUPxpTo9Ezt7FoT01ggfCL7yKNqou6Sm6uU
         gJdSqxm0gc9CMajzf+3sCh3AE2Nx5seXABfZfpdozVXYU5UbC8d55J/6hYPUPX949bPw
         dZXyiP4/tgx8lC/97DoXV0KP3aw7DUT65C30yjWPKWPKiw2mum6xN0DrHH7YoAqvDjyU
         IQSYObOG6AN9W+Uf4KhfFDyTKeDEZsgjZbEltNvi5lXvcDohiTaLRQPIXoOB0C2BiJWt
         CgQ6jKWA1Jprvx7FdEw56hzhD4yprAV5pUyeZSCuRhrJkYLfmvG8YStkcxoPEdONzyOk
         e3bw==
X-Gm-Message-State: AOAM531g8YjdxP29K8xhwPoKJTQp6pS0ZooeRbG5BA82AAABJrhedV/p
        9a8FKUmjjeDx28SZAU9vXVl530A5v7Q=
X-Google-Smtp-Source: ABdhPJxSdUqzJFiGvPqQL26FCOlLnA1ExRhVCzRo3VX7JB95RQXgC9bHPitrCnosfpRAklv4a4ny7Q==
X-Received: by 2002:a5d:4c50:: with SMTP id n16mr1895000wrt.249.1626989333886;
        Thu, 22 Jul 2021 14:28:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11sm30390946wro.78.2021.07.22.14.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:53 -0700 (PDT)
Message-Id: <3685ba90f60ef95892a22c8549c9a3c0717d6662.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:45 +0000
Subject: [PATCH v2 09/11] t7064: use update-ref -d to remove upstream branch
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

The previous code tested this by writing $ZERO_OID explicitly in the packed-refs
file. This is a type of corruption that doesn't reflect realistic use-cases. In
addition, even the ref-store test-tool refuses to write invalid OIDs.
(update-ref interprets $ZERO_OID is deleting the ref).

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7064-wtstatus-pv2.sh | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
index 4613882caff..eeb0534163d 100755
--- a/t/t7064-wtstatus-pv2.sh
+++ b/t/t7064-wtstatus-pv2.sh
@@ -373,10 +373,7 @@ test_expect_success 'verify upstream fields in branch header' '
 
 		## Test upstream-gone case. Fake this by pointing
 		## origin/initial-branch at a non-existing commit.
-		OLD=$(git rev-parse origin/initial-branch) &&
-		NEW=$ZERO_OID &&
-		mv .git/packed-refs .git/old-packed-refs &&
-		sed "s/$OLD/$NEW/g" <.git/old-packed-refs >.git/packed-refs &&
+		git update-ref -d refs/remotes/origin/initial-branch &&
 
 		HUF=$(git rev-parse HEAD) &&
 
-- 
gitgitgadget

