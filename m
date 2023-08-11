Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87F11C001DE
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:06:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236256AbjHKRGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236258AbjHKRF5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:57 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9873B19F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:56 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6bd3317144fso544413a34.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691773556; x=1692378356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b9PXND0SvoICandopZjWA9aKhF3BAhZEKxeSwhTTlBM=;
        b=TmHhyouCwysITPDqogzoURuwdmOzv+1AdsU9IyDsCjfQV+SX0RsZKjnXh9NPEvegts
         Tee6yeVG0q/C+EVUYBMdFf64dFkMDKz9u4+uMvERqVmi4uGt6eIiksFilk959NLcGcb+
         BNc1gJxw14vfOsir6yB2G9Kf1US/4JvtSPr6ULf+t/bHO8CORZSFomvEm2f2608Br6NO
         NWa+L7u4DDCZ3uLkqzMieUqIopaz/JYvUVxtLLoM6IhPolIc/KjQq5CI+zamDmsNT4Yf
         uIOd2jAFXkONcQFkku6bBl7PrF2UeizLUtoSqstvtzDV7FUHm6HFVh9borjmxwoJaMMW
         bqqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773556; x=1692378356;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b9PXND0SvoICandopZjWA9aKhF3BAhZEKxeSwhTTlBM=;
        b=LwnT3SsXbh6JO9CUqQ1agzIF1p/vsVVig/zYf9kMm5iVShLIpqFpT1TWmfep2QqMpF
         VT802kuFtTsiS5/YMKKJPNFF0uB/L3ckF004RbdJDWvosyKd9zQxmTbcfCRx9gm6bB85
         LYFMIxcxpGhwmaTFtYn6xZgV/+OkEhFUShqh0yhQcXjLJniQh9ouoaWtDoi8mpdjDHTD
         HYoUAW9GLb6MQz1ixhDsqWAxfY+HViJrybqRhXn0N0OrRPA+aD/FoSmLPTBcHG1DEAYM
         ZHrMLCZa9eW5xCg2/CfNR/de1hL959w2OzQLirS0rn8JJjQfCoe1MVJ+4M4gRVVVrC0c
         58eg==
X-Gm-Message-State: AOJu0YxexTfcmMShqoK45IDYbDZjlWLEMa08kRP8NnF4h2SD9rZYVn4u
        W688RdWfOlAwYgbfpjRPzAN2AFrxqc1n1wCGH57Aiw==
X-Google-Smtp-Source: AGHT+IH6G/k62eaX2+/zEEA9KIAX+c074R8VN6L10JlGTxWLLrktczh/i0Wvy9g4KAmXYRhlBCpQ6A==
X-Received: by 2002:a05:6358:291b:b0:134:c815:f067 with SMTP id y27-20020a056358291b00b00134c815f067mr2521895rwb.11.1691773555660;
        Fri, 11 Aug 2023 10:05:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x83-20020a253156000000b00d457578141dsm1009392ybx.56.2023.08.11.10.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:05:55 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:05:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 5/5] commit-graph: avoid repeated mixed generation number
 warnings
Message-ID: <b82b15ebc86168223619c2b853e0abe02831138b.1691773533.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691773533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When validating that a commit-graph has either all zero, or all non-zero
generation numbers, we emit a warning on both the rising and falling
edge of transitioning between the two.

So if we are unfortunate enough to see a commit-graph which has a
repeating sequence of zero, then non-zero generation numbers, we'll
generate many warnings that contain more or less the same information.

Avoid this by treating `generation_zero` as a bit-field, and warn under
the same conditions, but only do so once.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 commit-graph.c          | 17 ++++++++++-------
 t/t5318-commit-graph.sh | 14 ++++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/commit-graph.c b/commit-graph.c
index f7d9b31546..8d924b4509 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2562,6 +2562,8 @@ static void graph_report(const char *fmt, ...)
 
 #define GENERATION_ZERO_EXISTS 1
 #define GENERATION_NUMBER_EXISTS 2
+#define GENERATION_NUMBER_BOTH_EXIST \
+	(GENERATION_ZERO_EXISTS | GENERATION_NUMBER_EXISTS)
 
 static int commit_graph_checksum_valid(struct commit_graph *g)
 {
@@ -2573,19 +2575,19 @@ static void verify_mixed_generation_numbers(struct commit_graph *g,
 					    int *generation_zero)
 {
 	if (commit_graph_generation_from_graph(graph_commit)) {
-		if (*generation_zero == GENERATION_ZERO_EXISTS)
+		if (*generation_zero & GENERATION_ZERO_EXISTS)
 			graph_report(_("commit-graph has non-zero generation "
 				       "number for commit %s, but zero "
 				       "elsewhere"),
 				     oid_to_hex(&graph_commit->object.oid));
-		*generation_zero = GENERATION_NUMBER_EXISTS;
+		*generation_zero |= GENERATION_NUMBER_EXISTS;
 	} else {
-		if (*generation_zero == GENERATION_NUMBER_EXISTS)
+		if (*generation_zero & GENERATION_NUMBER_EXISTS)
 			graph_report(_("commit-graph has generation number "
 				       "zero for commit %s, but non-zero "
 				       "elsewhere"),
 				     oid_to_hex(&graph_commit->object.oid));
-		*generation_zero = GENERATION_ZERO_EXISTS;
+		*generation_zero |= GENERATION_ZERO_EXISTS;
 	}
 }
 
@@ -2702,10 +2704,11 @@ static int verify_one_commit_graph(struct repository *r,
 			graph_report(_("commit-graph parent list for commit %s terminates early"),
 				     oid_to_hex(&cur_oid));
 
-		verify_mixed_generation_numbers(g, graph_commit,
-						&generation_zero);
+		if (generation_zero != GENERATION_NUMBER_BOTH_EXIST)
+			verify_mixed_generation_numbers(g, graph_commit,
+							&generation_zero);
 
-		if (generation_zero == GENERATION_ZERO_EXISTS)
+		if (generation_zero & GENERATION_ZERO_EXISTS)
 			continue;
 
 		/*
diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 8e96471b34..2626d41c94 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -628,6 +628,20 @@ test_expect_success 'detect mixed generation numbers (zero to non-zero)' '
 		"but zero elsewhere"
 '
 
+test_expect_success 'detect mixed generation numbers (flip-flop)' '
+	corrupt_graph_setup &&
+	for pos in \
+		$GRAPH_BYTE_COMMIT_GENERATION \
+		$GRAPH_BYTE_COMMIT_GENERATION_LAST
+	do
+		printf "\0\0\0\0" | dd of="full/$objdir/info/commit-graph" bs=1 \
+		seek="$pos" conv=notrunc || return 1
+	done &&
+
+	test_must_fail git -C full commit-graph verify 2>err &&
+	test 1 -eq "$(grep -c "generation number" err)"
+'
+
 test_expect_success 'git fsck (checks commit-graph when config set to true)' '
 	git -C full fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
-- 
2.42.0.rc0.30.gb82b15ebc8
