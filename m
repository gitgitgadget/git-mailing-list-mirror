Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B75BC433F5
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E7AEB60551
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233105AbhJYL1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbhJYL1f (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:35 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455B8C061767
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id m22so8895840wrb.0
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EbsG0EM3mwaRgbSFnkf/58IaUBPc3hPXNcYps+BMyxA=;
        b=Rz2PboDffKAjfPx9m2yRb851zHghF9HPUdj+Oy7VLG9zRUYlKTvst8wuwn/zVF2lCa
         X1ZyVvO3f8WC2Ej9YteC/7YL18tMpubIem3YX9X/X2EeFwDd6xfwF3gSczKpWxMcgDwJ
         VtTu8ldm1hFPYuM/AnBwveivp3Da4DSYAaubFbHlMqe0Y0Rk9QszrWoOpactwpOUSj+r
         WkiTfYB3ulbOLvsTqQuNcdZgGdHNLqkHPG7RvGobJHDItcaNAB+udmapmTZKkB1tiqWq
         fVPR16/umHW5NQQVmaw+pTMMuHwVsOgHlQFE3EpM+RZb/9ju+zhRr820FWtiFgUOHZ94
         8JWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EbsG0EM3mwaRgbSFnkf/58IaUBPc3hPXNcYps+BMyxA=;
        b=QxNyW26SseAwE6W17oBkQ4zM2S6Ag5suayymh8+yqnUhC6y8CLsXwIQvBr/FJ/J9V6
         dt85PvUglD/Cd6w/CD14w3LNWGjDd9o6dul5hK/EREJ4a0dE35XEXAvZWYYsGL3mrWbO
         zQ1MOHGJHVMBUM3KkiZ2yHV3LNEHTt/bJGwo4JL6YM13raPSuRP80yC3eDhdsgzQozfg
         fpMUWYUO981PuudapuC4R+tu090nRM7jwKHh8ofXAQa7GV2F6PFXCekgg+wvci/3PkDd
         zLTNNWVbD4GhM6sE+9dp0vaSn9V+6drrBgpVHDnzrQDUSx7GVoy6CisWUPXzkdjdNjVV
         BtHQ==
X-Gm-Message-State: AOAM5337IHX11nMOqcWOhGbMscZKZLhIR35pWiF966jGq66y7OGsmPqk
        /vBJ8origKQqpBVhIL2gdWX8NO6tCkQnhg==
X-Google-Smtp-Source: ABdhPJxwhuLeylFpL6xaPze3Kovpa9RJivy6kXV/79lmJsRJSqOt4/a9GKfqv2/noKBmx/WhMJG/qQ==
X-Received: by 2002:a5d:64a1:: with SMTP id m1mr11114893wrp.101.1635161111609;
        Mon, 25 Oct 2021 04:25:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:11 -0700 (PDT)
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
Subject: [PATCH v4 2/8] progress.c test helper: add missing braces
Date:   Mon, 25 Oct 2021 13:25:01 +0200
Message-Id: <patch-v4-2.8-e441cfea7c5-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If we have braces on one arm of an if/else all of them should have it,
per the CodingGuidelines's "When there are multiple arms to a
conditional[...]" advice. This formatting change makes a subsequent
commit smaller.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/helper/test-progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 9265e6ab7cf..50fd3be3dad 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -63,10 +63,11 @@ int cmd__progress(int argc, const char **argv)
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;
 			display_throughput(progress, byte_count);
-		} else if (!strcmp(line.buf, "update"))
+		} else if (!strcmp(line.buf, "update")) {
 			progress_test_force_update();
-		else
+		} else {
 			die("invalid input: '%s'\n", line.buf);
+		}
 	}
 	stop_progress(&progress);
 	strbuf_release(&line);
-- 
2.33.1.1510.ge5c82eefb93

