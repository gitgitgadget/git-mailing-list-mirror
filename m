From: Danny Thomas <Danny.Thomas@blackboard.com>
Subject: [PATCH] git-p4: support exclusively locked files
Date: Wed, 13 Mar 2013 13:51:11 -0400
Message-ID: <CD666D0F.1DC6E%danny.thomas@blackboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Mar 13 18:57:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFpuz-0004ue-3s
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 18:56:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933132Ab3CMR4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 13:56:22 -0400
Received: from exprod8og103.obsmtp.com ([64.18.3.86]:57313 "EHLO
	exprod8og103.obsmtp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933043Ab3CMR4W convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Mar 2013 13:56:22 -0400
X-Greylist: delayed 321 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Mar 2013 13:56:21 EDT
Received: from mail1.blackboard.com ([69.196.244.118]) (using TLSv1) by exprod8ob103.postini.com ([64.18.7.12]) with SMTP
	ID DSNKUUC9xdsJJNvPhJW/3U7/bHGmLPfAOHXY@postini.com; Wed, 13 Mar 2013 10:56:21 PDT
Received: from DCEX07-2.bbbb.net ([169.254.1.71]) by DCCAS3.bbbb.net
 ([10.2.224.18]) with mapi; Wed, 13 Mar 2013 13:50:59 -0400
Thread-Topic: [PATCH] git-p4: support exclusively locked files
Thread-Index: Ac4gE1He2LdhIu3BRsizYsEfdrmADw==
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Microsoft-MacOutlook/14.3.1.130117
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218078>

By default, newly added binary files are exclusively locked by Perforce:

'add default change (binary+l) *exclusive*'

This results in a 'Could not determine file type' error as the regex
expects
the line to end after the file type matching group. Some repositories are
also configured to always require exclusive locks, so may be a problem for
all revisions in some cases.

Signed-off-by: Danny Thomas <dthomas@blackboard.com>
---
git-p4.py | 2 +-
1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 0682e61..ffba294 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -326,7 +326,7 @@ def getP4OpenedType(file):
     # Returns the perforce file type for the given file.

     result = p4_read_pipe(["opened", wildcard_encode(file)])
-    match = re.match(".*\((.+)\)\r?$", result)
+    match = re.match(".*\((.+)\)(?:.+)?\r?$", result)
     if match:
         return match.group(1)
     else:
--
1.8.1.5





This email and any attachments may contain confidential and proprietary information of Blackboard that is for the sole use of the intended recipient. If you are not the intended recipient, disclosure, copying, re-distribution or other use of any of this information is strictly prohibited. Please immediately notify the sender and delete this transmission if you received this email in error.
