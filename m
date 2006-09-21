From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Make git_get_hash_by_path check type if provided
Date: Thu, 21 Sep 2006 18:09:12 +0200
Message-ID: <200609211809.12260.jnareb@gmail.com>
References: <200609211423.29729.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Thu Sep 21 18:11:22 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQR6z-0005fU-1y
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 18:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWIUQJO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 12:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750788AbWIUQJN
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 12:09:13 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:37065 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750704AbWIUQJN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 12:09:13 -0400
Received: by ug-out-1314.google.com with SMTP id o38so145464ugd
        for <git@vger.kernel.org>; Thu, 21 Sep 2006 09:09:11 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:references:in-reply-to:mime-version:content-disposition:message-id:content-type:content-transfer-encoding;
        b=kI+6i299AiGhozlxFGACzYAbWPbU+bxT7MELCB7S+GT7HL/IEuzdRX1hLkVYmzhLRz+0/U6eO0RYokKfbWvWKXIjf3R2GViJdDr1QpH3kU5SdKM/sLe9RfKnq/+4P5uJTRPpT4WqzUfN2MgHT0V+3m9IU7Vhzs6Js4YLqpJm2aM=
Received: by 10.67.103.7 with SMTP id f7mr9401825ugm;
        Thu, 21 Sep 2006 09:09:11 -0700 (PDT)
Received: from host-81-190-26-109.torun.mm.pl ( [81.190.26.109])
        by mx.gmail.com with ESMTP id u6sm1061524uge.2006.09.21.09.09.10;
        Thu, 21 Sep 2006 09:09:10 -0700 (PDT)
To: git@vger.kernel.org
User-Agent: KMail/1.9.3
In-Reply-To: <200609211423.29729.jnareb@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27482>

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch depends textually (as context) from the previous patch.
It can be applied using -C1 without applying previous patch first.

 gitweb/gitweb.perl |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 403bba1..7ed963c 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -718,6 +718,7 @@ # get hash of given path at given ref
 sub git_get_hash_by_path {
 	my $base = shift;
 	my $path = shift || return undef;
+	my $type = shift;
 
 	$path =~ s,/+$,,;
 
@@ -728,6 +729,10 @@ sub git_get_hash_by_path {
 
 	#'100644 blob 0fa3f3a66fb6a137f6ec2c19351ed4d807070ffa	panic.c'
 	$line =~ m/^([0-9]+) (.+) ([0-9a-fA-F]{40})\t(.+)$/;
+	if (defined $type && $type ne $2) {
+		# type doesn't match
+		return undef;
+	}
 	return $3;
 }
 
-- 
1.4.2.1
