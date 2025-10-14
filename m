Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41878313542
	for <git@vger.kernel.org>; Tue, 14 Oct 2025 12:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760444913; cv=pass; b=BAhBQkT54R47XFtmHP/m14+HXV6x8bd1fJesraCkMfJk66wGbnDSdHNyiShEmwpZikaAX/uplGabQgsJVJL1hFvQdRmXhEGVtgp/JyvI809puOxpvc9LWb3GGIhW0Raw8EF+q95z/8fsOdjrBt2idK1h1Kz+7WS5+fk4H9Rl2FU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760444913; c=relaxed/simple;
	bh=qKmaZVshbjnMEpKq4DXteA4zsFGuGdG0GuUxlKG51qA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mY/xAI42Lb4kX42GXMSWat4w3Z7rVTIjWPl35aI7ikvUVx86QmTSTUI1avh3/w0uTgrXYk0eteEvCdUCivqdOx8+jkjUIKRDQSXUPZy0fNqiKX1hLft+z4a+6cn1fAeYZm6Vpk6/TKfUfHagxPcwklWEJE3K5o67nUiqLJ+sJlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=jrY8D80d; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="jrY8D80d"
ARC-Seal: i=1; a=rsa-sha256; t=1760444777; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=aD9vKbc2k4XPI0bPzbebHJAML8WUdmc0UHXukrWVWvcAzzDO0Sqq3yeGb+1pfbPrEyyvyr042pougOjNBHTmfuj3scC81ZcRDK4TmRe9B3IKqHgieMDgMeej4isK+Uw3fbUGX8bjxgIwRROSlZAS0fWb8lGVVQA5ILrckA4iazg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1760444777; h=Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=5yKhtNWeREnS3mfG2vNVdz6oCmdGjnG0IVZz5fJzcqg=; 
	b=a9JusPCD06DLan52/TfWw+xujg/XHl/XZo82liLoc59IRk2eW6N2Gt3vEJM/hljMNs0ZC6FAKM4TjHjLOPjG8LI3zeDicy2PH5RWVhNL4fkABi1a/aKxeuc2Qp6wYk6PRmj4XkXG8pc8faUS/wT4GG8oUf1vxcrB4IBkE+4soX4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1760444777;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=5yKhtNWeREnS3mfG2vNVdz6oCmdGjnG0IVZz5fJzcqg=;
	b=jrY8D80deb8yohnhEB9EIfhr9txv6sAyiTEas+bdpfST82ioWg0MyJRopfziUqTV
	D6V0A7x45T8Zat6LXAAyrDrMxeD0b41gWLlL8VgznChysrGfVqwpyHxoyi1Dk5xuT2p
	CBUki2N14eHbg08Iiy6FIe5lcNwZHQb5NjQNJNgA=
Received: by mx.zohomail.com with SMTPS id 1760444767619993.1827325852238;
	Tue, 14 Oct 2025 05:26:07 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v4 22/29] rebase: persist --trailer options across restarts
Date: Tue, 14 Oct 2025 20:24:35 +0800
Message-ID: <20251014122452.1851103-23-me@linux.beauty>
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

