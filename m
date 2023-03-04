Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B98DFC61DA3
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 02:58:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbjCDC6M (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 21:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjCDC6M (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 21:58:12 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D94DD4
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 18:58:11 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id i12so3050298ila.5
        for <git@vger.kernel.org>; Fri, 03 Mar 2023 18:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677898690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m6zCIUbiWROgiu+doCWEBFvF8NAznBMCjF+4jz1TXX0=;
        b=Z8AknQcboVFRZ+6h/uxs8xV3Wkr6VEwt8a843eXiIfyl2F2TnvfOpfTgbFmuB387qP
         M5GC0N3R5B2XTXAH60CVhASaq2BBOGeXgzptG32TvVcYRZaeEcg7B1lBTxFDtcpn7ii1
         6lMHTQr6Cxcg5+kPhHDLpHGkGH8BCIbZ9aXl+8uQ800XSMWKYs2+FZIkjPomVcA4TsM5
         HtCP2NlUpKSdU/Bt/KIHHXykHhn/muUWgKxfQEXB5j/N4ysBMhJk3zDom5eO9EwcW/kG
         ufPcBCyZdVSdhV+H03miTosA2rIUsNEDwX6r0Oj9nFkS0kDL7LcUhd8p8T7nXgWLEtpV
         qEaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677898690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=m6zCIUbiWROgiu+doCWEBFvF8NAznBMCjF+4jz1TXX0=;
        b=v3RzCDGjHs+DFIaYQ6TEsTKqJ1bAybPvLDHsoEG3NBEpARucCxs5ss5jYvZmmAednA
         YZR196NZgg2CjDb5/ME1O4c7rZTsg9EAHT5HSeZj4EUxaOgN0zVY5z6oP/06fRKqv7Ys
         hwB7xMBVMU6qWyFVndcL410CTwHXNd/bSH5KrQCRoPGIeVXfyM6nQjVw8/gA+GgaOIB/
         K1HrU7mKYrY2DodTROxZhO6cSdZZ6ZpcS1vJA29d5TM0LCNS/yXpAeyrtHX2F/1EDt+q
         RrKt1+FjJABz1tEBimHUtT+tU3cwyoQP+B6u9OnmJnUAxHWyPWVAreliAB1TiKyiof/s
         Oj0Q==
X-Gm-Message-State: AO0yUKV6edvuZkCWmAdPJjfwxPnNiV9OsRQ9gTBvPi0VQzoPfdVtg8fn
        5WVLXP/8sCK72s/TCdhzkVDn0E3guRw=
X-Google-Smtp-Source: AK7set9eheu4cuqOBv/ffxVH0qGPc86xmHhFMkgTv7pD6PzLwOAwrpyr0rgOoo9Npbmwl9ROU1hj7w==
X-Received: by 2002:a92:c26a:0:b0:315:6e7f:f429 with SMTP id h10-20020a92c26a000000b003156e7ff429mr3234576ild.9.1677898690191;
        Fri, 03 Mar 2023 18:58:10 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id e23-20020a02a517000000b003c5157c8b2csm1261140jam.47.2023.03.03.18.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 18:58:09 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com,
        derrickstolee@github.com
Subject: [RFC][PATCH] t1092: add tests for `git diff-files`
Date:   Fri,  3 Mar 2023 21:57:40 -0500
Message-Id: <20230304025740.107830-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To make sure git diff-files behaves as expected when
inside or outside of sparse-checkout definition.

Add test for git diff-files:
Path is within sparse-checkout cone
Path is outside sparse-checkout cone

Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
---
 t/t1092-sparse-checkout-compatibility.sh | 32 ++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
index 801919009e..f4815c619a 100755
--- a/t/t1092-sparse-checkout-compatibility.sh
+++ b/t/t1092-sparse-checkout-compatibility.sh
@@ -2054,5 +2054,37 @@ test_expect_success 'grep sparse directory within submodules' '
 	git grep --cached --recurse-submodules a -- "*/folder1/*" >actual &&
 	test_cmp actual expect
 '
+test_expect_success 'diff-files with pathspec inside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	run_on_all ../edit-contents deep/a &&
+
+	test_all_match git diff-files  &&
+	test_all_match git diff-files deep/a &&
+	test_all_match git diff-files --find-object=HEAD:a
+'
+
+test_expect_success 'diff-files with pathspec outside sparse definition' '
+	init_repos &&
+
+	write_script edit-contents <<-\EOF &&
+	echo text >>$1
+	EOF
+
+	run_on_sparse mkdir newdirectory &&
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git sparse-checkout set newdirectory &&
+	test_sparse_match git add newdirectory/testfile &&
+	run_on_sparse ../edit-contents newdirectory/testfile &&
+	test_sparse_match git sparse-checkout set &&
+
+	test_sparse_match git diff-files &&
+	test_sparse_match git diff-files newdirectory/testfile &&
+	test_sparse_match test_must_fail git diff-files --find-object=HEAD:testfile
+'
 
 test_done
-- 
2.39.0

