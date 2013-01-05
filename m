From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 03/10] t5516: do not assume the "matching" push is the
 default
Date: Fri,  4 Jan 2013 22:53:01 -0800
Message-ID: <1357368788-28035-4-git-send-email-gitster@pobox.com>
References: <1357368788-28035-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 05 07:53:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TrNdW-0000vb-Mz
	for gcvg-git-2@plane.gmane.org; Sat, 05 Jan 2013 07:53:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753982Ab3AEGxT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 01:53:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752799Ab3AEGxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 01:53:16 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C718CD6
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:16 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=Gisa
	D8hFPd+cpELZL67tyjO+UXU=; b=vi1O/3FmU9UvwoNEvwegDRilwAhaZk3ME/27
	vD5t1qHmM3EBUslun9dIdeMmorFcqGF7DSNrfmnpoBuXMiW8wJs1KvmT/yDBBejS
	MbMY9ZnjAoZnNFFXQMzRkP3q2Ca1qkXjwG1fLhecjzCUjkZCpOIL8duP/1sCW2BF
	v/V9Imo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=RSv+4W
	VxXGs59LIhqggr2VXGJD+v81tk4rikqcfpQEX9nrBmuDd3TLc8PMKTs3JMsGL4sG
	BenI4Tm5qR57q7cEmKDoqy8dccQkJ1eh/6nwp4fUNVXKFgQOfJZoEyicbYnYSSrf
	ND4Qx35wxEjX6OKbBCUZ+U+0V2hq4U3JDq6a0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 478628CD5
	for <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:16 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C0BC88CD3 for
 <git@vger.kernel.org>; Sat,  5 Jan 2013 01:53:15 -0500 (EST)
X-Mailer: git-send-email 1.8.1.299.gc73b41f
In-Reply-To: <1357368788-28035-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 9487EC08-5704-11E2-B73A-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212672>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 t/t5516-fetch-push.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
index b5417cc..1a8753d 100755
--- a/t/t5516-fetch-push.sh
+++ b/t/t5516-fetch-push.sh
@@ -247,7 +247,7 @@ test_expect_success 'push with pushInsteadOf and explicit pushurl (pushInsteadOf
 test_expect_success 'push with matching heads' '
 
 	mk_test heads/master &&
-	git push testrepo &&
+	git push testrepo : &&
 	check_push_result $the_commit heads/master
 
 '
@@ -276,7 +276,7 @@ test_expect_success 'push --force with matching heads' '
 	mk_test heads/master &&
 	git push testrepo : &&
 	git commit --amend -massaged &&
-	git push --force testrepo &&
+	git push --force testrepo : &&
 	! check_push_result $the_commit heads/master &&
 	git reset --hard $the_commit
 
@@ -507,7 +507,7 @@ test_expect_success 'push with config remote.*.pushurl' '
 	git checkout master &&
 	git config remote.there.url test2repo &&
 	git config remote.there.pushurl testrepo &&
-	git push there &&
+	git push there : &&
 	check_push_result $the_commit heads/master
 '
 
@@ -521,7 +521,7 @@ test_expect_success 'push with dry-run' '
 		cd testrepo &&
 		old_commit=$(git show-ref -s --verify refs/heads/master)
 	) &&
-	git push --dry-run testrepo &&
+	git push --dry-run testrepo : &&
 	check_push_result $old_commit heads/master
 '
 
@@ -981,7 +981,7 @@ test_expect_success 'push --porcelain --dry-run rejected' '
 
 test_expect_success 'push --prune' '
 	mk_test heads/master heads/second heads/foo heads/bar &&
-	git push --prune testrepo &&
+	git push --prune testrepo : &&
 	check_push_result $the_commit heads/master &&
 	check_push_result $the_first_commit heads/second &&
 	! check_push_result $the_first_commit heads/foo heads/bar
-- 
1.8.1.299.gc73b41f
