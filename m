From: Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] gitweb: fix error in sanitize when highlight is enabled
Date: Sun, 30 Dec 2012 13:52:53 +0200
Message-ID: <1356868373-12721-1-git-send-email-orgads@gmail.com>
Cc: Orgad Shaneh <orgads@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 30 13:01:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TpHZp-0006bp-Ca
	for gcvg-git-2@plane.gmane.org; Sun, 30 Dec 2012 13:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754556Ab2L3MAx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Dec 2012 07:00:53 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:34022 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754547Ab2L3MAx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Dec 2012 07:00:53 -0500
Received: by mail-we0-f174.google.com with SMTP id x10so5514560wey.19
        for <git@vger.kernel.org>; Sun, 30 Dec 2012 04:00:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=2tY/MVwDNeggqIsDyesx0ULIsZXNGafZRatCLvmuhlQ=;
        b=0udOihqM/OQK4EFlIEiGhEJalU7w4555CY7R+s1bQbD+bfmNpwBLJsmO/zSCaUS4C6
         UlbGpPGFBR7D64+m7NVYn5X/6Xe3NEfpHclAJC37bICKilhow5F+fONecsbmU0JrdMRW
         znEYCqlXzlxZSUCtm3m5Fnc8ztBEv9pJ5Ht6fG80W/Qmk/LzosOxtGBCh02BieHha0gA
         3XFbGz/77ms6D9yLfQOdRbXfVvJapI6u3Xelb/JbGRaCJHnsrZav5beUHq+gbZDBV1l2
         2mb+QSVonUMygtw296rZXP4n91GJCJfLihNSICFZEnFxpnvsifVEx9zlPIAASdpgHp7m
         2lOQ==
X-Received: by 10.180.99.1 with SMTP id em1mr57951758wib.20.1356868387438;
        Sun, 30 Dec 2012 03:53:07 -0800 (PST)
Received: from localhost.localdomain (IGLD-84-228-100-27.inter.net.il. [84.228.100.27])
        by mx.google.com with ESMTPS id ew4sm64227823wid.11.2012.12.30.03.53.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 30 Dec 2012 03:53:06 -0800 (PST)
X-Mailer: git-send-email 1.7.10.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212328>

$1 becomes undef by internal regex, since it has no capture groups.

Match against accpetable control characters using index() instead of a regex.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 gitweb/gitweb.perl |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 0f207f2..6d5aeab 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -1556,7 +1556,7 @@ sub sanitize {
 	return undef unless defined $str;
 
 	$str = to_utf8($str);
-	$str =~ s|([[:cntrl:]])|($1 =~ /[\t\n\r]/ ? $1 : quot_cec($1))|eg;
+	$str =~ s|([[:cntrl:]])|(index("\t\n\r", $1) != -1 ? $1 : quot_cec($1))|eg;
 	return $str;
 }
 
-- 
1.7.10.4
