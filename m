From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 01/11] dir: free untracked cache when removing it
Date: Wed, 23 Dec 2015 22:03:49 +0100
Message-ID: <1450904639-25592-2-git-send-email-chriscool@tuxfamily.org>
References: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Dec 23 22:04:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBqaE-00085q-B6
	for gcvg-git-2@plane.gmane.org; Wed, 23 Dec 2015 22:04:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965333AbbLWVEY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Dec 2015 16:04:24 -0500
Received: from mail-wm0-f43.google.com ([74.125.82.43]:33507 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965277AbbLWVEW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Dec 2015 16:04:22 -0500
Received: by mail-wm0-f43.google.com with SMTP id p187so158630220wmp.0
        for <git@vger.kernel.org>; Wed, 23 Dec 2015 13:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qcB63TgDIA9QNt9a9p1hqLJLi5qfT+Wp8iPjdcTKD5U=;
        b=RVe30qq0oof0Ajytsin4k3rjW6bImSjSuC4S6yXyMtjhowAVeU0tuoiD5+xEeP9VBn
         jxCatW6cbaQnb3USDlS14AQUejeqbRX/Y14MdrF/Etg0YJlz98bVMOZ29vBDke7vUHth
         O13tG5w8euMuK6E3htDU3jGgWNTQJ4MkaybRkW9fq56ewCfjscKdLu/yeLAwAuA2K8O9
         u+LG/knvU9Bu7I1naHpOlTCr2dUcqUG+0ohCYq6A7RYP3KR0S/pdyHi9vqwSSBhOOIcO
         dXYhnRZaRneviDgcSXUA2zjoTdzO7w/Nfz1k4MfApnMS57hfGxaIzV5K543ULyNiWPAo
         tNdA==
X-Received: by 10.194.78.239 with SMTP id e15mr31426797wjx.26.1450904661767;
        Wed, 23 Dec 2015 13:04:21 -0800 (PST)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id w80sm9434692wme.17.2015.12.23.13.04.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 23 Dec 2015 13:04:20 -0800 (PST)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.7.0.rc2.11.g68ccdd4
In-Reply-To: <1450904639-25592-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282956>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 builtin/update-index.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/update-index.c b/builtin/update-index.c
index 7431938..a6fff87 100644
--- a/builtin/update-index.c
+++ b/builtin/update-index.c
@@ -1123,6 +1123,7 @@ int cmd_update_index(int argc, const char **argv, const char *prefix)
 		add_untracked_ident(the_index.untracked);
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	} else if (!untracked_cache && the_index.untracked) {
+		free_untracked_cache(the_index.untracked);
 		the_index.untracked = NULL;
 		the_index.cache_changed |= UNTRACKED_CHANGED;
 	}
-- 
2.7.0.rc2.11.g68ccdd4
