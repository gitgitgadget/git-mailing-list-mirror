From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH v2 4/7] http-walker: cleanup more thoroughly
Date: Tue,  2 Mar 2010 18:49:28 +0800
Message-ID: <1267526971-5552-5-git-send-email-rctay89@gmail.com>
References: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 02 11:50:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NmPg7-0003k4-2T
	for gcvg-git-2@lo.gmane.org; Tue, 02 Mar 2010 11:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752650Ab0CBKt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Mar 2010 05:49:59 -0500
Received: from mail-gx0-f227.google.com ([209.85.217.227]:40884 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752629Ab0CBKt4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Mar 2010 05:49:56 -0500
Received: by gxk27 with SMTP id 27so49434gxk.1
        for <git@vger.kernel.org>; Tue, 02 Mar 2010 02:49:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KhGtEL9kDrT+TLx5GCn1Y11lr3R7lUq+To93oAtQD8A=;
        b=DFhEWT4lf683tEiOt0F1jU9VgywMiPHWSuajXHk9gcTzuGREYLp3IMVChK3Y6xX3kW
         DimX0Vqo1XP7Vc+yxsfCafShDNvL5N1TAkPu04KP6PH2jVHNYJ7mxetWRefqynZ8knv3
         Cxlif3HnC7KB94d7gR7ADhWRnoTwhaeCXNYvo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=KxUzLK5RNwNyejit4UyYwJAxpUjMfX0BsMUGeCousBvwTMRHrbS0acpUU/7Otpo3Y6
         OhkznuIsskVAC/ysz4oDi8E9aQ7P9fFf12vtRWG80YC0C/GMLpXjh2bCbrkQ9+8NysY+
         kAuYCOcJMSvtlB9aYtZA8AQV+edEEtvkTvlTA=
Received: by 10.101.105.14 with SMTP id h14mr344589anm.65.1267526995441;
        Tue, 02 Mar 2010 02:49:55 -0800 (PST)
Received: from localhost.localdomain (cm212.zeta152.maxonline.com.sg [116.87.152.212])
        by mx.google.com with ESMTPS id 13sm2393991gxk.12.2010.03.02.02.49.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 02 Mar 2010 02:49:55 -0800 (PST)
X-Mailer: git-send-email 1.7.0.1.241.g6604f
In-Reply-To: <1267526971-5552-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/141381>

Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
---
 http-walker.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/http-walker.c b/http-walker.c
index 700bc13..508e355 100644
--- a/http-walker.c
+++ b/http-walker.c
@@ -543,6 +543,23 @@ static int fetch_ref(struct walker *walker, struct ref *ref)
 
 static void cleanup(struct walker *walker)
 {
+	struct walker_data *data = walker->data;
+	struct alt_base *alt, *alt_next;
+
+	if (data) {
+		alt = data->alt;
+		while (alt) {
+			alt_next = alt->next;
+
+			free(alt->base);
+			free(alt);
+
+			alt = alt_next;
+		}
+		free(data);
+		walker->data = NULL;
+	}
+
 	http_cleanup();
 }
 
-- 
1.7.0.26.gbfa16
