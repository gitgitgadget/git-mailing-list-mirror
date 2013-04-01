From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 4/4] tmp: run-command: code to exercise check_command
Date: Mon,  1 Apr 2013 15:46:44 -0600
Message-ID: <1364852804-31875-5-git-send-email-felipe.contreras@gmail.com>
References: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>, Aaron Schrab <aaron@schrab.com>,
	Clemens Buchacher <drizzd@aon.at>,
	David Michael Barr <b@rr-dav.id.au>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 01 23:55:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UMmhH-00072W-KV
	for gcvg-git-2@plane.gmane.org; Mon, 01 Apr 2013 23:55:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759211Ab3DAVyz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Apr 2013 17:54:55 -0400
Received: from mail-gg0-f182.google.com ([209.85.161.182]:53442 "EHLO
	mail-gg0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758358Ab3DAVyy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Apr 2013 17:54:54 -0400
Received: by mail-gg0-f182.google.com with SMTP id u2so461190ggn.13
        for <git@vger.kernel.org>; Mon, 01 Apr 2013 14:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=UCtGcqYpe+x2BdbYg9SknwK2GMmc72Ec/HA7c9sX5jk=;
        b=cmnugmoauamAESqvtinLYGSBeRCZmqYKOt5ttAv/fWH9kPNDhh9aL8HxMaGvRfKKOW
         xFkDtxByFUW2Ib77vovcxv7TsfimHTAdWWPBQ2FRxGn6+p/Doyt18qWjnM7lw+QMWyif
         ynYt/5Y0ttVnf4XeXkznWjPZ28SrgjZlGOLdtBGSsoKugfeWZnAaYL5D+QpctRhzv8cP
         ZNEBU1q0jrqeqdmd9EBrOPiUdGXkSgOCTJ+eyQThrReiRErJnOSbzzPI+u61jm07bHBJ
         IxQVxnnQ/S1s2om9AidH9Zv+z6ObmNKzumBCAcj0TID194vZEqmzUjU5RikJn7/I5oM4
         UCbA==
X-Received: by 10.236.130.242 with SMTP id k78mr12112746yhi.18.1364852872461;
        Mon, 01 Apr 2013 14:47:52 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id u77sm30118047yhe.27.2013.04.01.14.47.50
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Apr 2013 14:47:51 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1364852804-31875-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219718>

Do not merge!

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 run-command.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/run-command.c b/run-command.c
index 16833df..6f20d5f 100644
--- a/run-command.c
+++ b/run-command.c
@@ -234,6 +234,7 @@ static pid_t persistent_waitpid(struct child_process *cmd, pid_t pid, int *stat_
 		return errno ? -1 : pid;
 	} else {
 		pid_t waiting;
+		die("not supposed to happen");
 		while ((waiting = waitpid(pid, stat_loc, 0)) < 0 && errno == EINTR)
 			;	/* nothing */
 		return waiting;
@@ -246,6 +247,11 @@ static int wait_or_whine(struct child_process *cmd, pid_t pid, const char *argv0
 	pid_t waiting;
 	int failed_errno = 0;
 
+	do {
+		if (!check_command(cmd))
+			break;
+	} while(1);
+
 	waiting = persistent_waitpid(cmd, pid, &status);
 
 	if (waiting < 0) {
-- 
1.8.2
