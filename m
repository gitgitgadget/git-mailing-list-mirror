Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 923CFC433EF
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75F1360F46
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:09:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbhKATLz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231509AbhKATLy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:11:54 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AAFAC061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:09:20 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y84-20020a1c7d57000000b00330cb84834fso169380wmc.2
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ufHwRkxGYi92p2eh9JHC4nqjBONEttk0ji459/spTtw=;
        b=VoRlGUoTsnjMxtc4q3LLLuk/xxPwgnUrtmw5wwubAqggcOsxH03VMK2LGeNsqPkVlL
         2RvjA+6RXCTKdGFsbLaa37Euo0DIC5myux0Wls/RsIGXpoSyDsodhG8xS4f8UlJh+LsS
         NegRyH/RpN3pPgjTxvDZr7tJRVQr0BeFIxGwcyh1xupmWmZedFn+D/wKVL6RbKFyb/tr
         2CsZTmviubP3IoY9jqBt6qIVwWw+CzOJAThOoUHRT+yiISmbXGT5hSWRsNH+Fd36VXCG
         2PUYBQrYvYLs0oPjJ/zNnILFKxS18xblWov3hyvNov8tB0Wu/al7AjElPPKl3vobZo6/
         FG1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ufHwRkxGYi92p2eh9JHC4nqjBONEttk0ji459/spTtw=;
        b=R0BKRPtsT9R037JqmECA5Saa28oNNuJrPGysqVwr2cgXKG46Dbvc9JpQ8qmIjmgtch
         kxBFRvhljnSHXgbH9YV+j6GQuEUmFuroI49Ouh9c2UrhDTivb5+bQsG0no7V5nlfQIQg
         s5itOuK7hCHgJfSj5A2DWnsq3ZYHbOC2IhHODHzZoMOICtBcSvrS/4uXURJZ6Kz0wLPW
         TmYCS2v8kRyoLmTWWgt5SNDSKdml3wgnXCybDSXGrPwli7ie1QwJM44Qz09bafo5j7Be
         jdv4rmmy1GWxLdg3mSQO2a7QBO3g5IX46gQgtRkOttfd8PO9nXy6qBnqvYWslP7t/5pG
         QzNg==
X-Gm-Message-State: AOAM531RshIxZ8w1gY7NO0a8LHD5AE+Thlwx6nzmHYAtMiG8q6N3DD/p
        V+uygMq3RZURJo0dHu5T0z6889FrxxSD1Ji5
X-Google-Smtp-Source: ABdhPJzzLKzhFO13eZOVAuw40VT1tZxS2PEPjYSU+nzL0E9lleUOA1mmNSZGSU3mCCeAIWxz6fMtGA==
X-Received: by 2002:a7b:cc11:: with SMTP id f17mr949507wmh.122.1635793758946;
        Mon, 01 Nov 2021 12:09:18 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p12sm4337211wro.33.2021.11.01.12.09.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:09:18 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/8] leak tests: fix a memory leaks in "test-progress" helper
Date:   Mon,  1 Nov 2021 20:09:07 +0100
Message-Id: <patch-v5-1.8-0c0e5bfc656-20211101T190630Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
References: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com> <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com>
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
2.33.1.1570.g069344fdd45

