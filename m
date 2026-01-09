Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658792C21E6
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 15:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767972968; cv=pass; b=Rao65BTEa1KSCunehzcrWgRzdS7mt/hkhs5b4RT7zLWUWihG/GTaw03rSkhabku5kXVvpbBaRxVr7yGJWgdq3U0DKccQGAqfnGdbE28Sc4k8iliWFqC4+dm91hQ4k0Q13iwBkvszvvPuMHNpbFuucdcW4vjZ/qloDodpTD5rZe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767972968; c=relaxed/simple;
	bh=ACufrq6Fw+my5tp28lYGogzF9jIceVrdlAyaI889qKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PTt6ZTy8dE64PpL+aKSj1JMl/mqRqCkTEo5KuZZUBCtpTj5x90hiWbUAJKZOu6RUZo6smuCo6Av9lSt+ghFV59Ecc1iHiI6tdGbO6RLAI54vpafksEE/kxNpqYj0/IHlcBzWAF26ae7FDSTR2Qs47ZyI0Q7zKl2ccQI1u5p6HBM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=Je+D0/ec; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="Je+D0/ec"
ARC-Seal: i=1; a=rsa-sha256; t=1767972956; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=hPwiC+Ho5ScX4XxOTJTaAsarGA1Gz3iBYzauSsBM4/Ewcsv6PJTrHLK7zHYXLIyKXo3KunyXbXqfXBmiDcxkKVXDTnBKkkbC7t9BvM1yKA0DWz8ry783qPG0qHztwVRhVAyZ21rgwMtEALtx04PVoC7LCcRdw2EPUF5O+pgdJjc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1767972956; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=gAxJn9DDFdhF70+wDKUb9Z23oQkHPSUxF7vGQ4vvj+k=; 
	b=XnbLTua/khhX6/45fSRdmMqdm7E/xQjaSOw+tX6V47+xC0SjHwVcELl4BkxQMqN0+3MW8YJ6WpaB9rYj/45BfjdJaPgDFbp2BeXSU6sBxITeXqSgD5isx2PIr/YPl6xp582JQqpQDnQS+lQ582+bpyqzDlp0DuzwGktFan+VKGE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767972956;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=gAxJn9DDFdhF70+wDKUb9Z23oQkHPSUxF7vGQ4vvj+k=;
	b=Je+D0/eccaHOFYw/K0l/tB0Back2Nkg4jDN3BjpuEtl22qP/f7z2T5qAwe8e230J
	DjhIvtnqpYtCtuSBrFRN8gJzDAvp3+MJnRrCsuYjYgv6lT8F1ZJPELOLZuUnDbx8u8a
	yVddCHObkzAs5QObGrWMkh9RvEASBuPCyZkZbrSU=
Received: by mx.zohomail.com with SMTPS id 1767972953659599.8727478666715;
	Fri, 9 Jan 2026 07:35:53 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	correctmost <cmlists@sent.com>
Subject: [PATCH][next] hook: check for NULL pointer before deref
Date: Fri,  9 Jan 2026 17:35:28 +0200
Message-ID: <20260109153528.476163-1-adrian.ratiu@collabora.com>
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
Succesful CI run: https://github.com/10ne1/git/actions/runs/20855922803
---
 hook.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hook.c b/hook.c
index 35211e5ed7..c257bd3940 100644
--- a/hook.c
+++ b/hook.c
@@ -148,12 +148,11 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
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
@@ -165,11 +164,13 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	};
 
 	if (!options)
-		BUG("a struct run_hooks_opt must be provided to run_hooks");
+		BUG("a struct run_hooks_opt must be provided to run_hooks_opt");
 
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
 
+	opts.ungroup = options->ungroup;
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
-- 
2.51.2

