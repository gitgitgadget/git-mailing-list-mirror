Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 242A7C433FE
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 19:15:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240475AbiCaTR2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 15:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239667AbiCaTR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 15:17:27 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC92591550
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:39 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id y10so426726edv.7
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 12:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fgyNSdmp2yovFrc1IcjJlt2B3WjoN7r4UNujoSxseAc=;
        b=mMSrcs0pU8ohBilvFQpI6cjQhPLk1LqAUlFdgc8jRYW0kdWv2JKYRM2qYslr1jb5Ud
         Z2DWpJ2s7ZCc5P2tWmZMins6YV2/1R7MpKYCnieq/rodsO/5xN20EVT6y4lOI1X6fmOD
         0KqHB49dPVA4zozGrchEu7ak51UybTh9of2mfsDlQu/XJFS9yuddHc+JuCZRf5zF00vT
         9SThZp3x4XtGuyyzp/50xHsqUYtwCX2FbAiwKem6A4BxxHt1KHZ4+uHHBxlNOf+bGcPS
         4Gi4tPTDOD7CASt7G/YDycZKL8UAIxoi4ABHaLoHJYVshcBn01T8eLHo9Py5/2vg5ZMe
         fgjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fgyNSdmp2yovFrc1IcjJlt2B3WjoN7r4UNujoSxseAc=;
        b=jnWBN4WQCHJuQzDL26XWZlflqAxLYnVK8Vl2NRC7mLJJ+noK6x9mxLg60UZ/MmwZqq
         EAKAhRkGSUuxBV1hLndSu3QL+H9Z52xNONSIudrIl2MyALVKusY/2YGNVR33eCoaNeXw
         A7HYlw/ZN6aQZTDBUazdg1lwvezRjnbZj4kMPcCcDnLSuZPGlXrxhqR7kNMQVzsFNlM4
         GeiJQ64R4nTDCbpFlo/blirDc1xr3aLmKQVSJB/qlxj5TJ852oYAaDQsFw0aly1EvhTP
         0I+xECPtuREJ6ZWGeIvBwDhNtw3C4ksaDWvF6nwmfe/fAWUcLuJNIjM5Nx6VKbDFbxKM
         QEdw==
X-Gm-Message-State: AOAM5317H1o5EvONQjHMJPZ20QIXSjG6TtJ7ye6/BNiS5CbDUnU1hDEb
        QrFeCRrDLT2x98MvL875k9htIBALyOj/KlE7NsiS1Q==
X-Google-Smtp-Source: ABdhPJzrbbw2Ojo8nQe6ps7m6ZkrUmbBRZ2xdqt5PleZDsqErlQGV7dcSUdOVFC1Hi6gFqIgWv0IZg==
X-Received: by 2002:a05:6402:34c1:b0:419:585a:f383 with SMTP id w1-20020a05640234c100b00419585af383mr17679447edc.65.1648754138308;
        Thu, 31 Mar 2022 12:15:38 -0700 (PDT)
Received: from a35b75bc573c.europe-west4-b.c.codatalab-user-runtimes.internal (81.245.204.35.bc.googleusercontent.com. [35.204.245.81])
        by smtp.gmail.com with ESMTPSA id hp12-20020a1709073e0c00b006e02924bf20sm106181ejc.117.2022.03.31.12.15.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 12:15:38 -0700 (PDT)
From:   Labnann <khalid.masum.92@gmail.com>
To:     avarab@gmail.com
Cc:     git@vger.kernel.org, gitgitgadget@gmail.com,
        khalid.masum.92@gmail.com
Subject: [PATCH v2 2/3] t3501: don't ignore "git <cmd>" exit code
Date:   Thu, 31 Mar 2022 19:15:24 +0000
Message-Id: <20220331191525.17927-3-khalid.masum.92@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220331191525.17927-1-khalid.masum.92@gmail.com>
References: <220331.86bkxnt77a.gmgdl@evledraar.gmail.com>
 <20220331191525.17927-1-khalid.masum.92@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

without this change this test will become flaky e.g under
SANITIZE=leak if some (but not all) memory leaks revealed by
these commands, according to c419562860e

Signed-off-by: Labnann <khalid.masum.92@gmail.com>
---
 t/t3501-revert-cherry-pick.sh | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/t/t3501-revert-cherry-pick.sh b/t/t3501-revert-cherry-pick.sh
index 45492a7ed0..bd19c272d6 100755
--- a/t/t3501-revert-cherry-pick.sh
+++ b/t/t3501-revert-cherry-pick.sh
@@ -44,6 +44,12 @@ test_expect_success setup '
 	git tag rename2
 '
 
+test_cmp_rev_parse () {
+	git rev-parse $1 >expect &&
+	git rev-parse $2 >actual &&
+	test_cmp expect actual
+}
+
 test_expect_success 'cherry-pick --nonsense' '
 
 	pos=$(git rev-parse HEAD) &&
@@ -66,7 +72,7 @@ test_expect_success 'cherry-pick after renaming branch' '
 
 	git checkout rename2 &&
 	git cherry-pick added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename2) &&
+	test_cmp_rev_parse HEAD^ rename2 &&
 	test_path_is_file opos &&
 	grep "Add extra line at the end" opos &&
 	git reflog -1 | grep cherry-pick
@@ -77,7 +83,7 @@ test_expect_success 'revert after renaming branch' '
 
 	git checkout rename1 &&
 	git revert added &&
-	test $(git rev-parse HEAD^) = $(git rev-parse rename1) &&
+	test_cmp_rev_parse HEAD^ rename1 &&
 	test_path_is_file spoo &&
 	! grep "Add extra line at the end" spoo &&
 	git reflog -1 | grep revert
-- 
2.35.1

