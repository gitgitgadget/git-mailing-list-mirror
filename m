Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F24199B0
	for <git@vger.kernel.org>; Sun, 14 Apr 2024 01:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713057144; cv=none; b=hR5A4RigsxFunvS938YImug4hfnDvPZNAw66jWQ+o+dWOhfnLyw1/ZGRxEhDwHlyiMXHYkUlAS/dqPlAHWZWmJEmDPjkoksDYEYj8WT+oVsuGLkeu0WF3LPDT9Eup6fWTWcdF4Fnz9gt79cuXFwoFAPIToBOgCAF1++XegObgIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713057144; c=relaxed/simple;
	bh=7xKOVItu/+8PyIgxSMpe2CCS4ftKTouQR7f72k3jCzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3PfMyILy2q1IiJwmnc5CXdL/70veXOIx2Ur5JwJ1NXWf619ZyPrfdiB5CiYdSSVJIKeBrl9Po5e0IWJ77gEW9oYGvtMqnJVPmxhmirNwDkCqGjX5B7ocq0/rkwFU+L7dt+kjNdd1FZIEmaAPTrQQ5rZuw9/vS8p0E7n+tcgPsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=S0FCWmAK; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="S0FCWmAK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1713057141; x=1713316341;
	bh=G4hbb5RTa8FsnX1s+q65L8FvP/XusNnsJEuXyUfeBs8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=S0FCWmAKziB6XQOYk7yL0pmxkR1U75WTJijTglQznFnN6e5wlBDUaf0D+iJkGdH41
	 9qmrEE8FqvXry8ghZEsHTNfmi++O9quksGwlrzxnxk8I4nsQAreKNqTCM6Hml6e1pQ
	 lV47eFGV1ptNBMNDbjhWMw8NBh75C94Rl32/oARWyh465Trhh7+w8ZNDGKiTQGJNPw
	 cii7QP0mwIY+/CS7aHnSwVgiFRoY+eYaL/BnqtGNPop9ozMaHtdRPy325jb5vy5mwT
	 Txuv8dmIaZrW10E3dHaKxaksePR0zSxidUIaBxFG3CD8CFzdgNNpRlXuxnCsvRRlW7
	 4E6QQXrpJ77CA==
Date: Sun, 14 Apr 2024 01:12:12 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v5 6/8] fast-import: document C-style escapes for paths
Message-ID: <08e6fb37beb806f42ce66dc89f51c2d59865a4fa.1713056559.git.thalia@archibald.dev>
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

Simply saying =E2=80=9CC-style=E2=80=9D string quoting is imprecise, as onl=
y a subset of
C escapes are supported. Document the exact escapes.

Signed-off-by: Thalia Archibald <thalia@archibald.dev>
---
 Documentation/git-fast-import.txt |  6 +++++-
 t/t9300-fast-import.sh            | 10 ++++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index 1882758b8a..c6082c3b49 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -643,7 +643,11 @@ When a `<path>` starts with a double quote (`"`), it i=
s a C-style quoted
 string, where the complete filename is enclosed in a pair of double
 quotes and escape sequences are used. Certain characters must be escaped
 by preceding them with a backslash: `LF` is written as `\n`, backslash
-as `\\`, and double quote as `\"`. All filenames can be represented as
+as `\\`, and double quote as `\"`. Some characters may optionally be
+written with escape sequences: `\a` for bell, `\b` for backspace, `\f`
+for form feed, `\n` for line feed, `\r` for carriage return, `\t` for
+horizontal tab, and `\v` for vertical tab. Any byte can be written with
+3-digit octal codes (e.g., `\033`). All filenames can be represented as
 quoted strings.
=20
 A `<path>` must use UNIX-style directory separators (forward slash `/`)
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 13f98e6688..5cde8f8d01 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -3189,8 +3189,9 @@ test_path_eol_success () {
 =09'
 }
=20
-test_path_eol_success 'quoted spaces'   '" hello world.c "' ' hello world.=
c '
-test_path_eol_success 'unquoted spaces' ' hello world.c '   ' hello world.=
c '
+test_path_eol_success 'quoted spaces'   '" hello world.c "'  ' hello world=
.c '
+test_path_eol_success 'unquoted spaces' ' hello world.c '    ' hello world=
.c '
+test_path_eol_success 'octal escapes'   '"\150\151\056\143"' 'hi.c'
=20
 #
 # Valid paths before a space: filecopy (source) and filerename (source).
@@ -3256,8 +3257,9 @@ test_path_space_success () {
 =09'
 }
=20
-test_path_space_success 'quoted spaces'      '" hello world.c "' ' hello w=
orld.c '
-test_path_space_success 'no unquoted spaces' 'hello_world.c'     'hello_wo=
rld.c'
+test_path_space_success 'quoted spaces'      '" hello world.c "'  ' hello =
world.c '
+test_path_space_success 'no unquoted spaces' 'hello_world.c'      'hello_w=
orld.c'
+test_path_space_success 'octal escapes'      '"\150\151\056\143"' 'hi.c'
=20
 #
 # Test a single commit change with an invalid path. Run it with all occurr=
ences
--=20
2.44.0


