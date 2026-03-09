Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5382922D4DC
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 00:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773017700; cv=pass; b=TPjotp8CJfhy6M5+r/rL8jzeNu1UUqzwe9iSR1/9yJH05j/FhjqnQZUJKs20pY9T6WgST7f4PDibgNK0zD/yDeqAcMJWZT98fjXb/7bd3BM4bbTtgIcxUB8JheWk/HXAzsVVBa1zWl0saDHF66gQU54IhHCYctoJJT+hGD7H+80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773017700; c=relaxed/simple;
	bh=RIbNhVVzUJhLVKn9o+hCt+t4CZbZzlqSXBRY7dKNehQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=srUaFdn5gcn7sgiEe4ys8mq7Xysj+U6CC23ctjcz+P8yyxWMik+GyrDXVh+h8kDqfi5M0nUTgnjhIkvkHlgGbKnh3kWId3hpPLF3z0DXhD9gNgHx0sNDGXyloc41/i2tH+TGy9TRodNQKpJnnG9oQeMghJTkmosJ/ujIXFzRV08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Q8hQ2yfT; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Q8hQ2yfT"
ARC-Seal: i=1; a=rsa-sha256; t=1773017687; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=awPc0ncqomHJsuiSpIM2GBrNvQrFa/g2weWLxk48+CQ+3T0kgI8TUf7HeMaFNUN91Ge0x+SG3OKXwhihXdj4j4HIez7nbg6PtUjROcRPCvD27SHFsxyg0EJ+c0nkSesoMliPtgL6XveV/W6bVQg8tdyjrjQLPi7GQ/aKx66AyBo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1773017687; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ufDO0g5aamT6bJIoYgq7dtf2t19e0p8ciYWwltd25Q4=; 
	b=DUhrCo4Bh/qEPqcTffCAEuxOEswPvULv0HTzR2x71fYOj53JRmx2oxfO1vHdKw9eGbIvs0RvOh7uotctRPifpJLQCiaY64G6Y2GkzzlsdaQjaq31ateApdcbqA45NG7KrsxrHqUYkmmR3PeXmN27JxY8Xlkxr+6pkNeSPJqdJmA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773017687;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ufDO0g5aamT6bJIoYgq7dtf2t19e0p8ciYWwltd25Q4=;
	b=Q8hQ2yfTV/o2Btb2w7P71mpLRDPtD9Sri6/6F7PWQHUqhV2p7QQVznIT9Wgt/7xU
	prVhQ2F7o5TshYEfT30hQmHosm+vtsbYIFVYeFUm/HEmuF+YijZc+ljqYNka8xiTiqx
	+5YAxd9qLyrT4RlQpKxG73lUCGT0Iqz0pO7rGzmo=
Received: by mx.zohomail.com with SMTPS id 1773017684875485.2240016321201;
	Sun, 8 Mar 2026 17:54:44 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH 05/10] hook: replace hook_list_clear() -> string_list_clear_func()
Date: Mon,  9 Mar 2026 02:54:11 +0200
Message-ID: <20260309005416.2760030-6-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Replace the custom function with string_list_clear_func() which
is a more common pattern for clearing a string_list.

To be able to do this, rework hook_clear() into hook_free(), so
it can be passed to string_list_clear_func().

A slight complication is the need to keep a copy of the internal
cb data free() pointer, however I think it's worth it since the
API becomes cleaner, e.g. no more calls with NULL function args
like hook_list_clear(hooks, NULL).

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c |  2 +-
 hook.c         | 50 +++++++++++++++++++++++++++++---------------------
 hook.h         | 20 ++++++++++++++------
 3 files changed, 44 insertions(+), 28 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index c622a7399c..8fc647a4de 100644
--- a/builtin/hook.c
+++ b/builtin/hook.c
@@ -78,7 +78,7 @@ static int list(int argc, const char **argv, const char *prefix,
 	}
 
 cleanup:
-	hook_list_clear(head, NULL);
+	string_list_clear_func(head, hook_free);
 	free(head);
 	return ret;
 }
diff --git a/hook.c b/hook.c
index b8ed4d79e2..f6bb1999ae 100644
--- a/hook.c
+++ b/hook.c
@@ -52,8 +52,14 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
-static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
+/*
+ * Frees a struct hook stored as the util pointer of a string_list_item.
+ * Suitable for use as a string_list_clear_func_t callback.
+ */
+void hook_free(void *p, const char *str UNUSED)
 {
+	struct hook *h = p;
+
 	if (!h)
 		return;
 
@@ -64,22 +70,12 @@ static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
 		free((void *)h->u.configured.command);
 	}
 
-	if (cb_data_free)
-		cb_data_free(h->feed_pipe_cb_data);
+	if (h->data_free && h->feed_pipe_cb_data)
+		h->data_free(h->feed_pipe_cb_data);
 
 	free(h);
 }
 
-void hook_list_clear(struct string_list *hooks, hook_data_free_fn cb_data_free)
-{
-	struct string_list_item *item;
-
-	for_each_string_list_item(item, hooks)
-		hook_clear(item->util, cb_data_free);
-
-	string_list_clear(hooks, 0);
-}
-
 /* Helper to detect and add default "traditional" hooks from the hookdir. */
 static void list_hooks_add_default(struct repository *r, const char *hookname,
 				   struct string_list *hook_list,
@@ -100,9 +96,15 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
 	if (options && options->dir)
 		hook_path = absolute_path(hook_path);
 
-	/* Setup per-hook internal state cb data */
-	if (options && options->feed_pipe_cb_data_alloc)
+	/*
+	 * Setup per-hook internal state callback data.
+	 * When provided, the alloc/free callbacks are always provided
+	 * together, so use them to alloc/free the internal hook state.
+	 */
+	if (options && options->feed_pipe_cb_data_alloc) {
 		h->feed_pipe_cb_data = options->feed_pipe_cb_data_alloc(options->feed_pipe_ctx);
+		h->data_free = options->feed_pipe_cb_data_free;
+	}
 
 	h->kind = HOOK_TRADITIONAL;
 	h->u.traditional.path = xstrdup(hook_path);
@@ -148,7 +150,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			struct strmap_entry *e;
 
 			strmap_for_each_entry(&data->event_hooks, &iter, e)
-				unsorted_string_list_remove(e->value, hook_name);
+				unsorted_string_list_remove(e->value, hook_name, 0);
 		} else {
 			struct string_list *hooks =
 				strmap_get(&data->event_hooks, value);
@@ -160,7 +162,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			}
 
 			/* Re-insert if necessary to preserve last-seen order. */
-			unsorted_string_list_remove(hooks, hook_name);
+			unsorted_string_list_remove(hooks, hook_name, 0);
 			string_list_append(hooks, hook_name);
 		}
 	} else if (!strcmp(subkey, "command")) {
@@ -178,7 +180,7 @@ static int hook_config_lookup_all(const char *key, const char *value,
 			break;
 		case 1: /* enabled: undo a prior disabled entry */
 			unsorted_string_list_remove(&data->disabled_hooks,
-						    hook_name);
+						    hook_name, 0);
 			break;
 		default:
 			break; /* ignore unrecognised values */
@@ -315,10 +317,16 @@ static void list_hooks_add_configured(struct repository *r,
 		struct hook *hook;
 		CALLOC_ARRAY(hook, 1);
 
-		if (options && options->feed_pipe_cb_data_alloc)
+		/*
+		 * When provided, the alloc/free callbacks are always provided
+		 * together, so use them to alloc/free the internal hook state.
+		 */
+		if (options && options->feed_pipe_cb_data_alloc) {
 			hook->feed_pipe_cb_data =
 				options->feed_pipe_cb_data_alloc(
 					options->feed_pipe_ctx);
+			hook->data_free = options->feed_pipe_cb_data_free;
+		}
 
 		hook->kind = HOOK_CONFIGURED;
 		hook->u.configured.friendly_name = xstrdup(friendly_name);
@@ -361,7 +369,7 @@ int hook_exists(struct repository *r, const char *name)
 {
 	struct string_list *hooks = list_hooks(r, name, NULL);
 	int exists = hooks->nr > 0;
-	hook_list_clear(hooks, NULL);
+	string_list_clear_func(hooks, hook_free);
 	free(hooks);
 	return exists;
 }
@@ -515,7 +523,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	run_processes_parallel(&opts);
 	ret = cb_data.rc;
 cleanup:
-	hook_list_clear(cb_data.hook_command_list, options->feed_pipe_cb_data_free);
+	string_list_clear_func(cb_data.hook_command_list, hook_free);
 	free(cb_data.hook_command_list);
 	run_hooks_opt_clear(options);
 	return ret;
diff --git a/hook.h b/hook.h
index e514c1b45b..168c6495a4 100644
--- a/hook.h
+++ b/hook.h
@@ -7,6 +7,9 @@
 
 struct repository;
 
+typedef void (*hook_data_free_fn)(void *data);
+typedef void *(*hook_data_alloc_fn)(void *init_ctx);
+
 /**
  * Represents a hook command to be run.
  * Hooks can be:
@@ -41,10 +44,15 @@ struct hook {
 	 * Only useful when using `run_hooks_opt.feed_pipe`, otherwise ignore it.
 	 */
 	void *feed_pipe_cb_data;
-};
 
-typedef void (*hook_data_free_fn)(void *data);
-typedef void *(*hook_data_alloc_fn)(void *init_ctx);
+	/**
+	 * Callback to free `feed_pipe_cb_data`.
+	 *
+	 * It is called automatically and points to the `feed_pipe_cb_data_free`
+	 * provided via the `run_hook_opt` parameter.
+	 */
+	hook_data_free_fn data_free;
+};
 
 struct run_hooks_opt
 {
@@ -186,10 +194,10 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
 			       struct run_hooks_opt *options);
 
 /**
- * Frees the memory allocated for the hook list, including the `struct hook`
- * items and their internal state.
+ * Frees a struct hook stored as the util pointer of a string_list_item.
+ * Suitable for use as a string_list_clear_func_t callback.
  */
-void hook_list_clear(struct string_list *hooks, hook_data_free_fn cb_data_free);
+void hook_free(void *p, const char *str UNUSED);
 
 /**
  * Frees the hook configuration cache stored in `struct repository`.
-- 
2.52.0.732.gb351b5166d.dirty

