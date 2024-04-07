Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9C3E3C082
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 21:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712524770; cv=none; b=qUgg+RyrvyrW0LLXVtHy9nydK0MFvAK0sAJN5F42414sSMhhWtXJ2gtAeaKYJDzNuOl2fAPbI5vGJoTMhoHHgEoeOllOTLcXmkVyTQOVDcBnIr0Yh06SDeV7+LM3QEcitivsN4J8GIdsBvqSEDkVtTpddJ31MpjhjPnwOIGGe5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712524770; c=relaxed/simple;
	bh=S+R0mT1vtplQxoA5ZBEOt4QlbNYOi2m4Nn1NnCK5mzo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FK4TQrEYRbpgP4Me3AChjwePxc0ln8y34oruCjFe54VOk9obQJU17FGkdskgpsCIE9Pdn7z7TAAXAdiKCN+WZ7d5EB6cBMZcEILXHMcxeC3mp2eCGERmUMFKxottQ0E7t5jTLMjFI3iDWuYv/lZ+lWFopY/v1tfsG84plpm3P5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev; spf=pass smtp.mailfrom=archibald.dev; dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b=qcEuck55; arc=none smtp.client-ip=185.70.43.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=archibald.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=archibald.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=archibald.dev header.i=@archibald.dev header.b="qcEuck55"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archibald.dev;
	s=protonmail3; t=1712524757; x=1712783957;
	bh=kBJPguwJTJCXUgaqkSPwPZTbq+FUldQqNaf1qCoc13s=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=qcEuck55VIALueV0UNXeNA0qMLlteUuQMmJKox7qdJxeThreCAS/OutdHj5YMuxbQ
	 Ug+deC40IX/uKQG12AL+Y5SJbo1vIpaBjYJuUmBBewvdtyoF/GHn1jQ8V38VFW7VZe
	 UyfuELkIiXxTTmPTNR9gnS64HIkAMSlPbwvenXFGl4jmQHDvUDbBIatikGSm9kJyRS
	 uE2NOznf08QacPG4szD7er3f/ZQstDNVZjcfKvdv1oh6US8uybPraqFWYit6crYA6C
	 tl8/MVxZUXXEFWlSxOx/gbhYFRCOIhI2QT/4MfO5RJxc1hkf8aQHp/QezdmL76nbqQ
	 SQo/zNHbB8xYw==
Date: Sun, 07 Apr 2024 21:19:08 +0000
To: Patrick Steinhardt <ps@pks.im>
From: Thalia Archibald <thalia@archibald.dev>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, Elijah Newren <newren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 0/8] fast-import: tighten parsing of paths
Message-ID: <A820E635-14FA-403C-B932-D7F9FE57C092@archibald.dev>
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

On Apr 1, 2024, at 02:02, Thalia Archibald wrote:
>> fast-import has subtle differences in how it parses file paths between e=
ach
>> occurrence of <path> in the grammar. Many errors are suppressed or not c=
hecked,
>> which could lead to silent data corruption. A particularly bad case is w=
hen a
>> front-end sent escapes that Git doesn't recognize (e.g., hex escapes are=
 not
>> supported), it would be treated as literal bytes instead of a quoted str=
ing.
>>=20
>> Bring path parsing into line with the documented behavior and improve
>> documentation to fill in missing details.
>=20
> Thanks for the review, Patrick. I've made several changes, which I think =
address
> your feedback. What's the protocol for adding `Reviewed-by`? Since I don'=
t know
> whether I, you, or Junio add it, I've refrained from attaching your name =
to
> these patches.

Hello! Friendly ping here. It=E2=80=99s been a week since the last emails f=
or this patch
set, so I=E2=80=99d like to check in on the status.

As a new contributor to the project, I don=E2=80=99t yet have a full view o=
f the
contribution flow, aside from what I=E2=80=99ve read. I suspect the latency=
 is because I
may not have cc=E2=80=99d all the area experts. (When I sent v1, I used sep=
arate Cc
lines in send-email --compose, but it dropped all but the last. After Patri=
ck
reviewed it, I figured I could leave the cc list as-is for v2, assuming I=
=E2=80=99d get
another review.) I=E2=80=99ve now cc=E2=80=99d everyone listed by contrib/c=
ontacts, as well as
the maintainer. For anyone not a part of the earlier discussion, the latest
version is at https://lore.kernel.org/git/cover.1711960552.git.thalia@archi=
bald.dev/.
If that=E2=80=99s not the problem, I=E2=80=99d be keen to know what I could=
 do better.

I have several more patch sets in the works, that I=E2=80=99ve held back on=
 sending
until this one is finished, in case I=E2=80=99ve been doing something wrong=
. I want to
move forward. Thank you for your time.

Thalia

> Changes since v1:
> * In fast-import:
>  * Move `strbuf_release` outside of `parse_path_space` and `parse_path_eo=
l`.
>  * Retain allocations for static `strbuf`s.
>  * Rename `allow_spaces` parameter of `parse_path` to `include_spaces`.
>  * Extract change to neighboring comments as patch 8.
> * In tests:
>  * Test `` for the root path additionally in all tests using `""`.
>  * Pass all arguments by positional variables.
>  * Use `local`.
>  * Use `test_when_finished` instead of manual cleanup.
> * In documentation:
>  * Better document conditions under which a path is considered quoted or
>    unquoted.
> * Reword commit messages.
>=20
> Thalia
>=20
>=20
> Thalia Archibald (8):
>  fast-import: tighten path unquoting
>  fast-import: directly use strbufs for paths
>  fast-import: allow unquoted empty path for root
>  fast-import: remove dead strbuf
>  fast-import: improve documentation for unquoted paths
>  fast-import: document C-style escapes for paths
>  fast-import: forbid escaped NUL in paths
>  fast-import: make comments more precise
>=20
> Documentation/git-fast-import.txt |  30 +-
> builtin/fast-import.c             | 156 ++++----
> t/t9300-fast-import.sh            | 617 +++++++++++++++++++++---------
> 3 files changed, 541 insertions(+), 262 deletions(-)
>=20
> Range-diff against v1:
> 1:  8d9e0b25cb ! 1:  e790bdf714 fast-import: tighten parsing of paths
>    @@ Metadata
>     Author: Thalia Archibald <thalia@archibald.dev>
>=20
>      ## Commit message ##
>    -    fast-import: tighten parsing of paths
>    +    fast-import: tighten path unquoting
>=20
>         Path parsing in fast-import is inconsistent and many unquoting er=
rors
>    -    are suppressed.
>    +    are suppressed or not checked.
>=20
>    -    `<path>` appears in the grammar in these places:
>    +    <path> appears in the grammar in these places:
>=20
>             filemodify ::=3D 'M' SP <mode> (<dataref> | 'inline') SP <pat=
h> LF
>             filedelete ::=3D 'D' SP <path> LF
>    @@ Commit message
>         and fast-import.c parses them in five different ways:
>=20
>         1. For filemodify and filedelete:
>    -       If `<path>` is a valid quoted string, unquote it;
>    -       otherwise, treat it as literal bytes (including any number of =
SP).
>    +       Try to unquote <path>. If it unquotes without errors, use the
>    +       unquoted version; otherwise, treat it as literal bytes to the =
end of
>    +       the line (including any number of SP).
>         2. For filecopy (source) and filerename (source):
>    -       If `<path>` is a valid quoted string, unquote it;
>    -       otherwise, treat it as literal bytes until the next SP.
>    +       Try to unquote <path>. If it unquotes without errors, use the
>    +       unquoted version; otherwise, treat it as literal bytes up to, =
but not
>    +       including, the next SP.
>         3. For filecopy (dest) and filerename (dest):
>    -       Like 1., but an unquoted empty string is an error.
>    +       Like 1., but an unquoted empty string is forbidden.
>         4. For ls:
>    -       If `<path>` starts with `"`, unquote it and report parse error=
s;
>    -       otherwise, treat it as literal bytes (including any number of =
SP).
>    +       If <path> starts with `"`, unquote it and report parse errors;
>    +       otherwise, treat it as literal bytes to the end of the line
>    +       (including any number of SP).
>         5. For ls-commit:
>    -       Unquote `<path>` and report parse errors.
>    +       Unquote <path> and report parse errors.
>            (It must start with `"` to disambiguate from ls.)
>=20
>         In the first three, any errors from trying to unquote a string ar=
e
>         suppressed, so a quoted string that contains invalid escapes woul=
d be
>         interpreted as literal bytes. For example, `"\xff"` would fail to
>         unquote (because hex escapes are not supported), and it would ins=
tead be
>    -    interpreted as the byte sequence `"` `\` `x` `f` `f` `"`, which i=
s
>    +    interpreted as the byte sequence '"', '\\', 'x', 'f', 'f', '"', w=
hich is
>         certainly not intended. Some front-ends erroneously use their lan=
guage's
>    -    standard quoting routine and could silently introduce escapes tha=
t would
>    -    be incorrectly parsed due to this.
>    +    standard quoting routine instead of matching Git's, which could s=
ilently
>    +    introduce escapes that would be incorrectly parsed due to this an=
d lead
>    +    to data corruption.
>=20
>    -    The documentation states that =E2=80=9CTo use a source path that =
contains SP the
>    -    path must be quoted.=E2=80=9D, so it is expected that some implem=
entations
>    -    depend on spaces being allowed in paths in the final position. Th=
us we
>    -    have two documented ways to parse paths, so simplify the implemen=
tation
>    -    to that.
>    +    The documentation states =E2=80=9CTo use a source path that conta=
ins SP the path
>    +    must be quoted.=E2=80=9D, so it is expected that some implementat=
ions depend on
>    +    spaces being allowed in paths in the final position. Thus we have=
 two
>    +    documented ways to parse paths, so simplify the implementation to=
 that.
>=20
>         Now we have:
>=20
>         1. `parse_path_eol` for filemodify, filedelete, filecopy (dest),
>            filerename (dest), ls, and ls-commit:
>=20
>    -       If `<path>` starts with `"`, unquote it and report parse error=
s;
>    -       otherwise, treat it as literal bytes (including any number of =
SP).
>    -       Garbage after a quoted string or an unquoted empty string are =
errors.
>    -       (In ls-commit, it must be quoted to disambiguate from ls.)
>    +       If <path> starts with `"`, unquote it and report parse errors;
>    +       otherwise, treat it as literal bytes to the end of the line
>    +       (including any number of SP).
>=20
>         2. `parse_path_space` for filecopy (source) and filerename (sourc=
e):
>=20
>    -       If `<path>` starts with `"`, unquote it and report parse error=
s;
>    -       otherwise, treat it as literal bytes until the next SP.
>    -       It must be followed by a SP. An unquoted empty string is an er=
ror.
>    +       If <path> starts with `"`, unquote it and report parse errors;
>    +       otherwise, treat it as literal bytes up to, but not including,=
 the
>    +       next SP. It must be followed by SP.
>    +
>    +    There remain two special cases: The dest <path> in filecopy and r=
ename
>    +    cannot be an unquoted empty string (this will be addressed subseq=
uently)
>    +    and <path> in ls-commit must be quoted to disambiguate it from ls=
.
>=20
>         Signed-off-by: Thalia Archibald <thalia@archibald.dev>
>=20
>    - ## Documentation/git-fast-import.txt ##
>    -@@ Documentation/git-fast-import.txt: The value of `<path>` must be i=
n canonical form. That is it must not:
>    - * contain the special component `.` or `..` (e.g. `foo/./bar` and
>    -   `foo/../bar` are invalid).
>    -
>    --The root of the tree can be represented by an empty string as `<path=
>`.
>    -+The root of the tree can be represented by a quoted empty string (`"=
"`)
>    -+as `<path>`.
>    -
>    - It is recommended that `<path>` always be encoded using UTF-8.
>    -
>    -
>      ## builtin/fast-import.c ##
>    -@@ builtin/fast-import.c: static int parse_mapped_oid_hex(const char =
*hex, struct object_id *oid, const ch
>    -  *
>    -  *   idnum ::=3D ':' bigint;
>    -  *
>    -- * Return the first character after the value in *endptr.
>    -+ * Update *endptr to point to the first character after the value.
>    -  *
>    -  * Complain if the following character is not what is expected,
>    -  * either a space or end of the string.
>    -@@ builtin/fast-import.c: static uintmax_t parse_mark_ref_eol(const c=
har *p)
>    - }
>    -
>    - /*
>    -- * Parse the mark reference, demanding a trailing space.  Return a
>    -- * pointer to the space.
>    -+ * Parse the mark reference, demanding a trailing space. Update *p t=
o
>    -+ * point to the first character after the space.
>    -  */
>    - static uintmax_t parse_mark_ref_space(const char **p)
>    - {
>     @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const=
 char **p)
>       return mark;
>      }
>    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const =
char **p)
>     +/*
>     + * Parse the path string into the strbuf. It may be quoted with esca=
pe sequences
>     + * or unquoted without escape sequences. When unquoted, it may only =
contain a
>    -+ * space if `allow_spaces` is nonzero.
>    ++ * space if `include_spaces` is nonzero.
>     + */
>    -+static void parse_path(struct strbuf *sb, const char *p, const char =
**endp, int allow_spaces, const char *field)
>    ++static void parse_path(struct strbuf *sb, const char *p, const char =
**endp, int include_spaces, const char *field)
>     +{
>    -+ strbuf_reset(sb);
>     + if (*p =3D=3D '"') {
>     + if (unquote_c_style(sb, p, endp))
>     + die("Invalid %s: %s", field, command_buf.buf);
>     + } else {
>    -+ if (allow_spaces)
>    ++ if (include_spaces)
>     + *endp =3D p + strlen(p);
>     + else
>     + *endp =3D strchr(p, ' ');
>    -+ if (*endp =3D=3D p)
>    -+ die("Missing %s: %s", field, command_buf.buf);
>     + strbuf_add(sb, p, *endp - p);
>     + }
>     +}
>    @@ builtin/fast-import.c: static uintmax_t parse_mark_ref_space(const =
char **p)
>       struct object_id oid;
>       uint16_t mode, inline_data =3D 0;
>     @@ builtin/fast-import.c: static void file_change_m(const char *p, st=
ruct branch *b)
>    - die("Missing space after SHA1: %s", command_buf.buf);
>       }
>=20
>    -- strbuf_reset(&uq);
>    + strbuf_reset(&uq);
>     - if (!unquote_c_style(&uq, p, &endp)) {
>     - if (*endp)
>     - die("Garbage after path in: %s", command_buf.buf);
>    @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b
>       static struct strbuf uq =3D STRBUF_INIT;
>     - const char *endp;
>=20
>    -- strbuf_reset(&uq);
>    + strbuf_reset(&uq);
>     - if (!unquote_c_style(&uq, p, &endp)) {
>     - if (*endp)
>     - die("Garbage after path in: %s", command_buf.buf);
>    @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b
>     - const char *endp;
>       struct tree_entry leaf;
>=20
>    -- strbuf_reset(&s_uq);
>    + strbuf_reset(&s_uq);
>     - if (!unquote_c_style(&s_uq, s, &endp)) {
>     - if (*endp !=3D ' ')
>     - die("Missing space after source: %s", command_buf.buf);
>    @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b
>     - strbuf_add(&s_uq, s, endp - s);
>     - }
>     + parse_path_space(&s_uq, p, &p, "source");
>    -+ parse_path_eol(&d_uq, p, "dest");
>       s =3D s_uq.buf;
>    --
>    +
>     - endp++;
>     - if (!*endp)
>    -- die("Missing dest: %s", command_buf.buf);
>    ++ if (!p)
>    + die("Missing dest: %s", command_buf.buf);
>     -
>     - d =3D endp;
>    -- strbuf_reset(&d_uq);
>    + strbuf_reset(&d_uq);
>     - if (!unquote_c_style(&d_uq, d, &endp)) {
>     - if (*endp)
>     - die("Garbage after dest in: %s", command_buf.buf);
>     - d =3D d_uq.buf;
>     - }
>    ++ parse_path_eol(&d_uq, p, "dest");
>     + d =3D d_uq.buf;
>=20
>       memset(&leaf, 0, sizeof(leaf));
>       if (rename)
>    -@@ builtin/fast-import.c: static void parse_ls(const char *p, struct =
branch *b)
>    +@@ builtin/fast-import.c: static void print_ls(int mode, const unsign=
ed char *hash, const char *path)
>    +
>    + static void parse_ls(const char *p, struct branch *b)
>      {
>    ++ static struct strbuf uq =3D STRBUF_INIT;
>       struct tree_entry *root =3D NULL;
>       struct tree_entry leaf =3D {NULL};
>    -+ static struct strbuf uq =3D STRBUF_INIT;
>=20
>    - /* ls SP (<tree-ish> SP)? <path> */
>    - if (*p =3D=3D '"') {
>     @@ builtin/fast-import.c: static void parse_ls(const char *p, struct =
branch *b)
>       root->versions[1].mode =3D S_IFDIR;
>       load_tree(root);
>    @@ builtin/fast-import.c: static void parse_ls(const char *p, struct b=
ranch *b)
>     - die("Garbage after path in: %s", command_buf.buf);
>     - p =3D uq.buf;
>     - }
>    ++ strbuf_reset(&uq);
>     + parse_path_eol(&uq, p, "path");
>     + p =3D uq.buf;
>       tree_content_get(root, p, &leaf, 1);
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     +# Path parsing
>     +#
>     +# There are two sorts of ways a path can be parsed, depending on whe=
ther it is
>    -+# the last field on the line. Additionally, ls without a <tree-ish> =
has a
>    -+# special case. Test every occurrence of <path> in the grammar again=
st every
>    -+# error case.
>    ++# the last field on the line. Additionally, ls without a <dataref> h=
as a special
>    ++# case. Test every occurrence of <path> in the grammar against every=
 error case.
>     +#
>     +
>     +#
>     +# Valid paths at the end of a line: filemodify, filedelete, filecopy=
 (dest),
>     +# filerename (dest), and ls.
>     +#
>    -+# commit :301 from root -- modify hello.c
>    ++# commit :301 from root -- modify hello.c (for setup)
>     +# commit :302 from :301 -- modify $path
>     +# commit :303 from :302 -- delete $path
>     +# commit :304 from :301 -- copy hello.c $path
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     +# ls :305 $path
>     +#
>     +test_path_eol_success () {
>    -+ test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
>    ++ local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
>     + test_expect_success "S: paths at EOL with $test must work" '
>    ++ test_when_finished "git branch -D S-path-eol" &&
>    ++
>     + git fast-import --export-marks=3Dmarks.out <<-EOF >out 2>err &&
>     + blob
>     + mark :401
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + hallo welt
>     + BLOB
>     +
>    -+ commit refs/heads/path-eol
>    ++ commit refs/heads/S-path-eol
>     + mark :301
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + COMMIT
>     + M 100644 :401 hello.c
>     +
>    -+ commit refs/heads/path-eol
>    ++ commit refs/heads/S-path-eol
>     + mark :302
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + from :301
>     + M 100644 :402 '"$path"'
>     +
>    -+ commit refs/heads/path-eol
>    ++ commit refs/heads/S-path-eol
>     + mark :303
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + from :302
>     + D '"$path"'
>     +
>    -+ commit refs/heads/path-eol
>    ++ commit refs/heads/S-path-eol
>     + mark :304
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + from :301
>     + C hello.c '"$path"'
>     +
>    -+ commit refs/heads/path-eol
>    ++ commit refs/heads/S-path-eol
>     + mark :305
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + git ls-tree $commit_r >tree_r.out &&
>     + test_cmp tree_r.exp tree_r.out &&
>     +
>    -+ test_cmp out tree_r.exp &&
>    -+
>    -+ git branch -D path-eol
>    ++ test_cmp out tree_r.exp
>     + '
>     +}
>     +
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     +#
>     +# Valid paths before a space: filecopy (source) and filerename (sour=
ce).
>     +#
>    -+# commit :301 from root -- modify $path
>    ++# commit :301 from root -- modify $path (for setup)
>     +# commit :302 from :301 -- copy $path hello2.c
>     +# commit :303 from :301 -- rename $path hello2.c
>     +#
>     +test_path_space_success () {
>    -+ test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
>    ++ local test=3D"$1" path=3D"$2" unquoted_path=3D"$3"
>     + test_expect_success "S: paths before space with $test must work" '
>    ++ test_when_finished "git branch -D S-path-space" &&
>    ++
>     + git fast-import --export-marks=3Dmarks.out <<-EOF 2>err &&
>     + blob
>     + mark :401
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + hello world
>     + BLOB
>     +
>    -+ commit refs/heads/path-space
>    ++ commit refs/heads/S-path-space
>     + mark :301
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + COMMIT
>     + M 100644 :401 '"$path"'
>     +
>    -+ commit refs/heads/path-space
>    ++ commit refs/heads/S-path-space
>     + mark :302
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     + from :301
>     + C '"$path"' hello2.c
>     +
>    -+ commit refs/heads/path-space
>    ++ commit refs/heads/S-path-space
>     + mark :303
>     + committer $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER=
_DATE
>     + data <<COMMIT
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     +
>     + printf "100644 blob $blob\thello2.c\n" >tree_r.exp &&
>     + git ls-tree $commit_r >tree_r.out &&
>    -+ test_cmp tree_r.exp tree_r.out &&
>    -+
>    -+ git branch -D path-space
>    ++ test_cmp tree_r.exp tree_r.out
>     + '
>     +}
>     +
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     +# of <path> in the grammar against all error kinds.
>     +#
>     +test_path_fail () {
>    -+ what=3D"$1" path=3D"$2" err_grep=3D"$3"
>    ++ local change=3D"$1" what=3D"$2" prefix=3D"$3" path=3D"$4" suffix=3D=
"$5" err_grep=3D"$6"
>     + test_expect_success "S: $change with $what must fail" '
>     + test_must_fail git fast-import <<-EOF 2>err &&
>     + blob
>    @@ t/t9300-fast-import.sh: test_expect_success 'S: ls with garbage aft=
er sha1 must
>     +}
>     +
>     +test_path_base_fail () {
>    -+ test_path_fail 'unclosed " in '"$field"          '"hello.c'    "Inv=
alid $field"
>    -+ test_path_fail "invalid escape in quoted $field" '"hello\xff"' "Inv=
alid $field"
>    ++ local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
>    ++ test_path_fail "$change" 'unclosed " in '"$field"          "$prefix=
" '"hello.c'    "$suffix" "Invalid $field"
>    ++ test_path_fail "$change" "invalid escape in quoted $field" "$prefix=
" '"hello\xff"' "$suffix" "Invalid $field"
>     +}
>     +test_path_eol_quoted_fail () {
>    -+ test_path_base_fail
>    -+ test_path_fail "garbage after quoted $field" '"hello.c"x' "Garbage =
after $field"
>    -+ test_path_fail "space after quoted $field"   '"hello.c" ' "Garbage =
after $field"
>    ++ local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
>    ++ test_path_base_fail "$change" "$prefix" "$field" "$suffix"
>    ++ test_path_fail "$change" "garbage after quoted $field" "$prefix" '"=
hello.c"x' "$suffix" "Garbage after $field"
>    ++ test_path_fail "$change" "space after quoted $field"   "$prefix" '"=
hello.c" ' "$suffix" "Garbage after $field"
>     +}
>     +test_path_eol_fail () {
>    -+ test_path_eol_quoted_fail
>    -+ test_path_fail 'empty unquoted path' '' "Missing $field"
>    ++ local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
>    ++ test_path_eol_quoted_fail "$change" "$prefix" "$field" "$suffix"
>     +}
>     +test_path_space_fail () {
>    -+ test_path_base_fail
>    -+ test_path_fail 'empty unquoted path' '' "Missing $field"
>    -+ test_path_fail "missing space after quoted $field" '"hello.c"x' "Mi=
ssing space after $field"
>    ++ local change=3D"$1" prefix=3D"$2" field=3D"$3" suffix=3D"$4"
>    ++ test_path_base_fail "$change" "$prefix" "$field" "$suffix"
>    ++ test_path_fail "$change" "missing space after quoted $field" "$pref=
ix" '"hello.c"x' "$suffix" "Missing space after $field"
>     +}
>     +
>    -+change=3Dfilemodify       prefix=3D'M 100644 :1 ' field=3Dpath   suf=
fix=3D''         test_path_eol_fail
>    -+change=3Dfiledelete       prefix=3D'D '           field=3Dpath   suf=
fix=3D''         test_path_eol_fail
>    -+change=3Dfilecopy         prefix=3D'C '           field=3Dsource suf=
fix=3D' world.c' test_path_space_fail
>    -+change=3Dfilecopy         prefix=3D'C hello.c '   field=3Ddest   suf=
fix=3D''         test_path_eol_fail
>    -+change=3Dfilerename       prefix=3D'R '           field=3Dsource suf=
fix=3D' world.c' test_path_space_fail
>    -+change=3Dfilerename       prefix=3D'R hello.c '   field=3Ddest   suf=
fix=3D''         test_path_eol_fail
>    -+change=3D'ls (in commit)' prefix=3D'ls :2 '       field=3Dpath   suf=
fix=3D''         test_path_eol_fail
>    ++test_path_eol_fail   filemodify       'M 100644 :1 ' path   ''
>    ++test_path_eol_fail   filedelete       'D '           path   ''
>    ++test_path_space_fail filecopy         'C '           source ' world.=
c'
>    ++test_path_eol_fail   filecopy         'C hello.c '   dest   ''
>    ++test_path_space_fail filerename       'R '           source ' world.=
c'
>    ++test_path_eol_fail   filerename       'R hello.c '   dest   ''
>    ++test_path_eol_fail   'ls (in commit)' 'ls :2 '       path   ''
>     +
>    -+# When 'ls' has no <tree-ish>, the <path> must be quoted.
>    -+change=3D'ls (without tree-ish in commit)' prefix=3D'ls ' field=3Dpa=
th suffix=3D'' \
>    -+test_path_eol_quoted_fail &&
>    -+test_path_fail 'empty unquoted path' '' "Invalid dataref"
>    ++# When 'ls' has no <dataref>, the <path> must be quoted.
>    ++test_path_eol_quoted_fail 'ls (without dataref in commit)' 'ls ' pat=
h ''
>     +
>      ###
>      ### series T (ls)
> 2:  a2aca9f9e6 ! 2:  82a6f53c13 fast-import: directly use strbufs for pat=
hs
>    @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b
>       die("Missing space after SHA1: %s", command_buf.buf);
>       }
>=20
>    +- strbuf_reset(&uq);
>     - parse_path_eol(&uq, p, "path");
>     - p =3D uq.buf;
>    ++ strbuf_reset(&path);
>     + parse_path_eol(&path, p, "path");
>=20
>       /* Git does not track empty, non-toplevel directories. */
>    @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b
>     - static struct strbuf uq =3D STRBUF_INIT;
>     + static struct strbuf path =3D STRBUF_INIT;
>=20
>    +- strbuf_reset(&uq);
>     - parse_path_eol(&uq, p, "path");
>     - p =3D uq.buf;
>     - tree_content_remove(&b->branch_tree, p, NULL, 1);
>    ++ strbuf_reset(&path);
>     + parse_path_eol(&path, p, "path");
>     + tree_content_remove(&b->branch_tree, path.buf, NULL, 1);
>      }
>    @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b
>     + static struct strbuf dest =3D STRBUF_INIT;
>       struct tree_entry leaf;
>=20
>    +- strbuf_reset(&s_uq);
>     - parse_path_space(&s_uq, p, &p, "source");
>    -- parse_path_eol(&d_uq, p, "dest");
>     - s =3D s_uq.buf;
>    -- d =3D d_uq.buf;
>    ++ strbuf_reset(&source);
>     + parse_path_space(&source, p, &p, "source");
>    +
>    + if (!p)
>    + die("Missing dest: %s", command_buf.buf);
>    +- strbuf_reset(&d_uq);
>    +- parse_path_eol(&d_uq, p, "dest");
>    +- d =3D d_uq.buf;
>    ++ strbuf_reset(&dest);
>     + parse_path_eol(&dest, p, "dest");
>=20
>       memset(&leaf, 0, sizeof(leaf));
>    @@ builtin/fast-import.c: static void file_change_m(const char *p, str=
uct branch *b
>       &leaf.versions[1].oid,
>       leaf.versions[1].mode,
>       leaf.tree);
>    -@@ builtin/fast-import.c: static void parse_ls(const char *p, struct =
branch *b)
>    +@@ builtin/fast-import.c: static void print_ls(int mode, const unsign=
ed char *hash, const char *path)
>    +
>    + static void parse_ls(const char *p, struct branch *b)
>      {
>    - struct tree_entry *root =3D NULL;
>    - struct tree_entry leaf =3D {NULL};
>     - static struct strbuf uq =3D STRBUF_INIT;
>     + static struct strbuf path =3D STRBUF_INIT;
>    + struct tree_entry *root =3D NULL;
>    + struct tree_entry leaf =3D {NULL};
>=20
>    - /* ls SP (<tree-ish> SP)? <path> */
>    - if (*p =3D=3D '"') {
>     @@ builtin/fast-import.c: static void parse_ls(const char *p, struct =
branch *b)
>       root->versions[1].mode =3D S_IFDIR;
>       load_tree(root);
>       }
>    +- strbuf_reset(&uq);
>     - parse_path_eol(&uq, p, "path");
>     - p =3D uq.buf;
>     - tree_content_get(root, p, &leaf, 1);
>    ++ strbuf_reset(&path);
>     + parse_path_eol(&path, p, "path");
>     + tree_content_get(root, path.buf, &leaf, 1);
>       /*
> 3:  ecaf4883d1 < -:  ---------- fast-import: release unfreed strbufs
> -:  ---------- > 3:  893bbf5e73 fast-import: allow unquoted empty path fo=
r root
> 4:  058a38416a ! 4:  cb05a184e6 fast-import: remove dead strbuf
>    @@ Metadata
>      ## Commit message ##
>         fast-import: remove dead strbuf
>=20
>    -    The strbuf in `note_change_n` has been unused since the function =
was
>    +    The strbuf in `note_change_n` is to copy the remainder of `p` bef=
ore
>    +    potentially invalidating it when reading the next line. However, =
`p` is
>    +    not used after that point. It has been unused since the function =
was
>         created in a8dd2e7d2b (fast-import: Add support for importing com=
mit
>         notes, 2009-10-09) and looks to be a fossil from adapting
>    -    `note_change_m`. Remove it.
>    +    `file_change_m`. Remove it.
>=20
>         Signed-off-by: Thalia Archibald <thalia@archibald.dev>
>=20
> 5:  a5e8df0759 < -:  ---------- fast-import: document C-style escapes for=
 paths
> 6:  9792940ba9 < -:  ---------- fast-import: forbid escaped NUL in paths
> -:  ---------- > 5:  1f34b632d7 fast-import: improve documentation for un=
quoted paths
> -:  ---------- > 6:  82a4da68af fast-import: document C-style escapes for=
 paths
> -:  ---------- > 7:  c087c6a860 fast-import: forbid escaped NUL in paths
> -:  ---------- > 8:  a503c55b83 fast-import: make comments more precise
> --
> 2.44.0


