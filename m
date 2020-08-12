Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E48C433E1
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C56DF206DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 19:44:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ee6aKjNX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgHLToc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 15:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726593AbgHLTob (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 15:44:31 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D12C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:44:31 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id a79so1534956pfa.8
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 12:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w1MPiDX7ZUZQhhAr2HsU79nnNU8nJB0SBkJ4MkD3/+w=;
        b=Ee6aKjNX0sNluN5N9P6iJiX+4vsr4yQ6gLvm/CzmDn2XHaGyS444ylHy7nYQxuEu0C
         sy2RuHw42hzy9i8Tz7DjlGEoXn8cMr9Y/s3hSwGEdqJB10aCHeam20vETW8gZWnmsykt
         p/7JVr/0VOhaJuaAOUfitMADEKHspCcNJxqHHcg64Y/E9dyQEvrSdCfMRax3IqXgEK+8
         rx4QmgzdNZX9512836qUo4bADEKVfuRGJ+Zik8J6tyjxCMAoEz4evEPCc/tj0fiV3rcZ
         TvvEk8I+c5BREDvNAjJSZoaIRk4msTsygsCpn6hW4Ll1n4FtpXngA2yisngQFkFNiE4l
         XbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w1MPiDX7ZUZQhhAr2HsU79nnNU8nJB0SBkJ4MkD3/+w=;
        b=CnPtdrgyaltTHTdyGV/X08YBeMryZHmAa2/w/ST4dR38jDeC/odfKolszzGj7/XJun
         6ES3+qDexfMhttoDgjhQuq+vbMc5C436xVtHcsQqtl6SG1bIL3yIBIf+ojUy8Mquk3YE
         urUoPBZh40l26rT2YQRRgQSNcD2jTgGgtW4XmmOYP6OIYzegiLDFFvJvOcqbuZTtiH8F
         2j6EOkey6wGQuNfCoD4O+W0MJdNbwH2wGkIWGbFN2TAsRx2swvmfbGtmizXm61mt0R0q
         +DlI1eS0Lk0OidnAas7LeusX2bboDWjM/aI7ebDdXz4G28+vtkjCpiiUZaxOeBq5lIfY
         sGoA==
X-Gm-Message-State: AOAM533moFga+so6jAjoQC1Cp/XvZv2hBpkgKM0Bd8w6BgjsLQxJHEyo
        5OhBViAHxMe9nWlwE4NC6quiSexpmvA=
X-Google-Smtp-Source: ABdhPJzoSa0iB4G3stMxneO8bUgAjwGgvCrg1YUMxvZorrs1IuTejQlPcXGZsVZeWoarYijlpq7kKg==
X-Received: by 2002:a63:5825:: with SMTP id m37mr652971pgb.257.1597261470942;
        Wed, 12 Aug 2020 12:44:30 -0700 (PDT)
Received: from localhost.localdomain ([45.127.46.132])
        by smtp.gmail.com with ESMTPSA id q17sm3183965pfh.32.2020.08.12.12.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2020 12:44:30 -0700 (PDT)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     shouryashukla.oo@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        Johannes.Schindelin@gmx.de, kaartic.sivaraam@gmail.com,
        liu.denton@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 3/4] t7421: introduce a test script for verifying 'summary' output
Date:   Thu, 13 Aug 2020 01:14:03 +0530
Message-Id: <20200812194404.17028-4-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200812194404.17028-1-shouryashukla.oo@gmail.com>
References: <20200806164102.6707-1-shouryashukla.oo@gmail.com>
 <20200812194404.17028-1-shouryashukla.oo@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

't7401-submodule-summary.sh' uses 'git add' to add submodules. Therefore,
some commands such as 'git submodule init' and 'git submodule deinit'
do not work as expected.

So, introduce a test script for verifying the 'summary' output for
submodules added using 'git submodule add' and notify regarding the
above mentioned behaviour in t7401 itself.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Mentored-by: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Signed-off-by: Shourya Shukla <shouryashukla.oo@gmail.com>
---
 t/t7401-submodule-summary.sh     |  4 ++
 t/t7421-submodule-summary-add.sh | 69 ++++++++++++++++++++++++++++++++
 2 files changed, 73 insertions(+)
 create mode 100755 t/t7421-submodule-summary-add.sh

diff --git a/t/t7401-submodule-summary.sh b/t/t7401-submodule-summary.sh
index 9bc841d085..45c5d2424e 100755
--- a/t/t7401-submodule-summary.sh
+++ b/t/t7401-submodule-summary.sh
@@ -7,6 +7,10 @@ test_description='Summary support for submodules
 
 This test tries to verify the sanity of summary subcommand of git submodule.
 '
+# NOTE: This test script uses 'git add' instead of 'git submodule add' to add
+# submodules to the superproject. Some submodule subcommands such as init and
+# deinit might not work as expected in this script. t7421 does not have this
+# caveat.
 
 . ./test-lib.sh
 
diff --git a/t/t7421-submodule-summary-add.sh b/t/t7421-submodule-summary-add.sh
new file mode 100755
index 0000000000..829fe26d6d
--- /dev/null
+++ b/t/t7421-submodule-summary-add.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+#
+# Copyright (C) 2020 Shourya Shukla
+#
+
+test_description='Summary support for submodules, adding them using git submodule add
+
+This test script tries to verify the sanity of summary subcommand of git submodule
+while making sure to add submodules using `git submodule add` instead of
+`git add` as done in t7401.
+'
+
+. ./test-lib.sh
+
+test_expect_success 'summary test environment setup' '
+	git init sm &&
+	test_commit -C sm "add file" file file-content file-tag &&
+
+	git submodule add ./sm my-subm &&
+	test_tick &&
+	git commit -m "add submodule"
+'
+
+test_expect_success 'submodule summary output for initialized submodule' '
+	test_commit -C sm "add file2" file2 file2-content file2-tag &&
+	git submodule update --remote &&
+	test_tick &&
+	git commit -m "update submodule" my-subm &&
+	git submodule summary HEAD^ >actual &&
+	rev1=$(git -C sm rev-parse --short HEAD^) &&
+	rev2=$(git -C sm rev-parse --short HEAD) &&
+	cat >expected <<-EOF &&
+	* my-subm ${rev1}...${rev2} (1):
+	  > add file2
+
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule summary output for deinitialized submodule' '
+	git submodule deinit my-subm &&
+	git submodule summary HEAD^ >actual &&
+	test_must_be_empty actual &&
+	git submodule update --init my-subm &&
+	git submodule summary HEAD^ >actual &&
+	rev1=$(git -C sm rev-parse --short HEAD^) &&
+	rev2=$(git -C sm rev-parse --short HEAD) &&
+	cat >expected <<-EOF &&
+	* my-subm ${rev1}...${rev2} (1):
+	  > add file2
+
+	EOF
+	test_cmp expected actual
+'
+
+test_expect_success 'submodule summary output for submodules with changed paths' '
+	git mv my-subm subm &&
+	git commit -m "change submodule path" &&
+	rev=$(git -C sm rev-parse --short HEAD^) &&
+	git submodule summary HEAD^^ -- my-subm >actual 2>err &&
+	test_i18ngrep "fatal:.*my-subm" err &&
+	cat >expected <<-EOF &&
+	* my-subm ${rev}...0000000:
+
+	EOF
+	test_cmp expected actual
+'
+
+test_done
-- 
2.28.0

