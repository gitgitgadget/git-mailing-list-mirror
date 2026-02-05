Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876672FC893
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 21:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770328576; cv=none; b=tulTSYOSwelnOu6D9x06ltfFcyw+BYNGjxVFRM0+KvatPYYMYE/fhLX9huJHGkV8jBIqO51bQY9s8vG+JUKzg4yUKxJuWxqnICflvzNtNV7RRmvzPOMkGJS/1kxqjmMHbBYs5TO/OGkBPMPjCDf/u/G9KjKLg/7FdrnTtA2jVL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770328576; c=relaxed/simple;
	bh=NM5HlZaWfoV5eQFHLcCm/u+hEUTYKx3ZeMKjRF2khsc=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=Ei4IFOTnQPmPEskv1w1dw73AQDWo4jxVJDqZuQ+FmeHazIt4EOdieh8tFwBUIziJ0Wr8yVaGZPv0mnhyoKxN+9J2NF1OYh1kBz4km6XIbIkmdJdP6gDQZpDZxgcsCEQzrN9J0L+FoWj7ilSXo0ZVN49aJ43D+JkKaPRa6XqTX5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=EnM+s6Eb; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="EnM+s6Eb"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4f6WJC6hwgz9vSF;
	Thu,  5 Feb 2026 22:56:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1770328572;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YNH4uK9fKvtqotRtt3eCUzRtkkIAXqvqFgjGffdoQpo=;
	b=EnM+s6EbiOeU/0tVtOhSabnlW/0+mFOq/X/+ui/U2MiIM2nf6MwBNAhpiH04Dq9pc9vOnr
	1B13wM+9oyACpM56h8EIvwOL1cVO6wY1KB7iPgMVP58jGhCfZmDJ0d2Avu3AaU/8gYz44T
	DLxYCE6kElkIckZf+L55AzDI1Uue36kYE/nc40EyEgxdoS/poWdbGg4FzGnoCJJvaTq+PG
	Q4VzR2L1qU6g+rg0rxfv1kiUUREHUWdSq1J6FpuEbA5JMScEsmO4uVGrMUGBJfPt6gNHD7
	3RM3JYCjEV17400H1qt3oUk8J+ixLz41Id9Usk6uKX99qtDsEkcv0UFCxEWW6A==
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: Re: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
 repository
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
Date: Thu, 5 Feb 2026 22:55:58 +0100
Cc: git@vger.kernel.org,
 Manuel Lerchner <manuel.lerchner@quantco.com>,
 Yannik Tausch <yannik.tausch@quantco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <D514F3BA-36DD-4DAD-BF73-609730390A27@ytausch.de>
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
 <xmqq4invm2dk.fsf@gitster.g>
 <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
 <fa7fc215-03eb-492d-9af4-457482c56a48@app.fastmail.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
 gitster@pobox.com

> Junio C Hamano <gitster@pobox.com> wrote:

> Wouldn't it suffice to unconditionally execute the body of the if
> (startup_info->have_repository) block to pass "repo" we obtained
> from the caller to repo_config() instead of the_repository?  The
> caller of this function passes us either the_repository or NULL and
> repo_config() does the very-early thing when passed NULL as the
> repo, signalling that we are outside a repository.

Jup, looks like I missed that. Implemented your suggestion!

> Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com> wrote:

> Preferably the message should discuss the code as it exists without =
the
> patch applied in the present tense. (SubmittingPatches present-tense)

Fixed!
>=20
>> read from system and user configuration files using
>> read_very_early_config(), so that users can set their preferred
>> conflict style globally and have it honored even outside a =
repository.
>=20
> The update to the documentation might merit an =E2=80=9Calso=E2=80=9D? =
I dunno.

Added!

> You need to replace this blank line with a `+` if you want this to be
> the second paragraph on this option.

Fixed!

> Some tests in this file already use the regular expect/actual but =
there
> are also many one-off names like expect.c/myers_output.c. I don=E2=80=99=
t
> understand why. But I=E2=80=99m just thinking out loud here.

I also don=E2=80=99t understand why, but considering your point, I =
don=E2=80=99t see a reason
to not use the regular expect/actual convention. Fixed.

> It seems you might as well break the lines for this command further =
with
> some `\` to get closer to the soft limit.

Done!

Here is the new patch:

=46rom 9fa437c70bfd328cfdfe9cfca982b49b70ad033f Mon Sep 17 00:00:00 2001
From: Yannik Tausch <dev@ytausch.de>
Date: Thu, 5 Feb 2026 21:09:52 +0100
Subject: [PATCH v2] merge-file: honor merge.conflictStyle outside of a
 repository

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



