From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Strip trailing slashes from $path in git_get_hash_by_path
Date: Thu, 21 Sep 2006 14:23:29 +0200
Message-ID: <200609211423.29729.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 21 14:37:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQNnl-0001sS-A7
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 14:37:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbWIUMhJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 08:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751160AbWIUMhJ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 08:37:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.170]:33736 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750853AbWIUMhG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 08:37:06 -0400
Received: by ug-out-1314.google.com with SMTP id o38so117900ugd
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 05:37:04 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=hodco606insLlYJFAWGLar70S6WnkrQUtJA7oqCNzBPSf/DhI3M370ivyOnx699qQmj5hEw6RH5AwTh8joJXbVZab07J6wnrvsukUYzibitG3x3fk5bW93PUg/9i4/TFUNCTYzIMO42a/qQ4MN2OWePSuLukLFvdPhMyqHHAbXg=
Received: by 10.67.103.7 with SMTP id f7mr9176093ugm;
        Thu, 21 Sep 2006 05:37:04 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id e33sm904654ugd.2006.09.21.05.37.03;
        Thu, 21 Sep 2006 05:37:04 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27476>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
While
        git ls-tree $base -- dirname
shows dirname entry (that's what we want)
        git ls-tree $base -- dirname/
shows directory _contents_.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index fb8d37e..403bba1 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -719,7 +719,7 @@ sub git_get_hash_by_path {
 	my $base = shift;
 	my $path = shift || return undef;
 
-	my $tree = $base;
+	$path =~ s,/+$,,;
 
 	open my $fd, "-|", git_cmd(), "ls-tree", $base, "--", $path
 		or die_error(undef, "Open git-ls-tree failed");
-- 
1.4.2.1
