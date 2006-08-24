From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH 7] gitweb: Faster return from git_get_preceding_references if possible
Date: Thu, 24 Aug 2006 19:39:32 +0200
Message-ID: <200608241939.32535.jnareb@gmail.com>
References: <200608240015.15071.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Aug 24 19:46:29 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GGJHS-000163-Lo
	for gcvg-git@gmane.org; Thu, 24 Aug 2006 19:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030429AbWHXRqA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 Aug 2006 13:46:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030434AbWHXRqA
	(ORCPT <rfc822;git-outgoing>); Thu, 24 Aug 2006 13:46:00 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:29778 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030429AbWHXRp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Aug 2006 13:45:58 -0400
Received: by nf-out-0910.google.com with SMTP id o25so638006nfa
        for <git@vger.kernel.org>; Thu, 24 Aug 2006 10:45:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Nonw7CIZ99l0iT5slmSRxTI1/HUwF6wHwrr7peMz7fqA5uzEKwoBAO3VgNzLr4GWj2h43dNb4O+HneCGOlWzrxBGy8iqS1631jywIY8v2OSnImjo1kyamgrA94QwUxDGVmvXoohrUIht8kwDOMTy3iX15zKFTLVUGYpk7//orW8=
Received: by 10.48.48.18 with SMTP id v18mr4041652nfv;
        Thu, 24 Aug 2006 10:45:57 -0700 (PDT)
Received: from host-81-190-21-215.torun.mm.pl ( [81.190.21.215])
        by mx.gmail.com with ESMTP id p20sm4867170nfc.2006.08.24.10.45.56;
        Thu, 24 Aug 2006 10:45:57 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200608240015.15071.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25967>

Return on first ref found when git_get_preceding_references
is called in scalar context

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Jakub Narebski wrote:
> Actually, the two following patches adresses this, not this patch...

The two following this patch...

 gitweb/gitweb.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 2d3776a..a068a81 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -789,16 +789,15 @@ sub git_get_preceding_references {
 		or return undef;
 
 	my @reflist;
-	my $firstref;
 
 	foreach my $commit (@commits) {
 		foreach my $ref (@{$refs->{$commit}}) {
-			$firstref = $ref unless $firstref;
+			return $ref unless wantarray;
 			push @reflist, $ref;
 		}
 	}
 
-	return wantarray ? @reflist : $firstref;
+	return @reflist;
 }
 
 ## ----------------------------------------------------------------------
-- 
1.4.1.1
