From: Bo Yang <struggleyb.nku@gmail.com>
Subject: [PATCH] Warn the users when more than 3 '-C' given.
Date: Sat, 10 Apr 2010 19:51:48 +0800
Message-ID: <1270900308-20147-1-git-send-email-struggleyb.nku@gmail.com>
Cc: gitster@pobox.com, trast@student.ethz.ch, dirson@bertin.fr
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 10 13:52:20 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0ZEa-00029n-7n
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 13:52:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894Ab0DJLv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 07:51:59 -0400
Received: from mail-qy0-f179.google.com ([209.85.221.179]:46971 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751749Ab0DJLv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 07:51:59 -0400
Received: by qyk9 with SMTP id 9so2308798qyk.1
        for <git@vger.kernel.org>; Sat, 10 Apr 2010 04:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=LfrLaGLvJ7j9gyHK3aydOBDNhc22b9w/3XAAbXIZUjs=;
        b=ZnoU1N6xjmHydvhbPFJTeoVK0QJjjU0u45XyS3T7qUcLas4Cy6BgK9ObxhYU2dplSt
         DrmqQWvivAlE4Wq63NziiXnGhAgYCGyx1YHlKsR8/LoX2fy0Pjejrqed/feODyYLr5AE
         8Fl6uOJ8RljAYomof6IYTVetQ0VWlJ5bsL228=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=ubM39D9ZyZvvhOxbvrU+ut3bvXjDc10gUQDKY8H1xi2t/bIZ39VmVglyGP2IuWkyTc
         7TO8jkQ1Q6BHcCaUAR7pEfuuPr6kwBDrlK3iTr52uPIG4Ji0YkFlSDsfg8RQ89yky+jy
         IqhJLjccyJPxgdtG/KbEm+bJyMNF2Gg3u1y2A=
Received: by 10.229.212.4 with SMTP id gq4mr754358qcb.62.1270900317957;
        Sat, 10 Apr 2010 04:51:57 -0700 (PDT)
Received: from localhost.localdomain ([117.15.72.219])
        by mx.google.com with ESMTPS id f5sm2988168qcg.8.2010.04.10.04.51.54
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 10 Apr 2010 04:51:57 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.2.273.gc2413.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144541>

Output a warning message to users when there are more than
3 '-C' options given. And ignore the numeric argument value
provided by the additional '-C' options.

Signed-off-by: Bo Yang <struggleyb.nku@gmail.com>
---
 builtin/blame.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index fc15863..e8ed547 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -2165,6 +2165,15 @@ static int blame_copy_callback(const struct option *option, const char *arg, int
 	int *opt = option->value;
 
 	/*
+	 * Warn the users when more than 3 '-C' options are given and
+	 * ignore the corresponding numeric argument of it.
+	 */
+	if (*opt & PICKAXE_BLAME_COPY_HARDEST) {
+		warning("The additional '-C' above 3 is not supported.");
+		return 0;
+	}
+
+	/*
 	 * -C enables copy from removed files;
 	 * -C -C enables copy from existing files, but only
 	 *       when blaming a new file;
-- 
1.7.0.2.273.gc2413.dirty
