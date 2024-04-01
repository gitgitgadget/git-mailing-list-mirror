Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C18A0DDD9
	for <git@vger.kernel.org>; Mon,  1 Apr 2024 09:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962225; cv=none; b=WQvXU76ua8qmPuVofjc9xcNMH+/kwEoyTFfGxYISjyNn9g/t3h4Qp2dKsoRJGLXClDN0ykmOzDsap617hSu/eCfRRca276aZmNStM5rgMwPEWY4AsGnxmPgbGdTGC373goi2uWgHBGRSFSf2tew/KDu4WHi+9rU/zGfHfp/+FMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962225; c=relaxed/simple;
	bh=WPzqEvQpU4C2O5x6yCuxGCvax9aBUfOqE3w3ExSwJHg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m0vbA15pUdMRYajcw7HDH+/lOrtJmywvW5YF0ADvJJqXCiij4XL7jZMYWueXHQhz5MUy1SImB/Es3EEbzY5qe29n1g9mvlMis72jXKVZwOgh+PDzKZ028cRwYhFLwjGsuUHLC+X+JfxCAXfVUoHN9HGAOj+qfdtqgTiTOOgbyU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=s9KQJh+c; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="s9KQJh+c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711962221; x=1712221421;
	bh=N8XgjHlZHmADcp4IaJMk7NLtAcvIzKo5zzwBmK4XP6I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=s9KQJh+c+h+iZxDvyGAJYnOV45vV9oN27UY8/Tox1EMNsUJgkSMYM+pd+2ziEmpcZ
	 iv/QpHPTW7fZNH+ECYTAkR8bYUC8ckLv+juOUQUiuIU1WObdb+/ocpxRLvdehkn6Er
	 hVITK4dvDllHRmFZl1BpfC19A320h91pJP0xSxejUKbQ9hRaaIdNVwPKYklK4wkX2Y
	 Ny5PE0kTb+Fq0LPeDAGBTvi6CIzTphMv2NduVhfC0Rh6ZG61IUkqojfM7BQfs5Ae+e
	 z5vajwDsAPJkujQmvduRmIhK82wx+i5KLpyKiDvFqjzM75E1YR5PGP7MqYVuT81qSE
	 t9gbYOJSZgGRw==
Date: Mon, 01 Apr 2024 09:03:33 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v2 5/8] fast-import: improve documentation for unquoted paths
Message-ID: <1f34b632d72b0b04d22da54b8eac1520e262620a.1711960552.git.thalia@archibald.dev>
In-Reply-To: <cover.1711960552.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It describes what cannot be in an unquoted path, but not what it is.
Reframe it as a definition of unquoted paths. The requirement that it
not start with `"` is the core element that implies the rest.

The restriction that the source paths of filecopy and filerename cannot
contain SP is only stated in their respective sections. Restate it in
the <path> section.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 Documentation/git-fast-import.txt | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index b2607366b9..f26d7a8571 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -630,18 +630,23 @@ in octal.  Git only supports the following modes:
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
=20
-A `<path>` string must use UNIX-style directory separators (forward
-slash `/`), may contain any byte other than `LF`, and must not
-start with double quote (`"`).
+A `<path>` can be written as unquoted bytes or a C-style quoted string:
=20
-A path can use C-style string quoting; this is accepted in all cases
-and mandatory if the filename starts with double quote or contains
-`LF`. In C-style quoting, the complete name should be surrounded with
+When a `<path>` does not start with double quote (`"`), it is an
+unquoted string and is parsed as literal bytes without any escape
+sequences. However, if the filename contains `LF` or starts with double
+quote, it must be written as a quoted string. Additionally, the source
+`<path>` in `filecopy` or `filerename` must be quoted if it contains SP.
+
+A `<path>` can use C-style string quoting; this is accepted in all cases
+and mandatory in the cases where the filename cannot be represented as
+an unquoted string. In C-style quoting, the complete name should be surrou=
nded with
 double quotes, and any `LF`, backslash, or double quote characters
 must be escaped by preceding them with a backslash (e.g.,
 `"path/with\n, \\ and \" in it"`).
=20
-The value of `<path>` must be in canonical form. That is it must not:
+A `<path>` must use UNIX-style directory separators (forward slash `/`)
+and must be in canonical form. That is it must not:
=20
 * contain an empty directory component (e.g. `foo//bar` is invalid),
 * end with a directory separator (e.g. `foo/` is invalid),
--=20
2.44.0


