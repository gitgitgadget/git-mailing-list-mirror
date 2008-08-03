From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Sun,  3 Aug 2008 20:02:25 +0200
Message-ID: <1217786545-30685-1-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 03 20:03:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KPhvD-0007yl-OU
	for gcvg-git-2@gmane.org; Sun, 03 Aug 2008 20:03:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752201AbYHCSCJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Aug 2008 14:02:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752097AbYHCSCJ
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Aug 2008 14:02:09 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:6447 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751861AbYHCSCI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Aug 2008 14:02:08 -0400
Received: by fg-out-1718.google.com with SMTP id 19so849090fgg.17
        for <git@vger.kernel.org>; Sun, 03 Aug 2008 11:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=zME0I8IGZFqE1AkmHw4kOdcC1g81ZXf6Wa0NjJ0fHXc=;
        b=NPOSLH5mra66M8ZYyHbpmt7IWHMnVrs+jxaXBJoXKdV/Wn32RExg7l16Hm1ZowApCw
         Qc4s/MnMEVtJgihwN0M/+b/N5dwAnaPHsQlolqkUKtw+LnZ3m/U5+x5NrwyvniLc30Vy
         w+iKHuyDnnBA9jE1HaqgUQj+1lPLhjjrKe+PE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=HFKXV9GNTGr3wW+CZc7kRLlyw5jWZNZBQ5OEIwS/Bcs03J59Mbb/TiSXm31ieDHA9T
         OiMrd+vE4BfnpJhiUeIKYx2TzFXX1oyMKRJOspUAGZfHYYQMBDWyIF9As0csR/+Nuujc
         2Q6V0m96BmE3F7+BjqtxH8/YkMHboW7ae+4oY=
Received: by 10.86.99.9 with SMTP id w9mr9582293fgb.70.1217786526426;
        Sun, 03 Aug 2008 11:02:06 -0700 (PDT)
Received: from localhost ( [94.37.6.145])
        by mx.google.com with ESMTPS id d4sm4522790fga.8.2008.08.03.11.02.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 03 Aug 2008 11:02:05 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91257>

This patch (combined with appropriate server configuration) allows usage
of the gitweb CGI script as DirectoryIndex for the server root even when
the pathinfo feature is enabled.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ba1f71b..9c8bcab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -26,6 +26,10 @@ our $cgi = new CGI;
 our $version = "++GIT_VERSION++";
 our $my_url = $cgi->url();
 our $my_uri = $cgi->url(-absolute => 1);
+if (my $path_info = $ENV{"PATH_INFO"}) {
+	$my_url =~ s,$path_info$,,;
+	$my_uri =~ s,$path_info$,,;
+}
 
 # core git executable to use
 # this can just be "git" if your webserver has a sensible PATH
-- 
1.5.6.3
