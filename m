From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 10/15] contrib: related: group persons with same email
Date: Sat, 12 Oct 2013 02:06:12 -0500
Message-ID: <1381561584-20529-4-git-send-email-felipe.contreras@gmail.com>
References: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Cc: Duy Nguyen <pclouds@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 12 09:12:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUtNW-00052U-36
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754113Ab3JLHMi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:38 -0400
Received: from mail-oa0-f42.google.com ([209.85.219.42]:49960 "EHLO
	mail-oa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab3JLHMd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:33 -0400
Received: by mail-oa0-f42.google.com with SMTP id g12so3120046oah.1
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Gl5AZbQX2NNKOAFKC2EXTk4pJD9lGg9i6ygotN+e0TE=;
        b=MqoEg+BTsCZMrNNrstJ5N8JYZKve52Tuz8JbYT13qWD7ytGmh62jy3RPC36UJLaNuZ
         ytvveckJKqdWFZ5ZxtZsnJJebRSz+ZOAE1UuKWJNikIabB2TUhRMsaKZEODaoNs3bAr8
         UNr04DWzzz3Tu2pA/oKbr5MU9gwVaIE7K5vPwJB4yu6pQWSN0I46AmTBVgvP7CWWqhao
         obng5HTvk6+G7tLaSCsiCYeEC2BSThga6fPob2QHqowyKPkXMuBz/10dtlSFfM5d2GJ9
         mE6XlqCnM1HxyKHFAm6iGJmq7dK96Yo8BN5bT94GfWkYlu2JnKYs4px7fPeywo2XK7BO
         xzBw==
X-Received: by 10.60.51.7 with SMTP id g7mr18185691oeo.6.1381561953427;
        Sat, 12 Oct 2013 00:12:33 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id nw5sm28649121obc.9.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:32 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235995>

Suggested-by: Duy Nguyen <pclouds@gmail.com>
Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    |  2 +-
 contrib/related/test-related.t | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index f94f5f4..3399307 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -56,7 +56,7 @@ class Persons
   end
 
   def self.get(name, email)
-    id = [name, email]
+    id = email.downcase
     person = @@index[id]
     if not person
       person = @@index[id] = Person.new(name, email)
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index 9da2693..a19ad32 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -44,8 +44,7 @@ test_expect_success "others" "
 	git format-patch --stdout -1 master > patch &&
 	git related patch | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (author: 33%)
-	John Poppins <john@doe.com> (author: 33%)
+	John Poppins <john@doe.com> (author: 66%)
 	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
@@ -56,8 +55,7 @@ test_expect_success "multiple patches" "
 	git format-patch --stdout -1 master^ > patch2 &&
 	git related patch1 patch2 | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (author: 25%)
-	John Poppins <john@doe.com> (author: 25%)
+	John Poppins <john@doe.com> (author: 50%)
 	Jon Stewart <jon@stewart.com> (reviewer: 25%, author: 25%)
 	Pablo Escobar <pablo@escobar.com> (author: 25%)
 	EOF
@@ -67,8 +65,7 @@ test_expect_success "multiple patches" "
 test_expect_success "from committish" "
 	git related -1 master | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (author: 33%)
-	John Poppins <john@doe.com> (author: 33%)
+	John Poppins <john@doe.com> (author: 66%)
 	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
@@ -77,8 +74,7 @@ test_expect_success "from committish" "
 test_expect_success "from single rev committish" "
 	git related -1 master | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com> (author: 33%)
-	John Poppins <john@doe.com> (author: 33%)
+	John Poppins <john@doe.com> (author: 66%)
 	Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
 	EOF
 	test_cmp expected actual
-- 
1.8.4-fc
