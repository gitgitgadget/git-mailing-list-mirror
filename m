From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 4/5] gitweb: Add git_url subroutine, and use it to quote full URLs
Date: Tue, 26 Sep 2006 01:58:41 +0200
Message-ID: <200609260158.42247.jnareb@gmail.com>
References: <200609260153.08503.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Tue Sep 26 02:00:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS0NH-0005hZ-PJ
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 02:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751785AbWIZAAP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Sep 2006 20:00:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbWIZAAO
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Sep 2006 20:00:14 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:1112 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751785AbWIZAAF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Sep 2006 20:00:05 -0400
Received: by ug-out-1314.google.com with SMTP id o38so538810ugd
        for <git@vger.kernel.org>; Mon, 25 Sep 2006 17:00:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=M1hKmcAKwz8qkadbvR47XTM/VJCtWQLLzB1nEpZ+NnZpfWWKEIQSpY0DtGvMWfpHoCakenCZa5kB8sz13W/8yPECOcqzMBRsf4W6Eu0eDLIMX0KM6tA1j/We/XKQ/au+zNShz4NIzBZP3RQaqrDGAUzRcCQXGqw+9YR1T3XW6hI=
Received: by 10.66.221.19 with SMTP id t19mr96141ugg;
        Mon, 25 Sep 2006 17:00:04 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id s1sm2153117uge.2006.09.25.17.00.03;
        Mon, 25 Sep 2006 17:00:03 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609260153.08503.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27760>

Add git_url subroutine, which does what git_param did before commit
a2f3db2f5de2a3667b0e038aa65e3e097e642e7d, and is used to quote full
URLs, currently only $home_link.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
It will also be used in patch inspired by
  "[RFC][PATCH] gitweb: Make the Git logo link target to point to the homepage"
  Message-ID: <7virjes7dq.fsf@assigned-by-dhcp.cox.net>
  http://permalink.gmane.org/gmane.comp.version-control.git/27619

 gitweb/gitweb.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fce9a6..b51e061 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -446,6 +446,15 @@ sub esc_param {
 	return $str;
 }
 
+# quote unsafe chars in whole URL, so some charactrs cannot be quoted
+sub esc_url {
+	my $str = shift;
+	$str =~ s/([^A-Za-z0-9\-_.~();\/;?:@&=])/sprintf("%%%02X", ord($1))/eg;
+	$str =~ s/\+/%2B/g;
+	$str =~ s/ /\+/g;
+	return $str;
+}
+
 # replace invalid utf8 character with SUBSTITUTION sequence
 sub esc_html {
 	my $str = shift;
@@ -1362,7 +1371,7 @@ EOF
 	      "<a href=\"http://www.kernel.org/pub/software/scm/git/docs/\" title=\"git documentation\">" .
 	      "<img src=\"$logo\" width=\"72\" height=\"27\" alt=\"git\" style=\"float:right; border-width:0px;\"/>" .
 	      "</a>\n";
-	print $cgi->a({-href => esc_param($home_link)}, $home_link_str) . " / ";
+	print $cgi->a({-href => esc_url($home_link)}, $home_link_str) . " / ";
 	if (defined $project) {
 		print $cgi->a({-href => href(action=>"summary")}, esc_html($project));
 		if (defined $action) {
-- 
1.4.2.1
