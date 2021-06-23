Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC4CC49EA4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6689B611AC
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbhFWRvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhFWRuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:55 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99700C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:36 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b3so3577566wrm.6
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qf4PP5g4jx32MZalOcQzmlv7jX4VlmPiVJHLrleRXU=;
        b=BbUEfXvvkq8oTEswEiODLjXx+BjsBngQgr+j/LCmEk0cEIr/C0EVrjK2E2eftcdp87
         hZWu4hk8pVLGzb/0U2+KGYTcW0eECnDiXEVCHovu3UVNnA92x71BY0PtQWetdB/PTIZT
         CbuSTUP2yB0K6qkHjsFGtITKoohBQiIDvgjC24dmBDVoHaxdrjMMK7+9KAS1F6E24i5x
         TuJUIXvGKAWhS6bJH+/A5Rt2Gl8gjjiqFws9TOjfJ2/CurQVRCVAFqurtpwlMPHheCOn
         ZrlN7l/tAZCf58w5mM39XWN9MMol+hK8TLkrCQ34JAG2MZU7ZSIvX9EnbuXIfVR1qd0t
         MBKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qf4PP5g4jx32MZalOcQzmlv7jX4VlmPiVJHLrleRXU=;
        b=GD29f1u5MmWyFb8yOs6isIHlDe7f+d0Lk5Zip+/QKlKoGinyWu4XngTX3KR108SG5V
         qr/T7SY7JRfOFMyBywR1OdqE3OkHB1E0oQnweoAeRgw/Fyh5pZcRiaYE1kGpdCOMAGxM
         M9BKSAoddzaDoBL4uJXZingJdWutlBzA5G4vK3ddxjT2iSRkGqZt/NOJDOjH+Iy3GXv3
         r7E7u/1mkZbm+ibxASUXSkT40O34QfWYOTFn4b2LDc/IT1ukjUWZlQPIb9w2QeH2BvjM
         oJgPU3dRu2vxXpqylw088ZxoU2QjHh2z5b++i0h20hQ5o/8Ol93SUtBwn7HtAhXRYnSa
         SL+w==
X-Gm-Message-State: AOAM532hdI9+INJIWusF3UmEjV7ofppMXuGdb8Gd6VxUMhDh5LaMhHO5
        EAM7uLLUuzJnzIo8rX+kPMPfTa6gYl99zw==
X-Google-Smtp-Source: ABdhPJwWeXnioz34pfKSEl+XljDw8hLBid/bC3WQ02pw/9KET4slNgfb8uYqvXeYjs/0fBqA3ebxTQ==
X-Received: by 2002:adf:ef4d:: with SMTP id c13mr1468473wrp.220.1624470515036;
        Wed, 23 Jun 2021 10:48:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 08/25] progress.c: add temporary variable from progress struct
Date:   Wed, 23 Jun 2021 19:48:08 +0200
Message-Id: <patch-08.25-75b72929191-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
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
index 1fade5808de..1ab7d19deb8 100644
--- a/progress.c
+++ b/progress.c
@@ -331,15 +331,16 @@ void stop_progress(struct progress **p_progress)
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
2.32.0.599.g3967b4fa4ac

