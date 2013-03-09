From: Kirill Smelkov <kirr@navytux.spb.ru>
Subject: Re: [PATCH] format-patch: RFC 2047 says multi-octet character may
 not be split
Date: Sat, 9 Mar 2013 19:27:23 +0400
Organization: NAVYTUX.SPB.RU
Message-ID: <20130309152722.GA32248@mini.zxlink>
References: <1362568106-30741-1-git-send-email-kirr@mns.spb.ru>
 <7vd2vcqv1y.fsf@alter.siamese.dyndns.org>
 <20130307105430.GA3049@tugrik.mns.mnsspb.ru>
 <7vobevm6fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Dmitry Komissarov <dak@mnsspb.ru>, git@vger.kernel.org,
	Jan =?iso-8859-1?Q?H=2E_Sch=F6nherr?= <schnhrr@cs.tu-berlin.de>,
	kirr@mns.spb.ru
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 09 16:27:28 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UELgF-00061D-Cq
	for gcvg-git-2@plane.gmane.org; Sat, 09 Mar 2013 16:27:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758685Ab3CIP0x convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 9 Mar 2013 10:26:53 -0500
Received: from forward2.mail.yandex.net ([77.88.46.7]:33918 "EHLO
	forward2.mail.yandex.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758588Ab3CIP0w (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Mar 2013 10:26:52 -0500
Received: from smtp1.mail.yandex.net (smtp1.mail.yandex.net [77.88.46.101])
	by forward2.mail.yandex.net (Yandex) with ESMTP id A980B12A2E99;
	Sat,  9 Mar 2013 19:26:48 +0400 (MSK)
Received: from smtp1.mail.yandex.net (localhost [127.0.0.1])
	by smtp1.mail.yandex.net (Yandex) with ESMTP id 38B57AA00E4;
	Sat,  9 Mar 2013 19:26:48 +0400 (MSK)
Received: from unknown (unknown [78.25.120.190])
	by smtp1.mail.yandex.net (nwsmtp/Yandex) with ESMTP id QcHOPQfS-QjHWRE26;
	Sat,  9 Mar 2013 19:26:46 +0400
Received: from kirr by mini.zxlink with local (Exim 4.80)
	(envelope-from <kirr@mini.zxlink>)
	id 1UELgB-0003yK-5r; Sat, 09 Mar 2013 19:27:23 +0400
Content-Disposition: inline
In-Reply-To: <7vobevm6fp.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217729>

On Thu, Mar 07, 2013 at 10:05:30AM -0800, Junio C Hamano wrote:
> Kirill Smelkov <kirr@mns.spb.ru> writes:
>=20
> >> > @@ -367,16 +376,18 @@ static void add_rfc2047(struct strbuf *sb,=
 const char *line, int len,
> >> >  		 * causes ' ' to be encoded as '=3D20', avoiding this problem=
=2E
> >> >  		 */
> >> > =20
> >> > +		if (line_len + 2 + (is_special ? 3*chrlen : 1) > max_encoded_=
length) {
> >>=20
> >> Always have SP around binary operators such as '*' (multiplication=
).
> >
> > ok, but note that's just a matter of style, and if one is used to c=
ode
> > formulas,...
>=20
> Well, when working on a project with others, what _you_ are used to
> does not matter.  Also please never call coding style "just a matter
> of".  Keeping things consistent with the style around the area is a
> prerequisite.
>=20
>    When you have time:
>    Cf. https://www.youtube.com/watch?feature=3Dplayer_embedded&v=3DfM=
eH7wqOwXA

Junio, what Greg says here is all known and good and respected. I agree
coding style is not a "just a matter of" and is important to follow for
project to stay consisting. My note here was just a sentiment about
spaces around operators, which I didn't know was in the coding style
because it is not in Documentation/CodingGuidelines, and especially if
the project sometimes uses my style

    *offset =3D 60*off;                                       date.c   =
   5e2a78a4
    diff +=3D 7*n;                                            date.c   =
   6b7b0427
    sub_size < 2*window && i+1 < delta_search_threads       pack_object=
s.c  bf874896


But anyway, I'm ok with any style the project chooses - it's not so imp=
ortant
for me to insist here, so let it be "3 * chrlen" and lets forget about =
it.


> > Actually if we add encoded_len, adding encoded_fmt is tempting
> >
> >     const char *encoded_fmt =3D is_special ? "=3D%02X"    : "%c";
> >
> > and then encoding part simplifies to just unconditional
> >
> >     for (i =3D 0; i < chrlen; i++)
> >             strbuf_addf(sb, encoded_fmt, p[i]);
> >     line_len +=3D encoded_len;
>=20
> Sounds very sensible ;-)

Thanks.

> >  		 * for now, let's treat encodings !=3D UTF-8 as one-byte
> >  		 */
> >  		chrlen =3D 1;
> >
> > ---- 8< ----
> > From 46b9cddc63c07cb5513cfbf6d20aaaa98c66bcdf Mon Sep 17 00:00:00 2=
001
> > From: Kirill Smelkov <kirr@mns.spb.ru>
> > Date: Wed, 6 Mar 2013 14:28:46 +0400
> > Subject: [PATCH v2] format-patch: RFC 2047 says multi-octet charact=
er may not be split
>=20
> Good use of scissors line; but please drop these four lines after
> it.  The first is unwanted and the rest are redundant.
>=20
> > Even though an earlier attempt (bafc478..41dd00bad) cleaned
> > up RFC 2047 encoding, pretty.c::add_rfc2047() still decides
> > where to split the output line by going through the input
> > ...
> > @@ -367,18 +380,15 @@ static void add_rfc2047(struct strbuf *sb, co=
nst char *line, int len,
> >  		 * causes ' ' to be encoded as '=3D20', avoiding this problem.
> >  		 */
> > =20
> > -		if (line_len + 2 + (is_special ? 3 : 1) > max_encoded_length) {
> > +		if (line_len + encoded_len + /* ?=3D */2 > max_encoded_length) {
> > +			/* It will not fit---break the line */
>=20
> It doesn't look much clearer with /* ?=3D */ unless we say something
> that contains the word "close", e.g. "?=3D to close the encoded part"=
=2E
> Maybe it is just me.

How about

        if (line_len + encoded_len + 2 > max_encoded_length) {
                /* It won't fit with trailing "?=3D" --- break the line=
 */

?

>=20
> > -		if (is_special) {
> > -			strbuf_addf(sb, "=3D%02X", ch);
> > -			line_len +=3D 3;
> > -		} else {
> > -			strbuf_addch(sb, ch);
> > -			line_len++;
> > -		}
> > +		for (i =3D 0; i < chrlen; i++)
> > +			strbuf_addf(sb, encoded_fmt, p[i]);
> > +		line_len +=3D encoded_len;
>=20
> Nice code reduction.

Thanks.

Interdiff and updated patch follow. Note I'm sending this from home, so
'From:' line after scissors is kept as necessary.

Kirill

P.S. sorry for the delay - I harmed my arm yesterday.


diff --git a/pretty.c b/pretty.c
index 8fce619..41f04e6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -380,8 +380,8 @@ static void add_rfc2047(struct strbuf *sb, const ch=
ar *line, size_t len,
 		 * causes ' ' to be encoded as '=3D20', avoiding this problem.
 		 */
=20
-		if (line_len + encoded_len + /* ?=3D */2 > max_encoded_length) {
-			/* It will not fit---break the line */
+		if (line_len + encoded_len + 2 > max_encoded_length) {
+			/* It won't fit with trailing "?=3D" --- break the line */
 			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
 			line_len =3D strlen(encoding) + 5 + 1; /* =3D??q? plus SP */
 		}

---- 8< ----
=46rom: Kirill Smelkov <kirr@mns.spb.ru>
 split

Even though an earlier attempt (bafc478..41dd00bad) cleaned
up RFC 2047 encoding, pretty.c::add_rfc2047() still decides
where to split the output line by going through the input
one byte at a time, and potentially splits a character in
the middle.  A subject line may end up showing like this:

     ".... f=F6?? bar".   (instead of  ".... f=F6=F6 bar".)

if split incorrectly.

RFC 2047, section 5 (3) explicitly forbids such behaviour

    Each 'encoded-word' MUST represent an integral number of
    characters.  A multi-octet character may not be split across
    adjacent 'encoded- word's.

that means that e.g. for

    Subject: .... f=F6=F6 bar

encoding

    Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
     =3D?UTF-8?q?=3D20bar?=3D

is correct, and

    Subject: =3D?UTF-8?q?....=3D20f=3DC3=3DB6=3DC3?=3D      <-- NOTE =F6=
 is broken here
     =3D?UTF-8?q?=3DB6=3D20bar?=3D

is not, because "=F6" character UTF-8 encoding C3 B6 is split here acro=
ss
adjacent encoded words.

To fix the problem, make the loop grab one _character_ at a time and
determine its output length to see where to break the output line.  Not=
e
that this version only knows about UTF-8, but the logic to grab one
character is abstracted out in mbs_chrlen() function to make it possibl=
e
to extend it to other encodings with the help of iconv in the future.

(With help from Junio C Hamano <gitster@pobox.com>)
Cc: Jan H. Sch=F6nherr <schnhrr@cs.tu-berlin.de>
Signed-off-by: Kirill Smelkov <kirr@mns.spb.ru>
---
 pretty.c                | 34 ++++++++++++++++++++++------------
 t/t4014-format-patch.sh | 27 ++++++++++++++-------------
 utf8.c                  | 39 +++++++++++++++++++++++++++++++++++++++
 utf8.h                  |  2 ++
 4 files changed, 77 insertions(+), 25 deletions(-)

diff --git a/pretty.c b/pretty.c
index b57adef..41f04e6 100644
--- a/pretty.c
+++ b/pretty.c
@@ -345,7 +345,7 @@ static int needs_rfc2047_encoding(const char *line,=
 int len,
 	return 0;
 }
=20
-static void add_rfc2047(struct strbuf *sb, const char *line, int len,
+static void add_rfc2047(struct strbuf *sb, const char *line, size_t le=
n,
 		       const char *encoding, enum rfc2047_type type)
 {
 	static const int max_encoded_length =3D 76; /* per rfc2047 */
@@ -355,9 +355,22 @@ static void add_rfc2047(struct strbuf *sb, const c=
har *line, int len,
 	strbuf_grow(sb, len * 3 + strlen(encoding) + 100);
 	strbuf_addf(sb, "=3D?%s?q?", encoding);
 	line_len +=3D strlen(encoding) + 5; /* 5 for =3D??q? */
-	for (i =3D 0; i < len; i++) {
-		unsigned ch =3D line[i] & 0xFF;
-		int is_special =3D is_rfc2047_special(ch, type);
+
+	while (len) {
+		/*
+		 * RFC 2047, section 5 (3):
+		 *
+		 * Each 'encoded-word' MUST represent an integral number of
+		 * characters.  A multi-octet character may not be split across
+		 * adjacent 'encoded- word's.
+		 */
+		const unsigned char *p =3D (const unsigned char *)line;
+		int chrlen =3D mbs_chrlen(&line, &len, encoding);
+		int is_special =3D (chrlen > 1) || is_rfc2047_special(*p, type);
+
+		/* "=3D%02X" * chrlen, or the byte itself */
+		const char *encoded_fmt =3D is_special ? "=3D%02X"    : "%c";
+		int	    encoded_len =3D is_special ? 3 * chrlen : 1;
=20
 		/*
 		 * According to RFC 2047, we could encode the special character
@@ -367,18 +380,15 @@ static void add_rfc2047(struct strbuf *sb, const =
char *line, int len,
 		 * causes ' ' to be encoded as '=3D20', avoiding this problem.
 		 */
=20
-		if (line_len + 2 + (is_special ? 3 : 1) > max_encoded_length) {
+		if (line_len + encoded_len + 2 > max_encoded_length) {
+			/* It won't fit with trailing "?=3D" --- break the line */
 			strbuf_addf(sb, "?=3D\n =3D?%s?q?", encoding);
 			line_len =3D strlen(encoding) + 5 + 1; /* =3D??q? plus SP */
 		}
=20
-		if (is_special) {
-			strbuf_addf(sb, "=3D%02X", ch);
-			line_len +=3D 3;
-		} else {
-			strbuf_addch(sb, ch);
-			line_len++;
-		}
+		for (i =3D 0; i < chrlen; i++)
+			strbuf_addf(sb, encoded_fmt, p[i]);
+		line_len +=3D encoded_len;
 	}
 	strbuf_addstr(sb, "?=3D");
 }
diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 78633cb..b993dae 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -837,25 +837,26 @@ Subject: [PATCH] =3D?UTF-8?q?f=3DC3=3DB6=3DC3=3DB=
6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
  =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
  =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
  =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC=
3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3?=3D
- =3D?UTF-8?q?=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=
=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
- =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC=
3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB=
6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20=
f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f?=3D
+ =3D?UTF-8?q?=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D=
20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar?=3D
+ =3D?UTF-8?q?=3D20f=3DC3=3DB6=3DC3=3DB6=3D20bar=3D20f=3DC3=3DB6=3DC3=3D=
B6=3D20bar=3D20f=3DC3=3DB6=3DC3=3DB6=3D20?=3D
+ =3D?UTF-8?q?bar?=3D
 EOF
 test_expect_success 'format-patch wraps extremely long subject (rfc204=
7)' '
 	rm -rf patches/ &&
diff --git a/utf8.c b/utf8.c
index 8f6e84b..7f64857 100644
--- a/utf8.c
+++ b/utf8.c
@@ -531,3 +531,42 @@ char *reencode_string(const char *in, const char *=
out_encoding, const char *in_e
 	return out;
 }
 #endif
+
+/*
+ * Returns first character length in bytes for multi-byte `text` accor=
ding to
+ * `encoding`.
+ *
+ * - The `text` pointer is updated to point at the next character.
+ * - When `remainder_p` is not NULL, on entry `*remainder_p` is how mu=
ch bytes
+ *   we can consume from text, and on exit `*remainder_p` is reduced b=
y returned
+ *   character length. Otherwise `text` is treated as limited by NUL.
+ */
+int mbs_chrlen(const char **text, size_t *remainder_p, const char *enc=
oding)
+{
+	int chrlen;
+	const char *p =3D *text;
+	size_t r =3D (remainder_p ? *remainder_p : SIZE_MAX);
+
+	if (r < 1)
+		return 0;
+
+	if (is_encoding_utf8(encoding)) {
+		pick_one_utf8_char(&p, &r);
+
+		chrlen =3D p ? (p - *text)
+			   : 1 /* not valid UTF-8 -> raw byte sequence */;
+	}
+	else {
+		/*
+		 * TODO use iconv to decode one char and obtain its chrlen
+		 * for now, let's treat encodings !=3D UTF-8 as one-byte
+		 */
+		chrlen =3D 1;
+	}
+
+	*text +=3D chrlen;
+	if (remainder_p)
+		*remainder_p -=3D chrlen;
+
+	return chrlen;
+}
diff --git a/utf8.h b/utf8.h
index 501b2bd..1f8ecad 100644
--- a/utf8.h
+++ b/utf8.h
@@ -22,4 +22,6 @@ char *reencode_string(const char *in, const char *out=
_encoding, const char *in_e
 #define reencode_string(a,b,c) NULL
 #endif
=20
+int mbs_chrlen(const char **text, size_t *remainder_p, const char *enc=
oding);
+
 #endif
--=20
1.8.2.rc2.366.g3bc8dda
