Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34822819
	for <git@vger.kernel.org>; Tue, 22 Oct 2024 00:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729555747; cv=none; b=uCuWj/RfgmyxjZkmWo/V+hHSL/gPtaVtTjo3aY6V9YQaIsXM3W1Vy4FasK02pcaytyYlMR99MlLhAqqwmQ0c7gKZZIqxDTK8arf4G8YVzSRTZyeS3/hGxuGWyYHOujiuE9FJuihMmAY1Ww1Xb1blCwhlGvk0+ss3EYLN4qNCfXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729555747; c=relaxed/simple;
	bh=C1ofgxmbBlN3aUWcchxBZTQfMOnqFvuALoVreh9nGYA=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=P1KcnN/ZMpg+F0buRVz+3+TqOOcTQeWkHTpy7IEUHaFZXmJLqB7ekZntOWw67DMVm+kkmCi181QPJElFwknE/OooRcmEzleBIxczpj2rSsFNh28XH25YSzf0qHjo+AENLoQ7tRs93OyNnvjStwbUa5hrRg31CgmroEaxTtU07Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=ausbLTHe; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="ausbLTHe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1729555737; x=1729814937;
	bh=yqXFmbT8lGpiGEstCddn7trlUAVcTKvujgZBCGL4tzU=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=ausbLTHeK+AzEnlaOogvGLYeg3EgR/ybAshQPLaoChtMGNQZJlOWRNp2BdnVoUA0z
	 cYd8GxhPHEyKWXAUk36H1ndOSGj82xldSa1AcEe8cxUcpbSwzp2PDqU54CgqTik9mK
	 TiA2NhDzOoeEHjpvcQHM40LcIDGsSS9+vQKP3uqk/xqA37Mg76vDamjVtkNb9KPOa+
	 po5rj5E1T/DR2cfDdkDnti0vRuRgXevyllgA+35TyuLIWbfhHxkTjCAvo4EDr2jMJD
	 vh/4GrB0SvhprqxtOXFf+4mM8i3shoaQEr+/H9Hfp8jVwft3qBP4w5MMDe1ZLlIkx+
	 SGqzc2VKwr1Jg==
Date: Tue, 22 Oct 2024 00:08:49 +0000
To: git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: Junio C Hamano <gitster@pobox.com>, Caleb White <cdwhite3@pm.me>
Subject: [PATCH] doc: consolidate extensions in git-config documentation
Message-ID: <20241021-cleanup-extension-docs-v1-1-ab02cece3132@pm.me>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: fdacbd12a4784fa8e5da0a86ab20542691d09c71
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The `technical/repository-version.txt` document originally served as the
master list for extensions, requiring that any new extensions be defined
there. However, the `config/extensions.txt` file was introduced later
and has since become the de facto location for describing extensions,
with several extensions listed there but missing from
`repository-version.txt`.

This consolidates all extension definitions into `config/extensions.txt`,
making it the authoritative source for extensions. The references in
`repository-version.txt` are updated to point to `config/extensions.txt`,
and cross-references to related documentation such as
`gitrepository-layout[5]` and `git-config[1]` are added.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Caleb White <cdwhite3@pm.me>
---
This patch was based on v2.47.0.
---
 Documentation/config/core.txt                      |  2 +-
 Documentation/config/extensions.txt                | 73 ++++++++++++++++--=
----
 Documentation/gitrepository-layout.txt             |  1 +
 .../technical/hash-function-transition.txt         |  4 +-
 Documentation/technical/partial-clone.txt          |  2 +-
 Documentation/technical/repository-version.txt     | 44 +------------
 6 files changed, 62 insertions(+), 64 deletions(-)

diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
index 60ca9f2b6861063c0e78307edcbbd25a9104472f..8f6d8e77541261d67abac4f990f=
36ebb29b568c6 100644
--- a/Documentation/config/core.txt
+++ b/Documentation/config/core.txt
@@ -366,7 +366,7 @@ default in a bare repository.
=20
 core.repositoryFormatVersion::
 =09Internal variable identifying the repository format and layout
-=09version.
+=09version. See linkgit:gitrepository-layout[5].
=20
 core.sharedRepository::
 =09When 'group' (or 'true'), the repository is made shareable between
diff --git a/Documentation/config/extensions.txt b/Documentation/config/ext=
ensions.txt
index f0a784447db09856639ec43b443681f13c17c966..5dc569d1c9c77c15e3244149328=
9f9c9dd5e7f0b 100644
--- a/Documentation/config/extensions.txt
+++ b/Documentation/config/extensions.txt
@@ -1,17 +1,13 @@
-extensions.objectFormat::
-=09Specify the hash algorithm to use.  The acceptable values are `sha1` an=
d
-=09`sha256`.  If not specified, `sha1` is assumed.  It is an error to spec=
ify
-=09this key unless `core.repositoryFormatVersion` is 1.
+extensions.*::
+=09Unless otherwise stated, is an error to specify an extension if
+=09`core.repositoryFormatVersion` is not `1`. See
+=09linkgit:gitrepository-layout[5].
 +
-Note that this setting should only be set by linkgit:git-init[1] or
-linkgit:git-clone[1].  Trying to change it after initialization will not
-work and will produce hard-to-diagnose issues.
-
-extensions.compatObjectFormat::
-
+--
+compatObjectFormat::
 =09Specify a compatibility hash algorithm to use.  The acceptable values
 =09are `sha1` and `sha256`.  The value specified must be different from th=
e
-=09value of extensions.objectFormat.  This allows client level
+=09value of `extensions.objectFormat`.  This allows client level
 =09interoperability between git repositories whose objectFormat matches
 =09this compatObjectFormat.  In particular when fully implemented the
 =09pushes and pulls from a repository in whose objectFormat matches
@@ -19,18 +15,55 @@ extensions.compatObjectFormat::
 =09compatObjectFormat in addition to oids encoded with objectFormat to
 =09locally specify objects.
=20
-extensions.refStorage::
+noop::
+=09This extension does not change git's behavior at all. It is useful only
+=09for testing format-1 compatibility.
++
+For historical reasons, this extension is respected regardless of the
+`core.repositoryFormatVersion` setting.
+
+noop-v1::
+=09This extension does not change git's behavior at all. It is useful only
+=09for testing format-1 compatibility.
+
+objectFormat::
+=09Specify the hash algorithm to use.  The acceptable values are `sha1` an=
d
+=09`sha256`.  If not specified, `sha1` is assumed.
++
+Note that this setting should only be set by linkgit:git-init[1] or
+linkgit:git-clone[1].  Trying to change it after initialization will not
+work and will produce hard-to-diagnose issues.
+
+partialClone::
+=09When enabled, indicates that the repo was created with a partial clone
+=09(or later performed a partial fetch) and that the remote may have
+=09omitted sending certain unwanted objects.  Such a remote is called a
+=09"promisor remote" and it promises that all such omitted objects can
+=09be fetched from it in the future.
++
+The value of this key is the name of the promisor remote.
++
+For historical reasons, this extension is respected regardless of the
+`core.repositoryFormatVersion` setting.
+
+preciousObjects::
+=09If enabled, indicates that objects in the repository MUST NOT be delete=
d
+=09(e.g., by `git-prune` or `git repack -d`).
++
+For historical reasons, this extension is respected regardless of the
+`core.repositoryFormatVersion` setting.
+
+refStorage::
 =09Specify the ref storage format to use. The acceptable values are:
 +
 include::../ref-storage-format.txt[]
-+
-It is an error to specify this key unless `core.repositoryFormatVersion` i=
s 1.
+
 +
 Note that this setting should only be set by linkgit:git-init[1] or
 linkgit:git-clone[1]. Trying to change it after initialization will not
 work and will produce hard-to-diagnose issues.
=20
-extensions.worktreeConfig::
+worktreeConfig::
 =09If enabled, then worktrees will load config settings from the
 =09`$GIT_DIR/config.worktree` file in addition to the
 =09`$GIT_COMMON_DIR/config` file. Note that `$GIT_COMMON_DIR` and
@@ -40,7 +73,7 @@ extensions.worktreeConfig::
 =09`config.worktree` file will override settings from any other
 =09config files.
 +
-When enabling `extensions.worktreeConfig`, you must be careful to move
+When enabling this extension, you must be careful to move
 certain values from the common config file to the main working tree's
 `config.worktree` file, if present:
 +
@@ -48,15 +81,17 @@ certain values from the common config file to the main =
working tree's
   `$GIT_COMMON_DIR/config.worktree`.
 * If `core.bare` is true, then it must be moved from `$GIT_COMMON_DIR/conf=
ig`
   to `$GIT_COMMON_DIR/config.worktree`.
+
 +
 It may also be beneficial to adjust the locations of `core.sparseCheckout`
 and `core.sparseCheckoutCone` depending on your desire for customizable
 sparse-checkout settings for each worktree. By default, the `git
-sparse-checkout` builtin enables `extensions.worktreeConfig`, assigns
+sparse-checkout` builtin enables this extension, assigns
 these config values on a per-worktree basis, and uses the
 `$GIT_DIR/info/sparse-checkout` file to specify the sparsity for each
 worktree independently. See linkgit:git-sparse-checkout[1] for more
 details.
 +
-For historical reasons, `extensions.worktreeConfig` is respected
-regardless of the `core.repositoryFormatVersion` setting.
+For historical reasons, this extension is respected regardless of the
+`core.repositoryFormatVersion` setting.
+--
diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepo=
sitory-layout.txt
index 949cd8a31e9a9e896ccec63d5c7e2f23f740973a..fa8b51daf08775f3d666a910d9b=
00486627e02af 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -298,6 +298,7 @@ SEE ALSO
 --------
 linkgit:git-init[1],
 linkgit:git-clone[1],
+linkgit:git-config[1],
 linkgit:git-fetch[1],
 linkgit:git-pack-refs[1],
 linkgit:git-gc[1],
diff --git a/Documentation/technical/hash-function-transition.txt b/Documen=
tation/technical/hash-function-transition.txt
index ed574810891cad1024658920e0fa8ac550231534..7102c7c8f5d66de5574de459a0e=
1136131a53004 100644
--- a/Documentation/technical/hash-function-transition.txt
+++ b/Documentation/technical/hash-function-transition.txt
@@ -148,8 +148,8 @@ Detailed Design
 Repository format extension
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 A SHA-256 repository uses repository format version `1` (see
-Documentation/technical/repository-version.txt) with extensions
-`objectFormat` and `compatObjectFormat`:
+linkgit:gitrepository-layout[5]) with `extensions.objectFormat` and
+`extensions.compatObjectFormat` (see linkgit:git-config[1]) set to:
=20
 =09[core]
 =09=09repositoryFormatVersion =3D 1
diff --git a/Documentation/technical/partial-clone.txt b/Documentation/tech=
nical/partial-clone.txt
index cd948b00722cba5ae9f01b31f6a226f8d4497ea8..bf5ec5c82d9e0f2fedfec517a6a=
86d9973f4f312 100644
--- a/Documentation/technical/partial-clone.txt
+++ b/Documentation/technical/partial-clone.txt
@@ -102,7 +102,7 @@ or commits that reference missing trees.
 - On the client a repository extension is added to the local config to
   prevent older versions of git from failing mid-operation because of
   missing objects that they cannot handle.
-  See "extensions.partialClone" in Documentation/technical/repository-vers=
ion.txt"
+  See `extensions.partialClone` in linkgit:git-config[1].
=20
=20
 Handling Missing Objects
diff --git a/Documentation/technical/repository-version.txt b/Documentation=
/technical/repository-version.txt
index 47281420fc4a0c901d60b2854a8f0a6e8f70587a..b9bb81a81f9ea16830290dfabd0=
839f1f05b1992 100644
--- a/Documentation/technical/repository-version.txt
+++ b/Documentation/technical/repository-version.txt
@@ -65,44 +65,6 @@ Note that if no extensions are specified in the config f=
ile, then
 provides no benefit, and makes the repository incompatible with older
 implementations of git).
=20
-This document will serve as the master list for extensions. Any
-implementation wishing to define a new extension should make a note of
-it here, in order to claim the name.
-
-The defined extensions are:
-
-=3D=3D=3D=3D `noop`
-
-This extension does not change git's behavior at all. It is useful only
-for testing format-1 compatibility.
-
-=3D=3D=3D=3D `preciousObjects`
-
-When the config key `extensions.preciousObjects` is set to `true`,
-objects in the repository MUST NOT be deleted (e.g., by `git-prune` or
-`git repack -d`).
-
-=3D=3D=3D=3D `partialClone`
-
-When the config key `extensions.partialClone` is set, it indicates
-that the repo was created with a partial clone (or later performed
-a partial fetch) and that the remote may have omitted sending
-certain unwanted objects.  Such a remote is called a "promisor remote"
-and it promises that all such omitted objects can be fetched from it
-in the future.
-
-The value of this key is the name of the promisor remote.
-
-=3D=3D=3D=3D `worktreeConfig`
-
-If set, by default "git config" reads from both "config" and
-"config.worktree" files from GIT_DIR in that order. In
-multiple working directory mode, "config" file is shared while
-"config.worktree" is per-working directory (i.e., it's in
-GIT_COMMON_DIR/worktrees/<id>/config.worktree)
-
-=3D=3D=3D=3D `refStorage`
-
-Specifies the file format for the ref database. The valid values are
-`files` (loose references with a packed-refs file) and `reftable` (see
-Documentation/technical/reftable.txt).
+The defined extensions are given in the `extensions.*` section of
+linkgit:git-config[1]. Any implementation wishing to define a new
+extension should make a note of it there, in order to claim the name.

---
base-commit: 777489f9e09c8d0dd6b12f9d90de6376330577a2
change-id: 20241020-cleanup-extension-docs-f365868711bf

Best regards,
--=20
Caleb White <cdwhite3@pm.me>


