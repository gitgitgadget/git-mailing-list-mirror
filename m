From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v4 13/10] test: remote-helper: add test for force pushes
Date: Sun, 27 Oct 2013 17:16:29 -0400
Message-ID: <1382908589-7000-2-git-send-email-rhansen@bbn.com>
References: <1382857521-7005-1-git-send-email-felipe.contreras@gmail.com>
 <1382908589-7000-1-git-send-email-rhansen@bbn.com>
Cc: srabbelier@gmail.com, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 27 22:17:01 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VaXhk-0007Il-Ol
	for gcvg-git-2@plane.gmane.org; Sun, 27 Oct 2013 22:17:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754649Ab3J0VQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Oct 2013 17:16:57 -0400
Received: from smtp.bbn.com ([128.33.1.81]:18235 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754350Ab3J0VQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Oct 2013 17:16:56 -0400
Received: from socket.bbn.com ([192.1.120.102]:44178)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1VaXhe-000ABR-Cs; Sun, 27 Oct 2013 17:16:54 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 9EB3A4007B
X-Mailer: git-send-email 1.8.4.1.614.ga09cf56
In-Reply-To: <1382908589-7000-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236812>

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 t/t5801-remote-helpers.sh | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index be543c0..93a7d34 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -102,6 +102,19 @@ test_expect_success 'push delete branch' '
 	 rev-parse --verify refs/heads/new-name
 '
 
+test_expect_success 'force push' '
+	(cd local &&
+	 git checkout -b force-test &&
+	 echo content >>file &&
+	 git commit -a -m eight &&
+	 git push origin force-test &&
+	 echo content >>file &&
+	 git commit -a --amend -m eight-modified &&
+	 git push --force origin force-test
+	) &&
+	compare_refs local refs/heads/force-test server refs/heads/force-test
+'
+
 test_expect_success 'cloning without refspec' '
 	GIT_REMOTE_TESTGIT_REFSPEC="" \
 	git clone "testgit::${PWD}/server" local2 2>error &&
-- 
1.8.4.1.614.ga09cf56
