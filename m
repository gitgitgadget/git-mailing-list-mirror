From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] t7800-difftool.sh: Test mergetool.prompt fallback
Date: Fri, 22 Jan 2010 21:58:00 -0800
Message-ID: <1264226280-18888-1-git-send-email-davvid@gmail.com>
Cc: git@vger.kernel.org, sschuberth@gmail.com
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 23 06:58:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYZ0h-0005mq-KJ
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 06:58:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752195Ab0AWF6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 00:58:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897Ab0AWF6K
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 00:58:10 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:53159 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750789Ab0AWF6J (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 00:58:09 -0500
Received: by yxe17 with SMTP id 17so1625804yxe.33
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 21:58:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=d4a1G+PI5Nru7s4h8VdRevjFZdfWVr4o0J5OZOGANiY=;
        b=Uj73j5uzAwGdcvtt9BsldnoYTVvqGMWISW7UGzmHlULou+6wOEv28dvnTKkOUuuK5K
         qV0H8IGhFCWmJR1dXPe22JXx1iirYFUkHBRz703ZaVDl+QEAMBQdu+bKIxCkNxh7/b5q
         Pgt7mBzKCXS2zEebvoifFhpRiWZ2vWu6s4HxE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=fgNjvnuzS5RHRN5cEEHunYmm0P/CjyYoYaLUhVgkfAhcIhmRytiT8HmyUjmouvJoCY
         nDd5XwP0Qqm/IWlPyx0atJhIWEQdHQAAsDgXC6l8WLeNBtUVp/sh8N0Q1dc/4cUraTFu
         dxixhD1H9tDqQYmIvXprd5+uqRHNC3QcuwVVE=
Received: by 10.101.132.14 with SMTP id j14mr5118277ann.58.1264226287653;
        Fri, 22 Jan 2010 21:58:07 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 9sm1062521ywe.56.2010.01.22.21.58.06
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 21:58:07 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.436.gaba7d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137810>

4cacc621 made difftool fall back to mergetool.prompt
when difftool.prompt is unconfigured.  This adds a test.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 t/t7800-difftool.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index fad5472..a16bfa0 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -27,6 +27,7 @@ remove_config_vars()
 	git config --unset difftool.prompt
 	git config --unset merge.tool
 	git config --unset mergetool.test-tool.cmd
+	git config --unset mergetool.prompt
 	return 0
 }
 
@@ -159,6 +160,17 @@ test_expect_success 'difftool.prompt config variable is false' '
 	restore_test_defaults
 '
 
+# Test that we don't have to pass --no-prompt when mergetool.prompt is false
+test_expect_success 'difftool merge.promptconfig = false' '
+	git config --unset difftool.prompt
+	git config mergetool.prompt false &&
+
+	diff=$(git difftool branch) &&
+	test "$diff" = "branch" &&
+
+	restore_test_defaults
+'
+
 # Test that the -y flag can override difftool.prompt = true
 test_expect_success 'difftool.prompt can overridden with -y' '
 	git config difftool.prompt true &&
-- 
1.6.6.1.436.gaba7d.dirty
