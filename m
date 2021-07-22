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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07C0EC4338F
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7D5560C41
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 21:29:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232093AbhGVUs2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 16:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbhGVUsV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 16:48:21 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 934D4C0613CF
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:54 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id q3so265424wrx.0
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 14:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=lvxys0eKz9+e7jI2OrA67HFhf87Sy524WHimOJM3rgA=;
        b=ZNcfYN3GntfLg7od4E2NMp6JlNhsA8BBAOgrXXO0zKMtyhnKxaC3PMOdM9MRv0W/fw
         o7G7VuJpbdhb2FBKbLwMkKGc/Cg2qIzgy6YMnswhpYABz89PUL/qaRctabpO29nRRzbY
         gqQZwKZtwjuJegih4Pook/kSXOB8bXIqGzW/61fUnb7e0eBrj+vKFnC0R3khrmlQzOSl
         xShDSWy0hfloW+isG95hmNQ78S/IZpmQaNvNhKRrz6ootRjZM9zGJUDXm3qqNG51Naut
         AvjjyuPcmtm1GD7Xc3rOFyl9aTGxIAuXjqfHlbHQBXnpk0WjQcAbu++Unl7jkFKMC/Gd
         Gk0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=lvxys0eKz9+e7jI2OrA67HFhf87Sy524WHimOJM3rgA=;
        b=YU07WhbWw+Wimv+HpExDJvnAilPTDf92oW9csMxQlk1jvc48MEOKdoKPObSsYA6lbz
         mNkW101TjzLUShs47BG1WONi94onQN3shhPDQh/1JRxAcEhNjghB4HynvMQ6aOvOXaT3
         L27tKZ/VzuvSIffExJQhMhTGRufgazr75XDnZubXYRMNS+7FHiO2XtmxUO91VQaEiqyv
         MPX+3gilI4bKiErArP19j9HO3XUSjB6RVpV/ykk2xKjs3eR30Z/zYhpEXdvgBfIivgdL
         RfPt5N2BeH4u+t2W8nKjUwZ/Luym4sO1v3AWNooELUhPD6VMsOom/TFoPpAGQ94NCBA1
         XoWw==
X-Gm-Message-State: AOAM533DWWCIEZxnLBXIQAToM8gp7OsJ0iGxIAM3KNKKUS5PXMIozeHl
        vYtGb4UmDFj84Ug7pg3naEEfqwFP5yA=
X-Google-Smtp-Source: ABdhPJyT2eRhRqBOWvNKgAXEtBVqnYe9hge6yTa2Z2ffMS7ueUK4lljkCRUptDaBO32Al9g313L6BQ==
X-Received: by 2002:a5d:64c8:: with SMTP id f8mr1956474wri.290.1626989333292;
        Thu, 22 Jul 2021 14:28:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r17sm3372080wmq.13.2021.07.22.14.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 14:28:53 -0700 (PDT)
Message-Id: <f931a26de58e3cc7bb6522fab47e934aca7dc776.1626989327.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
        <pull.1052.v2.git.git.1626989327.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 22 Jul 2021 21:28:44 +0000
Subject: [PATCH v2 08/11] t1410: mark test as REFFILES
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

In reftable, one cannot take a lock on an individual ref.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1410-reflog.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/t/t1410-reflog.sh b/t/t1410-reflog.sh
index 27b9080251a..d42f067ff8c 100755
--- a/t/t1410-reflog.sh
+++ b/t/t1410-reflog.sh
@@ -374,7 +374,9 @@ test_expect_failure 'reflog with non-commit entries displays all entries' '
 	test_line_count = 3 actual
 '
 
-test_expect_success 'reflog expire operates on symref not referrent' '
+# This test takes a lock on an individual ref; this is not supported in
+# reftable.
+test_expect_success REFFILES 'reflog expire operates on symref not referrent' '
 	git branch --create-reflog the_symref &&
 	git branch --create-reflog referrent &&
 	git update-ref referrent HEAD &&
-- 
gitgitgadget

