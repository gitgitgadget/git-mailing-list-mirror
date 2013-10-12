From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v10 06/15] contrib: related: print the amount of involvement
Date: Sat, 12 Oct 2013 02:06:14 -0500
Message-ID: <1381561584-20529-6-git-send-email-felipe.contreras@gmail.com>
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
	id 1VUtNX-00052U-5G
	for gcvg-git-2@plane.gmane.org; Sat, 12 Oct 2013 09:12:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754187Ab3JLHMo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Oct 2013 03:12:44 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:54892 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754085Ab3JLHMj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Oct 2013 03:12:39 -0400
Received: by mail-ob0-f172.google.com with SMTP id vb8so3469352obc.31
        for <git@vger.kernel.org>; Sat, 12 Oct 2013 00:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V9WlxHhwpV1PxX0+G8CjXv8augh4VHc+gK6Wyb7g7nM=;
        b=wCJWmLLQH2tt07Ez4KmaZq2qQ9lwDfzivxaqaiW3XcWxFLMhlbhbW75DQdWR4Mns4A
         WXdnYAZlm8+uq2f3V1vBIERsISaCmfzWjI4oxVDstkEb4fV4rrXTEi8z4fELXJI3wIdD
         Ev4tstrWp4Pqjtwl3j3VWrxQ7/xIuzULBe2LSfTjUM0fpNbJcYkk+kg93ZVgd1e3vfk/
         eUr78jNBDS6CigMTioW8Qj1Co4YZQbu7ItGbMWVUpN3anExROwOeCFjBgm5wiKjVkvpD
         5MAtf2fiFWR1k506XNmtqmH8B2KBvnfJUIio+LNV/a901eiokSh0fqGOO6VMMpxu74Rl
         ZbUw==
X-Received: by 10.60.124.14 with SMTP id me14mr17714496oeb.4.1381561958898;
        Sat, 12 Oct 2013 00:12:38 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id r3sm101384600oep.2.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 12 Oct 2013 00:12:38 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1381561584-20529-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235996>

100% means the person was involved in all the commits, in one way or the
other.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/related/git-related    |  2 +-
 contrib/related/test-related.t | 30 +++++++++++++++---------------
 2 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/contrib/related/git-related b/contrib/related/git-related
index 80e1f17..ffce839 100755
--- a/contrib/related/git-related
+++ b/contrib/related/git-related
@@ -163,5 +163,5 @@ end
 count_per_person.each do |person, count|
   percent = count.to_f * 100 / commits.size
   next if percent < $min_percent
-  puts person
+  puts '%s (involved: %u%%)' % [person, percent]
 end
diff --git a/contrib/related/test-related.t b/contrib/related/test-related.t
index 39b4fe9..ec2680a 100755
--- a/contrib/related/test-related.t
+++ b/contrib/related/test-related.t
@@ -34,8 +34,8 @@ test_expect_success "basic" "
 	git format-patch --stdout -1 basic > patch &&
 	git related patch | sort > actual &&
 	cat > expected <<-EOF &&
-	Jon Stewart <jon@stewart.com>
-	Pablo Escobar <pablo@escobar.com>
+	Jon Stewart <jon@stewart.com> (involved: 50%)
+	Pablo Escobar <pablo@escobar.com> (involved: 50%)
 	EOF
 	test_cmp expected actual
 "
@@ -44,9 +44,9 @@ test_expect_success "others" "
 	git format-patch --stdout -1 master > patch &&
 	git related patch | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com>
-	John Poppins <john@doe.com>
-	Jon Stewart <jon@stewart.com>
+	John Doe <john@doe.com> (involved: 33%)
+	John Poppins <john@doe.com> (involved: 33%)
+	Jon Stewart <jon@stewart.com> (involved: 66%)
 	EOF
 	test_cmp expected actual
 "
@@ -56,10 +56,10 @@ test_expect_success "multiple patches" "
 	git format-patch --stdout -1 master^ > patch2 &&
 	git related patch1 patch2 | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com>
-	John Poppins <john@doe.com>
-	Jon Stewart <jon@stewart.com>
-	Pablo Escobar <pablo@escobar.com>
+	John Doe <john@doe.com> (involved: 25%)
+	John Poppins <john@doe.com> (involved: 25%)
+	Jon Stewart <jon@stewart.com> (involved: 50%)
+	Pablo Escobar <pablo@escobar.com> (involved: 25%)
 	EOF
 	test_cmp expected actual
 "
@@ -67,9 +67,9 @@ test_expect_success "multiple patches" "
 test_expect_success "from committish" "
 	git related -1 master | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com>
-	John Poppins <john@doe.com>
-	Jon Stewart <jon@stewart.com>
+	John Doe <john@doe.com> (involved: 33%)
+	John Poppins <john@doe.com> (involved: 33%)
+	Jon Stewart <jon@stewart.com> (involved: 66%)
 	EOF
 	test_cmp expected actual
 "
@@ -77,9 +77,9 @@ test_expect_success "from committish" "
 test_expect_success "from single rev committish" "
 	git related -1 master | sort > actual &&
 	cat > expected <<-EOF &&
-	John Doe <john@doe.com>
-	John Poppins <john@doe.com>
-	Jon Stewart <jon@stewart.com>
+	John Doe <john@doe.com> (involved: 33%)
+	John Poppins <john@doe.com> (involved: 33%)
+	Jon Stewart <jon@stewart.com> (involved: 66%)
 	EOF
 	test_cmp expected actual
 "
-- 
1.8.4-fc
