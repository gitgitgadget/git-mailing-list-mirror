From: Pete Wyckoff <pw@padd.com>
Subject: [PATCHv2 07/21] git p4 test: start p4d inside its db dir
Date: Sat, 26 Jan 2013 22:11:10 -0500
Message-ID: <1359256284-5660-8-git-send-email-pw@padd.com>
References: <1359256284-5660-1-git-send-email-pw@padd.com>
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 27 04:14:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TzIh7-0005E9-PM
	for gcvg-git-2@plane.gmane.org; Sun, 27 Jan 2013 04:14:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755498Ab3A0DNt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jan 2013 22:13:49 -0500
Received: from honk.padd.com ([74.3.171.149]:58708 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755361Ab3A0DNs (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jan 2013 22:13:48 -0500
Received: from arf.padd.com (unknown [50.52.174.88])
	by honk.padd.com (Postfix) with ESMTPSA id CA25D2F3F;
	Sat, 26 Jan 2013 19:13:47 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 6F05C22838; Sat, 26 Jan 2013 22:13:44 -0500 (EST)
X-Mailer: git-send-email 1.8.1.1.517.gf5c753f
In-Reply-To: <1359256284-5660-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214657>

This will avoid having to do native path conversion for
windows.  Also may be a bit cleaner always to know that p4d
has that working directory, instead of wherever the function
was called from.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 t/lib-git-p4.sh | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/t/lib-git-p4.sh b/t/lib-git-p4.sh
index c5d1f4d..185f6f1 100644
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
1.8.1.1.460.g6fa8886
