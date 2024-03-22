Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B63EA48
	for <git@vger.kernel.org>; Fri, 22 Mar 2024 00:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.77.79.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711065858; cv=none; b=FQkR+ZVUqg7IwofLRUwxYwhnc/HxvkKjfwZVDPItEttEhrA+JKMCHPQgnbL+uiymbn2+XDrKcM5kztJ76e0S5Yg6XRmp4Mm63XswRRDYxLp17Sj3EsGv65XAJbZwUSgvj2mnx+kc0cx5xNGKHDxRK0+RAC1HdsYrC9MaWHB76Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711065858; c=relaxed/simple;
	bh=vxmk4UhIrlJGXcxb1yNqJM60pW8TeGWjNVXzCmMUqko=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mnzhkxSno6PfAtjA0hAvxHOekshZ/cuCo21OrVIB7Jf5JJOmTIEvLQLQZdDI5YMNB/T7FjPm+OdJ43KBhKj29DFEyjspFHi44W6/NuCARyxdPQHOxS6paqemqOe8HEJ4MfZf7FAYlkFMRgFfs00sb6zH+sLw1fL5tSKthNTHCPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=Xopya0eK; arc=none smtp.client-ip=51.77.79.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="Xopya0eK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1711065847; x=1711325047;
	bh=TmiGSefOnYVM6KMa3hvPOEUJOHJa6TzrAMAXpPg2504=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=Xopya0eKcxq4rCBc609VMZ3YLVnux6AabFVKhJh0IiXcdyybpuXkiYICn3YGNzOCG
	 EPCdk8bEgr0VG4i+lfSA5TtE8fQ5UM8Dwf1tej7EVaOBAKVydk0TLLsZ3CInMNkYG1
	 zCnrXz6HurLt/Y17v2y6eEgfY55m6AQO6rixXr3UAuaftG95R5mNWVVlDzkebdUHyU
	 27Njq/VqOAT4OMhzPAy8JRXZLu5q1epE4SFv+oRvRjE3Wba6UMZHrenU0hiF9idysV
	 wfAOAiuyeRSJLDK3SXvDrJ4wATYsalnqpueqsyCr1j0/blciohTMQlrJBwwpy+v4y4
	 9jnVGSU/f4a8A==
Date: Fri, 22 Mar 2024 00:03:47 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH 5/6] fast-import: document C-style escapes for paths
Message-ID: <20240322000304.76810-6-thalia@archibald.dev>
In-Reply-To: <20240322000304.76810-1-thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev>
Feedback-ID: 63908566:user:proton
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Simply saying =E2=80=9CC-style=E2=80=9D string quoting is imprecise, as onl=
y a subset of
C escapes are supported. Document the exact escapes.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 Documentation/git-fast-import.txt | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index 271bd63a10..4aa8ccbefd 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -630,18 +630,23 @@ in octal.  Git only supports the following modes:
 In both formats `<path>` is the complete path of the file to be added
 (if not already existing) or modified (if already existing).
=20
-A `<path>` string must use UNIX-style directory separators (forward
-slash `/`), may contain any byte other than `LF`, and must not
-start with double quote (`"`).
+A `<path>` string may contain any byte other than `LF`, and must not
+start with double quote (`"`). It is interpreted as literal bytes
+without escaping.
=20
 A path can use C-style string quoting; this is accepted in all cases
 and mandatory if the filename starts with double quote or contains
-`LF`. In C-style quoting, the complete name should be surrounded with
-double quotes, and any `LF`, backslash, or double quote characters
-must be escaped by preceding them with a backslash (e.g.,
-`"path/with\n, \\ and \" in it"`).
+`LF`. In C-style quoting, the complete name is surrounded with
+double quotes (`"`) and certain characters must be escaped by preceding
+them with a backslash: `LF` is written as `\n`, backslash as `\\`, and
+double quote as `\"`. Additionally, some characters may may optionally
+be written with escape sequences: `\a` for bell, `\b` for backspace,
+`\f` for form feed, `\n` for line feed, `\r` for carriage return, `\t`
+for horizontal tab, and `\v` for vertical tab. Any byte can be written
+with 3-digit octal codes (e.g., `\033`).
=20
-The value of `<path>` must be in canonical form. That is it must not:
+A `<path>` must use UNIX-style directory separators (forward slash `/`)
+and must be in canonical form. That is it must not:
=20
 * contain an empty directory component (e.g. `foo//bar` is invalid),
 * end with a directory separator (e.g. `foo/` is invalid),
--=20
2.44.0


