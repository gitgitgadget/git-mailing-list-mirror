From: Joe Ratterman <jratt0@gmail.com>
Subject: [PATCH] Gitweb: Avoid warnings when a repo does not have a valid HEAD
Date: Tue, 13 Dec 2011 16:35:05 -0600
Message-ID: <1323815706-10560-1-git-send-email-jratt0@gmail.com>
Cc: Joe Ratterman <jratt0@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 13 23:35:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Raawj-0006yc-7q
	for gcvg-git-2@lo.gmane.org; Tue, 13 Dec 2011 23:35:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754398Ab1LMWfT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 Dec 2011 17:35:19 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:57255 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753227Ab1LMWfS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Dec 2011 17:35:18 -0500
Received: by vbbfc26 with SMTP id fc26so151038vbb.19
        for <git@vger.kernel.org>; Tue, 13 Dec 2011 14:35:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EkRJEj9+jaWl/JYQudkSlSmmF177ggclKdbWx6kQx04=;
        b=fJOHAinO8candvr8d/hZYN1G7rHhSXr8GQ5J9Thdbg69iR/8vNgUk5KZ6FaJQ5b7d7
         4SQNHz2P5ETWcfedbLYh9kHqTJhQxA7xeb2atwsv8lXZf0h8BbyZG3k+wvY/05joWvAD
         F9FSwSX9pqEQiqgex/6ixoiBfVUZmruXTHhRE=
Received: by 10.52.99.231 with SMTP id et7mr2518287vdb.114.1323815717314;
        Tue, 13 Dec 2011 14:35:17 -0800 (PST)
Received: from localhost.localdomain (rchp4.rochester.ibm.com. [129.42.161.36])
        by mx.google.com with ESMTPS id em10sm484385vdc.6.2011.12.13.14.35.14
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 13 Dec 2011 14:35:16 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.3.ge148a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187068>

It is possible that the HEAD reference does not point to an existing
branch.  When viewing such a repository in gitweb, a message like this
one was sent to the error log:

  gitweb.cgi: Use of uninitialized value in string eq at /usr/src/git/gitweb/gitweb.cgi line 5115.

Signed-off-by: Joe Ratterman <jratt0@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4f0c3bd..5af06d6 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5440,7 +5440,7 @@ sub git_heads_body {
 	for (my $i = $from; $i <= $to; $i++) {
 		my $entry = $headlist->[$i];
 		my %ref = %$entry;
-		my $curr = $ref{'id'} eq $head;
+		my $curr = $head ? ($ref{'id'} eq $head) : 0;
 		if ($alternate) {
 			print "<tr class=\"dark\">\n";
 		} else {
-- 
1.7.7.1
