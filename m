From: Andrew Sayers <andrew-git@pileofstuff.org>
Subject: [PATCH] Explain how svn-fe parses filenames in SVN dumps
Date: Sat, 14 Apr 2012 18:03:09 +0100
Message-ID: <4F89ADCD.6000109@pileofstuff.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: David Barr <davidbarr@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Apr 14 19:03:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SJ6O0-0001rH-LN
	for gcvg-git-2@plane.gmane.org; Sat, 14 Apr 2012 19:03:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753100Ab2DNRDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Apr 2012 13:03:38 -0400
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49]:56481 "EHLO
	mtaout03-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751934Ab2DNRDO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Apr 2012 13:03:14 -0400
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com
          (InterMail vM.7.08.04.00 201-2186-134-20080326) with ESMTP
          id <20120414170311.TDEG21612.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>;
          Sat, 14 Apr 2012 18:03:11 +0100
Received: from [192.168.0.2] (really [94.170.150.126])
          by aamtaout03-winn.ispmail.ntl.com
          (InterMail vG.3.00.04.00 201-2196-133-20080908) with ESMTP
          id <20120414170311.WFTH13318.aamtaout03-winn.ispmail.ntl.com@[192.168.0.2]>;
          Sat, 14 Apr 2012 18:03:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
X-Cloudmark-Analysis: v=1.1 cv=JvdXmxIgLJv2/GthKqHpGJEEHukvLcvELVXUanXFreg= c=1 sm=0 a=yXtjXN6ItgYA:10 a=T3b_QnXfNb0A:10 a=u4BGzq-dJbcA:10 a=8nJEP1OIZ-IA:10 a=qOz2pZ_4AAAA:8 a=_uVKvx0eQv4xe4a2oJQA:9 a=en-dgnHu3T9OtpPHsKYA:7 a=wPNLvfGTeEIA:10 a=7qzHkXPk5l4A:10 a=HpAAvcLHHh0Zw7uRqdWCyQ==:117
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195493>

The documentation for the SVN dumpfile format says that filenames "may be
interpreted as binary data in any encoding by client tools", but users might be
surprised that svn-fe's handling differs from svn's.

Before version 1.2.0, `svn add` supported files containing characters in the
range 0x01-0x1F, and Subversion still supports existing files that contain
those characters.  The newline character is explicitly discussed so that users
with ancient repositories understand why they can't be supported by tools that
read the SVN dump format.

The documentation for the SVN dumpfile format describes records as containing
"a group of RFC822-style header lines", and its full text can be read as
implying newline characters are reserved for use by the format.  This reading
is slightly charitable, but it avoids the need to discuss the format's design
issues in a context where few readers will be interested.

Signed-off-by: Andrew Sayers <andrew-git@pileofstuff.org>
---
 contrib/svn-fe/svn-fe.txt |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/contrib/svn-fe/svn-fe.txt b/contrib/svn-fe/svn-fe.txt
index 1128ab2..c079abe 100644
--- a/contrib/svn-fe/svn-fe.txt
+++ b/contrib/svn-fe/svn-fe.txt
@@ -59,6 +59,14 @@ to put each project in its own repository and to separate the history
 of each branch.  The 'git filter-branch --subdirectory-filter' command
 may be useful for this purpose.
 
+Filenames are interpreted by svn-fe as binary data, and may contain
+any character except NUL (0x00) and newline (0x0A).  The NUL
+character is not valid in git paths, and the newline character is
+reserved for use by the (line-based) Subversion dumpfile format.
+This differs from Subversion, which requires filenames to contain
+only legal XML characters and disallows tabs characters, carriage
+returns and newlines.
+
 BUGS
 ----
 Empty directories and unknown properties are silently discarded.
-- 
1.7.1
