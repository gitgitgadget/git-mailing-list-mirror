Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D511E1E04
	for <git@vger.kernel.org>; Thu, 22 May 2025 18:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747940177; cv=none; b=Rulz6CbwrOOqF6QtwqJB8PocDIUIvWxhNkKxCjqxLn2MpmpEVg9x8cJ5ZeXq7qr3MdSYP2t9fckJUPCKQOnXkKc+PoCkkkuQI8oU0UPljsIGxxJQd4mIEDdnVGkzx18bhNH6oym1Ef8E8MgYIviN95qB+/BUc+5KXjatCapgTBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747940177; c=relaxed/simple;
	bh=mm/CXiPL24fxrNwax6IM2yAhBOo1yCVajV1srcCb/H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p2DRM4hUMetLwCFy9rfucV6JSC0D6kZGm2T1/EvKQUsGzKwuqz8h1zc3PJAbbo5AnlbXrUE70WD4M87WGsQtQWPg4ugugxP8KSYDjnmqB/4wFa61JwnVlujjwmeTfcoKBLNRbzQkvT+hpaS70BWsOlF2GocRNsRHTcXNxjbbrYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=O+/ClFPk; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="O+/ClFPk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1747940174;
	bh=mm/CXiPL24fxrNwax6IM2yAhBOo1yCVajV1srcCb/H4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From:Reply-To:
	 Subject:Date:To:CC:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	 In-Reply-To:References:Content-Type:Content-Disposition;
	b=O+/ClFPkhP+NLbJplcWZY3I+NliZ+stKqwaGIO8hBES0/UE9yP025QnvVELV1S79X
	 Mihe0pBy4udxO5h5TonFTyfAA9AozPJHb94XeeelTiB5cri9cKBDiYnC3eoJtScdo/
	 veHBpFGw8BU2apW/RpwgpW5hlcGEK/nzpi7q8b5b3sTSg9KZyyHe2zmHlxAUmzZC+8
	 gJN02wxmV+Tl7r8RrpExxtOV/86ckL5qjbATJ/eBKUl+LPmYRADJ+AwM4vJwWUGHzO
	 oY0lLb2ng003DenfFvRCwiefWbRThdkxyvTJVtY0d83AmurTTEybG66+6nuDbiauab
	 WdLVPKp9GN9cHaTdpv0LzmZynnVvSBS5OKQOEnWUxOYJCPc4x/kwcYYds/63Ehcqfm
	 FPy9mKzXR7cg43UmAjZGP5w8nNYdV2+4SxflSM/2nSsIhyF3VihEb2iqOXjad2TbiJ
	 Jmy28kOyccgOkud2FL/RnHeujfl8s/ASiuObl3G8qgI8rtVaUT9
Received: from tapette.. (unknown [104.129.158.231])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id B4D7C2018E;
	Thu, 22 May 2025 18:56:14 +0000 (UTC)
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: <git@vger.kernel.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	pwodd,
	"D. Ben Knoble" <ben.knoble@gmail.com>
Subject: [PATCH v6 2/5] reflog-walk: expose read_complete_reflog
Date: Thu, 22 May 2025 18:55:21 +0000
Message-ID: <20250522185524.18398-4-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.49.0.395.g12beb8f557c
In-Reply-To: <20250522185524.18398-1-sandals@crustytoothpaste.net>
References: <20250508234458.3665894-1-sandals@crustytoothpaste.net>
 <20250522185524.18398-1-sandals@crustytoothpaste.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In a future commit, we'll use this function and the corresponding free
function to read the entire reflog.  Expose it in the header so we can
do so.

Include the appropriate header files so that our header is complete.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 reflog-walk.c | 17 ++---------------
 reflog-walk.h | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/reflog-walk.c b/reflog-walk.c
index c7070b13b0..b7a9d70966 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -9,19 +9,6 @@
 #include "string-list.h"
 #include "reflog-walk.h"
 
-struct complete_reflogs {
-	char *ref;
-	char *short_ref;
-	struct reflog_info {
-		struct object_id ooid, noid;
-		char *email;
-		timestamp_t timestamp;
-		int tz;
-		char *message;
-	} *items;
-	int nr, alloc;
-};
-
 static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
 		const char *email, timestamp_t timestamp, int tz,
 		const char *message, void *cb_data)
@@ -41,7 +28,7 @@ static int read_one_reflog(struct object_id *ooid, struct object_id *noid,
 	return 0;
 }
 
-static void free_complete_reflog(struct complete_reflogs *array)
+void free_complete_reflog(struct complete_reflogs *array)
 {
 	int i;
 
@@ -64,7 +51,7 @@ static void complete_reflogs_clear(void *util, const char *str UNUSED)
 	free_complete_reflog(array);
 }
 
-static struct complete_reflogs *read_complete_reflog(const char *ref)
+struct complete_reflogs *read_complete_reflog(const char *ref)
 {
 	struct complete_reflogs *reflogs =
 		xcalloc(1, sizeof(struct complete_reflogs));
diff --git a/reflog-walk.h b/reflog-walk.h
index 989583dc55..8f0640f662 100644
--- a/reflog-walk.h
+++ b/reflog-walk.h
@@ -1,9 +1,24 @@
 #ifndef REFLOG_WALK_H
 #define REFLOG_WALK_H
 
+#include "git-compat-util.h"
+#include "hash.h"
+
 struct commit;
 struct reflog_walk_info;
 struct date_mode;
+struct complete_reflogs {
+	char *ref;
+	char *short_ref;
+	struct reflog_info {
+		struct object_id ooid, noid;
+		char *email;
+		timestamp_t timestamp;
+		int tz;
+		char *message;
+	} *items;
+	int nr, alloc;
+};
 
 void init_reflog_walk(struct reflog_walk_info **info);
 void reflog_walk_info_release(struct reflog_walk_info *info);
@@ -24,4 +39,7 @@ int reflog_walk_empty(struct reflog_walk_info *walk);
 
 struct commit *next_reflog_entry(struct reflog_walk_info *reflog_info);
 
+void free_complete_reflog(struct complete_reflogs *array);
+struct complete_reflogs *read_complete_reflog(const char *ref);
+
 #endif
