From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 34/45] rebase: cherry-pick: add merge options
Date: Sun,  9 Jun 2013 11:40:46 -0500
Message-ID: <1370796057-25312-35-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:44:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlijM-0007Jj-4A
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:44:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479Ab3FIQoa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:44:30 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:36575 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667Ab3FIQo2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:44:28 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so8745380obb.8
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=YDWkGWYarM1us5nVH6x5c61Xu72MbANfZHe0tUsC5Q0=;
        b=jo8287CmTU/ippuo9RL9z2VTAwCBBQyePJowPwHXYYbtmrsJ4nHH1fMGK2oUPjmIgs
         wIV04Zk1bPGFxHETB/dDKGnFsz1Yq5RLXI4WyXmrWq6b41q/NDZxGMZYha3hGJLC/q6v
         paqoOldJcMgqjDlv7Ho4BAphiKWTEo6hfnkQVsk/rGuuR541FKk3sUvsjei4UzXr3Ho0
         6D5uOQ3wmXy9CLjNHPPuK5AZ8YR1v85ENmPWEJjb8FfaPScWc64hzNjHEwqWa50nTxaV
         JMp7bEZkybAcsLN2FbxsvV+jU7Av1UZQ288oFVpSiNTCcPyAAp9ON0AprSTtYeg05A7n
         dZPw==
X-Received: by 10.182.135.161 with SMTP id pt1mr5259649obb.3.1370796267382;
        Sun, 09 Jun 2013 09:44:27 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id wv8sm14960376obb.2.2013.06.09.09.44.25
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:44:26 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227001>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase--cherrypick.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/git-rebase--cherrypick.sh b/git-rebase--cherrypick.sh
index 6f63618..644d45e 100644
--- a/git-rebase--cherrypick.sh
+++ b/git-rebase--cherrypick.sh
@@ -48,6 +48,14 @@ else
 fi
 test -n "$GIT_QUIET" && extra="$extra -q"
 test -z "$force_rebase" && extra="$extra --ff"
+test -n "$strategy" && extra="$extra --strategy=$strategy"
+for x in "$strategy_opts"
+do
+	test -z "$x" && continue
+	x=$(eval "echo $x")
+	extra="$extra -X${x#--}"
+done
+test -n "$allow_rerere_autoupdate" && extra="$extra $allow_rerere_autoupdate"
 
 git rev-list $rev_args > "$state_dir"/list
 git cherry-pick --action-name rebase $extra $rev_args
-- 
1.8.3.698.g079b096
