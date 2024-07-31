Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812F5101EE
	for <git@vger.kernel.org>; Wed, 31 Jul 2024 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722463749; cv=none; b=nAPHymBxFBpDNRbEE1lTXUiyZ7O6t19b9J6Z7a21/ZsSDAsso6Dbt6jINW2jAvOxLsW7QAovabhkzYPTTzf0BA7a0QLID9aHRFd/4P9CAKM41xebduyR07YVHIgp/KXIj5SQqk7mOI/m25HLu31XzX0Yb6s87Ayr1SiZriPpUfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722463749; c=relaxed/simple;
	bh=hJeEqDpDH/4o/WacHdlLgqlv02ytkIoHPNq791SQpY0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SI10MgSjdBWAEStAIfkdV/LQY0UrWGLtO2urNv3Uj/5qgdGKGQuU0jcuh7VsNwidNTNvDcPDMy0EUwLdI43RwH57D9Nn8sgZbgDolcZBFLeSQQRPw76Gt+NUC42ODtD7ZMO4NSCoXTxCvMbOYK6HnzbXGxHp+94zWkbDm4tO7SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=PxUwTEJy; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PxUwTEJy"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id EDA832784A;
	Wed, 31 Jul 2024 18:09:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=hJeEqDpDH/4o/WacHdlLgqlv02ytkIoHPNq791
	SQpY0=; b=PxUwTEJytZEOf9FigUBGc32fZaVz2r6i91mnK6N00m0F4MCsq8dqKe
	E5kIKrlRZXxN1hhcwtkRfr/QqQf3R/Es1Db3m48NnAdO0znR2tnwoG27TR1skm6p
	7Gnxr8X/wxuv1OPaGqQmnClocPcEdT/FWgZEsdUgRHWE3jUUWOxHk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id E6F7527846;
	Wed, 31 Jul 2024 18:09:00 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0DD5F27841;
	Wed, 31 Jul 2024 18:08:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>,
    "brian m. carlson" <sandals@crustytoothpaste.net>,
    "W. Michael Petullo" <mike@flyn.org>
Subject: Re: Git clone reads safe.directory differently?
In-Reply-To: <xmqqo76d7coa.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
	31 Jul 2024 09:23:49 -0700")
References: <ZqUc8DJ1uKcHYlcy@imp.flyn.org>
	<20240727215845.GA1263246@coredump.intra.peff.net>
	<ZqZjRMqpEV_3WIkD@imp.flyn.org>
	<20240728224807.GA1299337@coredump.intra.peff.net>
	<ZqjQi6i2kiY4gcc1@imp.flyn.org>
	<Zqlo-i8uCb1Yr4Jm@tapette.crustytoothpaste.net>
	<xmqqv80m8pha.fsf@gitster.g>
	<ZqlxtGIyz0G9jlJr@tapette.crustytoothpaste.net>
	<20240731072832.GB595974@coredump.intra.peff.net>
	<xmqqo76d7coa.fsf@gitster.g>
Date: Wed, 31 Jul 2024 15:08:55 -0700
Message-ID: <xmqq1q391afc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 7B5F0CD6-4F89-11EF-9F1C-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> So we probably need to add another axis to the "strict" parameter
> enter_repo() takes to selectively disable the ownership checks only
> for upload-pack, or something like that.

So, here is a rough sketch for the above.  Interested parties may
build on top of it, perhaps by adding separate knobs to loosen or
tighten the second parameter given to enter_repo() at different
callsites, by writing tests to make sure they work as intended, and
by documenting the security story around it none of which I do here
;-).

The two bits are

 - ENTER_REPO_STRICT: callers that require exact paths (as opposed
   to allowing known suffixes like ".git", ".git/.git" to be
   omitted) can set this bit.  Corresponds to the "strict" parameter
   that the flags wordreplaces.

 - ENTER_REPO_ANY_OWNER_OK: callers that are willing to run without
   ownership check can set this bit.

The former is --strict-paths option of "git daemon".  The latter is
set only by upload-pack, but you may want to add configuration knobs
in protected configuration files to loosen it per callsites.

 builtin/upload-pack.c |  5 ++++-
 daemon.c              |  6 ++++--
 path.c                | 10 ++++++----
 path.h                |  7 ++++++-
 4 files changed, 20 insertions(+), 8 deletions(-)

diff --git c/builtin/upload-pack.c w/builtin/upload-pack.c
index 46d93278d9..fe50ce3eed 100644
--- c/builtin/upload-pack.c
+++ w/builtin/upload-pack.c
@@ -36,6 +36,7 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 			    N_("interrupt transfer after <n> seconds of inactivity")),
 		OPT_END()
 	};
+	unsigned enter_repo_flags = ENTER_REPO_ANY_OWNER_OK;
 
 	packet_trace_identity("upload-pack");
 	disable_replace_refs();
@@ -51,7 +52,9 @@ int cmd_upload_pack(int argc, const char **argv, const char *prefix)
 
 	dir = argv[0];
 
-	if (!enter_repo(dir, strict))
+	if (strict)
+		enter_repo_flags |= ENTER_REPO_STRICT;
+	if (!enter_repo(dir, enter_repo_flags))
 		die("'%s' does not appear to be a git repository", dir);
 
 	switch (determine_protocol_version_server()) {
diff --git c/daemon.c w/daemon.c
index 17d331b2f3..fb37135521 100644
--- c/daemon.c
+++ w/daemon.c
@@ -149,6 +149,7 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 	size_t rlen;
 	const char *path;
 	const char *dir;
+	unsigned enter_repo_flags;
 
 	dir = directory;
 
@@ -239,14 +240,15 @@ static const char *path_ok(const char *directory, struct hostinfo *hi)
 		dir = rpath;
 	}
 
-	path = enter_repo(dir, strict_paths);
+	enter_repo_flags = strict_paths ? ENTER_REPO_STRICT : 0;
+	path = enter_repo(dir, enter_repo_flags);
 	if (!path && base_path && base_path_relaxed) {
 		/*
 		 * if we fail and base_path_relaxed is enabled, try without
 		 * prefixing the base path
 		 */
 		dir = directory;
-		path = enter_repo(dir, strict_paths);
+		path = enter_repo(dir, enter_repo_flags);
 	}
 
 	if (!path) {
diff --git c/path.c w/path.c
index 19f7684f38..df5aefdb8f 100644
--- c/path.c
+++ w/path.c
@@ -727,7 +727,7 @@ char *interpolate_path(const char *path, int real_home)
  * links.  User relative paths are also returned as they are given,
  * except DWIM suffixing.
  */
-const char *enter_repo(const char *path, int strict)
+const char *enter_repo(const char *path, unsigned flags)
 {
 	static struct strbuf validated_path = STRBUF_INIT;
 	static struct strbuf used_path = STRBUF_INIT;
@@ -735,7 +735,7 @@ const char *enter_repo(const char *path, int strict)
 	if (!path)
 		return NULL;
 
-	if (!strict) {
+	if (!(flags & ENTER_REPO_STRICT)) {
 		static const char *suffix[] = {
 			"/.git", "", ".git/.git", ".git", NULL,
 		};
@@ -779,7 +779,8 @@ const char *enter_repo(const char *path, int strict)
 		if (!suffix[i])
 			return NULL;
 		gitfile = read_gitfile(used_path.buf);
-		die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
+		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
+			die_upon_dubious_ownership(gitfile, NULL, used_path.buf);
 		if (gitfile) {
 			strbuf_reset(&used_path);
 			strbuf_addstr(&used_path, gitfile);
@@ -790,7 +791,8 @@ const char *enter_repo(const char *path, int strict)
 	}
 	else {
 		const char *gitfile = read_gitfile(path);
-		die_upon_dubious_ownership(gitfile, NULL, path);
+		if (!(flags & ENTER_REPO_ANY_OWNER_OK))
+			die_upon_dubious_ownership(gitfile, NULL, path);
 		if (gitfile)
 			path = gitfile;
 		if (chdir(path))
diff --git c/path.h w/path.h
index a6f0b70692..a0021a1425 100644
--- c/path.h
+++ w/path.h
@@ -187,7 +187,12 @@ int calc_shared_perm(int mode);
 int adjust_shared_perm(const char *path);
 
 char *interpolate_path(const char *path, int real_home);
-const char *enter_repo(const char *path, int strict);
+
+enum {
+	ENTER_REPO_STRICT = (1<<0),
+	ENTER_REPO_ANY_OWNER_OK = (1<<1),
+};
+const char *enter_repo(const char *path, unsigned flags);
 const char *remove_leading_path(const char *in, const char *prefix);
 const char *relative_path(const char *in, const char *prefix, struct strbuf *sb);
 int normalize_path_copy_len(char *dst, const char *src, int *prefix_len);
