Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83FB61F6DC
	for <e@80x24.org>; Wed, 25 Jan 2017 22:04:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbdAYWDw (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Jan 2017 17:03:52 -0500
Received: from mail-pg0-f52.google.com ([74.125.83.52]:36424 "EHLO
        mail-pg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750930AbdAYWD2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Jan 2017 17:03:28 -0500
Received: by mail-pg0-f52.google.com with SMTP id 3so9017116pgj.3
        for <git@vger.kernel.org>; Wed, 25 Jan 2017 14:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=sGPDxSH/KgXwSQFdmYBAePztFWVbMqHsEljVxyfMWvM=;
        b=q7n1YAmtmdBNZZbglfElsCr+0TQ8+xh6+a/DnZ3vjKh36NEUCqQmWEYncqWqdu1GUa
         b/H5FU3OUnE931PR/UtrgMEdSLtOAJpu2BJ9OdfqVGa1/TXRS1L+CWY0bzu7l4aurJLd
         b+LooDgJS0TlSUdK87bBC6QQQSfTqrg6//r6urHRZJ2sx+RGIahTi+loWVIoVxiImnMR
         8CcW0GE1vAL6UnGRVOxiSId9nh2zIQsWinR8ZvNyyYYxzTk4rw8orxkvhz5fUa+zOVOR
         5YcBLZgNpJEc/uR9sZLULefn4nj7jDgoG01Rj4uscBt8VOfhDxikafT6IlxpODImXr6V
         I39A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=sGPDxSH/KgXwSQFdmYBAePztFWVbMqHsEljVxyfMWvM=;
        b=BKANe5pxtEDh4p50sI4Z7dHvl0Dq7HFPdjAMU9q8Sbm5EPJM4vd+04n27ScdRW+ogK
         AKAafUm33JJKwmuKiaxqDdW2RHhEOVhNatngbTdC542KkEMQd5BR1ysbQc/t/lkTO7Df
         C6PBj6TFzxqUzjr6w4ES15zxO16G0TEiLOeUroYPCelKbRcdPMIlRLUTI70YnQNqOgS7
         G6nQvaIgnZiC9e5TNvY/INH/OFR3LUu+TIfaiz7NhghmQzoc2Kf2mdTI6tKkA0ua/zTS
         CiVQZ4lfr4HnI6i2Mtqrm0lWtafsthQ9UxHC1M1vmBhSc8rN0QeCFT9fLGYJz6xOK/2U
         UMqg==
X-Gm-Message-State: AIkVDXKYJsfW0+Hbj9htsu862+e6pq/HTVZlwkMz72MDjFTbpUl0u7S8diEkdrjsMPdf/qx+
X-Received: by 10.99.101.65 with SMTP id z62mr1697917pgb.74.1485381807289;
        Wed, 25 Jan 2017 14:03:27 -0800 (PST)
Received: from twelve2.mtv.corp.google.com ([100.96.238.13])
        by smtp.gmail.com with ESMTPSA id o24sm3357308pfj.78.2017.01.25.14.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 25 Jan 2017 14:03:26 -0800 (PST)
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Subject: [RFC 10/14] fetch-pack: support partial names and globs
Date:   Wed, 25 Jan 2017 14:03:03 -0800
Message-Id: <8e8ff3cbd7276233e712b4d0049e709c2372cfd7.1485381677.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.11.0.483.g087da7b7c-goog
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
In-Reply-To: <cover.1485381677.git.jonathantanmy@google.com>
References: <cover.1485381677.git.jonathantanmy@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Teach fetch-pack to support partial ref names and ref patterns as input.

This does not use "want-ref" yet - support for that will be added in a
future patch.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch-pack.c  | 40 ++++++++++++-------------------------
 remote.c              | 55 +++++++++++++++++++++++++++++++++++++++++++++++++++
 remote.h              | 16 +++++++++++++++
 t/t5500-fetch-pack.sh | 38 +++++++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 27 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index a18fd0c44..5f14242ae 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -11,32 +11,12 @@ static const char fetch_pack_usage[] =
 "[--include-tag] [--upload-pack=<git-upload-pack>] [--depth=<n>] "
 "[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]";
 
-static void add_sought_entry(const struct ref ***sought, int *nr, int *alloc,
+static void add_sought_entry(struct refspec **sought, int *nr, int *alloc,
 			     const char *name)
 {
-	struct ref *ref;
-	struct object_id oid;
-
-	if (!get_oid_hex(name, &oid)) {
-		if (name[GIT_SHA1_HEXSZ] == ' ') {
-			/* <sha1> <ref>, find refname */
-			name += GIT_SHA1_HEXSZ + 1;
-		} else if (name[GIT_SHA1_HEXSZ] == '\0') {
-			; /* <sha1>, leave sha1 as name */
-		} else {
-			/* <ref>, clear cruft from oid */
-			oidclr(&oid);
-		}
-	} else {
-		/* <ref>, clear cruft from get_oid_hex */
-		oidclr(&oid);
-	}
-
-	ref = alloc_ref(name);
-	oidcpy(&ref->old_oid, &oid);
 	(*nr)++;
 	ALLOC_GROW(*sought, *nr, *alloc);
-	(*sought)[*nr - 1] = ref;
+	parse_ref_or_pattern(&(*sought)[*nr - 1], name);
 }
 
 int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
@@ -44,8 +24,10 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	int i, ret;
 	struct ref *ref = NULL;
 	const char *dest = NULL;
-	const struct ref **sought = NULL;
+	struct refspec *sought = NULL;
 	int nr_sought = 0, alloc_sought = 0;
+	const struct ref **sought_refs;
+	int nr_sought_refs;
 	int fd[2];
 	char *pack_lockfile = NULL;
 	char **pack_lockfile_ptr = NULL;
@@ -195,8 +177,9 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 			return args.diag_url ? 0 : 1;
 	}
 	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL, &shallow);
+	get_ref_array(&sought_refs, &nr_sought_refs, ref, sought, nr_sought);
 
-	ref = fetch_pack(&args, fd, conn, ref, dest, sought, nr_sought,
+	ref = fetch_pack(&args, fd, conn, ref, dest, sought_refs, nr_sought_refs,
 			 &shallow, pack_lockfile_ptr);
 	if (pack_lockfile) {
 		printf("lock %s\n", pack_lockfile);
@@ -222,12 +205,15 @@ int cmd_fetch_pack(int argc, const char **argv, const char *prefix)
 	 */
 	for (i = 0; i < nr_sought; i++) {
 		struct ref *r;
-		for (r = ref; r; r = r->next)
-			if (!sought[i] || refname_match(sought[i]->name, r->name))
+		if (sought[i].pattern)
+			continue; /* patterns do not need to match anything */
+		for (r = ref; r; r = r->next) {
+			if (refname_match(sought[i].src, r->name))
 				break;
+		}
 		if (r)
 			continue;
-		error("no such remote ref %s", sought[i]->name);
+		error("no such remote ref %s", sought[i].src);
 		ret = 1;
 	}
 
diff --git a/remote.c b/remote.c
index 725a2d39a..08f3c910e 100644
--- a/remote.c
+++ b/remote.c
@@ -612,6 +612,39 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 	die("Invalid refspec '%s'", refspec[i]);
 }
 
+void parse_ref_or_pattern(struct refspec *refspec, const char *str)
+{
+	struct object_id oid;
+	memset(refspec, 0, sizeof(*refspec));
+
+	if (!get_oid_hex(str, &oid)) {
+		if (str[GIT_SHA1_HEXSZ] == ' ') {
+			struct object_id oid2;
+			/* <sha1> <ref>, find refname */
+			refspec->src = xstrdup(str + GIT_SHA1_HEXSZ + 1);
+			if (!get_oid_hex(refspec->src, &oid2)
+			    && !oidcmp(&oid, &oid2))
+				/* The name is actually a SHA-1 */
+				refspec->exact_sha1 = 1;
+		} else if (str[GIT_SHA1_HEXSZ] == '\0') {
+			; /* <sha1>, leave sha1 as name */
+			refspec->src = xstrdup(str);
+			refspec->exact_sha1 = 1;
+		} else {
+			/* <ref> */
+			refspec->src = xstrdup(str);
+		}
+	} else {
+		/* <ref> */
+		refspec->src = xstrdup(str);
+	}
+
+	if (has_glob_specials(refspec->src)) {
+		refspec->pattern = 1;
+		refspec->dst = refspec->src;
+	}
+}
+
 int valid_fetch_refspec(const char *fetch_refspec_str)
 {
 	struct refspec *refspec;
@@ -1924,6 +1957,28 @@ int get_fetch_map(const struct ref *remote_refs,
 	return 0;
 }
 
+void get_ref_array(const struct ref ***refs, int *nr_ref,
+		   const struct ref *remote_refs,
+		   const struct refspec *refspecs, int nr_refspecs)
+{
+	struct ref *head = NULL, **tail = &head;
+	const struct ref **array = NULL;
+	int nr = 0, alloc = 0;
+
+	struct ref *r;
+	int i;
+
+	for (i = 0; i < nr_refspecs; i++)
+		get_fetch_map(remote_refs, &refspecs[i], &tail, 1);
+	for (r = head; r; r = r->next) {
+		nr++;
+		ALLOC_GROW(array, nr, alloc);
+		array[nr - 1] = r;
+	}
+	*refs = array;
+	*nr_ref = nr;
+}
+
 int resolve_remote_symref(struct ref *ref, struct ref *list)
 {
 	if (!ref->symref)
diff --git a/remote.h b/remote.h
index 2f7f23d47..daca1c65e 100644
--- a/remote.h
+++ b/remote.h
@@ -162,6 +162,13 @@ int ref_newer(const struct object_id *new_oid, const struct object_id *old_oid);
  */
 struct ref *ref_remove_duplicates(struct ref *ref_map);
 
+/*
+ * Parse the given ref or ref pattern. If a ref, write a refspec with that ref
+ * as src, and with an empty dst. If a ref pattern, write a glob refspec with
+ * that pattern as src and dst.
+ */
+void parse_ref_or_pattern(struct refspec *refspec, const char *str);
+
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
@@ -192,6 +199,15 @@ void set_ref_status_for_push(struct ref *remote_refs, int send_mirror,
 int get_fetch_map(const struct ref *remote_refs, const struct refspec *refspec,
 		  struct ref ***tail, int missing_ok);
 
+/*
+ * Convenience function to generate an array of refs corresponding to the given
+ * refspecs. This is equivalent to repeatedly calling get_fetch_map and
+ * rearranging the returned refs as an array.
+ */
+void get_ref_array(const struct ref ***refs, int *nr_ref,
+		   const struct ref *remote_refs,
+		   const struct refspec *refspecs, int nr_refspecs);
+
 struct ref *get_remote_ref(const struct ref *remote_refs, const char *name);
 
 /*
diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
index 505e1b4a7..cb1b7d949 100755
--- a/t/t5500-fetch-pack.sh
+++ b/t/t5500-fetch-pack.sh
@@ -547,6 +547,44 @@ test_expect_success 'fetch-pack can fetch a raw sha1' '
 	git fetch-pack hidden $(git -C hidden rev-parse refs/hidden/one)
 '
 
+test_expect_success 'fetch-pack can fetch refs using a partial name' '
+	git init server &&
+	(
+		cd server &&
+		test_commit 1 &&
+		test_commit 2 &&
+		git checkout -b one
+	) &&
+	rm -f trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git fetch-pack server one >actual &&
+	grep " want " trace &&
+	! grep " want-ref " trace &&
+
+	grep "$(printf "%s refs/heads/one" $(git -C server rev-parse --verify one))" actual
+'
+
+test_expect_success 'fetch-pack can fetch refs using a glob' '
+	rm -rf server &&
+	git init server &&
+	(
+		cd server &&
+		test_commit 1 &&
+		test_commit 2 &&
+		git checkout -b ona &&
+		git checkout -b onb &&
+		test_commit 3 &&
+		git checkout -b onc
+	) &&
+	rm -f trace &&
+	GIT_TRACE_PACKET="$(pwd)/trace" git fetch-pack server "refs/heads/on*" >actual &&
+	grep " want " trace &&
+	! grep " want-ref " trace &&
+
+	grep "$(printf "%s refs/heads/ona" $(git -C server rev-parse --verify ona))" actual &&
+	grep "$(printf "%s refs/heads/onb" $(git -C server rev-parse --verify onb))" actual &&
+	grep "$(printf "%s refs/heads/onc" $(git -C server rev-parse --verify onc))" actual
+'
+
 check_prot_path () {
 	cat >expected <<-EOF &&
 	Diag: url=$1
-- 
2.11.0.483.g087da7b7c-goog

