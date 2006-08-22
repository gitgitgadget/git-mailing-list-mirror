From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Drop the href() params which keys are not in %mapping
Date: Tue, 22 Aug 2006 19:05:24 +0200
Message-ID: <11562663253739-git-send-email-jnareb@gmail.com>
References: <200608211739.32993.jnareb@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue Aug 22 19:06:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFZh6-0008LJ-Lv
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 19:05:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932200AbWHVRFg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 13:05:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932192AbWHVRFg
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 13:05:36 -0400
Received: from mail.fuw.edu.pl ([193.0.80.14]:31374 "EHLO mail.fuw.edu.pl")
	by vger.kernel.org with ESMTP id S932189AbWHVRFf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Aug 2006 13:05:35 -0400
Received: from front.fuw.edu.pl (front.fuw.edu.pl [193.0.83.59])
	by mail.fuw.edu.pl (8.13.6/8.13.6) with ESMTP id k7MH4HQl005254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 22 Aug 2006 19:04:17 +0200
Received: from front.fuw.edu.pl (IDENT:10582@localhost [127.0.0.1])
	by front.fuw.edu.pl (8.13.3/8.12.4) with ESMTP id k7MH5QnG012457;
	Tue, 22 Aug 2006 19:05:26 +0200
Received: (from jnareb@localhost)
	by front.fuw.edu.pl (8.13.3/8.12.4/Submit) id k7MH5P6I012456;
	Tue, 22 Aug 2006 19:05:25 +0200
To: git@vger.kernel.org
X-Mailer: git-send-email 1.3.0
In-Reply-To: <200608211739.32993.jnareb@gmail.com>
X-Scanned-By: MIMEDefang 2.56 on 193.0.80.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25862>

If someone would enter parameter name incorrectly, and some key of
%params is not found in %mapping hash, the parameter is now
ignored. Change introduced by Martin Waitz in commit
  756d2f064b2419fcdf9cd9c851f352e2a4f75103
tried to do that, but it left empty value and there was doubled ";;"
in returned string.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 063735d..89ef5e7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -278,7 +278,7 @@ sub href(%) {
 	my $href = "$my_uri?";
 	$href .= esc_param( join(";",
 		map {
-			"$mapping{$_}=$params{$_}" if defined $params{$_}
+			defined $params{$_} ? "$mapping{$_}=$params{$_}" : ()
 		} keys %params
 	) );
 
-- 
1.4.1.1
