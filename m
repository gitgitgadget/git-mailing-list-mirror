Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 644E31FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 23:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751422AbdBMXfH (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 18:35:07 -0500
Received: from zimbra-vnc.tngtech.com ([83.144.240.98]:47444 "EHLO
        proxy.tng.vnc.biz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbdBMXfG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 18:35:06 -0500
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 958431E3094;
        Tue, 14 Feb 2017 00:35:02 +0100 (CET)
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 1F2i1SDB-4Jk; Tue, 14 Feb 2017 00:35:02 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by proxy.tng.vnc.biz (Postfix) with ESMTP id 129941E30A4;
        Tue, 14 Feb 2017 00:35:02 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from proxy.tng.vnc.biz ([127.0.0.1])
        by localhost (proxy.tng.vnc.biz [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id zT4deLS8bode; Tue, 14 Feb 2017 00:35:02 +0100 (CET)
Received: from localhost.localdomain (aftr-185-17-206-18.dynamic.mnet-online.de [185.17.206.18])
        by proxy.tng.vnc.biz (Postfix) with ESMTPSA id A20351E3094;
        Tue, 14 Feb 2017 00:35:01 +0100 (CET)
From:   cornelius.weig@tngtech.com
To:     git@vger.kernel.org
Cc:     Cornelius Weig <cornelius.weig@tngtech.com>, szeder.dev@gmail.com,
        j6t@kdbg.org, bitte.keine.werbung.einwerfen@googlemail.com
Subject: [PATCH] completion: complete modified files for checkout with '--'
Date:   Tue, 14 Feb 2017 00:33:59 +0100
Message-Id: <20170213233359.11149-1-cornelius.weig@tngtech.com>
X-Mailer: git-send-email 2.10.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Cornelius Weig <cornelius.weig@tngtech.com>

The command line completion for git-checkout bails out when seeing '--'
as an isolated argument. For git-checkout this signifies the start of a
list of files which are to be checked out. Checkout of files makes only
sense for modified files, therefore completion can be a bit smarter:
Instead of bailing out, offer modified files for completion.

Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
---
 contrib/completion/git-completion.bash | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 6c6e1c7..d6523fd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1059,7 +1059,10 @@ _git_bundle ()
 
 _git_checkout ()
 {
-	__git_has_doubledash && return
+	__git_has_doubledash && {
+		__git_complete_index_file "--modified"
+		return
+	}
 
 	case "$cur" in
 	--conflict=*)
-- 
2.10.2

