Received: from mail-4022.proton.ch (mail-4022.proton.ch [185.70.40.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D5E450283
	for <git@vger.kernel.org>; Fri, 12 Apr 2024 08:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712908923; cv=none; b=HuduB5fZRp4w5AWjnz+whVxlS4N4YW24Fpno1prDsHihUMVoXpZdbyztwwUZKJDSyIjkpUsfQvAV0flPwLSeSPsvxL5PDq+vp3ubhrvEu1XxJyX0djBBvK9+GyfmVZ8swy22llt4a+ANv79RkljfjD9pUO2qWhar066KUcfK2Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712908923; c=relaxed/simple;
	bh=sy7mk/PZ0PH9evjZHrF7vDS5J9mjxK4cold+vEHsub0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tiknZiXDJTgH8VEwmhI24NoU4CNOsFv9j8I5b2Izj16vIDfpnszHRwXp+VPblPTyQENPY1UEAKzircgRlK/temJZJqHng3KXK6pyF8Vbj5RFoJdKPvuK/SNRa1jDMf68BjqvnuAf7iO3wfVwWQ15rAAZxz+T6wNGxCcApDbRJw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=T8ufD+Wq; arc=none smtp.client-ip=185.70.40.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="T8ufD+Wq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712908905; x=1713168105;
	bh=VyCQ26+SNjFbdqZH+Kct3HhiEt4u8F/MlIcBmMZRQII=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=T8ufD+WqO//k4gW0GfzHs4m975r+QRs5e+26e4JePlK4Qvnw5AXjNEM96joxIajQ8
	 p51zs4RUn7ejZfNVjhRisXoW8dgetASmbIf1wnl/Ye5rC07Hrkh21Y6C4Gn5hUNdCF
	 ipusMw1ax6ZROpcNvvClxJYGhDFDnt4broECoEOeLrUVhoziQ/1cULvLXeGJq8uFou
	 9sCI4UsPThOoUqLprUBdLhOLpK4usQwL7N7kq6MaQjmfMM9eYx4i0gBqHonI267Tox
	 ajYdLlijqEArz9r06hp4O9NL0a7cS81utPj733s0xCI91GwQZlePzPuRN2YvXBqhr5
	 On+2xbi4QvYmQ==
Date: Fri, 12 Apr 2024 08:01:41 +0000
To: git@vger.kernel.org
From: Thalia Archibald <thalia@archibald.dev>
Cc: Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>, Chris Torek <chris.torek@gmail.com>, Elijah Newren <newren@gmail.com>, Thalia Archibald <thalia@archibald.dev>
Subject: [PATCH v4 0/8] fast-import: tighten parsing of paths
Message-ID: <cover.1712907684.git.thalia@archibald.dev>
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

> fast-import has subtle differences in how it parses file paths between ea=
ch
> occurrence of <path> in the grammar. Many errors are suppressed or not ch=
ecked,
> which could lead to silent data corruption. A particularly bad case is wh=
en a
> front-end sent escapes that Git doesn't recognize (e.g., hex escapes are =
not
> supported), it would be treated as literal bytes instead of a quoted stri=
ng.
>
> Bring path parsing into line with the documented behavior and improve
> documentation to fill in missing details.

Updated to address Junio's review comments. Thanks!

This round needed no code changes, so is probably ready, if the documentati=
on
changes look good.

Changes since v3:
* Reword documentation paragraphs on path quoting.
* Fix minor typo in commit message.

Thalia


Thalia Archibald (8):
  fast-import: tighten path unquoting
  fast-import: directly use strbufs for paths
  fast-import: allow unquoted empty path for root
  fast-import: remove dead strbuf
  fast-import: improve documentation for path quoting
  fast-import: document C-style escapes for paths
  fast-import: forbid escaped NUL in paths
  fast-import: make comments more precise

 Documentation/git-fast-import.txt |  31 +-
 builtin/fast-import.c             | 158 ++++----
 t/t9300-fast-import.sh            | 624 +++++++++++++++++++++---------
 3 files changed, 551 insertions(+), 262 deletions(-)

Range-diff against v3:
1:  d9ab0c6a75 =3D 1:  d6ea8aca46 fast-import: tighten path unquoting
2:  696ca27bb7 =3D 2:  9499f34aae fast-import: directly use strbufs for pat=
hs
3:  39879d0a66 ! 3:  9b1e6b80f5 fast-import: allow unquoted empty path for =
root
    @@ Commit message
         also be an empty string (`""`) to specify the root of the tree=
=E2=80=9D to =E2=80=9CThe
         root of the tree can be represented by an empty string as `<path>`=
=E2=80=9D.
    =20
    -    Thus, we can assume that some front-ends have depended on this beh=
avior.
    +    Thus, we should assume that some front-ends have depended on this
    +    behavior.
    =20
         Remove this restriction for the destination paths of filecopy and
         filerename and change tests targeting the root to test `""` and ``=
.
4:  1cef05e59a =3D 4:  1a2b0dc616 fast-import: remove dead strbuf
5:  2e78690023 ! 5:  fb0d870d53 fast-import: improve documentation for unqu=
oted paths
    @@ Metadata
     Author: Thalia Archibald <thalia@archibald.dev>
    =20
      ## Commit message ##
    -    fast-import: improve documentation for unquoted paths
    +    fast-import: improve documentation for path quoting
    =20
    -    It describes what cannot be in an unquoted path, but not what it i=
s.
    -    Reframe it as a definition of unquoted paths. The requirement that=
 it
    -    not start with `"` is the core element that implies the rest.
    +    It describes what characters cannot be in an unquoted path, but no=
t
    +    their semantics. Reframe it as a definition of unquoted paths. Fro=
m the
    +    perspective of the parser, whether it starts with `"` is what defi=
nes
    +    whether it will parse it as quoted or unquoted.
    +
    +    The restrictions on characters in unquoted paths (with starting-",=
 LF,
    +    and spaces) are explained in the quoted paragraph. Move it to the
    +    unquoted paragraph and reword.
    =20
         The restriction that the source paths of filecopy and filerename c=
annot
         contain SP is only stated in their respective sections. Restate it=
 in
    @@ Documentation/git-fast-import.txt: in octal.  Git only supports the =
following mo
     -A `<path>` string must use UNIX-style directory separators (forward
     -slash `/`), may contain any byte other than `LF`, and must not
     -start with double quote (`"`).
    -+A `<path>` can be written as unquoted bytes or a C-style quoted strin=
g:
    ++A `<path>` can be written as unquoted bytes or a C-style quoted strin=
g.
     =20
     -A path can use C-style string quoting; this is accepted in all cases
     -and mandatory if the filename starts with double quote or contains
     -`LF`. In C-style quoting, the complete name should be surrounded with
    -+When a `<path>` does not start with double quote (`"`), it is an
    +-double quotes, and any `LF`, backslash, or double quote characters
    +-must be escaped by preceding them with a backslash (e.g.,
    +-`"path/with\n, \\ and \" in it"`).
    ++When a `<path>` does not start with a double quote (`"`), it is an
     +unquoted string and is parsed as literal bytes without any escape
     +sequences. However, if the filename contains `LF` or starts with doub=
le
    -+quote, it must be written as a quoted string. Additionally, the sourc=
e
    -+`<path>` in `filecopy` or `filerename` must be quoted if it contains =
SP.
    -+
    -+A `<path>` can use C-style string quoting; this is accepted in all ca=
ses
    -+and mandatory in the cases where the filename cannot be represented a=
s
    -+an unquoted string. In C-style quoting, the complete name should be s=
urrounded with
    - double quotes, and any `LF`, backslash, or double quote characters
    - must be escaped by preceding them with a backslash (e.g.,
    - `"path/with\n, \\ and \" in it"`).
    ++quote, it cannot be represented as an unquoted string and must be
    ++quoted. Additionally, the source `<path>` in `filecopy` or `filerenam=
e`
    ++must be quoted if it contains SP.
     =20
     -The value of `<path>` must be in canonical form. That is it must not:
    ++When a `<path>` starts with a double quote (`"`), it is a C-style quo=
ted
    ++string, where the complete filename is enclosed in a pair of double
    ++quotes and escape sequences are used. Certain characters must be esca=
ped
    ++by preceding them with a backslash: `LF` is written as `\n`, backslas=
h
    ++as `\\`, and double quote as `\"`. All filenames can be represented a=
s
    ++quoted strings.
    ++
     +A `<path>` must use UNIX-style directory separators (forward slash `/=
`)
    -+and must be in canonical form. That is it must not:
    ++and its value must be in canonical form. That is it must not:
     =20
      * contain an empty directory component (e.g. `foo//bar` is invalid),
      * end with a directory separator (e.g. `foo/` is invalid),
6:  1b07ddffe0 ! 6:  4b6017ded8 fast-import: document C-style escapes for p=
aths
    @@ Commit message
         Signed-off-by: Thalia Archibald <thalia@archibald.dev>
    =20
      ## Documentation/git-fast-import.txt ##
    -@@ Documentation/git-fast-import.txt: quote, it must be written as a q=
uoted string. Additionally, the source
    -=20
    - A `<path>` can use C-style string quoting; this is accepted in all ca=
ses
    - and mandatory in the cases where the filename cannot be represented a=
s
    --an unquoted string. In C-style quoting, the complete name should be s=
urrounded with
    --double quotes, and any `LF`, backslash, or double quote characters
    --must be escaped by preceding them with a backslash (e.g.,
    --`"path/with\n, \\ and \" in it"`).
    -+an unquoted string. In C-style quoting, the complete filename is
    -+surrounded with double quote (`"`) and certain characters must be
    -+escaped by preceding them with a backslash: `LF` is written as `\n`,
    -+backslash as `\\`, and double quote as `\"`. Some characters may may
    -+optionally be written with escape sequences: `\a` for bell, `\b` for
    -+backspace, `\f` for form feed, `\n` for line feed, `\r` for carriage
    -+return, `\t` for horizontal tab, and `\v` for vertical tab. Any byte =
can
    -+be written with 3-digit octal codes (e.g., `\033`).
    +@@ Documentation/git-fast-import.txt: When a `<path>` starts with a do=
uble quote (`"`), it is a C-style quoted
    + string, where the complete filename is enclosed in a pair of double
    + quotes and escape sequences are used. Certain characters must be esca=
ped
    + by preceding them with a backslash: `LF` is written as `\n`, backslas=
h
    +-as `\\`, and double quote as `\"`. All filenames can be represented a=
s
    ++as `\\`, and double quote as `\"`. Some characters may optionally be
    ++written with escape sequences: `\a` for bell, `\b` for backspace, `\f=
`
    ++for form feed, `\n` for line feed, `\r` for carriage return, `\t` for
    ++horizontal tab, and `\v` for vertical tab. Any byte can be written wi=
th
    ++3-digit octal codes (e.g., `\033`). All filenames can be represented =
as
    + quoted strings.
     =20
      A `<path>` must use UNIX-style directory separators (forward slash `/=
`)
    - and must be in canonical form. That is it must not:
    =20
      ## t/t9300-fast-import.sh ##
     @@ t/t9300-fast-import.sh: test_path_eol_success () {
7:  dc67464b6a =3D 7:  5b464f4b01 fast-import: forbid escaped NUL in paths
8:  5e02d887bc =3D 8:  6eb66fce45 fast-import: make comments more precise
--=20
2.44.0

