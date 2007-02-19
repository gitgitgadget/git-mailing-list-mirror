From: Andy Parkins <andyparkins@gmail.com>
Subject: [PATCH] Replace literal STRLEN_ #defines in refs.h with compiler evaluated expressions
Date: Mon, 19 Feb 2007 20:01:46 +0000
Message-ID: <200702192001.46669.andyparkins@gmail.com>
References: <17881.62094.56975.799862@lisa.zopyra.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 19 21:04:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEkh-0006u3-IP
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbXBSUEo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:04:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932529AbXBSUEo
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:04:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:46796 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932515AbXBSUEn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:04:43 -0500
Received: by ug-out-1314.google.com with SMTP id 44so653694uga
        for <git@vger.kernel.org>; Mon, 19 Feb 2007 12:04:42 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:in-reply-to:references:from:date:subject:to:x-tuid:x-uid:x-length:mime-version:content-transfer-encoding:content-disposition:message-id;
        b=Je7KuiY7/5S98BFr7IBJaKRa2WEtsscJ7B1VT6cznuP00RlFJqFM4SPfBcx3qeD1z0nMGlKXOUqLodAs8ke6aOdlpzNmzCF7I/NvGfAeN2FNPRo58kn/CO6wOHTyJ4Cx/VL/CGHzVo/X1R+tUQVdvoSQWTmfr5cNao9JTZzp2xM=
Received: by 10.67.106.3 with SMTP id i3mr7252203ugm.1171915481828;
        Mon, 19 Feb 2007 12:04:41 -0800 (PST)
Received: from grissom.internal.parkins.org.uk ( [84.201.153.164])
        by mx.google.com with ESMTP id o24sm9619437ugd.2007.02.19.12.04.39;
        Mon, 19 Feb 2007 12:04:39 -0800 (PST)
In-Reply-To: <17881.62094.56975.799862@lisa.zopyra.com>
X-TUID: af43033f1fef53c1
X-UID: 247
X-Length: 1997
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40142>

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

On top of my previous patch.


 refs.h |   11 ++++++-----
 1 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/refs.h b/refs.h
index a986b42..6761095 100644
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
1.5.0.rc4.gb4d2
