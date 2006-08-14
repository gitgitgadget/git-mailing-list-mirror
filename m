From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 8/9] gitweb: True fix: Support for the standard mime.types map in gitweb
Date: Mon, 14 Aug 2006 02:16:33 +0200
Message-ID: <200608140216.34150.jnareb@gmail.com>
References: <200608140202.46160.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Mon Aug 14 12:17:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCZVB-0001tP-55
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 12:16:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbWHNKQt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Aug 2006 06:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751977AbWHNKQt
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Aug 2006 06:16:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:653 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751985AbWHNKQm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Aug 2006 06:16:42 -0400
Received: by nf-out-0910.google.com with SMTP id a4so20995nfc
        for <git@vger.kernel.org>; Mon, 14 Aug 2006 03:16:41 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=ALAeirkryFGbZrrOI3OsgpvzW0nK7MY0a2pGvQHsODUd++MNN30tDCPVyCLkfkk8SU8Qe7RcTNNuU808CyHfN6XpxPRtBJDSewgk2bvE9dzxMm/xZ5zwuhpd2Xx7RR5NEdltrW9awA1om3W1PrGkF52XQeWCUfpocsOSplfIWq8=
Received: by 10.48.210.20 with SMTP id i20mr1019282nfg;
        Mon, 14 Aug 2006 03:16:41 -0700 (PDT)
Received: from host-81-190-23-158.torun.mm.pl ( [81.190.23.158])
        by mx.gmail.com with ESMTP id m16sm9637471nfc.2006.08.14.03.16.41;
        Mon, 14 Aug 2006 03:16:41 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608140202.46160.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25341>

True fix for error in mimetype_guess, error introduced in original commit
2d00737489b8c61ed616b261c7c9bd314e2b0b41 and later fixed temporarily
by commenting out the line that caused error in commit
57bd4d3523efecf60197040cad34154aff4ddf80.

Gitweb now supports mime.types map $mimetypes_file relative to project.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Perhaps commit message should consist only of:

gitweb: Gitweb now supports mime.types map $mimetypes_file relative to project.

 gitweb/gitweb.perl |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 52ae2aa..15875a8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -880,7 +880,10 @@ sub mimetype_guess {
 
 	if ($mimetypes_file) {
 		my $file = $mimetypes_file;
-		#$file =~ m#^/# or $file = "$projectroot/$path/$file";
+		if ($file !~ m!^/!) { # if it is relative path
+			# it is relative to project
+			$file = "$projectroot/$project/$file";
+		}
 		$mime = mimetype_guess_file($filename, $file);
 	}
 	$mime ||= mimetype_guess_file($filename, '/etc/mime.types');
-- 
1.4.1.1
