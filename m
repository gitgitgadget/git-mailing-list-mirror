From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v7 14/38] lock_file(): exit early if lockfile cannot be opened
Date: Wed,  1 Oct 2014 12:28:18 +0200
Message-ID: <1412159322-2622-15-git-send-email-mhagger@alum.mit.edu>
References: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
Cc: Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>,
	Ronnie Sahlberg <sahlberg@google.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 01 12:30:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZHBP-0003Gf-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 01 Oct 2014 12:30:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751831AbaJAKaw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 06:30:52 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:62625 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751551AbaJAK3O (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Oct 2014 06:29:14 -0400
X-AuditID: 12074412-f792e6d000005517-6b-542bd7796e09
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id DF.1A.21783.977DB245; Wed,  1 Oct 2014 06:29:13 -0400 (EDT)
Received: from michael.fritz.box (p5DDB1FCB.dip0.t-ipconnect.de [93.219.31.203])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s91ASk6D026827
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Wed, 1 Oct 2014 06:29:12 -0400
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1412159322-2622-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmplleLIzCtJLcpLzFFi42IRYndR1K28rh1isOSUkUXXlW4mi4beK8wW
	T+beZbZ4e3MJo8XtFfOZLX609DBb/JtQY9HZ8ZXRgcPj7/sPTB47Z91l91iwqdTj4asudo9n
	vXsYPS5eUvb4vEnO4/azbSwBHFHcNkmJJWXBmel5+nYJ3Bmn5i9mLdjHVbFg+QmWBsY1HF2M
	nBwSAiYS/ze3skDYYhIX7q1nA7GFBC4zSiz44tDFyAVkH2eSOHflMyNIgk1AV2JRTzMTiC0i
	oCYxse0QC0gRs8BiJokJhzaBdQsL+Em8+feGFcRmEVCVmHfxMVgDr4CLxJo1HxghtslJbNj9
	H8zmBIovv9zMArHZWWLHna9MExh5FzAyrGKUS8wpzdXNTczMKU5N1i1OTszLSy3SNdPLzSzR
	S00p3cQICUahHYzrT8odYhTgYFTi4VVI0A4RYk0sK67MPcQoycGkJMq76BJQiC8pP6UyI7E4
	I76oNCe1+BCjBAezkghv9gGgHG9KYmVValE+TEqag0VJnPfnYnU/IYH0xJLU7NTUgtQimKwM
	B4eSBC/DNaBGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFBsxBcDowMkxQO01xmk
	nbe4IDEXKArReopRl2Nd57d+JiGWvPy8VClx3tCrQEUCIEUZpXlwK2Cp5xWjONDHwrzhIKN4
	gGkLbtIroCVMQEuS14AtKUlESEk1ME4t4J0l1yFwfU7u58BH0xj48z/d+PPwv9lMoz/hSruU
	V15+pfylYF1GvY+aRb1cUfnzWws3Xme4yfxLxlHk9oKFPH8k/dYuT0zZbdnzzk7t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257732>

This is a bit easier to read than the old version, which nested part
of the non-error code in an "if" block.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
Reviewed-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
---
 lockfile.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/lockfile.c b/lockfile.c
index 23847fc..a8f32e5 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -197,19 +197,18 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 		resolve_symlink(lk->filename, max_path_len);
 	strcat(lk->filename, LOCK_SUFFIX);
 	lk->fd = open(lk->filename, O_RDWR | O_CREAT | O_EXCL, 0666);
-	if (0 <= lk->fd) {
-		lk->owner = getpid();
-		if (adjust_shared_perm(lk->filename)) {
-			int save_errno = errno;
-			error("cannot fix permission bits on %s",
-			      lk->filename);
-			rollback_lock_file(lk);
-			errno = save_errno;
-			return -1;
-		}
-	}
-	else
+	if (lk->fd < 0) {
 		lk->filename[0] = 0;
+		return -1;
+	}
+	lk->owner = getpid();
+	if (adjust_shared_perm(lk->filename)) {
+		int save_errno = errno;
+		error("cannot fix permission bits on %s", lk->filename);
+		rollback_lock_file(lk);
+		errno = save_errno;
+		return -1;
+	}
 	return lk->fd;
 }
 
-- 
2.1.0
