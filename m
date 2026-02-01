Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60CBB2A1AA
	for <git@vger.kernel.org>; Sun,  1 Feb 2026 07:32:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769931172; cv=none; b=ZmhnBtobkCSLIgULlp+0Me0nEaM1moEsHFXVibEsmtZIefVdBF+53gE0b4WyvFTDBKT25OO4xfLyFx95Nd8ZPdd+3bjPpQbKumHknMcofiM2yRxknave/iPlXV0jZ/YVLHegXqDkOWo1GtMx8PSgXfuyWVDeCkCoaXK6SbPIiRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769931172; c=relaxed/simple;
	bh=jqjm8I3LassuKTVWjwCqdIKV17mpL6dMZ4T/ad8PgxE=;
	h=Date:To:From:Subject:Message-ID:MIME-Version:Content-Type; b=eA7W52C5mQz9WWehBZ40VNpjbYM1qWx15S79TICOnYyFFOVKdg7Asxxs1+zg1xK+3Pf+YLGT7mvRGcfWhC1EtkNi9wfZdJ0qM8ka+uwRtnO1UMvwRqZER/o/r+BtxnAITyCkWt6YA6dV9ZNRydeOp8SC0C/HKz0fKpzJxEkrnmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=dM7x6alq; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="dM7x6alq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1769931161; x=1770190361;
	bh=FSgCIf4o6Iywo6M8LdLikXL1T2fvCwghGZm6Fwnykjo=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=dM7x6alqaGUVSIf+vlDV0GadefFgvOjYbx9reRNEaV7rLga4XJUOEBJBkJKn59Ptc
	 ienvhO8gLpr0oP68jrbkjEiI3LGaRs6dj2huHPxTrnPh5cFku3b9pKQJrEatlN+5nD
	 XHjE5G9vu2TO0Qhz/OrCNUq+nNRciCnaQqBD6J+gF+WbXe6xjYG7mq+m8WbGkPVk8J
	 jSfPwU2SG1Z7xogIaZOLwQGkjaOhgYIGQ2DkTJ/EuhgyGn8GLEwVZ87XqH9ayFnkgZ
	 Gv5jTNShKogKyL7nH7GEqu4qFPRvlTWAdAzOuvwZVJ+biEPzJp/tl2rpvL0xTJ8uWT
	 TuQGYhWjn/flg==
Date: Sun, 01 Feb 2026 07:32:35 +0000
To: git@vger.kernel.org
From: Seth McDonald <sethmcmail@pm.me>
Subject: [BUG] git-blame: --color-lines ignores --ignore-rev
Message-ID: <aX8BjoOGPIytGXjD@McDaDebianPC>
Feedback-ID: 171233811:user:proton
X-Pm-Message-ID: 73092180233483d6a99f2a0aa2dd5713849d2a53
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha256; boundary="------7e6aca02a5fdeb5942667c7e4f356e308d5503feb636a0b39e2c47d84095842b"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------7e6aca02a5fdeb5942667c7e4f356e308d5503feb636a0b39e2c47d84095842b
Content-Type: text/plain; charset=UTF-8
Date: Sun, 1 Feb 2026 17:32:30 +1000
From: Seth McDonald <sethmcmail@pm.me>
To: git@vger.kernel.org
Subject: [BUG] git-blame: --color-lines ignores --ignore-rev
Message-ID: <aX8BjoOGPIytGXjD@McDaDebianPC>
Mail-Followup-To: Seth McDonald <sethmcmail@pm.me>, git@vger.kernel.org
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/2.2.13 (2024-03-09)

G'day all,

I believe I've found a bug regarding how git-blame(1) colours its output
when invoked with both --color-lines and --ignore-rev.

== Summary ==
git-blame(1) has two options of interest.  '--color-lines' colours a
line (in cyan by default) if it has the same blame as the preceding
line.  And '--ignore-rev <rev>' prevents any line from being blamed on
<rev>, instead blaming such lines on the most recent commit prior to
<rev> that modified those lines.

When used in combination, it is possible for consecutive lines to have
the same blame without the latter lines being coloured correctly.  I
first observed this behaviour on Git 2.47.3, but have since compiled
the latest release candidate (Git 2.53.0.rc2) and have observed the same
behaviour.

== Reproducibility ==
I was able to construct a minimal working example as follows.

First create and cd(1) into a temporary directory.  Let's name it
'git-test'.

$ mkdir git-test
$ cd git-test

Make git(1) ignore the system and global config files.  This is mainly
to aid in reproducibility.

$ export GIT_CONFIG_SYSTEM=/dev/null
$ export GIT_CONFIG_GLOBAL=/dev/null

Initialise a Git repository.

$ git init --initial-branch main
Initialized empty Git repository in /.../git-test/.git/

Now set some default values.  In particular, set blame.coloring to
repeatedLines; equivalent to the --color-lines option for git-blame(1).

$ git config set user.name 'John Git'
$ git config set user.email 'johngit@for.real'
$ git config set blame.coloring repeatedLines
$ git config set blame.date short

Create a file (let's name it 'text'), give it some text, and commit it.

$ echo Why hello there how are you | xargs -n1 > text
$ git add text
$ git commit --message 'init'
[main (root-commit) xxxxxxx] init
 1 file changed, 6 insertions(+)
 create mode 100644 text

Then fixup some punctuation in the file and commit it.

$ sed -i -e '3s/$/!/' -e '4s/h/H/' -e '6s/$/?/' text
$ git add text
$ git commit --message 'fix'
[main yyyyyyy] fix
 1 file changed, 3 insertions(+), 3 deletions(-)

If we now blame the file, we get the following.

$ git blame text
^xxxxxxx (John Git YYYY-MM-DD 1) Why
^xxxxxxx (John Git YYYY-MM-DD 2) hello
yyyyyyyy (John Git YYYY-MM-DD 3) there!
yyyyyyyy (John Git YYYY-MM-DD 4) How
^xxxxxxx (John Git YYYY-MM-DD 5) are
yyyyyyyy (John Git YYYY-MM-DD 6) you?

Where lines 2 and 4 are coloured cyan.  This is expected, since their
listed commits are the same as that on lines 1 and 3, respectively.

Now consider the output of git-blame(1) if we ignore the second commit.

$ git blame --ignore-rev HEAD text
^xxxxxxx (John Git YYYY-MM-DD 1) Why
^xxxxxxx (John Git YYYY-MM-DD 2) hello
^xxxxxxx (John Git YYYY-MM-DD 3) there!
^xxxxxxx (John Git YYYY-MM-DD 4) How
^xxxxxxx (John Git YYYY-MM-DD 5) are
^xxxxxxx (John Git YYYY-MM-DD 6) you?

My expected behaviour of git-blame(1) is to colour lines 2-6 cyan.  This
is because lines 1-6 all blame the same commit, meaning lines 2-6 all
have the same blame as their respective preceding lines.  And as the man
page for git-blame(1) states:

$ MANWIDTH=72 man git-blame | sed -n '/--color-lines$/,/^$/p'
       --color-lines
           Color line annotations in the default format differently if
           they come from the same commit as the preceding line. This
           makes it easier to distinguish code blocks introduced by
           different commits. The color defaults to cyan and can be
           adjusted using the color.blame.repeatedLines config option.

However, the actual behaviour of git-blame(1) is to colour only lines 2
and 4 cyan.  That is, it colours the output as if the --ignore-rev
option was not given.

== Environment ==
The following info was added verbatim from git-bugreport(1).

[System Info]
git version:
git version 2.53.0.rc2
cpu: x86_64
built from commit: ab380cb80b0727f7f2d7f6b17592ae6783e9820c
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
rust: disabled
gettext: enabled
libcurl: 8.14.1
OpenSSL: OpenSSL 3.5.4 30 Sep 2025
zlib: 1.3.1
SHA-1: SHA1_DC
SHA-256: SHA256_BLK
default-ref-format: files
default-hash: sha1
uname: Linux 6.12.63+deb13-amd64 #1 SMP PREEMPT_DYNAMIC Debian 6.12.63-1 (2025-12-30) x86_64
compiler info: gnuc: 14.2
libc info: glibc: 2.41
$SHELL (typically, interactive shell): /bin/bash


[Enabled Hooks]


And here's some extra info, in case it helps:

OS: Debian GNU/Linux 13 (trixie)
Terminal: GNOME Terminal 3.56.2
bash: (GNU bash) 5.2.37(1)-release (x86_64-pc-linux-gnu)
sed: (GNU sed) 4.9
xargs: (GNU findutils) 4.10.0

I'd be happy to further elaborate or provide help if needed.

-- 
Take care,
	Seth McDonald.

On-list:  2336 E8D2 FEB1 5300 692C  62A9 5839 6AD8 9243 D369
Off-list: 82B9 620E 53D0 A1AE 2D69  6111 C267 B002 0A90 0289

--------7e6aca02a5fdeb5942667c7e4f356e308d5503feb636a0b39e2c47d84095842b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wqsEARYIAF0Fgml/AZIJkFg5atiSQ9NpNRQAAAAAABwAEHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmeR4a6ak+iK2sr8hbd+GOvPFiEEIzbo0v6xUwBp
LGKpWDlq2JJD02kAABH9AP9a2e2cTIhKdidECBo8AQwhD0FjHCu84RPm8pid
omWKPgD9Gl1xoLwkVKArow36O/VmVVVO1F9R9R/yyDGFKIIfawY=
=ep7o
-----END PGP SIGNATURE-----


--------7e6aca02a5fdeb5942667c7e4f356e308d5503feb636a0b39e2c47d84095842b--

