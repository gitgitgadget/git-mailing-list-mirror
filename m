Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AAF8F20958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:39:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935230AbdCWPi4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:38:56 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36330 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934737AbdCWPit (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:38:49 -0400
Received: by mail-wm0-f66.google.com with SMTP id x124so17361910wmf.3
        for <git@vger.kernel.org>; Thu, 23 Mar 2017 08:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NHjJlOvm763DCaeHLHsjSZjcDhTSlkNESJ8LgeUs+v4=;
        b=TILfW9kW1CBywP1OuVDK2Ny45pVAWLEbmOtXQ3n9XLtvGVeqa6Wz88PDofVW5n0inU
         eQQtNjQeYDiW2vG0pNck+CuY8pabzq3+E/3TU/TQif2QjOR7bd+bxh89TPpekOo8xIVY
         VF6SZ4ufzAKdXkXjuTEIuFd78mHnZOR5wWE2UuChuNdKshN+hJm+EvHpvH/2OpSrMNm3
         aBL2/gv2Dqk45BdGw8u6tPrRligtQrVzErPZjKsSd7vqqImZws+saZjGt0iYLeVqvFev
         tXSadTdIgSTdRmC9dp2J59KIfjWZpMvTFZIXmRuInWHD6yHsh9f+juBu+JN/jVff7Un4
         fIIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHjJlOvm763DCaeHLHsjSZjcDhTSlkNESJ8LgeUs+v4=;
        b=CjR3Jc57i01/5yZApt2xejjcQ4ijwsB4rafgFA7eFRSrnbNIOOYaJZs4luSk0+OrL+
         DOfnAJ4gDDbFpT/wK6foUiPnVCLjw8uQ8WJL8EidqA4xApg1Zu5aEJDhZwdis1oxlvje
         GNQT7FgGIDd4elx6iwjjLx5EUWJRm+RdLXzw6kjWCV/ZYBEWyTvvfhqiL1ki/BsklyJn
         mfc2qb9SDV0wpl7SNVBxg2Dv3JiK/Nx6N/JnUgbjpUt0T4N76MLE2d0ELKMjgmpmNlCF
         8ySGgX0gyTl2JO6zyheNT/aDAIOG1xXQLK8D9/OrewcOXIUNjvV+D3VqqAbajGPWGFoF
         mW3w==
X-Gm-Message-State: AFeK/H0WWX/W1PHlgu7x4y95ZVL08MStiO+D0NZMBhWu3JhAb7jhE89sXK0p6SIj1CHxUg==
X-Received: by 10.28.168.130 with SMTP id r124mr13368548wme.34.1490283527735;
        Thu, 23 Mar 2017 08:38:47 -0700 (PDT)
Received: from localhost.localdomain (x4db02660.dyn.telefonica.de. [77.176.38.96])
        by smtp.gmail.com with ESMTPSA id b13sm4793766wmf.6.2017.03.23.08.38.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Mar 2017 08:38:47 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/3] completion: extract completing ctags symbol names into helper function
Date:   Thu, 23 Mar 2017 16:38:38 +0100
Message-Id: <20170323153839.24283-3-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.12.1.485.g1616aa492
In-Reply-To: <20170323153839.24283-1-szeder.dev@gmail.com>
References: <20170323153839.24283-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The previous commit doubled the number of __git_match_ctag()'s
positional parameters, and, to keep the position of existing
parameters for the sake of backwards compatibility, the prefix,
current word and suffix parameters ended up in different order than in
other functions accepting the same parameters.  Then there is a
condition checking the existence of the tag file before invoking this
function.

We could still live with this if there were only a single callsite,
but the next commit will add a few more, so it's worth providing a
cleaner interface.

Add the wrapper function __git_complete_symbol(), which encompasses
the condition for checking the presence of the tag file and filling
COMPREPLY, and accepts '--opt=val'-style options with default values
that keep callsites simpler.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 contrib/completion/git-completion.bash | 33 +++++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 5cacb0e2e..e38178022 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1529,6 +1529,34 @@ __git_match_ctag () {
 		" "$2"
 }
 
+# Complete symbol names from a tag file.
+# Usage: __git_complete_symbol [<option>]...
+# --tags=<file>: The tag file to list symbol names from instead of the
+#                default "tags".
+# --pfx=<prefix>: A prefix to be added to each symbol name.
+# --cur=<word>: The current symbol name to be completed.  Defaults to
+#               the current word to be completed.
+# --sfx=<suffix>: A suffix to be appended to each symbol name instead
+#                 of the default space.
+__git_complete_symbol () {
+	local tags=tags pfx="" cur_="${cur-}" sfx=" "
+
+	while test $# != 0; do
+		case "$1" in
+		--tags=*)	tags="${1##--tags=}" ;;
+		--pfx=*)	pfx="${1##--pfx=}" ;;
+		--cur=*)	cur_="${1##--cur=}" ;;
+		--sfx=*)	sfx="${1##--sfx=}" ;;
+		*)		return 1 ;;
+		esac
+		shift
+	done
+
+	if test -r "$tags"; then
+		__gitcomp_direct "$(__git_match_ctag "$cur_" "$tags" "$pfx" "$sfx")"
+	fi
+}
+
 _git_grep ()
 {
 	__git_has_doubledash && return
@@ -1554,10 +1582,7 @@ _git_grep ()
 
 	case "$cword,$prev" in
 	2,*|*,-*)
-		if test -r tags; then
-			__gitcomp_direct "$(__git_match_ctag "$cur" tags "" " ")"
-			return
-		fi
+		__git_complete_symbol && return
 		;;
 	esac
 
-- 
2.12.1.498.gded7ead47

