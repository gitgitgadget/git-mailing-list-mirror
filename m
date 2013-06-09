From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 26/45] rebase: cherry-pick: fix abort of cherry mode
Date: Sun,  9 Jun 2013 11:40:38 -0500
Message-ID: <1370796057-25312-27-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uliiz-00074a-Jp
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752216Ab3FIQoH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:07 -0400
Received: from mail-oa0-f49.google.com ([209.85.219.49]:60842 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752104Ab3FIQoF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:05 -0400
Received: by mail-oa0-f49.google.com with SMTP id k14so5089677oag.36
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=TCS3QidtT44FLGA2ZGFWPm0BGB2Kzo6jgeEmbXm+7x0=;
        b=k8E3NZl4iaCcwcE1/enNs05Pldu2/JZyewvWpBowOMnpIGqtZ1JAZ7XDhk83h6U/KZ
         hqfRSL1amiiP6OrCK4Uy9MYaboY+/vBp07ukPeGLZKSdY/r5N8t50SsCI2lnBUT1Scxb
         U08AOO/LMImR0geGVk+k04h47v4Dbmy+aaSeKL5tVViPSsTanZzWVy13W+IgV5wpeLIn
         8pzNdF8yo0IOVpv1dsEDGtLuVGP624/mlERKR4u1pZrkYQy6mP/rWl8GezNCxIRca9tQ
         0EXGvjz8PeOwvFO/neKXxmqdSAoPGGbRCQaE09Ci311340VHsmiQUexAS13BxCj2OsBO
         kgnw==
X-Received: by 10.182.213.10 with SMTP id no10mr5195000obc.76.1370796244912;
        Sun, 09 Jun 2013 09:44:04 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id dz4sm14846917obb.14.2013.06.09.09.44.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226996>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/git-rebase.sh b/git-rebase.sh
index 4465daf..0937e2c 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -369,6 +369,7 @@ skip)
 	run_specific_rebase
 	;;
 abort)
+	test "$type" == "cherrypick" && git cherry-pick --abort
 	git rerere clear
 	read_basic_state
 	case "$head_name" in
-- 
1.8.3.698.g079b096
