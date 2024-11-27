Received: from aib29agh122.zrh1.oracleemaildelivery.com (aib29agh122.zrh1.oracleemaildelivery.com [192.29.178.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA921891B2
	for <git@vger.kernel.org>; Wed, 27 Nov 2024 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732699095; cv=none; b=aRH41fKW/sGz2jy0b7LK2i3tfhrUW//1aZunB3nqo3DTVR4f6MDOvuspvK6xF6hCNNaAATEucMfRnvvpotG3rRpXDCOdagDAdnOArZTo+s5UWeXQskJxkhfrRoUWiAMVJzqqorxnGo51O5F9KD/H5gJKk08lYwYY8EqSPbJQye0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732699095; c=relaxed/simple;
	bh=+E+Qjp6UcXMi0iBWB2IYbSJrSuxQCtZIb3uGokgoWYw=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=MCTvqPaLfCD6AN10ikUGxZrglBB6MJSAgWT9D3l6sXe2o1bpsPete3iDRAgtIAjX5EROfoUlUSErdCnolp2VbXNfRnqfTX7fgJpPPjh9ozzk3lO9XUYILxoTWcxB+utftyjPLoA6zDEEN00Zselpt12Po69GqDGne1W6r4bAx0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=Un9bd2nG; arc=none smtp.client-ip=192.29.178.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="Un9bd2nG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=PPrbkG1gWcwQGeUfQ5VXbQEHsRlBT0XLWALaD6xbrIs=;
 b=Un9bd2nG8WWzu2MYIeNHrKNTNE5y+faxv3FgOOxip5qv7Ypgp3APG6Tl2H5RuKhGtyzAoCGV1sMj
   PnTdCKvj1Ug9ST6jixnAkheRNwpr8EYx+uTXL6MYPFakWOpRadq1vaG0QDu7uCyMVOw9sIvcctBi
   e1OQ/vQeD033Pr5reyust5UnK/4/2RBn2Prxwb3jgkpDFDlopmWJkJR3z4tvEnwe3cu759Ejd2h3
   KEY4LaNOBtEal1PgdJvN3ao7TKWdyYFlav1i2ztOhXsAuPJl7JaKOFEw3pdg4UW04j/dezA+xo1M
   5zDy/vrjAWWNw4t+L5rZId2u7ElWuCke0hwr5Q==
Received: by omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SNL0001KR65G8B0@omta-ad1-fd1-401-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Wed, 27 Nov 2024 09:18:05 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>,	karthik.188@gmail.com,
	Taylor Blau <me@ttaylorr.com>,	Patrick Steinhardt <ps@pks.im>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [PATCH v1] fetch: add configuration for set_head behaviour
Date: Wed, 27 Nov 2024 10:16:25 +0100
Message-id: <20241127091718.345541-1-bence@ferdinandy.com>
In-reply-to: <20241122123138.66960-1-bence@ferdinandy.com>
References: <20241122123138.66960-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHPdtQ2E8baPXs7GJdE6nIh/M8u5nrfiQIdTHBnjSZySGlGt93DAeGSYmDQMvLm
 Xg8ERjLDbreSsLK2V9yOdzQ1eorMRMucfDt8g639wtOudDdVlDjINz8tTEX+sEFU
 pjpAmwN7aWTflQjmuyr2j45323nBwgpKmBkLAGFTihIcf6gjYZCi3HuFcosfHYZq
 jzwrssp1w4YbdD5fhY3UUZ9RBeeVG2ZZ6ioaURArt3G+GY/5n2mejPyPpcFnGGIW
 SZQRXUrmP8EgwxQHoqZXNxqitdn3sKSEVdU8rPRoAo/eAYFXsBiGkYCY2j4gvyGw
 zVkFjh2M4slpl92Ix0wTsFKg5Mb9oAmghHJTDRcM+JNjp2e0SsTcqr/+4H8Zg12n
 JcZMumVJ3ATYajkiGc8E4WuLqAN8Bss/Batj8cntw0MahiIXomy1GV5RdEU/Y/AE
 izCHJ4IDuIH2SEH7cQskhiFXucwyd4Klur6h8o8y3dQnyuwzDVD7EB9o

In the current implementatio, if refs/remotes/$remote/HEAD does not
exist, running fetch will create it, but if it does exist it will not do
anything, which is a somewhat safe and minimal approach. Unfortunately,
for users who wish to NOT have refs/remotes/$remote/HEAD set for any
reason (e.g. so that `git rev-parse origin` doesn't accidentally point
them somewhere they do not want to), there is no way to remove this
behaviour. On the other side of the spectrum, users may want fetch to
automatically update HEAD or at least give them a warning if something
changed on the remote.

Introduce a new setting, remote.$remote.followRemoteHEAD with four
options:

    - "never": do not ever do anything, not even create
    - "create": the current behaviour, now the default behaviour
    - "warn": print a message if remote and local HEAD is different
    - "always": silently update HEAD on every change

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    This patch is built off v15 of the set-head/fetch updates series:
    https://lore.kernel.org/git/D5WEJJBMSO1K.2TPXDI1K08SHT@ferdinandy.com/T/#m13a0c3e8919872188ef07fd9fd984c78e8aa35ba
    
    The patch is sent separately, because the rest of the series building up
    to here seems ready, while this patch will likely trigger some
    discussion.

 Documentation/config/remote.txt |  11 ++++
 builtin/fetch.c                 |  46 ++++++++++++--
 remote.c                        |   9 +++
 remote.h                        |   9 +++
 t/t5510-fetch.sh                | 102 ++++++++++++++++++++++++++++++++
 5 files changed, 171 insertions(+), 6 deletions(-)

diff --git a/Documentation/config/remote.txt b/Documentation/config/remote.txt
index 6d8b7d6c63..024f92befc 100644
--- a/Documentation/config/remote.txt
+++ b/Documentation/config/remote.txt
@@ -101,6 +101,17 @@ remote.<name>.serverOption::
 	The default set of server options used when fetching from this remote.
 	These server options can be overridden by the `--server-option=` command
 	line arguments.
+
+remote.<name>.followRemoteHEAD::
+	How linkgit:git-fetch[1] should handle updates to `remotes/<name>/HEAD`.
+	The default value is "create", which will create `remotes/<name>/HEAD`
+	if it exists on the remote, but not locally, but will not touch an
+	already existing local reference.  Setting to "warn" will print
+	a message if the remote has a different value, than the local one and
+	in case there is no local reference, it behaves like "create". Setting
+	to "always" will silently update it to the value on the remote.
+	Finally, setting it to "never" will never change or create the local
+	reference.
 +
 This is a multi-valued variable, and an empty value can be used in a higher
 priority configuration file (e.g. `.git/config` in a repository) to clear
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 2f416cf867..b619bddd7a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1579,10 +1579,35 @@ static const char *strip_refshead(const char *name){
 	return name;
 }
 
-static int set_head(const struct ref *remote_refs)
+static void report_set_head(const char *remote, const char *head_name,
+			struct strbuf *buf_prev, int updateres) {
+	struct strbuf buf_prefix = STRBUF_INIT;
+	const char *prev_head = NULL;
+
+	strbuf_addf(&buf_prefix, "refs/remotes/%s/", remote);
+	skip_prefix(buf_prev->buf, buf_prefix.buf, &prev_head);
+
+	if (prev_head && strcmp(prev_head, head_name)) {
+		printf("'HEAD' at '%s' is '%s', but we have '%s' locally.\n",
+			remote, head_name, prev_head);
+		printf("Run 'git remote set-head %s %s' to follow the change.\n",
+			remote, head_name);
+	}
+	else if (updateres && buf_prev->len) {
+		printf("'HEAD' at '%s' is '%s', "
+			"but we have a detached HEAD pointing to '%s' locally.\n",
+			remote, head_name, buf_prev->buf);
+		printf("Run 'git remote set-head %s %s' to follow the change.\n",
+			remote, head_name);
+	}
+	strbuf_release(&buf_prefix);
+}
+
+static int set_head(const struct ref *remote_refs, int follow_remote_head)
 {
-	int result = 0, is_bare;
-	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT;
+	int result = 0, create_only, is_bare, was_detached;
+	struct strbuf b_head = STRBUF_INIT, b_remote_head = STRBUF_INIT,
+		      b_local_head = STRBUF_INIT;
 	const char *remote = gtransport->remote->name;
 	char *head_name = NULL;
 	struct ref *ref, *matches;
@@ -1603,6 +1628,8 @@ static int set_head(const struct ref *remote_refs)
 		string_list_append(&heads, strip_refshead(ref->name));
 	}
 
+	if (follow_remote_head < 0)
+		goto cleanup;
 
 	if (!heads.nr)
 		result = 1;
@@ -1614,6 +1641,7 @@ static int set_head(const struct ref *remote_refs)
 	if (!head_name)
 		goto cleanup;
 	is_bare = is_bare_repository();
+	create_only = follow_remote_head == 2 ? 0 : !is_bare;
 	if (is_bare) {
 		strbuf_addstr(&b_head, "HEAD");
 		strbuf_addf(&b_remote_head, "refs/heads/%s", head_name);
@@ -1626,9 +1654,14 @@ static int set_head(const struct ref *remote_refs)
 		result = 1;
 		goto cleanup;
 	}
-	if (refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
-					"fetch", NULL, !is_bare))
+	was_detached = refs_update_symref_extended(refs, b_head.buf, b_remote_head.buf,
+					"fetch", &b_local_head, create_only);
+	if (was_detached == -1) {
 		result = 1;
+		goto cleanup;
+	}
+	if (follow_remote_head == 1 && verbosity >= 0)
+		report_set_head(remote, head_name, &b_local_head, was_detached);
 
 cleanup:
 	free(head_name);
@@ -1636,6 +1669,7 @@ static int set_head(const struct ref *remote_refs)
 	free_refs(matches);
 	string_list_clear(&heads, 0);
 	strbuf_release(&b_head);
+	strbuf_release(&b_local_head);
 	strbuf_release(&b_remote_head);
 	return result;
 }
@@ -1855,7 +1889,7 @@ static int do_fetch(struct transport *transport,
 				  "you need to specify exactly one branch with the --set-upstream option"));
 		}
 	}
-	if (set_head(remote_refs))
+	if (set_head(remote_refs, transport->remote->follow_remote_head))
 		;
 		/*
 		 * Way too many cases where this can go wrong
diff --git a/remote.c b/remote.c
index 10104d11e3..5a768ddac2 100644
--- a/remote.c
+++ b/remote.c
@@ -514,6 +514,15 @@ static int handle_config(const char *key, const char *value,
 	} else if (!strcmp(subkey, "serveroption")) {
 		return parse_transport_option(key, value,
 					      &remote->server_options);
+	} else if (!strcmp(subkey, "followremotehead")) {
+		if (!strcmp(value, "never"))
+			remote->follow_remote_head = -1;
+		else if (!strcmp(value, "create"))
+			remote->follow_remote_head = 0;
+		else if (!strcmp(value, "warn"))
+			remote->follow_remote_head = 1;
+		else if (!strcmp(value, "always"))
+			remote->follow_remote_head = 2;
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index a7e5c4e07c..3ceadac820 100644
--- a/remote.h
+++ b/remote.h
@@ -107,6 +107,15 @@ struct remote {
 	char *http_proxy_authmethod;
 
 	struct string_list server_options;
+
+	/*
+	 * The setting for whether to update HEAD for the remote.
+	 * -1 never update
+	 * 0 create only (default)
+	 * 1 warn on change
+	 * 2 always update
+	 */
+	int follow_remote_head;
 };
 
 /**
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index 87698341f5..2467027d34 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -99,6 +99,108 @@ test_expect_success "fetch test remote HEAD change" '
 	branch=$(git rev-parse refs/remotes/origin/other) &&
 	test "z$head" = "z$branch"'
 
+test_expect_success "fetch test followRemoteHEAD never" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
+		git config set remote.origin.followRemoteHEAD "never" &&
+		git fetch &&
+		test_must_fail git rev-parse --verify refs/remotes/origin/HEAD
+	)
+'
+
+test_expect_success "fetch test followRemoteHEAD warn no change" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git config set remote.origin.followRemoteHEAD "warn" &&
+		git fetch >output &&
+		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+			"but we have ${SQ}other${SQ} locally." >expect &&
+		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
+		test_cmp expect output &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/other) &&
+		test "z$head" = "z$branch"
+	)
+'
+
+test_expect_success "fetch test followRemoteHEAD warn create" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
+		git config set remote.origin.followRemoteHEAD "warn" &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		output=$(git fetch) &&
+		test "z" = "z$output" &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/main) &&
+		test "z$head" = "z$branch"
+	)
+'
+
+test_expect_success "fetch test followRemoteHEAD warn detached" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git update-ref --no-deref -d refs/remotes/origin/HEAD &&
+		git update-ref refs/remotes/origin/HEAD HEAD &&
+		HEAD=$(git log --pretty="%H") &&
+		git config set remote.origin.followRemoteHEAD "warn" &&
+		git fetch >output &&
+		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
+			"but we have a detached HEAD pointing to" \
+			"${SQ}${HEAD}${SQ} locally." >expect &&
+		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
+		test_cmp expect output
+	)
+'
+
+test_expect_success "fetch test followRemoteHEAD warn quiet" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git config set remote.origin.followRemoteHEAD "warn" &&
+		output=$(git fetch --quiet) &&
+		test "z" = "z$output" &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/other) &&
+		test "z$head" = "z$branch"
+	)
+'
+
+test_expect_success "fetch test followRemoteHEAD always" '
+	test_when_finished "git config unset remote.origin.followRemoteHEAD" &&
+	(
+		cd "$D" &&
+		cd two &&
+		git rev-parse --verify refs/remotes/origin/other &&
+		git remote set-head origin other &&
+		git rev-parse --verify refs/remotes/origin/HEAD &&
+		git rev-parse --verify refs/remotes/origin/main &&
+		git config set remote.origin.followRemoteHEAD "always" &&
+		git fetch &&
+		head=$(git rev-parse refs/remotes/origin/HEAD) &&
+		branch=$(git rev-parse refs/remotes/origin/main) &&
+		test "z$head" = "z$branch"
+	)
+'
+
 test_expect_success 'fetch --prune on its own works as expected' '
 	cd "$D" &&
 	git clone . prune &&
-- 
2.47.1.295.ge630f003e1.dirty

