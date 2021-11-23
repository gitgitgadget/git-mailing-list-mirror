Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31DEAC4332F
	for <git@archiver.kernel.org>; Tue, 23 Nov 2021 11:46:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236340AbhKWLtp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Nov 2021 06:49:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236455AbhKWLtk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Nov 2021 06:49:40 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26450C061763
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:29 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so38443550wrr.8
        for <git@vger.kernel.org>; Tue, 23 Nov 2021 03:46:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ycsl7qYc/5fSrAoXHxS9HM2S7S3ofNPq9Jqs+qOaEj4=;
        b=F0QrK+VF8Hnlacf3GP3HybQJzM8j9/ckEdORn6q5wIsbapcGViroL53Viz1ksB6S1w
         ymd3ooWHh9ZUnsZ67G/DrTLKVKpbJntPANVRMmes2YKQeMi5TfYh9VJdLprLWZqoDpnY
         ry6raRUHc5FPpK8jD6xBiFjlryaNbNi3WVbuVc53M7U5OWuYhaWp7VZZRJfGfw4WEh5s
         fIFZI1gdcInla6eoyQM+7mpgFwK0E7YSdXLcO/Ph+ApK4b4mosZ00G88uJATt3AGm5q1
         1MtoBilyum064EnVrrzLEKKuYiWA7ZIXBz3BtuCQQVxi4kmao2oLolOmMd9HFachScKD
         zp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ycsl7qYc/5fSrAoXHxS9HM2S7S3ofNPq9Jqs+qOaEj4=;
        b=yA6qGeGBY31DfZA7GjPPbgB4Pn+J6ANzwM6EgPXN+NRP+HhbcTQPXA1SE/axbB8NeB
         8VgWpipnk2hBVPJG79X3oK9k7/eEXcF525ceJQp7R4YGVdxxzi7FZIYFDe0xxjk9Aw4L
         dpcrP9aFuWHuw36UAVPrmLa1oRRX1DNQyHW5IhHRmvGo1/tT5Pzx/NxgjDu0H8/KbtpW
         23cehUhfwNNNcEdYQPTVgLG0P6u0xr0wieoQRMfCgCqRamzacQ0SZe28OMOo38GuF9xg
         e455lgFafLg74zMBCvNv9u6spCCt4V+QHzKNZBXUdwf6O9D8fO+FZvszMSD4DavLmsL6
         vZcQ==
X-Gm-Message-State: AOAM532MrVXeOcIfFd/8DziCbYdALHaPzCKR2gilhaZhKFiqvLJA+LeB
        dHVb5fyz16E9v8SvgRc8uIB30NPIU3sujg==
X-Google-Smtp-Source: ABdhPJw9qBim9Ol8VUs529nfutphDwwXJaUe8NXdKcPcJTGqWZTOQcCt82v6v1CN4rLfaZnCDL4gWw==
X-Received: by 2002:a5d:6da9:: with SMTP id u9mr6957516wrs.237.1637667987543;
        Tue, 23 Nov 2021 03:46:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c11sm1723145wmq.27.2021.11.23.03.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Nov 2021 03:46:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 08/17] merge: convert post-merge to use hook.h
Date:   Tue, 23 Nov 2021 12:46:07 +0100
Message-Id: <patch-v5-08.17-119b92fbeae-20211123T114206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.831.gd33babec0d1
In-Reply-To: <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
References: <cover-v4-00.17-00000000000-20211101T184938Z-avarab@gmail.com> <cover-v5-00.17-00000000000-20211123T114206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Emily Shaffer <emilyshaffer@google.com>

Teach post-merge to use the hook.h library instead of the
run-command.h library to run hooks.

Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/merge.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index ea3112e0c0b..e6facd1c95d 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -488,7 +488,7 @@ static void finish(struct commit *head_commit,
 	}
 
 	/* Run a post-merge hook */
-	run_hook_le(NULL, "post-merge", squash ? "1" : "0", NULL);
+	run_hooks_l("post-merge", squash ? "1" : "0", NULL);
 
 	apply_autostash(git_path_merge_autostash(the_repository));
 	strbuf_release(&reflog_message);
-- 
2.34.0.831.gd33babec0d1

