From: Marek Zawirski <marek.zawirski@gmail.com>
Subject: [EGIT PATCH 12/23] Fix: let RevWalk reset correctly before isMergedInto()
Date: Sat, 28 Jun 2008 00:06:36 +0200
Message-ID: <1214604407-30572-13-git-send-email-marek.zawirski@gmail.com>
References: <1214604407-30572-1-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-2-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-3-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-4-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-5-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-6-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-7-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-8-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-9-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-10-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-11-git-send-email-marek.zawirski@gmail.com>
 <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
Cc: git@vger.kernel.org, Marek Zawirski <marek.zawirski@gmail.com>
To: robin.rosenberg@dewire.com, spearce@spearce.org
X-From: git-owner@vger.kernel.org Sat Jun 28 00:09:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCM7j-0000rw-EK
	for gcvg-git-2@gmane.org; Sat, 28 Jun 2008 00:08:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757695AbYF0WHy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2008 18:07:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757492AbYF0WHw
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Jun 2008 18:07:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:38733 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757478AbYF0WHt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2008 18:07:49 -0400
Received: by nf-out-0910.google.com with SMTP id d3so182445nfc.21
        for <git@vger.kernel.org>; Fri, 27 Jun 2008 15:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=0fBqY5zFltd2yigeZgfI44yPGx+lM63B9nALgKZS6FU=;
        b=PtKFtITO6o0UQy6con0Fi+prEz1EE8pSSHgSp3f4ntCXYhfKXy7jnh2iOurJq+nKWF
         gzrS4bmh1p/H3EE0mh4W91fvMpNc9NPBdjuwjOtyYAGFwxCkfwLhfeuaUvmeoZRWxJnH
         r0Y8McJUxFc78wtv4bu9x5JNaXRtzC1o9qPF8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=mQcz6mJ0K1//JzGrqf7V4jYtHITKcZ5KIbbxNwfBMpwcSPccwisZcE2l5gEEIIiVyf
         +gFEtTy7fYgPpuAkJWowDID+etveDA95SpneLtiR2w8faIaLbCROXn/qDUDzf0D4qau0
         NMXaayt3kOzFjE1y3CWw9gC+MGnlcJIBMR+7I=
Received: by 10.210.87.14 with SMTP id k14mr1611256ebb.60.1214604467853;
        Fri, 27 Jun 2008 15:07:47 -0700 (PDT)
Received: from localhost ( [62.21.19.93])
        by mx.google.com with ESMTPS id b33sm2445589ika.2.2008.06.27.15.07.45
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Jun 2008 15:07:46 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.4
In-Reply-To: <1214604407-30572-12-git-send-email-marek.zawirski@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86652>

Retained flags was wrongly computed for reset() call inside
isMergedInto().

Signed-off-by: Marek Zawirski <marek.zawirski@gmail.com>
---
 .../src/org/spearce/jgit/revwalk/RevWalk.java      |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
index fc757a5..7976d75 100644
--- a/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
+++ b/org.spearce.jgit/src/org/spearce/jgit/revwalk/RevWalk.java
@@ -347,7 +347,7 @@ public class RevWalk implements Iterable<RevCommit> {
 		final TreeFilter oldTF = treeFilter;
 		try {
 			finishDelayedFreeFlags();
-			reset(~freeFlags & ~RESERVED_FLAGS);
+			reset(~freeFlags & APP_FLAGS);
 			filter = RevFilter.MERGE_BASE;
 			treeFilter = TreeFilter.ALL;
 			markStart(tip);
-- 
1.5.5.3
