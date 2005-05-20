From: Andres Salomon <dilinger@athenacr.com>
Subject: add conf file support to gitweb
Date: Fri, 20 May 2005 15:29:45 -0400
Message-ID: <1116617385.15157.19.camel@jack.dev.in.athenacr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-mtGheKk4YqadldMo6myP"
X-From: git-owner@vger.kernel.org Fri May 20 21:30:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DZDAz-0003HY-I1
	for gcvg-git@gmane.org; Fri, 20 May 2005 21:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261557AbVETT3x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 May 2005 15:29:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261552AbVETT3x
	(ORCPT <rfc822;git-outgoing>); Fri, 20 May 2005 15:29:53 -0400
Received: from [66.150.84.1] ([66.150.84.1]:47568 "EHLO
	rowdy.as.in.athenacr.com") by vger.kernel.org with ESMTP
	id S261557AbVETT3q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2005 15:29:46 -0400
Received: from [192.168.0.6] (helo=jack.dev.in.athenacr.com)
	by rowdy.as.in.athenacr.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DZDBq-0001aP-00; Fri, 20 May 2005 15:29:46 -0400
To: git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>
X-Mailer: Evolution 2.0.2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-mtGheKk4YqadldMo6myP
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi,

The attached patch makes gitweb read and eval variables from
an /etc/gitweb.conf file.  This is useful for distributions; I'm
packaging gitweb for debian, and want to have a separate config file
that users can edit that won't get overwritten when they upgrade gitweb.
Even if you don't take this patch, please consider some other method
that decouples the configuration from the gitweb.cgi script.



--=-mtGheKk4YqadldMo6myP
Content-Disposition: attachment; filename=gitweb.conf.patch
Content-Type: text/x-patch; name=gitweb.conf.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: gitweb.cgi
===================================================================
--- 8b7a4b08ba4892970a2531d4c1584e3881a13586/gitweb.cgi  (mode:100644)
+++ fe8329b147103e115e2ad727bfca34c2ecfa901d/gitweb.cgi  (mode:100755)
@@ -40,6 +40,16 @@
 #my $projects_list = $projectroot;
 my $projects_list = "index/index.aux";
 
+# allow config file to override settings above
+if (-r '/etc/gitweb.conf') {
+	open(CONF, '/etc/gitweb.conf') || die_error(undef, "Cannot open /etc/gitweb.conf.");
+	while (<CONF>) {
+		chomp;
+		eval($_) if ($_ =~ /^\s*(\$[\w]+)\s*=\s*(.*)\s*$/);
+	}
+	close(CONF);
+}
+
 # input validation and dispatch
 my $action = $cgi->param('a');
 if (defined $action) {

--=-mtGheKk4YqadldMo6myP--

