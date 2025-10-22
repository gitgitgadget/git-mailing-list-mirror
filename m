Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674992E9729
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111723; cv=pass; b=Fa+YE46RREM0uAdVjCmqgWQHqzfFO2xVdGzfb0mjGUKu9LQvKfJ1P6hHlJ8daohO0rbSLyZKNUURy93npScA7d6rJcwyZkX2B8uOwHICVxxdWGVARZbrytUeael+YDMQ0vatVhqe5u98fCshLL4dyZj3zbP9m7kU/pAaNaf8i0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111723; c=relaxed/simple;
	bh=6y4NFVcrBboa+nuz21ZbUQAQ9++qD7ieo9eqLygr2Po=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FLJ0buOdeM8b+7C0c3LkWcGcsRyTNClvcd6HvbCk9eRbgwlWVykzuojkNRNOJCiH/g+ed/zPTK2uBLHRyc2zxILYD0mxoL+QKMnlMKSHv3zD68z2kmEKwcAP+6Ye/O+IfcDF9BEX6uRVvjw/zIpD3UF285j+8WmRABhPY1441dw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=Qi2am0/y; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="Qi2am0/y"
ARC-Seal: i=1; a=rsa-sha256; t=1761111619; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=SOGk0F39q3A4+1zihA5GutGaoi1vQ406mgT6F+gB10h1ysYsgSJWh1ia8G5hIsZ4oYgkZd4S2Hte5lx/yvnjA1IQlWT8VYf3xJQdqB8orBpeyFH7Kg3A0NDcqrHQ4g4tJD4d2OmxHdYInx/dgIYfehO7z5OE8cSEkKaGq+QkmqE=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111619; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=P3PWTD9Cc3d4er1vP710QDQjQZ/GOXl19MQSC3I73F8=; 
	b=BX9pjvMpJT6Mr9TS3SDnq8NpR6KYgM7huK4qC/hE5QYyKnx2drNQdtQL+uv5Mge7OrriUm3lR/diM5aKg1b5Z2NqYGBpvjTPQJYbGThQ2lA0EMtwaWQ/lGBsww2aOgA2CuYIuq9xda3UAis2Y1h25TByg4r4nlznfF9R7Q3aQ6Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111619;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=P3PWTD9Cc3d4er1vP710QDQjQZ/GOXl19MQSC3I73F8=;
	b=Qi2am0/yHZ7cC1BG9yPCBykBnWchztV1XJqaHsWFexVeF0NDXb8VwO34q9B5moy0
	TKA2Ik+dbgbsUDWBjR4v/YwMExLI4aZ2/joOuRWxNEeI+9T8JO9QvhxvcqcfhmDYAgK
	JOxubp0u5M0/48tOU2hbgvDTTyaaj+CpoNofLMIg=
Received: by mx.zohomail.com with SMTPS id 1761111616422224.41744076535565;
	Tue, 21 Oct 2025 22:40:16 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 10/29] rebase: inline trailer state paths
Date: Wed, 22 Oct 2025 13:39:30 +0800
Message-ID: <20251022053951.602605-11-me@linux.beauty>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251022053951.602605-1-me@linux.beauty>
References: <20251022053951.602605-1-me@linux.beauty>
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
index 3db1439b52..b0f547ef2b 100644
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

