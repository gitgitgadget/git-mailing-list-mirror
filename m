From: Ralf Thielow <ralf.thielow@gmail.com>
Subject: [PATCH] rebase-i: print abbreviated hash when stop for editing
Date: Thu, 24 Mar 2016 19:31:21 +0100
Message-ID: <1458844281-13107-1-git-send-email-ralf.thielow@gmail.com>
Cc: Ralf Thielow <ralf.thielow@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 24 19:31:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajA2d-0005Ic-Dk
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 19:31:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbcCXSb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 14:31:27 -0400
Received: from mail-wm0-f49.google.com ([74.125.82.49]:34814 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751108AbcCXSb0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 14:31:26 -0400
Received: by mail-wm0-f49.google.com with SMTP id p65so486077wmp.1
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 11:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=HEaUxXh16JE2vzPzS7Z3ARooH2dRTdwvlCKRbvUEpjs=;
        b=A1aCdLOQ5lucLo/mSPOxGjX7NG1yrZ56E7P0SqBZ3KHJ3F/tz/CdsEIw6gJW/CLUH8
         rai82Dh9kVgu/AoYKRf4ODHuN8UCGoZI2ohGrv6Evnl+971jzBFIlHUc6n4jJuC76cQZ
         yGXK0ZqtzW5ROkbRnT/V1RdrNCVjnoWtQ0eTFVwvEcu4k4tR3j/DLTpZI7tmid55nLgb
         bUulgJZA/ImM9nLuE9FAcUsegwSHi08Tn9+sbVBdtS+1iouXoFEoHMX3RSTo9fo3z/wf
         PumazwuuBiyP2/1WICbvTbZcAvoportuLBZCNKhvNmpYKDPk/mBVh86e6FddKu/N4ElJ
         PEwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=HEaUxXh16JE2vzPzS7Z3ARooH2dRTdwvlCKRbvUEpjs=;
        b=gM2f+7HMvKpAll/ZX69O3y3znbllRJPcpWdg/1PEx4CJTyGNn5UTEss3MK5iqsbMJk
         eyCEOu5ZBKh/YkEn0w+6mN29CauCH2FccW9fOmWmbXTtvEIpnEjCrkc/rvs1lMXD5ZXR
         zDlPeAvWNXy+jdxSlUKI3OEaZ3K2ZbAqlKeWEO7LTzFpx91COqlahUZRh7LB7MNpD1hF
         K5AGCEK0dIkTq1huStA/3sP0cuWXHqc5nzjj0rNzeF6BIabn/zH/KeKqIRKH88WrafQh
         2dsZgttknsEqSOCp0auzDprcHU5oZM0MJF8An8KoIahjssEVoMhLYvrdMTLCR5JyL4Rh
         C0LA==
X-Gm-Message-State: AD7BkJLCEVNgt/kccFQZZiqYn+cMOwOTEQu9Phcf6+M6xGp0RsUnG/86pDAQZTQpzv312w==
X-Received: by 10.28.223.70 with SMTP id w67mr11519361wmg.92.1458844284897;
        Thu, 24 Mar 2016 11:31:24 -0700 (PDT)
Received: from localhost (cable-82-119-18-125.cust.telecolumbus.net. [82.119.18.125])
        by smtp.gmail.com with ESMTPSA id et11sm8559803wjc.30.2016.03.24.11.31.24
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 24 Mar 2016 11:31:24 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.rc4.7.g35d7ca9.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289783>

Signed-off-by: Ralf Thielow <ralf.thielow@gmail.com>
---
 git-rebase--interactive.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 4cde685..9ea3075 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -548,7 +548,8 @@ do_next () {
 
 		mark_action_done
 		do_pick $sha1 "$rest"
-		warn "Stopped at $sha1... $rest"
+		sha1_abbrev=$(git rev-parse --short $sha1)
+		warn "Stopped at $sha1_abbrev... $rest"
 		exit_with_patch $sha1 0
 		;;
 	squash|s|fixup|f)
-- 
2.8.0.rc4.7.g35d7ca9.dirty
