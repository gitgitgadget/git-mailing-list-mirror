Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03790C433ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:41:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8B14E61026
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 19:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238892AbhD0Tl7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 15:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbhD0Tl4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 15:41:56 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2335CC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:41:11 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c19so6207313pfv.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 12:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=skydio.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kxBa14AFwnzk1pw7Jlv0cNbTp2TRyuyGBwvwB2uFsg=;
        b=GoMfOag1XgDqDaf5gjEzfXrELR5FevB68uhF52r+3ufdeRwRsrObpb2h4pM+dUd5Zs
         JBs8s3/iIG9iovN7m0aU9VMSkm8qLUhX66htC8KSSvHv7ITq4YnAd1g060JpVZkKzyOo
         I+6NKODyMexDP/FTzLCKyJpMeeoswz1dr4SaKYVCCgt5NLcR/3SBzPeldLFFvIzs2y6j
         6H3Ws2xz+4fB4BcahuSuyIXyNAEdQ/bzX+6pgM3rawFZdACKPq4YiajbrMH/s6dH2SDP
         04nbhI1D2GPjbmDi4GsHCHqAd/TaD8apI/qWzq4r6COQxQvftbcVEiuyel9KElYM6s4e
         Vz7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5kxBa14AFwnzk1pw7Jlv0cNbTp2TRyuyGBwvwB2uFsg=;
        b=Gf9QBzpGH5hXgXhs5ZkTwJg1TWNYig8CYlAa3jbeNpCZX9FVizDFzoJzlhS3IWqkV2
         QPfKwvjeflGNvF4A917uTmvd/aKBoK/M0XAu9HecSXzPX4dEk6adFlTwjaeF/sXXiS/S
         jv98SKE2MhSq5D4tcmdZKxsTLJ3BX00hM6I29YcK7sA1ElHhbj2PBSDyiANfuWjOLYFA
         q+p1t902OHytOdSdGYD/V0pc7nWv9qsvq1rgMelDTMthTtVHRVsZ5TKJLSxmxgDh8wg4
         l3HVE/u7laTMImfT6wEAwflJmCOJTZuyDaxZl6365wQQIicMN36KB7k3r9a2/HIrptJg
         TQWA==
X-Gm-Message-State: AOAM531SZyMZbDxAlKptp7ARjRZ+GkLLRVkzIwIPNi49ElJXcQOy88jU
        53YOJEYP30IW3GJAUNeDopI6LF03Qt7GYe/Y
X-Google-Smtp-Source: ABdhPJxaS3VU/gyHmV63JsHrv04HW/K/LTe4jg8OE916C2GsgJgjWmog+obSGTPUfj82hS4Xg51WeQ==
X-Received: by 2002:a65:6085:: with SMTP id t5mr23566198pgu.201.1619552470265;
        Tue, 27 Apr 2021 12:41:10 -0700 (PDT)
Received: from jerry-desktop.localdomain ([50.236.240.214])
        by smtp.gmail.com with ESMTPSA id t1sm2737649pjo.33.2021.04.27.12.41.09
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Apr 2021 12:41:09 -0700 (PDT)
From:   Jerry Zhang <jerry@skydio.com>
To:     git@vger.kernel.org, gitster@pobox.com
Cc:     ross@skydio.com, abe@skydio.com, brian.kubisiak@skydio.com,
        Jerry Zhang <jerry@skydio.com>
Subject: [PATCH] git-apply: add --quiet flag
Date:   Tue, 27 Apr 2021 12:41:06 -0700
Message-Id: <20210427194106.14500-1-jerry@skydio.com>
X-Mailer: git-send-email 2.31.1.367.g30381d2e76
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace OPT_VERBOSE with OPT_VERBOSITY.

This adds a --quiet flag to "git apply" so
the user can turn down the verbosity.

Signed-off-by: Jerry Zhang <jerry@skydio.com>
---
 Documentation/git-apply.txt | 7 ++++++-
 apply.c                     | 2 +-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-apply.txt b/Documentation/git-apply.txt
index aa1ae56a25..a32ad64718 100644
--- a/Documentation/git-apply.txt
+++ b/Documentation/git-apply.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--ignore-space-change | --ignore-whitespace]
 	  [--whitespace=(nowarn|warn|fix|error|error-all)]
 	  [--exclude=<path>] [--include=<path>] [--directory=<root>]
-	  [--verbose] [--unsafe-paths] [<patch>...]
+	  [--verbose | --quiet] [--unsafe-paths] [<patch>...]
 
 DESCRIPTION
 -----------
@@ -228,6 +228,11 @@ behavior:
 	current patch being applied will be printed. This option will cause
 	additional information to be reported.
 
+-q::
+--quiet::
+	Suppress stderr output. Messages about patch status and progress
+	will not be printed.
+
 --recount::
 	Do not trust the line counts in the hunk headers, but infer them
 	by inspecting the patch (e.g. after editing the patch without
diff --git a/apply.c b/apply.c
index 7aa49e2048..918e0988bb 100644
--- a/apply.c
+++ b/apply.c
@@ -5051,7 +5051,7 @@ int apply_parse_options(int argc, const char **argv,
 			N_("leave the rejected hunks in corresponding *.rej files")),
 		OPT_BOOL(0, "allow-overlap", &state->allow_overlap,
 			N_("allow overlapping hunks")),
-		OPT__VERBOSE(&state->apply_verbosity, N_("be verbose")),
+		OPT__VERBOSITY(&state->apply_verbosity),
 		OPT_BIT(0, "inaccurate-eof", options,
 			N_("tolerate incorrectly detected missing new-line at the end of file"),
 			APPLY_OPT_INACCURATE_EOF),
-- 
2.29.0

