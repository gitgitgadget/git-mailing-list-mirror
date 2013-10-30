From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 03/23] t5510: check that "git fetch --prune --tags" does not prune branches
Date: Wed, 30 Oct 2013 06:32:52 +0100
Message-ID: <1383111192-23780-4-git-send-email-mhagger@alum.mit.edu>
References: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org,
	=?UTF-8?q?Carlos=20Mart=C3=ADn=20Nieto?= <cmn@elego.de>,
	Michael Schubert <mschub@elegosoft.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Marc Branchaud <marcnarc@xiplink.com>,
	Nicolas Pitre <nico@fluxnic.net>,
	John Szakmeister <john@szakmeister.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 06:41:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VbOWi-0007Fu-0Q
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 06:41:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752577Ab3J3FlC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 01:41:02 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:48305 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750757Ab3J3FlA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 30 Oct 2013 01:41:00 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Wed, 30 Oct 2013 01:40:59 EDT
X-AuditID: 1207440e-b7fbc6d000004ad9-c6-52709a457e50
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 5C.0E.19161.54A90725; Wed, 30 Oct 2013 01:33:57 -0400 (EDT)
Received: from localhost.localdomain (p57A242F8.dip0.t-ipconnect.de [87.162.66.248])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r9U5XbIE014009
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 30 Oct 2013 01:33:55 -0400
X-Mailer: git-send-email 1.8.4.1
In-Reply-To: <1383111192-23780-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBIsWRmVeSWpSXmKPExsUixO6iqOs6qyDI4OU3S4vpXatZLLqudDNZ
	NPReYbaYd3cXk8WqW8uYLVbOuMFocXvFfGaLp52VFvNevGCz+NHSw+zA5fH3/Qcmj0vrXjJ5
	HPozhd3j2Yl2No9LL7+zeTzr3cPocfGSsseMltcsHp83yXkcuPyYLYAritsmKbGkLDgzPU/f
	LoE7Y8uCp2wF87krHh49y9TAOJGzi5GDQ0LAROLpWb4uRk4gU0ziwr31bF2MXBxCApcZJVb0
	NEM5V5gkPjwHcTg52AR0JRb1NDOB2CICahIT2w6xgBQxC0xkljg+fRELSEJYIE5iy4WLYA0s
	AqoS7zduBYvzCrhILLo/jRlinYLEjeaprCA2p4CrxKddN9lBbCGgmqb2z+wTGHkXMDKsYpRL
	zCnN1c1NzMwpTk3WLU5OzMtLLdI11svNLNFLTSndxAgJW74djO3rZQ4xCnAwKvHwGjzIDxJi
	TSwrrsw9xCjJwaQkyps2pSBIiC8pP6UyI7E4I76oNCe1+BCjBAezkgjv9ONA5bwpiZVVqUX5
	MClpDhYlcV61Jep+QgLpiSWp2ampBalFMFkZDg4lCV7lmUBDBYtS01Mr0jJzShDSTBycIIIL
	ZAMP0AYekELe4oLE3OLMdIiiU4yKUuK8SSAJAZBERmke3ABYgnnFKA70jzBEOw8wOcF1vwIa
	zAQ0eA9LHsjgkkSElFQDo+K5R7KTWrOyDu5ZcXzb5J2J/ya/uSi16ffJup8r1raomLmXPHAU
	CTi1yfyQRlimxK7IC0m+zYJsi9dvPS3/XS2e+79OvO2cv+fYBM7UFUU135Tw/HE4 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236966>

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
1.8.4.1
