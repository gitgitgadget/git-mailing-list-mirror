Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F20D71CBEA6
	for <git@vger.kernel.org>; Wed, 18 Sep 2024 23:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726702116; cv=none; b=XOT1EaiJ/yZRAyn9mBLUG2RCsVNuKjcyoZcxl3BfZ1p49LCFkTvEzNX0woxItkqoOxL0SfX8tWM9fkDsVj302d7AWnQSDFtOBSRH56L9efwwqWyPOzXDt2LLs/aGbA9nOdUWrEr4/ov9wma6O+aGSw5qL+BAKd18ZvEEynYgUio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726702116; c=relaxed/simple;
	bh=IcWJqzdNCuAVV1ubr0fLfLkONXw37nYvbq7OhPIXWOw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KQL7SR/iqky94651ZFUHQdgJwcfjaPX6pYF1Hzyh7BFHOhWzSkUu/z/puWUjjEiMhJ1dC2KYRAMDBClRb6z02bgIPiX8NpswlVhKF+d31J65OiM7AKbW8vjG+sOcUmIP+Iue7e0BSgxHWUGwWi5cV62W4PAgJwL0LTMAxLrylLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=doGTWpVF; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="doGTWpVF"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D4578354A2;
	Wed, 18 Sep 2024 19:28:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references:mime-version
	:content-transfer-encoding; s=sasl; bh=IcWJqzdNCuAVV1ubr0fLfLkON
	Xw37nYvbq7OhPIXWOw=; b=doGTWpVFZWZZiPp3Eofed0O3wY/pS5c4s4FWpgugl
	JcztZrWrLI/k36VVyadQfY6TnKPZClgz4MP/QFIU7GPEgJHug6HQhpibH+89fHra
	SMPMOD3z3K56EOhgnliO3JiJa23qfh+p41J7gVI4toMk6jWKTDFrCdcvdpHptJ38
	f8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CC892354A1;
	Wed, 18 Sep 2024 19:28:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 452473549F;
	Wed, 18 Sep 2024 19:28:33 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 4/4] refs: remove the last remnants of core.preferSymlinkRefs
Date: Wed, 18 Sep 2024 16:28:25 -0700
Message-ID: <20240918232825.2627999-5-gitster@pobox.com>
X-Mailer: git-send-email 2.46.1-742-g4240f61078
In-Reply-To: <20240918232825.2627999-1-gitster@pobox.com>
References: <20240918232825.2627999-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Pobox-Relay-ID:
 B876DF2E-7615-11EF-9332-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

This step is for some time after Git 3.0.

Now it is almost N years since we removed the support for the
variable at Git 3.0 boundary, it is time to remove the warning about
this ancient variable and the behaviour change we went through with
it.

This concludes the journey to make sure we no longer create a
symbolic link to represent a symref, while still recognising
existing ones.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/config/core.txt |  5 -----
 config.c                      |  5 -----
 environment.c                 |  1 -
 environment.h                 |  1 -
 refs/files-backend.c          |  5 -----
 t/t0600-reffiles-backend.sh   | 15 ++-------------
 6 files changed, 2 insertions(+), 30 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.tx=
t
index a6f67cab27..1887da78e3 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -285,11 +285,6 @@ CIFS/Microsoft Windows.
 +
 False by default.
=20
-core.preferSymlinkRefs (removed)::
-	Instead of the default "symref" format for HEAD and other
-	symbolic reference files, use symbolic links.  The support
-	for this variable was dropped in Git 3.0.
-
 core.alternateRefsCommand::
 	When advertising tips of available history from an alternate, use the s=
hell to
 	execute the specified command instead of linkgit:git-for-each-ref[1]. T=
he
diff --git a/config.c b/config.c
index 56b5862e59..8693cd510d 100644
--- a/config.c
+++ b/config.c
@@ -1445,11 +1445,6 @@ static int git_default_core_config(const char *var=
, const char *value,
 		return 0;
 	}
=20
-	if (!strcmp(var, "core.prefersymlinkrefs")) {
-		prefer_symlink_refs =3D git_config_bool(var, value);
-		return 0;
-	}
-
 	if (!strcmp(var, "core.logallrefupdates")) {
 		if (value && !strcasecmp(value, "always"))
 			log_all_ref_updates =3D LOG_REFS_ALWAYS;
diff --git a/environment.c b/environment.c
index 1d6c48b52d..2c3a60149b 100644
--- a/environment.c
+++ b/environment.c
@@ -40,7 +40,6 @@ int has_symlinks =3D 1;
 int minimum_abbrev =3D 4, default_abbrev =3D -1;
 int ignore_case;
 int assume_unchanged;
-int prefer_symlink_refs;
 int is_bare_repository_cfg =3D -1; /* unspecified */
 int warn_ambiguous_refs =3D 1;
 int warn_on_object_refname_ambiguity =3D 1;
diff --git a/environment.h b/environment.h
index 0148738ed6..6b595bd210 100644
--- a/environment.h
+++ b/environment.h
@@ -127,7 +127,6 @@ extern int has_symlinks;
 extern int minimum_abbrev, default_abbrev;
 extern int ignore_case;
 extern int assume_unchanged;
-extern int prefer_symlink_refs;
 extern int warn_ambiguous_refs;
 extern int warn_on_object_refname_ambiguity;
 extern char *apply_default_whitespace;
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 1296272252..eef01fee06 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -2983,11 +2983,6 @@ static int files_transaction_finish(struct ref_sto=
re *ref_store,
 			}
 		}
=20
-		/* Warn against core.preferSymlinkRefs set to true */
-		if (update->new_target && prefer_symlink_refs)
-			/* we used to, but no longer, create a symlink here */
-			warning("core.preferSymlinkRefs was removed in Git 3.0");
-
 		if (update->flags & REF_NEEDS_COMMIT) {
 			clear_loose_ref_cache(refs);
 			if (commit_ref(lock)) {
diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
index 4e517cdc13..4db86757ac 100755
--- a/t/t0600-reffiles-backend.sh
+++ b/t/t0600-reffiles-backend.sh
@@ -480,22 +480,12 @@ test_expect_success SYMLINKS 'symlinks used as symr=
efs are still supported' '
 	test_cmp actual expect
 '
=20
-test_expect_success 'core.prefersymlinkrefs gets a warning' '
+test_expect_success 'core.prefersymlinkrefs no longer gets a warning' '
 	test_when_finished "git symbolic-ref -d TEST_SYMREF_HEAD || :" &&
 	git update-ref refs/heads/new HEAD &&
=20
 	test_config core.prefersymlinkrefs true &&
 	git symbolic-ref TEST_SYMREF_HEAD refs/heads/new 2>stderr &&
-	test_grep "core\.preferSymlinkRefs was removed" stderr &&
-
-	git symbolic-ref -d TEST_SYMREF_HEAD &&
-	git config core.prefersymlinkrefs false &&
-	git symbolic-ref TEST_SYMREF_HEAD refs/heads/new 2>stderr &&
-	test_grep ! "core\.preferSymlinkRefs was removed" stderr &&
-
-	git symbolic-ref -d TEST_SYMREF_HEAD &&
-	git config --unset core.prefersymlinkrefs &&
-	git symbolic-ref TEST_SYMREF_HEAD refs/heads/new 2>stderr &&
 	test_grep ! "core\.preferSymlinkRefs was removed" stderr
 '
=20
@@ -512,8 +502,7 @@ test_expect_success 'symref transaction' '
 	test_path_is_file .git/TEST_SYMREF_HEAD &&
 	git symbolic-ref TEST_SYMREF_HEAD >actual &&
 	echo refs/heads/new >expect &&
-	test_cmp expect actual &&
-	test_grep ! "core\.preferSymlinkRefs was removed" stderr
+	test_cmp expect actual
 '
=20
 test_done
--=20
2.46.1-742-g4240f61078

