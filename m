From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 02/10] gitweb: Mark boundary commits in 'blame' view
Date: Sat, 25 Jul 2009 00:44:02 +0200
Message-ID: <1248475450-5668-3-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:41:46 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTST-0006Z0-If
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:41:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754882AbZGXWli (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754877AbZGXWli
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:41:38 -0400
Received: from mail-fx0-f218.google.com ([209.85.220.218]:33890 "EHLO
	mail-fx0-f218.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754876AbZGXWlh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:41:37 -0400
Received: by mail-fx0-f218.google.com with SMTP id 18so1687100fxm.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ZE2rJHUIzwfibPe2I7E48kiYnx0zNHm7q9V3zMNX0iY=;
        b=i4/HbtOwW9y1MEDfTidnO8KHdtB+RUl6anPqbJ28ITI1SfFXkw3gDGLDqxUzUBrY/s
         +XbwT41F8mwqr2pf6qals5FoklISvSOyXDwHjp3jBoPpqp9GyFFi2hXq5MzgYw7NGfx5
         cYSY9YzmndHgrgN3OTQ1cP4xwwobcl6sW8YCg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=JsHxfIW4ptyKVMrbbyrVrrCo1y+6QPVKz78w1zMylBU7iKMmFX5nQv9o/LVsbvYY6y
         qPhthplqiYas0UIMZ0gahKxfr16WW2VPWHf0SgJrPc25ExEjNONzb1t9H7kRNsZhWBTk
         pCEnI2SqoR6HweNtJ7dQ0U3gnAPdxLnTcbbwU=
Received: by 10.103.242.1 with SMTP id u1mr1984988mur.113.1248475297074;
        Fri, 24 Jul 2009 15:41:37 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id 7sm14812880mup.54.2009.07.24.15.41.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:41:36 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMl3YR005739;
	Sat, 25 Jul 2009 00:47:08 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMkWqu005736;
	Sat, 25 Jul 2009 00:46:32 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123959>

Use "boundary" class to mark boundary commits, which currently results
in using bold weight font for SHA-1 of a commit (to be more exact for
all text in the first cell in row, that contains SHA-1 of a commit).

Detecting boundary commits is done by watching for "boundary" header
in "git blame -p" output.  Because this header doesn't carry
additional data the regular expression for blame header fields
had to be slightly adjusted.

With current gitweb API only root (parentless) commits can be boundary
commits.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Formatting (styling) of boundary commits is currently very minimal.

This is just resend of previous version of patch.

 gitweb/gitweb.css  |    4 ++++
 gitweb/gitweb.perl |    6 ++++--
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.css b/gitweb/gitweb.css
index 70b7c2f..f47709b 100644
--- a/gitweb/gitweb.css
+++ b/gitweb/gitweb.css
@@ -242,6 +242,10 @@ tr.dark:hover {
 	background-color: #edece6;
 }
 
+tr.boundary td.sha1 {
+	font-weight: bold;
+}
+
 td {
 	padding: 2px 5px;
 	font-size: 100%;
diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7fbd5ff..3078b92 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4826,7 +4826,7 @@ HTML
 		while ($data = <$fd>) {
 			chomp $data;
 			last if ($data =~ s/^\t//); # contents of line
-			if ($data =~ /^(\S+) (.*)$/) {
+			if ($data =~ /^(\S+)(?: (.*))?$/) {
 				$meta->{$1} = $2;
 			}
 		}
@@ -4838,7 +4838,9 @@ HTML
 		if ($group_size) {
 			$current_color = ($current_color + 1) % $num_colors;
 		}
-		print "<tr id=\"l$lineno\" class=\"$rev_color[$current_color]\">\n";
+		my $tr_class = $rev_color[$current_color];
+		$tr_class .= ' boundary' if (exists $meta->{'boundary'});
+		print "<tr id=\"l$lineno\" class=\"$tr_class\">\n";
 		if ($group_size) {
 			print "<td class=\"sha1\"";
 			print " title=\"". esc_html($author) . ", $date\"";
-- 
1.6.3.3
