Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9291717996
	for <git@vger.kernel.org>; Tue, 26 Nov 2024 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732585917; cv=none; b=ucRglkhU7z9DHl7rLKkj/3PRk/48J6cAblwC6eQ2p7ElUmQN2Ni4WdUfUMusWeCETHCvDbBXBbV0Kfk254Rvfq1TvNb9ZFTbgmdB+Xl1edUzatYSclZVL+gnKbuNabqVINGyYXeC1PSZp62VDxRyG/6U+dQV6DZzcVQx5u+IwfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732585917; c=relaxed/simple;
	bh=8MxPZdn1L5978tfqkhcficZ+8i6hBfaQ8ew5JQtRmOM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NWVf3RnXDVfHQAXmp97yGdhKPjZHRvh6vrhC9O3X2hEvJjA15XvdeE7aXzwueDtXJGTpB5hPi/FHMuqWal8yvxTgEoIqTIx5uqLGbelUdUnRrutj5kdz+wH+wRP5rdAn3tpkKyPh5qPDDHsh4ElUKks4xwIRjZXAQVgij/OT7Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=oAt5lZgG; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="oAt5lZgG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732585907; x=1732845107;
	bh=nMqMaP/mEzs1WtgxDUhbCeyuGGDh1Au4R56Bq4fXY+g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=oAt5lZgGd+Bt1FB/s24EcCeSlXkV7TjmFkbsVosDWSt8IPKAW8kpjC6OkHLe+0HZo
	 9hJVCghLF4PMm+qfhvKgQHPyPVwDJSvaf+OJi3s4oFWbT5XbzBtYLq9UKo65gFVy/4
	 LCwRt9mRTOyrp/94t9Ky7miUefQp1ONhIjEy2GfBNVOJND70kRII2lNRDpGC0hfC5J
	 o3wIyIQv1nnvLC1GVQyZItzlnhZJHNxO9aNyti8k0Vto14SjH334C/s6MBR3Br4sKI
	 0R2AiNKy+ZG6ApV8mnsEbQb0mWUUKVd/78bpjmrCmQHp8OFvGsxZfJijc8222cv/6+
	 fl4rnSXxTWfqA==
Date: Tue, 26 Nov 2024 01:51:44 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Taylor Blau <me@ttaylorr.com>, Phillip Wood <phillip.wood123@gmail.com>, Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH v5 2/8] worktree: add `relativeWorktrees` extension
Message-ID: <20241125-wt_relative_options-v5-2-356d122ff3db@pm.me>
In-Reply-To: <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
References: <20241031-wt_relative_options-v4-0-07a3dc0f02a3@pm.me> <20241125-wt_relative_options-v5-0-356d122ff3db@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 0fc81cb8a13181fedbfec5c170a9c081781bd3ee
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

A new extension, `relativeWorktrees`, is added to indicate that at least
one worktree in the repository has been linked with relative paths.
This ensures older Git versions do not attempt to automatically prune
worktrees with relative paths, as they would not not recognize the
paths as being valid.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Caleb White <cdwhite3@pm.me>
---
 Documentation/config/extensions.txt | 6 ++++++
 repository.c                        | 1 +
 repository.h                        | 1 +
 setup.c                             | 7 +++++++
 setup.h                             | 1 +
 5 files changed, 16 insertions(+)

diff --git a/Documentation/config/extensions.txt b/Documentation/config/ext=
ensions.txt
index 5dc569d1c9c77c15e32441493289f9c9dd5e7f0b..5cb4721a0e0ae1ed64f90492c0d=
c18b96473cb33 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -63,6 +63,12 @@ Note that this setting should only be set by linkgit:git=
-init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
=20
+relativeWorktrees::
+=09If enabled, indicates at least one worktree has been linked with
+=09relative paths. Automatically set if a worktree has been created or
+=09repaired with either the `--relative-paths` option or with the
+=09`worktree.useRelativePaths` config set to `true`.
+
 worktreeConfig::
 =09If enabled, then worktrees will load config settings from the
 =09`$GIT_DIR/config.worktree` file in addition to the
diff --git a/repository.c b/repository.c
index f988b8ae68a6a29792e7f2c980a02bd0e388a3b9..1a6a62bbd03a5dc4fdade3eb45e=
a2696968abc23 100644
--- a/repository.c
+++ b/repository.c
@@ -283,6 +283,7 @@ int repo_init(struct repository *repo,
 =09repo_set_compat_hash_algo(repo, format.compat_hash_algo);
 =09repo_set_ref_storage_format(repo, format.ref_storage_format);
 =09repo->repository_format_worktree_config =3D format.worktree_config;
+=09repo->repository_format_relative_worktrees =3D format.relative_worktree=
s;
=20
 =09/* take ownership of format.partial_clone */
 =09repo->repository_format_partial_clone =3D format.partial_clone;
diff --git a/repository.h b/repository.h
index 24a66a496a6ff516ce06d47b7329b3d36eb701ca..c4c92b2ab9c9e3b425dc2974636=
e33d1f4089c69 100644
--- a/repository.h
+++ b/repository.h
@@ -150,6 +150,7 @@ struct repository {
=20
 =09/* Configurations */
 =09int repository_format_worktree_config;
+=09int repository_format_relative_worktrees;
=20
 =09/* Indicate if a repository has a different 'commondir' from 'gitdir' *=
/
 =09unsigned different_commondir:1;
diff --git a/setup.c b/setup.c
index 1e5c2eacb19eb6b230d7c9954f66fc7ae0b05631..39ff48d9dc5d67b16159c6cca66=
ff2663bbba6cf 100644
--- a/setup.c
+++ b/setup.c
@@ -683,6 +683,9 @@ static enum extension_result handle_extension(const cha=
r *var,
 =09=09=09=09     "extensions.refstorage", value);
 =09=09data->ref_storage_format =3D format;
 =09=09return EXTENSION_OK;
+=09} else if (!strcmp(ext, "relativeworktrees")) {
+=09=09data->relative_worktrees =3D git_config_bool(var, value);
+=09=09return EXTENSION_OK;
 =09}
 =09return EXTENSION_UNKNOWN;
 }
@@ -1854,6 +1857,8 @@ const char *setup_git_directory_gently(int *nongit_ok=
)
 =09=09=09=09=09=09    repo_fmt.ref_storage_format);
 =09=09=09the_repository->repository_format_worktree_config =3D
 =09=09=09=09repo_fmt.worktree_config;
+=09=09=09the_repository->repository_format_relative_worktrees =3D
+=09=09=09=09repo_fmt.relative_worktrees;
 =09=09=09/* take ownership of repo_fmt.partial_clone */
 =09=09=09the_repository->repository_format_partial_clone =3D
 =09=09=09=09repo_fmt.partial_clone;
@@ -1950,6 +1955,8 @@ void check_repository_format(struct repository_format=
 *fmt)
 =09=09=09=09    fmt->ref_storage_format);
 =09the_repository->repository_format_worktree_config =3D
 =09=09fmt->worktree_config;
+=09the_repository->repository_format_relative_worktrees =3D
+=09=09fmt->relative_worktrees;
 =09the_repository->repository_format_partial_clone =3D
 =09=09xstrdup_or_null(fmt->partial_clone);
 =09clear_repository_format(&repo_fmt);
diff --git a/setup.h b/setup.h
index e496ab3e4de580c2d9f95a7ea0eaf90e0d41b070..18dc3b73686ce28fac2fe04282c=
e95f8bf3e6b74 100644
--- a/setup.h
+++ b/setup.h
@@ -129,6 +129,7 @@ struct repository_format {
 =09int precious_objects;
 =09char *partial_clone; /* value of extensions.partialclone */
 =09int worktree_config;
+=09int relative_worktrees;
 =09int is_bare;
 =09int hash_algo;
 =09int compat_hash_algo;

--=20
2.47.0


