From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2] send-email: fix mutt regex for grouped aliases
Date: Wed, 30 Sep 2009 17:49:36 +0300
Message-ID: <1254322176-4561-1-git-send-email-felipe.contreras@gmail.com>
References: <20090930112833.GA4984@sigio.peff.net>
Cc: Junio C Hamano <gitster@pobox.com>,
	Eric Wong <normalperson@yhbt.net>, Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 30 16:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mt0V3-0002P6-D2
	for gcvg-git-2@lo.gmane.org; Wed, 30 Sep 2009 16:49:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754593AbZI3Otj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Sep 2009 10:49:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754585AbZI3Otj
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Sep 2009 10:49:39 -0400
Received: from ey-out-2122.google.com ([74.125.78.26]:56488 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754580AbZI3Otj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Sep 2009 10:49:39 -0400
Received: by ey-out-2122.google.com with SMTP id 4so500025eyf.19
        for <git@vger.kernel.org>; Wed, 30 Sep 2009 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=e75KYR6p77WJy99LZ+2z8tUhxb1Yu2VdNL2uN5W2xH8=;
        b=vNIcyxEhFNrjTSCy0NS34tRhQrewzgbyTi/buL687QfItayly36itbX+Vz82lYkBJT
         2vwUGzVRITQa0/KwNp34QzWM6ArkkeYX37t3oKzSX8myZsTNxoF+i9DCea0zVaxkIKLB
         ch6cyqA4IznmLjPLaZFziAb+OYlRgG2RVsCEc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=oFnCVW99csCwEKGtjYinAEL+hBCYyodhwxTOuPsxXar6lCOVz0+gnn1/QVtxOVPJMI
         1NEbxdhgXmfAu7lcQcEGDUmmtYfjPm5emIgQoCSF4sq+0DxdaLeRd59EnXFOE1qUQ+Jr
         Bahc8rNoKAwqrr+um7a8dlCjQKcavVQX9vCyQ=
Received: by 10.211.139.16 with SMTP id r16mr6871845ebn.89.1254322181826;
        Wed, 30 Sep 2009 07:49:41 -0700 (PDT)
Received: from localhost (gw3.cosmicparrot.net [217.152.255.6])
        by mx.google.com with ESMTPS id 7sm31461eyb.4.2009.09.30.07.49.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 30 Sep 2009 07:49:40 -0700 (PDT)
X-Mailer: git-send-email 1.6.5.rc2.1.g9071
In-Reply-To: <20090930112833.GA4984@sigio.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129344>

For example:
alias -group friends foo Foo Bar <foo@bar.com>

Comments by Jeff King.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-send-email.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 0700d80..93b7ed2 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -401,7 +401,7 @@ my %aliases;
 my %parse_alias = (
 	# multiline formats can be supported in the future
 	mutt => sub { my $fh = shift; while (<$fh>) {
-		if (/^\s*alias\s+(\S+)\s+(.*)$/) {
+		if (/^\s*alias\s+(?:-group\s+\S+\s+)*(\S+)\s+(.*)$/) {
 			my ($alias, $addr) = ($1, $2);
 			$addr =~ s/#.*$//; # mutt allows # comments
 			 # commas delimit multiple addresses
-- 
1.6.5.rc2.1.g9071
