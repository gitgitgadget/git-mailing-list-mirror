Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A732C1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965429AbeF0NZ3 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:29 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46567 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965111AbeF0NZ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:28 -0400
Received: by mail-qt0-f193.google.com with SMTP id h5-v6so1560689qtm.13
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QnR0ekdCN7hQfJsxOheFV0xXIkQypZA8brItIYd5iVY=;
        b=iCfy/4731a+0gKcL7WBceWrhUXpAd3aiemNgY/rXefgp0E89EieNdmenqjwHyyIX5+
         DH0EDyHIGu15HVmbu61CTfIQ1oBZyCdFZMJCQMj1j8CwufU4ipKbfRsc5LrH6M+3A4Wo
         MkIGOTPHqBLz1oPvi41VNFmb28zcbPwhvTnnh3lwekLw7+JygPrZI/X4h05UxOyicS/2
         fXpy3By+zdIRQjqozX8BK9NjGTDH34ZC5viXzn5yKegKvCJ5yynyg2Cx9O67UzJz4bGX
         pMFC93lzPx8C+P49JmMaIbbCLITVIM88XNEjiV8pbej8ON8xSMFb/924gjC/kPoWETSL
         IrXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QnR0ekdCN7hQfJsxOheFV0xXIkQypZA8brItIYd5iVY=;
        b=grzInKN6AgcLOaGe024M8vVtQApfPueF7OyVW/tjWq58OwBQtFqMy/RyZBDNWBXCce
         wRwaZqliV1nBW3xWM497r6nugPGSAxcXv4M/3vxcftUaXsv0stcaE0VsZxmdH23jIq/j
         LD315DeN0pLXuDKkWxhE3oJnM6t7KIh0Vy8cW65urY4Y7xWJc25mTnevtf3Kfz5cj08T
         gfYmScpwo4p6F5vskAVEGkOlzs9bLFSNkfoRQNqKF/lDCUderfw/EPz+73dXKucmTGRh
         0Pw4ecS1eD5Le+eM6NcMeC4x1xHJZYLtSpaQP8cHsY0y+aV6wNBjNvDR1WblbqiOtib4
         pqlw==
X-Gm-Message-State: APt69E09OFlAkKTk6QsLu7OO3CXqTxttcdufwmT3i+AGgpuC5pNyBpX/
        BH5+M7NgBAUcGiO7iqI/rN5XsjdGUDI=
X-Google-Smtp-Source: AAOMgpepbFNhnq/QJMNm+g53FkRJFYZaeeyPUTXIwJ/tXE4wFcW+kzahMD4fThqhTGhd/ZXNC37i+w==
X-Received: by 2002:ac8:460c:: with SMTP id p12-v6mr5323515qtn.289.1530105927443;
        Wed, 27 Jun 2018 06:25:27 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:26 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 16/22] commit-graph: test for corrupted octopus edge
Date:   Wed, 27 Jun 2018 09:24:41 -0400
Message-Id: <20180627132447.142473-17-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit-graph file has an extra chunk to store the parent int-ids for
parents beyond the first parent for octopus merges. Our test repo has a
single octopus merge that we can manipulate to demonstrate the 'verify'
subcommand detects incorrect values in that chunk.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 2c65e6a95c..a0cf1f66de 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -248,6 +248,7 @@ test_expect_success 'git commit-graph verify' '
 '
 
 NUM_COMMITS=9
+NUM_OCTOPUS_EDGES=2
 HASH_LEN=20
 GRAPH_BYTE_VERSION=4
 GRAPH_BYTE_HASH=5
@@ -274,6 +275,10 @@ GRAPH_BYTE_COMMIT_EXTRA_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 4))
 GRAPH_BYTE_COMMIT_WRONG_PARENT=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 3))
 GRAPH_BYTE_COMMIT_GENERATION=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 11))
 GRAPH_BYTE_COMMIT_DATE=$(($GRAPH_COMMIT_DATA_OFFSET + $HASH_LEN + 12))
+GRAPH_COMMIT_DATA_WIDTH=$(($HASH_LEN + 16))
+GRAPH_OCTOPUS_DATA_OFFSET=$(($GRAPH_COMMIT_DATA_OFFSET + \
+			     $GRAPH_COMMIT_DATA_WIDTH * $NUM_COMMITS))
+GRAPH_BYTE_OCTOPUS=$(($GRAPH_OCTOPUS_DATA_OFFSET + 4))
 
 # usage: corrupt_graph_and_verify <position> <data> <string>
 # Manipulates the commit-graph file at the position
@@ -383,4 +388,9 @@ test_expect_success 'detect incorrect commit date' '
 		"commit date"
 '
 
+test_expect_success 'detect incorrect parent for octopus merge' '
+	corrupt_graph_and_verify $GRAPH_BYTE_OCTOPUS "\01" \
+		"invalid parent"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

