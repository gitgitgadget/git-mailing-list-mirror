From: David Aguilar <davvid@gmail.com>
Subject: [PATCH] mergetool-lib: specialize opendiff options when in diff mode
Date: Thu,  2 Apr 2009 19:16:11 -0700
Message-ID: <1238724971-60979-1-git-send-email-davvid@gmail.com>
Cc: charles@hashpling.org, markus.heidelberg@web.de,
	git@vger.kernel.org, David Aguilar <davvid@gmail.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Apr 03 04:17:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LpYyg-0000ba-JZ
	for gcvg-git-2@gmane.org; Fri, 03 Apr 2009 04:17:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752234AbZDCCQV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Apr 2009 22:16:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751436AbZDCCQV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Apr 2009 22:16:21 -0400
Received: from rv-out-0506.google.com ([209.85.198.227]:31594 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752111AbZDCCQV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Apr 2009 22:16:21 -0400
Received: by rv-out-0506.google.com with SMTP id g37so42331rvb.5
        for <git@vger.kernel.org>; Thu, 02 Apr 2009 19:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=2Nl473K4o0d3zyVlzhUFTeZO3z8jASyPqpwG5g7ra6E=;
        b=bSsoWHzsmJpc9CsPq+Mf62nzy+fF3f/IU5oT0D5T6VuK92Cc8bkzCRICr3jGWKB1CB
         gghxP/REvtQn1iYsMS27GQ93X06ZqqtBaTnY0ylgkOSHD/Zpv0rJPh2ytdJFSYsj0Zfy
         9YRLCELxiyeDQIxb7uxP81jftGx9avh6GZ1LE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Vz8NRyYzuH/XM40mYjPvgbXWaexCT/x417IwybTC0TjwAsLPulFve2ffeeVOiY4y7K
         roD7XyWw7EnYdc70+IbV9RYAU15TwOWW84BHWmFo0yCEBUxuk5fZXtbMTjKWD0Q1usNt
         pdDWkUgAlAN8/ktgvNNaqRHxRrXUPT3DJ+bHM=
Received: by 10.141.122.1 with SMTP id z1mr275669rvm.49.1238724979233;
        Thu, 02 Apr 2009 19:16:19 -0700 (PDT)
Received: from localhost (wdas-1.disneyanimation.com [12.188.26.1])
        by mx.google.com with ESMTPS id b8sm5229682rvf.42.2009.04.02.19.16.18
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 02 Apr 2009 19:16:18 -0700 (PDT)
X-Mailer: git-send-email 1.6.2.2.404.ge96f3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115511>

We don't need the '-merged "$MERGED"' option when in diff mode.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
 git-mergetool--lib.sh |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 06d261a..b8566b2 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -189,8 +189,12 @@ run_mergetool () {
 			"$merge_tool_path" "$LOCAL" "$REMOTE" \
 				-ancestor "$BASE" -merge "$MERGED" | cat
 		else
-			"$merge_tool_path" "$LOCAL" "$REMOTE" \
-				-merge "$MERGED" | cat
+			if merge_mode; then
+				"$merge_tool_path" "$LOCAL" "$REMOTE" \
+					-merge "$MERGED" | cat
+			else
+				"$merge_tool_path" "$LOCAL" "$REMOTE" | cat
+			fi
 		fi
 		check_unchanged
 		;;
-- 
1.6.1.3
