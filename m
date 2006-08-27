From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 1/2] gitweb: Remove unused git_get_{preceding,following}_references
Date: Sun, 27 Aug 2006 23:44:38 +0200
Message-ID: <200608272344.38542.jnareb@gmail.com>
References: <200608272343.14653.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Sun Aug 27 23:45:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GHSRq-0004Nu-FP
	for gcvg-git@gmane.org; Sun, 27 Aug 2006 23:45:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932291AbWH0Vpd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 27 Aug 2006 17:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbWH0Vpc
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Aug 2006 17:45:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:5900 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932297AbWH0Vp2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Aug 2006 17:45:28 -0400
Received: by nf-out-0910.google.com with SMTP id o25so1123459nfa
        for <git@vger.kernel.org>; Sun, 27 Aug 2006 14:45:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=fFnJQF87JTNVo20KRFure+QYfY0o6htHak2g4pc7HF5hktGIenI4YKvlmNcly5//vLSydU6tk5fZeIhb39ViFwggPysaXUPkh4vuem+DRNmwbAxcNYfHODiLCGbQQYMsRSNnb9zhiuPllR+kiIZ5h3OHuzloGhexJfPHkLHjIV8=
Received: by 10.49.21.8 with SMTP id y8mr8230314nfi;
        Sun, 27 Aug 2006 14:45:27 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id q28sm3913698nfc.2006.08.27.14.45.27;
        Sun, 27 Aug 2006 14:45:27 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608272343.14653.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26115>

Remove unused (and with errors in implementation)
git_get_{preceding,following}_references subroutines.

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
 gitweb/gitweb.perl |   51 ---------------------------------------------------
 1 files changed, 0 insertions(+), 51 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index ba5024a..6918947 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -784,57 +784,6 @@ sub git_get_references {
 	return \%refs;
 }
 
-sub git_get_following_references {
-	my $hash = shift || return undef;
-	my $type = shift;
-	my $base = shift || $hash_base || "HEAD";
-
-	my $refs = git_get_references($type);
-	open my $fd, "-|", $GIT, "rev-list", $base
-		or return undef;
-	my @commits = map { chomp; $_ } <$fd>;
-	close $fd
-		or return undef;
-
-	my @reflist;
-	my $lastref;
-
-	foreach my $commit (@commits) {
-		foreach my $ref (@{$refs->{$commit}}) {
-			$lastref = $ref;
-			push @reflist, $lastref;
-		}
-		if ($commit eq $hash) {
-			last;
-		}
-	}
-
-	return wantarray ? @reflist : $lastref;
-}
-
-sub git_get_preceding_references {
-	my $hash = shift || return undef;
-	my $type = shift;
-
-	my $refs = git_get_references($type);
-	open my $fd, "-|", $GIT, "rev-list", $hash
-		or return undef;
-	my @commits = map { chomp; $_ } <$fd>;
-	close $fd
-		or return undef;
-
-	my @reflist;
-
-	foreach my $commit (@commits) {
-		foreach my $ref (@{$refs->{$commit}}) {
-			return $ref unless wantarray;
-			push @reflist, $ref;
-		}
-	}
-
-	return @reflist;
-}
-
 sub git_get_rev_name_tags {
 	my $hash = shift || return undef;
 
-- 
1.4.1.1
