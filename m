From: Techlive Zheng <techlivezheng@gmail.com>
Subject: [PATCH] subtree.sh: Use raw subject and body modifier "%B" instead of "%s%n%n%b"
Date: Fri, 10 Aug 2012 09:15:58 +0800
Message-ID: <1344561358-2953-2-git-send-email-techlivezheng@gmail.com>
References: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
Cc: apenwarr@gmail.com, greened@obbligato.org,
	Techlive Zheng <techlivezheng@gmail.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Aug 10 03:15:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzdpB-0004Yr-RD
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 03:15:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755653Ab2HJBPa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Aug 2012 21:15:30 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:40521 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755380Ab2HJBP3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Aug 2012 21:15:29 -0400
Received: by mail-pb0-f46.google.com with SMTP id rr13so1807450pbb.19
        for <git@vger.kernel.org>; Thu, 09 Aug 2012 18:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=c0HaM1OqH2reJrYYbIHFpDjJe3aLAb5QUvd+aXXCzoc=;
        b=OIYGkLgT7VYwKpffoPBRU/pDGu8eHFdjWe6Tjh/SobwG5XYnuVzYcpGtUlaca32T0j
         GQ7Yzzl3En7UC8qe7IUu3oMm7sYh+nvi+9AHbLmu3WDz2yyUV0MQq/P++EKqTDYk9Jpi
         3FCgMZHG7MQKIByqIc69ReecKyvWn7lBbqJdE4B40un7URJQdRDLjWb1iVFSSs1c1lBB
         y3enoyAQ6oHmFpW1N3eYlsQVp1RoVTCTGVrH6+qEJkKA7y1STwmo62e44sCRrWAO7/Yx
         KB9swA7eSr8OzETiIVhljCno2pHPJ9NnsWyWKdR5Cb/OixnSNSAZY5P27kMS3OcE7J9T
         aeoA==
Received: by 10.68.217.233 with SMTP id pb9mr8064891pbc.140.1344561329162;
        Thu, 09 Aug 2012 18:15:29 -0700 (PDT)
Received: from home.techlive.me ([122.244.154.180])
        by mx.google.com with ESMTPS id gh9sm2187321pbc.20.2012.08.09.18.15.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 09 Aug 2012 18:15:28 -0700 (PDT)
X-Mailer: git-send-email 1.7.11.4
In-Reply-To: <1344561358-2953-1-git-send-email-techlivezheng@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203197>

"%s%n%n%b" is not always equal to "%B". If the commit msg does not have
a body, this will append an extra new-line character to the msg title
which would cause the splited commit has a new sha1 hash. In most cases,
this does not matter, but for a project which did not merged using this
script initially, the 'split' command would not genereate the same
commits as the orginal which may cause conflicts.

Signed-off-by: Techlive Zheng <techlivezheng@gmail.com>
---
 contrib/subtree/git-subtree.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index 920c664..5598210 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -296,7 +296,7 @@ copy_commit()
 	# We're going to set some environment vars here, so
 	# do it in a subshell to get rid of them safely later
 	debug copy_commit "{$1}" "{$2}" "{$3}"
-	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%s%n%n%b' "$1" |
+	git log -1 --pretty=format:'%an%n%ae%n%ad%n%cn%n%ce%n%cd%n%B' "$1" |
 	(
 		read GIT_AUTHOR_NAME
 		read GIT_AUTHOR_EMAIL
-- 
1.7.11.4
