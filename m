Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D8602047F
	for <e@80x24.org>; Sat, 23 Sep 2017 09:45:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750896AbdIWJpN (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 05:45:13 -0400
Received: from mout.web.de ([212.227.17.11]:65251 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750766AbdIWJpL (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 05:45:11 -0400
Received: from [192.168.178.36] ([91.20.61.209]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Lg-1daty93uay-00pqAe; Sat, 23
 Sep 2017 11:45:05 +0200
Subject: [PATCH 3/3] refs: pass NULL to resolve_ref_unsafe() if hash is not
 needed
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <01b1b3bd-c948-d849-9a03-7a8327fe5003@web.de>
Date:   Sat, 23 Sep 2017 11:45:04 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.3.0
MIME-Version: 1.0
In-Reply-To: <b89d36b5-0996-829b-a267-7ee4da9673dc@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:ZAyGlRAdJYfoAMYfLx8A3PhsfJiVZiffZwOeI3p5WoZl77rtJak
 EWisHzeGICDL8RPGtmBlI3lxkkiknYvvrrpIzNhnh+BjnzY/ZzRufyzI3NOV8Xs29OU4m0p
 ft64xdyB+DFSXa5fEq2ATHWilDjlasuSfgspoX1M7U4p1EKoXDhTGFhFc7QFV3u0wJyOs7K
 Z+Jtj0sCOYF6vij5R5Wmw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YIQ5CR4YThI=:n+rOrVOVja2+4OiU1EI/hR
 rEyK8mYnNfPbmXhBSzErNlomx+YCQS0VvBUkwA+CDdXXmZc1m/ykaaxq1MXe27Hb3HYx1TSr7
 MsjLgo/I/CFRe2PFDjZ0AV2J+RPytBzxI9ySzBK+Vjb3j06wHuSeBHU/s9UGFfeJsYdv4QFpz
 kBlIdwhNZpFwYv7FCTi0WjW368jlucHfTwcqtcr4JHYwDGL3IAYaoDlnD6zT4DMD0kp1Tedne
 h/9rNw0RAzxc3a4Co/fCYDCOw/Bsa88izr+rIEsKNap/0kaNbOWN5b7/udXSiOtzeeqL6x1ye
 DYLTQzlg1dbQaUdHTt46ir0+AmHstyvrW7/QSFI+ngV1FydCePD0pcfbx5hGAU2ElNOU2MY+i
 UEthTWf3yRTxz5ebiZCjao5Ua3NcAPTjLcWgLYHKOdrAioS60T/ikOK/W9amwH8vauuduxN2u
 ou3/LQ+6C79hZnKaGcyFg5mA2y28Z9YRj5x5mK6td0QHbVRYY9Yg0P84B2UWVjrrSPyU9LTvO
 pgHTnzzeaNvSpXBKHMQuzpgA3V3xr2MhlEVDeZ8dq2vKBwkEVayDmCabzQaBGUBjTGvclEJkZ
 WLEpYcc6HoHX1QcJrdOvxDis/lTtap1e8OXXl8xDh92lwAILLnIh2UN027eJnppqBz3UmMeT9
 ILbc4ocCxOGMlgfDZpcXyEo8OcV0wBb1HF7WaPIDLhzmCiht7VhFsAyHxro8QlUeBXSWVvAHx
 9dRypI273e6ldSQg9hVJExtnGkGhPYTMOwqxCaUhszvaEPEKyYwKfernQWFlz67AOi8KMHKvb
 phNsrJb2xFf1kKsYuXNcn488WuIuW2CrKIL6Tmnw4tV2qppAFs=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This allows us to get rid of some write-only variables, among them seven
SHA1 buffers.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 branch.c                    |  3 +--
 builtin/commit.c            |  3 +--
 builtin/log.c               |  3 +--
 builtin/receive-pack.c      |  3 +--
 builtin/remote.c            |  3 +--
 builtin/submodule--helper.c |  6 ++----
 builtin/symbolic-ref.c      |  3 +--
 http-backend.c              |  3 +--
 log-tree.c                  |  3 +--
 refs.c                      |  6 ++----
 remote.c                    | 12 ++++--------
 revision.c                  |  3 +--
 transport.c                 |  3 +--
 upload-pack.c               |  3 +--
 14 files changed, 19 insertions(+), 38 deletions(-)

diff --git a/branch.c b/branch.c
index 703ded69ca..4377ce2fb1 100644
--- a/branch.c
+++ b/branch.c
@@ -191,9 +191,8 @@ int validate_new_branchname(const char *name, struct strbuf *ref,
 
 	if (!attr_only) {
 		const char *head;
-		struct object_id oid;
 
-		head = resolve_ref_unsafe("HEAD", 0, oid.hash, NULL);
+		head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 		if (!is_bare_repository() && head && !strcmp(head, ref->buf))
 			die(_("Cannot force update the current branch."));
 	}
diff --git a/builtin/commit.c b/builtin/commit.c
index 58f9747c2f..39d5b7f6c7 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1431,7 +1431,6 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	struct rev_info rev;
 	struct commit *commit;
 	struct strbuf format = STRBUF_INIT;
-	struct object_id junk_oid;
 	const char *head;
 	struct pretty_print_context pctx = {0};
 	struct strbuf author_ident = STRBUF_INIT;
@@ -1484,7 +1483,7 @@ static void print_summary(const char *prefix, const struct object_id *oid,
 	rev.diffopt.break_opt = 0;
 	diff_setup_done(&rev.diffopt);
 
-	head = resolve_ref_unsafe("HEAD", 0, junk_oid.hash, NULL);
+	head = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 	if (!strcmp(head, "HEAD"))
 		head = _("detached HEAD");
 	else
diff --git a/builtin/log.c b/builtin/log.c
index f8cccbc964..d81a09051e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1660,10 +1660,9 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			check_head = 1;
 
 		if (check_head) {
-			struct object_id oid;
 			const char *ref, *v;
 			ref = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
-						 oid.hash, NULL);
+						 NULL, NULL);
 			if (ref && skip_prefix(ref, "refs/heads/", &v))
 				branch_name = xstrdup(v);
 			else
diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index 52c63ebfdc..65d89078ab 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1207,11 +1207,10 @@ static void check_aliased_update(struct command *cmd, struct string_list *list)
 	const char *dst_name;
 	struct string_list_item *item;
 	struct command *dst_cmd;
-	unsigned char sha1[GIT_MAX_RAWSZ];
 	int flag;
 
 	strbuf_addf(&buf, "%s%s", get_git_namespace(), cmd->ref_name);
-	dst_name = resolve_ref_unsafe(buf.buf, 0, sha1, &flag);
+	dst_name = resolve_ref_unsafe(buf.buf, 0, NULL, &flag);
 	strbuf_release(&buf);
 
 	if (!(flag & REF_ISSYMREF))
diff --git a/builtin/remote.c b/builtin/remote.c
index 33ba739332..4f5cac96b0 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -558,14 +558,13 @@ static int read_remote_branches(const char *refname,
 	struct strbuf buf = STRBUF_INIT;
 	struct string_list_item *item;
 	int flag;
-	struct object_id orig_oid;
 	const char *symref;
 
 	strbuf_addf(&buf, "refs/remotes/%s/", rename->old);
 	if (starts_with(refname, buf.buf)) {
 		item = string_list_append(rename->remote_branches, xstrdup(refname));
 		symref = resolve_ref_unsafe(refname, RESOLVE_REF_READING,
-					    orig_oid.hash, &flag);
+					    NULL, &flag);
 		if (flag & REF_ISSYMREF)
 			item->util = xstrdup(symref);
 		else
diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 818fe74f0a..ea49710893 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -17,9 +17,8 @@
 static char *get_default_remote(void)
 {
 	char *dest = NULL, *ret;
-	unsigned char sha1[20];
 	struct strbuf sb = STRBUF_INIT;
-	const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
+	const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 	if (!refname)
 		die(_("No such ref: %s"), "HEAD");
@@ -1089,8 +1088,7 @@ static const char *remote_submodule_branch(const char *path)
 		return "master";
 
 	if (!strcmp(branch, ".")) {
-		unsigned char sha1[20];
-		const char *refname = resolve_ref_unsafe("HEAD", 0, sha1, NULL);
+		const char *refname = resolve_ref_unsafe("HEAD", 0, NULL, NULL);
 
 		if (!refname)
 			die(_("No such ref: %s"), "HEAD");
diff --git a/builtin/symbolic-ref.c b/builtin/symbolic-ref.c
index df75cb9d4a..17aabaa679 100644
--- a/builtin/symbolic-ref.c
+++ b/builtin/symbolic-ref.c
@@ -12,9 +12,8 @@ static const char * const git_symbolic_ref_usage[] = {
 
 static int check_symref(const char *HEAD, int quiet, int shorten, int print)
 {
-	unsigned char sha1[20];
 	int flag;
-	const char *refname = resolve_ref_unsafe(HEAD, 0, sha1, &flag);
+	const char *refname = resolve_ref_unsafe(HEAD, 0, NULL, &flag);
 
 	if (!refname)
 		die("No such ref: %s", HEAD);
diff --git a/http-backend.c b/http-backend.c
index 8076b1d5e5..b8ce960a35 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -486,10 +486,9 @@ static int show_head_ref(const char *refname, const struct object_id *oid,
 	struct strbuf *buf = cb_data;
 
 	if (flag & REF_ISSYMREF) {
-		struct object_id unused;
 		const char *target = resolve_ref_unsafe(refname,
 							RESOLVE_REF_READING,
-							unused.hash, NULL);
+							NULL, NULL);
 
 		if (target)
 			strbuf_addf(buf, "ref: %s\n", strip_namespace(target));
diff --git a/log-tree.c b/log-tree.c
index 410ab4f02d..cea056234d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -185,7 +185,6 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 {
 	const struct name_decoration *list, *head = NULL;
 	const char *branch_name = NULL;
-	struct object_id unused;
 	int rru_flags;
 
 	/* First find HEAD */
@@ -198,7 +197,7 @@ static const struct name_decoration *current_pointed_by_HEAD(const struct name_d
 		return NULL;
 
 	/* Now resolve and find the matching current branch */
-	branch_name = resolve_ref_unsafe("HEAD", 0, unused.hash, &rru_flags);
+	branch_name = resolve_ref_unsafe("HEAD", 0, NULL, &rru_flags);
 	if (!(rru_flags & REF_ISSYMREF))
 		return NULL;
 
diff --git a/refs.c b/refs.c
index 36439fdb54..97e33fdc7b 100644
--- a/refs.c
+++ b/refs.c
@@ -239,8 +239,7 @@ int read_ref(const char *refname, unsigned char *sha1)
 
 int ref_exists(const char *refname)
 {
-	unsigned char sha1[20];
-	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, sha1, NULL);
+	return !!resolve_ref_unsafe(refname, RESOLVE_REF_READING, NULL, NULL);
 }
 
 static int filter_refs(const char *refname, const struct object_id *oid,
@@ -286,12 +285,11 @@ static int warn_if_dangling_symref(const char *refname, const struct object_id *
 {
 	struct warn_if_dangling_data *d = cb_data;
 	const char *resolves_to;
-	struct object_id junk;
 
 	if (!(flags & REF_ISSYMREF))
 		return 0;
 
-	resolves_to = resolve_ref_unsafe(refname, 0, junk.hash, NULL);
+	resolves_to = resolve_ref_unsafe(refname, 0, NULL, NULL);
 	if (!resolves_to
 	    || (d->refname
 		? strcmp(resolves_to, d->refname)
diff --git a/remote.c b/remote.c
index 4113090069..b220f0dfc6 100644
--- a/remote.c
+++ b/remote.c
@@ -466,7 +466,6 @@ static void alias_all_urls(void)
 static void read_config(void)
 {
 	static int loaded;
-	struct object_id oid;
 	int flag;
 
 	if (loaded)
@@ -475,7 +474,7 @@ static void read_config(void)
 
 	current_branch = NULL;
 	if (startup_info->have_repository) {
-		const char *head_ref = resolve_ref_unsafe("HEAD", 0, oid.hash, &flag);
+		const char *head_ref = resolve_ref_unsafe("HEAD", 0, NULL, &flag);
 		if (head_ref && (flag & REF_ISSYMREF) &&
 		    skip_prefix(head_ref, "refs/heads/", &head_ref)) {
 			current_branch = make_branch(head_ref, 0);
@@ -1105,10 +1104,9 @@ static struct ref *make_linked_ref(const char *name, struct ref ***tail)
 static char *guess_ref(const char *name, struct ref *peer)
 {
 	struct strbuf buf = STRBUF_INIT;
-	struct object_id oid;
 
 	const char *r = resolve_ref_unsafe(peer->name, RESOLVE_REF_READING,
-					   oid.hash, NULL);
+					   NULL, NULL);
 	if (!r)
 		return NULL;
 
@@ -1166,12 +1164,11 @@ static int match_explicit(struct ref *src, struct ref *dst,
 		return -1;
 
 	if (!dst_value) {
-		struct object_id oid;
 		int flag;
 
 		dst_value = resolve_ref_unsafe(matched_src->name,
 					       RESOLVE_REF_READING,
-					       oid.hash, &flag);
+					       NULL, &flag);
 		if (!dst_value ||
 		    ((flag & REF_ISSYMREF) &&
 		     !starts_with(dst_value, "refs/heads/")))
@@ -1792,10 +1789,9 @@ const char *branch_get_push(struct branch *branch, struct strbuf *err)
 
 static int ignore_symref_update(const char *refname)
 {
-	struct object_id oid;
 	int flag;
 
-	if (!resolve_ref_unsafe(refname, 0, oid.hash, &flag))
+	if (!resolve_ref_unsafe(refname, 0, NULL, &flag))
 		return 0; /* non-existing refs are OK */
 	return (flag & REF_ISSYMREF);
 }
diff --git a/revision.c b/revision.c
index f9a90d71d2..9582a727ca 100644
--- a/revision.c
+++ b/revision.c
@@ -2263,11 +2263,10 @@ static int handle_revision_pseudo_opt(const char *submodule,
 
 static void NORETURN diagnose_missing_default(const char *def)
 {
-	unsigned char sha1[20];
 	int flags;
 	const char *refname;
 
-	refname = resolve_ref_unsafe(def, 0, sha1, &flags);
+	refname = resolve_ref_unsafe(def, 0, NULL, &flags);
 	if (!refname || !(flags & REF_ISSYMREF) || (flags & REF_ISBROKEN))
 		die(_("your current branch appears to be broken"));
 
diff --git a/transport.c b/transport.c
index d75ff0514d..fb8c01e57a 100644
--- a/transport.c
+++ b/transport.c
@@ -26,7 +26,6 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		const char *localname;
 		const char *tmp;
 		const char *remotename;
-		unsigned char sha[20];
 		int flag = 0;
 		/*
 		 * Check suitability for tracking. Must be successful /
@@ -44,7 +43,7 @@ static void set_upstreams(struct transport *transport, struct ref *refs,
 		localname = ref->peer_ref->name;
 		remotename = ref->name;
 		tmp = resolve_ref_unsafe(localname, RESOLVE_REF_READING,
-					 sha, &flag);
+					 NULL, &flag);
 		if (tmp && flag & REF_ISSYMREF &&
 			starts_with(tmp, "refs/heads/"))
 			localname = tmp;
diff --git a/upload-pack.c b/upload-pack.c
index 7efff2fbfd..06d822aad2 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -965,11 +965,10 @@ static int find_symref(const char *refname, const struct object_id *oid,
 {
 	const char *symref_target;
 	struct string_list_item *item;
-	struct object_id unused;
 
 	if ((flag & REF_ISSYMREF) == 0)
 		return 0;
-	symref_target = resolve_ref_unsafe(refname, 0, unused.hash, &flag);
+	symref_target = resolve_ref_unsafe(refname, 0, NULL, &flag);
 	if (!symref_target || (flag & REF_ISSYMREF) == 0)
 		die("'%s' is a symref but it is not?", refname);
 	item = string_list_append(cb_data, refname);
-- 
2.14.1
