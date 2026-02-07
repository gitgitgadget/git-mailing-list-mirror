Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DF61E515
	for <git@vger.kernel.org>; Sat,  7 Feb 2026 21:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770500310; cv=none; b=TfVJcRVmSKQAf7GdBa5BQxljJyZIKDvNSQ0+XiabccF9V0oabfvSFpOrFeN1+EsX1xUfj3PUQUCkTVzbA76V01Woa4pKfHLA3p4q8VGllbCTE7UZ+ONHHGFUrdxTz2sH4IHEo+Ncq/H5qRhQ3dHv7iuUP0B5cC5Sg0OCIdCgq8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770500310; c=relaxed/simple;
	bh=jLLWluFfvvh0GY5Ft8Qf9nWpyFUqaj+9886NK2F1Cp8=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=qaWiBkIzIHGERTVbaB4L0lC6f6963sI/TrJtFYtjVjtQhBZIDq0eepfnT9aiaw0Qutp+LKbeVhGrnBKS0BLMQ/v+WjzUKUf8uO5Z/J8OaX6GMM2lGbSEiQcKchzrdDVLiLKrbsnALj3z62+KuRqT5zwuGRPeCUUibU8TwhuHKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=uSR2zK4F; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="uSR2zK4F"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4f7kpf3STGz9sxM;
	Sat,  7 Feb 2026 22:38:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1770500298;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w6cVA2g18qfW/9axGNwtpNqktiDJenRHR5NrKGTGdNE=;
	b=uSR2zK4FsEbwwN5Z7VjsuEiBf0vMjJS3aTTKRbOv0QN5TxmIcilhMJh4HK2RZl+Y6W3Q86
	58k191fhnvCHatvDn7TVbOyFjTOH7AhLbYTuGdb9mmgVdH9fkaPaduu0oc8KSJmviZYfP5
	i1RbWwY4efMoYsixc/PxVDC5Eea/rCyBi/TAQR4KBKGfip/YKGK1fIqBlfoST67nQmgrme
	3hYp4yISzpMNBGTxnFEgPprNKgXMf+NV+IufK08cyKTi3fph5YA/kD5f/ST4sE3L49h8Am
	4wDZUfMOR047XJ8ZJLB6IMsM5aVHdORaycoMpRMpOd7qsBw1sns/4JYYsL9euA==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
 repository
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <75AA7DD7-F8D8-48DC-ADA0-74E56CFF351D@ytausch.de>
Date: Sat, 7 Feb 2026 22:37:48 +0100
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 git@vger.kernel.org,
 Manuel Lerchner <manuel.lerchner@quantco.com>,
 Yannik Tausch <yannik.tausch@quantco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3488DCC3-D127-465B-BB95-3D87BB2E48F6@ytausch.de>
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
 <xmqq4invm2dk.fsf@gitster.g>
 <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
 <fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
 <D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>
 <xmqqqzqxczeb.fsf@gitster.g>
 <75AA7DD7-F8D8-48DC-ADA0-74E56CFF351D@ytausch.de>
To: Junio C Hamano <gitster@pobox.com>
X-Rspamd-Queue-Id: 4f7kpf3STGz9sxM

When running outside a repository, git merge-file ignores the
merge.conflictStyle configuration variable entirely. Since the
function receives `repo` from the caller (which is NULL outside a
repository), and repo_config() falls back to reading system and user
configuration when passed NULL, pass `repo` to repo_config()
unconditionally.

Also document that merge.conflictStyle is honored.

Signed-off-by: Yannik Tausch <dev@ytausch.de>
---

Notes:
   Changes since v1:
   - Use repo parameter directly with repo_config() (Junio)
   - Fix AsciiDoc continuation, rename test files, break long
     lines (Kristoffer)

 Documentation/git-merge-file.adoc |  3 +++
 builtin/merge-file.c              | 12 +++++------
 t/t6403-merge-file.sh             | 36 +++++++++++++++++++++++++++++++
 3 files changed, 44 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-merge-file.adoc =
b/Documentation/git-merge-file.adoc
index 71915a00fa..9dc5d8a370 100644
--- a/Documentation/git-merge-file.adoc
+++ b/Documentation/git-merge-file.adoc
@@ -85,6 +85,9 @@ object store and the object ID of its blob is written =
to standard output.
=20
 --zdiff3::
 	Show conflicts in "zdiff3" style.
++
+The `--diff3` and `--zdiff3` options default to the value of the
+`merge.conflictStyle` configuration variable (see =
linkgit:git-config[1]).
=20
 --ours::
 --theirs::
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 46775d0c79..f9de636884 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -60,7 +60,7 @@ static int diff_algorithm_cb(const struct option *opt,
 int cmd_merge_file(int argc,
 		   const char **argv,
 		   const char *prefix,
-		   struct repository *repo UNUSED)
+		   struct repository *repo)
 {
 	const char *names[3] =3D { 0 };
 	mmfile_t mmfs[3] =3D { 0 };
@@ -95,12 +95,10 @@ int cmd_merge_file(int argc,
 	xmp.style =3D 0;
 	xmp.favor =3D 0;
=20
-	if (startup_info->have_repository) {
-		/* Read the configuration file */
-		repo_config(the_repository, git_xmerge_config, NULL);
-		if (0 <=3D git_xmerge_style)
-			xmp.style =3D git_xmerge_style;
-	}
+	/* Read the configuration file */
+	repo_config(repo, git_xmerge_config, NULL);
+	if (0 <=3D git_xmerge_style)
+		xmp.style =3D git_xmerge_style;
=20
 	argc =3D parse_options(argc, argv, prefix, options, =
merge_file_usage, 0);
 	if (argc !=3D 3)
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 06ab4d7aed..4d6e748320 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -428,6 +428,42 @@ test_expect_success '"diff3 -m" style output (2)' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'merge.conflictStyle honored outside repo' '
+	test_config_global merge.conflictStyle diff3 &&
+	cat >nongit-base <<-\EOF &&
+	line1
+	original
+	line3
+	EOF
+	cat >nongit-ours <<-\EOF &&
+	line1
+	ours
+	line3
+	EOF
+	cat >nongit-theirs <<-\EOF &&
+	line1
+	theirs
+	line3
+	EOF
+	cat >expect <<-\EOF &&
+	line1
+	<<<<<<< ours
+	ours
+	||||||| base
+	original
+	=3D=3D=3D=3D=3D=3D=3D
+	theirs
+	>>>>>>> theirs
+	line3
+	EOF
+	test_must_fail nongit git merge-file -p \
+		-L ours -L base -L theirs \
+		"$PWD/nongit-ours" \
+		"$PWD/nongit-base" \
+		"$PWD/nongit-theirs" >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'marker size' '
 	cat >expect <<-\EOF &&
 	Dominus regit me,
--=20
2.52.0

