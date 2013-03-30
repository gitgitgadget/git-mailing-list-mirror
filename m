From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH] rev-parse: clarify documentation for the --verify option
Date: Sat, 30 Mar 2013 07:44:25 +0100
Message-ID: <1364625865-8459-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 30 07:46:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULpXd-0000M5-CW
	for gcvg-git-2@plane.gmane.org; Sat, 30 Mar 2013 07:45:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754960Ab3C3Gov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Mar 2013 02:44:51 -0400
Received: from ALUM-MAILSEC-SCANNER-8.MIT.EDU ([18.7.68.20]:59851 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753959Ab3C3Gov (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Mar 2013 02:44:51 -0400
X-AuditID: 12074414-b7fb86d000000905-89-515689e21c32
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 39.FA.02309.2E986515; Sat, 30 Mar 2013 02:44:50 -0400 (EDT)
Received: from michael.fritz.box (p57A2472C.dip.t-dialin.net [87.162.71.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2U6icpn024821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 30 Mar 2013 02:44:49 -0400
X-Mailer: git-send-email 1.8.2
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrDIsWRmVeSWpSXmKPExsUixO6iqPuoMyzQYOUlLouuK91MFg29V5gt
	bq+Yz+zA7PH3/Qcmj4uXlD0+b5ILYI7itklKLCkLzkzP07dL4M7o/3eLreCXSMW5kx9YGxhv
	C3QxcnJICJhIdK+6yghhi0lcuLeerYuRi0NI4DKjxON7nUwQzhkmiZ+Xb7CBVLEJ6Eos6mlm
	ArFFBNQkJrYdYgGxmQUcJDZ/bgSbJCzgKTHx6nlWEJtFQFVi/5onYDavgLPE3bsrmLsYOYC2
	yUm0r3SbwMi9gJFhFaNcYk5prm5uYmZOcWqybnFyYl5eapGuhV5uZoleakrpJkaI70V2MB45
	KXeIUYCDUYmHt2BNaKAQa2JZcWXuIUZJDiYlUd4LbWGBQnxJ+SmVGYnFGfFFpTmpxYcYJTiY
	lUR45VcAlfOmJFZWpRblw6SkOViUxHm/LVb3ExJITyxJzU5NLUgtgsnKcHAoSfByAENcSLAo
	NT21Ii0zpwQhzcTBCTKcS0qkODUvJbUosbQkIx4U6PHFwFAHSfEA7QVr5y0uSMwFikK0nmLU
	5Whr//yKUYglLz8vVUqc93YHUJEASFFGaR7cClikv2IUB/pYmFcCZBQPMEnATXoFtIQJaMny
	r8EgS0oSEVJSDYyr7Q8+T7Y6+ssgM7a/fueTa3H/AiS/tq//zVrq320cIBRgIu0cqMk429CA
	reFzd/Xyp3WJkvv0tZyafuiUyG7R/Kj0OGWtpvTF02eOK28uexPipWC56dD39oSpAq6PizaY
	WGQmNbq/VlO8vlxp0t6NbqnBPg3Gm5kOnLm86tYupdW/tqs1aSuxFGckGmoxFxUn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219561>

The old version could be read to mean that the argument has to refer
to a valid object, but that is incorrect:

* the object is not necessarily read (e.g., to check for corruption)

* if the argument is a 40-digit string of hex digits, then it is
  accepted whether or not is is the name of an existing object.

So reword the explanation to be less ambiguous.

Also fix the examples involving --verify: to be sure that the argument
refers to a commit (rather than some other kind of object), the
argument has to be suffixed with "^{commit}".  This trick is not
possible in the example involving --default, so don't imply that it is
exactly the same as the previous example.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---

This was discussed in the following thread:

    http://thread.gmane.org/gmane.comp.version-control.git/219409

Please note that the second example already reveals a fly in the
ointment:

    $ git rev-parse --default master --verify $REV

Following Junio's advice, we would like to change this to

    $ git rev-parse --default master --verify $REV^{commit}

but that defeats the purpose of the --default option.  Doing

    $ git rev-parse --verify $(git rev-parse --default master $REV)^{commit}

is just plain ugly.  Though honestly, I don't see the point of using
--default as opposed to

    $ git rev-parse --verify ${REV:-master}^{commit}

So maybe the second example should be removed entirely or converted to
use ${REV:-master} rather than --default.

 Documentation/git-rev-parse.txt | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index 10a116f..6095227 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -60,8 +60,10 @@ OPTIONS
 	instead.
 
 --verify::
-	The parameter given must be usable as a single, valid
-	object name.  Otherwise barf and abort.
+	If the parameter can be used as a single object name, output
+	that name; otherwise, emit an error message and exit with a
+	non-zero status.  Please note that the existence and validity
+	of the named object itself are not checked.
 
 -q::
 --quiet::
@@ -308,12 +310,12 @@ $ git rev-parse --verify HEAD
 * Print the commit object name from the revision in the $REV shell variable:
 +
 ------------
-$ git rev-parse --verify $REV
+$ git rev-parse --verify $REV^{commit}
 ------------
 +
 This will error out if $REV is empty or not a valid revision.
 
-* Same as above:
+* Similar to above:
 +
 ------------
 $ git rev-parse --default master --verify $REV
-- 
1.8.2
