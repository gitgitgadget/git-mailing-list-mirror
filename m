Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F1FC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:44:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE1B3610C7
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:44:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbhFGOqW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:46:22 -0400
Received: from mail-ej1-f41.google.com ([209.85.218.41]:46017 "EHLO
        mail-ej1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbhFGOqW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:46:22 -0400
Received: by mail-ej1-f41.google.com with SMTP id k7so27035984ejv.12
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 07:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HVqcaAYvwoCQorS39mfYxXLV46Hy/KGfs3W4bdzvI2w=;
        b=r5BjCSnO50hxDoKTMc2QvCuGVdZpgtv59b8Et+9TXCjpYmuactLG/+CIrNgF3R0be/
         fuQeF84eH8sbsk/3Sjs3RMHjCuiamnLzOIytbI8b8MhJXU+WM3XFtXlA4MnWjmuiY3tP
         qvehlX8QHABQxQ/eV3XDETlM0C1gAUmAKop7d7gsmoS7/fvKk7a6L6bhuqksurR6KAPQ
         Z2D9s660lBDBHfpIfZZqgrRQMmaAk78qOUNEDAOZrb4ZsgTwCQ/VrwhZNp7KRu560nCM
         68VR8iRIsDwnqvPmhY3a3TzDXSLyezM5p/5rp2GDSwmF5aBHo70U1swpPIlTuc9LQXl/
         UFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HVqcaAYvwoCQorS39mfYxXLV46Hy/KGfs3W4bdzvI2w=;
        b=YK9ZG3Nkv2H3y+8sB/mhERMNewt5IVknYECRvyrQ2wqHquQm9yC6Mauk8cxzhbsxHE
         C1r7k3jp5bSDWb/Xabk46mRTOCh1kOuFMRX7aczJmdePqECes2h5yOEDPbrCcJ3OJBjp
         80kqoykJMTEWdO07yuYhliZ2DTUW2ffyhS6tBJKwFImIE4suLN76l0DgLv07F49YKCXW
         qhOslF9dVZ327IouGZjNXtgPo6F6GxJ16koubODweb+O3ySYBIOGez6II60QP0QgP79f
         2FOeF5KQUQPM6lDS1Sv/zSUOhbCXDxnybgRTIXWhtgKsWGKMbGR/hYq71nw4gcB0H52v
         jcpQ==
X-Gm-Message-State: AOAM531NnRqowT1AkcAUL0hEkNM5CeDAHYM8Mpo9iqoPDJyt+lDPinTS
        QLLi3QhK/P27YsqFA4f9Y72S/Mj0O9Ev0Q==
X-Google-Smtp-Source: ABdhPJz/ThhqKgzw7LbTJLrLuSkzlcKwCtJsRwyoaINKFa8YQbSNqP+Fxb8xy8uchJrnvJ01PA4oRQ==
X-Received: by 2002:a17:906:2da1:: with SMTP id g1mr18002198eji.47.1623077009870;
        Mon, 07 Jun 2021 07:43:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h19sm3446723ejy.82.2021.06.07.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:43:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] read-cache.c: don't guard calls to progress.c API
Date:   Mon,  7 Jun 2021 16:43:22 +0200
Message-Id: <patch-1.2-1680109655-20210607T144206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Don't guard the calls to the progress.c API with "if (progress)". The
API itself will check this. This doesn't change any behavior, but
makes this code consistent with the rest of the codebase.

See ae9af12287b (status: show progress bar if refreshing the index
takes too long, 2018-09-15) for the commit that added the pattern
we're changing here.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 1b3c2eb408..470f800855 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1627,8 +1627,7 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		t2_sum_scan += t2_did_scan;
 		if (new_entry == ce)
 			continue;
-		if (progress)
-			display_progress(progress, i);
+		display_progress(progress, i);
 		if (!new_entry) {
 			const char *fmt;
 
@@ -1663,10 +1662,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	trace2_data_intmax("index", NULL, "refresh/sum_lstat", t2_sum_lstat);
 	trace2_data_intmax("index", NULL, "refresh/sum_scan", t2_sum_scan);
 	trace2_region_leave("index", "refresh", NULL);
-	if (progress) {
-		display_progress(progress, istate->cache_nr);
-		stop_progress(&progress);
-	}
+	display_progress(progress, istate->cache_nr);
+	stop_progress(&progress);
 	trace_performance_leave("refresh index");
 	return has_errors;
 }
-- 
2.32.0.rc3.434.gd8aed1f08a7

