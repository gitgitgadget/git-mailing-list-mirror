From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH v2] gitweb: Do not show 'patch' link for merge commits
Date: Fri, 9 Oct 2009 14:10:14 +0200
Message-ID: <200910091410.15904.jnareb@gmail.com>
References: <20090930201953.22301.73887.stgit@localhost.localdomain> <20091001075540.GA13436@coredump.intra.peff.net> <200910011118.02875.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Junio Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 09 14:16:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MwEOc-0004lH-8e
	for gcvg-git-2@lo.gmane.org; Fri, 09 Oct 2009 14:16:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760203AbZJIMKb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Oct 2009 08:10:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756028AbZJIMKa
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Oct 2009 08:10:30 -0400
Received: from fg-out-1718.google.com ([72.14.220.155]:35135 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754194AbZJIMKa (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Oct 2009 08:10:30 -0400
Received: by fg-out-1718.google.com with SMTP id 22so276761fge.1
        for <git@vger.kernel.org>; Fri, 09 Oct 2009 05:10:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=k8aOZuMBxTeQOhdNODDr8ISvzksVuSllZrODQMl1O4o=;
        b=IaEQ/uw8vhdQbbxMncqBa1Qt+5e3ZcYWlxutk6/DNMINfmfZCoDyrHpZgEsH8a8vm9
         YxlOyxMeQlLwWMTn1X0eDGxAG+9h+w8K5cG2KUDOckBas/vFW+swqrjdg+J5q4PuqSq3
         DRAwwZVr5kj5h1hqNuAERLB1X3maqi2/iqK/M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=wC9UZOfHYqtbxRCArQZwdNlVq2EQXME2tWLchM8r0wh+F+yzlEQDB2cpkaFTiT/Hqg
         qo/wJDQHLT7SnK3TXMcsfCrX5sc7pL6F4boVei3syoFRqnecJ0AUws7gMI+TaOypwZj7
         mXDxi0hXmrc1bKH/c/0wSyuori1xEZauhvs50=
Received: by 10.86.103.19 with SMTP id a19mr2297256fgc.54.1255090219024;
        Fri, 09 Oct 2009 05:10:19 -0700 (PDT)
Received: from ?192.168.1.13? (abve46.neoplus.adsl.tpnet.pl [83.8.202.46])
        by mx.google.com with ESMTPS id 4sm1867619fgg.23.2009.10.09.05.10.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 09 Oct 2009 05:10:18 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200910011118.02875.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129792>

The 'patch' view is about generating text/plain patch that can be
given to "git am", and "git am" doesn't understand merges anyway.
Therefore link to 'patch' view should not be shown for merge commits.

Also call to git-format-patch inside the 'patch' action would fail
when 'patch' action is called for a merge commit, with "Reading
git-format-patch failed" text as 'patch' view body.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
On Thu, 1 Oct 2009, Jakub Narebski wrote:

> I'll send v2 of this patch in a bit.

Here it is.

Changes since v1:
 * Do not show 'patch' link for merge commits not only in 'commit'
   view, but also in 'commitdiff' view (more complete)
 * 'patch' link is shown also for root (parentless) commits; it
   works correctly thanks to passing '--root' option to git-format-patch
   (remove unnecessary restriction)
 * better commit message thanks to discussion with Jeff King

 gitweb/gitweb.perl |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 24b2193..14f31dc 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -5328,7 +5328,7 @@ sub git_commit {
 			} @$parents ) .
 			')';
 	}
-	if (gitweb_check_feature('patches')) {
+	if (gitweb_check_feature('patches') && @$parents <= 1) {
 		$formats_nav .= " | " .
 			$cgi->a({-href => href(action=>"patch", -replay=>1)},
 				"patch");
@@ -5616,7 +5616,7 @@ sub git_commitdiff {
 		$formats_nav =
 			$cgi->a({-href => href(action=>"commitdiff_plain", -replay=>1)},
 			        "raw");
-		if ($patch_max) {
+		if ($patch_max &&  && @{$co{'parents'}} <= 1) {
 			$formats_nav .= " | " .
 				$cgi->a({-href => href(action=>"patch", -replay=>1)},
 					"patch");
@@ -5824,7 +5824,7 @@ sub git_commitdiff_plain {
 
 # format-patch-style patches
 sub git_patch {
-	git_commitdiff(-format => 'patch', -single=> 1);
+	git_commitdiff(-format => 'patch', -single => 1);
 }
 
 sub git_patches {
-- 
1.6.4.2
