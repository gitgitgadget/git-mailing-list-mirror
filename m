From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Add new testcase to show fast-export does not always exports all tags
Date: Sat, 22 Nov 2008 19:22:48 +0100
Message-ID: <1227378168-14992-1-git-send-email-vmiklos@frugalware.org>
References: <20081122022913.GC4746@genesis.frugalware.org>
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Nov 22 19:23:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L3x8y-0006cI-0E
	for gcvg-git-2@gmane.org; Sat, 22 Nov 2008 19:23:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758759AbYKVSVg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Nov 2008 13:21:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758751AbYKVSVg
	(ORCPT <rfc822;git-outgoing>); Sat, 22 Nov 2008 13:21:36 -0500
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:41355 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758735AbYKVSVg (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Nov 2008 13:21:36 -0500
Received: from vmobile.example.net (dsl5401CBB3.pool.t-online.hu [84.1.203.179])
	by yugo.frugalware.org (Postfix) with ESMTPA id 59839446CCF;
	Sat, 22 Nov 2008 19:21:33 +0100 (CET)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 2C97319D92A; Sat, 22 Nov 2008 19:22:48 +0100 (CET)
X-Mailer: git-send-email 1.6.0.4.770.gf38d.dirty
In-Reply-To: <20081122022913.GC4746@genesis.frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101555>

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Here is a testcase for the bug I mentioned.

 t/t9301-fast-export.sh |   11 +++++++++++
 1 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/t/t9301-fast-export.sh b/t/t9301-fast-export.sh
index 6ddd7c1..078832f 100755
--- a/t/t9301-fast-export.sh
+++ b/t/t9301-fast-export.sh
@@ -231,4 +231,15 @@ test_expect_success 'fast-export -C -C | fast-import' '
 
 '
 
+test_expect_failure 'fast-export | fast-import when master is tagged' '
+
+	git tag -m msg last &&
+	rm -rf new &&
+	mkdir new &&
+	git --git-dir=new/.git init &&
+	git fast-export -C -C --signed-tags=strip --all > output &&
+	test $(grep -c "^tag" output) = 3
+
+'
+
 test_done
-- 
1.6.0.4.770.gf38d.dirty
