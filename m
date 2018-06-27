Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C1CF1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 13:25:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965409AbeF0NZP (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 09:25:15 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:36438 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965398AbeF0NZN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 09:25:13 -0400
Received: by mail-qt0-f193.google.com with SMTP id o9-v6so1584579qtp.3
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 06:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AwziY/RFDVjLtrCsKZqq7wicq+lalmI5zPFBV3W9jC0=;
        b=dMGU7qlnzSsQJZvrUSfKhNsru+sibEa8fTx8EYV4zRCZ8NTw0SMI5fUIShjqxcIeMP
         8liq2oyix5u+fw/3fh5SRXj/3CLIsa9yZQpFJnpMWIbnzElFeoyH09sO3LeVz7RvvceO
         CR3NzEQysP8iRcjWb7BDRmrWNrbxEOw/p4Vfl1ns4k9DwR6xsUo9X93ejyPl7AGtWJXk
         osXTwQlVHZ+AUFd48IzAiXrNQ/DdRR00xVlLtxGWKmPSGYkDEkFl0AxaExS5LcqwjUCg
         vYsuX2cXalaWianwxr7FyfCkWpL2BlE76OXsF8Jr3O/nnbawF6qd9YXZw+1Ilz9O40Zp
         zChg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AwziY/RFDVjLtrCsKZqq7wicq+lalmI5zPFBV3W9jC0=;
        b=o7ZLHh62k6QM88ggDGjkgT/n7/qmUYIM+nIrGu6cKKXGUYUDBPjqGm3zwlWg+mdvKH
         ohGYxXNO8D3QDI3T2FLIj7xGjqdZsG6XcTu/HaXe0Q+PsVR2aJ/Cv7a6uhPGh/scN+gv
         POllAkIhULq5brs9KVVyqtjeAt2NiUAew9SEv116mTs8wzWZ+i8ePhCXKHKFtlZ1jeQy
         4Qlh6mbkOqppt+p/K+o9rew5U6xRQzfKLoU3AS8vXQ+NV1rP3tOBXu/gnq8HkNPkuJnE
         c39K4qUYkZqKtdV6X3Q2O+ZuPhTmJ5A2JZM+qk95/+ahicNpliYTLjWt1Oc25Y5EAh28
         kJWw==
X-Gm-Message-State: APt69E0DjleKu2lQnBTxlX96lBpnRMvclF+5izAd3OLDfr8mmSwIBpsZ
        mQ8l//jOikrDuZ6YzJgxdVnP8p6gFY0=
X-Google-Smtp-Source: AAOMgpfxFB/VoRSL2q9OaUbquRR1lw+IjVatu97oro5y8Xe6nJEEPEMe9zbVs3zyDcCtpBRPsod5Xw==
X-Received: by 2002:ac8:16bb:: with SMTP id r56-v6mr5348156qtj.23.1530105912128;
        Wed, 27 Jun 2018 06:25:12 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id 15-v6sm3761019qtv.56.2018.06.27.06.25.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jun 2018 06:25:11 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, avarab@gmail.com, sbeller@google.com,
        jnareb@gmail.com, marten.agren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v7 08/22] commit-graph: verify catches corrupt signature
Date:   Wed, 27 Jun 2018 09:24:33 -0400
Message-Id: <20180627132447.142473-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180627132447.142473-1-dstolee@microsoft.com>
References: <20180608135548.216405-1-dstolee@microsoft.com>
 <20180627132447.142473-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is the first of several commits that add a test to check that
'git commit-graph verify' catches corruption in the commit-graph
file. The first test checks that the command catches an error in
the file signature. This is a check that exists in the existing
commit-graph reading code.

Add a helper method 'corrupt_graph_and_verify' to the test script
t5318-commit-graph.sh. This helper corrupts the commit-graph file
at a certain location, runs 'git commit-graph verify', and reports
the output to the 'err' file. This data is filtered to remove the
lines added by 'test_must_fail' when the test is run verbosely.
Then, the output is checked to contain a specific error message.

Most messages from 'git commit-graph verify' will not be marked
for translation. There will be one exception: the message that
reports an invalid checksum will be marked for translation, as that
is the only message that is intended for a typical user.

Helped-by: Szeder Gábor <szeder.dev@gmail.com>
Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5318-commit-graph.sh | 43 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/t/t5318-commit-graph.sh b/t/t5318-commit-graph.sh
index 0830ef9fdd..c0c1ff09b9 100755
--- a/t/t5318-commit-graph.sh
+++ b/t/t5318-commit-graph.sh
@@ -235,9 +235,52 @@ test_expect_success 'perform fast-forward merge in full repo' '
 	test_cmp expect output
 '
 
+# the verify tests below expect the commit-graph to contain
+# exactly the commits reachable from the commits/8 branch.
+# If the file changes the set of commits in the list, then the
+# offsets into the binary file will result in different edits
+# and the tests will likely break.
+
 test_expect_success 'git commit-graph verify' '
 	cd "$TRASH_DIRECTORY/full" &&
+	git rev-parse commits/8 | git commit-graph write --stdin-commits &&
 	git commit-graph verify >output
 '
 
+GRAPH_BYTE_VERSION=4
+GRAPH_BYTE_HASH=5
+
+# usage: corrupt_graph_and_verify <position> <data> <string>
+# Manipulates the commit-graph file at the position
+# by inserting the data, then runs 'git commit-graph verify'
+# and places the output in the file 'err'. Test 'err' for
+# the given string.
+corrupt_graph_and_verify() {
+	pos=$1
+	data="${2:-\0}"
+	grepstr=$3
+	cd "$TRASH_DIRECTORY/full" &&
+	test_when_finished mv commit-graph-backup $objdir/info/commit-graph &&
+	cp $objdir/info/commit-graph commit-graph-backup &&
+	printf "$data" | dd of="$objdir/info/commit-graph" bs=1 seek="$pos" conv=notrunc &&
+	test_must_fail git commit-graph verify 2>test_err &&
+	grep -v "^+" test_err >err
+	test_i18ngrep "$grepstr" err
+}
+
+test_expect_success 'detect bad signature' '
+	corrupt_graph_and_verify 0 "\0" \
+		"graph signature"
+'
+
+test_expect_success 'detect bad version' '
+	corrupt_graph_and_verify $GRAPH_BYTE_VERSION "\02" \
+		"graph version"
+'
+
+test_expect_success 'detect bad hash version' '
+	corrupt_graph_and_verify $GRAPH_BYTE_HASH "\02" \
+		"hash version"
+'
+
 test_done
-- 
2.18.0.24.g1b579a2ee9

