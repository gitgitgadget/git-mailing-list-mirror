Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6EFB20954
	for <e@80x24.org>; Tue, 28 Nov 2017 20:26:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753260AbdK1U0c (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Nov 2017 15:26:32 -0500
Received: from mxf98a.netcup.net ([46.38.249.138]:45045 "EHLO
        mxf98a.netcup.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753080AbdK1U0b (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Nov 2017 15:26:31 -0500
Received: from desky.robertabel.eu (x4d076d7f.dyn.telefonica.de [77.7.109.127])
        by mxf98a.netcup.net (Postfix) with ESMTPSA id 25B0A140CBA;
        Tue, 28 Nov 2017 21:18:27 +0100 (CET)
Authentication-Results: mxf98a;
        spf=pass (sender IP is 77.7.109.127) smtp.mailfrom=rabel@robertabel.eu smtp.helo=desky.robertabel.eu
Received-SPF: pass (mxf98a: connection is authenticated)
From:   Robert Abel <rabel@robertabel.eu>
To:     git@vger.kernel.org
Cc:     Robert Abel <rabel@robertabel.eu>
Subject: [PATCH] git-prompt: fix reading files with windows line endings
Date:   Tue, 28 Nov 2017 21:18:18 +0100
Message-Id: <20171128201818.4132-2-rabel@robertabel.eu>
X-Mailer: git-send-email 2.13.0.windows.1
In-Reply-To: <20171128201818.4132-1-rabel@robertabel.eu>
References: <20171128201818.4132-1-rabel@robertabel.eu>
X-PPP-Message-ID: <20171128201827.17710.34303@mxf98a.netcup.net>
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
index c6cbef38c2..71a64e7959 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -282,7 +282,7 @@ __git_eread ()
 {
 	local f="$1"
 	shift
-	test -r "$f" && read "$@" <"$f"
+	test -r "$f" && read "$@" <"$f" && export $@="${!@%$'\r'}"
 }
 
 # __git_ps1 accepts 0 or 1 arguments (i.e., format string)
-- 
2.13.0.windows.1

