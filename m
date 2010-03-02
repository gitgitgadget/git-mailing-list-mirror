From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v3 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Tue,  2 Mar 2010 19:52:11 +0800
Message-ID: <1267530731-1384-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 02 12:52:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmQeo-0000tg-GM
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 12:52:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751824Ab0CBLww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 06:52:52 -0500
Received: from mail-pz0-f190.google.com ([209.85.222.190]:47820 "EHLO
	mail-pz0-f190.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750825Ab0CBLwv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 06:52:51 -0500
Received: by pzk28 with SMTP id 28so99678pzk.1
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 03:52:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=s1KMVG8sI6APtHwrvaHKGlcUQuYRGemD9Yk/IZhzIhI=;
        b=PodQatKRC3sxDEKcuQ/NusAhi7J2IvpkhdfHvrDK+iYIUo0exwAdTxz70Bi0T81IJT
         SEvka5rmmCZZQPs0gaPEXHP9KL8+mCx7bfb+9WOqTJaHHAq3t2TG3z8bV8ADQobfHzyu
         SzvI0JCMArpZzIhxPHRg8duJB6FNftEJ66EzU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=qvx+nIr4bNoREgxx/zgKM8NWMmAE/ZNDhGtJmdtTlV9Jtcz8dBNH0UXhdMj9jYyq5h
         9Sb0PN+/qU5US3EDuRGKrG2BYLy6EiHQHGCj9D6RY8moRkWTOLgsQedSq2myf8YX2GDu
         mM808c1gQpDPSSg3W0+nSUNbJw94V3eLdagvQ=
Received: by 10.142.67.31 with SMTP id p31mr254637wfa.301.1267530771367;
        Tue, 02 Mar 2010 03:52:51 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 20sm4560979pzk.7.2010.03.02.03.52.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 03:52:50 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141389>

If GIT_ASKPASS is not set and SSH_ASKPASS set, GIT_ASKPASS will
use SSH_ASKPASS.

Signed-off-by: Frank Li <lznuaa@gmail.com>
---
 git.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 90c6daf..f09948e 100644
--- a/git.c
+++ b/git.c
@@ -54,6 +54,9 @@ static int handle_options(const char ***argv, int *argc, int *envchanged)
 {
 	int handled = 0;
 
+	if (!getenv("GIT_ASKPASS") && getenv("SSH_ASKPASS"))
+		setenv("GIT_ASKPASS", getenv("SSH_ASKPASS"), 1);
+
 	while (*argc > 0) {
 		const char *cmd = (*argv)[0];
 		if (cmd[0] != '-')
-- 
1.7.0.86.g45191
