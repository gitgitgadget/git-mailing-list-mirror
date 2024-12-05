Received: from aib29agh123.zrh1.oracleemaildelivery.com (aib29agh123.zrh1.oracleemaildelivery.com [192.29.178.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F765214A73
	for <git@vger.kernel.org>; Thu,  5 Dec 2024 12:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733401137; cv=none; b=ppiNkNvr0tpdbFeuGSTXHjH7JQ5QFI7Ner5K+jEwbxvGgmbYka5qH5FvBPCjjuPtweboqdLW3S4Wsl53er1zjaCQe5Mv8DzeajtYR67kF43hCNJOmJF6H10T+q0VVyEJpuZ0LhpHoXkMxprPbLaRXCz4faprVRXeN17EAUspB/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733401137; c=relaxed/simple;
	bh=+Fx/atOKGw//dk8Qj0sNPFhEAX8Mmm+gjmFF79DkN3U=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=q9x52wMqRzZNfnFPqsToh1bKPPTwkjNJMQ2u9wiZc8beupCX1Zlp5WJwK5bUCjGX/svoglnkyKM0tMmnj6A35q8vSWlNC09ALtPHMWHDylUl5NtftbQ09asu5bm3gZJFFP96QvJqV3yYXnAnbX2GeGWoU5Kxiw1jzMXBTLrna64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=MO/FNiWB; arc=none smtp.client-ip=192.29.178.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="MO/FNiWB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=hs7HS9x6QBl/yYFKykicezVXHC/yyJ/IKX7KvsASagU=;
 b=MO/FNiWBo2ASmg4HURjIhKEObpvFoHU9QkPHEJ0g0hL8tVkiOU24mhz9nkNztE56OfOUIFk/6AtX
   ZgDLjHGdkpqt+OR0rSiT/lhDaVHXAvjRVIjEF/0oSOa56lpBcYvl47vvNu84DmondTdkqJutidrr
   NlgNIBjyUsi2CutqT2D0dzv7mUuuH+kDaOOH/IVcF9U2mpI/YyGRUUP9nvNvm6uzc7F3TkFlzDX9
   riiPAne6m69GCTe+ZnDZalcTa9kzUG7PsfWE9z49Y8MQ5wl+fUrQ43TLP2W46Jwo0s6jwoxwIHoo
   9yku/GqngovNuzEfAlXojcuTKFC+6wTay+jh+g==
Received: by omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20241107 64bit (built Nov  7
 2024))
 with ESMTPS id <0SO000BF5SVCBA20@omta-ad1-fd1-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
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
Subject: [PATCH v3 1/3] fetch set_head: move warn advice into advise_if_enabled
Date: Thu,  5 Dec 2024 13:16:20 +0100
Message-id: <20241205121737.1181695-1-bence@ferdinandy.com>
In-reply-to: <173ea521-6a2e-45aa-ae5e-4da99060cc4f@app.fastmail.com>
References: <173ea521-6a2e-45aa-ae5e-4da99060cc4f@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAENN+S17iDo31gGP2o4L5QYxGeW6jLCO1pcqz30tJPD2E33i5qJmdOLoVGP/6me
 98CqK5VGhvXNvs0AHQNdK20GfZNNnk5rMru8FQX9Xeyrl97VYH4sh3FWnJJNTBGP
 HmPxrUxSKPTskGs7/4R0ua7PNgmKCUt2d9yYHZaZmaNd54fveX80iaj89k7KdbP4
 r44Huammlob7bniXPYsh9v638b72ItAI6iQRf8Sl8/X7M49nAzWu0wuaA/T6k0JZ
 3wJTfeYS7RtUkpfEjBGDhL6U4FwwtoVz5GYo86cc9yC9Xcd1+CufKLzTz0riQ4MV
 RS9Is1fQ++Cz85nOBUuOCAdJZ6WUKWXfx/BDPjCxlQs9tJcQUrETCdQHFNwJeNnN
 PW4ipLmTKhjXFBAndXANeM1YxYah6BUzWAno98VwZyikv6b1b8EHFV+otlO15kJc
 +QO3NdYKASOiDXiqEt6LM12yi5ZltkqxRnLZefyf1VttdHwqvZPEQToT

Advice about what to do when getting a warning is typed out explicitly
twice and is printed as regular output. The output is also tested for.
Extract the advice message into a single place and use a wrapper
function, so if later the advice is made more chatty the signature only
needs to be changed in once place. Remove the testing for the advice
output in the tests.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---

Notes:
    v2: new patch, with the refactor moved out from the following one

 advice.c         |  1 +
 advice.h         |  1 +
 builtin/fetch.c  | 17 +++++++++++++----
 t/t5510-fetch.sh |  2 --
 4 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/advice.c b/advice.c
index 6b879d805c..66461fdce9 100644
--- a/advice.c
+++ b/advice.c
@@ -53,6 +53,7 @@ static struct {
 	[ADVICE_COMMIT_BEFORE_MERGE]			= { "commitBeforeMerge" },
 	[ADVICE_DETACHED_HEAD]				= { "detachedHead" },
 	[ADVICE_DIVERGING]				= { "diverging" },
+	[ADVICE_FETCH_SET_HEAD_WARN]			= { "fetchRemoteHEADWarn" },
 	[ADVICE_FETCH_SHOW_FORCED_UPDATES]		= { "fetchShowForcedUpdates" },
 	[ADVICE_FORCE_DELETE_BRANCH]			= { "forceDeleteBranch" },
 	[ADVICE_GRAFT_FILE_DEPRECATED]			= { "graftFileDeprecated" },
diff --git a/advice.h b/advice.h
index d7466bc0ef..cf2284ec43 100644
--- a/advice.h
+++ b/advice.h
@@ -20,6 +20,7 @@ enum advice_type {
 	ADVICE_COMMIT_BEFORE_MERGE,
 	ADVICE_DETACHED_HEAD,
 	ADVICE_DIVERGING,
+	ADVICE_FETCH_SET_HEAD_WARN,
 	ADVICE_FETCH_SHOW_FORCED_UPDATES,
 	ADVICE_FORCE_DELETE_BRANCH,
 	ADVICE_GRAFT_FILE_DEPRECATED,
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 62769d1686..087beb4c92 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1579,6 +1579,17 @@ static const char *strip_refshead(const char *name){
 	return name;
 }
 
+static void set_head_advice_msg(const char *remote, const char *head_name)
+{
+	const char message_advice_set_head[] =
+	N_("Run 'git remote set-head %s %s' to follow the change, or set\n"
+	   "'remote.%s.followRemoteHEAD' configuration option to a different value\n"
+	   "if you do not want to see this message.");
+
+	advise_if_enabled(ADVICE_FETCH_SET_HEAD_WARN, _(message_advice_set_head),
+			remote, head_name, remote);
+}
+
 static void report_set_head(const char *remote, const char *head_name,
 			struct strbuf *buf_prev, int updateres) {
 	struct strbuf buf_prefix = STRBUF_INIT;
@@ -1590,15 +1601,13 @@ static void report_set_head(const char *remote, const char *head_name,
 	if (prev_head && strcmp(prev_head, head_name)) {
 		printf("'HEAD' at '%s' is '%s', but we have '%s' locally.\n",
 			remote, head_name, prev_head);
-		printf("Run 'git remote set-head %s %s' to follow the change.\n",
-			remote, head_name);
+		set_head_advice_msg(remote, head_name);
 	}
 	else if (updateres && buf_prev->len) {
 		printf("'HEAD' at '%s' is '%s', "
 			"but we have a detached HEAD pointing to '%s' locally.\n",
 			remote, head_name, buf_prev->buf);
-		printf("Run 'git remote set-head %s %s' to follow the change.\n",
-			remote, head_name);
+		set_head_advice_msg(remote, head_name);
 	}
 	strbuf_release(&buf_prefix);
 }
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index ccb74428bc..5d7ee1b550 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -123,7 +123,6 @@ test_expect_success "fetch test followRemoteHEAD warn no change" '
 		git fetch >output &&
 		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
 			"but we have ${SQ}other${SQ} locally." >expect &&
-		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
 		test_cmp expect output &&
 		head=$(git rev-parse refs/remotes/origin/HEAD) &&
 		branch=$(git rev-parse refs/remotes/origin/other) &&
@@ -160,7 +159,6 @@ test_expect_success "fetch test followRemoteHEAD warn detached" '
 		echo "${SQ}HEAD${SQ} at ${SQ}origin${SQ} is ${SQ}main${SQ}," \
 			"but we have a detached HEAD pointing to" \
 			"${SQ}${HEAD}${SQ} locally." >expect &&
-		echo "Run ${SQ}git remote set-head origin main${SQ} to follow the change." >>expect &&
 		test_cmp expect output
 	)
 '
-- 
2.47.1.398.g18e7475ebe

