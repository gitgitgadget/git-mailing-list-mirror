From: Alberto <albcoron@gmail.com>
Subject: [PATCH] Replace memcpy with hashcpy when lengths defined
Date: Sun,  2 Mar 2014 13:19:37 -0600
Message-ID: <1393787977-13164-1-git-send-email-albcoron@gmail.com>
Cc: Alberto Corona <albcoron@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 02 20:20:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKBwF-0005T7-RV
	for gcvg-git-2@plane.gmane.org; Sun, 02 Mar 2014 20:20:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751660AbaCBTT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2014 14:19:58 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:64678 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751595AbaCBTT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2014 14:19:57 -0500
Received: by mail-ie0-f173.google.com with SMTP id rl12so2029128iec.18
        for <git@vger.kernel.org>; Sun, 02 Mar 2014 11:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=6XmKL6Nx4PSQC7BdOihhZ2E/SukdL+3KieNSJEvep6w=;
        b=oUU0jLcWPLALKTZGD2gES0HpyniNwg7bxUmwiMql4/Zs2bGeetR7swu4eYNvFLqEHZ
         XxQuEv8IVZyVI0thcdjAmY3QWPsSpzpOLA1RO2GH76pDYevbau61Q56E4Y4h4blVBMjT
         9zzWh5JlqLsiYmBPSQzn0Nuje3EmZlItzZBH/Qz7A6vXLCtglVbK3SbhzHrHGJl/RLeT
         yBDKpRZ17OQd3CpuLbR1+Oxg0kWvWsYzg9WM2HxzGvEPo+dL8JAPWpj/vQGn8jVZOT3S
         Tr/Q6yUeQPIN2N3olYMe3LiWNF2iYcQO0aQMad4pPGtkLWVmpIJBHUfN1WDrxG9E4dM0
         RvIA==
X-Received: by 10.50.43.135 with SMTP id w7mr17955277igl.12.1393787997325;
        Sun, 02 Mar 2014 11:19:57 -0800 (PST)
Received: from 0X1AB.localdomain.com (24-148-43-69.c3-0.grn-ubr1.chi-grn.il.cable.rcn.com. [24.148.43.69])
        by mx.google.com with ESMTPSA id bf7sm31216885igb.9.2014.03.02.11.19.55
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Mar 2014 11:19:56 -0800 (PST)
X-Mailer: git-send-email 1.9.0.138.g2de3478.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243156>

From: Alberto Corona <albcoron@gmail.com>

Replaced memcpy with hashcpy where lengts in memcpy
are already defined.

Signed-off-by: Alberto Corona <albcoron@gmail.com>
---
 bundle.c    | 2 +-
 grep.c      | 2 +-
 refs.c      | 2 +-
 sha1_name.c | 4 ++--
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/bundle.c b/bundle.c
index e99065c..7809fbb 100644
--- a/bundle.c
+++ b/bundle.c
@@ -19,7 +19,7 @@ static void add_to_ref_list(const unsigned char *sha1, const char *name,
 		list->list = xrealloc(list->list,
 				list->alloc * sizeof(list->list[0]));
 	}
-	memcpy(list->list[list->nr].sha1, sha1, 20);
+	hashcpy(list->list[list->nr].sha1, sha1);
 	list->list[list->nr].name = xstrdup(name);
 	list->nr++;
 }
diff --git a/grep.c b/grep.c
index c668034..f5101f7 100644
--- a/grep.c
+++ b/grep.c
@@ -1650,7 +1650,7 @@ void grep_source_init(struct grep_source *gs, enum grep_source_type type,
 		break;
 	case GREP_SOURCE_SHA1:
 		gs->identifier = xmalloc(20);
-		memcpy(gs->identifier, identifier, 20);
+		hashcpy(gs->identifier, identifier);
 		break;
 	case GREP_SOURCE_BUF:
 		gs->identifier = NULL;
diff --git a/refs.c b/refs.c
index 89228e2..f90b7ea 100644
--- a/refs.c
+++ b/refs.c
@@ -1222,7 +1222,7 @@ static int resolve_gitlink_packed_ref(struct ref_cache *refs,
 	if (ref == NULL)
 		return -1;
 
-	memcpy(sha1, ref->u.value.sha1, 20);
+	hashcpy(sha1, ref->u.value.sha1);
 	return 0;
 }
 
diff --git a/sha1_name.c b/sha1_name.c
index 6fca869..3f5010f 100644
--- a/sha1_name.c
+++ b/sha1_name.c
@@ -111,7 +111,7 @@ static void find_short_object_filename(int len, const char *hex_pfx, struct disa
 				continue;
 			if (memcmp(de->d_name, hex_pfx + 2, len - 2))
 				continue;
-			memcpy(hex + 2, de->d_name, 38);
+			hashcpy(hex + 2, de->d_name);
 			if (!get_sha1_hex(hex, sha1))
 				update_candidates(ds, sha1);
 		}
@@ -373,7 +373,7 @@ const char *find_unique_abbrev(const unsigned char *sha1, int len)
 	static char hex[41];
 
 	exists = has_sha1_file(sha1);
-	memcpy(hex, sha1_to_hex(sha1), 40);
+	hashcpy(hex, sha1_to_hex(sha1));
 	if (len == 40 || !len)
 		return hex;
 	while (len < 40) {
-- 
1.9.0.138.g2de3478.dirty
