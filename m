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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D327C43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 535C161241
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 11:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240068AbhDLLJ7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 07:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240061AbhDLLJn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 07:09:43 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B5D8C061342
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:24 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id 12so12490534wrz.7
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hpFibl7BhOy4Lfslv7gEMw1HEtvWSoGoavwYSZVNh9M=;
        b=ER7uXR94GW5rGWLS6PoQUtHowHkVdaht/JUM7+pprwjR5ymkIsVm8bfSumxD3Y7cZm
         RSN9ZL0LSwl3bq0T5/Uz5eAl36dJYL//nT3wQTSHlNOQ9/SDeUMmIomrKcmo6D+LnLUn
         Rsg4kBa5CNPydcNiB2QNm5QvyDobzQM0C7cqaZTOOmqRjeU4DzWmuDoizg0/yGSCakaO
         mnBF4UGvyhLUo4vR1trWppFngK/EU+x+53q0OPfeqdJ19ARY3eopjf1XU6rSEls4+ck6
         PzBVghbT71rK2KpIcZ3vht3ghFEWWTBYRRqFdDQG8rOoh6B3WsOeRgzoacdHVO/DCTof
         UqXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hpFibl7BhOy4Lfslv7gEMw1HEtvWSoGoavwYSZVNh9M=;
        b=RNr27mHQ7o40GwwpDLEowG0Wu4FwqzPFcfH70hFS4oMYiLZkD5UlZuwVU6XaLlAYO5
         xFKySJp7JVRfAolqixeYPyI23bBoVZ9AfST7Yfs69gP/II4Xi0ldgIIR2+Khpztbwg7I
         rIQRYxSt9F3cjWHMhNZgJ8iq1T9QquszQ1gcPMZu7RH1vTW56ydvyjh/hozYEZVamfdI
         +PBwFxdRDwwXR1h77ECnPCUf0Vj9BPfz/AT7Tj48h9aXw9MBNtC1F0ZkvBc4jqr4h3Mr
         tEBPFFLMCWG0NwCNQHamVeJIK+m4xNiBA97vaebMKY8oYTFcCjLX514qOW9DNF7dxIGq
         kkXg==
X-Gm-Message-State: AOAM530jWyuNTZtWN8+0mFzHBPtWqxuOid0KGlG9I1dIfvk6omDeR7be
        Gk9Ofz/HxdrnnM1y931RSKqUmx+5bMCUjA==
X-Google-Smtp-Source: ABdhPJyRMiJEuHYAgczqxKgRZSFQY8eJASx7VNFqvsSV4ZgNugI9XbwwmTulCHR85a5vRsBaDIC2vQ==
X-Received: by 2002:adf:fdc7:: with SMTP id i7mr14775587wrs.350.1618225763044;
        Mon, 12 Apr 2021 04:09:23 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm18158744wrh.91.2021.04.12.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 04:09:22 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 16/16] test-lib-functions: remove last two parameter count assertions
Date:   Mon, 12 Apr 2021 13:09:05 +0200
Message-Id: <patch-16.16-b4a018a63f3-20210412T110456Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.634.gb41287a30b0
In-Reply-To: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
References: <cover-00.16-00000000000-20210412T110456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove a couple of parameter count assertions where we'll now silently
do the wrong thing if given too many parameters, unlike the "$@" cases
in the preceding commit where "test" etc. handle the check for usi.

In the case of "test_file_size", the "test-tool" we're invoking is
happy to accept N parameters (it'll print out all N sizes). Let's just
use "$@" in that case anyway, there's only a few callers, and
eventually those should probably be moved to use the test-tool
directly.

That only leaves test_line_count, I suppose I could leave that one
alone, but since it's the only common function left that does this
assertion let's remove it for the brevity of the -x output and
consistency with other functions.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 2cf72b56851..32d6b98b972 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -822,10 +822,7 @@ test_path_is_missing () {
 # output through when the number of lines is wrong.
 
 test_line_count () {
-	if test $# != 3
-	then
-		BUG "not 3 parameters to test_line_count"
-	elif ! test $(wc -l <"$3") "$1" "$2"
+	if ! test $(wc -l <"$3") "$1" "$2"
 	then
 		echo "test_line_count: line count for $3 !$1 $2"
 		cat "$3"
@@ -834,8 +831,7 @@ test_line_count () {
 }
 
 test_file_size () {
-	test "$#" -ne 1 && BUG "1 param"
-	test-tool path-utils file-size "$1"
+	test-tool path-utils file-size "$@"
 }
 
 # Returns success if a comma separated string of keywords ($1) contains a
-- 
2.31.1.634.gb41287a30b0

