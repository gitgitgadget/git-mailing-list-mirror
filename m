Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D0E54FA0
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712909032; cv=none; b=s/4pqhP4yMMg9eu5Bo9e6vrRsAxm4o4CyVQaBx700Qw+AhYlgBXVLa+AOoWc4brX+Ckq+YfVN+8Ute8ulnOuouhsmeJq5WtKd1YdOL6WNbZFOT6id52i3U10ntrib7Wn82AdVTYeRsu+h28ifLm93lXg5q+USOr0c3JZWcpNNIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712909032; c=relaxed/simple;
	bh=7xKOVItu/+8PyIgxSMpe2CCS4ftKTouQR7f72k3jCzQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j2oxf1S1Db2bYU/HMi9oNlgHjezxBzUHN8ETU+MC5XhyZYVWITIMJvFhvgXZ+KgEcnFm1bi9A44vQ+6QJZ6ROoBD64BDBoUZssMRR1VFxnwbCyPxHLF6X/aAqgIA6dBsMl0XIqxcsj7zk1alUh7ungyPw+zYRWaDW+bylLOLLTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=la4QBVoR; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="la4QBVoR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712909022; x=1713168222;
	bh=G4hbb5RTa8FsnX1s+q65L8FvP/XusNnsJEuXyUfeBs8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=la4QBVoRCcC1wN78cnHKqISJiUqQ9t2Y26CfgVniB/QSXf0A/Kg/nefQ1du37OX6R
	 dSx/yAPnaarQA5aepIpdGAa2O/RI3SBDL6tT46OP6ec+jOVEoCdG6HGrIQ8mfsGaaj
	 /1XSxmKJG6idkXwmMkI0pzRJ3yGRB3w4fJ6eHSDgTxx1olwh/KCMpQVZRCe6BQogJV
	 VoNHIJB0Y+LQ3t+3XiSGpqnMNPyx2/JcE+P6nDOZ+fbh40Fsk8xQ0Ds9Xn9MFhgHSR
	 S7qi6aOxsyiMqD5vXBBSfsYVk/dm25zU4uIesCLjTe3rjgEv+rOR2zLsfYWYosuieX
	 wiggWPPA6O1TA==
Date: Fri, 12 Apr 2024 08:03:38 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v4 6/8] fast-import: document C-style escapes for paths
Message-ID: <4b6017ded8ec434fc6d7ac90964b59e40f6dd561.1712907684.git.thalia@archibald.dev>
In-Reply-To: <cover.1712907684.git.thalia@archibald.dev>
References: <20240322000304.76810-1-thalia@archibald.dev> <cover.1711960552.git.thalia@archibald.dev> <cover.1712741870.git.thalia@archibald.dev> <cover.1712907684.git.thalia@archibald.dev>
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


