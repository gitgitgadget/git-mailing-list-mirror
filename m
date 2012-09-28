From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 07/21] git p4 test: start p4d inside its db dir
Date: Fri, 28 Sep 2012 08:04:11 -0400
Message-ID: <1348833865-6093-8-git-send-email-pw@padd.com>
References: <1348833865-6093-1-git-send-email-pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 28 14:07:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THZLV-0002AZ-V6
	for gcvg-git-2@plane.gmane.org; Fri, 28 Sep 2012 14:07:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab2I1MGw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2012 08:06:52 -0400
Received: from honk.padd.com ([74.3.171.149]:34965 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757141Ab2I1MGt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2012 08:06:49 -0400
Received: from arf.padd.com (unknown [50.55.148.232])
	by honk.padd.com (Postfix) with ESMTPSA id ECCEA5AF2;
	Fri, 28 Sep 2012 05:06:48 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id A356D31413; Fri, 28 Sep 2012 08:06:46 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.1.457.g468b3ef
In-Reply-To: <1348833865-6093-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206564>

This will avoid having to do native path conversion for
windows.  Also may be a bit cleaner always to know that p4d
has that working directory, instead of wherever the function
was called from.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index d558dd0..402d736 100644
--- a/t/lib-git-p4.sh
+++ b/t/lib-git-p4.sh
@@ -40,8 +40,11 @@ start_p4d() {
 	mkdir -p "$db" "$cli" "$git" &&
 	rm -f "$pidfile" &&
 	(
-		p4d -q -r "$db" -p $P4DPORT &
-		echo $! >"$pidfile"
+		cd "$db" &&
+		{
+			p4d -q -p $P4DPORT &
+			echo $! >"$pidfile"
+		}
 	) &&
 
 	# This gives p4d a long time to start up, as it can be
-- 
1.7.12.1.403.g28165e1
