Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16AFC05027
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:40:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232889AbjBOCkg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232750AbjBOCke (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:40:34 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7027127D7F
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:33 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id cr22so20468230qtb.10
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:40:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTsBbEhpUqXc+8sr5ARxshDRtlGNv7DUXMnqRIuVHNE=;
        b=oSJGtwzPMANYjDd9/vUFOrbcxfkRlDDBNEwg3+toR01eSscvN0QLudl/GfLL/Jm4yr
         2ML2NVSdIeF/A+OH1XJbfNFqQcq1gkoNrA9W+DdFbKbio41h9cvRBZOrxyE+bdxG4Hp1
         PYSUZT2/tQUP61ufWGoCwGCQoZQ6wBnBrE/0moVZnPt1o/XdLb1pY2WIVc2FiSBYMWWO
         b9Ni6/W6qrjnFY3B2gw3+WWbMC6vALleYrJ/S3kOb/MfmkG0YeKft9EbWaEiQP8mksoX
         nUy5E094KMku22m0sap/13MGrMHGN4IKzxEwssWoYdQ9sjqnmoN2slxIrrdBtpBGrMWv
         UPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTsBbEhpUqXc+8sr5ARxshDRtlGNv7DUXMnqRIuVHNE=;
        b=7/KXHr0xOyDiPo6riu2TfSDSM/1eBoTLeyx8LCXx74a1JrMzCFYPDHB/vEJQew7lTU
         REiW+7rafcQn2+FZ8XQVyW2jepCD9CHOEjdDjMAU52G68gFbQ25vsO4d7oPrQ7EAZNNz
         HXVTVVMfx6lGH9oUxbDg+LdU40Y3vyUqCHPtR7Ihd/7GNvi70qCnQ0iOb16W2R/uKW44
         kx0fl9p2nArWfyPBvkm/X3WDRG5ku9ImsX38HL89rzX5r3q8vlWe6bcF4vKH/d5oXMhS
         +AQuSNJcKmTJCzuu3NlNYImWQCVc1QEOPoF8M2mx4MDiiqOjl3VQY2ahu0lQGDRrR/GL
         YKIw==
X-Gm-Message-State: AO0yUKUzQc+z+pqmBS0oTLR09+LDDYNSE2cRkiiAyVFuwrZA+PAZytbd
        yDC40xLV6vm5c/O85nrSHtU3UmNJDz6q+A==
X-Google-Smtp-Source: AK7set/2NPp9BWSo2L7LWE/qxVjWL/Gf+ay+/C0ATxScIA0RPQkU3bZezETvmcp4634g0DJ4WoTILQ==
X-Received: by 2002:a05:622a:88:b0:3a8:efd:2ef0 with SMTP id o8-20020a05622a008800b003a80efd2ef0mr791456qtw.60.1676428832187;
        Tue, 14 Feb 2023 18:40:32 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id e184-20020a3769c1000000b0073b69922cfesm1069734qkc.85.2023.02.14.18.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:40:21 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v6 1/3] t4113: modernize test script
Date:   Tue, 14 Feb 2023 21:39:51 -0500
Message-Id: <20230215023953.11880-2-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230215023953.11880-1-cheskaqiqi@gmail.com>
References: <20230209154417.10763-1-cheskaqiqi@gmail.com>
 <20230215023953.11880-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Test scripts in file in this script are written in old style,
where the test_expect_success command and test title are written on
separate lines. Change the old style to modern style.

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t4113-apply-ending.sh | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/t/t4113-apply-ending.sh b/t/t4113-apply-ending.sh
index 66fa51591e..41526ca805 100755
--- a/t/t4113-apply-ending.sh
+++ b/t/t4113-apply-ending.sh
@@ -24,14 +24,14 @@ echo 'a' >file
 echo 'b' >>file
 echo 'c' >>file
 
-test_expect_success setup \
-    'git update-index --add file'
-
+test_expect_success setup '
+    git update-index --add file
+'
 # test
 
-test_expect_success 'apply at the end' \
-    'test_must_fail git apply --index test-patch'
-
+test_expect_success 'apply at the end' '
+    test_must_fail git apply --index test-patch
+'
 cat >test-patch <<\EOF
 diff a/file b/file
 --- a/file
@@ -47,7 +47,7 @@ b
 c'
 git update-index file
 
-test_expect_success 'apply at the beginning' \
-	'test_must_fail git apply --index test-patch'
-
+test_expect_success 'apply at the beginning' '
+	test_must_fail git apply --index test-patch
+'
 test_done
-- 
2.39.0

