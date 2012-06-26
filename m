From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 1/5] rebase: don't source git-sh-setup twice
Date: Tue, 26 Jun 2012 07:51:54 -0700
Message-ID: <1340722318-24392-2-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 26 16:52:48 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SjX8G-0005yY-RM
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jun 2012 16:52:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757855Ab2FZOwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jun 2012 10:52:40 -0400
Received: from mail-qa0-f74.google.com ([209.85.216.74]:52293 "EHLO
	mail-qa0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757161Ab2FZOwj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jun 2012 10:52:39 -0400
Received: by qabg24 with SMTP id g24so15534qab.1
        for <git@vger.kernel.org>; Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :x-gm-message-state;
        bh=9PMNRBcSd6lHqbK4mz7CsFJoE62078j7yiI/iByE0Xk=;
        b=nIyQXXuyoBziARiGi67pv7W6RB2tYqUS5kp27nkhPBckZlNR/di/MdS5otsegLtePg
         aFZSeRVuc4QXcoV3GKNm92zRc/M5Hs1AikJIll4YUZNK27xRaN8WxcWSi6ZWvXYRoPxM
         rPZdmrsn6gs7XnYcCojX74k+mw53KNdiHbsH5G1EqGQ16ewsYP+C/cTVhld7kDvRtFDW
         /mjkgFgOK/86vRuwAo3LdrWIih/HZ2Osp+z+XRF2SIQlKRl145zEu3SXYepRlTHU+1wI
         uVs0dzfY7GxqnqUR2xdYk5Qfy34r8cikg14luO9GiUTpvkZldbv0nEc9whN3/IYWq+xn
         h3IQ==
Received: by 10.101.175.34 with SMTP id c34mr7015967anp.13.1340722358785;
        Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
Received: by 10.101.175.34 with SMTP id c34mr7015963anp.13.1340722358729;
        Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id r48si23456205yhm.3.2012.06.26.07.52.38
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
Received: from handduk2.mtv.corp.google.com (handduk2.mtv.corp.google.com [172.18.98.93])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id 9DB33100047;
	Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
Received: by handduk2.mtv.corp.google.com (Postfix, from userid 151024)
	id 5CABFC19F8; Tue, 26 Jun 2012 07:52:38 -0700 (PDT)
X-Mailer: git-send-email 1.7.9.3.327.g2980b
In-Reply-To: <1340722318-24392-1-git-send-email-martin.von.zweigbergk@gmail.com>
X-Gm-Message-State: ALoCoQnygykoC1emgitly8TEAj6RDZ3iUh4K5H4MlgRh6IYTfpXjw5R8ZqAo+LGgYQoxD38Xl5avdOXUA6MIJEerRpuxT8DgguRBYLLaJBRGQYXNcfCvG4i4bVMtvLVBqVTx2y/YaY1wldhZgl+zUSkHQlw/Dn/adtpnbb/mf+RJ3IRVS8v1hI56OZBNxSBcG5mikjjL8Oc1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200645>

The git-sh-setup script is already sourced in git-rebase.sh before
calling into git-rebase--(am|interactive|merge).sh. There are no other
callers of these scripts. It is therefore unnecessary to source
git-sh-setup again in them.
---
 git-rebase--am.sh          |    2 --
 git-rebase--interactive.sh |    4 +---
 git-rebase--merge.sh       |    2 --
 3 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/git-rebase--am.sh b/git-rebase--am.sh
index 04d8941..392ebc9 100644
--- a/git-rebase--am.sh
+++ b/git-rebase--am.sh
@@ -3,8 +3,6 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
-. git-sh-setup
-
 case "$action" in
 continue)
 	git am --resolved --resolvemsg="$resolvemsg" &&
diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 0c19b7c..a5b018d 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -9,9 +9,7 @@
 #
 # The original idea comes from Eric W. Biederman, in
 # http://article.gmane.org/gmane.comp.version-control.git/22407
-
-. git-sh-setup
-
+#
 # The file containing rebase commands, comments, and empty lines.
 # This file is created by "git rebase -i" then edited by the user.  As
 # the lines are processed, they are removed from the front of this
diff --git a/git-rebase--merge.sh b/git-rebase--merge.sh
index dc59907..b10f2cf 100644
--- a/git-rebase--merge.sh
+++ b/git-rebase--merge.sh
@@ -3,8 +3,6 @@
 # Copyright (c) 2010 Junio C Hamano.
 #
 
-. git-sh-setup
-
 prec=4
 
 read_state () {
-- 
1.7.9.3.327.g2980b
