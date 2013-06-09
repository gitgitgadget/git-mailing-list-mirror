From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 11/45] cherry-pick: don't barf when there's nothing to do
Date: Sun,  9 Jun 2013 11:40:23 -0500
Message-ID: <1370796057-25312-12-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliiJ-0006Yj-4D
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493Ab3FIQnZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:25 -0400
Received: from mail-ob0-f181.google.com ([209.85.214.181]:51672 "EHLO
	mail-ob0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3FIQnX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:23 -0400
Received: by mail-ob0-f181.google.com with SMTP id 16so8929756obc.26
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ia3zzu0S2PN7g2YtoQ59mroO3HJTWLS+ipBxhz2y268=;
        b=LVPicBC2/bBnblZ6GG6344qyVny+WfY7+64I0ooxGbMKC+PElSAIOwjejbG2caOTQw
         cklp+rsJBGh00EMBUF+N6bV+fP7nKbCbT2a8IbeaSMl8SugjA4rRLbZxY6/en8viWcIp
         ZrORz8206S9d5SOjbAZOO61QcMDW0/aUZELr9Ebn1Mf9kqfqyFNbjmzsCIcKhpykP4w5
         WOE0M0qgfHSNPQH/CiMNTmXEmdVddtv4KIFb9kRl/MEDNcXdZ5rp7pHW1tKuRmQil9FI
         W1IdUc+nGQqM2H/p2Y0yhDKkVuAKi7CGhUuLYI1PQQCqWPn/gbmlbm/amRBvH0HVeZRK
         kIZg==
X-Received: by 10.182.120.196 with SMTP id le4mr5327188obb.57.1370796202612;
        Sun, 09 Jun 2013 09:43:22 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id r4sm15180625oem.3.2013.06.09.09.43.20
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226980>

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c             | 4 ++--
 t/t3510-cherry-pick-sequence.sh | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index 23b01b7..4d7dc8b 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -565,8 +565,8 @@ static void prepare_revs(struct replay_opts *opts)
 	if (prepare_revision_walk(opts->revs))
 		die(_("revision walk setup failed"));
 
-	if (!opts->revs->commits)
-		die(_("empty commit set passed"));
+	if (!opts->revs->commits && !opts->quiet)
+		error(_("empty commit set passed"));
 }
 
 static void read_and_refresh_cache(struct replay_opts *opts)
diff --git a/t/t3510-cherry-pick-sequence.sh b/t/t3510-cherry-pick-sequence.sh
index 7b7a89d..33c5512 100755
--- a/t/t3510-cherry-pick-sequence.sh
+++ b/t/t3510-cherry-pick-sequence.sh
@@ -472,7 +472,7 @@ test_expect_success 'malformed instruction sheet 2' '
 
 test_expect_success 'empty commit set' '
 	pristine_detach initial &&
-	test_expect_code 128 git cherry-pick base..base
+	git cherry-pick base..base
 '
 
 test_expect_success 'malformed instruction sheet 3' '
-- 
1.8.3.698.g079b096
