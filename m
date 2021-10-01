Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55FABC433EF
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38752610C8
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:17:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352965AbhJAJS6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352915AbhJAJSt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:18:49 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B2D3C06177B
        for <git@vger.kernel.org>; Fri,  1 Oct 2021 02:17:03 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q17-20020a7bce91000000b0030d4e298215so730182wmj.0
        for <git@vger.kernel.org>; Fri, 01 Oct 2021 02:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u/kZVGaHdt9Pow4L0kVNsM0cKr+aE3rOPJbriFA3iqs=;
        b=UFK5yVz9tvKRAHEcbHsnZcpoK+24UfkeuOk+qHgDbmCqauPyMtb/A56HBl1nHYNJms
         enGAjtRYn+8kYIffsm60XGWdNimsb3TuOYQ3rFpvSn9PbxY311WSQkcfOtnTv2yVhDAU
         WDKRmgMwDqT34hc7V84m/BC2PspnonSOtGTdW8xgNRSdaMVMm7oWq7hWGJ/4W1pj2gz/
         +hVTfpLyQvyujpZj/QqLWAYyagCeAEOR2jlL5tenw3R571dxjCtLD6jEJPiWDDKyhSon
         TW1ZxFtsvTI/uUGt8K1VQbsihcJ8zd+sQEWDltl/iKOknqWF6EA+n/lZgcza4RB4WaQr
         nZ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u/kZVGaHdt9Pow4L0kVNsM0cKr+aE3rOPJbriFA3iqs=;
        b=oY/vy/HjXwIUiSW0D89437X5GQSDX+7thAz2434dqsxNToiYpxHAP4E4KmK9qES3Pb
         ofJ7p7xm078HUvUKDf4BEpirelAA8Q3tqXTAvKzzDtDRtbUR2X66yRS367pqx2UAYJSs
         aG+gIVo6Pug9Txg4Mg6ZOkwRNJ9iKSkYkN4xr6pzMK36UXVMmW1FFNjINclVFxtRtGdc
         Dexe1hFYt8vyGQuBDtOcSSp11pQyx0PEAYFAwwJTS3Hbzjq7EhchP3RUYgEhU4XZ2px4
         g8AKgLtoxwk11tFCpAVNXtwDdy6ZXQlXuxBrQk5XD4FI4ceiONVBhjKvtWp4LiXEoRV1
         uKrQ==
X-Gm-Message-State: AOAM532FJzP8qPxpk72gUzaGoCO6a2RUrFocy4YSPdzBxXuQjL0CiFTb
        NpiwZValz56XJe69WmeyF3evIg8RSJzERw==
X-Google-Smtp-Source: ABdhPJy2I7me500dZ6xCfWe43u9AqpbmBGUMkk7EeMFLVc2LXZh2o/jJ1wtEq1XPboB7sGmKSivpsA==
X-Received: by 2002:a1c:f201:: with SMTP id s1mr3362907wmc.101.1633079821080;
        Fri, 01 Oct 2021 02:17:01 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j4sm5301346wrt.67.2021.10.01.02.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Oct 2021 02:17:00 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 04/17] fsck tests: test for garbage appended to a loose object
Date:   Fri,  1 Oct 2021 11:16:40 +0200
Message-Id: <patch-v10-04.17-a527e3b262c-20211001T091051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1375.g5eed55aa1b5
In-Reply-To: <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
References: <cover-v9-00.17-00000000000-20210930T133300Z-avarab@gmail.com> <cover-v10-00.17-00000000000-20211001T091051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There wasn't any output tests for this scenario, let's ensure that we
don't regress on it in the changes that come after this.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index f9cabcecd14..281ff8bdd8e 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -93,6 +93,26 @@ test_expect_success 'object with hash and type mismatch' '
 	)
 '
 
+test_expect_success POSIXPERM 'zlib corrupt loose object output ' '
+	git init --bare corrupt-loose-output &&
+	(
+		cd corrupt-loose-output &&
+		oid=$(git hash-object -w --stdin --literally </dev/null) &&
+		oidf=objects/$(test_oid_to_path "$oid") &&
+		chmod 755 $oidf &&
+		echo extra garbage >>$oidf &&
+
+		cat >expect.error <<-EOF &&
+		error: garbage at end of loose object '\''$oid'\''
+		error: unable to unpack contents of ./$oidf
+		error: $oid: object corrupt or missing: ./$oidf
+		EOF
+		test_must_fail git fsck 2>actual &&
+		grep ^error: actual >error &&
+		test_cmp expect.error error
+	)
+'
+
 test_expect_success 'branch pointing to non-commit' '
 	git rev-parse HEAD^{tree} >.git/refs/heads/invalid &&
 	test_when_finished "git update-ref -d refs/heads/invalid" &&
-- 
2.33.0.1375.g5eed55aa1b5

