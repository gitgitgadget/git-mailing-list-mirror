From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: [PATCH 5/6] gitweb: remove PATH_INFO from $my_url and $my_uri
Date: Sun, 21 Sep 2008 22:57:42 +0200
Message-ID: <1222030663-22540-6-git-send-email-giuseppe.bilotta@gmail.com>
References: <1222030663-22540-1-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-2-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-3-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-4-git-send-email-giuseppe.bilotta@gmail.com>
 <1222030663-22540-5-git-send-email-giuseppe.bilotta@gmail.com>
Cc: Jakub Narebski <jnareb@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Lea Wiemann <lewiemann@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 22:58:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhW17-0002jI-Fp
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 22:58:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752755AbYIUU5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 16:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752723AbYIUU5r
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 16:57:47 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:19993 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752726AbYIUU5o (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 16:57:44 -0400
Received: by ug-out-1314.google.com with SMTP id k3so1260968ugf.37
        for <git@vger.kernel.org>; Sun, 21 Sep 2008 13:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=hY8/4RZeTFrVGCUVb0jLSqCD5MnYhpzzLWxOR1gt44g=;
        b=n1njrKzAOJDY68G8rwn8TA6T3HbYRVWfSznOzRufy8jupibjR07sC3NZWPxjAHnk/H
         4u2mb4OApwmWfVr+boeUIt578+M61q8BKEt2kbZerB0v9o7vOaFhuZ0xz8ox+h0jdb9z
         2+mu+tPkQoNpAB6+tTxa5ErGkd0TkEJta3Vf0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W8EqlJorxoDnhuhr5DUlpj8vE6AaJ8EfLnWhPPZs9eQbONrnenCUc5hcSYIRVH+BV8
         ZQNsPeQBVeCRRJ3SjRWZFBDOeEqbHiYU/mfOBI0ORgrbXn3oaDtZqLwMYz2RPhhNh4l1
         /vg93KBkYiQ3Ub7JnGHa0Xf4sWBhBcINsGln0=
Received: by 10.210.129.10 with SMTP id b10mr3848956ebd.26.1222030663983;
        Sun, 21 Sep 2008 13:57:43 -0700 (PDT)
Received: from localhost ( [94.37.17.250])
        by mx.google.com with ESMTPS id 7sm6239863eyb.1.2008.09.21.13.57.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 21 Sep 2008 13:57:43 -0700 (PDT)
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <1222030663-22540-5-git-send-email-giuseppe.bilotta@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96435>

This patch (combined with appropriate server configuration) allows usage
of the gitweb CGI script as DirectoryIndex for the server root even when
the pathinfo feature is enabled.

Signed-off-by: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
---
 gitweb/gitweb.perl |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0dd2526..4a91d07 100755
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
1.5.6.5
