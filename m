Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCF31352D
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444812; cv=pass; b=lBzJmqUWkn41Fj6iOF2Zor/nrpurJTvKWaY0Vps3Vn4qT0Pm8QbLcNyBOYxIpfiIG3FrkEGXeIe0WJ7Sb0CzePsP96HW0tgiW7zsayC2N/B+vTw6cWoNMqvyVxHGy6aZ5yILbbhBXoGXKOTy/qjSBKKVBq+AzTm6BkrpSY3u3F8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444812; c=relaxed/simple;
	bh=RWZra8ABYut/E9++XWte/RSWNPwWfCqoSIiYdwy3tsQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HfoGqSNqYTunQB3cszuz6xpheFzwzjg/AYFArD0y+cx5CixK4AHjNr0z0slvbyk4ZNDJb9VUD9VIjp7GBdb9blGlaXuMvFCFxg41huTT1vuaEYjvXWjVuV+euC2IV4RdYJdfSeo4mw9xpJjz9YGleYSoBtRivbNKbbXCBHpjueU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Q9Em26mV; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Q9Em26mV"
ARC-Seal: i=1; a=rsa-sha256; t=1760444736; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=eFLrLaajxv0P0AP1bN1Oa1l8o3jgGl9gP3B1Qs50lnzeuQOzH1dx0rMH44U1Cmqg2PkyoQjnlPupJfQc7dfdJXkveRXbAYUnqedrWLBI5OlJUPow7CSfr8qxAgn3OPOf3ycSKu/9rUDbJctXYeM6HPKwHJZupJZXnzFsZD7wdn8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444736; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=R6/mqo2zxcMqYE0CJCjvU/YRih5MoW99uDuyUAUiiZ8=; 
	b=N68a5QBi4Ve0J78zZkDGsH5sCM8WTbE5ahJcTDxOwf7AvxKjmDK39d17XG9bmHF1fqoh4KffjK7qm4DCBrFDt/bvxjSP2rTVRuVFil8iYi3Cbc3Ds8N8fVUHCZQIbyDXDffLdytfbpTyFCYeE7qCFHzCuRVUmuogXrIWaWw4XeA=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444736;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=R6/mqo2zxcMqYE0CJCjvU/YRih5MoW99uDuyUAUiiZ8=;
	b=Q9Em26mVDkcr63dkjh+DWd1h50eBFjmjAl7gDyxDoI7ZL2QPZFxxLOJs4lszg1lx
	eSu6SmGWhJ2RgIzzIeJCJbstk2WAbElv+m6cTHlqg9aROe3x0D3eYr/cN8zkCg0E/Rf
	tqdD/zZztqkPnh35kPzBU2j1i7o50fTb6WKhZUKA=
Received: by mx.zohomail.com with SMTPS id 1760444733752978.6290138599358;
	Tue, 14 Oct 2025 05:25:33 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 10/29] rebase: inline trailer state paths
Date: Tue, 14 Oct 2025 20:24:23 +0800
Message-ID: <20251014122452.1851103-11-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014122452.1851103-1-me@linux.beauty>
References: <20251014122452.1851103-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

Simplified read_basic_state() by dropping the
temporary trailer path variables and calling
state_dir_path("trailer", opts) directly when
loading trailer arguments.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 builtin/rebase.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/builtin/rebase.c b/builtin/rebase.c
index 3b001c0757..2a2674e375 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -442,8 +442,6 @@ static int read_basic_state(struct rebase_options *opts)
 	struct strbuf head_name = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id oid;
-	const char trailer_state_name[] = "trailer";
-	const char *path = state_dir_path(trailer_state_name, opts);
 
 	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
 			   READ_ONELINER_WARN_MISSING) ||
@@ -512,7 +510,7 @@ static int read_basic_state(struct rebase_options *opts)
 
 	strbuf_release(&buf);
 
-	if (strbuf_read_file(&buf, path, 0) >= 0) {
+	if (strbuf_read_file(&buf, state_dir_path("trailer", opts), 0) >= 0) {
 		const char *p = buf.buf, *end = buf.buf + buf.len;
 
 		while (p < end) {
@@ -535,8 +533,6 @@ static int read_basic_state(struct rebase_options *opts)
 
 static int rebase_write_basic_state(struct rebase_options *opts)
 {
-	const char trailer_state_name[] = "trailer";
-
 	write_file(state_dir_path("head-name", opts), "%s",
 		   opts->head_name ? opts->head_name : "detached HEAD");
 	write_file(state_dir_path("onto", opts), "%s",
@@ -568,7 +564,7 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 				strbuf_addstr(&buf, opts->trailer_args.v[i]);
 				strbuf_addch(&buf, '\n');
 		}
-		write_file(state_dir_path(trailer_state_name, opts),
+		write_file(state_dir_path("trailer", opts),
 				   "%s", buf.buf);
 		strbuf_release(&buf);
 	}
-- 
2.51.0

