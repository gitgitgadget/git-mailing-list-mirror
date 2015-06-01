From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 1/3] t6301: new tests of for-each-ref error handling
Date: Mon,  1 Jun 2015 17:53:49 +0200
Message-ID: <1433174031-5471-2-git-send-email-mhagger@alum.mit.edu>
References: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
Cc: Anders Kaseorg <andersk@mit.edu>,
	Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 01 17:54:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzS2W-0002ne-Kx
	for gcvg-git-2@plane.gmane.org; Mon, 01 Jun 2015 17:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753720AbbFAPyH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 11:54:07 -0400
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:48709 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753733AbbFAPyD (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 1 Jun 2015 11:54:03 -0400
X-AuditID: 1207440d-f79026d000000bad-43-556c80171446
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 15.1F.02989.7108C655; Mon,  1 Jun 2015 11:53:59 -0400 (EDT)
Received: from michael.fritz.box (p4FC96750.dip0.t-ipconnect.de [79.201.103.80])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t51FrsEo010505
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Mon, 1 Jun 2015 11:53:58 -0400
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1433174031-5471-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrHIsWRmVeSWpSXmKPExsUixO6iqCvekBNq8Pgwj8WZvnCLrivdTBYN
	vVeYLW6vmM9s8aOlh9li8+Z2Fgc2j7/vPzB5LNhU6tF05iizx7PePYweFy8pe3zeJBfAFsVt
	k5RYUhacmZ6nb5fAnbGiSbygSaji/dwlzA2MP/i6GDk5JARMJHqWHGGCsMUkLtxbz9bFyMUh
	JHCZUeLMxJnMEM5xJonFz1YyglSxCehKLOppBusQEVCTmNh2iAXEZhbYzCjR+TCoi5GDQ1jA
	RWLfxzKQMIuAqsTPDyvZQcK8As4S385KQeySkzh//CcziM0JVL1k0xew6UJAJbdXfmSbwMi7
	gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGukV5uZoleakrpJkZIePHuYPy/TuYQowAHoxIP
	b0Z3dqgQa2JZcWXuIUZJDiYlUV7nypxQIb6k/JTKjMTijPii0pzU4kOMEhzMSiK8VhVAOd6U
	xMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBO/sOqBGwaLU9NSKtMycEoQ0
	EwcnyHAuKZHi1LyU1KLE0pKMeFBUxBcD4wIkxQO0Nxqknbe4IDEXKArReopRl+PHpcbFTEIs
	efl5qVLivPtAigRAijJK8+BWwJLJK0ZxoI+Fef+DVPEAExHcpFdAS5iAlrQLgC0pSURISTUw
	5j331Hqw9Mz7ydrXP6vdeJyk4HAx4KPcFPnCg+EFD6e1h6+4qJcc0Zc/tUTJ4PoVkzXVW8qM
	9vhwZezbwPfgcJHDg5z1fd80+qMeMChGCXe/WSTSWsizttvke8HNB2d2/54vyPRg 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270428>

Add tests that for-each-ref correctly reports broken loose reference
files and references that point at missing objects. In fact, two of
these tests fail, because (1) NULL_SHA1 is not recognized as an
invalid reference value, and (2) for-each-ref doesn't respect
REF_ISBROKEN. Fixes to come.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

Notes (discussion):
    Note that a reference that points at NULL_SHA1 is reported as "broken"
    rather than "missing". This is because NULL_SHA1 is manifestly bogus,
    whereas we have no systematic basis for rejecting any other
    40-character hexadecimal string without doing an object lookup.

 t/t6301-for-each-ref-errors.sh | 45 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100755 t/t6301-for-each-ref-errors.sh

diff --git a/t/t6301-for-each-ref-errors.sh b/t/t6301-for-each-ref-errors.sh
new file mode 100755
index 0000000..dc68947
--- /dev/null
+++ b/t/t6301-for-each-ref-errors.sh
@@ -0,0 +1,45 @@
+#!/bin/sh
+
+test_description='for-each-ref errors for broken refs'
+
+. ./test-lib.sh
+
+ZEROS=0000000000000000000000000000000000000000
+MISSING=abababababababababababababababababababab
+
+test_expect_success setup '
+	git commit --allow-empty -m "Initial" &&
+	git tag testtag &&
+	git for-each-ref >full-list
+'
+
+test_expect_failure 'Broken refs are reported correctly' '
+	r=refs/heads/bogus &&
+	: >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "warning: ignoring broken ref $r" >broken-err &&
+	git for-each-ref >out 2>err &&
+	test_cmp full-list out &&
+	test_cmp broken-err err
+'
+
+test_expect_failure 'NULL_SHA1 refs are reported correctly' '
+	r=refs/heads/zeros &&
+	echo $ZEROS >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "warning: ignoring broken ref $r" >zeros-err &&
+	git for-each-ref >out 2>err &&
+	test_cmp full-list out &&
+	test_cmp zeros-err err
+'
+
+test_expect_success 'Missing objects are reported correctly' '
+	r=refs/heads/missing &&
+	echo $MISSING >.git/$r &&
+	test_when_finished "rm -f .git/$r" &&
+	echo "fatal: missing object $MISSING for $r" >missing-err &&
+	test_must_fail git for-each-ref 2>err &&
+	test_cmp missing-err err
+'
+
+test_done
-- 
2.1.4
