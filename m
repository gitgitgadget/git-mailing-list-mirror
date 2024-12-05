Received: from aib29agh124.zrh1.oracleemaildelivery.com (aib29agh124.zrh1.oracleemaildelivery.com [192.29.178.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA81214A73
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 12:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401132; cv=none; b=azypC/NdqNIi2CgE+xeuBEE8FwhswB7tsRFaHt/27uVhNV5g5BvRTb89omz5Zxuc0UJItdJhc5OmfyG1eQ8jvXmekLiq1Bt6rKzwKcO71Mw9d2kEMCztBVY5tpe06uaijg5NicFGk0rHd9b2RQslUngK7lQRX0OVYBRsfqEESSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401132; c=relaxed/simple;
	bh=715ZaPAej0L1Giw0+UQ/k65E+y+cwFodapw8Ikb2FCg=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=AeRMr9hrcQJVcfVrXjTcZCk09w3QgQJN1nCwJ7xixWRLQN/UF4sBiFcKE8vpdssjWgz4nUkWzZLckT5ehzET5pV+FLYaf8R9kRB9yMaWNxdLu5WdYeV4yBmKw5BYeQfrTUwBH4HorQUCC+/CDAE8orwhUvPvdNikicZMjtIfqv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=KCZzhIId; arc=none smtp.client-ip=192.29.178.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="KCZzhIId"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=lSFjlf5lCY/tOu4SDDsdKryI8Zegteb0LBJ046zbWwQ=;
 b=KCZzhIId0q+h/kwYghRwnL4Cm7UB7Ft41F5yM+Mv0ajw7siq+TIBQJwslJBGpAbcCu8+Z3B7+keD
   rHvDor/boPb2Hvtsumn0WqWjIlpM9VYqIx0H+ZE7Y0INoMGsyMxl2YyTVQHQHsWPEuwF/r6nxH0p
   Fvf1IVbWCGEWHRIwDH00bxJbfuoCEzX4rcF4XUUznFV5TlVQ81hj9fUd8yj8PGHRr0shC8fnjxXs
   yecsChRHNGzUCBBq1IDFW4LMUK78qETsWEP18nJAG7iu8xb+xXNYT4W6PPm5K6dI/JQI9BpNdLDt
   vx6+q7YhHs2Rb1T/4MP8PSG7cdx0kMSKgfKQWA==
Received: by omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO000D5USVCUG80@omta-ad1-fd2-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Thu, 05 Dec 2024 12:18:48 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Bence Ferdinandy <bence@ferdinandy.com>,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Karthik Nayak <karthik.188@gmail.com>,	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v3 2/3] fetch set_head: add warn-if-not-$branch option
Date: Thu,  5 Dec 2024 13:16:21 +0100
Message-id: <20241205121737.1181695-2-bence@ferdinandy.com>
In-reply-to: <20241205121737.1181695-1-bence@ferdinandy.com>
References: <173ea521-6a2e-45aa-ae5e-4da99060cc4f@app.fastmail.com>
 <20241205121737.1181695-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAF7auvij4z5nZj1+hXu9tMn/LZ18Pk4Ps3GFhpA0WpLphquIyAscYY4pgHTOzrh
 WB97q7yVo/cXdUcktolNJONQhm1W+3bEY4jVu2zZzYo45eoJsMVtS0gxN4GLad6J
 QuHxLsxu9JqBCy3LmRWh/us6AZyNRoC+as7PtfB+MHMvCwcTqvi9VGtaDF5ycesY
 sisPuAfyi0nAvvaraSB7Fb8aJvvgHQupaVQX6Sj6YpUHaL+CaKQAG7zjsGMIXd5N
 fua3AgH34l+d37cu2pBfkpt6gx2mbDdhlEuoIWQvqTwvoZk+0pJQSnhFZY069gUe
 o7RazPnmkw87uSaIqFrUoVMIfST+IC+2V6EB9vfmT9to6U9qTvG3Ebmpz0f7s9qr
 7VrE3VH/hCQ/poiXIg7yWYiqWnFpLrBOwTm0Wih1R5ee/4UUopqVVgTg7oGKg2YH
 4p5HgELuAXYWuqhJyBJPMU63vsjJz0UTlkIM/1a7zmzFTZwrO+E8HlyZ

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
    
    v3: s/output/actual in tests

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
index 5d7ee1b550..3885461ac1 100755
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
+		actual=$(git fetch) &&
+		test "z" = "z$actual" &&
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
+		git fetch >actual &&
+		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+			"but we have ${SQ}other${SQ} locally." >expect &&
+		test_cmp expect actual &&
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

