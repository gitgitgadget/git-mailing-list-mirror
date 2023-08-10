Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DFFC001DE
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235402AbjHJUho (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235364AbjHJUhm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:37:42 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F351E2738
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:41 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-583f036d50bso15055537b3.3
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1691699861; x=1692304661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jiOlJUhG+9no+fop+p2xwp8mlQwHAHXweQz3coMlkzs=;
        b=g1bOKIG7zrQKwG3q8mStpFUQ3mPw398TIH4qcmNa7oMcDh4NPYYdQmG3najkEHZmZ+
         fh5BcgNZuvXzSPmwOIRZUuLObTgqzIyuNq75lhEtCdM5VGwIRKvBN074uSpm1qFFevm0
         z72LyX6h21SI4oVgHTwpp57EcaC8hWfd/BBw7AvfQzL39BRCnY6Dx9gjh0RIufVj8tuX
         yP/kj5N1JrNtnbifbsS2ovj9tejpgw2zRADgJMz0Cj3Dcw0Wed6fvZ0pLeUA2k0fJrtV
         TpGzx3Wro0l6QOWcP1jUyun0Y3FRy0yTa4pYsVzPDN3DLvHbY/Z1EVOcwRsS6Sk6qT/v
         tCAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691699861; x=1692304661;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiOlJUhG+9no+fop+p2xwp8mlQwHAHXweQz3coMlkzs=;
        b=fEUHf35mGYbuh9wsemuTlAozhVwrHn/UGj6wIEVZHXC4NOWQ/HFkMVzagqQfyqT1Lj
         ChUQVtEGkSNa7jrzKMexegRyzDpq8wThD7BmxS4k6qAxJXTys0JCUVvF5sGzaV4wLSfT
         nC9/dSpqc9rff/Gbj93X6ggI6xK75T1I++etkJCVBsd0hpw2h/uPByDMsNVHYEdq4SW2
         v/ChX+1mII/0z1L+CM2qRIS9QK9vCgehYFNxVhTEZmRAaWIYCmRCXTjoGEyHavBUZpoJ
         odssOoe7gPp8eRhCyKwiWAX2S32cC5xsfQWP2OC1OxPPf7RcV0RjO6PcBH88bYyQ/Kew
         5wjw==
X-Gm-Message-State: AOJu0Yy3/lI9YjKd9B2cQbealudvQ5onx9mYx/lbFMkXnos/5/0x+ji1
        ogqDhv6CtJ5S9L7aGEj7yLo/gtyZNwcU8zRKwON+Rw==
X-Google-Smtp-Source: AGHT+IHMpmAYgROY+vVG6rHOGVaV6XMvD5w0SKFbI/mM13UgwiuXUwaYo6saKE0HU54QcLnUQtleIA==
X-Received: by 2002:a81:6d43:0:b0:589:a5b5:4e65 with SMTP id i64-20020a816d43000000b00589a5b54e65mr16793ywc.3.1691699860973;
        Thu, 10 Aug 2023 13:37:40 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d125-20020a814f83000000b005869e7171d4sm565704ywb.80.2023.08.10.13.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 13:37:40 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:37:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: [PATCH 3/4] t/t5318-commit-graph.sh: test generation zero
 transitions during fsck
Message-ID: <8679db3d0e895bef7f9a12d8d6742ca812768241.1691699851.git.me@ttaylorr.com>
References: <ZNUiEXF5CP6WMk9A@nand.local>
 <cover.1691699851.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1691699851.git.me@ttaylorr.com>
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
2.42.0.rc0.29.g00abebef8e

