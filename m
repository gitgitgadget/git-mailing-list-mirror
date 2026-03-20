Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 055133AA4EC
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007600; cv=pass; b=LvPBPrwncBeHn7E/WtZMC962dZlcVqw6eZErsQLna+7cGDWaq/NupIAKTDUVn19pZLznG/uujG6pl1q/wR+Qa1J7m0VKVJWKqOc059v3L7f81yByEiqRgFXxcMQPiIFJkfOpQLlTh289FAuVVnrPmQArxmd2KIaMvoI4hp9sj/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007600; c=relaxed/simple;
	bh=ZtTaDVFjpF5Zrfj3bhE6cQQVVs5dodJ2syAVJoNZ1Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V9UirP3CT5Dh2m1VkF9uOG4ocRTNcB7nWPxa6tSRKx2R20R47DYUZm9RjXgea0SjDySSQt1anWbrha3oN1QHgbFvvBRLTUiB9a4VKSs63QMrXSr52ySSre7RVrunNpN2qh1v8OKL9gBagiYqrbg9l1TMcpYbSWzJ9oB+FwqjG7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=T7oWeW1p; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="T7oWeW1p"
ARC-Seal: i=1; a=rsa-sha256; t=1774007586; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=JyWKTaRrAf59YErqMBXvKm+7L0rnkUBZwtlnnVZqJrpcunEDf9kxEBbRoP78b/aaAu+au0Zc20akxlhuYpu5vYTaNWVzj6pZpI1th7RBsdgWO4ew4l6p1p51lsDDgpdSYyZLDfCPpRqTI5rUuujA4RLuQ9X6p2e4hda4exLdHa4=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007586; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=URXLBhgO0ywkOVWPzOLwgcVWKuFjm+p1b74rktr7dd4=; 
	b=X5eBuOZbuQ2SqoeP/38V9MawK/9q+nP9FxC6IbiGe9Ysg7GrCRg6IKgv8HeTsqa+HEBeQTCxY61WVElXyh5sVd81uWtHKMQIIzkCWAbBJNhTY56L1c6xrEO78qnttM6+cbw27YZtf0kpE9myeoalJuzoszRmD/Nn8H+Iihby46Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007586;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=URXLBhgO0ywkOVWPzOLwgcVWKuFjm+p1b74rktr7dd4=;
	b=T7oWeW1pJ6KELL2mdJCN3GhP5UGo9Bxmr4zK+HzVpGTTnwOvtLmd7vSbfR24/4hs
	Y14nN3AhosClcrVrJvgpR51adfSfryCF1uyaLEiQ7X0NugBc+vuThDFPDuED+2aSlug
	XBzd+8FZOOJ/r3EIkalE05F/DZvLaFh5iuPjKrkY=
Received: by mx.zohomail.com with SMTPS id 1774007584489455.9297620316754;
	Fri, 20 Mar 2026 04:53:04 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 08/10] hook: introduce hook_config_cache_entry for per-hook data
Date: Fri, 20 Mar 2026 13:52:09 +0200
Message-ID: <20260320115211.177351-9-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260320115211.177351-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260320115211.177351-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replace the bare `char *command` util pointer stored in each string_list
item with a heap-allocated `struct hook_config_cache_entry` that carries
that command string.

This is just a refactoring with no behavior changes, to give the cache
entry room to grow, so it can carry the additional hook metadata we'll
be adding in the following commits.

Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 28 ++++++++++++++++++++++------
 1 file changed, 22 insertions(+), 6 deletions(-)

diff --git a/hook.c b/hook.c
index 7f89ae9cc2..49f1ebe17a 100644
--- a/hook.c
+++ b/hook.c
@@ -112,6 +112,15 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	string_list_append(hook_list, hook_path)->util = h;
 }
 
+/*
+ * Cache entry stored as the .util pointer of string_list items inside the
+ * hook config cache. For now carries only the command for the hook. Next
+ * commits will add more data.
+ */
+struct hook_config_cache_entry {
+	char *command;
+};
+
 /*
  * Callback struct to collect all hook.* keys in a single config pass.
  * commands: friendly-name to command map.
@@ -206,7 +215,12 @@ void hook_cache_clear(struct strmap *cache)
 
 	strmap_for_each_entry(cache, &iter, e) {
 		struct string_list *hooks = e->value;
-		string_list_clear(hooks, 1); /* free util (command) pointers */
+		for (size_t i = 0; i < hooks->nr; i++) {
+			struct hook_config_cache_entry *entry = hooks->items[i].util;
+			free(entry->command);
+			free(entry);
+		}
+		string_list_clear(hooks, 0);
 		free(hooks);
 	}
 	strmap_clear(cache, 0);
@@ -236,6 +250,7 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 
 		for (size_t i = 0; i < hook_names->nr; i++) {
 			const char *hname = hook_names->items[i].string;
+			struct hook_config_cache_entry *entry;
 			char *command;
 
 			/* filter out disabled hooks */
@@ -249,9 +264,10 @@ static void build_hook_config_map(struct repository *r, struct strmap *cache)
 				      "'hook.%s.event' must be removed;"
 				      " aborting."), hname, hname);
 
-			/* util stores the command; owned by the cache. */
-			string_list_append(hooks, hname)->util =
-				xstrdup(command);
+			/* util stores a cache entry; owned by the cache. */
+			CALLOC_ARRAY(entry, 1);
+			entry->command = xstrdup(command);
+			string_list_append(hooks, hname)->util = entry;
 		}
 
 		strmap_put(cache, e->key, hooks);
@@ -313,7 +329,7 @@ static void list_hooks_add_configured(struct repository *r,
 	/* Iterate through configured hooks and initialize internal states */
 	for (size_t i = 0; configured_hooks && i < configured_hooks->nr; i++) {
 		const char *friendly_name = configured_hooks->items[i].string;
-		const char *command = configured_hooks->items[i].util;
+		struct hook_config_cache_entry *entry = configured_hooks->items[i].util;
 		struct hook *hook;
 		CALLOC_ARRAY(hook, 1);
 
@@ -330,7 +346,7 @@ static void list_hooks_add_configured(struct repository *r,
 
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
-		hook->u.configured.command = xstrdup(command);
+		hook->u.configured.command = xstrdup(entry->command);
 
 		string_list_append(list, friendly_name)->util = hook;
 	}
-- 
2.52.0.732.gb351b5166d.dirty

