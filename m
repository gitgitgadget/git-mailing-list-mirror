From: David Aguilar <davvid@gmail.com>
Subject: [PATCH v2] t7800-difftool.sh: Test mergetool.prompt fallback
Date: Fri, 22 Jan 2010 22:03:36 -0800
Message-ID: <1264226616-19019-1-git-send-email-davvid@gmail.com>
Cc: sschuberth@gmail.com, git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 23 07:03:49 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NYZ64-0006yG-Gk
	for gcvg-git-2@lo.gmane.org; Sat, 23 Jan 2010 07:03:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753820Ab0AWGDp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Jan 2010 01:03:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463Ab0AWGDp
	(ORCPT <rfc822;git-outgoing>); Sat, 23 Jan 2010 01:03:45 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:42112 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752617Ab0AWGDo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Jan 2010 01:03:44 -0500
Received: by ywh6 with SMTP id 6so1683589ywh.4
        for <git@vger.kernel.org>; Fri, 22 Jan 2010 22:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XJSQ9234zq9nBwYmfrCFpbc2kYjA6hyNH3Navv+EUEI=;
        b=D7CySH1tr9ulRSJXeMJXzqOc1dts83C6xKgqCaXR7XHEWwiSb2GeBzrNaWUQWRv6ow
         G/wYtYpPSCob8gd48QpWWDngLw2vWPG4odQ8dY5Meh8ZlL6McVacfsTlL7VaYs2VNdKV
         kS42RaXykHU1r3F9V5BsQMvPAvLuHdG3tv/BU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=k+0IxuqJHJw/QXj09/Heug7IpCGr9tdtbi0v1K8eYAwGjyuA3mhK69t2wmeLNsLzEz
         5lPE1AlxGh3IJ+gYCeq2HG3A7hTrFYGNRsViTQReiMssuwO/J9bWXSHiNo8pOBk46qfh
         zJ5NDw43JwVEncSoLz2TSkL8p3bz+JtgYEnZ0=
Received: by 10.150.117.25 with SMTP id p25mr5363597ybc.139.1264226622986;
        Fri, 22 Jan 2010 22:03:42 -0800 (PST)
Received: from localhost (208-106-56-2.static.dsltransport.net [208.106.56.2])
        by mx.google.com with ESMTPS id 22sm1074603ywh.0.2010.01.22.22.03.41
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 22 Jan 2010 22:03:42 -0800 (PST)
X-Mailer: git-send-email 1.6.6.1.436.gaba7d.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137811>

4cacc621 made difftool fall back to mergetool.prompt
when difftool.prompt is unconfigured.  This adds a test.

Signed-off-by: David Aguilar <davvid@gmail.com>
---

Oops, the last one had a typo in the test string.

 t/t7800-difftool.sh |   12 ++++++++++++
 1 files changed, 12 insertions(+), 0 deletions(-)

diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index fad5472..19c72f5 100755
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
+test_expect_success 'difftool merge.prompt = false' '
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
