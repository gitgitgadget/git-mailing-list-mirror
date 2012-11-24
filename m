From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p1.1 11/14] remote-testgit: implement the "done" feature manually
Date: Sat, 24 Nov 2012 04:17:11 +0100
Message-ID: <1353727034-24698-12-git-send-email-felipe.contreras@gmail.com>
References: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Max Horn <max@quendi.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:18:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6GA-0002E8-S5
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:18:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756790Ab2KXDSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:18:08 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:61989 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932594Ab2KXDSG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:18:06 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063027bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:18:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=RH6vdg4Jpgf3LhD5nqCw5A4PP8bglsg9gC4NAuJVnvQ=;
        b=MHbGgbJadxhb/vtKzrN8SRJYU11iPJF05DJoz/F1lDrIeFCDXX1S/zSF2PBZBZoyh5
         XPqKvF+IDaju4utx5QeDTQKDp/oiL6yaC3bmLbX1T9FTpgbSJXH2aDvT+T5Ze82T/Xm7
         xHamM8f7+K9kkAYGv++cbsi1yRM6ffbp2JJ6t8Vwm/ypevA4BAuech7WspxO6/voE0AU
         DAzLBYKPLt2V29awt35r99fzWX8HWRgghtes+AxV6hjYkqbVQI3SfmZKV3ILxC9FW0v8
         RGWR60y97j5j9IH9deBCri/Oa/5JRLV+mSkC6AE9AEFq6W8zfQ1s6Vvj4SSWUGtzI7i5
         unmQ==
Received: by 10.204.10.88 with SMTP id o24mr528292bko.19.1353727086184;
        Fri, 23 Nov 2012 19:18:06 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id 1sm5467106bks.3.2012.11.23.19.18.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:18:05 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727034-24698-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210295>

People who want to write their own remote-helper will find it more
useful to see clearly how they are supposed to advertise and implement
the "done" feature themselves.

Right now we are relying on fast-export to do that by using the
--use-done-feature argument. However, people writing their own
remote-helper would probably not have such an option, as they would
probably be writing the fast-export functionality themselves.

It should now be clearer to them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-remote-testgit | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-remote-testgit b/git-remote-testgit
index aba3502..0389545 100755
--- a/git-remote-testgit
+++ b/git-remote-testgit
@@ -61,8 +61,10 @@ do
 			echo "feature import-marks=$gitmarks"
 			echo "feature export-marks=$gitmarks"
 		fi
-		git fast-export --use-done-feature "${testgitmarks_args[@]}" $refs |
+		echo "feature done"
+		git fast-export "${testgitmarks_args[@]}" $refs |
 		sed -e "s#refs/heads/#${prefix}/heads/#g"
+		echo "done"
 		;;
 	export)
 		before=$(git for-each-ref --format='%(refname) %(objectname)')
-- 
1.8.0
