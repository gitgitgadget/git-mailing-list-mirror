From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Fix thinko in git_tags and git_heads
Date: Tue, 19 Sep 2006 20:47:27 +0200
Message-ID: <200609192047.27454.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue Sep 19 21:49:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPlaY-0004rT-7L
	for gcvg-git@gmane.org; Tue, 19 Sep 2006 21:49:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbWISTst (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 15:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbWISTst
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 15:48:49 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:56443 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1752012AbWISTsr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 15:48:47 -0400
Received: by nf-out-0910.google.com with SMTP id o25so246683nfa
        for <git@vger.kernel.org>; Tue, 19 Sep 2006 12:48:46 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=k2m6BpstBeKRyPjgggcCpg37qK8J2bjwlt6rMf9vnR19VT5Z7PAQ4zi2zZMEB4yiklUhVufZNhdQDgqijU2hprR1MN37Q2qDIbYf0HF5d+QYbJveZTO5vbateXMofWH586V2OgQpmpZ3KX6HsPUTiD8w2Lzpbjp+yVk6Svr2hTs=
Received: by 10.78.97.7 with SMTP id u7mr4104849hub;
        Tue, 19 Sep 2006 12:48:46 -0700 (PDT)
Received: from host-81-190-31-133.torun.mm.pl ( [81.190.31.133])
        by mx.gmail.com with ESMTP id 24sm11338169huf.2006.09.19.12.48.45;
        Tue, 19 Sep 2006 12:48:45 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27280>

git_get_refs_list always return reference to list (and reference to
hash which we ignore), so $taglist (in git_tags) and $headlist (in
git_heads) are always defined, but @$taglist / @$headlist might be
empty. Replaced incorrect "if (defined @$taglist)" with
"if (@$taglist)" in git_tags and respectively in git_heads.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 34311ee..9445fa7 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2565,7 +2565,7 @@ sub git_tags {
 	git_print_header_div('summary', $project);
 
 	my ($taglist) = git_get_refs_list("tags");
-	if (defined @$taglist) {
+	if (@$taglist) {
 		git_tags_body($taglist);
 	}
 	git_footer_html();
@@ -2578,7 +2578,7 @@ sub git_heads {
 	git_print_header_div('summary', $project);
 
 	my ($headlist) = git_get_refs_list("heads");
-	if (defined @$headlist) {
+	if (@$headlist) {
 		git_heads_body($headlist, $head);
 	}
 	git_footer_html();
-- 
1.4.2.1
