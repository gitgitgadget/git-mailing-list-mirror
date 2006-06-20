From: Timo Hirvonen <tihirvon@gmail.com>
Subject: [PATCH] gitweb: Start search from HEAD
Date: Tue, 20 Jun 2006 15:25:15 +0300
Message-ID: <20060620152515.23e59396.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Jun 20 14:25:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FsfIJ-0008QW-Fo
	for gcvg-git@gmane.org; Tue, 20 Jun 2006 14:25:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965040AbWFTMZU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 08:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965056AbWFTMZU
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 08:25:20 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:30630 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S965040AbWFTMZT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Jun 2006 08:25:19 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1396132nfa
        for <git@vger.kernel.org>; Tue, 20 Jun 2006 05:25:18 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=Rr8RGigEM3a6RyXzy44G4zV5sQM6mHv36rPCpSLXZlgv+P2EaKJ23u8dIDj9rb5C/JI3bzBb9KpnZ754rBXuER985wEz4Z5UxIM13wgiQULoHtI/R4NYK//iaphNb0trlN7B9hVKtpt7UbkGY5LRPYwQJ43ZhfpGgGSYqBm73RU=
Received: by 10.48.232.17 with SMTP id e17mr3665251nfh;
        Tue, 20 Jun 2006 05:25:18 -0700 (PDT)
Received: from garlic.home.net ( [82.128.229.197])
        by mx.gmail.com with ESMTP id k24sm6753808nfc.2006.06.20.05.25.16;
        Tue, 20 Jun 2006 05:25:17 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.18; i686-pc-linux-gnu)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22197>

Starting search from whatever the current "h" parameter points to is
wrong.  Sometimes it doesn't give all the expected results or may even
fail if h points to an object which is not a commit.

Signed-off-by: Timo Hirvonen <tihirvon@gmail.com>
---

 This patch is against the "next" branch.

 gitweb/gitweb.cgi |   11 +----------
 1 files changed, 1 insertions(+), 10 deletions(-)

diff --git a/gitweb/gitweb.cgi b/gitweb/gitweb.cgi
index 78e6dd0..3ad23a3 100755
--- a/gitweb/gitweb.cgi
+++ b/gitweb/gitweb.cgi
@@ -292,14 +292,7 @@ EOF
 		if (!defined $searchtext) {
 			$searchtext = "";
 		}
-		my $search_hash;
-		if (defined $hash) {
-			$search_hash = $hash;
-		} else {
-			$search_hash  = "HEAD";
-		}
 		$cgi->param("a", "search");
-		$cgi->param("h", $search_hash);
 		print $cgi->startform(-method => "get", -action => $my_uri) .
 		      "<div class=\"search\">\n" .
 		      $cgi->hidden(-name => "p") . "\n" .
@@ -2328,9 +2321,7 @@ sub git_search {
 	if (!defined $searchtext) {
 		die_error("", "Text field empty.");
 	}
-	if (!defined $hash) {
-		$hash = git_read_head($project);
-	}
+	$hash = "HEAD";
 	my %co = git_read_commit($hash);
 	if (!%co) {
 		die_error(undef, "Unknown commit object.");
-- 
1.4.0.gd281
