Received: from aib29agh125.zrh1.oracleemaildelivery.com (aib29agh125.zrh1.oracleemaildelivery.com [192.29.178.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7FF91741E8
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.125
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726000634; cv=none; b=Z2zF7MbIeR6u22kOq9b5maCQin3Gvs3WH7iZN4eP/66T1i+Twi3dP2naVQlTJqcoV+bi5iYOJy7pXUWBsMhrfetccSO0bkKqQs1WyaiHSceJi5FBzeqQHZ7MI5gssJH3C5e71AWxQd2Dp0VTcTOhq6epVr/NWPzUuXrX0NtBS/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726000634; c=relaxed/simple;
	bh=QZBCqw2G82OdN2aDRIhGTS893iPwEWAjoCSNC2nDoS0=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=adHE7zf/lUJ9g1F8m2KY3XDpaiOFMg7XqgNolKx6IuSf2Nqrakm24LdDY/ozFBUT20q0m+X5dJTUc7rIVEyOwKzZaibWkCj0mY23NA6aG1vJ+vIGUxHuXiFj29StxWtV4wjR1maUDGypyZ/tDMe0zEu7tQNO6mBuNKuoIhbV/KU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=pXR0Gql4; arc=none smtp.client-ip=192.29.178.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="pXR0Gql4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=R1YrB40qO3JlgrgVOKo9miaDmh2216DNGKIvrWEzizs=;
 b=pXR0Gql4Pu5pKSYfaHDET3P26yP0Do0YQ6urHhQ+ZS4xfC8VxIBJwu4khlJnzoujxwQNDwblTmnT
   H0p3jfsvYlXvZ8LOztbATG33ymNnDdii3RUdvefMk6iKPZ/NSsP+eZMY+e7ED+SRl13Bbso9zcIu
   vL4m3TBIzjCmt9enz6ihHYZotmiuIrN45MH6uiOHCNIYQ/donEInWqNMAx0MmNewYCZvN1YAmV4s
   fGqvQim08YLk7HQZIu7PM3tYbCXavzgGvsQkZhWXeZ1dxECqwp1zP9wRvMQizGlCzGjAieBJRtwP
   MQIW/Tlx+LHn5vHDXapaGGw47ug434UjHTO0RA==
Received: by omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJM002Z96DDPM80@omta-ad1-fd2-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 10 Sep 2024 20:32:01 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: johannes.schindelin@gmx.de,	Bence Ferdinandy <bence@ferdinandy.com>,
 cc@mail.ferdinandy.com,
	/tmp/FUboFpyPuH/0001-fetch-set-head-with-set-head-option.patch@mail.ferdinandy.com
Subject: [RFC PATCH 1/2] fetch: set-head with --set-head option
Date: Tue, 10 Sep 2024 22:24:58 +0200
Message-id: <20240910203129.2251090-2-bence@ferdinandy.com>
In-reply-to: <20240910203129.2251090-1-bence@ferdinandy.com>
References: <20240910203129.2251090-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAGJ6/mkol+Ap++/pEyqGNeGu9zVxxvhfnzcW8vd2ea3WUcu9RlcMLRcPbzoE7zE
 zntPrxyZWTntUgHFoc+mQ3JKx8oyEPMPhSnW5KSC2AfRIy2WJkm+sQ67FnqGy0oE
 2LYCkOf9TKtyfApdpPqDOtFvFXjdN72vTiSUz5wZX4u+D2HWBW8ELEJP9z5V42Eh
 zHtFFMVQR65DpuElhwrWbxhV4mAF65McAI+zSk3I3WEJXkmciSokBMl9wzfCNjTg
 LkBdqUPBhZg4DMb8cpSurlQx4YYxjPL8xqUUwN1xp2MNUSru7Z/bFjKRqnvvlVND
 F1IzBqoVWKHIf6+SCdsSdhJ8FFD4jUcy58wWAo+cCn7MwQLuVsWgJMyy65V3ESsA
 UB2Ag25wfeuwiBAI7IZpLCeCPFvpOh1DpgiUp0xTWTcTgZmKb6X0mLD654/F2jjX
 KthOjEYETa1lhhZtRj+u1kCj5CNwHLaAI7b3YI+l4GXiAEwCKGLST+0=

When cloning a repository refs/remotes/origin/HEAD is set automatically.
In contrast, when using init, remote add and fetch to set a remote, one
needs to call remote set-head --auto to achieve the same result.

Add a --set-head option to git fetch to automatically set heads on
remotes.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/fetch.c  | 29 ++++++++++++++++++++++++-----
 builtin/remote.c |  5 +++++
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index b2b5aee5bf..6392314c6a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1961,8 +1961,19 @@ static int fetch_finished(int result, struct strbuf *out,
 	return 0;
 }
 
-static int fetch_multiple(struct string_list *list, int max_children,
-			  const struct fetch_config *config)
+static int run_set_head(const char *name)
+{
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	strvec_push(&cmd.args, "remote");
+	strvec_push(&cmd.args, "set-head");
+	strvec_push(&cmd.args, "--auto");
+	strvec_push(&cmd.args, name);
+	cmd.git_cmd = 1;
+	return run_command(&cmd);
+}
+
+static int fetch_multiple(struct string_list *list, int max_children, int set_head,
+			const struct fetch_config *config)
 {
 	int i, result = 0;
 	struct strvec argv = STRVEC_INIT;
@@ -2014,6 +2025,8 @@ static int fetch_multiple(struct string_list *list, int max_children,
 				error(_("could not fetch %s"), name);
 				result = 1;
 			}
+			if (set_head && run_set_head(name))
+				result = 1;
 		}
 
 	strvec_clear(&argv);
@@ -2062,7 +2075,7 @@ static inline void fetch_one_setup_partial(struct remote *remote)
 }
 
 static int fetch_one(struct remote *remote, int argc, const char **argv,
-		     int prune_tags_ok, int use_stdin_refspecs,
+		     int prune_tags_ok, int set_head, int use_stdin_refspecs,
 		     const struct fetch_config *config)
 {
 	struct refspec rs = REFSPEC_INIT_FETCH;
@@ -2135,9 +2148,12 @@ static int fetch_one(struct remote *remote, int argc, const char **argv,
 	refspec_clear(&rs);
 	transport_disconnect(gtransport);
 	gtransport = NULL;
+	if (set_head && run_set_head(remote -> name))
+		exit_code = 1;
 	return exit_code;
 }
 
+
 int cmd_fetch(int argc, const char **argv, const char *prefix)
 {
 	struct fetch_config config = {
@@ -2154,6 +2170,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 	struct string_list list = STRING_LIST_INIT_DUP;
 	struct remote *remote = NULL;
 	int all = -1, multiple = 0;
+	int set_head = 0;
 	int result = 0;
 	int prune_tags_ok = 1;
 	int enable_auto_gc = 1;
@@ -2171,6 +2188,8 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 		OPT__VERBOSITY(&verbosity),
 		OPT_BOOL(0, "all", &all,
 			 N_("fetch from all remotes")),
+		OPT_BOOL(0, "set-head", &set_head,
+			 N_("auto set remote HEAD")),
 		OPT_BOOL(0, "set-upstream", &set_upstream,
 			 N_("set upstream for git pull/fetch")),
 		OPT_BOOL('a', "append", &append,
@@ -2436,7 +2455,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 			trace2_region_leave("fetch", "setup-partial", the_repository);
 		}
 		trace2_region_enter("fetch", "fetch-one", the_repository);
-		result = fetch_one(remote, argc, argv, prune_tags_ok, stdin_refspecs,
+		result = fetch_one(remote, argc, argv, prune_tags_ok, set_head, stdin_refspecs,
 				   &config);
 		trace2_region_leave("fetch", "fetch-one", the_repository);
 	} else {
@@ -2459,7 +2478,7 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
 
 		/* TODO should this also die if we have a previous partial-clone? */
 		trace2_region_enter("fetch", "fetch-multiple", the_repository);
-		result = fetch_multiple(&list, max_children, &config);
+		result = fetch_multiple(&list, max_children, set_head, &config);
 		trace2_region_leave("fetch", "fetch-multiple", the_repository);
 	}
 
diff --git a/builtin/remote.c b/builtin/remote.c
index 0acc547d69..35c54dd103 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1536,9 +1536,12 @@ static int get_remote_default(const char *key, const char *value UNUSED,
 static int update(int argc, const char **argv, const char *prefix)
 {
 	int i, prune = -1;
+	int set_head = 0;
 	struct option options[] = {
 		OPT_BOOL('p', "prune", &prune,
 			 N_("prune remotes after fetching")),
+		OPT_BOOL(0, "set-head", &set_head,
+			 N_("auto set remote HEAD")),
 		OPT_END()
 	};
 	struct child_process cmd = CHILD_PROCESS_INIT;
@@ -1552,6 +1555,8 @@ static int update(int argc, const char **argv, const char *prefix)
 
 	if (prune != -1)
 		strvec_push(&cmd.args, prune ? "--prune" : "--no-prune");
+	if (set_head)
+		strvec_push(&cmd.args, "--set-head");
 	if (verbose)
 		strvec_push(&cmd.args, "-v");
 	strvec_push(&cmd.args, "--multiple");
-- 
2.46.0

