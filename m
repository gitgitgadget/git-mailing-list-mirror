From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/2] Replace literal STRLEN_ #defines in refs.h with compiler evaluated expressions
Date: Sat, 29 Sep 2007 13:00:13 +0000
Message-ID: <200709291400.13880.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 29 15:00:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ibbvz-0001ek-Po
	for gcvg-git-2@gmane.org; Sat, 29 Sep 2007 15:00:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756632AbXI2NAW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Sep 2007 09:00:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756310AbXI2NAV
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Sep 2007 09:00:21 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:33983 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755523AbXI2NAT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Sep 2007 09:00:19 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1621190ugc
        for <git@vger.kernel.org>; Sat, 29 Sep 2007 06:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=4a2yIW04FXszF78A4w7VMQzuHfIPVzabXmE9DvHtTso=;
        b=p0qiCsNvBNaGK00SeCO0jaQX2hJmQyQyQaCtVev3A+UdecdnAFggbw5Xidggu2xdcMpxqeQQkqlPG+0OyiL8EGD4pGlYGAdJH+QKuGtQSRw4a7uLf/+HANJJeqAuKHQgBx35G/mDJ4ndRnB8qhOEpjEUP/xK9J9fTLIfg+Cyi6E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=NFBG6wtpS0opQD8Qo/XaVDnxEkEEuIO7UeYiiGiUcr9f4e+cFWPHb/eKoflzwKYruRq6mOJRPhTJRagBUjlm+hMpYSbfSXSlszL0d4LvqIPcX3ztjUFMi+CtH8EmQCcwGw6iGmWRIa5mBeUK9i6sOKIvp+c3SrWLc6LXOwmg3gc=
Received: by 10.67.32.14 with SMTP id k14mr957398ugj.1191070818550;
        Sat, 29 Sep 2007 06:00:18 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id 20sm3753599uga.2007.09.29.06.00.17
        (version=SSLv3 cipher=OTHER);
        Sat, 29 Sep 2007 06:00:17 -0700 (PDT)
X-TUID: b1fe2309fc31077f
X-UID: 342
X-Length: 1891
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59467>

Bill Lear pointed out that the following:

 #define PATH_REMOTES             "remotes/"
 #define STRLEN_PATH_REMOTES      8

Could be replaced by the less error-prone

 #define PATH_REMOTES "remotes/"
 #define LIT_STRLEN(S) ((sizeof(S) / sizeof(S[0])) -1)
 #define STRLEN_PATH_REMOTES LIT_STRLEN(PATH_REMOTES)

which is what this patch does.

Signed-off-by: Andy Parkins <andyparkins@gmail.com>
---
 refs.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs.h b/refs.h
index 1025d04..fb58889 100644
--- a/refs.h
+++ b/refs.h
@@ -13,16 +13,17 @@ struct ref_lock {
 #define REF_ISSYMREF 01
 #define REF_ISPACKED 02
 
+#define LIT_STRLEN(S)            ((sizeof(S) / sizeof(S[0])) -1)
 #define PATH_OBJECTS             "objects/"
-#define STRLEN_PATH_OBJECTS      8
+#define STRLEN_PATH_OBJECTS      LIT_STRLEN(PATH_OBJECTS)
 #define PATH_REFS                "refs/"
-#define STRLEN_PATH_REFS         5
+#define STRLEN_PATH_REFS         LIT_STRLEN(PATH_REFS)
 #define PATH_HEADS               "heads/"
-#define STRLEN_PATH_HEADS        6
+#define STRLEN_PATH_HEADS        LIT_STRLEN(PATH_HEADS)
 #define PATH_TAGS                "tags/"
-#define STRLEN_PATH_TAGS         5
+#define STRLEN_PATH_TAGS         LIT_STRLEN(PATH_TAGS)
 #define PATH_REMOTES             "remotes/"
-#define STRLEN_PATH_REMOTES      8
+#define STRLEN_PATH_REMOTES      LIT_STRLEN(PATH_REMOTES)
 #define PATH_REFS_HEADS          PATH_REFS PATH_HEADS
 #define STRLEN_PATH_REFS_HEADS   (STRLEN_PATH_REFS+STRLEN_PATH_HEADS)
 #define PATH_REFS_TAGS           PATH_REFS PATH_TAGS
-- 
1.5.3.rc5.11.g312e
