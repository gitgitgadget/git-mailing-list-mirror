Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B0F220248
	for <e@80x24.org>; Sat, 16 Mar 2019 19:27:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbfCPT1l (ORCPT <rfc822;e@80x24.org>);
        Sat, 16 Mar 2019 15:27:41 -0400
Received: from guitar.tcltek.co.il ([192.115.133.116]:56125 "EHLO
        mx.tkos.co.il" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726418AbfCPT1l (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Mar 2019 15:27:41 -0400
Received: from tarshish.tkos.co.il (unknown [10.0.8.3])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx.tkos.co.il (Postfix) with ESMTPS id 54219440441;
        Sat, 16 Mar 2019 21:27:20 +0200 (IST)
From:   Baruch Siach <baruch@tkos.co.il>
To:     git@vger.kernel.org
Cc:     Baruch Siach <baruch@tkos.co.il>, Joe Perches <joe@perches.com>,
        Rasmus Villemoes <rv@rasmusvillemoes.dk>
Subject: [PATCH] send-email: don't cc *-by lines with '-' prefix
Date:   Sat, 16 Mar 2019 21:26:50 +0200
Message-Id: <eec56beab016182fb78fbd367fcfa97f2ca6a5ff.1552764410.git.baruch@tkos.co.il>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since commit ef0cc1df90f6b ("send-email: also pick up cc addresses from
-by trailers") in git version 2.20, git send-email adds to cc list
addresses from all *-by lines. As a side effect a line with
'-Signed-off-by' is now also added to cc. This makes send-email pick
lines from patches that remove patch files from the git repo. This is
common in the Buildroot project that often removes (and adds) patch
files that have 'Signed-off-by' in their patch description part.

Consider only *-by lines that start with [a-z] (case insensitive) to
avoid unrelated addresses in cc.

Cc: Joe Perches <joe@perches.com>
Cc: Rasmus Villemoes <rv@rasmusvillemoes.dk>
Signed-off-by: Baruch Siach <baruch@tkos.co.il>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 8eb63b5a2f8d..5656ba83d9b1 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1693,7 +1693,7 @@ sub process_file {
 	# Now parse the message body
 	while(<$fh>) {
 		$message .=  $_;
-		if (/^([a-z-]*-by|Cc): (.*)/i) {
+		if (/^([a-z][a-z-]*-by|Cc): (.*)/i) {
 			chomp;
 			my ($what, $c) = ($1, $2);
 			# strip garbage for the address we'll use:
-- 
2.20.1

