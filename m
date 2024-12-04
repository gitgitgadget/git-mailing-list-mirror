Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4464D9FB
	for <git@vger.kernel.org>; Wed,  4 Dec 2024 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733308877; cv=none; b=Oe0bqWGGJIEzSej/6deDTrJ3AaFkyhhiSy07vYFPZsBPmXsqexTgbckAsmUMjA3h3g7N3LfQgLh63kOsEl68Pzm1pHJ7jzV7+QtT/Cdi78oJ1FgOzsLE25CXYGkG5Z/f/TV9yoyE12k+haSbxVay9L0zbJ9dWKnJpj+HRv5Zfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733308877; c=relaxed/simple;
	bh=i7H2lX2+6eThK7UUHDOXCL/NbuzUMRj/bfbr+s2htDg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=jBgEdcRIWidX9OKBdJKpdfuEe4GOkQKnEnH8sQ0zTpx0Pe/Z91imrN03LvVi+uuUh6vbHZKx57fGmye9dAayogx768fbKefKT6k25A9pXMP5QoIiE3kOj0WkjR26+/ziy2IZc9I5YcG/9v3L3sbBa96ycb+dTxmF7ptIkf79v74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=lcHhLQfa; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="lcHhLQfa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=/JTIOmGvcUsoY6twrH6GgHwIKtbRAsZd/0at70FsO5M=;
 b=lcHhLQfannNd/ry+3juZpKsEBaJsnaPAlOIZh7CWdTmSAf2TMWsF9DX707ItDw2m5pY/KeE0xC/r
   zhULAEeDKhCn1fZci78wZ561kcvRwwYl7naW+yZMOrhUDz2TQMzhYB1sjLdmfbGY/RodxwO90Opm
   SSxhk+EYi1MNSCwqzrE1OazWMr3+oIUG6zCNJ/AlvLA8zd13Vdu7Ua88KCy32KpkyDpRf4C5EVMM
   al8m5kVgjweYOLtpAX6+eEsxu4giFj/YgMYREFKF74R8y8NYFwicZ01JHZZIpeIPV0CqU84TXThG
   fUkwl3ekSlIZ7LH667mSDNu4fElC+W0sgZ1wqA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNY00881TOPOVF0@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 04 Dec 2024 10:41:13 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v2 2/3] fetch set_head: add warn-if-not-$branch option
Date: Wed,  4 Dec 2024 11:39:25 +0100
Message-id: <20241204104003.514905-2-bence@ferdinandy.com>
In-reply-to: <20241204104003.514905-1-bence@ferdinandy.com>
References: <20241203215713.135068-1-bence@ferdinandy.com>
 <20241204104003.514905-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAFT3u2STzDfwqqTfQV9JtTvpZc/stlRMtWIqovsFZ1gzqEvq1d9mdXL/9RJGmU1
 /+rQoxRkwAtOlY+glzw60gw4SXWpYE6J3Sr8NjaAHCNscJaP4as7U8HxICWadxNo
 G1pRgStjF4Sl/xwA0XNR6xkjbi9AJKPimbnKKs1JcKcW2HKv0zhbMuBMkDf9Kni2
 v3HWkXDws1yBCIaeDxASYGycBYUML6TiTrapQuLfryGo4aj5ZdFZNyffUTIwomNy
 L8rMzqjo7Xp0V6hUTUvLedW8XAzHFfqUUTSp1kcRXjbzDrEgpQK3HyVnqVNPOuf/
 ciZ4N1n6ENajOFpBXOVRntvonVhpLaDFR+AOI6o76g2o31yhh0TgTRy80Zu3AiHp
 HPljBdB1F0Cpf4ObonE/XXC8ukV/WSzvXtI54JhhTLImHbk7M8cFuZ5S1Va7FU93
 J/5yECxRM/7ew7nuFMCyNQ5ngOotsvNsv1j2tE01vlvwv0mSd4j0cm1N

Currently if we want to have a remote/HEAD locally that is different
from the one on the remote, but we still want to get a warning if remote
changes HEAD, our only option is to have an indiscriminate warning with
"follow_remote_head" set to "warn". Add a new option
"warn-if-not-$branch", where $branch is a branch name we do not wish to
get a warning about. If the remote HEAD is $branch do not warn,
otherwise, behave as "warn".

E.g. let's assume, that our remote origin has HEAD
set to "master", but locally we have "git remote set-head origin seen".
Setting 'remote.origin.followRemoteHEAD = "warn"' will always print
a warning, even though the remote has not changed HEAD from "master".
Setting 'remote.origin.followRemoteHEAD = "warn-if-not-master" will
squelch the warning message, unless the remote changes HEAD from
"master". Note, that should the remote change HEAD to "seen" (which we
have locally), there will still be no warning.

Improve the advice message in report_set_head to also include silencing
the warning message with "warn-if-not-$branch".

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v2: reuse FOLLOW_REMOTE_WARN
        add documentation

 Documentation/config/remote.txt |  8 ++++---
 builtin/fetch.c                 | 16 +++++++++-----
 remote.c                        | 13 +++++++++--
 remote.h                        |  1 +
 t/t5510-fetch.sh                | 38 +++++++++++++++++++++++++++++++++
 5 files changed, 66 insertions(+), 10 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 024f92befc..4118c219c1 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -106,10 +106,12 @@ remote.<name>.followRemoteHEAD::
 	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`.
 	The default value is "create", which will create `remotes/<name>/HEAD`
 	if it exists on the remote, but not locally, but will not touch an
-	already existing local reference.  Setting to "warn" will print
+	already existing local reference. Setting to "warn" will print
 	a message if the remote has a different value, than the local one and
-	in case there is no local reference, it behaves like "create". Setting
-	to "always" will silently update it to the value on the remote.
+	in case there is no local reference, it behaves like "create".
+	A variant on "warn" is "warn-if-not-$branch", which behaves like
+	"warn", but if `HEAD` on the remote is `$branch` it will be silent.
+	Setting to "always" will silently update it to the value on the remote.
 	Finally, setting it to "never" will never change or create the local
 	reference.
 +
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 087beb4c92..b3f6793026 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1584,10 +1584,12 @@ static void set_head_advice_msg(const char *remote, const char *head_name)
 	const char message_advice_set_head[] =
 	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
 	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
-	   "if you do not want to see this message.");
+	   "if you do not want to see this message. Specifically running\n"
+	   "'git config set remote.%s.followRemoteHEAD %s' will disable the warning\n"
+	   "until the remote changes HEAD to something else.");
 
 	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
-			remote, head_name, remote);
+			remote, head_name, remote, remote, head_name);
 }
 
 static void report_set_head(const char *remote, const char *head_name,
@@ -1612,7 +1614,8 @@ static void report_set_head(const char *remote, const char *head_name,
 	strbuf_release(&buf_prefix);
 }
 
-static int set_head(const struct ref *remote_refs, int follow_remote_head)
+static int set_head(const struct ref *remote_refs, int follow_remote_head,
+		const char *no_warn_branch)
 {
 	int result = 0, create_only, is_bare, was_detached;
 	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
@@ -1669,7 +1672,9 @@ static int set_head(const struct ref *remote_refs, int follow_remote_head)
 		result = 1;
 		goto cleanup;
 	}
-	if (follow_remote_head == FOLLOW_REMOTE_WARN && verbosity >= 0)
+	if (verbosity >= 0 &&
+		follow_remote_head == FOLLOW_REMOTE_WARN &&
+		(!no_warn_branch || strcmp(no_warn_branch, head_name)))
 		report_set_head(remote, head_name, &b_local_head, was_detached);
 
 cleanup:
@@ -1898,7 +1903,8 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (set_head(remote_refs, transport->remote->follow_remote_head))
+	if (set_head(remote_refs, transport->remote->follow_remote_head,
+		transport->remote->no_warn_branch))
 		;
 		/*
 		 * Way too many cases where this can go wrong
diff --git a/remote.c b/remote.c
index 0b18840d43..4ec5d3f47b 100644
--- a/remote.c
+++ b/remote.c
@@ -515,14 +515,23 @@ static int handle_config(const char *key, const char *value,
 		return parse_transport_option(key, value,
 					      &remote->server_options);
 	} else if (!strcmp(subkey, "followremotehead")) {
+		const char *no_warn_branch;
 		if (!strcmp(value, "never"))
 			remote->follow_remote_head = FOLLOW_REMOTE_NEVER;
 		else if (!strcmp(value, "create"))
 			remote->follow_remote_head = FOLLOW_REMOTE_CREATE;
-		else if (!strcmp(value, "warn"))
+		else if (!strcmp(value, "warn")) {
 			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
-		else if (!strcmp(value, "always"))
+			remote->no_warn_branch = NULL;
+		} else if (skip_prefix(value, "warn-if-not-", &no_warn_branch)) {
+			remote->follow_remote_head = FOLLOW_REMOTE_WARN;
+			remote->no_warn_branch = no_warn_branch;
+		} else if (!strcmp(value, "always")) {
 			remote->follow_remote_head = FOLLOW_REMOTE_ALWAYS;
+		} else {
+			warning(_("unrecognized followRemoteHEAD value '%s' ignored"),
+				value);
+		}
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 184b35653d..bda10dd5c8 100644
--- a/remote.h
+++ b/remote.h
@@ -116,6 +116,7 @@ struct remote {
 	struct string_list server_options;
 
 	enum follow_remote_head_settings follow_remote_head;
+	const char *no_warn_branch;
 };
 
 /**
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 5d7ee1b550..5c9915b836 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -181,6 +181,44 @@ test_expect_success "fetch test followRemoteHEAD warn quiet" '
 	)
 '
 
+test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is same" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git config set remote.origin.followRemoteHEAD "warn-if-not-main" &&
+		output=$(git fetch) &&
+		test "z" = "z$output" &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/other) &&
+		test "z$head" = "z$branch"
+	)
+'
+
+test_expect_success "fetch test followRemoteHEAD warn-if-not-branch branch is different" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git config set remote.origin.followRemoteHEAD "warn-if-not-some/different-branch" &&
+		git fetch >output &&
+		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+			"but we have ${SQ}other${SQ} locally." >expect &&
+		test_cmp expect output &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/other) &&
+		test "z$head" = "z$branch"
+	)
+'
+
 test_expect_success "fetch test followRemoteHEAD always" '
 	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
 	(
-- 
2.47.1.398.g18e7475ebe

