From: Brian Norris <computersforpeace@gmail.com>
Subject: [PATCH] send-email: fix uninitialized var warning for $smtp_auth
Date: Fri, 18 Sep 2015 15:12:50 -0700
Message-ID: <1442614370-39880-1-git-send-email-computersforpeace@gmail.com>
Cc: Brian Norris <computersforpeace@gmail.com>,
	Jan Viktorin <viktorin@rehivetech.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Junio C Hamano <gitster@pobox.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 19 00:13:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zd3uh-0005CY-2d
	for gcvg-git-2@plane.gmane.org; Sat, 19 Sep 2015 00:13:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754623AbbIRWNp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Sep 2015 18:13:45 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:36100 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754480AbbIRWNp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Sep 2015 18:13:45 -0400
Received: by padhk3 with SMTP id hk3so61274259pad.3
        for <git@vger.kernel.org>; Fri, 18 Sep 2015 15:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=rQprs//46gPaRAbh4ici2PW3DAUG0T6mEEXF3qcsyGU=;
        b=UJqE8ZSjHmzxYXQ2QoeIbjge9zYWwCo8yydRljabOgqTLaWUudYoJ3wIg9FBxGVuT9
         Qjstps0xVyqV1R0Xeqk/tICvx22/GJDMHTVVLrNxpBwhnbW4bTjVi/W8H/cqTi0fqvyU
         Ef2R+TFzi6eI3aF51Vcr5/hceWRYwqQPJrF37zd9WQjQk5Df4RGdwMLSElR+fyO6j1Hr
         n7sFQ3flPb1hHZVBOXCP2FbUbcQ4AFTmGwKEY9SX1MgyeWzJGnvj1IGHkqS170gK7LCx
         gyltJ1viZeX4K92Fkf85/4VYjH5Q4VQ98DGWRy4Yww13HHF6RYnw9F02FGs3x4dPIF3q
         DSUg==
X-Received: by 10.66.119.202 with SMTP id kw10mr9611788pab.38.1442614424807;
        Fri, 18 Sep 2015 15:13:44 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id b7sm10828222pbu.20.2015.09.18.15.13.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 18 Sep 2015 15:13:44 -0700 (PDT)
X-Mailer: git-send-email 2.6.0.rc0.131.gf624c3d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278223>

On the latest version of git-send-email, I see this error just before
running SMTP auth (I didn't provide any --smtp-auth= parameter):

  Use of uninitialized value $smtp_auth in pattern match (m//) at /usr/local/google/home/briannorris/git/git/git-send-email.perl line 1139.

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Cc: Jan Viktorin <viktorin@rehivetech.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index c5a3f766f7fd..e3ff44b4d0cd 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -1136,7 +1136,7 @@ sub smtp_auth_maybe {
 
 	# Check mechanism naming as defined in:
 	# https://tools.ietf.org/html/rfc4422#page-8
-	if ($smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
+	if ($smtp_auth && $smtp_auth !~ /^(\b[A-Z0-9-_]{1,20}\s*)*$/) {
 		die "invalid smtp auth: '${smtp_auth}'";
 	}
 
-- 
2.6.0.rc0.131.gf624c3d
