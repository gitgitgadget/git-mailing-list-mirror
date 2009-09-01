From: David Reiss <dreiss@facebook.com>
Subject: [PATCH-v2] Make git status print a helpful death message if the disk
 is full
Date: Tue, 1 Sep 2009 13:27:20 -0700
Message-ID: <4A9D83A8.3000400@facebook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Sep 01 22:29:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiZz7-0007pc-Ro
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 22:29:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbZIAU3T (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Sep 2009 16:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753553AbZIAU3S
	(ORCPT <rfc822;git-outgoing>); Tue, 1 Sep 2009 16:29:18 -0400
Received: from mailout-snc1.facebook.com ([69.63.179.25]:58355 "EHLO
	mailout-sf2p.facebook.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753401AbZIAU3S (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 1 Sep 2009 16:29:18 -0400
Received: from mail.thefacebook.com (intlb01.snat.snc1.facebook.com [10.128.203.16] (may be forged))
	by pp02.snc1.tfbnw.net (8.14.1/8.14.1) with ESMTP id n81KT5dX020962
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Tue, 1 Sep 2009 13:29:06 -0700
Received: from [172.24.132.70] (192.168.18.252) by mail.TheFacebook.com
 (192.168.18.104) with Microsoft SMTP Server (TLS) id 8.1.393.1; Tue, 1 Sep
 2009 13:27:25 -0700
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
X-Proofpoint-Virus-Version: vendor=fsecure engine=1.12.8161:2.4.5,1.2.40,4.0.166 definitions=2009-09-01_14:2009-08-26,2009-09-01,2009-09-01 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 ipscore=0 phishscore=0 bulkscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx engine=5.0.0-0908210000 definitions=main-0909010175
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127554>

The old behavior just said that it failed.  Now it includes the error
information, which makes it much easier to debug.

There is a risk that some failure paths could result in misleading error
messages that actually make debugging more difficult.

Signed-off-by: David Reiss <dreiss@facebook.com>
---
Sorry I missed that.

 builtin-commit.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-commit.c b/builtin-commit.c
index 4bcce06..7feb598 100644
--- a/builtin-commit.c
+++ b/builtin-commit.c
@@ -256,7 +256,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    close_lock_file(&index_lock))
-			die("unable to write new_index file");
+			die_errno("unable to write new_index file");
 		commit_style = COMMIT_NORMAL;
 		return index_lock.filename;
 	}
@@ -275,7 +275,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 		refresh_cache(REFRESH_QUIET);
 		if (write_cache(fd, active_cache, active_nr) ||
 		    commit_locked_index(&index_lock))
-			die("unable to write new_index file");
+			die_errno("unable to write new_index file");
 		commit_style = COMMIT_AS_IS;
 		return get_index_file();
 	}
@@ -318,7 +318,7 @@ static char *prepare_index(int argc, const char **argv, const char *prefix)
 	refresh_cache(REFRESH_QUIET);
 	if (write_cache(fd, active_cache, active_nr) ||
 	    close_lock_file(&index_lock))
-		die("unable to write new_index file");
+		die_errno("unable to write new_index file");
 
 	fd = hold_lock_file_for_update(&false_lock,
 				       git_path("next-index-%"PRIuMAX,
-- 
1.6.0.4
