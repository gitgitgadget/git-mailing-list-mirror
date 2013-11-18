From: Richard Hansen <rhansen@bbn.com>
Subject: [PATCH v3 1/9] remote-hg:  don't decode UTF-8 paths into Unicode objects
Date: Sun, 17 Nov 2013 23:12:42 -0500
Message-ID: <1384747970-25481-2-git-send-email-rhansen@bbn.com>
References: <1384235688-9655-1-git-send-email-rhansen@bbn.com>
 <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Cc: git@vger.kernel.org, felipe.contreras@gmail.com,
	Richard Hansen <rhansen@bbn.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 18 05:13:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ViGDR-00040D-5E
	for gcvg-git-2@plane.gmane.org; Mon, 18 Nov 2013 05:13:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409Ab3KREN1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Nov 2013 23:13:27 -0500
Received: from smtp.bbn.com ([128.33.0.80]:57186 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751199Ab3KRENV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Nov 2013 23:13:21 -0500
Received: from socket.bbn.com ([192.1.120.102]:57933)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1ViGD7-0009ca-TM; Sun, 17 Nov 2013 23:13:17 -0500
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 29C6E3FFEF
X-Mailer: git-send-email 1.8.5.rc1.208.g8ff7964
In-Reply-To: <1384747970-25481-1-git-send-email-rhansen@bbn.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237967>

The internal mercurial API expects ordinary 8-bit string objects, not
Unicode string objects.  With this change, the test-hg.sh unit tests
pass again.

Signed-off-by: Richard Hansen <rhansen@bbn.com>
Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
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
