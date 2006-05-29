From: Horst von Brand <vonbrand@inf.utfsm.cl>
Subject: Re: [PATCH] git-send-email.perl extract_valid_address issue
Date: Mon, 29 May 2006 17:09:42 -0400
Message-ID: <200605292109.k4TL9g7E014263@laptop11.inf.utfsm.cl>
References: <ryan@michonline.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 29 23:10:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fkp0J-0002Wk-QT
	for gcvg-git@gmane.org; Mon, 29 May 2006 23:10:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751283AbWE2VKV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 May 2006 17:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751300AbWE2VKV
	(ORCPT <rfc822;git-outgoing>); Mon, 29 May 2006 17:10:21 -0400
Received: from inti.inf.utfsm.cl ([200.1.21.155]:34514 "EHLO inti.inf.utfsm.cl")
	by vger.kernel.org with ESMTP id S1751283AbWE2VKU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 29 May 2006 17:10:20 -0400
Received: from laptop11.inf.utfsm.cl (laptop11.inf.utfsm.cl [200.1.19.198])
	by inti.inf.utfsm.cl (8.13.1/8.13.1) with ESMTP id k4TL9gFb031909
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 29 May 2006 17:09:43 -0400
Received: from laptop11.inf.utfsm.cl (localhost.localdomain [127.0.0.1])
	by laptop11.inf.utfsm.cl (8.13.6/8.13.6) with ESMTP id k4TL9g7E014263;
	Mon, 29 May 2006 17:09:42 -0400
To: Ryan Anderson <ryan@michonline.com>,
	Nicolas Troncoso Carrere <ntroncos@alumnos.inf.utfsm.cl>
In-Reply-To: Message from Ryan Anderson <ryan@michonline.com> 
   of "Mon, 29 May 2006 13:00:27 MST." <20060529200026.GA32457@h4x0r5.com> 
X-Mailer: MH-E 7.4.2; nmh 1.1; XEmacs 21.4 (patch 19)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-2.0.2 (inti.inf.utfsm.cl [200.1.19.1]); Mon, 29 May 2006 17:09:43 -0400 (CLT)
X-Virus-Scanned: ClamAV version 0.88, clamav-milter version 0.87 on inti.inf.utfsm.cl
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20971>

Fix regexps to better match email addresses if Email::Valid isn't present
Make it return the address on match containing a @

Signed-off-by:  Horst H. von Brand <vonbrand@inf.utfsm.cl>
---
 git-send-email.perl |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index 312a4ea..6e39f2f 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -309,14 +309,14 @@ sub extract_valid_address {
 	my $address = shift;
 
 	# check for a local address:
-	return $address if ($address =~ /^([\w\-]+)$/);
+	return $address if ($address =~ /^([\w\-.]+)$/);
 
 	if ($have_email_valid) {
 		return Email::Valid->address($address);
 	} else {
 		# less robust/correct than the monster regexp in Email::Valid,
 		# but still does a 99% job, and one less dependency
-		return ($address =~ /([^\"<>\s]+@[^<>\s]+)/);
+		return ($address =~ /([\w\-.]+@[\w\-.]+)/) ? $1 : undef;
 	}
 }
 
-- 
1.3.3.g0f0ac
