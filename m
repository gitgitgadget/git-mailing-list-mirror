From: Alexey Shumkin <alex.crezoff@gmail.com>
Subject: [PATCH 1/3] mergetool--lib: fix startup options for gvimdiff tool
Date: Thu, 24 Jan 2013 11:16:06 +0400
Message-ID: <1359011768-7665-1-git-send-email-Alex.Crezoff@gmail.com>
Cc: Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 24 08:17:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyH3c-0002gk-1x
	for gcvg-git-2@plane.gmane.org; Thu, 24 Jan 2013 08:17:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752283Ab3AXHQs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 02:16:48 -0500
Received: from mail-la0-f44.google.com ([209.85.215.44]:51996 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751776Ab3AXHQq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 02:16:46 -0500
Received: by mail-la0-f44.google.com with SMTP id eb20so8625744lab.3
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 23:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=RjTPa35kTSR/vySAhj4RlW2BZMhaPTgBy7OOlkwFRog=;
        b=WMPDboqUogsZ3Jy2Yd/BNhqFyotnU5wrWCl7OvsSOuSOsGfX20r+iEmf9keiHiErhd
         3l6jK0XIImy00psZmj79A7bmrIV19M6b/2tzMTbZvnhRaqEeeH5a92POLfTfhR6vv0mN
         VMw9TWz6/LTZHg4+fffFFpjBgxKd3AagYHrQ8EVecbEEpAIdypVyKGVdyNVz92jFsCQF
         mbYtmnorSczSuyDYOPmR7iy4dHrcW0YQHsIHCt72nnmcH/h/iunH1VoIs+8Zqzyqn3gJ
         YZh1DZExN1D5xasD+2RFUBDLTLUY9HGftpcoxY1JYa7iVd17NqFLE62E1VIrN8KIADjT
         Pmjg==
X-Received: by 10.152.144.71 with SMTP id sk7mr861302lab.29.1359011805042;
        Wed, 23 Jan 2013 23:16:45 -0800 (PST)
Received: from ds212plus (ppp91-77-44-105.pppoe.mtu-net.ru. [91.77.44.105])
        by mx.google.com with ESMTPS id gi3sm8793830lab.7.2013.01.23.23.16.43
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 23 Jan 2013 23:16:44 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
	by ds212plus (Postfix) with ESMTP id 4F27D60002;
	Thu, 24 Jan 2013 11:17:19 +0400 (MSK)
X-Mailer: git-send-email 1.8.1.1.10.g9255f3f
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214405>

Options are taken from <Git source>/mergetools/vim

Signed-off-by: Alexey Shumkin <Alex.Crezoff@gmail.com>
---
 git-gui/lib/mergetool.tcl | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/git-gui/lib/mergetool.tcl b/git-gui/lib/mergetool.tcl
index 3c8e73b..4fc1cab 100644
--- a/git-gui/lib/mergetool.tcl
+++ b/git-gui/lib/mergetool.tcl
@@ -211,7 +211,13 @@ proc merge_resolve_tool2 {} {
 		}
 	}
 	gvimdiff {
-		set cmdline [list "$merge_tool_path" -f "$LOCAL" "$MERGED" "$REMOTE"]
+		if {$base_stage ne {}} {
+			set cmdline [list "$merge_tool_path" -f -d -c "wincmd J" \
+				"$MERGED" "$LOCAL" "$BASE" "$REMOTE"]
+		} else {
+			set cmdline [list "$merge_tool_path" -f -d -c "wincmd l" \
+				"$LOCAL" "$MERGED" "$REMOTE"]
+		}
 	}
 	kdiff3 {
 		if {$base_stage ne {}} {
-- 
1.8.1.1.10.g9255f3f
