From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: text files for 'blob_plain' action without charset by default
Date: Sat, 17 Jun 2006 18:07:24 +0200
Organization: At home
Message-ID: <e719bi$vfd$1@sea.gmane.org>
References: <200606171332.15591.jnareb@gmail.com> <20060617153540.GI2609@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Sat Jun 17 18:07:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrdKl-0007Fj-6g
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 18:07:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751634AbWFQQHa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Jun 2006 12:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbWFQQHa
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Jun 2006 12:07:30 -0400
Received: from main.gmane.org ([80.91.229.2]:48328 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751634AbWFQQHa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 17 Jun 2006 12:07:30 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1FrdKT-0007DI-Lk
	for git@vger.kernel.org; Sat, 17 Jun 2006 18:07:21 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 18:07:21 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 17 Jun 2006 18:07:21 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22022>

$default_text_plain_charset is undefined (no specified charset) by
default. Additionally ':raw' layer for binmode is used for outputting file
content.

---
This patch depends on the previous patch in the thread:
  "gitweb: safely output binary files for 'blob_plain' action"
Contrary to the previous patch it is not based on other unrelated gitweb.cgi
patches (this changes only line numbers in patch).

 gitweb/gitweb.cgi |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

53209981db06a5dde7c59caada279bf63d329da8
diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index acac1f4..f082e5d 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -44,7 +44,7 @@ my $projects_list =   "index/index.aux";
 
 # default blob_plain mimetype and default charset for text/plain blob
 my $default_blob_plain_mimetype = 'text/plain';
-my $default_text_plain_charset  = 'utf-8';     # can be undefined
+my $default_text_plain_charset  = undef;       # was: 'utf-8'
 
 # input validation and dispatch
 my $action = $cgi->param('a');
@@ -1451,9 +1451,9 @@ sub git_blob_plain {
 
        print $cgi->header(-type => "$type", '-content-disposition' => "inline; filename=\"$save_as\"");
        undef $/;
-       binmode STDOUT, ':raw' unless $type =~ m/^text\//;
+       binmode STDOUT, ':raw';
        print <$fd>;
-       binmode STDOUT, ':utf8' unless $type =~ m/^text\//;
+       binmode STDOUT, ':utf8'; # as set at the beginning of gitweb.cgi
        $/ = "\n";
        close $fd;
 }
-- 
1.3.0
