From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 2/6] gitweb: Add mod_perl version string to "generator" meta header
Date: Wed, 27 Dec 2006 23:59:51 +0100
Message-ID: <200612272359.51960.jnareb@gmail.com>
References: <200612272355.31923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:04:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzikb-0002G6-Iy
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWL1ADn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWL1ADn
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:03:43 -0500
Received: from ug-out-1314.google.com ([66.249.92.171]:55835 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964832AbWL1ADj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:03:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4021264uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 16:03:38 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=GGJW71IZDEXxmrcEUO2d/bqMlWyMKYpI4CfUgBvg3NF7haxMhBg9mMtK0PuiWqp1T3y2xzIkaVgfKKGrWTfvLjA/h5ZSRWgqVpy2WiBSpNThgPSMe59Og9OcsduG1/1c07lwlf8zMVU6UeskjImITgp6aEpVpiWWT1xj7RH9X/E=
Received: by 10.66.243.4 with SMTP id q4mr20523207ugh.1167264218440;
        Wed, 27 Dec 2006 16:03:38 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id j3sm19956330ugd.2006.12.27.16.03.37;
        Wed, 27 Dec 2006 16:03:37 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612272355.31923.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35492>

Add mod_perl version string (the value of $ENV{'MOD_PERL'} if it is
set) to "generator" meta header.

The purpose of this is to identify version of gitweb, now that
codepath may differ for gitweb run as CGI script, run under
mod_perl 1.0 and run under mod_perl 2.0.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
For example mod_perl 2.0 sets MOD_PERL to something like
"mod_perl/2.0.1".

This patch was created because further patches make gitweb to
have different codepath for mod_perl; so mod_perl version string
was added to "generator" meta header in HTML header.

 gitweb/gitweb.perl |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index aaee217..bb1d66c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1724,6 +1724,8 @@ sub git_header_html {
 		-charset => 'utf-8',
 		-status => $status,
 		-expires => $expires);
+	# the environmental variable MOD_PERL has 'mod_perl/VERSION' value if set
+	my $mod_perl_version = $ENV{'MOD_PERL'} ? " $ENV{'MOD_PERL'}" : '';
 	print <<EOF;
 <?xml version="1.0" encoding="utf-8"?>
 <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
@@ -1732,7 +1734,7 @@ sub git_header_html {
 <!-- git core binaries version $git_version -->
 <head>
 <meta http-equiv="content-type" content="$content_type; charset=utf-8"/>
-<meta name="generator" content="gitweb/$version git/$git_version"/>
+<meta name="generator" content="gitweb/$version git/$git_version$mod_perl_version"/>
 <meta name="robots" content="index, nofollow"/>
 <title>$title</title>
 EOF
-- 
1.4.4.3
