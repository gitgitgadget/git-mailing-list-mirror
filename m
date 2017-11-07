Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6ED220A36
	for <e@80x24.org>; Tue,  7 Nov 2017 21:22:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933974AbdKGVWt (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Nov 2017 16:22:49 -0500
Received: from a7-20.smtp-out.eu-west-1.amazonses.com ([54.240.7.20]:51314
        "EHLO a7-20.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932345AbdKGVWs (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 7 Nov 2017 16:22:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=shh3fegwg5fppqsuzphvschd53n6ihuv; d=amazonses.com; t=1510089767;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=1lAQ+IrzlAKGjNah1uKoP43xJvxzULt/SSbjkAFPKMA=;
        b=OEVt830eyaQ7zSYPKc8a7sZvfY/9AcExnCN3eLW4Iw8XnbUV89zb0k0imTaOkwws
        W7Hm4sExoNqqpMbDaZMnCUgm2kEHYPK1h8q6xogL5+neNywoGXa73xswWriV2wwqREm
        RP6Obetm81Eg5QKpKN1Bh3+o2Yx/XLaZrR249vjg=
From:   Max Rothman <max.r.rothman@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
In-Reply-To: <CAGZ79kYKfZC1CzoGE_6G1b2vD+MCw1_rY7J_LeWyT8rp6CAuDw@mail.gmail.com>
References: <CAGZ79kYKfZC1CzoGE_6G1b2vD+MCw1_rY7J_LeWyT8rp6CAuDw@mail.gmail.com>
Subject: [PATCH] completion: add missing completions for log, diff, show
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 7 Nov 2017 21:22:47 +0000
X-SES-Outgoing: 2017.11.07-54.240.7.20
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Max Rothman <max-rothman@pluralsight.com>

Teach git-log tab completion about the --no-* options for ease of use
at the command line.

Similarly, teach git-show tab completion about the --no-abbrev-commit,
--expand-tabs, and --no-expand-tabs options.

Also, teach git-diff (and all commands that use its options) tab
completion about the --textconv and --indent-heuristic families of
options. --indent-heuristic is no longer experimental, so there's no
reason it should be left out of tab completion any more, and textconv
seems to have simply been missed.
---
 contrib/completion/git-completion.bash | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0e16f017a4144..252a6c8c0c80c 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1412,6 +1412,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--dirstat-by-file= --cumulative
 			--diff-algorithm=
 			--submodule --submodule=
+			--indent-heuristic --no-indent-heuristic
+			--textconv --no-textconv
 "
 
 _git_diff ()
@@ -1752,6 +1754,10 @@ _git_log ()
 		__gitcomp "$__git_diff_submodule_formats" "" "${cur##--submodule=}"
 		return
 		;;
+	--no-walk=*)
+		__gitcomp "sorted unsorted" "" "${cur##--no-walk=}"
+		return
+		;;
 	--*)
 		__gitcomp "
 			$__git_log_common_options
@@ -1759,16 +1765,19 @@ _git_log ()
 			$__git_log_gitk_options
 			--root --topo-order --date-order --reverse
 			--follow --full-diff
-			--abbrev-commit --abbrev=
+			--abbrev-commit --no-abbrev-commit --abbrev=
 			--relative-date --date=
 			--pretty= --format= --oneline
 			--show-signature
 			--cherry-mark
 			--cherry-pick
 			--graph
-			--decorate --decorate=
+			--decorate --decorate= --no-decorate
 			--walk-reflogs
+			--no-walk --no-walk= --do-walk
 			--parents --children
+			--expand-tabs --expand-tabs= --no-expand-tabs
+			--patch
 			$merge
 			$__git_diff_common_options
 			--pickaxe-all --pickaxe-regex
@@ -2816,8 +2825,9 @@ _git_show ()
 		return
 		;;
 	--*)
-		__gitcomp "--pretty= --format= --abbrev-commit --oneline
-			--show-signature
+		__gitcomp "--pretty= --format= --abbrev-commit --no-abbrev-commit
+			--oneline --show-signature --patch
+			--expand-tabs --expand-tabs= --no-expand-tabs
 			$__git_diff_common_options
 			"
 		return

--
https://github.com/git/git/pull/426
