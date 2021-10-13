Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8837C433F5
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBE2A61163
	for <git@archiver.kernel.org>; Wed, 13 Oct 2021 22:28:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhJMWao (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 18:30:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230513AbhJMWaj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 18:30:39 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3BF2C061749
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:35 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id e12so13221387wra.4
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 15:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4AXp/uomUWbfDjEKWU3J2bdlHQbIwqwWakuUfA2NxYU=;
        b=UuHrLZUO1usqtNZWs3OWMkcFsKTgGAp5QB+DLUYa0z7jdFDieBIE7MKZp3ldMwHYi6
         Ud6D+WEWzKjpqOtm4p91fMybJcTxErQQD8qU3m0dMYjd4gBqZQAwSbJtWdHIB7QmRjEC
         hOFTFiNrnFXSZCod61SULRxAVhjRQehScy7TbUDiLZsEl8JviGpuNGOZIlr7HCcceQUW
         DzgqJjyqh7mXJTCNRvaUXuanulW82W3qVaiyDYd3YYv9O25+yCQ7S8SA/wlXmIwsqGSS
         7cptEcstjHIsNFvgMNIzpKeSYecQdLFATK67QO8culmiubM5B3l+n0gpvtjFi6XjG3Bf
         wenQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4AXp/uomUWbfDjEKWU3J2bdlHQbIwqwWakuUfA2NxYU=;
        b=YejD7KFLnL7X+6cT/FEvsfT1JVWdRexBBV4FzCi72AtD4vuNg7Cf1fzPn/X1Y21ucP
         YWC4VtFeQehQlJaDCr5lf2fmxjaMPknmkUs9bmaLLLH2YOny6I8rTAM62+bvLf0He+dw
         r47AB7SXNe8FAhTrdex4O+4J2k4bQIdCiBemWV8qEY0nDw7CrD5cn4OwG8NU5m0+CQAq
         d4YwjBvv9xhWQXjiAMkaQdIERyIvBgl35ToUJm2X6dVG+eJ88uWLP5bDMLNX8my4VBND
         b5Xo4ZGM4l4oweOG4Ng69tXhhzIBIR4Z7jtGgQ1nsMZPAtZzdLNE5pFLQFrgD96/siNy
         Zx0w==
X-Gm-Message-State: AOAM530baEBhHyq5xFk47dy2A1iqtDXWea21NMy4ma4iPwzt6C1X9Mpk
        088cawLbxsgez1xFcgljD96GmgIDoV+MQQ==
X-Google-Smtp-Source: ABdhPJyvj9DTJtDDsB7KV4qoA+RLdV4lQZHJ1um7+oVC2tS2NjeBz2BON7He9x9c1o/IMScZwI5Rjg==
X-Received: by 2002:a7b:c4c2:: with SMTP id g2mr2026406wmk.134.1634164114105;
        Wed, 13 Oct 2021 15:28:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l5sm736683wrq.77.2021.10.13.15.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 15:28:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/10] progress.c: add temporary variable from progress struct
Date:   Thu, 14 Oct 2021 00:28:23 +0200
Message-Id: <patch-v3-07.10-cd2d27b1626-20211013T222329Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1346.g48288c3c089
In-Reply-To: <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20210920T225701Z-avarab@gmail.com> <cover-v3-00.10-00000000000-20211013T222329Z-avarab@gmail.com>
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
index 7fcc513717a..b9369e9a264 100644
--- a/progress.c
+++ b/progress.c
@@ -329,15 +329,16 @@ void stop_progress(struct progress **p_progress)
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
2.33.1.1346.g48288c3c089

