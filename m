Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0CFEB64DD
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 17:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236215AbjHKRFy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 13:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236229AbjHKRFw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 13:05:52 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AF030D0
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:50 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6bcac140aaaso2029756a34.2
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 10:05:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691773549; x=1692378349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEUVqyg4LIBpEfVS1GWla72BtbMv8t4K9/JFetVzL4Y=;
        b=4i3OqXPvGBoZFDDdgjlYE6OW5BoVXHpMFAryxUlILaOdLf5Y8CCPecB2x6rEOb5DXe
         C3GrWf7yWaK/XKiECgH4Z7RixsngXMegYXfskCOg0hYUq4j8imudc4Uzcc/sUt/lmQyP
         vbiOF/dvzAivhWsAw7upFvYp3zEfz5tPkdHRdKQeOhu1Ei4eEtqINVNMMNS0aGgRFWfY
         YqEQMAxljOzhCkWbkAx6d/K0FUY1DHcgffYaFqRaH6eOzOLtuFxqWIPh9y0fK89atJ4W
         NL/UxiLZ+6SRp1rigJh1SEzJiXRHB5wWXHBudu9DsVtZwWPSSbFfF8Ehv4eNUBggwI3p
         ZfmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773549; x=1692378349;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEUVqyg4LIBpEfVS1GWla72BtbMv8t4K9/JFetVzL4Y=;
        b=B9EkoSrcncQuWIEZOKg9jrfIBeQPd1IwIMPje3NqZ6d1D3lZptOrDVIqQQalZMFsnB
         KH99vB1RdoXSNCGr5ORgIneBQq3tjtNdkfBRZxg3sZZ4bVkG5LPTQu0i+3GmF9Fpz1HB
         mtWTdu8DwlqeMJfacKHJU+dRveCrKiSVQwlHfFif2L6838pE0WUiLxNlUFM02qk8gDsF
         sfgvQ/KzZMNNoyJyHNrjFNDM1S4kcbxUNxY9lu4nB0TUrB1Ia9Jb3IOnF8aE2yEwbhFI
         t1CSQeD1dfN5WPMRmji40QCKzUxsUr7HNJCq1UAx1QF7CMMHn5/xI4kWogSCFuXiXSaz
         9EcQ==
X-Gm-Message-State: AOJu0Ywmk17q5jVa2NwQg3TGerw7+hAtJWYohebPvFv8jOf9sO1PCYRw
        s6Z3KJPriekQlg7RBkhZYF4Zx93+u+jYbrz09Emxyw==
X-Google-Smtp-Source: AGHT+IEO5m0wQ2tsImm5QHxzm4iqEHFDzfA89KXED3Us0SNUNIbbB3FrzNd+kDtMnzwdfNNpBjZTFA==
X-Received: by 2002:a05:6870:4153:b0:1be:ca9e:a65 with SMTP id r19-20020a056870415300b001beca9e0a65mr2571505oad.58.1691773549257;
        Fri, 11 Aug 2023 10:05:49 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k6-20020a0dfa06000000b005731dbd4928sm1092986ywf.69.2023.08.11.10.05.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 10:05:49 -0700 (PDT)
Date:   Fri, 11 Aug 2023 13:05:48 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH v2 3/5] t/t5318-commit-graph.sh: test generation zero
 transitions during fsck
Message-ID: <8679db3d0e895bef7f9a12d8d6742ca812768241.1691773533.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691773533.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691773533.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The second test called "detect incorrect generation number" asserts that
we correctly warn during an fsck when we see a non-zero generation
number after seeing a zero beforehand.

The other transition (going from non-zero to zero) was previously
untested. Test both directions, and rename the existing test to make
clear which direction it is exercising.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5318-commit-graph.sh | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 4e70820c74..8e96471b34 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -450,14 +450,15 @@ GRAPH_BYTE_FANOUT2=$(($GRAPH_FANOUT_OFFSET + 4 * 255))
 GRAPH_OID_LOOKUP_OFFSET=$(($GRAPH_FANOUT_OFFSET + 4 * 256))
 GRAPH_BYTE_OID_LOOKUP_ORDER=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 8))
 GRAPH_BYTE_OID_LOOKUP_MISSING=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * 4 + 10))
+GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
 GRAPH_COMMIT_DATA_OFFSET=$(($GRAPH_OID_LOOKUP_OFFSET + $HASH_LEN * $NUM_COMMITS))
 GRAPH_BYTE_COMMIT_TREE=$GRAPH_COMMIT_DATA_OFFSET
 GRAPH_BYTE_COMMIT_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN))
 GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
 GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
+GRAPH_BYTE_COMMIT_GENERATION_LAST=$(($GRAPH_BYTE_COMMIT_GENERATION + $(($NUM_COMMITS - 1)) * $GRAPH_COMMIT_DATA_WIDTH))
 GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
-GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
 GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
 			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
 GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
@@ -596,11 +597,6 @@ test_expect_success 'detect incorrect generation number' '
 		"generation for commit"
 '
 
-test_expect_success 'detect incorrect generation number' '
-	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\01" \
-		"but zero elsewhere"
-'
-
 test_expect_success 'detect incorrect commit date' '
 	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_DATE "\01" \
 		"commit date"
@@ -622,6 +618,16 @@ test_expect_success 'detect incorrect chunk count' '
 		$GRAPH_CHUNK_LOOKUP_OFFSET
 '
 
+test_expect_success 'detect mixed generation numbers (non-zero to zero)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION_LAST "\0\0\0\0" \
+		"but non-zero elsewhere"
+'
+
+test_expect_success 'detect mixed generation numbers (zero to non-zero)' '
+	corrupt_graph_and_verify $GRAPH_BYTE_COMMIT_GENERATION "\0\0\0\0" \
+		"but zero elsewhere"
+'
+
 test_expect_success 'git fsck (checks commit-graph when config set to true)' '
 	git -C full fsck &&
 	corrupt_graph_and_verify $GRAPH_BYTE_FOOTER "\00" \
-- 
2.42.0.rc0.30.gb82b15ebc8

