Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.8 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15BF020A1E
	for <e@80x24.org>; Thu, 13 Dec 2018 19:44:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729053AbeLMToD (ORCPT <rfc822;e@80x24.org>);
        Thu, 13 Dec 2018 14:44:03 -0500
Received: from mail-qk1-f201.google.com ([209.85.222.201]:48688 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728102AbeLMToD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Dec 2018 14:44:03 -0500
Received: by mail-qk1-f201.google.com with SMTP id g22so2617513qke.15
        for <git@vger.kernel.org>; Thu, 13 Dec 2018 11:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=efEEs95enuKrdSqW+iergQtEBEBtrrcZb97DUu1UZCs=;
        b=i1P7LzwRRpSFb1wwVq05ApN5CHpeNsCA2PXUhL+xPJaSU0Mwx4t4rUjHPcZk/xBGtr
         fjQVbLDGdyTfFAqOD8Mc8aEXrG1huCujfcrUVWZCE3+2gXj1dYoDJ/jPb2qnC57teZgz
         UDXN3DIYUdmjdrT6Pr6ybYrw1N29AI5L09dzfKXVkOQ9Wv+z+riaX7dxO7dxD+J9+qUb
         tI8Diiop9oFoMBvvaSO4Ueqjsr2TohZGC3WasaRc1NE5efl7NiwzixFNqRkgaMt76eb0
         lHclVsNCTLVpJ+pTwheSA4sDVjuLOg5T0uOdM3ED36ONEv63SqUw5hMnYMCmY/ZrnBkO
         QunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=efEEs95enuKrdSqW+iergQtEBEBtrrcZb97DUu1UZCs=;
        b=P0gRHbGD0rk2HYG58h6AKTmDr0KfMqX89xKqYjXQ5uGQB3vRfP8M/w0QLz2/94rUKt
         w1pJayUJwNi1vYUKKhMSA3rQ3SFkUBSLOu+ZSKt6gO8X0KbosgZjxr/FjFYqxrEaZbVa
         Jdsv0MYaToj3uS7aA73+M51b6IVeh06aYgf+h7uL2hTbHbnuO3/28hQ5twF4YNTvQBVY
         Za+EjhC/TarZTsz+NZg6U4aMmEwzxR1aaWSWlY987BRA/cpvLG7jaNbiT8q9dCA7OS2j
         aH/riPaJjteHnAxQTb5VqV1f8AGJw6xhx1VKmLIZvy9DZBCSolIg41Mh+TNdLhuYEKDm
         S5Xg==
X-Gm-Message-State: AA+aEWZX0CurTzLZgq2YsYlFKYPy58+3cUrYLbnG0kjUxyVCmCofVZDR
        XOaxjR3AdieXQr/CRzVr9Ovifw5E9wvKRIoWF6pYNSjloMFxfH73mSSR4R81MLa7f1GTHs0+vaC
        h8VcNy2Iw8RigPTBAxkziTQ2NUqzotKnwpiabQb193jesjYc/mqheDAeDlBFAX9Q=
X-Google-Smtp-Source: AFSGD/X62VzuY302a4gxTh+Fu/nkDKNnbCkTBAMp4GM2XNACgqE45tkCc9atTZQMeEI40f0khBO6rFX1FSARIA==
X-Received: by 2002:a37:717:: with SMTP id 23mr92160qkh.1.1544730242316; Thu,
 13 Dec 2018 11:44:02 -0800 (PST)
Date:   Thu, 13 Dec 2018 11:43:55 -0800
In-Reply-To: <cover.1544048946.git.steadmon@google.com>
Message-Id: <cover.1544729841.git.steadmon@google.com>
Mime-Version: 1.0
References: <cover.1544048946.git.steadmon@google.com>
X-Mailer: git-send-email 2.20.0.rc2.403.gdbc3b29805-goog
Subject: [PATCH v4 0/3] Add commit-graph fuzzer and fix buffer overflow
From:   Josh Steadmon <steadmon@google.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, stolee@gmail.com, avarab@gmail.com,
        peff@peff.net, szeder.dev@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a new fuzz test for the commit graph and fix a buffer read-overflow
that it discovered. Additionally, fix the Makefile instructions for
building fuzzers.

Changes since V3:
  * Improve portability of the new test functionality.
  * Fix broken &&-chains in tests.

Changes since V2:
  * Avoid pointer arithmetic overflow when checking the graph's chunk
    count.
  * Merge the corrupt_graph_and_verify and
    corrupt_and_zero_graph_then_verify test functions.

Josh Steadmon (3):
  commit-graph, fuzz: Add fuzzer for commit-graph
  commit-graph: fix buffer read-overflow
  Makefile: correct example fuzz build

 .gitignore              |  1 +
 Makefile                |  3 +-
 commit-graph.c          | 67 +++++++++++++++++++++++++++++------------
 commit-graph.h          |  3 ++
 fuzz-commit-graph.c     | 16 ++++++++++
 t/t5318-commit-graph.sh | 16 ++++++++--
 6 files changed, 83 insertions(+), 23 deletions(-)
 create mode 100644 fuzz-commit-graph.c

Range-diff against v3:
1:  675d58ecea ! 1:  80b5662f30 commit-graph: fix buffer read-overflow
    @@ -55,29 +55,26 @@
      	pos=$1
      	data="${2:-\0}"
      	grepstr=$3
    -+	orig_size=$(stat --format=%s $objdir/info/commit-graph)
    -+	zero_pos=${4:-${orig_size}}
    ++	orig_size=$(wc -c < $objdir/info/commit-graph) &&
    ++	zero_pos=${4:-${orig_size}} &&
      	cd "$TRASH_DIRECTORY/full" &&
      	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
      	cp $objdir/info/commit-graph commit-graph-backup &&
      	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
    -+	truncate --size=$zero_pos $objdir/info/commit-graph &&
    -+	truncate --size=$orig_size $objdir/info/commit-graph &&
    ++	dd of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=0 &&
    ++	dd if=/dev/zero of="$objdir/info/commit-graph" bs=1 seek="$zero_pos" count=$(($orig_size - $zero_pos)) &&
      	test_must_fail git commit-graph verify 2>test_err &&
    - 	grep -v "^+" test_err >err
    +-	grep -v "^+" test_err >err
    ++	grep -v "^+" test_err >err &&
      	test_i18ngrep "$grepstr" err
      }
      
    -+
    - test_expect_success 'detect bad signature' '
    - 	corrupt_graph_and_verify 0 "\0" \
    - 		"graph signature"
     @@
      		"incorrect checksum"
      '
      
     +test_expect_success 'detect incorrect chunk count' '
    -+	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\xff" \
    ++	corrupt_graph_and_verify $GRAPH_BYTE_CHUNK_COUNT "\377" \
     +		"chunk lookup table entry missing" $GRAPH_CHUNK_LOOKUP_OFFSET
     +'
     +
2:  06a32bfe8b = 2:  21101b961a Makefile: correct example fuzz build
-- 
2.20.0.rc2.10.g21101b961a

