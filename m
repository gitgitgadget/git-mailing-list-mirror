Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0211EC433FE
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC19B610CF
	for <git@archiver.kernel.org>; Fri, 22 Oct 2021 08:55:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbhJVI6N (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Oct 2021 04:58:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbhJVI6I (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Oct 2021 04:58:08 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261EAC061766
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id u18so3641473wrg.5
        for <git@vger.kernel.org>; Fri, 22 Oct 2021 01:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0oT7hzE3b1wkVs3NpJ+iSmfa6Yxatw9pOs7IO9r3/8Q=;
        b=aBvTBw+yxlr91jWQu1EL0EoFtnrR5xJYKLyh/9di+jCVWos6NAvLAxGwU/+S8auV6V
         uCW5VF4qQjPR8FZShxkOFRzdKi2mDpnmjeHEmLQ88VacEk5yc3qXxl1TkUoXMcMohQhK
         j0fpM/t0C54jja9X0qL80R2n1dmdzw9xUSxNCk4WCZNVIVQDOfG6VNGnI3hvLoDMM9gP
         8UuNcWsLosI8aYIY5BvA62O7hhM+Ucn/XcQJ816tRfbAtCa1181gy8YbKEX1HYZC16fz
         ++NT0zY5yao+6vySDCsG2UU6rgMr/MH67dS4BHi0R/M7NycnxtYM/RmATBLPzcWcNzb8
         6Ulw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0oT7hzE3b1wkVs3NpJ+iSmfa6Yxatw9pOs7IO9r3/8Q=;
        b=h41DnFKrVDP2gamvu+xH6SUlsrb8oIoIfDRWYlVVaaRLM1bFr6bxXsy+w1NFgsj01s
         PFIhowcJttMIEt38rGnFZ2fP2aSlMTMvHk1lbdd4nj1OXGkYbwej/SbxuYg4rRxQqMzn
         CED/IAqSkLnDpcAOyuqg1u0Yj9lpKRG3OjSBRKZ/d2zMO6gZPGsiHZmQZGPKeHsa1bOT
         lsm6cBolRXkb7yiMC+7vUFYMlypZonPPuuzciDgri/nqv2ZxfpgcJyx0eRpDLfaxp6wJ
         x1Kd2pn9b1kPgHB8eK0g10NFuBYFGWjIvYWCxa3tMpxG0IDQPVInE9gary6znpNHT8sT
         KQtw==
X-Gm-Message-State: AOAM5339zoprW06KThbGlodw+ij80/u7JhM8lVX6Bk81qUTII6N7mr3I
        rvP00fnckw4+1sX4DSBOyDVuzQLJGBCxkA==
X-Google-Smtp-Source: ABdhPJynpzCmMGgLPyPH+QfZ/8fCZBDv/A4K58ZZMCddKjp8VPJEpiOL67LnQUHV+n56Dk32knehfQ==
X-Received: by 2002:a5d:6907:: with SMTP id t7mr12813059wru.423.1634892949521;
        Fri, 22 Oct 2021 01:55:49 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b19sm10609069wmj.9.2021.10.22.01.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 01:55:48 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/6] grep: prefer "struct grep_opt" over its "void *" equivalent
Date:   Fri, 22 Oct 2021 10:55:39 +0200
Message-Id: <patch-v2-1.6-66c838fd800-20211022T085306Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1494.g88b39a443e1
In-Reply-To: <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211021T155529Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20211022T085306Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stylistically fix up code added in bfac23d9534 (grep: Fix two memory
leaks, 2010-01-30). We usually don't use the "arg" at all once we've
casted it to the struct we want, let's not do that here when we're
freeing it. Perhaps it was thought that a cast to "void *" would
otherwise be needed?

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 8af5249a7bb..fd184c182a3 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -199,8 +199,8 @@ static void *run(void *arg)
 		grep_source_clear_data(&w->source);
 		work_done(w);
 	}
-	free_grep_patterns(arg);
-	free(arg);
+	free_grep_patterns(opt);
+	free(opt);
 
 	return (void*) (intptr_t) hit;
 }
-- 
2.33.1.1494.g88b39a443e1

