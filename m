From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH 1/7] remote-hg:  don't decode UTF-8 paths into Unicode objects
Date: Sun, 10 Nov 2013 23:05:06 -0500
Message-ID: <1384142712-2936-2-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 11 05:07:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vfin5-00040j-OV
	for gcvg-git-2@plane.gmane.org; Mon, 11 Nov 2013 05:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753Ab3KKEHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Nov 2013 23:07:52 -0500
Received: from smtp.bbn.com ([128.33.1.81]:46005 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751135Ab3KKEHu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Nov 2013 23:07:50 -0500
Received: from socket.bbn.com ([192.1.120.102]:44754)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vfimz-000JV6-Bq; Sun, 10 Nov 2013 23:07:49 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 3B2183FF72
X-Mailer: git-send-email 1.8.5.rc1.207.gc17dd22
In-Reply-To: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237598>

The internal mercurial API expects ordinary 8-bit string objects, not
Unicode string objects.  With this change, the test-hg.sh unit tests
pass again.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
---
 contrib/remote-helpers/git-remote-hg | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 3222afd..c6026b9 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -747,7 +747,7 @@ def parse_commit(parser):
             f = { 'deleted' : True }
         else:
             die('Unknown file command: %s' % line)
-        path = c_style_unescape(path).decode('utf-8')
+        path = c_style_unescape(path)
         files[path] = f
 
     # only export the commits if we are on an internal proxy repo
-- 
1.8.5.rc1.207.gc17dd22
