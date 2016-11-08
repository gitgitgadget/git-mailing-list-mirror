Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D32C82022A
	for <e@80x24.org>; Tue,  8 Nov 2016 17:03:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753937AbcKHRDH (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Nov 2016 12:03:07 -0500
Received: from mx2.suse.de ([195.135.220.15]:51634 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752944AbcKHRDH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2016 12:03:07 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 790B0AC72
        for <git@vger.kernel.org>; Tue,  8 Nov 2016 17:03:05 +0000 (UTC)
From:   Andreas Schwab <schwab@suse.de>
To:     git@vger.kernel.org
Subject: [PATCH] t6026-merge-attr: don't fail if sleep exits early
X-Yow:  Uh-oh!!  I forgot to submit to COMPULSORY URINALYSIS!
Date:   Tue, 08 Nov 2016 18:03:04 +0100
Message-ID: <mvmtwbhdhvb.fsf@hawking.suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit 5babb5bdb3 ("t6026-merge-attr: clean up background process at end
of test case") added a kill command to clean up after the test, but this
can fail if the sleep command exits before the cleanup is executed.
Ignore the error from the kill command.

Signed-off-by: Andreas Schwab <schwab@suse.de>
---
The failure can be simulated by adding a sleep after the last command to
delay the cleanup.
---
 t/t6026-merge-attr.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t6026-merge-attr.sh b/t/t6026-merge-attr.sh
index 7a6e33e673..2672b15aa3 100755
--- a/t/t6026-merge-attr.sh
+++ b/t/t6026-merge-attr.sh
@@ -187,7 +187,7 @@ test_expect_success 'custom merge does not lock index' '
 		sleep 1 &
 		echo $! >sleep.pid
 	EOF
-	test_when_finished "kill \$(cat sleep.pid)" &&
+	test_when_finished "kill \$(cat sleep.pid) || :" &&
 
 	test_write_lines >.gitattributes \
 		"* merge=ours" "text merge=sleep-one-second" &&
-- 
2.10.2


-- 
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
