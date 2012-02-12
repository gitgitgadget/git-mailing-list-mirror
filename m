From: Jakub Narebski <jnareb@gmail.com>
Subject: [PATCH] gitweb: Harden and improve $project_filter page title
Date: Sun, 12 Feb 2012 16:21:30 +0100
Message-ID: <1329060090-32370-1-git-send-email-jnareb@gmail.com>
Cc: "Bernhard R. Link" <brl+git@mail.brlink.eu>,
	Jakub Narebski <jnareb@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 16:22:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RwbG6-00069v-Px
	for gcvg-git-2@plane.gmane.org; Sun, 12 Feb 2012 16:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755408Ab2BLPV7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Feb 2012 10:21:59 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:59983 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754503Ab2BLPV7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2012 10:21:59 -0500
Received: by eekc14 with SMTP id c14so1548673eek.19
        for <git@vger.kernel.org>; Sun, 12 Feb 2012 07:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=BpoLwTi30Gd/A3p7xyosAJbj1qBCQ6Hm2mnO2UbkPPo=;
        b=IaINvHVZ1NyTZswohkHTABRz6an4651ASUBwvAN3B9iJlvbqQ37fLvk4bUL0WeA0X4
         KNaU2jQF8tsFvJNc2Od6Z1Z+uFZAh9O0mWg44aS2dkCtiMuHZR9YhNMc0zqgLns0PPDU
         5mwwo1Tp8n/875kc0xG0gTOIzUOQll0mD5flg=
Received: by 10.14.202.200 with SMTP id d48mr3403834eeo.24.1329060117583;
        Sun, 12 Feb 2012 07:21:57 -0800 (PST)
Received: from localhost.localdomain (abwh127.neoplus.adsl.tpnet.pl. [83.8.231.127])
        by mx.google.com with ESMTPS id w60sm31491125eeb.4.2012.02.12.07.21.55
        (version=SSLv3 cipher=OTHER);
        Sun, 12 Feb 2012 07:21:57 -0800 (PST)
X-Mailer: git-send-email 1.7.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190573>

Commit 19d2d23 (gitweb: add project_filter to limit project list
to a subdirectory, 2012-01-30) added also support for displaying
$project_filter, if present, in page title.

Unfortunately it forgot to treat $project_filter as path, and escape
it using esc_path(), like it is done for $filename.

Also, it was not obvious that "$site_name - $project_filter" is about
project filtering: use "$site_name - projects in '$project_filter'".

Signed-off-by: Jakub Narebski <jnareb@gmail.com>
---
Though we should probably also esc_path($project), not only
to_utf8($project) in get_page_title() subroutine.

So I am not that sure if it is really necessary, or if I should follow
it by further hardening of get_page_title().

Anyway I have noticed this when I was examining gitweb code for
generating page title, considering adding information about search for
project search.  So this is patch I will be depending textually via
context lines on.

 gitweb/gitweb.perl |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 081ac45..8ba2022 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -3751,7 +3751,7 @@ sub get_page_title {
 
 	unless (defined $project) {
 		if (defined $project_filter) {
-			$title .= " - " . to_utf8($project_filter);
+			$title .= " - projects in '" . esc_path($project_filter) . "'";
 		}
 		return $title;
 	}
-- 
1.7.9
