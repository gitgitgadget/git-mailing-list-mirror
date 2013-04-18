From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 5/6] transport-helper: trivial code shuffle
Date: Wed, 17 Apr 2013 23:14:32 -0500
Message-ID: <1366258473-12841-6-git-send-email-felipe.contreras@gmail.com>
References: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 06:16:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USgGW-0002IG-Nj
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 06:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753744Ab3DREQD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 00:16:03 -0400
Received: from mail-yh0-f44.google.com ([209.85.213.44]:53726 "EHLO
	mail-yh0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753084Ab3DREQA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 00:16:00 -0400
Received: by mail-yh0-f44.google.com with SMTP id m1so393772yhg.31
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 21:16:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/Lbg6Xk1/JkhDSNWD3q9S+VfnrS/z156bohw6EmgVTM=;
        b=ZLVBWUPA4NYjdOurGo/mSwjzG0ayoEMdxAF0bdUu0rzgE3NwgFBYNBar1iS05MuQnB
         T8tWV+2/yqdu/c+FIJ9Thunjk6mitJoAoQfDoj0WBe+32oE9lP5ZYUUNxmH39/VHKUqg
         WkNk1qkbLArWKcxMg85MC0xs/YHEtyQDp1xnMKBHnAMSX+B/bbHikpcDoG09mXOX3HNZ
         fnE7WnAmrmklkNnKTjxf7ewn5H6pFUCyb0yFmLFDcpGPCj0pms0qAKhQyoxJDGtUSeyQ
         hEvTjS31uoXh3IPtlYZUKyc47fCHzYp7TBj4DLMUOFGizrKWnGgbfVTWlfU+5RGreiVh
         BXsg==
X-Received: by 10.236.170.131 with SMTP id p3mr6341207yhl.143.1366258560007;
        Wed, 17 Apr 2013 21:16:00 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id q28sm819288yhm.13.2013.04.17.21.15.57
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 21:15:58 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366258473-12841-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221607>

Just shuffle the die() part to make it more explicit, and cleanup the
code-style.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 transport-helper.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 573eaf7..9d31f2d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -800,6 +800,9 @@ static int push_refs_with_export(struct transport *transport,
 		char *private;
 		unsigned char sha1[20];
 
+		if (ref->deletion)
+			die("remote-helpers do not support ref deletion");
+
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
@@ -807,13 +810,8 @@ static int push_refs_with_export(struct transport *transport,
 		}
 		free(private);
 
-		if (ref->deletion) {
-			die("remote-helpers do not support ref deletion");
-		}
-
 		if (ref->peer_ref)
 			string_list_append(&revlist_args, ref->peer_ref->name);
-
 	}
 
 	if (get_exporter(transport, &exporter, &revlist_args))
-- 
1.8.2.1.679.g509521a
