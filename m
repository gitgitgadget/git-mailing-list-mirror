From: "Gordon Hopper" <g.hopper@computer.org>
Subject: [PATCH] git-cvsimport: fix handling of user name when it is not set in CVSROOT
Date: Thu, 8 Nov 2007 13:15:20 -0700
Message-ID: <3b3fddfa0711081215w7aed667boa00ea134c0798a9@mail.gmail.com>
Reply-To: g.hopper@computer.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 08 21:16:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqDmt-0002MZ-Mk
	for gcvg-git-2@gmane.org; Thu, 08 Nov 2007 21:15:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759958AbXKHUPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2007 15:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761024AbXKHUPW
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Nov 2007 15:15:22 -0500
Received: from rv-out-0910.google.com ([209.85.198.188]:23415 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758970AbXKHUPV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2007 15:15:21 -0500
Received: by rv-out-0910.google.com with SMTP id k20so261248rvb
        for <git@vger.kernel.org>; Thu, 08 Nov 2007 12:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:reply-to:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        bh=tRD7z4hDhO1nXnkllBntrulSwQXBE/IskoIgX6ObW+M=;
        b=YdnxfyEmc3mlDDpAd6ibm+k8nIkq9LZG2Z/RVEasTyMmXNMmuXc1rM3pLigIs/eZRwSbKXPMpfLiRLWiJDSlAjCiaK6FErVrSrP7BLyS4QGLbDX3E1mM9u4wRfwGJOxBTZ0r0R/ojoPyi3/lxSb0pCmz5j9dQdWMM/kQth/FgCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:reply-to:sender:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition:x-google-sender-auth;
        b=GLcpS1IGxuRkP2fvLgnOIaDzjMTmnM9npUcVUXx3SryXDp9iiw6NwSKTHIXCJG91bXi07iHrZJkRT5hWqr1hMI39ydOTshqh8r47uMs0ZWE4u6J+m5dQOZS8xDsjUP/eDPr3tesai8DtQ3GMfBS9BGvkQhBe09UX2i5v2MqJ+x4=
Received: by 10.141.99.4 with SMTP id b4mr518450rvm.1194552920291;
        Thu, 08 Nov 2007 12:15:20 -0800 (PST)
Received: by 10.141.37.6 with HTTP; Thu, 8 Nov 2007 12:15:20 -0800 (PST)
Content-Disposition: inline
X-Google-Sender-Auth: a8fb8b44ddf4a099
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64067>

The cvs programs do not default to "anonymous" as the user name, but use the
currently logged in user.  This patch more closely matches the cvs behavior.

Signed-off-by: Gordon Hopper <g.hopper@computer.org>
---
 git-cvsimport.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-cvsimport.perl b/git-cvsimport.perl
index e4bc2b5..efa6a0c 100755
--- a/git-cvsimport.perl
+++ b/git-cvsimport.perl
@@ -223,7 +223,8 @@ sub conn {
 			}
 		}

-		$user="anonymous" unless defined $user;
+		# if username is not explicit in CVSROOT, then use current user, as cvs would
+		$user=(getlogin() || $ENV{'LOGNAME'} || $ENV{'USER'} ||
"anonymous") unless $user;
 		my $rr2 = "-";
 		unless ($port) {
 			$rr2 = ":pserver:$user\@$serv:$repo";
-- 
1.5.3.5
