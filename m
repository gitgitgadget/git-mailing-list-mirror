From: Tay Ray Chuan <rctay89@gmail.com>
Subject: [PATCH 4/7] http-walker: cleanup more thoroughly
Date: Sun, 21 Feb 2010 11:08:25 +0800
Message-ID: <1266721708-1060-5-git-send-email-rctay89@gmail.com>
References: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Cc: "Clemens Buchacher" <drizzd@aon.at>,
	"Mike Hommey" <mh@glandium.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Feb 21 04:38:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nj2Bs-0004jO-Et
	for gcvg-git-2@lo.gmane.org; Sun, 21 Feb 2010 04:09:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757147Ab0BUDIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Feb 2010 22:08:54 -0500
Received: from mail-qy0-f179.google.com ([209.85.221.179]:48037 "EHLO
	mail-qy0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757116Ab0BUDIv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Feb 2010 22:08:51 -0500
Received: by mail-qy0-f179.google.com with SMTP id 9so352982qyk.21
        for <git@vger.kernel.org>; Sat, 20 Feb 2010 19:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KhGtEL9kDrT+TLx5GCn1Y11lr3R7lUq+To93oAtQD8A=;
        b=Ml3ijbgdv6Sg05MZ0fKPM3XNnyc050nyIHZFFK/rNcKdg4CeHSP9uNcrSEXp3Acwkt
         2g3d8ZcZYaPWP2sadHqEwFH1Vfxnc5KasMyE68Vl7ZdcTCWHxEeqATj03ay232oJDEJ8
         ymbssyBttxuBymfc4ZY4pZ9n7fPDD4zWLAE90=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=uGozs24oYpr5tJKVaOwWZ6lTWQMcyALWdgdhOMZT3vBQK87hzqKO2ZBClMzvLo4C99
         wRosYas8fn2EJIS1xiW0CRzUTu6O2cfs2NdOL2U46/D+iaQOuGHVyX43mJM6P8WDEOB6
         PdQjIVTuRT+i1dTPvt98nAL9WHayxOkhbxogY=
Received: by 10.224.88.83 with SMTP id z19mr4773106qal.88.1266721730860;
        Sat, 20 Feb 2010 19:08:50 -0800 (PST)
Received: from localhost.localdomain (cm91.zeta153.maxonline.com.sg [116.87.153.91])
        by mx.google.com with ESMTPS id 22sm1412717qyk.14.2010.02.20.19.08.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 20 Feb 2010 19:08:50 -0800 (PST)
X-Mailer: git-send-email 1.7.0.20.gcb44ed
In-Reply-To: <1266721708-1060-1-git-send-email-rctay89@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140584>

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
