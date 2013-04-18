From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 5/6] transport-helper: trivial code shuffle
Date: Wed, 17 Apr 2013 19:05:23 -0500
Message-ID: <1366243524-18202-6-git-send-email-felipe.contreras@gmail.com>
References: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Max Horn <max@quendi.de>, Jonathan Nieder <jrnieder@gmail.com>,
	Florian Achleitner <florian.achleitner.2.6.31@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 18 02:06:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UScNO-00079y-5I
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 02:06:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935502Ab3DRAGx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Apr 2013 20:06:53 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:62576 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S935433Ab3DRAGw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Apr 2013 20:06:52 -0400
Received: by mail-yh0-f46.google.com with SMTP id l109so366495yhq.19
        for <git@vger.kernel.org>; Wed, 17 Apr 2013 17:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=/Lbg6Xk1/JkhDSNWD3q9S+VfnrS/z156bohw6EmgVTM=;
        b=L+l/tRKFLjLzZ05hIDnFMNuai0W3KyCUcuGxFrRGAFgaZ7+OGpftu0ntHFe6Wem42I
         gDEkvvEaU1BHuDx892wfltMQiCi3eRg3n6Tb9KFclf/W0GL8OBygLmV74rty7/Qb7BRv
         FnTJoYxQ8YlfIsPpyClRreTUdVdX0TFCSq7E3e5UFB8g3XfGe9HJXS8BLdLx0AaVPRiH
         wNuNdkbIcg+pqPdxDeM2lqkgQos50rsSqxrLxmicS/mP6CFPf5a8+9ymPxeHuU562ysN
         LprMVJ1ZgavRAfuUs8Her4AWmvSl1KQ64yL3BE5fdX2mGsp5ciqAS+uCvz5iYUU2fyrM
         jqLg==
X-Received: by 10.236.176.161 with SMTP id b21mr5870287yhm.12.1366243611387;
        Wed, 17 Apr 2013 17:06:51 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id z26sm13054639yhg.14.2013.04.17.17.06.49
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 17 Apr 2013 17:06:50 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.1.679.g509521a
In-Reply-To: <1366243524-18202-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221592>

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
