Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CE0C620281
	for <e@80x24.org>; Sun, 17 Sep 2017 08:17:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751302AbdIQIRm (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Sep 2017 04:17:42 -0400
Received: from benson.default.arb33.uk0.bigv.io ([46.43.0.16]:33436 "EHLO
        benson.default.arb33.uk0.bigv.io" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750860AbdIQIRj (ORCPT
        <rfc822;git@vger.kernel.org>); Sun, 17 Sep 2017 04:17:39 -0400
Received: from cpc91198-cmbg18-2-0-cust103.5-4.cable.virginm.net ([81.98.98.104] helo=celaeno.hellion.org.uk)
        by benson.default.arb33.uk0.bigv.io with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <ijc-relay-phiayoh8@benson.default.arb33.uk0.bigv.io>)
        id 1dtU8U-0006LR-1q; Sun, 17 Sep 2017 08:37:02 +0100
Received: from dagon.hellion.org.uk ([192.168.1.7])
        by celaeno.hellion.org.uk with smtp (Exim 4.84_2)
        (envelope-from <ijc@hellion.org.uk>)
        id 1dtU8Q-0005xI-Tj; Sun, 17 Sep 2017 08:37:00 +0100
Received: by dagon.hellion.org.uk (sSMTP sendmail emulation); Sun, 17 Sep 2017 08:36:58 +0100
From:   Ian Campbell <ijc@hellion.org.uk>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Ian Campbell <ijc@hellion.org.uk>
Subject: [PATCH v2 2/4] filter-branch: reset $GIT_* before cleaning up
Date:   Sun, 17 Sep 2017 08:36:55 +0100
Message-Id: <20170917073657.31193-2-ijc@hellion.org.uk>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <1505633797.22447.4.camel@hellion.org.uk>
References: <1505633797.22447.4.camel@hellion.org.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is pure code motion to enable a subsequent patch to add code which needs
to happen with the reset $GIT_* but before the temporary directory has been
cleaned up.

Signed-off-by: Ian Campbell <ijc@hellion.org.uk>
---
 git-filter-branch.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/git-filter-branch.sh b/git-filter-branch.sh
index 05645064a..e15c538f6 100755
--- a/git-filter-branch.sh
+++ b/git-filter-branch.sh
@@ -544,11 +544,6 @@ if [ "$filter_tag_name" ]; then
 	done
 fi
 
-cd "$orig_dir"
-rm -rf "$tempdir"
-
-trap - 0
-
 unset GIT_DIR GIT_WORK_TREE GIT_INDEX_FILE
 test -z "$ORIG_GIT_DIR" || {
 	GIT_DIR="$ORIG_GIT_DIR" && export GIT_DIR
@@ -562,6 +557,11 @@ test -z "$ORIG_GIT_INDEX_FILE" || {
 	export GIT_INDEX_FILE
 }
 
+cd "$orig_dir"
+rm -rf "$tempdir"
+
+trap - 0
+
 if [ "$(is_bare_repository)" = false ]; then
 	git read-tree -u -m HEAD || exit
 fi
-- 
2.11.0

