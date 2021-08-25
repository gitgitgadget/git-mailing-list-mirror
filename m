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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F30EC432BE
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:20:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7187F60EBC
	for <git@archiver.kernel.org>; Wed, 25 Aug 2021 23:20:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233969AbhHYXUp (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Aug 2021 19:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhHYXUk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Aug 2021 19:20:40 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DF2C0613C1
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:54 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id n5so1818404wro.12
        for <git@vger.kernel.org>; Wed, 25 Aug 2021 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pQA7pFi0QoPZQ7MB004K+GNcMwx/aOtDVw/UWgSk9s8=;
        b=oAUwRDvsSpJcK9EBuvaBnWuSJC8UG+mU5lma/m9oIw5664k/ujGnfeBsmxd+uMchm+
         G0n7W4sm3TzQCCCVWzqO4vaQsVrAGbFdg0rmrfMpKFgAAs4pCa9krz1nS8mKuy5V6syG
         WjBkIxbL/4svrIcIsGFKdNaVyGXyOFXYpLo2471xZLgRE75mThXIhbLt3NK+JhFWgTxh
         hq1CFAupA0jynNmYFSGv0DLU2OjdICPk0+uavBCDYnvZt0ztGDsTYFfjeKZecawh081R
         Nc0mp9ChTjvGezXfBKodvtNjakypMpPqbaaNc5TLzALgRS63S1uWVOOtfuY3cNBy53P1
         hohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pQA7pFi0QoPZQ7MB004K+GNcMwx/aOtDVw/UWgSk9s8=;
        b=mIWBjN+Iq/1sh//Xlub2AoLT35q6uIqEOPzkiwqoJIe8a6Xw9ja98Ys72zIugaT2G8
         h26anqusCZR0QgZRxKOqfZ0fmwJfXkAaiSf4CFc8WJRbY75R1aROY0vu2g9Q3pksxZL/
         khj6oPBU5S37oV3OLqmnRiKG0n0zcrTK/0jgFPPfAWc1bg/fQ9AMDXPACcChjPpNTwcf
         NezPhY3zChczpcRNUxqD42H2nX7dLO3q4IKsRFxyNSlZlG4MSBcZu9J8BkSsY9jmoSoy
         yDBha1Og8LnkoCvh4okEmG1sdJk5ZegaO2OpdLVhdx9ImLHZettVMLNfk4msQNyHKc2T
         yc8w==
X-Gm-Message-State: AOAM531+alZjKCNoY2BRXtxfs85+ipiqSUkzFbp6ObUGSO/sy0Mtvt4b
        ETlIwOeH4FScP4wt0i1iKBIyVNpyxfM57g==
X-Google-Smtp-Source: ABdhPJzKZaDUU5iBExEtuRJoTco9zwmJ3o9KD4XRggPWLY6iSdYhUVVMoZoy6O4LWtP4Pbk5eAvEFw==
X-Received: by 2002:adf:ec8b:: with SMTP id z11mr570036wrn.122.1629933592802;
        Wed, 25 Aug 2021 16:19:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u23sm6327166wmc.24.2021.08.25.16.19.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Aug 2021 16:19:52 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] tr2: do compiler enum check in trace2_collect_process_info()
Date:   Thu, 26 Aug 2021 01:19:23 +0200
Message-Id: <patch-5.6-4e378da2cce-20210825T231400Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.733.ga72a4f1c2e1
In-Reply-To: <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
References: <87o8agp29o.fsf@evledraar.gmail.com> <cover-0.6-00000000000-20210825T231400Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change code added in 2f732bf15e6 (tr2: log parent process name,
2021-07-21) to use a switch statement without a "default" branch to
have the compiler error if this code ever drifts out of sync with the
members of the "enum trace2_process_info_reason".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 compat/linux/procinfo.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/compat/linux/procinfo.c b/compat/linux/procinfo.c
index c86daff2b26..46a751c9a1d 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -30,29 +30,30 @@ static void get_ancestry_names(struct strvec *names)
 
 void trace2_collect_process_info(enum trace2_process_info_reason reason)
 {
+	struct strvec names = STRVEC_INIT;
+
 	if (!trace2_is_enabled())
 		return;
 
-	if (reason == TRACE2_PROCESS_INFO_EXIT)
+	switch (reason) {
+	case TRACE2_PROCESS_INFO_EXIT:
 		/*
 		 * The Windows version of this calls its
 		 * get_peak_memory_info() here. We may want to insert
 		 * similar process-end statistics here in the future.
 		 */
-		return;
-
-	if (reason == TRACE2_PROCESS_INFO_STARTUP) {
+		break;
+	case TRACE2_PROCESS_INFO_STARTUP:
 		/*
 		 * NEEDSWORK: we could do the entire ptree in an array instead,
 		 * see compat/win32/trace2_win32_process_info.c.
 		 */
-		struct strvec names = STRVEC_INIT;
-
 		get_ancestry_names(&names);
 
 		if (names.nr)
 			trace2_cmd_ancestry(names.v);
 		strvec_clear(&names);
+		break;
 	}
 
 	return;
-- 
2.33.0.733.ga72a4f1c2e1

