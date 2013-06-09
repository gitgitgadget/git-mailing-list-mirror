From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v5 10/36] sequencer: trivial fix
Date: Sun,  9 Jun 2013 14:24:24 -0500
Message-ID: <1370805890-3453-11-git-send-email-felipe.contreras@gmail.com>
References: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 09 21:27:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UllGr-0003Pb-CH
	for gcvg-git-2@plane.gmane.org; Sun, 09 Jun 2013 21:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752233Ab3FIT1P (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Jun 2013 15:27:15 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:45014 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752170Ab3FIT1M (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Jun 2013 15:27:12 -0400
Received: by mail-ob0-f177.google.com with SMTP id ta17so8892316obb.22
        for <git@vger.kernel.org>; Sun, 09 Jun 2013 12:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=bd1uIgJwbXKGSID9lF4au6v8/hwnykDvBWTa6p8s2d8=;
        b=ByxewcVp/4qGFhHHB6jPOALCXSPx+U4uKPYOxbHN9x1/fQd+7UWz+6Ve8gKfcpEqXE
         arX9s2Ai0tKJAqnhEEr9KddRlzs9DeKVUdtaDQtiDDeMFLoQUdCbCEJgvh7RRKfAEUg1
         eFFAQ8BVaJIqUOvbgTZiy6SPgatSKlxE4s53Ub59Nn9B7rxYsZ21T/6yuvTdCmWgo4KO
         5XgGv7AU+nq28KFQvzWJe6+NrkOeUJ5yQKyEL4upn0TEsyXYgLzjn/CymGMcrOdDwFOK
         DgfrhhiISVR1PfXJtuAnE9Cleu8i0jNJl/GO2Cz3C7TvBDfkxivvhzTU2tUXaE59r/A/
         tnrw==
X-Received: by 10.182.230.163 with SMTP id sz3mr5485347obc.81.1370806032252;
        Sun, 09 Jun 2013 12:27:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id oe10sm16249250oeb.6.2013.06.09.12.27.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 12:27:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
In-Reply-To: <1370805890-3453-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227118>

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
