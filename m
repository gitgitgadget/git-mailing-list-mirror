From: Lea Wiemann <lewiemann@gmail.com>
Subject: [PATCH] gitweb: fix support for repository directories with spaces
Date: Tue, 17 Jun 2008 03:09:37 +0200
Message-ID: <1213664977-23964-1-git-send-email-LeWiemann@gmail.com>
Cc: Lea Wiemann <LeWiemann@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 17 03:10:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8PiX-0001mb-2w
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 03:10:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751788AbYFQBJl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jun 2008 21:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751958AbYFQBJl
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jun 2008 21:09:41 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:19104 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751619AbYFQBJl (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jun 2008 21:09:41 -0400
Received: by fg-out-1718.google.com with SMTP id 19so3421994fgg.17
        for <git@vger.kernel.org>; Mon, 16 Jun 2008 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:to:cc:subject:date
         :message-id:x-mailer:from;
        bh=4Sie49/gSIcYh8cmSMJZofnqrHqCui6hiX3zKo+iVsc=;
        b=coN0cxXYj/9qopTO8Fp45TugB10pOYFWaikAmm0EjRbeK2/eHgaTwYkpY3P5cF45eZ
         vOKfEUCmaspwPcqVGJ0fYfTRAQfHREmudKYBsV2mN9fuUggZvvDXy/FDYN6WoGGOrPWq
         GeYzobjc3SUxiu7rFs9bttQnlqw5VHi4e/AjI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=to:cc:subject:date:message-id:x-mailer:from;
        b=TEUDiiq3nNEPph5eQltTLqlyV0g00emmqx9QLUY4rPmDaU49xhq0SObLENPfiXVQyu
         yewCSuNUWY7mZU2hFsHWpDdenPX8KH3rrGPbWOKmxjZ68std72w+bNTxpnwP8yvKrymj
         HqIKhuyEynoqOmAy0GvB8iZ0943cOwdcMu7+c=
Received: by 10.86.90.2 with SMTP id n2mr8385897fgb.51.1213664979388;
        Mon, 16 Jun 2008 18:09:39 -0700 (PDT)
Received: from fly ( [88.128.91.129])
        by mx.google.com with ESMTPS id d6sm12421430fga.2.2008.06.16.18.09.38
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 16 Jun 2008 18:09:38 -0700 (PDT)
Received: from lea by fly with local (Exim 4.69)
	(envelope-from <lea@fly>)
	id 1K8PhZ-0006Et-Qp; Tue, 17 Jun 2008 03:09:37 +0200
X-Mailer: git-send-email 1.5.6.rc3.7.ged9620
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85254>

git_cmd_str does not quote the directory names without this patch.

Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>
---
git_cmd_str is really really bad from a security POV: Where it is
used, command lines are passed to the shell, which (I believe) just
*happen* to open no security holes.  Hence the function should
ultimately go away.  However, let's make the tests work for the
meantime while it's still there.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 07e64da..0bddc31 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1502,7 +1502,7 @@ sub git_cmd {
 
 # returns path to the core git executable and the --git-dir parameter as string
 sub git_cmd_str {
-	return join(' ', git_cmd());
+	return join ' ', map("'$_'", git_cmd());
 }
 
 # get HEAD ref of given project as hash
-- 
1.5.6.rc3.7.ged9620
