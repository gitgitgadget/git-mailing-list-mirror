From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 1/2] sequencer: trivial fix
Date: Mon, 27 May 2013 11:52:18 -0500
Message-ID: <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 27 18:54:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uh0gU-0005T6-La
	for gcvg-git-2@plane.gmane.org; Mon, 27 May 2013 18:54:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755502Ab3E0QyG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 May 2013 12:54:06 -0400
Received: from mail-ob0-f182.google.com ([209.85.214.182]:50889 "EHLO
	mail-ob0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755418Ab3E0QyF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 May 2013 12:54:05 -0400
Received: by mail-ob0-f182.google.com with SMTP id va7so1214853obc.27
        for <git@vger.kernel.org>; Mon, 27 May 2013 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=wZ5WN3k3oVJeUQsJtx/Pddb52eArhVoDb53B/kET15Q=;
        b=GSTMLo9oOZiuRVy56x7MgEiYKlu/Ztqw9dLjRhZcLJbaROLzql6uah5Kk6gZFuSwcT
         FYqaUiwjDUfDYzf/5FmgkeUlvDVUAzWZ5KsHvxTJ2VgnukL9l5caU/d4aclrbdmlAwAz
         dRGYPbcG6qJJlZdbLiXocFa6XKEphf8INf6WIfQjX4weQroubd4hG5p4JBFmX5ouyZJg
         ZQWiHPeJvgyhG+Up67g2A1Z0nV4bRCBp7aga+6Jo48rfAkt4m63H4SNpjmZMXfy/6WsV
         EPCp3jlSilMDV/e524/xCx45m4izFNwYgOa3QnOQhqcd/X08IoFAj1lwv5DfsCgPr3vf
         hybQ==
X-Received: by 10.182.129.101 with SMTP id nv5mr18300164obb.56.1369673645211;
        Mon, 27 May 2013 09:54:05 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id n5sm30745133obi.8.2013.05.27.09.54.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 27 May 2013 09:54:04 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.312.g47657de
In-Reply-To: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225610>

We should free objects before leaving.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 sequencer.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/sequencer.c b/sequencer.c
index ab6f8a7..7eeae2f 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -626,12 +626,15 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
 		rerere(opts->allow_rerere_auto);
 	} else {
 		int allow = allow_empty(opts, commit);
-		if (allow < 0)
-			return allow;
+		if (allow < 0) {
+			res = allow;
+			goto leave;
+		}
 		if (!opts->no_commit)
 			res = run_git_commit(defmsg, opts, allow);
 	}
 
+leave:
 	free_message(&msg);
 	free(defmsg);
 
-- 
1.8.3.rc3.312.g47657de
