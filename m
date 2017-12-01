Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EA8320954
	for <e@80x24.org>; Fri,  1 Dec 2017 23:30:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751500AbdLAXaE (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Dec 2017 18:30:04 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:34833 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751414AbdLAXaD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Dec 2017 18:30:03 -0500
Received: from fizzler.bingo (xc347130c.dyn.telefonica.de [195.71.19.12])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 2A779140CAE;
        Sat,  2 Dec 2017 00:30:02 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 195.71.19.12) smtp.mailfrom=rabel@robertabel.eu smtp.helo=fizzler.bingo
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Cc:     Robert Abel <rabel@robertabel.eu>
Subject: [PATCH v2 1/2] git-prompt: make __git_eread intended use explicit
Date:   Sat,  2 Dec 2017 00:31:32 +0100
Message-Id: <20171201233133.30011-1-rabel@robertabel.eu>
X-Mailer: git-send-email 2.15.1
In-Reply-To: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
References: <alpine.DEB.2.21.1.1712011143320.98586@virtualbox>
X-PPP-Message-ID: <20171201233002.7732.80986@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__git_eread is used to read a single line of a given file (if it exists)
into a variable without the EOL. All six current users of __git_eread
use it that way and don't expect multi-line content.

Thus, add a comment and explicitly use $2 instead of shifting the args
down and using $@.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 contrib/completion/git-prompt.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c6cbef38c..41a471957 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -278,11 +278,12 @@ __git_ps1_colorize_gitstring ()
 	r="$c_clear$r"
 }
 
+# Helper function to read the first line of a file into a variable.
+# __git_eread requires 2 arguments, the file path and the name of the
+# variable, in that order.
 __git_eread ()
 {
-	local f="$1"
-	shift
-	test -r "$f" && read "$@" <"$f"
+	test -r "$1" && read "$2" <"$1"
 }
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-- 
2.15.1

