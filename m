From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH (bugfix)] gitweb: Fix passing parameters to git_project_search_form
Date: Fri,  2 Mar 2012 23:50:01 +0100
Message-ID: <1330728601-27124-1-git-send-email-jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 02 23:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3bIn-00065d-4B
	for gcvg-git-2@plane.gmane.org; Fri, 02 Mar 2012 23:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965442Ab2CBWuH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Mar 2012 17:50:07 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:55947 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965425Ab2CBWuF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2012 17:50:05 -0500
Received: by eekc41 with SMTP id c41so784412eek.19
        for <git@vger.kernel.org>; Fri, 02 Mar 2012 14:50:04 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.213.15.144 as permitted sender) client-ip=10.213.15.144;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.213.15.144 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.213.15.144])
        by 10.213.15.144 with SMTP id k16mr1309328eba.10.1330728604865 (num_hops = 1);
        Fri, 02 Mar 2012 14:50:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=CWYKfIu4TdCJRM84HRPjfPhPELkPJVUhKboeMoc67Js=;
        b=mDSpH+mYW5V8HvCsEcSAe6bYFLCMwormtZy48xQlb6w4FcL5j5h4inv+0qPFvAGc5p
         M9OtrtmeQcd+wS7f+XoAO1tzHqq5xUaghEB6DvIDZnjlsqzSTOSyixJAxoLxFWBrBdz2
         hQiLo2MuP9RWRDLrqBh/8OPhVdmbVUDNhdEt9o1IUy2jNZyFsaoM8fvgPcBzXEEXPL5M
         IxO+P7PCTmbMzEJOM6SS91LkBoGmNJtsf1rUvZQRM4PoNSlIP33hPKPSRN5VfFL1Wqa3
         a/AbU9861aYnlG9QxfCJcq4vUvUGFPq1027o6BCEJBDuCKc8OiPW8auHU0mjQdsUu1/R
         YhuA==
Received: by 10.213.15.144 with SMTP id k16mr1007662eba.10.1330728604754;
        Fri, 02 Mar 2012 14:50:04 -0800 (PST)
Received: from localhost.localdomain (abvt148.neoplus.adsl.tpnet.pl. [83.8.217.148])
        by mx.google.com with ESMTPS id r5sm25774866eef.6.2012.03.02.14.50.03
        (version=SSLv3 cipher=OTHER);
        Fri, 02 Mar 2012 14:50:04 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192072>

The git_project_search_form() subroutine, introduced in a1e1b2d
(gitweb: improve usability of projects search form, 2012-01-31) didn't
get its arguments from caller correctly.  Gitweb worked correctly
thanks to sticky-ness of form fields in CGI.pm... but it make UTF-8
fix for project search not working.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Brown paper bug (a1e1b2d is in master).  I am extremly sorry about that.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7398be1..e2e6a73 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5263,7 +5263,7 @@ sub git_patchset_body {
 # . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . . .
 
 sub git_project_search_form {
-	my ($searchtext, $search_use_regexp);
+	my ($searchtext, $search_use_regexp) = @_;
 
 	my $limit = '';
 	if ($project_filter) {
-- 
1.7.9
