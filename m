From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v4 10/45] sequencer: trivial fix
Date: Sun,  9 Jun 2013 11:40:22 -0500
Message-ID: <1370796057-25312-11-git-send-email-felipe.contreras@gmail.com>
References: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 18:43:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UliiI-0006Yj-IO
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 18:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751443Ab3FIQnV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 12:43:21 -0400
Received: from mail-ob0-f180.google.com ([209.85.214.180]:37529 "EHLO
	mail-ob0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab3FIQnU (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 12:43:20 -0400
Received: by mail-ob0-f180.google.com with SMTP id eh20so8712994obb.25
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 09:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bd1uIgJwbXKGSID9lF4au6v8/hwnykDvBWTa6p8s2d8=;
        b=ENZmkj8V+Qwj+Rca1CJG1DfKf5Q1MKVH7DIFf/l/ehf2ovJVtnY9Jluq6x737H8H0Y
         xeu2BxU456iMWYGua0VTT7LIsiMedduYb0hpYDuOguUpySZ0jYmjjvbLzH7VqLd7Bc4r
         w14XuoSHgYKq+zMo9vmo/WJeVbaxW9yBmrKV6VEC7kd9A9SNx/DkqKRY+ND97Mh4N5RF
         WKYNp+tIG+Fh0OMLuXoi13Y9zCIZrKXbiDm6PBXHsDGamiHAmFHRlNDWQbX6HfwRwOO5
         rDwnNCZirJmOpVNYopVtXcIZXRpaaS1msvQ+u30ajtxdFGM94+aAUAkWc9ovJ0Ztd4P4
         gQ2A==
X-Received: by 10.60.47.130 with SMTP id d2mr5414898oen.67.1370796199798;
        Sun, 09 Jun 2013 09:43:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id h4sm15191304oel.2.2013.06.09.09.43.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 09:43:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370796057-25312-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226979>

We should free objects before leaving.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/sequencer.c b/builtin/sequencer.c
index b2c8c94..23b01b7 100644
--- a/builtin/sequencer.c
+++ b/builtin/sequencer.c
@@ -539,8 +539,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 	}
 
 	allow = allow_empty(opts, commit);
-	if (allow < 0)
-		return allow;
+	if (allow < 0) {
+		res = allow;
+		goto leave;
+	}
 	if (!opts->no_commit)
 		res = run_git_commit(defmsg, opts, allow);
 
-- 
1.8.3.698.g079b096
