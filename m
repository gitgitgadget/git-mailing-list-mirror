From: Stefan Beller <sbeller@google.com>
Subject: [RFC_PATCHv4 3/7] submodule-config: add method to check for being labeled
Date: Mon, 21 Mar 2016 19:06:08 -0700
Message-ID: <1458612372-10966-4-git-send-email-sbeller@google.com>
References: <1458612372-10966-1-git-send-email-sbeller@google.com>
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jens.Lehmann@web.de, sschuberth@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 22 03:06:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aiBiO-0000gs-S3
	for gcvg-git-2@plane.gmane.org; Tue, 22 Mar 2016 03:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758217AbcCVCGa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 22:06:30 -0400
Received: from mail-pf0-f170.google.com ([209.85.192.170]:36131 "EHLO
	mail-pf0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758162AbcCVCG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 22:06:28 -0400
Received: by mail-pf0-f170.google.com with SMTP id u190so288904205pfb.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 19:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8+uKQ8VBU6W8d7aNzONe3rBQ5l2EIN/ZhUmofbJ5xBM=;
        b=JX5M/gY6dhbNJoRfbhF88o4zPAkNWi4boTplBzTZf5l51SPZLzO/T9nxvw2ZihLzrV
         MLCwfxBTXcrSTzgwClZ2h0qLENxTdncS4mY+Nt5p3CoO0FmXy61geh1umJ1iknRqJPTy
         qBBz1+hMvSWDQiO8X6DAn0W3G9CRGSidTr7z51FE2roXZ+oUu7CGF3LBCD4f3EsCu5bS
         gLF73mIuzb7SrL3cP+U4PoEKqS+N3wiOGeIa74jcKFjBEZiytra6lL8+32Gamlq5TwDI
         Z/L9NgvYMr8Q9wSJ4tdQnMI0ESGJOYbqiq2dk/m88Wyna8+OhttRQ5oG5gLzOzAtdb3T
         bDHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8+uKQ8VBU6W8d7aNzONe3rBQ5l2EIN/ZhUmofbJ5xBM=;
        b=JhF0MrH5QDqzhwjSX8IobOJ1RbuSwZY0yWseos74mPCEFqrBzInrj13hCFtKRhbxG7
         oyMpR66V5l8FGLISTyalX5IZMjpGCEnZYEWi91KAiRIal2b3jvH2A/30smU8N68iXG4E
         R5+wC8LhFbfpS3gQKD2fSE3I+7VC/TP3i4WUuJ+bqfCySrHyOuSZfTjGGJrBggjzZm5v
         QNZEbLNlJ3aWtMjXqiZPVRWhcY0TShy8qKahuhW5S5ttL+4YIJvkevWDmUrlR5fUM2/c
         1dZ+52u39Xecr/A7HCFS60sa0OPkRq5d3r7zUrG34POsjc2IWVop/XbcuXCBreHjAk7C
         2Dig==
X-Gm-Message-State: AD7BkJLqr28l9gUdHjlZtEdGYTut+A7HXwRYYpn5m+hDRk6SZPkpT1dfKbFBO0ouU14xkVwp
X-Received: by 10.98.7.153 with SMTP id 25mr50511668pfh.38.1458612387572;
        Mon, 21 Mar 2016 19:06:27 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:f1b0:8994:3428:87f7])
        by smtp.gmail.com with ESMTPSA id o185sm43628999pfo.36.2016.03.21.19.06.26
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 21 Mar 2016 19:06:26 -0700 (PDT)
X-Mailer: git-send-email 2.7.0.rc0.45.g6b4c145
In-Reply-To: <1458612372-10966-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289481>

In later patches we need to tell if a submodule is labeled by
the given labels.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 submodule-config.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 submodule-config.h |  3 +++
 2 files changed, 51 insertions(+)

diff --git a/submodule-config.c b/submodule-config.c
index 7b48e59..b10a773 100644
--- a/submodule-config.c
+++ b/submodule-config.c
@@ -493,3 +493,51 @@ void submodule_free(void)
 	cache_free(&cache);
 	is_cache_init = 0;
 }
+
+int submodule_applicable_by_labels(const struct string_list *list,
+				   const struct submodule *sub)
+{
+	int label_apply = 0;
+	struct strbuf sb = STRBUF_INIT;
+
+	if (!list)
+		return 1;
+
+	if (sub->labels) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, sub->labels) {
+			strbuf_reset(&sb);
+			strbuf_addf(&sb, "*%s", item->string);
+			if (string_list_has_string(list, sb.buf)) {
+				label_apply = 1;
+				break;
+			}
+		}
+	}
+	if (sub->path) {
+		/*
+		 * NEEDSWORK: This currently works only for
+		 * exact paths, but we want to enable
+		 * inexact matches such wildcards.
+		 */
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, "./%s", sub->path);
+		if (string_list_has_string(list, sb.buf)) {
+			label_apply = 1;
+		}
+	}
+	if (sub->name) {
+		/*
+		 * NEEDSWORK: Same as with path. Do we want to
+		 * support wildcards or such?
+		 */
+		strbuf_reset(&sb);
+		strbuf_addf(&sb, ":%s", sub->name);
+		if (string_list_has_string(list, sb.buf)) {
+			label_apply = 1;
+		}
+	}
+	strbuf_release(&sb);
+
+	return label_apply;
+}
diff --git a/submodule-config.h b/submodule-config.h
index 8d61df3..d67f666 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -30,4 +30,7 @@ const struct submodule *submodule_from_path(const unsigned char *commit_sha1,
 		const char *path);
 void submodule_free(void);
 
+int submodule_applicable_by_labels(const struct string_list *list,
+				   const struct submodule *sub);
+
 #endif /* SUBMODULE_CONFIG_H */
-- 
2.7.0.rc0.45.g6b4c145
