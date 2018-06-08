Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 890651F403
	for <e@80x24.org>; Fri,  8 Jun 2018 20:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932094AbeFHUdK (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 16:33:10 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:44786 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753098AbeFHUdE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 16:33:04 -0400
Received: by mail-wr0-f196.google.com with SMTP id x4-v6so6402953wro.11
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 13:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BG4VzNZ8wL8g9uXepevf7zrHBSydw1sQz41Ds8XPcWg=;
        b=cJ5ij7jcw1irrmTTnCiDHf//eJNIKcdhIgJVmUorYvDvDPK5pYaozaTUzF//04lym0
         cOTdRLy8uigp1Oe4r5+GBCBVvlaLhNThOATEttmUMN6fqVcf6AHB2AXnjTrYQfkKVeaw
         pkBCy7lSmFwVs5+maVGZpI45I/OH4cHwGnYnI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BG4VzNZ8wL8g9uXepevf7zrHBSydw1sQz41Ds8XPcWg=;
        b=BQJEErkKQup1Mf7jzcOUxQLnJn3P0s4+iwo7ZrAS4ltUVh2QJyZjdujHQ7JLVlHcEJ
         1df0YNFbjSWe28pPEgP4Q7ttTzI1vzJRYmOW32GTvCYI2UatpwaeomYpUeohVeqcUVbD
         Owr5pfnyy8gLz+GhW2WFe/CRC1oovWbVuTyUS2qC1UK3kRNFLKMEtt+jOzB7qurbUl1N
         MTFWgjKH1AdM8R/NEvY5L+njiWQr92gxWsW0XSDF2kYsJdjaSpkTBAvhklQ1obO2XxW1
         16NOWLZg3KodCeiW+dQz17oUy2I4FLhHpufvjgKbZGejqH4KzV6bk3iGjcvzd94sX1K6
         Iz1w==
X-Gm-Message-State: APt69E3I7T2wymS8nTcM317i/AkYfOtXuxH6J64dJwoUSkprS5tQXAFV
        sczio2H+RhSSZ1L+IiX/Bc7KCJqq
X-Google-Smtp-Source: ADUXVKIIbhOo8aSbRES+qTukqNSZzSdPMdY57Xw4JyM01cFIBCaTamTzp/LQjfbsziR8fjEQ4paIrw==
X-Received: by 2002:adf:e20b:: with SMTP id j11-v6mr6232371wri.205.1528489982387;
        Fri, 08 Jun 2018 13:33:02 -0700 (PDT)
Received: from ethel.corp.roku (cpc92728-cmbg20-2-0-cust351.5-4.cable.virginm.net. [82.29.15.96])
        by smtp.gmail.com with ESMTPSA id k82-v6sm240001wmg.10.2018.06.08.13.33.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Jun 2018 13:33:01 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     Eric Scouten <eric@scouten.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>, viniciusalexandre@gmail.com,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 6/6] git-p4: auto-size the block
Date:   Fri,  8 Jun 2018 21:32:48 +0100
Message-Id: <20180608203248.16311-7-luke@diamand.org>
X-Mailer: git-send-email 2.17.0.392.gdeb1a6e9b7
In-Reply-To: <20180608203248.16311-6-luke@diamand.org>
References: <20180608203248.16311-1-luke@diamand.org>
 <20180608203248.16311-2-luke@diamand.org>
 <20180608203248.16311-3-luke@diamand.org>
 <20180608203248.16311-4-luke@diamand.org>
 <20180608203248.16311-5-luke@diamand.org>
 <20180608203248.16311-6-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-p4 originally would fetch changes in one query. On large repos this
could fail because of the limits that Perforce imposes on the number of
items returned and the number of queries in the database.

To fix this, git-p4 learned to query changes in blocks of 512 changes,
However, this can be very slow - if you have a few million changes,
with each chunk taking about a second, it can be an hour or so.

Although it's possible to tune this value manually with the
"--changes-block-size" option, it's far from obvious to ordinary users
that this is what needs doing.

This change alters the block size dynamically by looking for the
specific error messages returned from the Perforce server, and reducing
the block size if the error is seen, either to the limit reported by the
server, or to half the current block size.

That means we can start out with a very large block size, and then let
it automatically drop down to a value that works without error, while
still failing correctly if some other error occurs.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 git-p4.py               | 27 +++++++++++++++++++++------
 t/t9818-git-p4-block.sh |  8 ++++++++
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5f59feb5bb..0354d4df5c 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -47,8 +47,8 @@ def __str__(self):
 # Only labels/tags matching this will be imported/exported
 defaultLabelRegexp = r'[a-zA-Z0-9_\-.]+$'
 
-# Grab changes in blocks of this many revisions, unless otherwise requested
-defaultBlockSize = 512
+# The block size is reduced automatically if required
+defaultBlockSize = 1<<20
 
 p4_access_checked = False
 
@@ -969,7 +969,8 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
     changes = set()
 
     # Retrieve changes a block at a time, to prevent running
-    # into a MaxResults/MaxScanRows error from the server.
+    # into a MaxResults/MaxScanRows error from the server. If
+    # we _do_ hit one of those errors, turn down the block size
 
     while True:
         cmd = ['changes']
@@ -983,10 +984,24 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
         for p in depotPaths:
             cmd += ["%s...@%s" % (p, revisionRange)]
 
+        # fetch the changes
+        try:
+            result = p4CmdList(cmd, errors_as_exceptions=True)
+        except P4RequestSizeException as e:
+            if not block_size:
+                block_size = e.limit
+            elif block_size > e.limit:
+                block_size = e.limit
+            else:
+                block_size = max(2, block_size // 2)
+
+            if verbose: print("block size error, retrying with block size {0}".format(block_size))
+            continue
+        except P4Exception as e:
+            die('Error retrieving changes description ({0})'.format(e.p4ExitCode))
+
         # Insert changes in chronological order
-        for entry in reversed(p4CmdList(cmd)):
-            if entry.has_key('p4ExitCode'):
-                die('Error retrieving changes descriptions ({})'.format(entry['p4ExitCode']))
+        for entry in reversed(result):
             if not entry.has_key('change'):
                 continue
             changes.add(int(entry['change']))
diff --git a/t/t9818-git-p4-block.sh b/t/t9818-git-p4-block.sh
index 8840a183ac..ce7cb22ad3 100755
--- a/t/t9818-git-p4-block.sh
+++ b/t/t9818-git-p4-block.sh
@@ -129,6 +129,7 @@ test_expect_success 'Create a repo with multiple depot paths' '
 '
 
 test_expect_success 'Clone repo with multiple depot paths' '
+	test_when_finished cleanup_git &&
 	(
 		cd "$git" &&
 		git p4 clone --changes-block-size=4 //depot/pathA@all //depot/pathB@all \
@@ -138,6 +139,13 @@ test_expect_success 'Clone repo with multiple depot paths' '
 	)
 '
 
+test_expect_success 'Clone repo with self-sizing block size' '
+	test_when_finished cleanup_git &&
+	git p4 clone --changes-block-size=1000000 //depot@all --destination="$git" &&
+	git -C "$git" log --oneline >log &&
+	test_line_count \> 10 log
+'
+
 test_expect_success 'kill p4d' '
 	kill_p4d
 '
-- 
2.17.0.392.gdeb1a6e9b7

