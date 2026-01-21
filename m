Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC5B43CEEA
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 21:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032526; cv=pass; b=VCcrtPNJP3v9V1wLa6zk0E/kDWK2bsy7TjvTLFi7wzrnVGfyAkXDXARyDAt8eu8rujyuNeTSdjaY9vGFfBsXdciLBxN8zfFL9UahKKFDzCO+GOdQqCAB/MxMAAe+6b/Z5HC62sdqWG+ct6WC27EpH6E/S8I+47k0iXH1NqtuP2k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032526; c=relaxed/simple;
	bh=DkJOlN1XdjPruf3G4OsJlyJakGy8O0oXWo4mUqFom+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bkabOUrlPhNVSA4IAS7aDuJU6UugxTMVa14/xg5Yz/ewcJp5IoIb4lEqAc0JOOrb0Jsy4pvgXV5syvFPse/8T4VXAhR+Ohnm7qB89DOjLz9DqDMZ1stu3oKlWcYEFOwYlbMiNXosq4e78UamDZMd6GgiDbp2bP5URBl5lZ8Pp98=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=HQxpIfuU; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="HQxpIfuU"
ARC-Seal: i=1; a=rsa-sha256; t=1769032511; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=OQbNF8TrubUvqTUMT91d0NjcgiA3awXpq4FjRrEK8Vt/Zde2qDdc+EClahtMbbX7w321+0u05OCXMthfzmnmgMnmcpGv/K2DQO2HK/GJSL5+wpf63BqMkGLKldqMwhMhNv2safkXtFYpWYo6CbvpytrglP6X3RbjMV6Srpe2kIY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769032511; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=As1+Woth2+/jUrdpADcJ3FTEktyt63jhwZTBhKqldIk=; 
	b=Y++OA3+QwxVW+FGh41AABfrEjRLPxwbjRupDfzk3hGFw+RXIHeY0apzy7OQoBMKz5Zy0UVN2bhrB8ndi9eot7qjepI+j79BrdrWg69JoZxevm2UgebVkQ6Oyp3MLOJq99r2zViyYZNBwQVZImjsaL1KXsGTvXfOnp4/uRiZa4HE=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769032511;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=As1+Woth2+/jUrdpADcJ3FTEktyt63jhwZTBhKqldIk=;
	b=HQxpIfuUJeV3R0KDB5lzi8LyTrB3eVylL/mqEr3bMn853pMzM+7JmYTjKCA6tN1t
	4S61T0BvgasOuZ0Ex+QdkPh89UihcrCUMX50MJI/mA0XkX1vRdariWSvyQUuP7GaX0e
	zZqJDpqoi9jCPfMropsSWziBu1NGf6R5Oz6nsECg=
Received: by mx.zohomail.com with SMTPS id 17690325101874.811498205024009;
	Wed, 21 Jan 2026 13:55:10 -0800 (PST)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: git@vger.kernel.org,
	Jeff King <peff@peff.net>
Cc: Emily Shaffer <emilyshaffer@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Josh Steadmon <steadmon@google.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Adrian Ratiu <adrian.ratiu@collabora.com>
Subject: [PATCH v7 09/12] hook: add jobs option
Date: Wed, 21 Jan 2026 23:54:33 +0200
Message-ID: <20260121215436.1473800-10-adrian.ratiu@collabora.com>
X-Mailer: git-send-email 2.52.0.732.gb351b5166d.dirty
In-Reply-To: <20260121215436.1473800-1-adrian.ratiu@collabora.com>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20260121215436.1473800-1-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Allow the API callers to specify the number of jobs across which
hook execution can be parallelized. It defaults to 1 and no hook
currently changes it, so all hooks run sequentially as before.

This allows us to both pave the way for parallel hook execution
(that will be a follow-up patch series building upon this) and to
finish the API conversion of builtin/receive-pack.c, keeping the
output muxer thread design as Peff suggested.

When .jobs == 1 nothing changes, the simple "copy_to_sideband" mux
still outputs directly via sideband channel 2, keeping the current
(mostly) real-time output characteristics, avoids unecessary poll
delays or deadlock risks.

When .jobs > 1, a more complex muxer is needed, to buffer the hook
output and avoid interleaving. After working on this mux I quickly
realized I was re-implementing run-command with ungroup=0 so that
ideas was dropped in favor of run-command which outputs to stderr.
Then run-command's stderr just connects to the simple muxer input.

Maybe it's better to understand using ascii graphics:

 [ Sequential (jobs = 1) ]             [ Parallel (jobs > 1) ]

 +--------------+                      +--------+   +--------+
 | Hook Process |                      | Hook 1 |   | Hook 2 |
 +--------------+                      +--------+   +--------+
        |                                  |             |
        | stderr (inherited)               | stderr pipe |
        |                                  | (captured)  |
        v                                  v             v
 +-------------------------------------------------------------+
 |                      Parent Process                         |
 |                                                             |
 |      (direct write)              [run-command (buffered)]   |
 |             |                                 |             |
 |             |                                 | writes      |
 |             v                                 v             |
 |      +-------------------------------------------+          |
 |      |             stderr (FD 2)                 |          |
 |      +-------------------------------------------+          |
 |                           |                                 |
 |                           | (dup2'd to pipe)                |
 |                           v                                 |
 |               +-------------------------+                   |
 |               | sideband "muxer" thread |                   |
 |               +-------------------------+                   |
 +-------------------------------------------------------------+

When use_sideband == 0, the sideband muxer thread is missing, so
the same architecture just outputs via the parent stderr stream.

See the following commits for the hook API conversions doing this,
using pre-existing sideband thread logic from `copy_to_sideband`.

Suggested-by: Jeff King <peff@peff.net>
Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
---
 hook.c | 7 +++++--
 hook.h | 9 +++++++++
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/hook.c b/hook.c
index fde1f88ce8..aafed134af 100644
--- a/hook.c
+++ b/hook.c
@@ -152,8 +152,8 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 		.tr2_category = "hook",
 		.tr2_label = hook_name,
 
-		.processes = 1,
-		.ungroup = 1,
+		.processes = options->jobs,
+		.ungroup = options->jobs <= 1,
 
 		.get_next_task = pick_next_hook,
 		.start_failure = notify_start_failure,
@@ -169,6 +169,9 @@ int run_hooks_opt(struct repository *r, const char *hook_name,
 	if (options->path_to_stdin && options->feed_pipe)
 		BUG("options path_to_stdin and feed_pipe are mutually exclusive");
 
+	if (!options->jobs)
+		BUG("run_hooks_opt must be called with options.jobs >= 1");
+
 	if (options->invoked_hook)
 		*options->invoked_hook = 0;
 
diff --git a/hook.h b/hook.h
index 7cbeef0a1e..3db860bf3c 100644
--- a/hook.h
+++ b/hook.h
@@ -16,6 +16,14 @@ struct run_hooks_opt
 	/* Emit an error if the hook is missing */
 	unsigned int error_if_missing:1;
 
+	/**
+	 *  Number of processes to parallelize across.
+	 *
+	 * If > 1, output will be buffered and de-interleaved (ungroup=0).
+	 * If == 1, output will be real-time (ungroup=1).
+	 */
+	unsigned int jobs;
+
 	/**
 	 * An optional initial working directory for the hook,
 	 * translates to "struct child_process"'s "dir" member.
@@ -86,6 +94,7 @@ struct run_hooks_opt
 	.env = STRVEC_INIT, \
 	.args = STRVEC_INIT, \
 	.stdout_to_stderr = 1, \
+	.jobs = 1, \
 }
 
 struct hook_cb_data {
-- 
2.52.0.732.gb351b5166d.dirty

