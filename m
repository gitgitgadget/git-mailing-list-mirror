Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC143557E0
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 11:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768305474; cv=pass; b=sbyelicqLsiBBPm2I2J0SyTo09LPjhASd0HVO1+sbU4m1hbT4iXj37cQBpHokfOp0hFNlCbNv1P8crY9YfXhn9Gl5llz0Sn3ua3zm7/BYuGr+GpBxM69lnjhjNINoM3G8B/AxH7L161KX5/UvUZUDaFZIDmy6ZkBdUuZ0E9VT9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768305474; c=relaxed/simple;
	bh=m4c4hfvdiYzUhaACM0TIaRO/V8jM3BHPSKFJ0009HXc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sL/6o1BfgUYxnIabgTcuOU4EvZZTpiCJTEX+0eP4UbYrtXDmKrjwN6wJkZdG32nCWXxdcXmgkNkBLgOXzsEPP7GzmgSPUGRbz9IPiF3JVrtgWzM6xBha6yoOsXnnrKefNYvmys29BGzXNdE+IytSPlcaqk7gr/3XT4Tqtsm9x+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=WQWD4Jp/; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="WQWD4Jp/"
ARC-Seal: i=1; a=rsa-sha256; t=1768305453; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=IWBjqJYL1fMozsQx8+UGTuOsyO5smcXtZ537KOjhmtqbmlzt3DVw3dkLxV8+u+Cv7EXEarUYl5esVtZkIlbFN/zF2ApuBOW/CZTlWFFWB0ymSUJqi8JGoNNj/rpBSkD/R0naIMBsJbY2Yjc8g2H78lE88o3d+VfeDoXzAV28IUA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1768305453; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=TJcMKNp54qBWxR8eMr5/fi7D6hJUU4n5dRjgOeJhrjk=; 
	b=iprTKlGTwN34mqmcVw5yinVabduY1gb4UVpvauD4HvPsjwtCNBxBSrjhs3QScFRFve20a9AfAtSLgPtULVFXGJQsDMU3B2Ob+ZnxsbMboJnjqWjDIg7q1SQA4zQpHYxkyQACg+A1S+j6b1pPNISo+PjN99P5H3wD0cpr092gySg=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1768305453;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=TJcMKNp54qBWxR8eMr5/fi7D6hJUU4n5dRjgOeJhrjk=;
	b=WQWD4Jp/x8vYoPacnj2ZQG/Ksv8M3elFrIPbMXSSnVJjkAtlPmP6vClKl0wmdjKE
	phZ6SynvVWR/U7lIxJyuDIiAzP0jHjKAQIiWuESl4aavkhq0Aeuq5YAp9TOSDJdDpW/
	3/HwDi9Xi3ujAMdaqX5A6klDtaOFbPaDO2ZtYDv8=
Received: by mx.zohomail.com with SMTPS id 1768305450806908.9937826563012;
	Tue, 13 Jan 2026 03:57:30 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Emily Shaffer <emilyshaffer@google.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>,
	Chris Darroch <chrisd@apache.org>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH] hook: make stdout_to_stderr optional
Date: Tue, 13 Jan 2026 13:56:33 +0200
Message-ID: <20260113115633.230479-1-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

The last batch of hooks converted to the hook.[ch] API introduced
a regression because pick_next_hook() always sets stdout_to_stderr
for its child processes.

Pre-push is the only hook API user which requires stdout_to_stderr
to be 0, so it can be argued that pre-push needs fixing, however
this will likely break many pre-push hooks, so it's better to allow
it to be 0, i.e. to match the previous behavior.

We can introduce an extension for the breaking change of all hooks
sending stdout to stderr, however this just fixes the regression.

Reported-by: Chris Darroch <chrisd@apache.org>
Suggested-by: brian m. carlson <sandals@crustytoothpaste.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
This is based on the latest master branch.
Pushed to GitHub: https://github.com/10ne1/git/tree/dev/aratiu/make-hook-stdout_to_stderr-optional-v1
Succesful CI run: https://github.com/10ne1/git/actions/runs/20954859587
---
 hook.c      | 2 +-
 hook.h      | 6 ++++++
 transport.c | 1 +
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/hook.c b/hook.c
index 35211e5ed7..ebd9d9e26e 100644
--- a/hook.c
+++ b/hook.c
@@ -81,7 +81,7 @@ static int pick_next_hook(struct child_process *cp,
 		cp->in = -1;
 	}
 
-	cp->stdout_to_stderr = 1;
+	cp->stdout_to_stderr = hook_cb->options->stdout_to_stderr;
 	cp->trace2_hook_name = hook_cb->hook_name;
 	cp->dir = hook_cb->options->dir;
 
diff --git a/hook.h b/hook.h
index ae502178b9..2488db7133 100644
--- a/hook.h
+++ b/hook.h
@@ -39,6 +39,11 @@ struct run_hooks_opt
 	 */
 	unsigned int ungroup:1;
 
+	/**
+	 * Send the hook's stdout to stderr.
+	 */
+	unsigned int stdout_to_stderr:1;
+
 	/**
 	 * Path to file which should be piped to stdin for each hook.
 	 */
@@ -93,6 +98,7 @@ struct run_hooks_opt
 #define RUN_HOOKS_OPT_INIT { \
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
+	.stdout_to_stderr = 1, \
 }
 
 struct hook_cb_data {
diff --git a/transport.c b/transport.c
index 6d0f02be5d..8f0e5987ab 100644
--- a/transport.c
+++ b/transport.c
@@ -1372,6 +1372,7 @@ static int run_pre_push_hook(struct transport *transport,
 
 	opt.feed_pipe = pre_push_hook_feed_stdin;
 	opt.feed_pipe_cb_data = &data;
+	opt.stdout_to_stderr = 0;
 
 	ret = run_hooks_opt(the_repository, "pre-push", &opt);
 
-- 
2.52.0

