From: John Keeping <john@keeping.me.uk>
Subject: [PATCH 2/2] bisect: avoid signed integer overflow
Date: Tue,  2 Apr 2013 20:50:32 +0100
Message-ID: <0cb4456948b0874a1cedc5679a7b23b82e755e94.1364931627.git.john@keeping.me.uk>
References: <cover.1364931627.git.john@keeping.me.uk>
Cc: Junio C Hamano <gitster@pobox.com>,
	John Keeping <john@keeping.me.uk>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 02 21:51:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN7Er-0005LW-MD
	for gcvg-git-2@plane.gmane.org; Tue, 02 Apr 2013 21:51:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760Ab3DBTuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Apr 2013 15:50:55 -0400
Received: from hyena.aluminati.org ([64.22.123.221]:57714 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932401Ab3DBTuz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Apr 2013 15:50:55 -0400
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id B71C222FB8;
	Tue,  2 Apr 2013 20:50:54 +0100 (BST)
X-Quarantine-ID: <H-V+IRydCbIh>
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Amavis-Alert: BAD HEADER SECTION, Duplicate header field: "References"
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H-V+IRydCbIh; Tue,  2 Apr 2013 20:50:54 +0100 (BST)
Received: from river.lan (tg1.aluminati.org [10.0.16.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hyena.aluminati.org (Postfix) with ESMTPSA id F0DE723099;
	Tue,  2 Apr 2013 20:50:48 +0100 (BST)
X-Mailer: git-send-email 1.8.2.540.gf023cfe
In-Reply-To: <cover.1364931627.git.john@keeping.me.uk>
In-Reply-To: <cover.1364931627.git.john@keeping.me.uk>
References: <cover.1364931627.git.john@keeping.me.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219869>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
 bisect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/bisect.c b/bisect.c
index bd1b7b5..0d33c6f 100644
--- a/bisect.c
+++ b/bisect.c
@@ -526,7 +526,7 @@ struct commit_list *filter_skipped(struct commit_list *list,
  * for this application.
  */
 static int get_prn(int count) {
-	count = count * 1103515245 + 12345;
+	count = ((unsigned) count) * 1103515245 + 12345;
 	return ((unsigned)(count/65536) % PRN_MODULO);
 }
 
-- 
1.8.2.540.gf023cfe
