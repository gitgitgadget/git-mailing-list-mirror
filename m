Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DCFB1F461
	for <e@80x24.org>; Tue,  2 Jul 2019 01:56:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfGBB42 (ORCPT <rfc822;e@80x24.org>);
        Mon, 1 Jul 2019 21:56:28 -0400
Received: from a7-12.smtp-out.eu-west-1.amazonses.com ([54.240.7.12]:34880
        "EHLO a7-12.smtp-out.eu-west-1.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726781AbfGBB42 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Jul 2019 21:56:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=ihchhvubuqgjsxyuhssfvqohv7z3u4hn; d=amazonses.com; t=1562032586;
        h=From:To:Message-ID:In-Reply-To:References:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Date:Feedback-ID;
        bh=UYeNMt0snQKirpJFz22VYLQ5fMeGgpkWsj+L1CTQNA0=;
        b=WzLNYgmKjW1HZkBXB1Efqxvi5oIgOrbBn9Jvklo7TYdz+XaDPj/0vQYSBw8Y0MwS
        OdBU+FNscUIEZouEBo5CXsBG8HZDXruwRLsViSyyor4OFzB2EPgDuudACdK97lzYiTO
        bJ46x0kEr3jsNR+IFAHrtF4GPmSvvRYT8RzuNxPY=
From:   Max Rothman <max.r.rothman@gmail.com>
To:     git@vger.kernel.org
Message-ID: <0102016bb065bf5e-005b0752-2594-45d5-a01a-12d0c5e24b70-000000@eu-west-1.amazonses.com>
In-Reply-To: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
References: <0102015f985d387e-f50183c4-4b49-4a9f-b365-2a86ba24bbed-000000@eu-west-1.amazonses.com>
Subject: [PATCH] completion: add missing completions for log, diff, show
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Date:   Tue, 2 Jul 2019 01:56:26 +0000
X-SES-Outgoing: 2019.07.02-54.240.7.12
Feedback-ID: 1.eu-west-1.YYPRFFOog89kHDDPKvTu4MK67j4wW0z7cAgZtFqQH58=:AmazonSES
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The bash completion script knows some options to "git log" and
"git show" only in the positive form, (e.g. "--abbrev-commit"), but not
in their negative form (e.g. "--no-abbrev-commit"). Add them.

Also, the bash completion script is missing some other options to
"git diff", and "git show" (and thus, all other commands that take
"git diff"'s options). Add them. Of note, since "--indent-heuristic" is
no longer experimental, add that too.

Signed-off-by: Max Rothman <max.r.rothman@gmail.com>
---
 contrib/completion/git-completion.bash | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 9f71bcde967bc..b6d18710135ec 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -1474,6 +1474,8 @@ __git_diff_common_options="--stat --numstat --shortstat --summary
 			--dirstat-by-file= --cumulative
 			--diff-algorithm=
 			--submodule --submodule= --ignore-submodules
+			--indent-heuristic --no-indent-heuristic
+			--textconv --no-textconv
 "
 
 _git_diff ()
@@ -1782,6 +1784,10 @@ _git_log ()
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
@@ -1789,16 +1795,19 @@ _git_log ()
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
@@ -2525,8 +2534,9 @@ _git_show ()
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
