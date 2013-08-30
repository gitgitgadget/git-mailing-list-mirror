From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 24/28] prompt: parse cherry-pick rebase mode
Date: Fri, 30 Aug 2013 00:56:18 -0500
Message-ID: <1377842182-18724-25-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHme-0007iQ-Gk
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755961Ab3H3GCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:02:04 -0400
Received: from mail-oa0-f52.google.com ([209.85.219.52]:33802 "EHLO
	mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GCC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:02:02 -0400
Received: by mail-oa0-f52.google.com with SMTP id f4so1799005oah.11
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=x4K+Kug02NI+JdNI+LxosUQNFQdKVWwiClZ4iulEnuE=;
        b=vyyZVRylgC7cVGD8mWVD520Je6w2Ly16HKq0iXXkGRkxMbkC1jsGzIT+qxjZ1/bo73
         GN0I46mxSKZw+i5G0S8kQQbiz6F0LN2ftmtWcYi4uhlfSg1oHCqkVBmpfz2lqnf+49aA
         LPceL0nzr6bW2+bGvJHutupxFmrrk7ftpPd3x8y+uqZQmTQ/Eh8TTSP1vpvrX5mOT/3/
         0RYWdO3WNbOke6rk4g40ZEJlqtKamXS2QkihbPrCXNcjFPrQaMyuJyUMJ+aB759Q7bst
         LmE+XiOSwogx1C4xPjksGJLp2Ajr/Ow6QxH0sxiJUqf1HRNGtyfUkkSNERzFKsQgvHfn
         mPLA==
X-Received: by 10.182.226.199 with SMTP id ru7mr5537300obc.12.1377842521778;
        Thu, 29 Aug 2013 23:02:01 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s14sm36896271oeo.1.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:02:00 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233419>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/completion/git-prompt.sh | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
index a81ef5a..a7bde16 100644
--- a/contrib/completion/git-prompt.sh
+++ b/contrib/completion/git-prompt.sh
@@ -313,12 +313,18 @@ __git_ps1 ()
 	local total=""
 	if [ -d "$g/rebase-merge" ]; then
 		read b 2>/dev/null <"$g/rebase-merge/head-name"
-		read step 2>/dev/null <"$g/rebase-merge/msgnum"
-		read total 2>/dev/null <"$g/rebase-merge/end"
-		if [ -f "$g/rebase-merge/interactive" ]; then
-			r="|REBASE-i"
+		if [ -f "$g/rebase-merge/cherrypick" ]; then
+			read total 2>/dev/null <"$g/sequencer/total"
+			read step 2>/dev/null <"$g/sequencer/step"
+			r="|REBASE"
 		else
-			r="|REBASE-m"
+			read step 2>/dev/null <"$g/rebase-merge/msgnum"
+			read total 2>/dev/null <"$g/rebase-merge/end"
+			if [ -f "$g/rebase-merge/interactive" ]; then
+				r="|REBASE-i"
+			else
+				r="|REBASE-m"
+			fi
 		fi
 	else
 		if [ -d "$g/rebase-apply" ]; then
-- 
1.8.4-fc
