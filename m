From: David Reiss <dreiss@facebook.com>
Subject: [PATCH 1/2] chdir after computing new cwd in check_repository_format_gently
Date: Tue, 13 May 2008 22:45:21 -0700
Message-ID: <482A7C71.6050509@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 14 07:46:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jw9oe-0000W7-M7
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 07:46:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbYENFpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 01:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751847AbYENFpY
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 01:45:24 -0400
Received: from fw-sf2p.facebook.com ([204.15.23.140]:32573 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751801AbYENFpX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 01:45:23 -0400
Received: from sf2pmxf02.TheFacebook.com (sf2pmxf02.thefacebook.com [192.168.16.13])
	by pp01.sf2p.tfbnw.net (8.14.1/8.14.1) with ESMTP id m4E5jM8O003770
	for <git@vger.kernel.org>; Tue, 13 May 2008 22:45:22 -0700
Received: from [192.168.98.131] ([10.8.254.247]) by sf2pmxf02.TheFacebook.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 13 May 2008 22:42:34 -0700
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
X-OriginalArrivalTime: 14 May 2008 05:42:34.0626 (UTC) FILETIME=[4F544620:01C8B585]
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.7160:2.4.4,1.2.40,4.0.166 definitions=2008-05-14_01:2008-05-13,2008-05-14,2008-05-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0804140000 definitions=main-0805130271
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82074>

In preparation for adding a check before the chdir.
This should be a no-op because the cwd is not read in the interim
and any nonlocal exits either chdir to an absolute path or die.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
I sent this in a few weeks ago, but got no response.  Probably because I
messed up the formatting.  Hopefully I'm getting it right this time.

 setup.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/setup.c b/setup.c
index b8fd476..c54f2b6 100644
--- a/setup.c
+++ b/setup.c
@@ -443,7 +443,6 @@ const char *setup_git_directory_gently(int *nongit_ok)
 			check_repository_format_gently(nongit_ok);
 			return NULL;
 		}
-		chdir("..");
 		do {
 			if (!offset) {
 				if (nongit_ok) {
@@ -455,6 +454,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
 				die("Not a git repository");
 			}
 		} while (cwd[--offset] != '/');
+		chdir("..");
 	}
 
 	inside_git_dir = 0;
-- 
1.5.4
