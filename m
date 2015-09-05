From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 4/5] t7800: don't use test_config in a subshell
Date: Sat,  5 Sep 2015 14:12:48 +0100
Message-ID: <5aa306f56f544de4f71be98f66b912b72336835f.1441458341.git.john@keeping.me.uk>
References: <20150905085429.GB25039@sigill.intra.peff.net>
 <cover.1441458341.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 05 15:14:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYDI8-0000EV-Ur
	for gcvg-git-2@plane.gmane.org; Sat, 05 Sep 2015 15:14:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752082AbbIENN6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Sep 2015 09:13:58 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:37806 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbbIENN5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Sep 2015 09:13:57 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id B21EFCDA46B;
	Sat,  5 Sep 2015 14:13:56 +0100 (BST)
X-Quarantine-ID: <WtMnylCGtqrn>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-0.199 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_50=0.8, URIBL_BLOCKED=0.001] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id WtMnylCGtqrn; Sat,  5 Sep 2015 14:13:56 +0100 (BST)
Received: from river.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id 4F9A2CDA603;
	Sat,  5 Sep 2015 14:13:39 +0100 (BST)
X-Mailer: git-send-email 2.5.0.466.g9af26fa
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
In-Reply-To: <cover.1441458341.git.john@keeping.me.uk>
References: <cover.1441458341.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277373>

Use the new "-C" option to test_config to change the configuration in
the submodule from the top level of the test so that it can be unset
correctly when the test finishes.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7800-difftool.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ea35a02..48c6e2b 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -492,12 +492,12 @@ test_expect_success PERL 'difftool --no-symlinks detects conflict ' '
 
 test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
 	git submodule add ./. submod/ule &&
+	test_config -C submod/ule diff.tool checktrees &&
+	test_config -C submod/ule difftool.checktrees.cmd '\''
+		test -d "$LOCAL" && test -d "$REMOTE" && echo good
+		'\'' &&
 	(
 		cd submod/ule &&
-		test_config diff.tool checktrees &&
-		test_config difftool.checktrees.cmd '\''
-			test -d "$LOCAL" && test -d "$REMOTE" && echo good
-		'\'' &&
 		echo good >expect &&
 		git difftool --tool=checktrees --dir-diff HEAD~ >actual &&
 		test_cmp expect actual
-- 
2.5.0.466.g9af26fa
