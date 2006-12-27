From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 3/6] gitweb: Precompile CGI routines for mod_perl
Date: Thu, 28 Dec 2006 00:00:52 +0100
Message-ID: <200612280000.52586.jnareb@gmail.com>
References: <200612272355.31923.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Dec 28 01:04:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gzikb-0002G6-1o
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 01:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964825AbWL1ADm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Dec 2006 19:03:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbWL1ADm
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Dec 2006 19:03:42 -0500
Received: from ug-out-1314.google.com ([66.249.92.174]:55841 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964825AbWL1ADj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Dec 2006 19:03:39 -0500
Received: by ug-out-1314.google.com with SMTP id 44so4021260uga
        for <git@vger.kernel.org>; Wed, 27 Dec 2006 16:03:39 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=L/rjAh7KVvDtiFv4tU7uTQhwWJKM4jHtKpcnkCnYyZLss8KnHtJlMC9m8/4PVxtqmk17zyeXiMNFF6NcxXT4P/dJjThGE/tSCydzJNqRCBaUXeFZR8/j7deobMk015DgZyIUg81/PbbHJoC8wbZNmxQFeP03vs9PmjGnHDa1ots=
Received: by 10.66.244.11 with SMTP id r11mr19276022ugh.1167264218876;
        Wed, 27 Dec 2006 16:03:38 -0800 (PST)
Received: from host-81-190-19-121.torun.mm.pl ( [81.190.19.121])
        by mx.google.com with ESMTP id j3sm19956330ugd.2006.12.27.16.03.38;
        Wed, 27 Dec 2006 16:03:38 -0800 (PST)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200612272355.31923.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35489>

Following advice from CGI(3pm) man page, precompile all CGI routines
for mod_perl, in the BEGIN block.


  If you want to compile without importing use the compile() method
  instead:

    use CGI();
    CGI->compile();

  This is particularly useful in a mod_perl environment, in which you
  might want to precompile all CGI routines in a startup script, and then
  import the functions individually in each mod_perl script.


Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Could help. I'm a bit unsure.

 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index bb1d66c..3888563 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -18,6 +18,10 @@ use File::Find qw();
 use File::Basename qw(basename);
 binmode STDOUT, ':utf8';
 
+BEGIN {
+	CGI->compile() if $ENV{MOD_PERL};
+}
+
 our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
-- 
1.4.4.3
