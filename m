Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AB92EC09C
	for <git@vger.kernel.org>; Wed, 22 Oct 2025 05:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761111847; cv=pass; b=Wo9doQsLS4/wxuoCIKL3sgn6bO8qSbQJNWCnAjQBQlbBqSBPJh18jsqp8iPzF40PReN7SIPBU2AchLgCm2i/jWXrQ0g+8q0b+O7baM1wIfPeNf2uzzWKqjrKA0nUUO0e+nS8jQzIwUxcuuJ3Hm2d64j5HUvgK+nM5EOk8R9ESSQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761111847; c=relaxed/simple;
	bh=qKmaZVshbjnMEpKq4DXteA4zsFGuGdG0GuUxlKG51qA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itx4Kbn8yf3otujsA83AvDE9VEcOqWBdm10/77GNo2qIy1tsBYtEMK84osSe3svEkaZCjVmKVIduzWnYnYjoV2gww27RNgY/7rYpbBZuG9XhO1ZXDlXa4/NveVDsJ8/fefnrFx291vwWWBCxmdzX74QCDicRrJhPlpQoM3wltQQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=XI2eApom; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="XI2eApom"
ARC-Seal: i=1; a=rsa-sha256; t=1761111643; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=XTrSPqAjxF3WkUGRL+403rJdYo358Kjg0avTpr75tQLX4s0S0VZaVf1w1HbXb2daxRO4WBq40ie0XADR8W7ybgEEtxtdVd/JdPd8LboZqj/lminZHX4b8u3BNk3Mgr5RURTLdDx47DIdyd9sXyTSaRKrvHsyKQen6tSN8PqHd1U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1761111643; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=5yKhtNWeREnS3mfG2vNVdz6oCmdGjnG0IVZz5fJzcqg=; 
	b=cOvoOOTyNJ2v2ge0Qa5MpkA7gtxCY7+/p1tAi0w7OQYU0oeKrgSJK0oVCiIhPkxZXtUEerwPpGZ7+pK9cxxLFm9GY3cILXfngtqKAud0rsZHmwv/9d3IKIM5/5EERxlQTkk2nTuSPyRhNOIS1RbGoRlbGRrTPT6fpHqdRT7phrc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1761111643;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=5yKhtNWeREnS3mfG2vNVdz6oCmdGjnG0IVZz5fJzcqg=;
	b=XI2eApomNsOfJxcsNgi2oEZZz+tfERqR0JaZAbzWoAjoqAeCD7HEPYLPuvjue50o
	CYijUM060AI3zu+i7QKTxBS1d/EsassLWSmw2meoHZaBzbrOaReChNxzl8WDDE4SDlX
	d/lnBRvM2+IAe+07YEp6UJUM/uhqmf4hFlxROmGM=
Received: by mx.zohomail.com with SMTPS id 1761111640727661.0583979833602;
	Tue, 21 Oct 2025 22:40:40 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Subject: [PATCH v5 22/29] rebase: persist --trailer options across restarts
Date: Wed, 22 Oct 2025 13:39:42 +0800
Message-ID: <20251022053951.602605-23-me@linux.beauty>
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

t3440 showed rebase -m loses trailers after conflicts.
Each --continue spawns a fresh replay_opts without trailer_args.
Serialize them into rebase-merge/trailer so new runs reload them.
This keeps the user requested trailers intact when resuming.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 sequencer.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/sequencer.c b/sequencer.c
index 552e629e4f..c02364cfce 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -209,6 +209,7 @@ static GIT_PATH_FUNC(rebase_path_reschedule_failed_exec, "rebase-merge/reschedul
 static GIT_PATH_FUNC(rebase_path_no_reschedule_failed_exec, "rebase-merge/no-reschedule-failed-exec")
 static GIT_PATH_FUNC(rebase_path_drop_redundant_commits, "rebase-merge/drop_redundant_commits")
 static GIT_PATH_FUNC(rebase_path_keep_redundant_commits, "rebase-merge/keep_redundant_commits")
+static GIT_PATH_FUNC(rebase_path_trailer, "rebase-merge/trailer")
 
 /*
  * A 'struct replay_ctx' represents the private state of the sequencer.
@@ -3244,6 +3245,17 @@ static int read_populate_opts(struct replay_opts *opts)
 
 		read_strategy_opts(opts, &buf);
 		strbuf_reset(&buf);
+		if (strbuf_read_file(&buf, rebase_path_trailer(), 0) >= 0) {
+			char *p = buf.buf, *nl;
+
+			while ((nl = strchr(p, '\n'))) {
+				*nl = '\0';
+				if (*p)
+					strvec_push(&opts->trailer_args, p);
+				p = nl + 1;
+			}
+			strbuf_reset(&buf);
+		}
 
 		if (read_oneliner(&ctx->current_fixups,
 				  rebase_path_current_fixups(),
@@ -3338,6 +3350,14 @@ int write_basic_state(struct replay_opts *opts, const char *head_name,
 		write_file(rebase_path_reschedule_failed_exec(), "%s", "");
 	else
 		write_file(rebase_path_no_reschedule_failed_exec(), "%s", "");
+	if (opts->trailer_args.nr) {
+		struct strbuf buf = STRBUF_INIT;
+
+		for (size_t i = 0; i < opts->trailer_args.nr; i++)
+			strbuf_addf(&buf, "%s\n", opts->trailer_args.v[i]);
+		write_file(rebase_path_trailer(), "%s", buf.buf);
+		strbuf_release(&buf);
+	}
 
 	return 0;
 }
-- 
2.51.0

