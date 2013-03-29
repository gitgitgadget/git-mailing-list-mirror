From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 1/5] t7800: move '--symlinks' specific test to the end
Date: Fri, 29 Mar 2013 11:28:32 +0000
Message-ID: <279dbdc3072772961ce28a90ffa0a7d8df017ffe.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Matt McClure <matthewlmcclure@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	David Aguilar <davvid@gmail.com>,
	Sitaram Chamarty <sitaramc@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 29 12:29:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULXV3-00084l-Hk
	for gcvg-git-2@plane.gmane.org; Fri, 29 Mar 2013 12:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754538Ab3C2L3J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Mar 2013 07:29:09 -0400
Received: from coyote.aluminati.org ([72.9.247.114]:49787 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754271Ab3C2L3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Mar 2013 07:29:07 -0400
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id F3B496064CA;
	Fri, 29 Mar 2013 11:29:06 +0000 (GMT)
X-Quarantine-ID: <crORhYgmXM9V>
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.899
X-Spam-Level: 
X-Spam-Status: No, score=-12.899 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9,
	URIBL_BLOCKED=0.001] autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id crORhYgmXM9V; Fri, 29 Mar 2013 11:29:06 +0000 (GMT)
Received: from river.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 1A72C606500;
	Fri, 29 Mar 2013 11:28:53 +0000 (GMT)
X-Mailer: git-send-email 1.8.2.411.g65a544e
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
In-Reply-To: <cover.1364555970.git.john@keeping.me.uk>
References: <cover.1364555970.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219490>

This will group the tests more logically when we introduce a helper to
run most --dir-diff tests with both --symlinks and --no-symlinks.

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 t/t7800-difftool.sh | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index c6d6b1c..e6a16cd 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -340,6 +340,21 @@ test_expect_success PERL 'difftool --dir-diff' '
 	stdin_contains file <output
 '
 
+test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
+	git difftool --dir-diff --prompt --extcmd ls branch >output &&
+	stdin_contains sub <output &&
+	stdin_contains file <output
+'
+
+test_expect_success PERL 'difftool --dir-diff from subdirectory' '
+	(
+		cd sub &&
+		git difftool --dir-diff --extcmd ls branch >output &&
+		stdin_contains sub <output &&
+		stdin_contains file <output
+	)
+'
+
 write_script .git/CHECK_SYMLINKS <<\EOF
 for f in file file2 sub/sub
 do
@@ -362,19 +377,4 @@ test_expect_success PERL,SYMLINKS 'difftool --dir-diff --symlink without unstage
 	test_cmp actual expect
 '
 
-test_expect_success PERL 'difftool --dir-diff ignores --prompt' '
-	git difftool --dir-diff --prompt --extcmd ls branch >output &&
-	stdin_contains sub <output &&
-	stdin_contains file <output
-'
-
-test_expect_success PERL 'difftool --dir-diff from subdirectory' '
-	(
-		cd sub &&
-		git difftool --dir-diff --extcmd ls branch >output &&
-		stdin_contains sub <output &&
-		stdin_contains file <output
-	)
-'
-
 test_done
-- 
1.8.2.411.g65a544e
