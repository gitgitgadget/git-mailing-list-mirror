From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] Revert "gitweb: Add 'status_str' to parse_difftree_raw_line output"
Date: Sat, 5 Apr 2008 21:13:24 +0100
Message-ID: <200804052213.31253.jnareb@gmail.com>
References: <200804041623.44595.jnareb@gmail.com> <200804051916.14568.jnareb@gmail.com> <200804051938.17855.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Gerrit Pape <pape@smarden.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 05 22:14:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JiEmb-0004QH-JV
	for gcvg-git-2@gmane.org; Sat, 05 Apr 2008 22:14:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753465AbYDEUNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Apr 2008 16:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753463AbYDEUNy
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Apr 2008 16:13:54 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:41727 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753260AbYDEUNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Apr 2008 16:13:54 -0400
Received: by nf-out-0910.google.com with SMTP id g13so309534nfb.21
        for <git@vger.kernel.org>; Sat, 05 Apr 2008 13:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=5wYf/gcksamk+ytKMTnxaPXuN16J4PCKlnbw6GGYfXI=;
        b=ZLj0ht4MX+BIjPikDb0CvI3dlNhIQAdfSFarlfstj9cBjoPJIyARdLW+vD6rD2WJYDpwLBXRwHKZRhf8+2WMdHa/VYQhWBis+b+SOkmeO7SFfy/DVZL+8UfHVjzoAZXqxRMHpAIJs6LG8PXS4SuYLHwaBBFvGo+OQaEk92vGd2g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=T+Q1MG9D7bTFIe0sHAwdEKZNr1bvwSlbpa9m8W4GOynN1CL3PwROz8KIdvngrVY+RBFcUAQwV7JVqD45ZUvya94nLqzE7LRebgKicLuBxqVQ/UsoZtZtMWyJ7HKSP0pQ0DYLGLSjzewyfwJGNUsLHtNzaaKaRrEV0E8qLXviIEA=
Received: by 10.78.187.17 with SMTP id k17mr7974580huf.7.1207426432050;
        Sat, 05 Apr 2008 13:13:52 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.198.110])
        by mx.google.com with ESMTPS id 35sm2480401nfu.36.2008.04.05.13.13.48
        (version=SSLv3 cipher=OTHER);
        Sat, 05 Apr 2008 13:13:50 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <200804051938.17855.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78863>

This reverts commit 6aa6f92fda47cc4ee5f599895e8a5a327fb6f9ab.

It caused is_deleted() subroutine to output warnings when dealing with
old, legacy gitweb blobdiff URLs without either 'hb' or 'hpb'
parameters.

This fixes http://bugs.debian.org/469083

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
> It should be enough to revert commit 6aa6f92 (gitweb: Add 'status_str'
> to parse_difftree_raw_line output); it should fix this bug.

And here it is...

 gitweb/gitweb.perl |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 1be75c6..1501ec8 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -2204,7 +2204,7 @@ sub parse_difftree_raw_line {
 		$res{'to_mode'} = $2;
 		$res{'from_id'} = $3;
 		$res{'to_id'} = $4;
-		$res{'status'} = $res{'status_str'} = $5;
+		$res{'status'} = $5;
 		$res{'similarity'} = $6;
 		if ($res{'status'} eq 'R' || $res{'status'} eq 'C') { # renamed or copied
 			($res{'from_file'}, $res{'to_file'}) = map { unquote($_) } split("\t", $7);
@@ -2220,7 +2220,6 @@ sub parse_difftree_raw_line {
 		$res{'to_mode'} = pop @{$res{'from_mode'}};
 		$res{'from_id'} = [ split(' ', $3) ];
 		$res{'to_id'} = pop @{$res{'from_id'}};
-		$res{'status_str'} = $4;
 		$res{'status'} = [ split('', $4) ];
 		$res{'to_file'} = unquote($5);
 	}
@@ -3068,7 +3067,7 @@ sub fill_from_file_info {
 sub is_deleted {
 	my $diffinfo = shift;
 
-	return $diffinfo->{'status_str'} =~ /D/;
+	return $diffinfo->{'to_id'} eq ('0' x 40);
 }
 
 # does patch correspond to [previous] difftree raw line
-- 
1.5.4.4
