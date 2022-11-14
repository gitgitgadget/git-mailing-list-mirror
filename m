Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7E5AC4332F
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 10:09:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236646AbiKNKJp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 05:09:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiKNKI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 05:08:59 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D636568
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:57 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id n12so26953171eja.11
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 02:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ctDW4v0mUe9VFdjVIibUjCqnK/WQUt4mEbcJblh55U=;
        b=PLoAAwpkFz5qPAhjsv7qPpZqBignuOaAVssM2oRSQ6+ATE8OrRwda6qjXXQpjeucC/
         Leoq1wq34TXKjx8ImZ+pziE0BlM9OpjFW/WizXe1fq5s7yJTBnZG5PcSNHW1Ct20OdI5
         3rspT5YNE19UJLxi+speFaBoZaWh9lZtEkdfMGnkYTgds/yLH0b8Ggq/lWmFsaQfy9Ak
         luhsgrUAdti4RGOQZwX9DC7KNgvH8RksnZl3RIWg20ViREhVXS+IWwf37e2YKhaT7CQi
         C/kbNzVdz8oQYUi6qBM2VriJ8AEuAsnWZrWEsSNtvYDcvTchn05SPEWyT/+0aW3Hei8R
         yF+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ctDW4v0mUe9VFdjVIibUjCqnK/WQUt4mEbcJblh55U=;
        b=BeLG8mvAAsKkUGjaoitSUn0mrbNoQ/eEplBKmJJ3w8xvEsEy7Yikgd/PH5iV3ukKp7
         x/QRE9ZGawQiYmfhvk14nmUTyd74u+K+9h0PtEL28hEKO2lARLHbfDh5Yc7i8sV1mO2C
         hZEA31R8zWjacW4FeaVBlz8JFNLuyWXBpOd4fSzDGo5ZbGJvMxZ6oBk2K3WLuKLvre4J
         tUAjikADDJTX0M/3EGhCUV+T7idoK38QpYGTNnZoUribFKfB8MzHURXBnQzkOEkQGdkO
         ho4JZU0Z9QotwyzHqr/B9zeLaCHX5fBUk1N/W+iFp2tTzJw4pAlAtiXJRt5CnvOASEBN
         jkCQ==
X-Gm-Message-State: ANoB5pl1iA89L+TPwmTc1f/t3r22DU7YOsQhIRoKJs3aa0ceEjXYlfz8
        no2QkcpiZuyizqZq6++Dwvt7ihxxwHA=
X-Google-Smtp-Source: AA0mqf6YJhRhG/s0lodDwdI0bC93lPQ7Jq/FD2lbdWJeW7Vz2KSJAfeERVup/nUEyzFpnMBz4+JIKQ==
X-Received: by 2002:a17:906:1542:b0:7ae:27ed:e90e with SMTP id c2-20020a170906154200b007ae27ede90emr9566827ejd.224.1668420535630;
        Mon, 14 Nov 2022 02:08:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ml21-20020a170906cc1500b007828150a2f1sm4012062ejb.36.2022.11.14.02.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 02:08:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>, Taylor Blau <me@ttaylorr.com>,
        Robert Coup <robert@coup.net.nz>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/10] read-tree + fetch tests: test failing "--super-prefix" interaction
Date:   Mon, 14 Nov 2022 11:08:41 +0100
Message-Id: <patch-v2-01.10-1114a4ff666-20221114T100803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1471.ge4d8947e7aa
In-Reply-To: <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
References: <RFC-cover-0.8-00000000000-20221109T192315Z-avarab@gmail.com> <cover-v2-00.10-00000000000-20221114T100803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Ever since "git fetch --refetch" was introduced in 0f5e8851737 (Merge
branch 'rc/fetch-refetch', 2022-04-04) the test being added here would
fail. This is because "restore" will "read-tree .. --reset <hash>",
which will in turn invoke "fetch". The "fetch" will then die with:

	fatal: fetch doesn't support --super-prefix

This edge case and other "--super-prefix" bugs will be fixed in
subsequent commits, but let's first add a "test_expect_failure" test
for it. It passes until the very last command in the test.

Signed-off-by: Glen Choo <chooglen@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5616-partial-clone.sh | 43 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 037941b95d2..e56466580cf 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -644,6 +644,49 @@ test_expect_success 'repack does not loosen promisor objects' '
 	grep "loosen_unused_packed_objects/loosened:0" trace
 '
 
+test_expect_failure 'lazy-fetch in submodule succeeds' '
+	# setup
+	test_config_global protocol.file.allow always &&
+
+	git init src-sub &&
+	git -C src-sub config uploadpack.allowfilter 1 &&
+	git -C src-sub config uploadpack.allowanysha1inwant 1 &&
+
+	# This blob must be missing in the subsequent commit.
+	echo foo >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule one" &&
+	SUB_ONE=$(git -C src-sub rev-parse HEAD) &&
+
+	echo bar >src-sub/file &&
+	git -C src-sub add file &&
+	git -C src-sub commit -m "submodule two" &&
+	SUB_TWO=$(git -C src-sub rev-parse HEAD) &&
+
+	git init src-super &&
+	git -C src-super config uploadpack.allowfilter 1 &&
+	git -C src-super config uploadpack.allowanysha1inwant 1 &&
+	git -C src-super submodule add ../src-sub src-sub &&
+
+	git -C src-super/src-sub checkout $SUB_ONE &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject one" &&
+
+	git -C src-super/src-sub checkout $SUB_TWO &&
+	git -C src-super add src-sub &&
+	git -C src-super commit -m "superproject two" &&
+
+	# the fetch
+	test_when_finished "rm -rf src-super src-sub client" &&
+
+	test_config_global protocol.file.allow always &&
+	git clone --filter=blob:none --also-filter-submodules \
+		--recurse-submodules "file://$(pwd)/src-super" client &&
+
+	# Trigger lazy-fetch from the superproject
+	git -C client restore --recurse-submodules --source=HEAD^ :/
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.38.0.1471.ge4d8947e7aa

