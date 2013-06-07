From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] unpack-trees: improve maintainability
Date: Fri,  7 Jun 2013 17:23:07 -0500
Message-ID: <1370643787-3687-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 08 00:25:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ul55w-0001F4-JR
	for gcvg-git-2@plane.gmane.org; Sat, 08 Jun 2013 00:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756679Ab3FGWZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 18:25:07 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:65119 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756721Ab3FGWY6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 18:24:58 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so7286588obc.38
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 15:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=ygV1adm5icNbsPADc3QXpRn9UGswV7SvZYGuORRiZw4=;
        b=PwzKDqZ8bgOU9GX++jArBTB/3WSV6KpqJ60hf8JeVYvhPlBsHdqJgo056OMr7inK+k
         jI8tp0aYGfFUfZNE8KKARTuFrk7rJsxgk+OMtaT8lBiGLNqthgCd5/cK+EJK/eZHP8jp
         So068AkTn4ky1/V5PxBJDhTB1uNo5UXZj5oe9/ciVWk3kzJOcaghF3ZV319/owF/+ib0
         GanHUJCEO3hUwNhA5/44xHXL2a08yuXB1kkYh5VOER1ArDG8ZJpc5V0kwsTCBUW/I8fs
         RCtEVihX9SLJ47vKxYAcQ7arxi6Df2Xw0gt0tjU+ms3FeRxpyQtemxsD6lPay44AZ51D
         nOwA==
X-Received: by 10.182.102.234 with SMTP id fr10mr444954obb.85.1370643897494;
        Fri, 07 Jun 2013 15:24:57 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id kz3sm985208obb.6.2013.06.07.15.24.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 15:24:56 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.698.g079b096
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226754>

Clarify that ce can be NULL by adding a check (probably more efficient
also), and get rid of unnecessary indentation (since it's a single line
it doesn't matter, but in the future it might).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 unpack-trees.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 57b4074..9c0100d 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -605,8 +605,9 @@ static int unpack_nondirectories(int n, unsigned long mask,
 					o);
 		for (i = 0; i < n; i++) {
 			struct cache_entry *ce = src[i + o->merge];
-			if (ce != o->df_conflict_entry)
-				free(ce);
+			if (!ce || ce == o->df_conflict_entry)
+				continue;
+			free(ce);
 		}
 		return rc;
 	}
-- 
1.8.3.698.g079b096
