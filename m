From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 11/36] cherry-pick: don't barf when there's nothing to do
Date: Sun,  9 Jun 2013 14:24:25 -0500
Message-ID: <1370805890-3453-12-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllH1-0003Xe-Ss
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752249Ab3FIT1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:18 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:49878 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752230Ab3FIT1P (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:15 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so8921719obc.41
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ia3zzu0S2PN7g2YtoQ59mroO3HJTWLS+ipBxhz2y268=;
        b=tBKM1SGtrLklyCW2astW59lzqM0VEszZ3Z3IKZc7kHDMj6LUnZ0Du8Z8TgM5mccRRd
         Bb+FldHVC6a85xzWQVyechTW4RfH9TQ4EyUjsf+LRednAL1fjlz62/TUM+Ga0ZHGEY0h
         bg4gQXN4xKuDe9quwA6D0HuUdibjAVle+xgdbxHPVKkdhz9AAWdf9V6qImXLjshAskN5
         A31Brx1W0qPZD5Ez8g2VsbyMl/4oMoLmpWAUsOPjTd7lp2UQdryQpCAytMC05vYJImw9
         HNso3iSsx5xN+1An0kcf1hZVLjnFfpd9/O4Toy5fljlRTuaLqW2bMriunXi0OLOuR6Ml
         vfKQ==
X-Received: by 10.60.138.134 with SMTP id qq6mr3735311oeb.41.1370806035219;
        Sun, 09 Jun 2013 12:27:15 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id rs4sm8778470obc.10.2013.06.09.12.27.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227119>

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
