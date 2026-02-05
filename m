Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0A732C937
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 20:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770323265; cv=none; b=anpHS+qjeC+uxnVk+k9pQYi8wnuPzw/Lwqrq7i4+y2T3oymXCotOELXa4CNIvRTF0Svz1Vf4JB7txAmV8VvoTPpqw5It6jaPK2r73JOW93Rmn/PlUsCQ7+B1B28b2UueaHg3e25LUx1/brsTUxzGE949KNVpzlS04bvN8UnJwX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770323265; c=relaxed/simple;
	bh=SpUDqDxD4cmnzV2kYWw4caHE2Ovkm9VKFSUaHc9f8/Q=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=SwPPNkvuKImSfwA0Pofh9MiH6yby27y7du7yiKOtAK2TDhLpNYoK9Afbsp8R7KW8YvdGcN1em2RYfa9/2ygAx5W+ATs3M/T60VmsNCYDznnkj0I9Dk3O20bGpvP0fxXGOxcRIy7DFNvXBga5c6KnC8skXkqWaBSPLOXkfKeFJ54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de; spf=pass smtp.mailfrom=ytausch.de; dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b=GQA94EhA; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ytausch.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ytausch.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ytausch.de header.i=@ytausch.de header.b="GQA94EhA"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4f6TKx6PXBz9tQk;
	Thu,  5 Feb 2026 21:27:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ytausch.de; s=MBO0001;
	t=1770323253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LQytuBk35YtXmrH08AFtK6JZB7vnIW1hEocuF4yQyRI=;
	b=GQA94EhA568Tr6W7B+nVsWXYF13Fu19IkfIHMymbbiAVHqfagYkKv0UBedhZ9l7mecNgo2
	5nLm0wB8IgIGUa/6SMWdgU09W2kNKzuFIWQ0czweKURQSlrvkr8EzPNkSJls1/+LoAwwDH
	lUm0zfUGm1zcuCYQ4USJnMUfK6UIRjc3DVNdemAXMkUsZfwNYndeQsLUj/4qWThvVfR+v0
	wsKB/dwUGu5SVLqioSdGOzHzGnbj5f3cwMfHzCfZ5w6k9Nqg6y8zM4wx7DirTzrrMnjl7Q
	jtugKj36urtKZR1PNQZki+Lw7f16THymtmq/RmuB58kL0//CNivTiQ79Z2Rhrw==
Authentication-Results: outgoing_mbo_mout;
	dkim=none;
	spf=pass (outgoing_mbo_mout: domain of dev@ytausch.de designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=dev@ytausch.de
Content-Type: text/plain;
	charset=us-ascii
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: [PATCH] merge-file: honor merge.conflictStyle outside of a repository
From: Yannik Tausch <dev@ytausch.de>
In-Reply-To: <xmqq4invm2dk.fsf@gitster.g>
Date: Thu, 5 Feb 2026 21:27:21 +0100
Cc: git@vger.kernel.org,
 Manuel Lerchner <manuel.lerchner@quantco.com>,
 Yannik Tausch <yannik.tausch@quantco.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <3724733C-FECB-47F5-841C-84DE9792332D@ytausch.de>
References: <48B1AA62-D7FF-439E-B770-1127E1EE0E79@ytausch.de>
 <xmqq4invm2dk.fsf@gitster.g>
To: Junio C Hamano <gitster@pobox.com>
X-Rspamd-Queue-Id: 4f6TKx6PXBz9tQk

> Junio C Hamano <gitster@pobox.com> writes:
>=20
> Yannik Tausch <dev@ytausch.de> writes:
>=20
>> We noticed that `git merge-file` only respects the =
`merge.conflictStyle`
>> configuration when run inside a repository. Outside a repository, the
>> setting is ignored and only the `--diff3`/`--zdiff3` flags work.
>>=20
>> Looking at the history, this appears to be intentional since =
b541248467
>> ("merge.conflictstyle: choose between merge and diff3 -m styles", =
2008),
>> which explicitly gates config reading on being inside a repository.
>>=20
>> This behavior surprised me, and I couldn't find it documented =
anywhere.
>> Would a small documentation patch to git-merge-file.txt be welcome,
>> noting that the config is only read when inside a repository?
>=20
> Or even better, teach the command to read (limited set of)
> configuration files.
>=20
> By definition, you cannot read from per-repository configuration
> file when working outside a repository, but these days we let our
> commands read configuration from system and personal configuration
> files, I think.  Back in 2008, it is understandable we couldn't.

Thanks for the suggestion. Here's a patch:

=46rom bed0035d38072c67e0be8eedb0cf98da936cbac6 Mon Sep 17 00:00:00 2001
From: Yannik Tausch <dev@ytausch.de>
Date: Thu, 5 Feb 2026 21:09:52 +0100
Subject: [PATCH] merge-file: honor merge.conflictStyle outside of a =
repository

When running outside a repository, git merge-file previously ignored
the merge.conflictStyle configuration variable entirely. Teach it to
read from system and user configuration files using
read_very_early_config(), so that users can set their preferred
conflict style globally and have it honored even outside a repository.

Signed-off-by: Yannik Tausch <dev@ytausch.de>
---
 Documentation/git-merge-file.adoc |  3 +++
 builtin/merge-file.c              | 11 +++++-----
 t/t6403-merge-file.sh             | 34 +++++++++++++++++++++++++++++++
 3 files changed, 43 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-merge-file.adoc =
b/Documentation/git-merge-file.adoc
index 71915a00fa..773037aa14 100644
--- a/Documentation/git-merge-file.adoc
+++ b/Documentation/git-merge-file.adoc
@@ -86,6 +86,9 @@ object store and the object ID of its blob is written =
to standard output.
 --zdiff3::
 	Show conflicts in "zdiff3" style.
=20
+The `--diff3` and `--zdiff3` options default to the value of the
+`merge.conflictStyle` configuration variable (see =
linkgit:git-config[1]).
+
 --ours::
 --theirs::
 --union::
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 46775d0c79..1b6e16b9cb 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -95,12 +95,13 @@ int cmd_merge_file(int argc,
 	xmp.style =3D 0;
 	xmp.favor =3D 0;
=20
-	if (startup_info->have_repository) {
-		/* Read the configuration file */
+	if (startup_info->have_repository)
 		repo_config(the_repository, git_xmerge_config, NULL);
-		if (0 <=3D git_xmerge_style)
-			xmp.style =3D git_xmerge_style;
-	}
+	else
+		read_very_early_config(git_xmerge_config, NULL);
+
+	if (0 <=3D git_xmerge_style)
+		xmp.style =3D git_xmerge_style;
=20
 	argc =3D parse_options(argc, argv, prefix, options, =
merge_file_usage, 0);
 	if (argc !=3D 3)
diff --git a/t/t6403-merge-file.sh b/t/t6403-merge-file.sh
index 06ab4d7aed..9df9f878c8 100755
--- a/t/t6403-merge-file.sh
+++ b/t/t6403-merge-file.sh
@@ -428,6 +428,40 @@ test_expect_success '"diff3 -m" style output (2)' '
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
+	cat >nongit-expect <<-\EOF &&
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
+		"$PWD/nongit-ours" "$PWD/nongit-base" =
"$PWD/nongit-theirs" >nongit-actual &&
+	test_cmp nongit-expect nongit-actual
+'
+
 test_expect_success 'marker size' '
 	cat >expect <<-\EOF &&
 	Dominus regit me,
--=20
2.52.0

