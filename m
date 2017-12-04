Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 721DD20954
	for <e@80x24.org>; Mon,  4 Dec 2017 23:49:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751756AbdLDXtr (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Dec 2017 18:49:47 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:56267 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751156AbdLDXtq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Dec 2017 18:49:46 -0500
Received: from desky.robertabel.eu (x4d077b3a.dyn.telefonica.de [77.7.123.58])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 819D714080D;
        Tue,  5 Dec 2017 00:49:45 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.123.58) smtp.mailfrom=rabel@robertabel.eu smtp.helo=desky.robertabel.eu
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Cc:     Robert Abel <rabel@robertabel.eu>
Subject: [PATCH v3 1/2] git-prompt: make __git_eread intended use explicit
Date:   Tue,  5 Dec 2017 00:49:22 +0100
Message-Id: <20171204234923.9600-1-rabel@robertabel.eu>
X-Mailer: git-send-email 2.13.0.windows.1
In-Reply-To: <20171201233133.30011-1-rabel@robertabel.eu>
References: <20171201233133.30011-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20171204234945.18542.94088@mxf98a.netcup.net>
X-PPP-Vhost: robertabel.eu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

__git_eread is used to read a single line of a given file (if it exists)
into a single variable without the EOL. All six current users of __git_eread
use it that way and don't expect multi-line content.

Therefore, this patch removes the unused capability to split file conents into
tokens by passing multiple variable names. Add a comment and explicitly use $2
instead of $@ to read the file into one variable.

Signed-off-by: Robert Abel <rabel@robertabel.eu>
---
 contrib/completion/git-prompt.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index c6cbef38c2..41a471957a 100644
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
2.13.0.windows.1

