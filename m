From: Roland Mas <lolando@debian.org>
Subject: [PATCH] Update gitweb.perl to current CGI.pm API
Date: Thu, 16 Oct 2014 08:54:47 +0200
Message-ID: <87lhogzeq0.fsf@placard.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>, 765525@bugs.debian.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 16 09:01:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xef3d-0007Ia-7k
	for gcvg-git-2@plane.gmane.org; Thu, 16 Oct 2014 09:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751116AbaJPHBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Oct 2014 03:01:04 -0400
Received: from mirepoix.gnurandal.net ([195.154.230.83]:57457 "EHLO
	mirepoix.gnurandal.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750805AbaJPHBD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Oct 2014 03:01:03 -0400
X-Greylist: delayed 365 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Oct 2014 03:01:03 EDT
Received: from polymir (polymir.placard.fr.eu.org [IPv6:2001:bc8:3a7e:210:5604:a6ff:fe48:8421])
	by mirepoix.gnurandal.net (Postfix) with ESMTPA id F1F503BA;
	Thu, 16 Oct 2014 08:54:47 +0200 (CEST)
Received: from roland by polymir with local (Exim 4.84)
	(envelope-from <lolando@debian.org>)
	id 1XeexT-0007Wu-Hg; Thu, 16 Oct 2014 08:54:47 +0200
Mail-Copies-To: never
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

  This simple two-line patch fixes a bug that makes gitweb unusable on
systems where the installed CGI.pm is version 4.04 or later (such as on
Debian unstable).  That version removed the startform method, which had
previously been deprecated in favour of start_form since 2009.

  I don't have any specific tests for that change, but it does help
fixing the testsuite of FusionForge (which includes a test of its Git
plugin, involving gitweb).

  For reference, this is Debian bug #765525 (http://bugs.debian.org/765525).

  (I'm not subscribed to the git@vger mailing-list; please Cc me on
replies.)

  Thanks,

Roland.

>From 1b74cfb8568927a307f165e428455789398f6d61 Mon Sep 17 00:00:00 2001
From: Roland Mas <lolando@debian.org>
Date: Thu, 16 Oct 2014 00:05:25 +0200
Subject: [PATCH] Update gitweb.perl to current CGI.pm API

CGI.pm 4.04 removed the startform method, which had previously been
deprecated in favour of start_form.  Updated gitweb.perl accordingly.

Signed-off-by: Roland Mas <lolando@debian.org>
---
 gitweb/gitweb.perl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index a9f57d6..ccf7516 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4100,7 +4100,7 @@ sub print_search_form {
 	if ($use_pathinfo) {
 		$action .= "/".esc_url($project);
 	}
-	print $cgi->startform(-method => "get", -action => $action) .
+	print $cgi->start_form(-method => "get", -action => $action) .
 	      "<div class=\"search\">\n" .
 	      (!$use_pathinfo &&
 	      $cgi->input({-name=>"p", -value=>$project, -type=>"hidden"}) . "\n") .
@@ -5510,7 +5510,7 @@ sub git_project_search_form {
 	}
 
 	print "<div class=\"projsearch\">\n";
-	print $cgi->startform(-method => 'get', -action => $my_uri) .
+	print $cgi->start_form(-method => 'get', -action => $my_uri) .
 	      $cgi->hidden(-name => 'a', -value => 'project_list')  . "\n";
 	print $cgi->hidden(-name => 'pf', -value => $project_filter). "\n"
 		if (defined $project_filter);
-- 
2.1.1
