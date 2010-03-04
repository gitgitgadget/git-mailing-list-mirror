From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v5 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Thu,  4 Mar 2010 22:37:10 +0800
Message-ID: <1267713430-4516-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 04 15:38:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NnCBB-0003e0-Sn
	for gcvg-git-2@lo.gmane.org; Thu, 04 Mar 2010 15:37:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753824Ab0CDOh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Mar 2010 09:37:29 -0500
Received: from ey-out-2122.google.com ([74.125.78.27]:28971 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752860Ab0CDOh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Mar 2010 09:37:28 -0500
Received: by ey-out-2122.google.com with SMTP id 25so436502eya.19
        for <git@vger.kernel.org>; Thu, 04 Mar 2010 06:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=QIq/Okpbd3/O0YUxqgGoqL5SMcF7CqULH2BBOToru8k=;
        b=dyd0smHyjg4zaNy0vsFVHre8nnMK2ek66W2HaGC5qx3ZPjSnxYhx+eJsGFUIw8LCRp
         b3Nyr0Kgev8FRtnjYz/Wx2BYvJz86MF4U47V4/gPJ82eA/8O13sZQKInMnIVN+HZ/Xie
         978PdsRNtt3cDmhQ6bvORifxqeJlClDU7ccbQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=dWhaHrROlYRXylFb1W/q+dvHe6XJwiROw21gS6FgYdxgqAK9ELgx6PMEcrmHvS2e3l
         b8s92pfJIZnmkYf3Vk2Kn3BTMssSbqtcLp7j+P83np4NhMZjFJFO1BnsGSOJ1zOJWIgB
         HzBOhYkIRadU1QJ4kD1GnAjdJWgq0ELVQ/KFM=
Received: by 10.213.59.145 with SMTP id l17mr944779ebh.56.1267713447039;
        Thu, 04 Mar 2010 06:37:27 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 7sm1589745eyb.41.2010.03.04.06.37.25
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 04 Mar 2010 06:37:26 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141529>

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
1.7.0.86.g84fa0
