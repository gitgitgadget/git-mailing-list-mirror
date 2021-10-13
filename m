Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 193A7C433EF
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0181161152
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbhJMWah (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhJMWag (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:36 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31344C061749
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:31 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id y3so13297579wrl.1
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TDvMrx5FyoSPasPYzPlyF6XWXWetuKGLYNhXWYxOezs=;
        b=N4oKvfq7J7N+6S+qvtDW8+hJb8d6YibRhwVHmM3gaGyhcb7zbJ7YNQoycr274Hbi4R
         qVvM81o6wzk7W6eYwlRSsVRec5l9v1AMSFPoMzt5qy4K5qfsvV4jkcXWuHO8iWI7xAH6
         HFWBDpkyDXLaFe1oYUHOqsX8JDta2H1Wmc83MLIqvBiZduHINZHeXwUjd7Ms2/W23LB9
         9lHQCdNSjLDgGm49YNwDcjLhQ6knosSW/dEOwwbZYPjt+6luziAPmp6bl4SJNymzxHhq
         QPdA9QIKwvyT/rgWAV0xNbji0flLy/WnBC8vL1YqeoAQz2zwaMAxgtS8UpQSmlkrcFTW
         9O+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TDvMrx5FyoSPasPYzPlyF6XWXWetuKGLYNhXWYxOezs=;
        b=QqH5JW5tBlENKMkNszX2dUTpjQJDOYNV8Cu+DzB5wjKf1qS34VXrGQRstT3uYUNKd2
         zzRutgoix7fkNmMpICDJF7sZRW7+Mk/SDXrCmxj+bGlYUcOIitSOmz6M/n54MV90fcnH
         A075r2PC/Vyo6dOceXsDMT6DelauvTY4Q9OtBsLsruXjREqBfyf28/0qgPUCUj5d+iu1
         Fh2RLjIV7HHDyLF7Qa2p989TfWVY6adkegvt/J1cTTX0HPPKh6KiGL/10xyWzMTPywNP
         YWTcROeBdhmougg5Nd/Vt16IzGh5wyjU/0vmV6F00FBUVIzkOVF3NIdksH0SjKt8RqdH
         H20g==
X-Gm-Message-State: AOAM531EoUlhI5TvRYKVhCWA4vuC/1RGp1QJypeAbcechKLDZCGQr31s
        nqyejR4+BpmR/tlQ0QFugo0Ykya061gTKg==
X-Google-Smtp-Source: ABdhPJxMa9GVCarb1FFAu9eX2aYtKDoD1y0JzrriFl5bkQQnwAR7y6r4+GP/IMQNK4vx78aXXwNCng==
X-Received: by 2002:a05:6000:1449:: with SMTP id v9mr2077513wrx.433.1634164109992;
        Wed, 13 Oct 2021 15:28:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 02/10] progress.c test helper: add missing braces
Date:   Thu, 14 Oct 2021 00:28:18 +0200
Message-Id: <patch-v3-02.10-ee177d253a8-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
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
2.33.1.1346.g48288c3c089

