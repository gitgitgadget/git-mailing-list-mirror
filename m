Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C294B390CB6
	for <git@vger.kernel.org>; Fri, 20 Mar 2026 11:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774007593; cv=pass; b=tHAjCRw3umwlJ2KShefWH80Dm1yBP0dgrqHgaoNJc7P0szWTTasH8Jw+LQgYXnW4aAaS2cxLzfXu5gC3aB8JNcOQ7cvpckbDPFBbs/iTETANqNOS1hR597SpGp3bkLeuX9uJrTxjDliUCtJScefgktMTSC8txEgY2QuTXf9QPMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774007593; c=relaxed/simple;
	bh=bJz2o8Uwfp6pwgA0gZFB2xcDUNeb2FHpAF+owY0dBcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iMa9pQ9BeCsXC4/bdprzWxhUSZgeeIFyweXLys1yDVOPpVGSbC8i9c8PtKdZonGjlS35+j0Q/ztPXK/orwQDViDJDJUerqoVP14eUdQqp0zjVreVUEeRfLRIU5cKDTsVAdmfPJKXgyNUzWB4E5/wnahF3WhZjwoeafYxowLVvxo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=VNA4TSyS; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="VNA4TSyS"
ARC-Seal: i=1; a=rsa-sha256; t=1774007580; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UbyxCllfqoU18mTHfzlUzvArTlCuQvC68WKprOdIBaszBtEolRRq8aVLTNEEZbw0izs/1eBI4y5oi1x16H2hmtU9R9jp2caoxCRTyfaeAKgX4Eu6P/TCGxBsf7OgXII0VBEc6lXqU9uf8a+ngWwqQoiVT3ookHePsELG/QtPJbE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774007580; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=q9R+bRmXEGP/cRPffjbpBapS9zdlpHKjmkAfaVhykP4=; 
	b=VRG0Mo3V45y6r/h9VBR5BS5/Z8EiodbiCcI+qXoyZNaTrw6zKUuYLibO55YMDu4nYuf76EYwihNjyrSOy19XwZtIJvWlFVy0apiuxuuU/XBekyIQa8YDQ3e18w8e37P0VuDuOC2dAmprrmbsPWtT8yAjRMtF3rmPfzkYFrqpbsk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774007580;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=q9R+bRmXEGP/cRPffjbpBapS9zdlpHKjmkAfaVhykP4=;
	b=VNA4TSySlj9jOJ3cht9OcmvqB1Y+6FkfDOn74PzRH8PmHHueKuvIbJQJs/XbyHtb
	msHvJd3m8CXZtPtWr42JXySTrTGY3jp7BiYYhqj/1Ji0ooZvNxh4y7kKEmgM9P/006V
	iqp9k00JodlkX1o8KJKmyYDoOAOpSMsbq/oqd9Uk=
Received: by mx.zohomail.com with SMTPS id 1774007578486597.4907541484763;
	Fri, 20 Mar 2026 04:52:58 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v2 05/10] hook: replace hook_list_clear() -> string_list_clear_func()
Date: Fri, 20 Mar 2026 13:52:06 +0200
Message-ID: <20260320115211.177351-6-adrian.ratiu@collabora.com>
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
 hook.c         | 44 ++++++++++++++++++++++++++------------------
 hook.h         | 20 ++++++++++++++------
 3 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/builtin/hook.c b/builtin/hook.c
index e641614b84..54b737990b 100644
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
index 6dfaa7e9b1..f6bb1999ae 100644
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
index 94649218a1..74f4701176 100644
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
 
 struct run_hooks_opt {
 	/* Environment vars to be set for each hook */
@@ -185,10 +193,10 @@ struct string_list *list_hooks(struct repository *r, const char *hookname,
 			       struct run_hooks_opt *options);
 
 /**
- * Frees the memory allocated for the hook list, including the `struct hook`
- * items and their internal state.
+ * Frees a struct hook stored as the util pointer of a string_list_item.
+ * Suitable for use as a string_list_clear_func_t callback.
  */
-void hook_list_clear(struct string_list *hooks, hook_data_free_fn cb_data_free);
+void hook_free(void *p, const char *str);
 
 /**
  * Frees the hook configuration cache stored in `struct repository`.
-- 
2.52.0.732.gb351b5166d.dirty

