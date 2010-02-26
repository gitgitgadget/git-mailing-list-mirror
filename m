From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v2 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Fri, 26 Feb 2010 08:11:29 +0800
Message-ID: <1267143089-4880-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 26 01:11:53 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nkno6-0004fo-Lx
	for gcvg-git-2@lo.gmane.org; Fri, 26 Feb 2010 01:11:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934680Ab0BZALp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Feb 2010 19:11:45 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:44609 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934593Ab0BZALo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Feb 2010 19:11:44 -0500
Received: by pvb32 with SMTP id 32so1495939pvb.19
        for <git@vger.kernel.org>; Thu, 25 Feb 2010 16:11:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=25bzyfYdNySmxk43PeVmDYvTw8wp/xAGKbOT1kKSzw0=;
        b=h65H0jWdSZCEjMy+pt3AReo8yB9K43ToitFjY/a7PNjQrXFb+Oui6cTPzGL1OAPKNX
         NWQs1P1wUt/BehIH9x97J7fwxPXDJ1PVkDcxYCRl3dBiv0fCtglwQyGXNeDSPl1PAdDu
         KavAQ784uxFu4V1JQFbfFUkTjZLdFhGwjhJgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=h9O2XBVn9EPATBwSdoUq4VhMJBz28h+Av15VMwpyzvl4i6vsKL5UkOB5DSwouBH1a1
         341hvXTtO+rUYHXcsOtUEKeXStuxMlZQQX5Ct2uQ7JCmpxs07OIhjO1sZto1//xHh4pB
         JDzSR7aTkO9S3D+DUtGfP2rmP5k3GqFBYGy6Y=
Received: by 10.141.124.4 with SMTP id b4mr129525rvn.180.1267143103888;
        Thu, 25 Feb 2010 16:11:43 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 21sm2674170pzk.12.2010.02.25.16.11.42
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 25 Feb 2010 16:11:43 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141080>

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
1.7.0.85.g37fda.dirty
