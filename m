From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 15/18] rerere: further clarify do_rerere_one_path()
Date: Fri, 17 Jul 2015 15:24:37 -0700
Message-ID: <1437171880-21590-16-git-send-email-gitster@pobox.com>
References: <1435730699-9124-1-git-send-email-gitster@pobox.com>
 <1437171880-21590-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 18 00:25:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZGE4C-0004Fq-2y
	for gcvg-git-2@plane.gmane.org; Sat, 18 Jul 2015 00:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756210AbbGQWZK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2015 18:25:10 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:33690 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756189AbbGQWZG (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2015 18:25:06 -0400
Received: by padck2 with SMTP id ck2so67052952pad.0
        for <git@vger.kernel.org>; Fri, 17 Jul 2015 15:25:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:subject:date:message-id:in-reply-to:references;
        bh=8Azl03PC90OAeVyrHYggjqFCYZ1lIBAPs+8ax8N3GoM=;
        b=FhS1h+/bpED/lWw9xXd9D3adWUjYcV3hY1mjdCoWy1/H8epPz4NsEbiVUKdFXNQzcY
         /00ejoaMFdEjfDFM0Wfj/7ZT1CiXtzoK0dJXN8YsNsiPufRaGjZpD+qNei1ZhlB14god
         G+oqXbTyOc1LrJ9VrFJtxmdqReyV1Yxx8PB/0OevUjT6ySei+x98jviwgMXbARJOSraN
         841KoTCD+1lHvTx2pFqL8BRp4pVmk8Mk63Lla/E+dTDiN7jJbMNjzbBkX1QknJ28j4J+
         CdbxY/wxgYG0Ft/RuD/cpejBNFHv3yEDlK3Bekf0EIgZyiJ6amp1WE3VeuGbC4QtXv5V
         0v5A==
X-Received: by 10.70.134.163 with SMTP id pl3mr33309442pdb.142.1437171905693;
        Fri, 17 Jul 2015 15:25:05 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:902a:e9ec:1aae:aea2])
        by smtp.gmail.com with ESMTPSA id w13sm12318658pbt.45.2015.07.17.15.25.04
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 17 Jul 2015 15:25:05 -0700 (PDT)
X-Mailer: git-send-email 2.5.0-rc2-340-g0cccc16
In-Reply-To: <1437171880-21590-1-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274117>

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 rerere.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/rerere.c b/rerere.c
index 1089a9c..30bdfeb 100644
--- a/rerere.c
+++ b/rerere.c
@@ -644,16 +644,13 @@ static void do_rerere_one_path(struct string_list_item *rr_item,
 			fprintf(stderr,
 				"Resolved '%s' using previous resolution.\n",
 				path);
-		goto mark_resolved;
+	} else if (!handle_file(path, NULL, NULL)) {
+		/* The user has resolved it. */
+		copy_file(rerere_path(name, "postimage"), path, 0666);
+		fprintf(stderr, "Recorded resolution for '%s'.\n", path);
+	} else {
+		return;
 	}
-
-	/* Let's see if the user has resolved it. */
-	if (handle_file(path, NULL, NULL))
-		return; /* not yet resolved */
-
-	copy_file(rerere_path(name, "postimage"), path, 0666);
-	fprintf(stderr, "Recorded resolution for '%s'.\n", path);
-mark_resolved:
 	free(rr_item->util);
 	rr_item->util = NULL;
 }
-- 
2.5.0-rc2-340-g0cccc16
