From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCHv5 2/3] gitweb: webserver config for PATH_INFO
Date: Sat, 31 Jan 2009 02:31:51 +0100
Message-ID: <1233365512-7130-3-git-send-email-giuseppe.bilotta@gmail.com>
References: <1233365512-7130-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1233365512-7130-2-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jan 31 02:40:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LT4qC-0002FT-Sz
	for gcvg-git-2@gmane.org; Sat, 31 Jan 2009 02:40:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753776AbZAaBiX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Jan 2009 20:38:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754421AbZAaBiW
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jan 2009 20:38:22 -0500
Received: from mail-bw0-f12.google.com ([209.85.218.12]:50924 "EHLO
	mail-bw0-f12.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754403AbZAaBiV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jan 2009 20:38:21 -0500
X-Greylist: delayed 387 seconds by postgrey-1.27 at vger.kernel.org; Fri, 30 Jan 2009 20:38:20 EST
Received: by bwz5 with SMTP id 5so350678bwz.13
        for <git@vger.kernel.org>; Fri, 30 Jan 2009 17:38:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=FOL4fCSZrCqdWxr+3E4OTqtLa7Lu4bmRKy/ti2D+lO4=;
        b=GU1VduxT1AZAZTQ7AdDZXOtQ8K+IUzYxklzbKbQLS3qaaIS3ydQ3d5iyD4A9MnxaSq
         0aQESlu9VOMsc+me1ZfUxShS4TXKJTgtXkYJ4Fyzzs2IzG1+TRf9fKbGTD0pZxntF5Vh
         ns70Rv/lq89tmH/fpnkSyp99ngYatbndWH54k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=aBB8pVOEy8uCzAmAcHVjBGAtT2x7gYjxwfJ9lCCK4YOr6H/O8VGen6Ggg4ewFBHlxU
         E3uxz/47ByRl1n7FEGMECXy7kvCumKpf2D/jBGc6iHJOsrazjviutfSyUjcAOFBHbbU+
         9VkFf7tlB6X8c1DrW4y42VKAIQR0HLq7jUr0U=
Received: by 10.181.134.12 with SMTP id l12mr651166bkn.26.1233365510986;
        Fri, 30 Jan 2009 17:31:50 -0800 (PST)
Received: from localhost ([94.37.14.37])
        by mx.google.com with ESMTPS id z10sm2010179fka.33.2009.01.30.17.31.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 30 Jan 2009 17:31:50 -0800 (PST)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1233365512-7130-2-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107901>

Document some possible Apache configurations when the path_info feature
is enabled in gitweb.
---
 gitweb/README |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/gitweb/README b/gitweb/README
index 825162a..52ad88b 100644
--- a/gitweb/README
+++ b/gitweb/README
@@ -322,6 +322,82 @@ something like the following in your gitweb.conf (or gitweb_config.perl) file:
   $home_link = "/";
 
 
+PATH_INFO usage
+-----------------------
+If you enable PATH_INFO usage in gitweb by putting
+
+   $feature{'pathinfo'}{'default'} = [1];
+
+in your gitweb.conf, it is possible to set up your server so that it
+consumes and produces URLs in the form
+
+http://git.example.com/project.git/shortlog/sometag
+
+by using a configuration such as the following, that assumes that
+/var/www/gitweb is the DocumentRoot of your webserver, and that it
+contains the gitweb.cgi script and complementary static files
+(stylesheet, favicon):
+
+<VirtualHost *:80>
+	ServerAlias git.example.com
+
+	DocumentRoot /var/www/gitweb
+
+	<Directory /var/www/gitweb>
+		Options ExecCGI
+		AddHandler cgi-script cgi
+
+		DirectoryIndex gitweb.cgi
+
+		RewriteEngine On
+		RewriteCond %{REQUEST_FILENAME} !-f
+		RewriteCond %{REQUEST_FILENAME} !-d
+		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+	</Directory>
+</VirtualHost>
+
+The rewrite rule guarantees that existing static files will be properly
+served, whereas any other URL will be passed to gitweb as PATH_INFO
+parameter.
+
+Notice that in this case you don't need special settings for
+@stylesheets, $my_uri and $home_link, but you lose "dumb client" access
+to your project .git dirs. A possible workaround for the latter is the
+following: in your project root dir (e.g. /pub/git) have the projects
+named without a .git extension (e.g. /pub/git/project instead of
+/pub/git/project.git) and configure Apache as follows:
+
+<VirtualHost *:80>
+	ServerAlias git.example.com
+
+	DocumentRoot /var/www/gitweb
+
+	AliasMatch ^(/.*?)(\.git)(/.*)? /pub/git$1$3
+	<Directory /var/www/gitweb>
+		Options ExecCGI
+		AddHandler cgi-script cgi
+
+		DirectoryIndex gitweb.cgi
+
+		RewriteEngine On
+		RewriteCond %{REQUEST_FILENAME} !-f
+		RewriteCond %{REQUEST_FILENAME} !-d
+		RewriteRule ^.* /gitweb.cgi/$0 [L,PT]
+	</Directory>
+</VirtualHost>
+
+The additional AliasMatch makes it so that
+
+http://git.example.com/project.git
+
+will give raw access to the project's git dir (so that the project can
+be cloned), while
+
+http://git.example.com/project
+
+will provide human-friendly gitweb access.
+
+
 Originally written by:
   Kay Sievers <kay.sievers@vrfy.org>
 
-- 
1.5.6.5
