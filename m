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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E926C56202
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50E7E2085B
	for <git@archiver.kernel.org>; Mon, 26 Oct 2020 19:33:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mc1Zcbjy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1793212AbgJZTdG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 15:33:06 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:40589 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1793198AbgJZTdE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 15:33:04 -0400
Received: by mail-wm1-f68.google.com with SMTP id k18so13652402wmj.5
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 12:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=fTu+ikldQcPlNnRXrfMHKhzqWXN5I0TZ6MFtQU9jbUY=;
        b=mc1Zcbjykrg5rC0VqWvbB1+dMnDGjrGCjHzmJf6bDOja5lVBT1whQ+V+RP/+FegKSY
         79ii71S6qe7wXQLtabgaXKNmUhhqnF2RXKhUYQ3Ek00hLtkkf5EN0ozbd2TR80c6fbqL
         zrlHy58gSUarNmwe0shfzn2rIqMOmIZV9N/+8MYYygbNzeiwyFWz0oVR9vqktRrk0TxI
         RImRQa+VFSvEUgK5plzx+2oSVQCUYbAVaU+nUZh16YYaeFYwRPjoeO/KjrDc8LkBPyTL
         7wnDdrG7Fd0yYSlv4vkoVL5nyf4qjY4Vr8RoxFFuKv2p/tYPEdVNb+u1HYUGVFFMYyQY
         jn0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=fTu+ikldQcPlNnRXrfMHKhzqWXN5I0TZ6MFtQU9jbUY=;
        b=Iy7AeocfXwe/XnN8XlyXHI3xq9kH6ouy/gwsqEDKOXYLR8asL5LLwfYmmWKTI1XA2c
         BF4oWvF6JuUCxpnRiyMoiisuSxw+JddNwv1nH8v4DnYyxSQyN4yfQNCur/kFhtt2QP//
         BYAX1PuGEW5Jr3i7ShkMsBYgiyU+blhD1BomVEPpaDPMM3JctG0wW4Q+PyIiNm9Qx7M9
         9ryWKr3T26wYB2wVkjZMq1UUa+wE3vUpJ8TBWzq4Q3KV4LUwW48OrLW/hZLpJD4/IlvG
         TtUWlL8E39niAo//dWUCS/wJTLUWyKT+cYGt7nshUoTtLqxu1Kx0CqoZ9l+jDrDHoho3
         lYxw==
X-Gm-Message-State: AOAM531hTPaDtm5taR7tAY0S3jRk8Ap7MzxaBWMMCZsg4gqneo17DprF
        HeH/Ib9C+VVCteVffwb76tZZPYDQ668=
X-Google-Smtp-Source: ABdhPJzfAFa2aL98Zzy0MY0bWeZQSki4m3Kv6zUI2MAigMK9rpxpQ08TpWeKxi1Vp34XElr6arTD0Q==
X-Received: by 2002:a1c:3c4:: with SMTP id 187mr12500233wmd.14.1603740782374;
        Mon, 26 Oct 2020 12:33:02 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y201sm10582179wmd.27.2020.10.26.12.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 12:33:01 -0700 (PDT)
Message-Id: <e5b0eee172b1186e39b5f9cdb649185b5b91253d.1603740773.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.772.git.1603740773.gitgitgadget@gmail.com>
References: <pull.772.git.1603740773.gitgitgadget@gmail.com>
From:   "Nipunn Koorapati via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 26 Oct 2020 19:32:53 +0000
Subject: [PATCH 10/10] t/perf/fsmonitor: add benchmark for dirty status
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

This benchmark covers the git status time for a heavily
dirty directory - benchmarking fsmonitor's refresh

When running to compare our perl vs rs-git-fsmonitor - we see that
the perl script incurs significant overhead - further motivation
to provide a faster implementation within git.

7519.7: status (dirty) (fsmonitor=query-watchman) 10.05(7.78+1.56)
7519.20: status (dirty) (fsmonitor=rs-git-fsmonitor) 6.72(4.37+1.64)
7519.33: status (dirty) (fsmonitor=disabled) 5.62(4.24+2.03)

Signed-off-by: Nipunn Koorapati <nipunn@dropbox.com>
---
 t/perf/p7519-fsmonitor.sh | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/t/perf/p7519-fsmonitor.sh b/t/perf/p7519-fsmonitor.sh
index 577f79d455..163a13bea3 100755
--- a/t/perf/p7519-fsmonitor.sh
+++ b/t/perf/p7519-fsmonitor.sh
@@ -165,6 +165,11 @@ test_fsmonitor_suite() {
 		git status -uall
 	'
 
+	test_perf_w_drop_caches "status (dirty) ($DESC)" '
+		git ls-files | head -100000 | xargs -d "\n" touch -h &&
+		git status
+	'
+
 	test_perf_w_drop_caches "diff ($DESC)" '
 		git diff
 	'
-- 
gitgitgadget
