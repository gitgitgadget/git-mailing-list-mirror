From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: remove unused parse_ref method
Date: Tue, 17 Jun 2008 08:25:28 +0200
Message-ID: <1213683928-15128-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 08:26:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8UeB-0007d8-Jn
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 08:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752015AbYFQGZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 02:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752007AbYFQGZc
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 02:25:32 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:27075 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751942AbYFQGZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 02:25:31 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3465955fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 23:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=/upBHSVAsub0eVm6AHePhxWhEJOSQ5FSG3zPBSnw2uQ=;
        b=HLV55sLkftq3WDIE8YQr0AcYHbbSPn0vamcj/kYXVCpybIJeoS5wDvrcrDZ0tqPpQ0
         UhnQvexeWSjQkkaSYKy3SRCFnCQ56VH6O85uFeEixG0zuRZHqCck3MmIjAYvuLZ9Of8H
         NsYH2XIdsCg7MpidMei/blRarQEKPHjRMOMYc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=CtwFPY4auMwz3r5V9BaTfKssTbMoO5vXDu8z58hLvi0nYZyS3a8CiRrTme8x84Znfi
         oYJHOOLuNLT8ZlrN09C0hp5o56l7zWjDdNDd/cR7dMwDWx4nXdt3HHLFCX7Xq9a59JI2
         e8CxQfOg0MiadeRTCFINiWawG2nbELr2c22SI=
Received: by 10.86.80.17 with SMTP id d17mr8733784fgb.47.1213683930014;
        Mon, 16 Jun 2008 23:25:30 -0700 (PDT)
Received: from fly ( [91.33.200.72])
        by mx.google.com with ESMTPS id 3sm12973003fge.3.2008.06.16.23.25.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 23:25:29 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8UdE-0003wj-Q7; Tue, 17 Jun 2008 08:25:28 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85262>

The parse_ref method became unused in cd1464083c, but the author
decided to leave it in.  Now it gets in the way of refactoring, so
let's remove it.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
 gitweb/gitweb.perl |   43 -------------------------------------------
 1 files changed, 0 insertions(+), 43 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 4de9647..1ed2064 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2158,49 +2158,6 @@ sub parse_commits {
 	return wantarray ? @cos : \@cos;
 }
 
-# parse ref from ref_file, given by ref_id, with given type
-sub parse_ref {
-	my $ref_file = shift;
-	my $ref_id = shift;
-	my $type = shift || git_get_type($ref_id);
-	my %ref_item;
-
-	$ref_item{'type'} = $type;
-	$ref_item{'id'} = $ref_id;
-	$ref_item{'epoch'} = 0;
-	$ref_item{'age'} = "unknown";
-	if ($type eq "tag") {
-		my %tag = parse_tag($ref_id);
-		$ref_item{'comment'} = $tag{'comment'};
-		if ($tag{'type'} eq "commit") {
-			my %co = parse_commit($tag{'object'});
-			$ref_item{'epoch'} = $co{'committer_epoch'};
-			$ref_item{'age'} = $co{'age_string'};
-		} elsif (defined($tag{'epoch'})) {
-			my $age = time - $tag{'epoch'};
-			$ref_item{'epoch'} = $tag{'epoch'};
-			$ref_item{'age'} = age_string($age);
-		}
-		$ref_item{'reftype'} = $tag{'type'};
-		$ref_item{'name'} = $tag{'name'};
-		$ref_item{'refid'} = $tag{'object'};
-	} elsif ($type eq "commit"){
-		my %co = parse_commit($ref_id);
-		$ref_item{'reftype'} = "commit";
-		$ref_item{'name'} = $ref_file;
-		$ref_item{'title'} = $co{'title'};
-		$ref_item{'refid'} = $ref_id;
-		$ref_item{'epoch'} = $co{'committer_epoch'};
-		$ref_item{'age'} = $co{'age_string'};
-	} else {
-		$ref_item{'reftype'} = $type;
-		$ref_item{'name'} = $ref_file;
-		$ref_item{'refid'} = $ref_id;
-	}
-
-	return %ref_item;
-}
-
 # parse line of git-diff-tree "raw" output
 sub parse_difftree_raw_line {
 	my $line = shift;
-- 
1.5.6.rc3.7.ged9620
