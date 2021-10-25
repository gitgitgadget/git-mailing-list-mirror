Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72899C433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F66C60551
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233088AbhJYL1f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233081AbhJYL1e (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:34 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A1CC061745
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:12 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id e4so12214618wrc.7
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=djINBR4XCf7WufzYI7BJR1aL8y9PMnYTVmR09XWwbfQ=;
        b=kDSSAtXxzApfFqE1X1gn6sPvgpLGNbhOMfEIWX7CPMqNrNH4St3G1H1YKusmSmgrf1
         rEL4mnB7FcRwPEKKr0g0+nFGkRDuvhPTnYRNg1iAH8KSM7+0XCTPI3IQkur+mMhjrd9m
         CGpnVZgKVodblCuNPgvD40q9ZWMHMGxy9kJqnRG7ToBpV1sc+aI4a09UUpK4QluYnA0g
         VJMwaaN5Xsnnp06nKGJteaiaCbiyw/BBjz7mh3kD1dBnCYxy8If0MCZerre6YJR1JjPD
         Vab+2mh5NXdJ5yKktV/q8mu8TOa8D6mibV6fZXPl4VQhh+v/qIELnkDpqRd0uzOmVwSH
         eKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=djINBR4XCf7WufzYI7BJR1aL8y9PMnYTVmR09XWwbfQ=;
        b=QPGw0ajzNS7DDwatK1f+AdRN7xouW4IEyxbEj4c7TQWUY1IzOSpb0ywhVrH7p0SLcw
         Sc7Ure0UzUbn0GH7hIyk/xmsYnfmrv+GVCPqi+4htwUcHNYtQDp8eX1zKBcye7vAzrZ0
         OzV4TS4mlik6OGNQmS5BEo4DDVVcNyTKe6Y347ZxazsHjR3pn13druztfqdo+mTA5WHd
         sSB1juMFmXU1WHtxWSeOBLJVdQsRPxQeCktgkImF2zvKNmgQbEckScKtXZf0gBVVH6Ch
         YB/GnfLgdEOenMnqZnL4Gvl9HFSKVB+fYjkMr/gv2YdatYoNUfaSXmx00/Or0lqV+x7S
         kGHQ==
X-Gm-Message-State: AOAM533G4vHfRL1nMyfAVAL9xToA7HYEaJcFTVPMI95cMnKZFFRp1jHZ
        id2WeyPvfV/qOsArH5sBJ5qVtAXErwoiNw==
X-Google-Smtp-Source: ABdhPJzgOMFX62WmptBVE8K0m+bX177x65KhRurhYdiS7dbUE9aju5qLwyktUDXVwOHGc5XpgUVK3w==
X-Received: by 2002:a05:6000:2a4:: with SMTP id l4mr23282720wry.221.1635161110866;
        Mon, 25 Oct 2021 04:25:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:10 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 1/8] leak tests: fix a memory leaks in "test-progress" helper
Date:   Mon, 25 Oct 2021 13:25:00 +0200
Message-Id: <patch-v4-1.8-a3bd032d1eb-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
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
2.33.1.1510.ge5c82eefb93

