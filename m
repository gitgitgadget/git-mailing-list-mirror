Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8925120954
	for <e@80x24.org>; Fri,  1 Dec 2017 23:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751840AbdLAXaU (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 18:30:20 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:34667 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbdLAXaT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 18:30:19 -0500
Received: from fizzler.bingo (xc347130c.dyn.telefonica.de [195.71.19.12])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 84FB5140CB0;
        Sat,  2 Dec 2017 00:30:18 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 195.71.19.12) smtp.mailfrom=rabel@robertabel.eu smtp.helo=fizzler.bingo
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Cc:     Robert Abel <rabel@robertabel.eu>
Subject: [PATCH v2 2/2] git-prompt: fix reading files with windows line endings
Date:   Sat,  2 Dec 2017 00:31:33 +0100
Message-Id: <20171201233133.30011-2-rabel@robertabel.eu>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <20171201233133.30011-1-rabel@robertabel.eu>
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
 <20171201233133.30011-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20171201233018.7791.97026@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If any of the files read by __git_eread have \r\n line endings, read
will only strip \n, leaving \r. This results in an ugly prompt, where
instead of

    user@pc MINGW64 /path/to/repo (BARE:master)

the last parenthesis is printed over the beginning of the prompt like

    )ser@pc MINGW64 /path/to/repo (BARE:master

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 contrib/completion/git-prompt.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index 41a471957..983e419d2 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -283,7 +283,7 @@ __git_ps1_colorize_gitstring ()
 # variable, in that order.
 __git_eread ()
 {
-	test -r "$1" && read "$2" <"$1"
+	test -r "$1" && IFS=$'\r\n' read "$2" <"$1"
 }
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-- 
2.15.1

