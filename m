Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78EDBC433EF
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6621D60F46
	for <git@archiver.kernel.org>; Mon, 25 Oct 2021 11:25:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233127AbhJYL1l (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 07:27:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233103AbhJYL1i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 07:27:38 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90292C061225
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:15 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 62-20020a1c0241000000b0032ca21cffeeso8580110wmc.1
        for <git@vger.kernel.org>; Mon, 25 Oct 2021 04:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yuW3dE/4pXNUEbjfNDw2oKQ7LStdBet8HwwI9x2amEM=;
        b=EuwwGj39P6+HVswuVAD2nG9Efp2pfiiQ023RCeRFAvCO6rx3a9nhyPKgm3mrvll0/Z
         +amEFjEC7cmqwcAtBTh2tqN6KB6aEh/3eohkszWo5gvz0goKerEV8HXs7HLv6opPfVw+
         RIIkRiiPtatU+cQ7phTfL60EeLZSlCujOtglZWgJs/GlIztT9vo6VvJEuTXj5dfzl5+C
         JDF2G6JXqErr4ZmVatr1VdKMn86FbtNm7qMrl8EJPm/C7ZIn0LfJaoKnF19UiVa/XoOA
         5+kwQGO+BIUX+H4+Cu+uhKk/SrY76u5UEfrfSBcYYbczV2WKSbI9dkgzMx4KtvHGKoQc
         lyvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yuW3dE/4pXNUEbjfNDw2oKQ7LStdBet8HwwI9x2amEM=;
        b=Zm5UPRcquhL/nVzv0efqI9zZyDYqJtXsFNF5UFaO+skDul9TI1L+0deczqLAMGZ1Xj
         n+a2o1mMvII9sih2QJdMxrmbQMuAbmJCtc0S9JN95P0jry7zCENrdzw+kwWMSYbxMEAL
         wWgzG6y4SrHxcQ4mpbUwNmvv7I5Khzlg3SFoX21SZZwceNC0hWqdo3Sy7L+JMNpsIF+U
         Vya/MsfB1Mmr4ln1fANC7J1rVgByOu9GzhZsF7zzIq1aQEwOLIn4WNkGT1aiWxcDkc2e
         yKOtkU32hoR3OBKsQSgwyo1dixCqbQlbDuFYmIFXnbVHSO4dBIIB0wiyuCZ2rxvWT24x
         VjOw==
X-Gm-Message-State: AOAM5305Akr8g0f+LHDskX6IinD1Uam9lqq94VYH46j3YUp5ueOeYCMv
        N8kGxhGi4lEta8wOg9Vwh8DS2PsYOKH66A==
X-Google-Smtp-Source: ABdhPJzxgqWC15FOcchRdBmBEJrwigx04LxXLzEC/pQI1b/JzOmqKGurE6zZkuWbOdJikkKM3nVbEA==
X-Received: by 2002:a05:600c:4ec8:: with SMTP id g8mr47692562wmq.153.1635161113910;
        Mon, 25 Oct 2021 04:25:13 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm19021993wmi.1.2021.10.25.04.25.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Oct 2021 04:25:13 -0700 (PDT)
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
Subject: [PATCH v4 5/8] progress.c: add temporary variable from progress struct
Date:   Mon, 25 Oct 2021 13:25:04 +0200
Message-Id: <patch-v4-5.8-ff039742148-20211025T111915Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1510.ge5c82eefb93
In-Reply-To: <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com> <cover-v4-0.8-00000000000-20211025T111915Z-avarab@gmail.com>
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
2.33.1.1510.ge5c82eefb93

