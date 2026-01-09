Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3637364E9B
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 18:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767982784; cv=pass; b=mFrMrg0Q1l3SkPEQMqIVv2/XwAjgB3xxpeSF4CH168UEGNLaZ7It9Dygz6w7o3s1uxa/RYgJp6XW//xxRPQaSBXCuxFfZYs2IodzkwaF8gQK3bzJj/Z2Dw+cbDc7ivJiGb9Ixc6CZRZ71oX/N25zqW35qz3rH0aWOGVKTqSt6Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767982784; c=relaxed/simple;
	bh=DYAeWhZtU95Fu0k9R2I+OllW9bse2Tz5MdsF9vQZPTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SHcvuNBX2c+Ln6xSj8eOByalyKkaiHlGVK8VknfaLPg2uOxyeGKdt2w/Evgx5KtbplS9PAJsxUMZzkTAtZPUesneYheLF+B2wGie8xiglno74QfPZYR/HUhF+NimZ0S8RrveAoS3vNI1Imx2idCc19K2w/Wa09Xk5WxzxImN7Lk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=dZP3RyRH; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="dZP3RyRH"
ARC-Seal: i=1; a=rsa-sha256; t=1767982771; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ZjB/uXpvt6oD+23AhmtJW5PqnwBD8l3FUgM/Pw7gM9WcePGbVzim3toSAvGRkmssikQARzq3XLYRxUa6XGeDUr7L0rdUuq2oZUnlXxCbMZ60aio8cytHB5pPqwHqEoJUm4uQXDXawfczmXfhrmCgkGy3/LowIVFZrgLNt614lKg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767982771; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=BDP+fTvLuYDN1I26c83Co/p0KaouATeOQgi9Bltlxhw=; 
	b=TlVOUEcc6oCvYi32XlGrCAfBNc0woR1abZYjt7KhznwuH4xa0yPgi+Ko7eTInjgGrSlGo22yu4G0gbXFqe82qARRxZ79JhEq5w0te9juqw402wMw8TSg4UZgnPZgFLvvbtT/O7kEaWCYxC30l3ravF9fN8dPfoKY428Vg38Ai5E=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767982771;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=BDP+fTvLuYDN1I26c83Co/p0KaouATeOQgi9Bltlxhw=;
	b=dZP3RyRHOWnx3fwJzXP4B66ohpN1d6+HxV79lBvBZxWMJJm0pk3a/gEdhhj9Z1Mo
	LoqLDe0PhuYaDL7QPm0s00FK5iFvZjORv1EePNkDey4DmyRCTGQ1bFEUoq650PA8Hrc
	V7OKdLrYHgW247rlnOea6UbBu7WLsAoFJZchiyTc=
Received: by mx.zohomail.com with SMTPS id 1767982767527131.4696382782107;
	Fri, 9 Jan 2026 10:19:27 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	correctmost <cmlists@sent.com>
Subject: [PATCH v2][next] hook: check for NULL pointer before deref
Date: Fri,  9 Jan 2026 20:19:12 +0200
Message-ID: <20260109181912.689409-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Fix a compiler warning (-Werror=analyzer-deref-before-check) due to
dereferencing the options pointer before NULL checking it.

In practice run_hooks_opt() is never called with a NULL opt struct,
so this just fixes the code to not trigger the warning anymore.

The NULL check is kept as-is because some future patches might end up
calling run_hooks_opt with a NULL opt struct, which is clearly a bug.

While at it, also fix the BUG message function name.

Reported-by: correctmost <cmlists@sent.com>
Suggested-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
This is based on next, because it fixes a warning introduced in next.

Changes in v2:
* Applied fix to two additional dereferences (Patrick)

Succesful CI run: https://github.com/10ne1/git/actions/runs/20859773595
---
 hook.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/hook.c b/hook.c
index 35211e5ed7..6b8ddfe7b6 100644
--- a/hook.c
+++ b/hook.c
@@ -148,28 +148,29 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	};
 	const char *const hook_path = find_hook(r, hook_name);
 	int ret = 0;
-	const struct run_process_parallel_opts opts = {
+	struct run_process_parallel_opts opts = {
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
 
 		.processes = 1,
-		.ungroup = options->ungroup,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
-		.feed_pipe = options->feed_pipe,
-		.consume_output = options->consume_output,
 		.task_finished = notify_hook_finished,
 
 		.data = &cb_data,
 	};
 
 	if (!options)
-		BUG("a struct run_hooks_opt must be provided to run_hooks");
+		BUG("a struct run_hooks_opt must be provided to run_hooks_opt");
 
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
 
+	opts.ungroup = options->ungroup;
+	opts.feed_pipe = options->feed_pipe;
+	opts.consume_output = options->consume_output;
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
-- 
2.51.2

