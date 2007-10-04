From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH 2/3] Replace literal STRLEN_ #defines in refs.h with compiler evaluated expressions
Date: Thu, 4 Oct 2007 21:10:44 +0000
Message-ID: <200710042210.44940.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 04 23:12:31 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdXzO-0001dd-9p
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 23:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760643AbXJDVK5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 17:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761993AbXJDVK4
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 17:10:56 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:56414 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760283AbXJDVKy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 17:10:54 -0400
Received: by ug-out-1314.google.com with SMTP id z38so415038ugc
        for <git@vger.kernel.org>; Thu, 04 Oct 2007 14:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        bh=4a2yIW04FXszF78A4w7VMQzuHfIPVzabXmE9DvHtTso=;
        b=dxM5+IMM7MqK0H7QaKPzjqZxHAjtsFS2lhNSHXCrv0/Edpd5S1RXdUbQhQ8DQyCx5CFNblCmZDmdIUXN+Fd8cbbMZzwJtQzHTHF2lZ/eZxrWLJS9HUtrpartR8GflSddDKlCy+Dwg2kl/CJrWbnI8GNdcixn2Wj9f4xzLIS2tB0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=i24Gz5TFTfDQHkPEGEPfrJpbFlaNFliSgJwi3njo0+lcOg0hGm4rnwju3MJoQHlWH2lupFlyGYRE6Db9RFazo5LIMWnacxKLGBVkt9sG0ROWB87AJsoDRuJtVh9FyvnG0+XkBxb0mQNH2a+dLBhO52+i/nO7wcHOPN4bzcK72KA=
Received: by 10.66.221.17 with SMTP id t17mr2475190ugg.1191532252955;
        Thu, 04 Oct 2007 14:10:52 -0700 (PDT)
Received: from grissom.local ( [84.201.153.164])
        by mx.google.com with ESMTPS id 5sm2814414nfv.2007.10.04.14.10.51
        (version=SSLv3 cipher=OTHER);
        Thu, 04 Oct 2007 14:10:51 -0700 (PDT)
X-TUID: 15ca94534f87af54
X-UID: 350
X-Length: 1893
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60007>

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
