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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C7FC47094
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:43:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BACE9610C8
	for <git@archiver.kernel.org>; Mon,  7 Jun 2021 14:43:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbhFGOpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Jun 2021 10:45:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbhFGOpX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jun 2021 10:45:23 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BE25C061787
        for <git@vger.kernel.org>; Mon,  7 Jun 2021 07:43:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g8so27139035ejx.1
        for <git@vger.kernel.org>; Mon, 07 Jun 2021 07:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kvDAN2bgZCwafU6d1DOdMHqsdXwgXno9tVgtdhrQwhw=;
        b=ODjh7rECgF2N/vxUrfTBcDUwvt9wQxWlk38LP7vs93WNh4Cv7nWEK8PEotw8Nt4cCy
         NV51rKOpqtt6b4bYWj5VKvw3dQCbbTrpFq+2MPnF0CNox0y4ySqDLG4eJmpVzeQZUYhn
         /EAnu59F/E4t2nV+yRcxyRJdVg0V5M7wS2GjAZ7Q7pjJqGRpGtmowIRDH8YWoXavHrwP
         PWrCoogctV6utfbkXIzDFLg8b6JvqYO/3/v339dd++kP+7fyx8cOHLwMiaT++nhmEth5
         znY5sjBh25eAcfHvqvOcabJRlOToSE3PdbDXCmxddhI3Ikyw6000el8fbyyESKlTsfZp
         8r4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kvDAN2bgZCwafU6d1DOdMHqsdXwgXno9tVgtdhrQwhw=;
        b=Acj5V99I9pm9dieAasAZCY5nLpcGEUJt5+bt1XRLsVM5urRCo9tDzj9uQM1PfJqtV0
         ikavGGXQZJCT8geqKmOziDgPp8zJsVB/6gAb/fWmSH19+IcZFP+2E25OX3j/6C/K/911
         YXvLInt/xkQLUuhlxLaHaX+LAUT6vpXXuuO2VUzzzRHUl/+poufuSPWnxuKEkkXVbbmk
         4taEvyI0GeMfDS/eO9vC2DTgGRiOlAKBLpx67MxNBJkwbd0o0B6A22pDnRAEuVbRPVKO
         skfuV5/C79wu6uZwybfDB5Kssy9GQPothpQGr1wXsoGfKmc3AuHh7UCFUISh2zmcJQQ4
         bTrA==
X-Gm-Message-State: AOAM530Z8FnkSksHy6GZfHCt9OZDoeFwuM7it3o6fmCmiSJ8vTm674nv
        ATa1kVwMIbhNRvE9ODpvOPgekTM6oIb36w==
X-Google-Smtp-Source: ABdhPJx57MgLEAb5DlBdmvBeysxWpDyzNd4n5rzISKtKxAtfPrziPbC+sK7Igar3AUlQfS+IvNw79w==
X-Received: by 2002:a17:906:1d11:: with SMTP id n17mr17941135ejh.215.1623077010473;
        Mon, 07 Jun 2021 07:43:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id h19sm3446723ejy.82.2021.06.07.07.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Jun 2021 07:43:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/2] read-cache: fix incorrect count and progress bar stalling
Date:   Mon,  7 Jun 2021 16:43:23 +0200
Message-Id: <patch-2.2-042f598826-20210607T144206Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3.434.gd8aed1f08a7
In-Reply-To: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
References: <cover-0.2-0000000000-20210607T144206Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a potential incorrect display of the number of items (off by one)
and stalling of the progress bar in refresh_index().

The off-by-one error is minor, we should say we're processing the 1st
item, not the 0th. This along with the next change also allows us to
remove the last display_progress() call outside the loop, as we'll
always have reached 100% now.

Let's also move the display_progress() call to the very start of the
loop refresh_index() loop. In the loop we first check whether e.g. we
ignore submodules and the entry we're processing is a submodule,
whether we ignore certain paths etc.. Thus we could have a
pathological case where we have a huge index consisting of such
ignored entries, and we'd stall on the progress bar.

See ae9af12287 (status: show progress bar if refreshing the index
takes too long, 2018-09-15) for the initial addition of this progress
bar to refresh_index().

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 read-cache.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/read-cache.c b/read-cache.c
index 470f800855..8b0073a839 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -1594,6 +1594,8 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		int t2_did_lstat = 0;
 		int t2_did_scan = 0;
 
+		display_progress(progress, i + 1);
+
 		ce = istate->cache[i];
 		if (ignore_submodules && S_ISGITLINK(ce->ce_mode))
 			continue;
@@ -1627,7 +1629,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 		t2_sum_scan += t2_did_scan;
 		if (new_entry == ce)
 			continue;
-		display_progress(progress, i);
 		if (!new_entry) {
 			const char *fmt;
 
@@ -1662,7 +1663,6 @@ int refresh_index(struct index_state *istate, unsigned int flags,
 	trace2_data_intmax("index", NULL, "refresh/sum_lstat", t2_sum_lstat);
 	trace2_data_intmax("index", NULL, "refresh/sum_scan", t2_sum_scan);
 	trace2_region_leave("index", "refresh", NULL);
-	display_progress(progress, istate->cache_nr);
 	stop_progress(&progress);
 	trace_performance_leave("refresh index");
 	return has_errors;
-- 
2.32.0.rc3.434.gd8aed1f08a7

