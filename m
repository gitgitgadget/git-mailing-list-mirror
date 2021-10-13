Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C054C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52B8161183
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230442AbhJMWah (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230201AbhJMWaf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:35 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8D1EC061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:30 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id e12so13220870wra.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0hb31jai8oRS/QSuTfr/QIkQZRI0USLV0q1sWmvi5Ew=;
        b=qxQJkJOKNVo3yBztIetugB0M5GLpXYDJWLJl9YmmIKTxlmu59FDxW3S0H/xPgv3Dkb
         JE6T3L4eKfHxQmbhtoj+KDr5Na1DpRI4vka+urZ7DWAct5chYH/3es8oo4wkzR+510MD
         z73elnSPm3Iqonn0r1ZXoqc7oRux2dNLNCmn7A/Jg8ChN2qUuv++mYBayyhN688VF0MI
         dQ+4Janp3pEawTaHBpDcUJxIt9aWD06XD/lybDrBYoObzkXnGB2QJdzDyvlxLHP3qvOV
         4Fg39x4m3lsa47QvEkdbI3UUvYnThrkIjZuoVNACgQYI7qdqJV6zlyiQcHKkZO0Xi5X2
         72PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0hb31jai8oRS/QSuTfr/QIkQZRI0USLV0q1sWmvi5Ew=;
        b=Q+BYJz34SJSt6OydWjE+plz9lAQqAw7zX0/JqWLzxqd5fDdkEvFYN9js96LFk14Yzw
         1hdqQ0TpPhts6JPueHQBid7FjQ9Q/DVUoHcx54QCEmZeWHKnKwkkaKQYTjPx40kqAftm
         s6CSIwjR2Y4z1P7j7vF1rZtZRXM+1faO0Ff99vAvpp5WEVXRHxqPbY0p5z8w9qoy4oad
         o9+t6I4qbQeQt5ovWJjZsOC2qHqcprocTI3cxP6MQqTnHPFj7AZgNaWT8thCSHlGYGHT
         SFGv1C+LSTh1gHi5NrQaFwSL3db+vg1mFVGJ8Ko6rBXi/3fVr0Ic89c1H9pktCILocmE
         5vNA==
X-Gm-Message-State: AOAM533tj1ZyoYEXgsGPgnFdt6ZMnfibJMBlKRveCPjaTm31uZivcVgl
        jV0Wd0E6UQfyJfQrvDW8S8qBBtDbh1CrLw==
X-Google-Smtp-Source: ABdhPJxEsOKMqdBcwsbpRHDzPn+Hp8CrVrFRJfeqlPJ+vZd/FVxgQHkkcveyt9SyW7Jc+zl8qpaFdA==
X-Received: by 2002:a7b:c383:: with SMTP id s3mr15758233wmj.60.1634164109126;
        Wed, 13 Oct 2021 15:28:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:28 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/10] leak tests: fix a memory leaks in "test-progress" helper
Date:   Thu, 14 Oct 2021 00:28:17 +0200
Message-Id: <patch-v3-01.10-40f7c438a1e-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in the test-progress helper, and mark the
corresponding "t0500-progress-display.sh" test as being leak-free
under SANITIZE=leak. This fixes a leak added in 2bb74b53a4 (Test the
progress display, 2019-09-16).

My 48f68715b14 (tr2: stop leaking "thread_name" memory, 2021-08-27)
had fixed another memory leak in this test (as it did some trace2
testing).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c    | 1 +
 t/t0500-progress-display.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 5d05cbe7894..9265e6ab7cf 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -69,6 +69,7 @@ int cmd__progress(int argc, const char **argv)
 			die("invalid input: '%s'\n", line.buf);
 	}
 	stop_progress(&progress);
+	strbuf_release(&line);
 
 	return 0;
 }
diff --git a/t/t0500-progress-display.sh b/t/t0500-progress-display.sh
index 22058b503ac..f37cf2eb9c9 100755
--- a/t/t0500-progress-display.sh
+++ b/t/t0500-progress-display.sh
@@ -2,6 +2,7 @@
 
 test_description='progress display'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 show_cr () {
-- 
2.33.1.1346.g48288c3c089

