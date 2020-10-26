Return-Path: <SRS0=PD7l=EB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16B48C56202
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BAA582085B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgcw/WDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793232AbgJZTdH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:07 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52436 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793182AbgJZTdC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:33:02 -0400
Received: by mail-wm1-f65.google.com with SMTP id c194so12833022wme.2
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wJz0vtwqUUjo37ezSXWvV4obEraNnTX8m6e065xvb5E=;
        b=pgcw/WDV/B9zJUpSJidJ10RcL8+8++P++PZ5D1SVby1dZZCUa41ghN609xzVxfyg+T
         DQwSvq2fn6qi36XFpLNBnBVTkVG8siLznfFSwl1N4+2PoyYEfrBpdTXRDe2hwk9s4XZn
         36bz19Cy1dBUD9cn7SwlOEfWDp3exhmhGHGNlwSWEV5di4uW1U1zJqIBHVy2zYGLXjOg
         66M4L679Se/f94rOi96Wte1HNqIgdzghRhNXlObtGFx1ODTHSebJ6DzCfnsYQql6gjrJ
         yqu9z7JGqtcP+hvc8n5ULKrRjEbn8Nr/u/zFt5TssWmSCUlCzL7rZhaKd4fyIBzq5oCo
         BQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wJz0vtwqUUjo37ezSXWvV4obEraNnTX8m6e065xvb5E=;
        b=RFc13FY8gwyRPowPRrfB00qEZYK2Hk4GsNK6K5DR95/fXAjpmu0K3HJIryIkfPiFQj
         /TBLMRoqCLyPttCAeW1QHcoiNT1pg1OVhqbMv2pREbEq148w/i4HEB3CDd7c+UvS5mGA
         WZQHrgP+oytGzL905b3p2tjh3DO7iqb92B6MSMIxvQgieJJ050uoSJcy53tNtBvuswgV
         /yLliYgF8KHgsGJnowK4x57xgCoMVJELsX3lGt/DlUUSPhcLEBp9cCuL3QpX/bhWDGoL
         d+WeO1FptI3cv3hBFAmMOnt5ZRJv3C6/FMxsLfmQ/UFkgTR/CA0qeNF8TR/YtnId+y2D
         ++cA==
X-Gm-Message-State: AOAM530PnSHi6JfC/v4FWo5QxboW71csVka6SjWSwcteSGTjBppOVTrH
        XjuNhRq1IFCtkVLQXhv39lsVsz/FI+4=
X-Google-Smtp-Source: ABdhPJy/sbEpTff5wZbU/MqMEibe5B4+pEX4zlUmcddOc1hxT/qACKKczUB6iz/yjZzG6Vh1K/hr7g==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr17740690wmg.18.1603740779531;
        Mon, 26 Oct 2020 12:32:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z191sm23172782wme.30.2020.10.26.12.32.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:32:59 -0700 (PDT)
Message-Id: <6543e90c00843214676b658a033656e040f1c6a1.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:49 +0000
Subject: [PATCH 06/10] t/perf/fsmonitor: silence initial git commit
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Nipunn Koorapati <nipunn1313@gmail.com>,
        Nipunn Koorapati <nipunn@dropbox.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Nipunn Koorapati <nipunn@dropbox.com>

It is extremely verbose, printing >10K non-useful lines

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 2c817db1ae..970caff3d2 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -94,7 +94,7 @@ test_expect_success "one time repo setup" '
 	for i in $(test_seq 1 1000); do touch 1000_files/$i; done &&
 	for i in $(test_seq 1 10000); do touch 10000_files/$i; done &&
 	git add 1_file 10_files 100_files 1000_files 10000_files &&
-	git commit -m "Add files" &&
+	git commit -qm "Add files" &&
 
 	# If Watchman exists, watch the work tree and attempt a query.
 	if test_have_prereq WATCHMAN; then
-- 
gitgitgadget

