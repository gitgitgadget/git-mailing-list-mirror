Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A906117BAF
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057134; cv=none; b=f33n5GU24uxXTw4Ot+ZrsDTPMMevRv3gnS93Qj+GJ9lf1YcQtJ+X42UIxFp0I1OXNC3f/3McKayIgf6OggahrsEqxEf6SYFBX9qZmI894RZtsjaBS4jndPY2L3ef63MV+YvCfEq7E5yMWDtrRpW2aXBF1OmxECXg03ZHNII4dx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057134; c=relaxed/simple;
	bh=mA0IGHDr4QwxD9W8rUpULBVY+RI3BDSzCtgMfFGWBB4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D5xtX9la/am6e7QG0AfPQLoyPfkR1k9GKFQM1nXI3z13XlL9f3zCvk40rXlBvahFp1WiGYwmvUvGrk5QtMcakwcTYW30vSF2uxkVrG71yV27yZ7KGLavNWveqC9wkHDOTAQ83S2TDrkr0YyV2FZpwMItdjlZUyqvdj+Iz7mAJvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=NhgEy3Bg; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="NhgEy3Bg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057130; x=1713316330;
	bh=L8jIZIyOQXAe8rEhPm5KHRj2e5XKT0YZoFwgpOEWRk4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=NhgEy3Bg2C3svKIkECIeHl/8yrgS+LBV/C9qOaF+jKM/KIb9MQAWlCq1o0IIJBdJT
	 h1TU8Q7Lrql3FEM3pgyf2a0Eih4WHshVSpDJnd1umysiYz71JsQ/J/+hCgxIjOZ7j7
	 cC/oTmqVZiNx7YLzaUrMDgaRhMepqW8bIs1SdWKqJRh2Ve5lbLUfVSql+Y+vxKZI89
	 Rm1hqqcrYYQufDw5R8Lm/PLLFYwi5+Vj/ZFk683vhdgRyGGgatcZlCM6mC+CpW4hkt
	 +QyaY2YkxiKmPIfG2jTfOi9P596NoAqPFna5vbes9prQpT2+q7zt5iC32l5p/HIVSR
	 kGd0aATdu3bUQ==
Date: Sun, 14 Apr 2024 01:12:04 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 5/8] fast-import: improve documentation for path quoting
Message-ID: <e1a1b0395d0679f386b07c6dfeec4f481ccc7420.1713056559.git.thalia@archibald.dev>
In-Reply-To: <cover.1713056559.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev> <cover.1713056559.git.thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

It describes what characters cannot be in an unquoted path, but not
their semantics. Reframe it as a definition of unquoted paths. From the
perspective of the parser, whether it starts with `"` is what defines
whether it will parse it as quoted or unquoted.

The restrictions on characters in unquoted paths (with starting-", LF,
and spaces) are explained in the quoted paragraph. Move it to the
unquoted paragraph and reword.

The restriction that the source paths of filecopy and filerename cannot
contain SP is only stated in their respective sections. Restate it in
the <path> section.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 Documentation/git-fast-import.txt | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index b2607366b9..1882758b8a 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -630,18 +630,24 @@ in octal.  Git only supports the following modes:
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
=20
-A `<path>` string must use UNIX-style directory separators (forward
-slash `/`), may contain any byte other than `LF`, and must not
-start with double quote (`"`).
+A `<path>` can be written as unquoted bytes or a C-style quoted string.
=20
-A path can use C-style string quoting; this is accepted in all cases
-and mandatory if the filename starts with double quote or contains
-`LF`. In C-style quoting, the complete name should be surrounded with
-double quotes, and any `LF`, backslash, or double quote characters
-must be escaped by preceding them with a backslash (e.g.,
-`"path/with\n, \\ and \" in it"`).
+When a `<path>` does not start with a double quote (`"`), it is an
+unquoted string and is parsed as literal bytes without any escape
+sequences. However, if the filename contains `LF` or starts with double
+quote, it cannot be represented as an unquoted string and must be
+quoted. Additionally, the source `<path>` in `filecopy` or `filerename`
+must be quoted if it contains SP.
=20
-The value of `<path>` must be in canonical form. That is it must not:
+When a `<path>` starts with a double quote (`"`), it is a C-style quoted
+string, where the complete filename is enclosed in a pair of double
+quotes and escape sequences are used. Certain characters must be escaped
+by preceding them with a backslash: `LF` is written as `\n`, backslash
+as `\\`, and double quote as `\"`. All filenames can be represented as
+quoted strings.
+
+A `<path>` must use UNIX-style directory separators (forward slash `/`)
+and its value must be in canonical form. That is it must not:
=20
 * contain an empty directory component (e.g. `foo//bar` is invalid),
 * end with a directory separator (e.g. `foo/` is invalid),
--=20
2.44.0


