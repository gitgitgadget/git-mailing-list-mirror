Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6826A20A17
	for <e@80x24.org>; Sun, 22 Jan 2017 19:53:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbdAVTxR (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jan 2017 14:53:17 -0500
Received: from smtp-out-5.talktalk.net ([62.24.135.69]:36119 "EHLO
        smtp-out-5.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbdAVTxK (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jan 2017 14:53:10 -0500
Received: from localhost.localdomain ([92.31.218.76])
        by smtp.talktalk.net with SMTP
        id VOCIcRFMZHGLwVOCKca3TM; Sun, 22 Jan 2017 19:53:08 +0000
X-Originating-IP: [92.31.218.76]
X-Spam: 0
X-OAuthority: v=2.2 cv=dsCZMBo4 c=1 sm=1 tr=0 a=e6L6E7eW+5Nb7SO+DvSdIg==:117
 a=e6L6E7eW+5Nb7SO+DvSdIg==:17 a=1XWaLZrsAAAA:8 a=NEAV23lmAAAA:8
 a=pGLkceISAAAA:8 a=xtxXYLxNAAAA:8 a=4tzHqaojkdpRKMzpEN4A:9
 a=nJcEw6yWrPvoIXZ49MH8:22 a=Bn2pgwyD2vrAyMmN8A2t:22 a=6kGIvZw6iX1k4Y-7sg4_:22
 a=xts0dhWdiJbonKbuqhAr:22
From:   Philip Oakley <philipoakley@iee.org>
To:     GitList <git@vger.kernel.org>
Cc:     Self <philipoakley@iee.org>
Subject: [PATCH v3 1/4] git-gui: remove duplicate entries from .gitconfig's gui.recentrepo
Date:   Sun, 22 Jan 2017 19:52:58 +0000
Message-Id: <20170122195301.1784-2-philipoakley@iee.org>
X-Mailer: git-send-email 2.9.0.windows.1.323.g0305acf
In-Reply-To: <20170122195301.1784-1-philipoakley@iee.org>
References: <20170122195301.1784-1-philipoakley@iee.org>
X-CMAE-Envelope: MS4wfHcCY32gOz322x4H+mlPFThsn+7IqxU03m1vvwZSOvhgzwQ5t40fP+R3Beh9JRSggt0ZmRB1qGP+XXfl8ZQHMZcsZFp9mNCeMXmA7fg7vFuwxmrZ2HrI
 AGbAZzZ80M5RsWOvjVwLmMDbuqq9f0P7sxBnq45UsU+zeiE4StsRemh9e0G8vGsygUrV6KrfmI3B6KZwEINmHhpf9e4S3YBtTjg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The git gui's recent repo list may become contaminated with duplicate
entries. The git gui would barf when attempting to remove one entry.
Remove them all - there is no option within 'git config' to selectively
remove one of the entries.

This issue was reported on the 'Git User' list
(https://groups.google.com/forum/#!topic/git-users/msev4KsQGFc,
Warning: gui.recentrepo has multiply values while executing).

And also by zosrothko as a Git-for-Windows issue
https://github.com/git-for-windows/git/issues/1014.

On startup the gui checks that entries in the recentrepo list are still
valid repos and deletes thoses that are not. If duplicate entries are
present the 'git config --unset' will barf and this prevents the gui
from starting.

Subsequent patches fix other parts of recentrepo logic used for syncing
internal lists with the external .gitconfig.

Reported-by: Alexey Astakhov <asstv7@gmail.com>
Signed-off-by: Philip Oakley <philipoakley@iee.org>
---
 lib/choose_repository.tcl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/choose_repository.tcl b/lib/choose_repository.tcl
index 75d1da8..133ca0a 100644
--- a/lib/choose_repository.tcl
+++ b/lib/choose_repository.tcl
@@ -247,7 +247,7 @@ proc _get_recentrepos {} {
 
 proc _unset_recentrepo {p} {
 	regsub -all -- {([()\[\]{}\.^$+*?\\])} $p {\\\1} p
-	git config --global --unset gui.recentrepo "^$p\$"
+	git config --global --unset-all gui.recentrepo "^$p\$"
 	load_config 1
 }
 
-- 
2.9.0.windows.1.323.g0305acf

