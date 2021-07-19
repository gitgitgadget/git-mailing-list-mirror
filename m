Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4566CC07E9D
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:12:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 309B4610FB
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 18:12:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354544AbhGSRbS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 13:31:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380087AbhGSR1h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 13:27:37 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68C9CC061762
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 10:52:08 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id f9so23113323wrq.11
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 11:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o9KVw4pEzNFeWgplGe9YGi9/mdHySu7RVQZAxi7KePI=;
        b=W4PKaestanixrt2FOdHBJsITOjaT00UWNafMBZJOQP/crbUseFMKouJETyJvYBBJ0T
         u/jej1h1lAejkUtjcNpLREaK8ueKZ1cLeshFOffmPAp1tjnL2/pjcDAsgtRbO7z5mriw
         R4tqYuxn2jRK5l183iPFfR9AfIIs2ugxzSywKXVmBFcTcRBeANC8pO+XO60sCSXsTOFm
         YB3+URzO8O4JpUh+AM2fYO3jMfItHKTkvag2fln0Fnygun7PBE9tJIkMf3I0hwUgOlNv
         78IRhZX2CVqi5WbtR97RkcUMiHbXIBJmVdqFhfsKhLWwJEq9qYqwHbbUpTo17NCp+TFa
         Kc9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o9KVw4pEzNFeWgplGe9YGi9/mdHySu7RVQZAxi7KePI=;
        b=SeyJHvcaDys/hJklih5QBqrFMhRDShv8q1TY0SFs3thZ6Qqd5q08CCm9mvz438QKaS
         nRO3EsRrtLR3bWF+ct/3g5Lf8QddLvRTP4B1qE8QVghHTp4iaEIRLzQxmGjFLb7nlHPT
         l9ifgNm85POnirmVsxAaTC1pHRUhgNI6lDPTqDFl5ol/SmLEHB/OqIlhM8btQXLdSHay
         1Vxgzz2wojOPXd5YHJFZfZXzd1puIDQ+ImMIrSdeCyjriryDOZvUgzsgxIUHtKIV9dle
         nYIQBc0QjiSFSHpFn4kHBnPz2LVB/siwJqvtXXOuBxi/7VCfTioikd8DeARGus5Fge7c
         OOCg==
X-Gm-Message-State: AOAM530xZtYue8075U1T/xBxvrBMpTKr/TgnU7a47EHk1WEyxx/nV062
        voMAQDarwjhjmC0/nsRXimCpspt2tQY=
X-Google-Smtp-Source: ABdhPJwhStX8ZaXiaLknj5Yp6YCsin+91qEBBbdYM/kr3mpOiQ4oLd3hmVRNzqLH+rQYtAkHpxq6Ag==
X-Received: by 2002:a5d:4e43:: with SMTP id r3mr31070097wrt.132.1626718053299;
        Mon, 19 Jul 2021 11:07:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g3sm21748841wrv.64.2021.07.19.11.07.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:07:33 -0700 (PDT)
Message-Id: <695921cacb68dede0deef3a197bc9cd89c9cf2e3.1626718050.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
References: <pull.1052.git.git.1626718050.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Jul 2021 18:07:27 +0000
Subject: [PATCH 3/6] t6120: use git-update-ref rather than filesystem access
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t6120-describe.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1a501ee09e1..bae2419150b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -107,7 +107,8 @@ test_expect_success 'describe --contains defaults to HEAD without commit-ish' '
 check_describe tags/A --all A^0
 
 test_expect_success 'renaming tag A to Q locally produces a warning' "
-	mv .git/refs/tags/A .git/refs/tags/Q &&
+	git update-ref refs/tags/Q $(git rev-parse refs/tags/A) &&
+	git update-ref -d refs/tags/A &&
 	git describe HEAD 2>err >out &&
 	cat >expected <<-\EOF &&
 	warning: tag 'Q' is externally known as 'A'
@@ -135,7 +136,8 @@ test_expect_success 'abbrev=0 will not break misplaced tag (2)' '
 '
 
 test_expect_success 'rename tag Q back to A' '
-	mv .git/refs/tags/Q .git/refs/tags/A
+	git update-ref refs/tags/A $(git rev-parse refs/tags/Q) &&
+	git update-ref -d refs/tags/Q
 '
 
 test_expect_success 'pack tag refs' 'git pack-refs'
-- 
gitgitgadget

