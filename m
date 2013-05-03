From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH 3/4] fast-export: don't parse all the commits
Date: Thu,  2 May 2013 23:31:41 -0500
Message-ID: <1367555502-4706-4-git-send-email-felipe.contreras@gmail.com>
References: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 03 06:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UY7gW-0004tz-9x
	for gcvg-git-2@plane.gmane.org; Fri, 03 May 2013 06:33:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753569Ab3ECEdQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 00:33:16 -0400
Received: from mail-ye0-f170.google.com ([209.85.213.170]:43177 "EHLO
	mail-ye0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753525Ab3ECEdN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 00:33:13 -0400
Received: by mail-ye0-f170.google.com with SMTP id m4so222018yen.15
        for <git@vger.kernel.org>; Thu, 02 May 2013 21:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=Q0cIpvmsYc9PIPU6Z4eq09s8X2TtLzLyyLcbf/2lGOY=;
        b=hvYc1wYy63AX0whb3HMwEF3SZN5r5uLkgbSnoy1XXpJCfE+BD+TdL7iMLRyzbl0w/J
         H+Dzj4eE1sZFc2VmedPCEaHJD2b9SMX8cU3xOCL0u1LQZbp+eNyUPZ+vMe7uFw69NyIg
         R7eWki5pF9i2iYVVsfBVDtcoKzd8E1PDbKroYE7UYvilELnFsfFOL/SErfQTHBYwbzfU
         7B9btZlRDbWWNVpkMvrWsg4oVWLHGHEakvvCox7GtlyxsemvkiROb2P2yEMhoUpdnJzv
         VPlPFNR6LEIct3apIgRSb5C23TqCH52VRwCwII0KYjfy6/NfXkuQR08Li5twfOWG1ZCz
         xung==
X-Received: by 10.236.126.179 with SMTP id b39mr7608154yhi.94.1367555592793;
        Thu, 02 May 2013 21:33:12 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i21sm18201158yhl.15.2013.05.02.21.33.10
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 02 May 2013 21:33:11 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
In-Reply-To: <1367555502-4706-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223278>

We don't need the parsed objects at this point, merely the information
that they have marks.

Seems to be three times faster in my setup with lots of objects.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/fast-export.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index a5b8da8..3c5a701 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -636,7 +636,7 @@ static void import_marks(char *input_file)
 			/* only commits */
 			continue;
 
-		object = parse_object(sha1);
+		object = lookup_unknown_object(sha1);
 
 		if (object->flags & SHOWN)
 			error("Object %s already has a mark", sha1_to_hex(sha1));
-- 
1.8.3.rc0.401.g45bba44
