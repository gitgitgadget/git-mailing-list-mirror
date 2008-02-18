From: Jay Soffian <jaysoffian@gmail.com>
Subject: [PATCH] test cases: optionally setup branch.*.merge from upstream local branches
Date: Mon, 18 Feb 2008 10:07:25 -0500
Message-ID: <1203347245-23533-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 18 16:09:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JR7bM-0006o6-Vd
	for gcvg-git-2@gmane.org; Mon, 18 Feb 2008 16:08:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752734AbYBRPHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Feb 2008 10:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752754AbYBRPHj
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Feb 2008 10:07:39 -0500
Received: from hs-out-0708.google.com ([64.233.178.243]:6015 "EHLO
	hs-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388AbYBRPHi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Feb 2008 10:07:38 -0500
Received: by hs-out-0708.google.com with SMTP id 54so1421611hsz.5
        for <git@vger.kernel.org>; Mon, 18 Feb 2008 07:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=u0xi4otuPkiw/Xzv6OThhKZoHniPFxXBKL8ujX+g0Tk=;
        b=PBXH6GlX0ZlyFaArofKBZrKEL/pK9yvpDCLjKtllC2IqYrYoTOPW7HZFHeax/4r1DspLfdt29DYxWi9WMfDTEzX/nreDDBVCuLRMtcxO79MPGq2XsLu8q97c0j568C69TmlUzvrTMBBCSv5UUts4DES5EOYNDzgrbHqP5LC7lKI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=dfBml0H47z+ghHbGGYz/jWayKcnv4Nxt2PQbN4bUFJlsXMf9yRBkDi2lxfm0o1ZnZIq5ezi21vcUPySyYHTIpfXfbRVuGWWMwjCJ1ybR9Xm06W+l5P2SFh8zcOx2Xq3/l1X+c87b1mfmtgnpXHs57bZr+CXdMhvIwmqP51mSntE=
Received: by 10.100.38.3 with SMTP id l3mr11665630anl.15.1203347248809;
        Mon, 18 Feb 2008 07:07:28 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id d35sm13633547and.3.2008.02.18.07.07.27
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 18 Feb 2008 07:07:28 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.203.gf8d86
In-Reply-To: 1203342817-19653-1-git-send-email-jaysoffian@gmail.com
References: 1203342817-19653-1-git-send-email-jaysoffian@gmail.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74302>

Added test cases for new "optionally setup branch.*.merge from upstream local
branches" functionality.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
 t/t3200-branch.sh |   21 +++++++++++++++++++--
 1 files changed, 19 insertions(+), 2 deletions(-)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index d21081d..8d1dccd 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -161,7 +161,7 @@ test_expect_success 'avoid ambiguous track' '
 '
 
 test_expect_success 'test overriding tracking setup via --no-track' \
-    'git config branch.autosetupmerge true &&
+    'git config branch.autosetupmerge always &&
      git config remote.local.url . &&
      git config remote.local.fetch refs/heads/*:refs/remotes/local/* &&
      (git show-ref -q refs/remotes/local/master || git-fetch local) &&
@@ -171,7 +171,9 @@ test_expect_success 'test overriding tracking setup via --no-track' \
      ! test "$(git config branch.my2.merge)" = refs/heads/master'
 
 test_expect_success 'no tracking without .fetch entries' \
-    'git branch --track my6 s &&
+    'git config branch.autosetupmerge true &&
+     git branch my6 s &&
+     git config branch.automsetupmerge false &&
      test -z "$(git config branch.my6.remote)" &&
      test -z "$(git config branch.my6.merge)"'
 
@@ -192,6 +194,21 @@ test_expect_success 'test deleting branch without config' \
     'git branch my7 s &&
      test "$(git branch -d my7 2>&1)" = "Deleted branch my7."'
 
+test_expect_success 'test tracking without .fetch entries w/--track given' \
+    'git branch --track my8 &&
+     test "$(git config branch.my8.remote)" &&
+     test "$(git config branch.my8.merge)"'
+
+test_expect_success \
+    'test tracking without .fetch entries w/autosetupmerge=always' \
+    'git config branch.autosetupmerge always &&
+     git branch --track my9 &&
+     git config branch.autosetupmerge false
+     test "$(git config branch.my9.remote)" &&
+     test "$(git config branch.my9.merge)"'
+
+
+
 # Keep this test last, as it changes the current branch
 cat >expect <<EOF
 0000000000000000000000000000000000000000 $HEAD $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> 1117150200 +0000	branch: Created from master
-- 
1.5.4.2.203.gf8d86
