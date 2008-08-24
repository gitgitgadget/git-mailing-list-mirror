From: David Aguilar <davvid@gmail.com>
Subject: [PATCH 1/3] git-submodule: add a get_remote function
Date: Sun, 24 Aug 2008 10:21:38 -0700
Message-ID: <e21617f50ffaae98ab73fa364e40440397bcbe33.1219598198.git.davvid@gmail.com>
References: <1219598500-8334-1-git-send-email-davvid@gmail.com>
Cc: mlevedahl@gmail.com, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Aug 24 19:31:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXJQd-0002mk-Qc
	for gcvg-git-2@gmane.org; Sun, 24 Aug 2008 19:31:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752300AbYHXR3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Aug 2008 13:29:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYHXR3m
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Aug 2008 13:29:42 -0400
Received: from rv-out-0506.google.com ([209.85.198.232]:25935 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752300AbYHXR3j (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Aug 2008 13:29:39 -0400
Received: by rv-out-0506.google.com with SMTP id k40so1296197rvb.1
        for <git@vger.kernel.org>; Sun, 24 Aug 2008 10:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9aHusZ9PuLdNt/hHK7Mdc+mPN9yrHEvb3mqRWLcu5o8=;
        b=xqu/Kvoil51SbBdaQqdjJVD/a0XKW4lDHFTif/mqkSohey261YMweNhiBR2JgYCCQ0
         CCDEWVFCspLgiKE0mMb7Q1Id0e0fjCUta+ydAuM9CJgNavMXsm8GRFfNCjRvmAEr380s
         IhdpxIxOZ4b6B1BOjt45ZCdOJX9X6hHhwMbug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=gCcJFCBj/l37oFugchI+KPXthfpo7UhzG4dFiWiwCdabptja8IGhErlZvV+MabW0Sf
         k66NMshvV8sj/kOXQiEAbP8u7C5tYcKmEc1plLtdpyG1Dmo6ceyEMP4QvIYtD+Qu4kkq
         ijPMtNLEKNzmvUrvNagqeKJFaDNQV/ex1Wm9E=
Received: by 10.141.51.15 with SMTP id d15mr1684860rvk.106.1219598979088;
        Sun, 24 Aug 2008 10:29:39 -0700 (PDT)
Received: from localhost ( [208.106.56.2])
        by mx.google.com with ESMTPS id g31sm5852136rvb.7.2008.08.24.10.29.37
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 24 Aug 2008 10:29:38 -0700 (PDT)
X-Mailer: git-send-email 1.6.0.90.g436ed
In-Reply-To: <1219598500-8334-1-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93537>

get_remote finds the remote that corresponds to HEAD.
This code is duplicated from resolve_relative_url but
will be refactored and reused in subsequent commits.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-submodule.sh |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/git-submodule.sh b/git-submodule.sh
index 2a3a197..9d2bddb 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -27,6 +27,15 @@ say()
 	fi
 }
 
+# Gets the remote corresponding to HEAD
+get_remote()
+{
+	branch="$(git symbolic-ref HEAD 2>/dev/null)"
+	remote="$(git config branch.${branch#refs/heads/}.remote)"
+	remote="${remote:-origin}"
+	echo "$remote"
+}
+
 # Resolve relative url by appending to parent's url
 resolve_relative_url ()
 {
-- 
1.6.0.90.g436ed
