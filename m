From: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
Subject: [PATCH] git-instaweb: Add option to reuse previous config file
Date: Tue,  1 Jun 2010 19:14:05 +0530
Message-ID: <1275399845-13311-1-git-send-email-pavan.sss1991@gmail.com>
Cc: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: git@vger.kernel.org, jnareb@gmail.com, chriscool@tuxfamily.org,
	pasky@ucw.cz
X-From: git-owner@vger.kernel.org Tue Jun 01 15:51:15 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJRs8-0002LJ-7X
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 15:51:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756725Ab0FANul (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jun 2010 09:50:41 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:34431 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756695Ab0FANuk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 09:50:40 -0400
Received: by pwj2 with SMTP id 2so1145893pwj.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 06:50:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=umUdOsPEKjY5Jg8pBhHHNUqGI0S0fhoOTc8qXx34S7A=;
        b=E18XBZOfXFl041F3OTIozxov5fi990LGt1J2atJsBSJHSV3ONl5kHr7M2uE8m41AU6
         iwMFGtGVFvySQip6ox1Z9dsGNX5tmSiw6+GeaPAN49UnAh7VFsxVdBW4EohhA73q5KRl
         Aq7obnmCLb+VgyS+01VppqRHi6jC58Su8eXsw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=NuYH5w9j3B1LSFdh5YT6LcOdSUfNGPPEvJLolQKGFaLduM341WwO2d4kiK06bDvCkk
         qZYv/nbESk4Htc7xil9wrek7Vbn4H7mEphGZPfXj4YT8PWccgqdypUOI5PmDyVlKI2Nd
         otQDXmXXxr66WS4x4d5KrdmHZUfI2yyqPatf8=
Received: by 10.141.187.20 with SMTP id o20mr4535176rvp.13.1275399860875;
        Tue, 01 Jun 2010 06:44:20 -0700 (PDT)
Received: from localhost.localdomain ([202.63.112.23])
        by mx.google.com with ESMTPS id b2sm41186rvn.7.2010.06.01.06.44.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 06:44:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.390.gb0a41.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148114>

Add an option to git-instaweb which allows the usage of the old
gitweb_config.perl situated in '.git/gitweb' dir. When the option
is in use, gitweb_conf() won't be used and thus the gitweb_config.perl
won't be overwritten.

Usage:
	git instaweb --reuse-config

Example:
	When I use git-instaweb, it is hard to add the line (Use of
highlighting support) $feature{'highlight'}{'default'] = [1]; to the
gitweb_config.perl file everytime I initiate the server. With this,
it's enough to use this option.

Also update Documentation of git-instaweb

Signed-off-by: Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
---
 Documentation/git-instaweb.txt |    5 ++++-
 git-instaweb.sh                |    8 +++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-instaweb.txt b/Documentation/git-instaweb.txt
index 2c3c4d2..0e7e20b 100644
--- a/Documentation/git-instaweb.txt
+++ b/Documentation/git-instaweb.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git instaweb' [--local] [--httpd=<httpd>] [--port=<port>]
-               [--browser=<browser>]
+               [--browser=<browser>] [--reuse-config]
 'git instaweb' [--start] [--stop] [--restart]
 
 DESCRIPTION
@@ -49,6 +49,9 @@ OPTIONS
 	linkgit:git-web--browse[1] for more information about this. If
 	the script fails, the URL will be printed to stdout.
 
+--reuse-config::
+	The previous gitweb_config.perl will not be overwritten.
+
 --start::
 	Start the httpd instance and exit.  This does not generate
 	any of the configuration files for spawning a new instance.
diff --git a/git-instaweb.sh b/git-instaweb.sh
index 1af4d5a..7b8b8d1 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -13,6 +13,7 @@ p,port=        the port to bind to
 d,httpd=       the command to launch
 b,browser=     the browser to launch
 m,module-path= the module path (only needed for apache2)
+reuse-config	To use the previous gitweb_config.perl file from GIT_DIR. It will not be overwritten.
  Action
 stop           stop the web server
 start          start the web server
@@ -27,6 +28,7 @@ httpd="$(git config --get instaweb.httpd)"
 root="$(git config --get instaweb.gitwebdir)"
 port=$(git config --get instaweb.port)
 module_path="$(git config --get instaweb.modulepath)"
+no_reuse=true
 
 conf="$GIT_DIR/gitweb/httpd.conf"
 
@@ -171,6 +173,10 @@ do
 		shift
 		module_path="$1"
 		;;
+	--reuse-config)
+		shift
+		no_reuse=false
+		;;
 	--)
 		;;
 	*)
@@ -551,7 +557,7 @@ our \$projects_list = \$projectroot;
 EOF
 }
 
-gitweb_conf
+test "$no_reuse" = true && gitweb_conf
 
 resolve_full_httpd
 mkdir -p "$fqgitdir/gitweb/$httpd_only"
-- 
1.7.1.390.gb0a41.dirty
