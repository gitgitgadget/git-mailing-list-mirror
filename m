From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCHv2 05/10] gitweb: Add author initials in 'blame' view, a la "git gui blame"
Date: Sat, 25 Jul 2009 00:44:05 +0200
Message-ID: <1248475450-5668-6-git-send-email-jnareb@gmail.com>
References: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Cc: Petr Baudis <pasky@suse.cz>, Fredrik Kuivinen <frekui@gmail.com>,
	Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
	Luben Tuikov <ltuikov@yahoo.com>,
	Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 25 00:44:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUTVR-0007e4-PH
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 00:44:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbZGXWom (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Jul 2009 18:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754901AbZGXWom
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Jul 2009 18:44:42 -0400
Received: from mail-bw0-f228.google.com ([209.85.218.228]:63588 "EHLO
	mail-bw0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754899AbZGXWol (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Jul 2009 18:44:41 -0400
Received: by bwz28 with SMTP id 28so1677288bwz.37
        for <git@vger.kernel.org>; Fri, 24 Jul 2009 15:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received:from:to:cc
         :subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RJgo1mXllFHULYjg414LfjZupWk+BFWPZXGFMsvfLws=;
        b=VsBj6w3frf+zcwVsnklo8slUyw1Krg3Ds3CskbsMmsGw3f+1RBIdgzGRVnKLYk9EPc
         xN+HVbSTyP2kygHuhOPb5uhinWFufrckdMPQ9L08T8f6FZbgavEGHgktqOW4pdBIDynP
         6fiIcbRWA9o941Uip8QOJYqrdUsA/7IVVKM4c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=VmyqAFMaDxM6IMFGOz20Tk7evbaS0szdXWaetZJoHaaWrlsKl6XtJwOjZIZ32SN8qZ
         brG4a0gsuVs++VCIGeOUDN36WIeGPdsab1z88u9TXY/cVnD3bbhUthFHvoZ4CK/U7S+b
         Oc3gWegeD5fmSsq+IJsuKM7jO3MCwkf77SjOw=
Received: by 10.204.120.201 with SMTP id e9mr216791bkr.187.1248475480604;
        Fri, 24 Jul 2009 15:44:40 -0700 (PDT)
Received: from localhost.localdomain (abwq33.neoplus.adsl.tpnet.pl [83.8.240.33])
        by mx.google.com with ESMTPS id 22sm6039359fkr.0.2009.07.24.15.44.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 24 Jul 2009 15:44:40 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n6OMo7sS005782;
	Sat, 25 Jul 2009 00:50:12 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n6OMnajn005776;
	Sat, 25 Jul 2009 00:49:36 +0200
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1248475450-5668-1-git-send-email-jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123963>

For example for "Junio C Hamano" initials would be "JH".  Of course
initials are added (below shortened SHA-1 of blamed commit) only if
group of lines that blame the same commit has 2 or more lines in it.

Initials are extracted using i18n /\b([[:upper:]])\B/g regexp.

Additionally initials help to distinguish boundary commits, as they
use bold weight font too (in addition to shortened SHA-1 of commit).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This version of patch differs from previous version only in more
detailed commit message.  The change it introduces are identical.

 gitweb/gitweb.perl |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 128bddd..ea1ab5f 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4855,6 +4855,14 @@ HTML
 			                             hash=>$full_rev,
 			                             file_name=>$file_name)},
 			              esc_html($short_rev));
+			if ($group_size >= 2) {
+				my @author_initials = ($author =~ /\b([[:upper:]])\B/g);
+				if (@author_initials) {
+					print "<br />" .
+					      esc_html(join('', @author_initials));
+					#           or join('.', ...)
+				}
+			}
 			print "</td>\n";
 		}
 		# 'previous' <sha1 of parent commit> <filename at commit>
-- 
1.6.3.3
