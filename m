Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBF3E42ABE
	for <git@vger.kernel.org>; Fri, 24 May 2024 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716580068; cv=none; b=Y2oPipatppNiMaRwA6wHbtqYCqPX9AXpRrQXYBSUtGstX02Z2hsnopwdQ/VgqegcKEVU1nvVE75gbijAYA/omww6gID9qc2bkECgC5Xp0bPM1nmcYW6nH58wQ4OlqifVrKL5Axbn5BEMkbdOkW1xVg6LwMl+YxS1VlCdqRscduw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716580068; c=relaxed/simple;
	bh=W2Ekx/nKXOpu/DWRVJH8tiwaMOQQxwcHUrL++fHOwa8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rVDQWcfr7aIdsPPoL3HNjCAQOJAZORc03jd0wCx9idlG7uAoP3B8o/zqc9aGZDc2DbOsdm2cz+qCY3Z6LAFIeN7sOQ+57vGmdRjp/WKu9lx1M/G/R/rsPKhKFrxeDqGeZtxzrrXSw364UyYtGacFaFiMRjoUOCBqg+jV2N68eVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=jZkFMXLA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="jZkFMXLA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B138276E9;
	Fri, 24 May 2024 15:47:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=W2Ekx/nKXOpu/DWRVJH8tiwaM
	OQQxwcHUrL++fHOwa8=; b=jZkFMXLA5AlL1LpVsUTFAbUnRo9NFaw4T1uxlxEWn
	1npEslZ8r0RvJL7iQeJcB7pOQ3YPcTPNM3JYERAB/KHOA0pwKtm+uRNE5iM2mbFc
	Irj+VB0F/p1oIDaA+cS+lt9fIpb7RE/L+N32uti/H56nhWZdf23xGXFut2X+isFy
	sg=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 630FE276E8;
	Fri, 24 May 2024 15:47:46 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.173.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 83F1C276E5;
	Fri, 24 May 2024 15:47:43 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH v2 12/12] Revert "fsck: warn about symlink pointing inside a gitdir"
Date: Fri, 24 May 2024 12:47:15 -0700
Message-ID: <20240524194715.695916-13-gitster@pobox.com>
X-Mailer: git-send-email 2.45.1-246-gb9cfe4845c
In-Reply-To: <20240524194715.695916-1-gitster@pobox.com>
References: <20240524194715.695916-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 7CAB83CA-1A06-11EF-A4F3-F515D2CDFF5E-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable

This reverts commit a33fea08 (fsck: warn about symlink pointing
inside a gitdir, 2024-04-10), which warns against symbolic links
commonly created by git-annex.
---
 Documentation/fsck-msgids.txt | 12 --------
 fsck.c                        | 56 -----------------------------------
 fsck.h                        | 12 --------
 t/t1450-fsck.sh               | 37 -----------------------
 4 files changed, 117 deletions(-)

diff --git a/Documentation/fsck-msgids.txt b/Documentation/fsck-msgids.tx=
t
index b06ec385af..12eae8a222 100644
--- a/Documentation/fsck-msgids.txt
+++ b/Documentation/fsck-msgids.txt
@@ -157,18 +157,6 @@
 `nullSha1`::
 	(WARN) Tree contains entries pointing to a null sha1.
=20
-`symlinkPointsToGitDir`::
-	(WARN) Symbolic link points inside a gitdir.
-
-`symlinkTargetBlob`::
-	(ERROR) A non-blob found instead of a symbolic link's target.
-
-`symlinkTargetLength`::
-	(WARN) Symbolic link target longer than maximum path length.
-
-`symlinkTargetMissing`::
-	(ERROR) Unable to read symbolic link target's blob.
-
 `treeNotSorted`::
 	(ERROR) A tree is not properly sorted.
=20
diff --git a/fsck.c b/fsck.c
index b85868e122..47eaeedd70 100644
--- a/fsck.c
+++ b/fsck.c
@@ -636,8 +636,6 @@ static int fsck_tree(const struct object_id *tree_oid=
,
 				retval +=3D report(options, tree_oid, OBJ_TREE,
 						 FSCK_MSG_MAILMAP_SYMLINK,
 						 ".mailmap is a symlink");
-			oidset_insert(&options->symlink_targets_found,
-				      entry_oid);
 		}
=20
 		if ((backslash =3D strchr(name, '\\'))) {
@@ -1230,56 +1228,6 @@ static int fsck_blob(const struct object_id *oid, =
const char *buf,
 		}
 	}
=20
-	if (oidset_contains(&options->symlink_targets_found, oid)) {
-		const char *ptr =3D buf;
-		const struct object_id *reported =3D NULL;
-
-		oidset_insert(&options->symlink_targets_done, oid);
-
-		if (!buf || size > PATH_MAX) {
-			/*
-			 * A missing buffer here is a sign that the caller found the
-			 * blob too gigantic to load into memory. Let's just consider
-			 * that an error.
-			 */
-			return report(options, oid, OBJ_BLOB,
-					FSCK_MSG_SYMLINK_TARGET_LENGTH,
-					"symlink target too long");
-		}
-
-		while (!reported && ptr) {
-			const char *p =3D ptr;
-			char c, *slash =3D strchrnul(ptr, '/');
-			char *backslash =3D memchr(ptr, '\\', slash - ptr);
-
-			c =3D *slash;
-			*slash =3D '\0';
-
-			while (!reported && backslash) {
-				*backslash =3D '\0';
-				if (is_ntfs_dotgit(p))
-					ret |=3D report(options, reported =3D oid, OBJ_BLOB,
-						      FSCK_MSG_SYMLINK_POINTS_TO_GIT_DIR,
-						      "symlink target points to git dir");
-				*backslash =3D '\\';
-				p =3D backslash + 1;
-				backslash =3D memchr(p, '\\', slash - p);
-			}
-			if (!reported && is_ntfs_dotgit(p))
-				ret |=3D report(options, reported =3D oid, OBJ_BLOB,
-					      FSCK_MSG_SYMLINK_POINTS_TO_GIT_DIR,
-					      "symlink target points to git dir");
-
-			if (!reported && is_hfs_dotgit(ptr))
-				ret |=3D report(options, reported =3D oid, OBJ_BLOB,
-					      FSCK_MSG_SYMLINK_POINTS_TO_GIT_DIR,
-					      "symlink target points to git dir");
-
-			*slash =3D c;
-			ptr =3D c ? slash + 1 : NULL;
-		}
-	}
-
 	return ret;
 }
=20
@@ -1371,10 +1319,6 @@ int fsck_finish(struct fsck_options *options)
 			  FSCK_MSG_GITATTRIBUTES_MISSING, FSCK_MSG_GITATTRIBUTES_BLOB,
 			  options, ".gitattributes");
=20
-	ret |=3D fsck_blobs(&options->symlink_targets_found, &options->symlink_=
targets_done,
-			  FSCK_MSG_SYMLINK_TARGET_MISSING, FSCK_MSG_SYMLINK_TARGET_BLOB,
-			  options, "<symlink-target>");
-
 	return ret;
 }
=20
diff --git a/fsck.h b/fsck.h
index 130fa8d8f9..fcecf4101c 100644
--- a/fsck.h
+++ b/fsck.h
@@ -63,8 +63,6 @@ enum fsck_msg_type {
 	FUNC(GITATTRIBUTES_LARGE, ERROR) \
 	FUNC(GITATTRIBUTES_LINE_LENGTH, ERROR) \
 	FUNC(GITATTRIBUTES_BLOB, ERROR) \
-	FUNC(SYMLINK_TARGET_MISSING, ERROR) \
-	FUNC(SYMLINK_TARGET_BLOB, ERROR) \
 	/* warnings */ \
 	FUNC(EMPTY_NAME, WARN) \
 	FUNC(FULL_PATHNAME, WARN) \
@@ -74,8 +72,6 @@ enum fsck_msg_type {
 	FUNC(NULL_SHA1, WARN) \
 	FUNC(ZERO_PADDED_FILEMODE, WARN) \
 	FUNC(NUL_IN_COMMIT, WARN) \
-	FUNC(SYMLINK_TARGET_LENGTH, WARN) \
-	FUNC(SYMLINK_POINTS_TO_GIT_DIR, WARN) \
 	/* infos (reported as warnings, but ignored by default) */ \
 	FUNC(BAD_FILEMODE, INFO) \
 	FUNC(GITMODULES_PARSE, INFO) \
@@ -143,8 +139,6 @@ struct fsck_options {
 	struct oidset gitmodules_done;
 	struct oidset gitattributes_found;
 	struct oidset gitattributes_done;
-	struct oidset symlink_targets_found;
-	struct oidset symlink_targets_done;
 	kh_oid_map_t *object_names;
 };
=20
@@ -154,8 +148,6 @@ struct fsck_options {
 	.gitmodules_done =3D OIDSET_INIT, \
 	.gitattributes_found =3D OIDSET_INIT, \
 	.gitattributes_done =3D OIDSET_INIT, \
-	.symlink_targets_found =3D OIDSET_INIT, \
-	.symlink_targets_done =3D OIDSET_INIT, \
 	.error_func =3D fsck_error_function \
 }
 #define FSCK_OPTIONS_STRICT { \
@@ -164,8 +156,6 @@ struct fsck_options {
 	.gitmodules_done =3D OIDSET_INIT, \
 	.gitattributes_found =3D OIDSET_INIT, \
 	.gitattributes_done =3D OIDSET_INIT, \
-	.symlink_targets_found =3D OIDSET_INIT, \
-	.symlink_targets_done =3D OIDSET_INIT, \
 	.error_func =3D fsck_error_function, \
 }
 #define FSCK_OPTIONS_MISSING_GITMODULES { \
@@ -174,8 +164,6 @@ struct fsck_options {
 	.gitmodules_done =3D OIDSET_INIT, \
 	.gitattributes_found =3D OIDSET_INIT, \
 	.gitattributes_done =3D OIDSET_INIT, \
-	.symlink_targets_found =3D OIDSET_INIT, \
-	.symlink_targets_done =3D OIDSET_INIT, \
 	.error_func =3D fsck_error_cb_print_missing_gitmodules, \
 }
=20
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5669872bc8..de0f6d5e7f 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -1023,41 +1023,4 @@ test_expect_success 'fsck error on gitattributes w=
ith excessive size' '
 	test_cmp expected actual
 '
=20
-test_expect_success 'fsck warning on symlink target with excessive lengt=
h' '
-	symlink_target=3D$(printf "pattern %032769d" 1 | git hash-object -w --s=
tdin) &&
-	test_when_finished "remove_object $symlink_target" &&
-	tree=3D$(printf "120000 blob %s\t%s\n" $symlink_target symlink | git mk=
tree) &&
-	test_when_finished "remove_object $tree" &&
-	cat >expected <<-EOF &&
-	warning in blob $symlink_target: symlinkTargetLength: symlink target to=
o long
-	EOF
-	git fsck --no-dangling >actual 2>&1 &&
-	test_cmp expected actual
-'
-
-test_expect_success 'fsck warning on symlink target pointing inside git =
dir' '
-	gitdir=3D$(printf ".git" | git hash-object -w --stdin) &&
-	ntfs_gitdir=3D$(printf "GIT~1" | git hash-object -w --stdin) &&
-	hfs_gitdir=3D$(printf ".${u200c}git" | git hash-object -w --stdin) &&
-	inside_gitdir=3D$(printf "nested/.git/config" | git hash-object -w --st=
din) &&
-	benign_target=3D$(printf "legit/config" | git hash-object -w --stdin) &=
&
-	tree=3D$(printf "120000 blob %s\t%s\n" \
-		$benign_target benign_target \
-		$gitdir gitdir \
-		$hfs_gitdir hfs_gitdir \
-		$inside_gitdir inside_gitdir \
-		$ntfs_gitdir ntfs_gitdir |
-		git mktree) &&
-	for o in $gitdir $ntfs_gitdir $hfs_gitdir $inside_gitdir $benign_target=
 $tree
-	do
-		test_when_finished "remove_object $o" || return 1
-	done &&
-	printf "warning in blob %s: symlinkPointsToGitDir: symlink target point=
s to git dir\n" \
-		$gitdir $hfs_gitdir $inside_gitdir $ntfs_gitdir |
-	sort >expected &&
-	git fsck --no-dangling >actual 2>&1 &&
-	sort actual >actual.sorted &&
-	test_cmp expected actual.sorted
-'
-
 test_done
--=20
2.45.1-246-gb9cfe4845c

