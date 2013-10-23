From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 03/15] t5510: check that "git fetch --prune --tags" does not prune branches
Date: Wed, 23 Oct 2013 17:50:36 +0200
Message-ID: <1382543448-2586-4-git-send-email-mhagger@alum.mit.edu>
References: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 23 17:59:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZ0pv-0006py-Hp
	for gcvg-git-2@plane.gmane.org; Wed, 23 Oct 2013 17:59:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752709Ab3JWP7D (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Oct 2013 11:59:03 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:55933 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752703Ab3JWP7A (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 23 Oct 2013 11:59:00 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 23 Oct 2013 11:59:00 EDT
X-AuditID: 12074411-b7f426d000005455-a6-5267f09a88dc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.3E.21589.A90F7625; Wed, 23 Oct 2013 11:51:54 -0400 (EDT)
Received: from localhost.localdomain (p57A247B5.dip0.t-ipconnect.de [87.162.71.181])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9NFpLsu009100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 23 Oct 2013 11:51:52 -0400
X-Mailer: git-send-email 1.8.4
In-Reply-To: <1382543448-2586-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrGIsWRmVeSWpSXmKPExsUixO6iqDvrQ3qQwblFphbTu1azWHRd6Way
	aOi9wmwx7+4uJotVt5YxW6yccYPR4vaK+cwWTzsrLea9eMFm8aOlh9mBy+Pv+w9MHpfWvWTy
	OPRnCrvHsxPtbB6XXn5n83jWu4fR4+IlZY8ZLa9ZPD5vkvM4cPkxWwBXFLdNUmJJWXBmep6+
	XQJ3xuPlR9kK5nJX7Py/hL2BsZ+zi5GTQ0LARGLluu+MELaYxIV769m6GLk4hAQuM0oc//iH
	BcK5wiRx9OQUdpAqNgFdiUU9zUwgtoiAmsTEtkNgRcwCE5kljk9fxAKSEBaIlmj4cR9oLAcH
	i4CqxIcNlSAmr4CzRM/zRBBTQkBO4uG3WJBiTgEXiQvHp7OC2EJAFRMWTmWfwMi7gJFhFaNc
	Yk5prm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIyAruYJxxUu4QowAHoxIP78OWtCAh
	1sSy4srcQ4ySHExKorxz3qUHCfEl5adUZiQWZ8QXleakFh9ilOBgVhLh3XEXKMebklhZlVqU
	D5OS5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuBteg/UKFiUmp5akZaZU4KQZuLgBBFc
	IBt4gDbEgBTyFhck5hZnpkMUnWJUlBLnbQBJCIAkMkrz4AbAkssrRnGgf4R5E0GqeICJCa77
	FdBgJqDBU5akgQwuSURISTUwmnS7tB0+tYHr7MYdEaZzJ3FUaZZb7nq/WHT91f+Jl1adrU3M
	mH3ZeaaHqkxY0Yp5G9qPJvcqzFeYPGvv/7bDGza835/zLyi6bJaUrp/LwWmXy+UZ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236523>

"git fetch --prune --tags" is currently interpreted as follows:

* "--tags" is equivalent to specifying a refspec
  "refs/tags/*:refs/tags/*", and supersedes any default refspecs
  configured via remote.$REMOTE.fetch.

* "--prune" only operates on the refspecs being fetched.

Therefore, "git fetch --prune --tags" prunes tags in refs/tags/* but
does not fetch or prune other references.  The fact that this command
does not prune references outside of refs/tags/* was previously
untested.  So add a test that verifies the status quo.

However, the status quo is surprising, so it will be changed later in
this patch series.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 t/t5510-fetch.sh | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 08d8dbb..8328be1 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -118,9 +118,13 @@ test_expect_success 'fetch --prune --tags does not delete the remote-tracking br
 	git clone . prune-tags &&
 	cd prune-tags &&
 	git tag sometag master &&
+	# Create what looks like a remote-tracking branch from an earlier
+	# fetch that has since been deleted from the remote:
+	git update-ref refs/remotes/origin/fake-remote master &&
 
 	git fetch --prune --tags origin &&
 	git rev-parse origin/master &&
+	git rev-parse origin/fake-remote &&
 	test_must_fail git rev-parse sometag
 '
 
-- 
1.8.4
