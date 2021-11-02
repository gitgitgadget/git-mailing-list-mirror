Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B4CC4332F
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8363860F5A
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 12:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbhKBMaR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 08:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231194AbhKBMaO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 08:30:14 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46780C0613F5
        for <git@vger.kernel.org>; Tue,  2 Nov 2021 05:27:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id c71-20020a1c9a4a000000b0032cdcc8cbafso1946377wme.3
        for <git@vger.kernel.org>; Tue, 02 Nov 2021 05:27:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzlJzQtD48Z6qakgyJN9Jyj7/OVEDeqjq2OC7yZmO2s=;
        b=DgqA0R+yGuTpynBsCzlaneTvsSxlRwLQynukmcrynik/736qq59BWwoa8jIyfzFrYT
         eS1szLL6YA39BM8g7Q+RLw94RqGssDN/OGXRL1ca2eP6C7q4qc1WGgz5PARsx6t8ePC+
         3n+Iu9P8Seu2yvOI7BjL9t7TWjO8IsTkDk8lOHBtZfz1nP664U6dRkBRn8J8ZGEk5s5P
         SIPWuXZuAUbaeL8BlnhPga7SkcNbwfNFnyGocJIye/0BAE2yGOZfHKCajcXdcXmagTmM
         eCZHXNeLowxZfSwb0J4NGBXnjTenLFVgGpsvFPpOYEJlQFQmL7FndHSuBnbN8O9HFkwN
         zGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzlJzQtD48Z6qakgyJN9Jyj7/OVEDeqjq2OC7yZmO2s=;
        b=a3uYimVkZZXGLNWiKqC8UY5KgCqEaeg8C9KRMEqcj5DvnUeSyvl35OtkFgWMSthkGY
         GbqcEm/oNvzi+gprOlaR9ksqh7P1D+b03GN6gMNcUdEnToaw9LHI4uB5Ug3wlPQYtK7j
         /UHU0LmdoVwKPtM8NKW9yoqNZ325X6VBXMGq6oEDE5Lxvzv1uHVFKCffaDWLirvjx966
         YcoOJJRlR0KHNcyPR+vJTEoPdRfOcMAOUMWJyIKJAuE2Yn7AnCTcXqVSz7pduJ0dDIzy
         n+Y8iEY4dbWOquB8iPqCvLq9plSTvFXS86v0XUwxMffk0+7fgiwmtWrrQIxkXXwvbZnd
         N3tw==
X-Gm-Message-State: AOAM530JjB4yEd5pEvT4JSqEPnfrTv02f7GShscIsiQ1A3kaXwtmVLYs
        tclT+ct+CMsRtrMoXsxfCRw/zZdYmcZGUg==
X-Google-Smtp-Source: ABdhPJwdt5gvDjVNGaJ6n7D5C33/9AO973RfYeF7EawdD9pk7sBalrYT+jQ9CdKBcv2MwWv2Ne8FDg==
X-Received: by 2002:a05:600c:a45:: with SMTP id c5mr6589698wmq.79.1635856057514;
        Tue, 02 Nov 2021 05:27:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q84sm3332236wme.3.2021.11.02.05.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 05:27:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>, Johannes Sixt <j6t@kdbg.org>,
        Carlo Arenas <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 5/8] progress.c: add temporary variable from progress struct
Date:   Tue,  2 Nov 2021 13:27:27 +0100
Message-Id: <patch-v6-5.8-61c8da31aeb-20211102T122507Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
References: <cover-v5-0.8-00000000000-20211101T190630Z-avarab@gmail.com> <cover-v6-0.8-00000000000-20211102T122507Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a temporary "progress" variable for the dereferenced p_progress
pointer to a "struct progress *". Before 98a13647408 (trace2: log
progress time and throughput, 2020-05-12) we didn't dereference
"p_progress" in this function, now that we do it's easier to read the
code if we work with a "progress" struct pointer like everywhere else,
instead of a pointer to a pointer.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 progress.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/progress.c b/progress.c
index 680c6a8bf93..76a95cb7322 100644
--- a/progress.c
+++ b/progress.c
@@ -325,15 +325,16 @@ void stop_progress(struct progress **p_progress)
 	finish_if_sparse(*p_progress);
 
 	if (*p_progress) {
+		struct progress *progress = *p_progress;
 		trace2_data_intmax("progress", the_repository, "total_objects",
 				   (*p_progress)->total);
 
 		if ((*p_progress)->throughput)
 			trace2_data_intmax("progress", the_repository,
 					   "total_bytes",
-					   (*p_progress)->throughput->curr_total);
+					   progress->throughput->curr_total);
 
-		trace2_region_leave("progress", (*p_progress)->title, the_repository);
+		trace2_region_leave("progress", progress->title, the_repository);
 	}
 
 	stop_progress_msg(p_progress, _("done"));
-- 
2.33.1.1570.g069344fdd45

