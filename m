From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC/PATCH] gitweb: Add "all parents" (-m) view to commitdiff
Date: Tue, 24 Oct 2006 00:35:23 +0200
Message-ID: <200610240035.23963.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Oct 24 00:35:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc8O5-0002Za-GQ
	for gcvg-git@gmane.org; Tue, 24 Oct 2006 00:35:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbWJWWfJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 18:35:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbWJWWfI
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 18:35:08 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:54773 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1751526AbWJWWfH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Oct 2006 18:35:07 -0400
Received: by nf-out-0910.google.com with SMTP id c2so2559423nfe
        for <git@vger.kernel.org>; Mon, 23 Oct 2006 15:35:05 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=l+Lvt3vs0CQXsHjCE1vKSRLHayLY39eQampvgMe27nliLboKmKO0LJ7v5vPynZIRRFgELhqoyq9S5/Tqui17U81b7cby/GugUO/AN03nPe1wUHwQ9cRIXk8JM8NjWGwb7cjZqOTiqb6QpC55cRF+L928FXhNhYHTalw1cCnZ2us=
Received: by 10.49.80.12 with SMTP id h12mr7544431nfl;
        Mon, 23 Oct 2006 15:35:00 -0700 (PDT)
Received: from host-81-190-23-110.torun.mm.pl ( [81.190.23.110])
        by mx.google.com with ESMTP id k9sm2884002nfc.2006.10.23.15.35.00;
        Mon, 23 Oct 2006 15:35:00 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29894>

Add "all parents" view/link to commitdiff, which uses '-m' to show
diff to all parents of a merge commit.

This is instead of having link "combined" to combined (-c) or compact
combined (--cc) diff for a merge commit, till we have syntax
highlighting for combined diff.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   11 ++++++++++-
 1 files changed, 10 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 255487d..84b4abb 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3289,7 +3289,7 @@ sub git_commitdiff {
 			                       hash=>$hash, hash_parent=>$hash_parent)},
 			        "raw");
 
-		if (defined $hash_parent) {
+		if (defined $hash_parent && substr($hash_parent, 0, 1) ne '-') {
 			# commitdiff with two commits given
 			$formats_nav .=
 				' (' .
@@ -3310,6 +3310,15 @@ sub git_commitdiff {
 				')';
 		} else {
 			# merge commit
+			$formats_nav .= ' | ';
+			if (defined $hash_parent && $hash_parent eq '-m') {
+				$formats_nav .= 'all parents';
+			} else {
+				$formats_nav .=
+									$cgi->a({-href => href(action=>"commitdiff",
+					                       hash=>$hash, hash_parent=>'-m')},
+					        'all parents');
+			}
 			$formats_nav .=
 				' (' .
 				join(' ', map {
-- 
1.4.2.1
