From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v2 1/9] remote-hg:  don't decode UTF-8 paths into Unicode objects
Date: Tue, 12 Nov 2013 00:54:40 -0500
Message-ID: <1384235688-9655-2-git-send-email-rhansen@bbn.com>
References: <1384142712-2936-1-git-send-email-rhansen@bbn.com>
 <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Cc: felipe.contreras@gmail.com, Richard Hansen <rhansen@bbn.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 06:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vg6wc-0008KE-T6
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 06:55:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751203Ab3KLFzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 00:55:14 -0500
Received: from smtp.bbn.com ([128.33.1.81]:54739 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab3KLFzM (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 00:55:12 -0500
Received: from socket.bbn.com ([192.1.120.102]:44820)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1Vg6wR-0002PA-BH; Tue, 12 Nov 2013 00:55:11 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id AB2DF40064
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237687>

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
1.8.5.rc1.208.g8ff7964
