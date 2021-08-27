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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBB2CC432BE
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D35F960FD8
	for <git@archiver.kernel.org>; Fri, 27 Aug 2021 08:04:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244555AbhH0IE6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Aug 2021 04:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244563AbhH0IEe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Aug 2021 04:04:34 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75986C0617AD
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u16so9073340wrn.5
        for <git@vger.kernel.org>; Fri, 27 Aug 2021 01:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Xua6BbybOWBNzlYbvsVzofAGdjAP0ju/NNBGeBw6bso=;
        b=slcHvVixQXB+gnxLujNBtiw+fCEB2RTwALg7qqbsiVM/LnAIhslghN3JiHXN3BUCv5
         dEB/xCfs/Sl8RIfWfWV13xUeO1427+kkfqII0MvZ6dgQ/Ych+m0HCr7MbGJvXfvGKKqS
         cSqDXoLH0Kcr5ro++eSSM5qaxiLlVbmfONQTx5B9IQaiGgZMwfnvn1CzhEUG6VCzCQQ6
         gyeQ4dCnqA8CSNtHLtUP9zXveuA+PrAPzFvgpg+Ep6HgyWtRHYgq92RwgOpIhCOTxyZC
         fQYoW74pFu+jbKG3qucYuREuJu6LkPi0/p0w4iclxSrjp58DI16HQ+jWI0M9wkvKfP7o
         w2oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xua6BbybOWBNzlYbvsVzofAGdjAP0ju/NNBGeBw6bso=;
        b=CohoQoygzGQV7aXIir/NGsKY/VI5Sbm4ZfnAdd/XphL6NlX2YTNi6FiA2qyeyv+R+P
         IEF3L05lzTBY8X7wJtmbva5gr8NN5h0v10fJEfgAV48J90LVlp7yRDyfjWq+VsFlh2F5
         EdKfBMmrBvA5+QC/jCZGyvRh0yBDt3qt6qKeb/rU5+uu1GfhKK2GefqoMBiH3rYTVJH5
         AK4F3vC77dYyRYKsBLLsqToBrjAnxoQbw6JV66RHFmPXd06TqN46oHY9fqL25Hrkjprm
         +tGO0oxmo6P2slwJQyQFNworbddWwskaGOBLdlLQTKaPtu0YGGh/NewC5r0nnsdkcm3P
         Cn6A==
X-Gm-Message-State: AOAM532GNEeK0sYOGGYG+S1Ys/BcuEvblbfcKom5cEtRwxkiokpqGE2L
        g4WhD6ABB2X+bsleZD9na3N1bskxufyLcA==
X-Google-Smtp-Source: ABdhPJwpVbK3o/1t9ZFxiB+K/zF8vopqLxlxdclcm88AtbBgLP/f7odEahNtrKadb4w8v9AFXdElDg==
X-Received: by 2002:a5d:64e6:: with SMTP id g6mr8881277wri.288.1630051346894;
        Fri, 27 Aug 2021 01:02:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z137sm10922636wmc.14.2021.08.27.01.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Aug 2021 01:02:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/6] tr2: do compiler enum check in trace2_collect_process_info()
Date:   Fri, 27 Aug 2021 10:02:17 +0200
Message-Id: <patch-v3-5.6-0bea5aa9c9-20210827T080054Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.736.g68690aaec9a
In-Reply-To: <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20210826T121820Z-avarab@gmail.com> <cover-v3-0.6-0000000000-20210827T080054Z-avarab@gmail.com>
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
index bd01f017bc..0b47d44990 100644
--- a/compat/linux/procinfo.c
+++ b/compat/linux/procinfo.c
@@ -31,29 +31,30 @@ static void get_ancestry_names(struct strvec *names)
 
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
2.33.0.736.g68690aaec9a

