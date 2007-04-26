From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 3/2] post-receive-email example hook: sed command for getting description was wrong
Date: Thu, 26 Apr 2007 22:37:16 +0100
Message-ID: <200704262237.16795.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 26 23:37:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhBei-0005M6-Gd
	for gcvg-git@gmane.org; Thu, 26 Apr 2007 23:37:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbXDZVhd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Apr 2007 17:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755149AbXDZVhd
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Apr 2007 17:37:33 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:65492 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755147AbXDZVhc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Apr 2007 17:37:32 -0400
Received: by ug-out-1314.google.com with SMTP id 44so702629uga
        for <git@vger.kernel.org>; Thu, 26 Apr 2007 14:37:31 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Xb5nLsuQKAukrrLy/CJM1uO+xtfpYCaOLxZUVU8HwtdUmFUdxZP1BqBls3NQDJ6EBKLjZnWbdqHXGyO3tvfA1FYs/EgdGt3Zsimvdh0GBuufgV+nBSlgs+nC5qJ/8a0ZpWoezjHEJR48x1aK128QwUfvT7zhRWogfBVR/BPHrF4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=JV25E9aDdmc92OAyL3Ss1xM4o7T7zGBhHpzhsLgWWtY/SdYyLfSxRVax/bKuC0bix5ZR6ZU1K8nhGKRvzKCd4DkIdTiNl7uJaCqmIpQI4wrRYXMmg3fEluNnljkWjksmvHep3EsRFnkQvRcPS3Ua856DzHYCHfm36+JztFqhVis=
Received: by 10.67.89.6 with SMTP id r6mr1459192ugl.1177623451196;
        Thu, 26 Apr 2007 14:37:31 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTP id g30sm4215169ugd.2007.04.26.14.37.29;
        Thu, 26 Apr 2007 14:37:29 -0700 (PDT)
X-TUID: a582a710decfcdfa
X-UID: 306
X-Length: 1347
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45666>

The sed command that extracted the first line of the project description
didn't include the -n switch and hence the project name was being
printed twice.  This was ruining the email header generation because it
was assumed that the description was only one line and was included in
the subject.  This turned the subject into a two line item and
prematurely finished the header.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
Oops - patch 3 in my series of 2.  Tee hee.


 contrib/hooks/post-receive-email |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/contrib/hooks/post-receive-email b/contrib/hooks/post-receive-email
index e175b42..d1bef91 100644
--- a/contrib/hooks/post-receive-email
+++ b/contrib/hooks/post-receive-email
@@ -587,7 +587,7 @@ if [ -z "$GIT_DIR" ]; then
 	exit 1
 fi
 
-projectdesc=$(sed -e '1p' "$GIT_DIR/description")
+projectdesc=$(sed -ne '1p' "$GIT_DIR/description")
 # Check if the description is unchanged from it's default, and shorten it to a
 # more manageable length if it is
 if expr "$projectdesc" : "Unnamed repository.*$" >/dev/null
-- 
1.5.2.rc0.744.g33910
