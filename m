From: Thiago Farina <tfransosi@gmail.com>
Subject: [Patch v3] string-list: Document STRING_LIST_INIT_* macros.
Date: Sun,  5 Sep 2010 21:13:11 -0300
Message-ID: <1283731991-15080-1-git-send-email-tfransosi@gmail.com>
Cc: jrnieder@gmail.com, Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 06 02:13:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsPKz-00062y-6H
	for gcvg-git-2@lo.gmane.org; Mon, 06 Sep 2010 02:13:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754894Ab0IFANY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Sep 2010 20:13:24 -0400
Received: from mail-gw0-f46.google.com ([74.125.83.46]:53724 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab0IFANX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Sep 2010 20:13:23 -0400
Received: by gwj17 with SMTP id 17so1379631gwj.19
        for <git@vger.kernel.org>; Sun, 05 Sep 2010 17:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=XYGd7rXodH94eCKllh551WRpJH1NmgGvR0PEVSBT6X0=;
        b=rimnaPCqnfO69tAcF6ebbAcLDF0XBjDQw/DTDB5Xsh0Czx9L5hjYytRLRsftP/123d
         ztAVy3dGD1pxreBLIkPjWtUE7bhgB3aBW4xUaFeDynmH8zLm3jkuIYCcdZFs6YGoD0Q6
         31XTds6i2+yFstEduRR2Qh7bRiGsQsCmFDyAU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qIb4I4ZWClpIcF9JrRcsR5RIpyJn1KyeFZJAhzkp9rRXJ9BzyAi+4EB65ybLbqHTwk
         iXHZnLI9kdNcUbXO1506J8StqIJS9I03pmkCZaAiY9Va5EQM9cC0EDQhQ5iIOaaN02cx
         odfm4wsY/IhkkoTl/VEiKiOKYIxmmWrBTef1Y=
Received: by 10.151.103.12 with SMTP id f12mr1650616ybm.386.1283732002709;
        Sun, 05 Sep 2010 17:13:22 -0700 (PDT)
Received: from localhost ([186.205.0.204])
        by mx.google.com with ESMTPS id q3sm5240334ybe.2.2010.09.05.17.13.21
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 05 Sep 2010 17:13:22 -0700 (PDT)
X-Mailer: git-send-email 1.7.2.3.313.gcd15
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155503>

Clarify the modern ways to initialize a string_list. Text roughly
based on the analogous passage from api-strbuf.txt.

(Note: Based on the demo patch of Jonathan Nieder).

Signed-off-by: Thiago Farina <tfransosi@gmail.com>
---
 Documentation/technical/api-string-list.txt |   16 ++++++++++------
 1 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
index 3f575bd..f689163 100644
--- a/Documentation/technical/api-string-list.txt
+++ b/Documentation/technical/api-string-list.txt
@@ -11,10 +11,15 @@ The caller:
 
 . Allocates and clears a `struct string_list` variable.
 
-. Initializes the members. You might want to set the flag `strdup_strings`
-  if the strings should be strdup()ed. For example, this is necessary
-  when you add something like git_path("..."), since that function returns
-  a static buffer that will change with the next call to git_path().
+. Initializes the members. A string_list might be initialize by
+  `= STRING_LIST_INT_NODUP` or `= STRING_LIST_INIT_DUP` before it can be used.
+
+  Strings in lists initialized with the _DUP variant will be
+  automatically strdup()ed on insertion and free()ed on removal.
+  For example, this is necessary when you add something like
+  git_path("..."), since that function returns a static buffer
+  that will change with the next call to git_path().
+
 +
 If you need something advanced, you can manually malloc() the `items`
 member (you need this if you add things later) and you should set the
@@ -34,10 +39,9 @@ member (you need this if you add things later) and you should set the
 Example:
 
 ----
-struct string_list list;
+struct string_list list = STRING_LIST_DUP;
 int i;
 
-memset(&list, 0, sizeof(struct string_list));
 string_list_append(&list, "foo");
 string_list_append(&list, "bar");
 for (i = 0; i < list.nr; i++)
-- 
1.7.2.3.313.gcd15
