From: Jakub Narebski <jnareb@gmail.com>
Subject: [RFC PATCH 1/2] gitweb: Go to DONE_REQUEST rather than DONE_GITWEB in
	die_error
Date: Mon, 13 Dec 2010 01:48:55 +0100
Message-ID: <20101213004644.9475.10102.stgit@localhost.localdomain>
References: <20101213004259.9475.87376.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: "J.H." <warthog9@eaglescrag.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 13 01:49:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PRwbY-0007OB-PW
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 01:49:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932107Ab0LMAtX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Dec 2010 19:49:23 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:44373 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754825Ab0LMAtW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Dec 2010 19:49:22 -0500
Received: by wyb28 with SMTP id 28so5378053wyb.19
        for <git@vger.kernel.org>; Sun, 12 Dec 2010 16:49:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:subject:to:cc
         :date:message-id:in-reply-to:references:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=UjEg27IIXnzrEHFoafmHBva+NUCnkyNC0BwCUT0tvxU=;
        b=jKJZbAVvJimm7UFA9Hqh6LzTJJZOrUr4IKvXwjaCW3FtjZmvvh3IqoXFvZO8VTy6dY
         gFnAHS100V7ldceMlLxb1MHVOAFIILNylNHdbDF25rrK611LXWFSunZmjKIRaF0DRy9R
         +t+HqvqBkNAfMq7INZunHzYhU2ApGd1qbuvdc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:subject:to:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        b=NkY5JT5LOPlqiNkzlW4xBNEPI4IIsmNCBWtd0Gm/8JgV+FXCq7tMiBwgdU546M4tmZ
         GGMM082ueYTIhMVgvX5dSDluhXclUa86bToP2z7/x5Q7oi34JRc1pSMaQfbDEIwV6SoZ
         TrkTAhKMdxsxOdpN6tre2J3Dx9rCGF43gXuPs=
Received: by 10.216.187.133 with SMTP id y5mr3732513wem.110.1292201361060;
        Sun, 12 Dec 2010 16:49:21 -0800 (PST)
Received: from localhost.localdomain (abwq106.neoplus.adsl.tpnet.pl [83.8.240.106])
        by mx.google.com with ESMTPS id x28sm2787268weq.16.2010.12.12.16.49.19
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 12 Dec 2010 16:49:20 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id oBD0mtIM009581;
	Mon, 13 Dec 2010 01:49:05 +0100
In-Reply-To: <20101213004259.9475.87376.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163501>

End the request after die_error finishes, rather than exiting gitweb
instance (perhaps wrapped like in ModPerl::Registry or gitweb.psgi
case).

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
This patch was sent to git mailing list as a standalone RFC patch some
time ago.  This version doesn't change anything from previous version.

I am keeping this patch (even though it is not strictly necessary), to
have DONE_REQUEST label, which I think can be quite useful, even if
die_error wouldn't be using it starting from the following commit.

 gitweb/gitweb.perl |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index cfa511c..af45daa 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1147,6 +1147,7 @@ sub run {
 
 		run_request();
 
+	DONE_REQUEST:
 		$post_dispatch_hook->()
 			if $post_dispatch_hook;
 
@@ -3669,7 +3670,7 @@ EOF
 	print "</div>\n";
 
 	git_footer_html();
-	goto DONE_GITWEB
+	goto DONE_REQUEST
 		unless ($opts{'-error_handler'});
 }
 
