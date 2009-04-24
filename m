From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 1/3] t5540-http-push: test fetching of loose objects
Date: Sat, 25 Apr 2009 00:35:47 +0800
Message-ID: <49F1EA63.4040907@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 24 18:42:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LxOPr-0007uJ-GR
	for gcvg-git-2@gmane.org; Fri, 24 Apr 2009 18:38:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757646AbZDXQgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Apr 2009 12:36:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756701AbZDXQgX
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Apr 2009 12:36:23 -0400
Received: from rv-out-0506.google.com ([209.85.198.226]:59162 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZDXQgV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Apr 2009 12:36:21 -0400
Received: by rv-out-0506.google.com with SMTP id f9so1071259rvb.1
        for <git@vger.kernel.org>; Fri, 24 Apr 2009 09:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=ACz0VHBOG1ZxSCr/EM/0FM0ZLAz2kcWXh30wqYIN5G0=;
        b=IdLnrv+uK2JdrafXg8zDMsKGhrsYjGZu4V3RVA9yCv1ljMahqp8gnB9CCdU78stVeB
         onbL9lIQtODF++/z9i6JfOODyp2P0MjY+/CnQ41dn+L9BicYrTHdJwD55zBW+aBzqIhV
         5+DYfB0EK4aG8NvKU2tDIwnMVAl2Mit4a0A9U=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=VZJVcr8DWIUBWsftnTVOtMeubg7btyi0Bor7fGuXuYkMpwYcygOfxZJMQ1yU+yVr+1
         gOaZznsh5pfr6ek+9t8dJj4CadGYUsy4petzhhYoNKXf6HBbLM4aKq01r+MWXMmcttK4
         Qk/PJMirJJ1Iv6T1yosBEymLwzmzAJBo9k/lI=
Received: by 10.114.145.17 with SMTP id s17mr1571642wad.120.1240590980539;
        Fri, 24 Apr 2009 09:36:20 -0700 (PDT)
Received: from ?116.87.149.49? (cm49.zeta149.maxonline.com.sg [116.87.149.49])
        by mx.google.com with ESMTPS id c26sm1935124waa.50.2009.04.24.09.36.19
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Apr 2009 09:36:20 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117469>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 t/t5540-http-push.sh |   16 ++++++++++++++++
 1 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/t/t5540-http-push.sh b/t/t5540-http-push.sh
index 5fe479e..65a41db 100755
--- a/t/t5540-http-push.sh
+++ b/t/t5540-http-push.sh
@@ -67,6 +67,22 @@ test_expect_success ' push to remote repository with unpacked refs' '
 	 test $HEAD = $(git rev-parse --verify HEAD))
 '

+test_expect_failure 'http-push fetches unpacked objects' '
+	cp -R "$HTTPD_DOCUMENT_ROOT_PATH"/test_repo.git \
+		"$HTTPD_DOCUMENT_ROOT_PATH"/test_repo_unpacked.git &&
+
+	git clone $HTTPD_URL/test_repo_unpacked.git \
+		"$ROOT_PATH"/fetch_unpacked &&
+
+	# By reset, we force git to retrieve the object
+	(cd "$ROOT_PATH"/fetch_unpacked &&
+	 git reset --hard HEAD^ &&
+	 git remote rm origin &&
+	 git reflog expire --expire=0 --all &&
+	 git prune &&
+	 git push -f -v $HTTPD_URL/test_repo_unpacked.git master)
+'
+
 test_expect_success 'create and delete remote branch' '
 	cd "$ROOT_PATH"/test_repo_clone &&
 	git checkout -b dev &&
-- 
1.6.3.rc0
