From: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
Subject: [PATCH 3/3] git-bundle.txt: Add different strategies to create the bundle
Date: Sun, 24 Feb 2008 14:42:40 +0100
Message-ID: <1203860560-12399-1-git-send-email-sbejar@gmail.com>
References: <1203860474-12291-1-git-send-email-sbejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?q?Santi=20B=C3=A9jar?= <sbejar@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 24 14:43:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JTH8W-0004sJ-EW
	for gcvg-git-2@gmane.org; Sun, 24 Feb 2008 14:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753023AbYBXNmt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 24 Feb 2008 08:42:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753028AbYBXNms
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Feb 2008 08:42:48 -0500
Received: from fg-out-1718.google.com ([72.14.220.156]:13718 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753020AbYBXNms (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Feb 2008 08:42:48 -0500
Received: by fg-out-1718.google.com with SMTP id e21so928218fga.17
        for <git@vger.kernel.org>; Sun, 24 Feb 2008 05:42:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        bh=7WlfTfWGzJHoFqDExMyLFvSrIHgyNS/H9uGc/NJdnKI=;
        b=ZThnun/rD6XHVSWBR8EwEKSebTAwVG/lezMoO4bolzHJ4ajWcr0hg9h0GtVx04w76L4wKARXOZUURLKmJHEuJRZc2MDn4RxLauoiyj77i+EpzGxxpCIScwYCh4fkBzFtxtLlwqzujay2zvSWt0PSqnrKAuoRIFYW2j7Nes5vzZk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references:mime-version:content-type:content-transfer-encoding;
        b=k7jowlGAU994+imUBgBQ91SxI9bzSnzA5wixhuZdFnnZTOOjQWpevMvFnEaBG+d/Yhw2gcnAW2ilpQWeJjuCh91yjE2FTvvDFgcqUqDpEnyO7gHGEqx7+MSRcbmFvojf4X+d7LSiwFPvhOP0sgyawcj/xgue47oUkGDI7vlCN4c=
Received: by 10.86.77.5 with SMTP id z5mr1645445fga.5.1203860567362;
        Sun, 24 Feb 2008 05:42:47 -0800 (PST)
Received: from localhost ( [91.13.69.136])
        by mx.google.com with ESMTPS id 12sm4772387fgg.6.2008.02.24.05.42.44
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 24 Feb 2008 05:42:46 -0800 (PST)
X-Mailer: git-send-email 1.5.4.3.293.gac81
In-Reply-To: <1203860474-12291-1-git-send-email-sbejar@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74932>


Signed-off-by: Santi B=C3=A9jar <sbejar@gmail.com>
---
 Documentation/git-bundle.txt |   38 +++++++++++++++++++++++++++++++---=
----
 1 files changed, 31 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-bundle.txt b/Documentation/git-bundle.tx=
t
index 1143cdc..be6c7d9 100644
--- a/Documentation/git-bundle.txt
+++ b/Documentation/git-bundle.txt
@@ -119,27 +119,51 @@ Assume two repositories exist as R1 on machine A,=
 and R2 on machine B.
 For whatever reason, direct connection between A and B is not allowed,
 but we can move data from A to B via some mechanism (CD, email, etc).
 We want to update R2 with developments made on branch master in R1.
+
+To create the bundle you have to specify the basis. You have some opti=
ons:
+
+- Without basis.
++
+This is usefull to send the whole history.
+
+------------
+$ git bundle create mybundle master
+------------
+
+- Using temporally tags.
++
 We set a tag in R1 (lastR2bundle) after the previous such transport,
 and move it afterwards to help build the bundle.
=20
-in R1 on A:
-
 ------------
 $ git-bundle create mybundle master ^lastR2bundle
 $ git tag -f lastR2bundle master
 ------------
=20
-(move mybundle from A to B by some mechanism)
+- Using a tag present in both repositories
+
+------------
+$ git bundle create mybundle master ^v1.0.0
+------------
+
+- A basis based on time.
+
+------------
+$ git bundle create mybundle master --since=3D10.days.ago
+------------
=20
-in R2 on B:
+- With a limit on the number of commits
=20
 ------------
-$ git-bundle verify mybundle
-$ git-fetch mybundle  refspec
+$ git bundle create mybundle master -n 10
 ------------
=20
-where refspec is refInBundle:localRef
+Then you move mybundle from A to B, and in R2 on B:
=20
+------------
+$ git-bundle verify mybundle
+$ git-fetch mybundle master:localRef
+------------
=20
 Author
 ------
--=20
1.5.4.3.293.gac81
