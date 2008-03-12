From: Marc-Andre Lureau <marcandre.lureau@gmail.com>
Subject: [PATCH] git-cvsimport: fix merging with remote parent branch
Date: Wed, 12 Mar 2008 21:54:21 +0200
Message-ID: <1205351661-6384-1-git-send-email-marcandre.lureau@gmail.com>
Cc: Martin Langhoff <martin@catalyst.net.nz>,
	Marc-Andre Lureau <marcandre.lureau@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 12 20:55:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZX2V-0006k2-Lu
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:55:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751978AbYCLTyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:54:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752042AbYCLTyW
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:54:22 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:32778 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751919AbYCLTyV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:54:21 -0400
Received: by nf-out-0910.google.com with SMTP id g13so1260965nfb.21
        for <git@vger.kernel.org>; Wed, 12 Mar 2008 12:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=Uxp2Q+GSHL3HeoW5y2zSMAUxU2FBATCHNQoqFc/TCsU=;
        b=U2EBstrbh8oK+EnXivkAo6DooFxjKdNBz0G1LJrHEWfS/A7n0g93slMkgj9jo80itxcKj7KjxtTyNUazJdwZ6uRt02ZKVQCEhXAMJOgbKM7zwBykq7dvlm8cFfewQq+HI218NSigH4tm6Fd/4kmzX3hRvlHhb/0fnFxUlUnr0+0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ZfbauGwVTtAGqirCl1+4g+y+oHVlBGM4hKt/jObRVR0uYFuRhp1t/EoywBjQvEPJ1MwPmiVFkv59RJTmGtBAoWjnWZVjco2iLsplEbmQQuKVUcMMgJ/ZCyzMx9C/CkiMte976vd4A8OGekuy2yf/HxFfNYX81jnkHv/3p6sjOMo=
Received: by 10.78.132.2 with SMTP id f2mr23192054hud.37.1205351658454;
        Wed, 12 Mar 2008 12:54:18 -0700 (PDT)
Received: from localhost ( [88.113.0.245])
        by mx.google.com with ESMTPS id b36sm7219794ika.2.2008.03.12.12.54.15
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 12 Mar 2008 12:54:17 -0700 (PDT)
X-Mailer: git-send-email 1.5.4.4.534.gfb90c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76979>

commit-tree fails when specifying a remote name (via -r option) and
one of the parent branch has a name. Prefixing with "$remote/" fix it.

Signed-off-by: Marc-Andre Lureau <marcandre.lureau@gmail.com>
---
 git-cvsimport.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index 47f116f..95c5eec 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -735,7 +735,7 @@ sub commit {
 		next unless $logmsg =~ $rx && $1;
 		my $mparent = $1 eq 'HEAD' ? $opt_o : $1;
 		if (my $sha1 = get_headref("$remote/$mparent")) {
-			push @commit_args, '-p', $mparent;
+			push @commit_args, '-p', "$remote/$mparent";
 			print "Merge parent branch: $mparent\n" if $opt_v;
 		}
 	}
-- 
1.5.4.4.534.gfb90c.dirty
