From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 2/8] sequencer: trivial fix
Date: Tue, 28 May 2013 22:56:22 -0500
Message-ID: <1369799788-24803-3-git-send-email-felipe.contreras@gmail.com>
References: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@inf.ethz.ch>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 29 05:58:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhXWs-0002wT-GU
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 05:58:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934339Ab3E2D6R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 23:58:17 -0400
Received: from mail-ob0-f175.google.com ([209.85.214.175]:45441 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933578Ab3E2D6P (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 23:58:15 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so6822842obc.34
        for <git@vger.kernel.org>; Tue, 28 May 2013 20:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=ECYD1JyYIafXsFIJuw6rZ0FW65s0/Qhx6hrLPdNItrQ=;
        b=at0Xh6/fo9aD16huF4GQiyHqi4YqNoIwBO7moUetD8STN2IpABROtGgYWkJyyHQjye
         3s6/20QjQucgKphRfw6wAlgnCXLw6uaK3h2uujDOnOG9iZ6W2UwE73be9p0+yfeyyhGE
         /00sw1IqsTZWKmhgKq6A3Xz4CHAFyPEi0rWx3A6qkreP2XwIeCytg61DN/c5tztp3p67
         cbzoe/lrG6sZEcyniLYYrdC4rM4MqKh5RtCImETApZUbpRHFCZ2cuABmRTEczlwooltK
         2MWmojYthVKnPcVS8cSWdxyj5ukR+0NJB6E9z7IbdhgPc/pXrCS3uruAzDobj/7AeZAH
         NzIg==
X-Received: by 10.182.129.101 with SMTP id nv5mr481985obb.56.1369799894797;
        Tue, 28 May 2013 20:58:14 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id pm16sm39264896oeb.3.2013.05.28.20.58.12
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 20:58:14 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369799788-24803-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225717>

We should free objects before leaving.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index b4989ba..f7be7d8 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -628,8 +628,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
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
1.8.3.rc3.312.g47657de
