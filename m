From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Strbuf documentation: document most functions
Date: Wed,  4 Jun 2008 03:15:26 +0200
Message-ID: <1212542126-21514-1-git-send-email-vmiklos@frugalware.org>
References: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 03:16:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3hby-00004v-PL
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 03:16:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbYFDBPY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jun 2008 21:15:24 -0400
X-Warning: Original message contained 8-bit characters, however during
	   the SMTP transport session the receiving system did not announce
	   capability of receiving 8-bit SMTP (RFC 1651-1653), and as this
	   message does not have MIME headers (RFC 2045-2049) to enable
	   encoding change, we had very little choice.
X-Warning: We ASSUME it is less harmful to add the MIME headers, and
	   convert the text to Quoted-Printable, than not to do so,
	   and to strip the message to 7-bits.. (RFC 1428 Appendix A)
X-Warning: We don't know what character set the user used, thus we had to
	   write these MIME-headers with our local system default value.
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752284AbYFDBPY
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Jun 2008 21:15:24 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:46377 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752166AbYFDBPW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jun 2008 21:15:22 -0400
Received: from vmobile.example.net (catv-5062e605.catv.broadband.hu [80.98.230.5])
	by yugo.frugalware.org (Postfix) with ESMTP id 5A40D1DDC5B;
	Wed,  4 Jun 2008 03:15:19 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 163E318E2A7; Wed,  4 Jun 2008 03:15:26 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <1212447591-4870-1-git-send-email-vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83740>

All functions in strbuf.h are documented, except launch_editor().

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

Here is an improved version. Details below.

On Tue, Jun 03, 2008 at 01:00:33AM +0100, Johannes Schindelin <Johannes=
=2ESchindelin@gmx.de> wrote:
> In general, I'd rather leave the "->" from the members, since you hav=
e
> many instances where you access them with ".".

Ok, removed, except the code sniplet where the strbuf is obviously a
pointer.

> > +strbuf's can be use in many ways: as a byte array, or to store
> > arbitrary
> > +long, overflow safe strings.
>
> I think that you should not suggest using strbufs as byte array, even
> if
> that is certainly possible.  Rather, you should say something like:
>
>       An strbuf is NUL terminated for convenience, but no function in
>       the strbuf API actually relies on the string being free of NULs=
=2E

Changed.

> > +. The `->buf` member is always malloc-ed, hence strbuf's can be
> > used to
> > +  build complex strings/buffers whose final size isn't easily
> > known.
>
> Is this true?  I thought the initial string is empty, but not
> alloc'ed.
>
> So I'd rather have something like
>
>       The "buf" member is never NULL, so you can safely strcmp() it.

Right, corrected.

> I'd like to see a comment that strbuf's _have_ to be initialized
> either by
> strbuf_init() or by "=3D STRBUF_INIT" before the invariants, though.
>
> > +`strbuf_attach`::
> > +
> > +   Attaches a string to a buffer. You should specify the string to
> > attach,
> > +   the current length of the string and the amount of allocated
> > memory.
>
> ... This string _must_ be malloc()ed, and after attaching, the pointe=
r
> cannot be relied upon anymore, and neither be free()d directly.

Added. Also fixed the rest of the typos you pointed out.

On Tue, Jun 03, 2008 at 10:42:40AM +0200, Pierre Habouzit <madcoder@deb=
ian.org> wrote:
>   (1) it is totally safe to touch anything in the buffer pointed by
>   the
>       buf member between the index 0 and buf->len excluded.
>
>   (1b) what you write later: it's also possible to write after
>   buf->len
>        if not after strbuf_avail() _BUT_ then you have when you're
>        done
>        the task to reset the (2) invariant yourself, using
>        strbuf_setlen().
>
>   (2) ->buf[->len] =3D=3D '\0' holds _ALL TIME_.
>
>   (3) ->buf is never ever NULL so it can be used in any usual C strin=
g
>       ops safely.
>
>   (4) do NOT assume anything on what ->buf really is (allocated memor=
y
>       or not e.g.), use strbuf_detach to unwrap a memory buffer from
>       its
>       strbuf shell in a safe way. That is the sole supported way. Thi=
s
>       will give you a malloced buffer that you can later free().

Thanks, I improved the introduction including these, hopefully I haven'=
t
missing anything.

> > +* Life cycle
> > +
> > +`strbuf_init`::
> > +
> > +   Initializes the structure. The second parameter can be zero or =
a
> > bigger
> > +   number to allocate memory, in case you want to prevent further
> > reallocs.
>
>   I'd add that it is _MANDATORY_ to initialize strbufs, and that a
> static allocation (for global variables e.g.) can be done using
> the STRBUF_INIT static initializer.

Added.

>
> > +`strbuf_release`::
> > +
> > +   Releases a string buffer and the memory it used. You should not
> > use the
> > +   string buffer after using this function, unless you initialize
> > it again.
>
>   Actually this is wrong because strbuf_release performs a new init
> since init allocates 0 memory and that it's idiot-proof. But it could
> be
> changed in the future and it should not be relied upon.

That's why I think 'should' is the good term and not 'must'. I don't
think the reader should be informed of the current implementation.

> > +`strbuf_detach`::
> > +
> > +   Detaches the string from the string buffer. The function return=
s
> > a
> > +   pointer to the old string and empties the buffer.
>
>   Not really strbuf_detach unwraps the embedded buffer for sure, but
>   it
> doesn't "empties" the buffer, strbuf_detach is like strbuf_release:
> after a release, strbuf should be init-ed again (even if for now
> strbuf_release does so).

Right, thanks for pointing this out.

> > +`strbuf_attach`::
> > +
> > +   Attaches a string to a buffer. You should specify the string to
> > attach,
> > +   the current length of the string and the amount of allocated
> > memory.
>
>   In addition to what Johannes said: size must be > len. Because the
> string you pass is supposed to be a NUL-terminated string.

Added.

> > +`strbuf_grow`::
> > +
> > +   Allocated extra memory for the buffer.
>
>   I'd put that this way: ensure that at least this amount of availabl=
e
> memory is available. This is used when you know a typical size for
> what
> you will do and want to avoid repetitive automatic resize of the
> underlying buffer. This is never a needed operation, but can be
> critical
> for performance in some cases.

Changed.

> > +`strbuf_setlen`::
> > +
> > +   Sets the length of the buffer to a given value.
>
>   This function does NOT allocate new memory, so you should not
>   perform
> a strbuf_setlen to a length that is larger than sb->len +
> strbuf_avail(sb).
> strbuf_setlen is just meant as a "please fix invariants from this
> strbuf
> I just messed with)"

Added.

> > +`strbuf_add`::
> > +
> > +   Add data of given length to the buffer.
> > +
> > +`strbuf_addstr`::
> > +
> > +   Add a NULL-terminated string to the buffer.
>
>   Please use NUL, '\0' is NUL (as in its ascii name), NULL is (void
>   *)0.
> In addition to that, I'd say that strbuf_addstr will ALWAYS be
> implemented as an inline or a macro that expands to:
>   strbuf_add(..., s, strlen(s))
>
> Meaning that this is efficient to write things like:
>   strbuf_addstr(sb, "immediate string").

Changed and added.

> > +`strbuf_expand`::
>
>   This function is a pretty printer that expands magic formats string
> thanks to callbacks, so that it's done in a generic way. It's what is
> used to generate git-log e.g. I'm not its author, so I'm not really
> best
> placed to describe it.

OK. ;-)

> > +`strbuf_fread`::
> > +
> > +   Read a given size of data from a FILE* pointer to the buffer.
> > +
> > +`strbuf_read`::
> > +
> > +   Read the contents of a given file descriptor. The third argumen=
t
> > can be
> > +   used to give a hint about the file, to avoid reallocs.
> > +
> > +`strbuf_read_file`::
> > +
> > +   Read the contents of a file, specified by its path. The third
> > argument
> > +   can be used to give a hint about the file, to avoid reallocs.
> > +
> > +`strbuf_getline`::
> > +
> > +   Read a line from a FILE* pointer. The second argument specifies
> > the line
> > +   terminator character, like `'\n'`.
> > +
>
>   For all: the buffer is rewinded if the read fails.
>   If -1 is returned, errno must be consulted, like you would do for
> read(3).

Added.

> >     An strbuf is NUL terminated for convenience, but no function in
> >     the strbuf API actually relies on the string being free of NULs=
=2E
>
>   ACK. I'd add the fact that strbuf are meant to be used with all the
> usual C string and memory APIs. Given that the length of the buffer i=
s
> known, it's often better to use the mem* functions than a str* one
> (memchr vs. strchr e.g.). Though, one has to be careful about the fac=
t
> that str* functions often stop on NULs and that strbufs may have
> embedded NULs.

Added.

On Tue, Jun 03, 2008 at 05:41:38PM +0200, Ren=E9 Scharfe <rene.scharfe@=
lsrfire.ath.cx> wrote:
> > Actually this is a bit of request for help, I haven't figured out
> > what
> > strbuf_expand() does [...]
>
> It can be used to expand a format string containing placeholders.  To
> that end, it parses the string and calls the specified function for
> every percent sign found.
>
> The callback function is given a pointer to the character after the
> '%'
> and a pointer to the struct strbuf.  It is expected to add the
> expanded
> version of the placeholder to the strbuf, e.g. to add a newline
> character if the letter 'n' appears after a '%'.  The function return=
s
> the length of the placeholder recognized and strbuf_expand skips over
> it.
>
> All other characters (non-percent and not skipped ones) are copied
> verbatim to the strbuf.  If the callback returned zero, meaning that
> the
> placeholder is unknown, then the percent sign is copied, too.
>
> In order to facilitate caching and to make it possible to give
> parameters to the callback, strbuf_expand passes a context pointer,
> which can be used by the programmer of the callback as she sees fit.

Thanks, added.

 Documentation/technical/api-strbuf.txt |  234 ++++++++++++++++++++++++=
+++++++-
 1 files changed, 232 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/tec=
hnical/api-strbuf.txt
index a52e4f3..15f66b2 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -1,6 +1,236 @@
 strbuf API
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=20
-Talk about <strbuf.h>
+An strbuf is NUL terminated for convenience, but no function in the
+strbuf API actually relies on the string being free of NULs.
=20
-(Pierre, JC)
+strbuf's are meant to be used with all the usual C string and memory
+APIs. Given that the length of the buffer is known, it's often better =
to
+use the mem* functions than a str* one (memchr vs. strchr e.g.).
+Though, one has to be careful about the fact that str* functions often
+stop on NULs and that strbufs may have embedded NULs.
+
+strbufs has some invariants that are very important to keep in mind:
+
+. The `buf` member is never NULL, so you it can be used in any usual C
+string operations safely. strbuf's _have_ to be initialized either by
+`strbuf_init()` or by `=3D STRBUF_INIT` before the invariants, though.
++
+Do *not* assume anything on what `buf` really is (e.g. if it is
+allocated memory or not), use `strbuf_detach()` to unwrap a memory
+buffer from its strbuf shell in a safe way. That is the sole supported
+way. This will give you a malloced buffer that you can later `free()`.
++
+However, it is totally safe to touch anything in the buffer pointed by
+the `buf` member between the index `0` and `len` excluded.
+
+. The `buf` member is a byte array that has at least `len + 1` bytes
+  allocated. The extra byte is used to store a `'\0'`, allowing the
+  `buf` member to be a valid C-string. Every strbuf function ensure th=
is
+  invariant is preserved.
++
+NOTE: It is OK to "play" with the buffer directly if you work it that
+      way:
++
+----
+strbuf_grow(sb, SOME_SIZE); <1>
+strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+----
+<1> Here, the memory array starting at `buf`, and of length
+`strbuf_avail(sb)` is all yours, and you can be sure that
+`strbuf_avail(sb)` is at least `SOME_SIZE`.
++
+Of course, `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail=
(sb)`.
++
+Doing so is safe, though if it has to be done in many places, adding t=
he
+missing API to the strbuf module is the way to go.
++
+WARNING: Do _not_ assume that the area that is yours is of size `alloc
+- 1` even if it's true in the current implementation. Alloc is somehow=
 a
+"private" member that should not be messed with.
+
+Data structures
+---------------
+
+* `struct strbuf`
+
+This is string buffer structure. The `len` variable can be used to
+determine the current length of the string, and `buf` provides access
+to the string itself.
+
+Functions
+---------
+
+* Life cycle
+
+`strbuf_init`::
+
+	Initializes the structure. The second parameter can be zero or a bigg=
er
+	number to allocate memory, in case you want to prevent further reallo=
cs.
+
+`strbuf_release`::
+
+	Releases a string buffer and the memory it used. You should not use t=
he
+	string buffer after using this function, unless you initialize it aga=
in.
+
+`strbuf_detach`::
+
+	Detaches the string from the string buffer. The function returns a
+	pointer to the old string and releases a buffer, so that if you want =
to
+	use it again, you should initialize it before doing so.
+
+`strbuf_attach`::
+
+	Attaches a string to a buffer. You should specify the string to attac=
h,
+	the current length of the string and the amount of allocated memory.
+	The amount must be larger than the string length, because the string =
you
+	pass is supposed to be a NUL-terminated string.  This string _must_ b=
e
+	malloc()ed, and after attaching, the pointer cannot be relied upon
+	anymore, and neither be free()d directly.
+
+`strbuf_swap`::
+
+	Swaps the contents of two string buffers.
+
+* Related to the size of the buffer
+
+`strbuf_avail`::
+
+	Determines the amount of allocated but not used memory.
+
+`strbuf_grow`::
+
+	Ensure that at least this amount of available memory is available. Th=
is
+	is used when you know a typical size for what you will do and want to
+	avoid repetitive automatic resize of the underlying buffer. This is
+	never a needed operation, but can be critical for performance in some
+	cases.
+
+`strbuf_setlen`::
+
+	Sets the length of the buffer to a given value. This function does *n=
ot*
+	allocate new memory, so you should not perform a `strbuf_setlen()` to=
 a
+	length that is larger than `len + strbuf_avail()`. `strbuf_setlen()` =
is
+	just meant as a 'please fix invariants from this strbuf I just messed
+	with'.
+
+`strbuf_reset`::
+
+	Empties the buffer by setting the size of it to zero.
+
+* Related to the contents of the buffer
+
+`strbuf_rtrim`::
+
+	Strip whitespace from the end of a string.
+
+`strbuf_cmp`::
+
+	Compares two buffers. Returns an integer less than, equal to, or grea=
ter
+	than zero if the first buffer is found, respectively, to be less than=
,
+	to match, or be greater than the second buffer.
+
+* Adding data to the buffer
+
+`strbuf_addch`::
+
+	Adds a single character to the buffer.
+
+`strbuf_insert`::
+
+	Insert data to the given position of the buffer. The remaining conten=
ts
+	will be shifted, not overwritten.
+
+`strbuf_remove`::
+
+	Remove given amount of data from a given position of the buffer.
+
+`strbuf_splice`::
+
+	Splice pos..pos+len with given data.
+
+`strbuf_add`::
+
+	Add data of given length to the buffer.
+
+`strbuf_addstr`::
+
+Add a NUL-terminated string to the buffer.
++
+NOTE: This function will *always* be implemented as an inline or a mac=
ro
+that expands to:
++
+----
+strbuf_add(..., s, strlen(s));
+----
++
+Meaning that this is efficient to write things like:
++
+----
+strbuf_addstr(sb, "immediate string");
+----
+
+`strbuf_addbuf`::
+
+	Add an other buffer to the current one.
+
+`strbuf_adddup`::
+
+	Copy part of the buffer from a given position till a given length to =
the
+	end of the buffer.
+
+`strbuf_expand`::
+
+	This function can be used to expand a format string containing
+	placeholders. To that end, it parses the string and calls the specifi=
ed
+	function for every percent sign found.
++
+The callback function is given a pointer to the character after the `%=
`
+and a pointer to the struct strbuf.  It is expected to add the expande=
d
+version of the placeholder to the strbuf, e.g. to add a newline
+character if the letter `n` appears after a `%`.  The function returns
+the length of the placeholder recognized and `strbuf_expand()` skips
+over it.
++
+All other characters (non-percent and not skipped ones) are copied
+verbatim to the strbuf.  If the callback returned zero, meaning that t=
he
+placeholder is unknown, then the percent sign is copied, too.
++
+In order to facilitate caching and to make it possible to give
+parameters to the callback, `strbuf_expand()` passes a context pointer=
,
+which can be used by the programmer of the callback as she sees fit.
+
+`strbuf_addf`::
+
+	Add a formatted string to the buffer.
+
+`strbuf_fread`::
+
+	Read a given size of data from a FILE* pointer to the buffer.
++
+NOTE: The buffer is rewinded if the read fails. If -1 is returned,
+`errno` must be consulted, like you would do for `read(3)`.
+`strbuf_read()`, `strbuf_read_file()` and `strbuf_getline()` has the
+same behaviour as well.
+
+`strbuf_read`::
+
+	Read the contents of a given file descriptor. The third argument can =
be
+	used to give a hint about the file size, to avoid reallocs.
+
+`strbuf_read_file`::
+
+	Read the contents of a file, specified by its path. The third argumen=
t
+	can be used to give a hint about the file size, to avoid reallocs.
+
+`strbuf_getline`::
+
+	Read a line from a FILE* pointer. The second argument specifies the l=
ine
+	terminator character, typically `'\n'`.
+
+`stripspace`::
+
+	Strips whitespace from a buffer. The second parameter controls if
+	comments are considered contents to be removed or not.
+
+`launch_editor`::
--=20
1.5.6.rc0.dirty
