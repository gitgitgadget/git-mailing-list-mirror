Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1F30F93D
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774468565; cv=pass; b=g11XvnF5wa74kpmDWmdYZR4/jI2QJyRn1mVUNmKIgdYtGqA7Qp3cikO1e3b6pZEoFUsT8MVEcBTumMb9gZ/sqVCdEyaVcPlzBcxzeSUC3oQVnCI23g5o2yUAhZ5VotNLKzeKvgcuzZrR/LuAqoKMH+sb5bKkZjvXTRKw9BtSoSw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774468565; c=relaxed/simple;
	bh=PrRekKa8TQ7a3uvgnyHOXaWy7P+tEVCl9FeAnGOUuRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kNWDpVr5ox8Yscw8jNcP+ClKqiE4lOng0O8xzsuRcYD3BliuIInJlwua/nujQdAeuW0ccKtgKCOCgj5O6Vg0TxemlgAu3z2c/iUhUau5vzHElLT8VumnGP5tD3GKLdpMon+zgV2N1YGSwoMYCLVHWZ2R2eB+4PGnfmcXR2bJxkE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=kcIezwhD; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="kcIezwhD"
ARC-Seal: i=1; a=rsa-sha256; t=1774468551; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=AwIqKhvE04joYHdSJvALnHofCtVf+pgNWI1PAjAnvb4hnLF6q55VrzujL/RbVtceTAM/Jbz+IKefBm9xSx4vYhrHHw5yUPt0kkQwSV2me8urChv5Sqm1bzFitPg37ykCGqIO7nVLZZVEmC/rphbeSRYDwLGsFYEVgmiUd122Hlo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1774468551; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=2Qs+lg75ltK8A+vyV7qOyLmK9Q10FpQ3ahdZCFukUvE=; 
	b=C9OF1UI81cFpPPGSoi2Ss1YWBJ1/3uTNa7dar4aw8wLYGii9bN/dgFzLtN3ROzG1a1DInb/OUibTS0tpoIq5ObmqKRWC9qhVdaSrvzmj0PTEJkEFmNUwSe0DY8fCQcmWp+6SEs++UzqSRs3SJzDzKRp6qbdQtYIUS2BG0LOMgAA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774468551;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=2Qs+lg75ltK8A+vyV7qOyLmK9Q10FpQ3ahdZCFukUvE=;
	b=kcIezwhDLUQHU0YEoQxF6hMuigciJOgH0xzK22P8Jt5EGQUH9nBkG4T4obS70yzW
	qvSSC1Lm3iotnyXsGneYp0GONTCgHnMZl9hb0ACisJeW4rts9do9wSMkNjWUcEsQzUA
	DdJHjJcDhhvU40czwLAhBpRll5Mk3BIOm+H89e+w=
Received: by mx.zohomail.com with SMTPS id 1774468550497734.9314308128345;
	Wed, 25 Mar 2026 12:55:50 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v3 06/12] hook: replace hook_list_clear() -> string_list_clear_func()
Date: Wed, 25 Mar 2026 21:54:57 +0200
Message-ID: <20260325195503.1139418-7-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260325195503.1139418-1-adrian.ratiu@collabora.com>
References: <20260309005416.2760030-1-adrian.ratiu@collabora.com>
 <20260325195503.1139418-1-adrian.ratiu@collabora.com>
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

In other words, the callers don't need to keep track of hook
internal state to determine when cleanup is necessary or not
(pass NULL) because each `struct hook` now owns its data_free
callback.

Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 builtin/hook.c |  2 +-
 hook.c         | 40 ++++++++++++++++++++++------------------
 hook.h         | 20 ++++++++++++++------
 3 files changed, 37 insertions(+), 25 deletions(-)

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
index b0226ed716..021110f216 100644
--- a/hook.c
+++ b/hook.c
@@ -52,8 +52,10 @@ const char *find_hook(struct repository *r, const char *name)
 	return path.buf;
 }
 
-static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
+void hook_free(void *p, const char *str UNUSED)
 {
+	struct hook *h = p;
+
 	if (!h)
 		return;
 
@@ -64,22 +66,12 @@ static void hook_clear(struct hook *h, hook_data_free_fn cb_data_free)
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
@@ -100,9 +92,15 @@ static void list_hooks_add_default(struct repository *r, const char *hookname,
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
@@ -316,10 +314,16 @@ static void list_hooks_add_configured(struct repository *r,
 
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
@@ -362,7 +366,7 @@ int hook_exists(struct repository *r, const char *name)
 {
 	struct string_list *hooks = list_hooks(r, name, NULL);
 	int exists = hooks->nr > 0;
-	hook_list_clear(hooks, NULL);
+	string_list_clear_func(hooks, hook_free);
 	free(hooks);
 	return exists;
 }
@@ -516,7 +520,7 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	run_processes_parallel(&opts);
 	ret = cb_data.rc;
 cleanup:
-	hook_list_clear(cb_data.hook_command_list, options->feed_pipe_cb_data_free);
+	string_list_clear_func(cb_data.hook_command_list, hook_free);
 	free(cb_data.hook_command_list);
 	run_hooks_opt_clear(options);
 	return ret;
diff --git a/hook.h b/hook.h
index 965794a5b8..a56ac20ccf 100644
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

