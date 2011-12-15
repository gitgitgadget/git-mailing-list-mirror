From: Joe Ratterman <jratt0@gmail.com>
Subject: [PATCH] Gitweb: Avoid warnings when a repo does not have a valid HEAD
Date: Thu, 15 Dec 2011 14:58:57 -0600
Message-ID: <1323982737-19065-1-git-send-email-jratt0@gmail.com>
Cc: Joe Ratterman <jratt0@gmail.com>
To: gitster@pobox.com, git@vger.kernel.org, jnareb@gmail.com
X-From: git-owner@vger.kernel.org Thu Dec 15 21:59:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbIOb-0000KY-7q
	for gcvg-git-2@lo.gmane.org; Thu, 15 Dec 2011 21:59:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759215Ab1LOU7N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Dec 2011 15:59:13 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:45771 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751910Ab1LOU7M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2011 15:59:12 -0500
Received: by faar15 with SMTP id r15so2680224faa.19
        for <git@vger.kernel.org>; Thu, 15 Dec 2011 12:59:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=EkRJEj9+jaWl/JYQudkSlSmmF177ggclKdbWx6kQx04=;
        b=SjK6HbfBC3qwAafAmQLVglIli4LA6LH1OSV2scscFMaAbvQue/dZDWRccOXAgmkoRN
         yMqpzEjSMpplGrZvbsqPFTsWLx3ZZ5NVl1nBBagknQhkigEMU6yVMBZ7r88Nm6GIKmMc
         RkAFc3ZW6awJt0nl3a4rAO/kNuu/6bWKksItE=
Received: by 10.180.93.228 with SMTP id cx4mr8444569wib.19.1323982751359;
        Thu, 15 Dec 2011 12:59:11 -0800 (PST)
Received: from localhost.localdomain (rchp4.rochester.ibm.com. [129.42.161.36])
        by mx.google.com with ESMTPS id gb16sm11227588wbb.12.2011.12.15.12.59.09
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 15 Dec 2011 12:59:10 -0800 (PST)
X-Mailer: git-send-email 1.7.7.1.3.ge148a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187233>

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
