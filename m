From: Frank Li <lznuaa@gmail.com>
Subject: [PATCH v4 3/3] fallback SSH_ASKPASS when GIT_ASKPASS not set
Date: Wed,  3 Mar 2010 19:37:40 +0800
Message-ID: <1267616260-2168-1-git-send-email-lznuaa@gmail.com>
Cc: gitster@pobox.com, Frank Li <lznuaa@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 03 12:38:26 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmmuG-00084R-L1
	for gcvg-git-2@lo.gmane.org; Wed, 03 Mar 2010 12:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752579Ab0CCLiT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Mar 2010 06:38:19 -0500
Received: from mail-pv0-f174.google.com ([74.125.83.174]:48876 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752269Ab0CCLiR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Mar 2010 06:38:17 -0500
Received: by pva4 with SMTP id 4so404899pva.19
        for <git@vger.kernel.org>; Wed, 03 Mar 2010 03:38:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=130TGOsCkvl/WZ1Qepgyt+LTYHL8QLkzSZP31DmWoQ8=;
        b=qLQ5veD1Y2YW5YXr+x24HK4bSx3tiQVyATJOTg2LkpScZlycxIqeDylP1S5E8iyghD
         UTpu9g0A2KeA4SqjQtgXkgVmPhMXw2Js/Sgsfye8+dvocYiHI85J8BMe0+zlCY9sxyzD
         tUE7i6iGPA8124MwyAhXd39oSixWEU5t7Dvnk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=TnTm9xY7cbzWIE7S8p8aNyyY2PIRb1bnWPRO9GI2UQJxZ93r7K58fimil2iTsCFQ3n
         Zv3hgD6jDv8X8T9Ct/a+wSJ8y2AyIppVGuPcFiQ+04BOQXxjRb1FH/Qx1kXe3dtMkX1t
         IMHGFQbE6rRi9qLFGF6ggihXqpwupAwqATxhY=
Received: by 10.114.215.17 with SMTP id n17mr4230320wag.197.1267616296924;
        Wed, 03 Mar 2010 03:38:16 -0800 (PST)
Received: from localhost ([114.93.102.82])
        by mx.google.com with ESMTPS id 22sm5709327pzk.1.2010.03.03.03.38.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 03:38:16 -0800 (PST)
X-Mailer: git-send-email 1.6.5.1.1367.gcd48
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141445>

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
1.7.0.86.g013a4.dirty
