Received: from mail-4323.proton.ch (mail-4323.proton.ch [185.70.43.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA14815887C
	for <git@vger.kernel.org>; Wed, 10 Apr 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712742978; cv=none; b=hnj6MmYBATymY2bqWWMlDv3G3s6scwEZwmwQd5nerONITE+Cd/7fl5fX9AH2M+maIOExe+ThrR9Lj/nPoPGBxsDN5SR04vEcM40DNjrpPLe6ycgvE2zbbx1gtjzqzpBZvJrBmukPWAJNloOaDTotwB04RwOQbZhcnByZhIp9jxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712742978; c=relaxed/simple;
	bh=EgvxaSGNxzcUf/rlDo9IUXkuHnwoD8YDauyzr9h9Vcc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wymtz5pV4B03MXSlv/PsO8sB6VhFIN+fV+WoziSDibQ0KpE1mQZ5yGFajPMluVctBk8okO+RnW3+d6r/8XMGaLT/v+Mf6xb9NxUA4YY2khYm40dnBubytgmSDo29ec1QsOZAN/VvkcMMtaohgX0oDw4HF3ubcxMy/Jnpbc086ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=w2hfW1iJ; arc=none smtp.client-ip=185.70.43.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="w2hfW1iJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712742973; x=1713002173;
	bh=Nm/LiCCcd/ychPRVchBFnGMgvuHX8P8JBDTMJzk4bBc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=w2hfW1iJ6U4L+lKZBjQMRPIsfDP8pUwz8REIgOIOG217mz2lvgM3/vERMk1zq09xu
	 fMhupWMGsApWEGxu3rkRJkr6ypzWyk7LTVAq+YcDKvtCyiI/u0RVd5OpoaplmHsHK6
	 C3Ga6eDMGBEP12G3uqxA6Mg66V8/+cvAcWWLgIOsY+XV8vTGE8j1csqnKfsZBoPrYy
	 vIutk4brLD8anVrug54JoLq5caAfm0d75aBylK59j/RyZtQx07WGzSooOGdR3BHuyh
	 SkJzp1fU8ku3k1UXWnjjJwirF2MfnjxxWIqMpxSa7Pqndev7ZBAKEF6qoSPzFAmpJK
	 bhrsHXhv7nX4Q==
Date: Wed, 10 Apr 2024 09:56:03 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v3 6/8] fast-import: document C-style escapes for paths
Message-ID: <1b07ddffe000ed2ab34bd41f4f0558ae8b2dd663.1712741871.git.thalia@archibald.dev>
In-Reply-To: <cover.1712741870.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev>
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
 Documentation/git-fast-import.txt | 12 ++++++++----
 t/t9300-fast-import.sh            | 10 ++++++----
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/Documentation/git-fast-import.txt b/Documentation/git-fast-imp=
ort.txt
index f26d7a8571..db53b50268 100644
--- a/Documentation/git-fast-import.txt
+++ b/Documentation/git-fast-import.txt
@@ -640,10 +640,14 @@ quote, it must be written as a quoted string. Additio=
nally, the source
=20
 A `<path>` can use C-style string quoting; this is accepted in all cases
 and mandatory in the cases where the filename cannot be represented as
-an unquoted string. In C-style quoting, the complete name should be surrou=
nded with
-double quotes, and any `LF`, backslash, or double quote characters
-must be escaped by preceding them with a backslash (e.g.,
-`"path/with\n, \\ and \" in it"`).
+an unquoted string. In C-style quoting, the complete filename is
+surrounded with double quote (`"`) and certain characters must be
+escaped by preceding them with a backslash: `LF` is written as `\n`,
+backslash as `\\`, and double quote as `\"`. Some characters may may
+optionally be written with escape sequences: `\a` for bell, `\b` for
+backspace, `\f` for form feed, `\n` for line feed, `\r` for carriage
+return, `\t` for horizontal tab, and `\v` for vertical tab. Any byte can
+be written with 3-digit octal codes (e.g., `\033`).
=20
 A `<path>` must use UNIX-style directory separators (forward slash `/`)
 and must be in canonical form. That is it must not:
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


