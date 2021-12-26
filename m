Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C30A6C4332F
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 22:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234776AbhLZWhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 17:37:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234761AbhLZWhb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 17:37:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F40C061401
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:31 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id l4so8686943wmq.3
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1z1jyfEdfkOfqJ3m3MAiFxW+MrSIldwrk63Syc5uIR4=;
        b=GZrrKHwtEvJaH2oj9u1eN8CikcjCYGNnyzzXG913RhNSAph6vak5zRxhfWf5lduiY1
         yQtPSFL2951T0NahLs7A8AFdhdNjEV7BRcpnwSIeaF2dJ7uo7k3DKcuYpHteTH4ZAnj1
         TnPbV90txJB2MvnzCNNWeqcxXJqdRYqe7Ku1OIFS6mICDayJBcbu1L9qhiFKYbYCkUaQ
         jacg2taTs7dN7ut5YuaXMGohEi1sy9JPO6WDZxyxWMPgZYAp/jtVRAwkpcm8442FgBzd
         woLPNIuxLfojZdhjPrw/RJLYSfJySAsOKqhWmwGHnId+Baxe9Q4zj3unaQfP2U90Tu2d
         9XaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1z1jyfEdfkOfqJ3m3MAiFxW+MrSIldwrk63Syc5uIR4=;
        b=6KLllv0gtp1IdY14k0DTtb3uehwfu8ytMku31UO/OTdCEoCS+DiWDJq70cdBLPc0+e
         iWle86fiTo7KTSnjVEKKUXhNP4YmWRXATjGzRbrmahKQnpNPZqjU/rwmmUVR05irX5E1
         5v4TQ00R6A7T64vSsmSPHjpkQMvgFQWn/Rf+GiUFAiWJ5yW5w6fQpc+eql1qMuFepTJQ
         1W0wkgqMdPIvOmxRdLVKs7Uw1nzgKGZvVzTWy4arVZ2fLK4eUjU7l5Yw31qV8ub+RxeO
         ahmwH8GROTHPk0OlDNzJSGkPgplcpA7jZ6j/c0L43K9H5ZOV3XphB/N2Vh9lJYWNcYS6
         0/mQ==
X-Gm-Message-State: AOAM531i+qj5vYeVzeEVy1vCcxKdZEJa7GWJhlsOqwahPU1mnaspoNJx
        9Y9TALAqI+uhx5mV0DEFf6FenPvAsogY+UY2
X-Google-Smtp-Source: ABdhPJzLO/X7UOd7oN6LCx5Mq6iNI8GayV2Fm8MlGovbSqXrvSIJKyc0I2na7k4aSJP17zdvwaOzzA==
X-Received: by 2002:a7b:c0c4:: with SMTP id s4mr11210887wmh.26.1640558249283;
        Sun, 26 Dec 2021 14:37:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay29sm16289861wmb.13.2021.12.26.14.37.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:37:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 5/7] grep.c: don't pass along NULL callback value
Date:   Sun, 26 Dec 2021 23:37:17 +0100
Message-Id: <patch-v6-5.7-069b0339146-20211226T223035Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1239.g84ae229c870
In-Reply-To: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com> <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change grep_cmd_config() to stop passing around the always-NULL "cb"
value. When this code was added in 7e8f59d577e (grep: color patterns
in output, 2009-03-07) it was non-NULL, but when that changed in
15fabd1bbd4 (builtin/grep.c: make configuration callback more
reusable, 2012-10-09) this code was left behind.

In a subsequent change I'll start using the "cb" value, this will make
it clear which functions we call need it, and which don't.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index d85cbabea67..5ec4cecae45 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -285,8 +285,8 @@ static int wait_all(void)
 
 static int grep_cmd_config(const char *var, const char *value, void *cb)
 {
-	int st = grep_config(var, value, cb);
-	if (git_color_default_config(var, value, cb) < 0)
+	int st = grep_config(var, value, NULL);
+	if (git_color_default_config(var, value, NULL) < 0)
 		st = -1;
 
 	if (!strcmp(var, "grep.threads")) {
-- 
2.34.1.1239.g84ae229c870

