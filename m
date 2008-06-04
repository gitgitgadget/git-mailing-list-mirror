From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] Strbuf documentation: document most functions
Date: Wed,  4 Jun 2008 23:20:05 +0200
Message-ID: <1212614405-22756-1-git-send-email-vmiklos@frugalware.org>
References: <7vzlq1y77h.fsf@gitster.siamese.dyndns.org>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	=?utf-8?q?Ren=E9=20Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 23:21:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K40Pc-0004Ni-3c
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 23:20:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753160AbYFDVUB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 17:20:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754001AbYFDVUB
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 17:20:01 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:52852 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761677AbYFDVUA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 17:20:00 -0400
Received: from vmobile.example.net (dsl5401CDCD.pool.t-online.hu [84.1.205.205])
	by yugo.frugalware.org (Postfix) with ESMTP id D66BB1DDC5B;
	Wed,  4 Jun 2008 23:19:56 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 7ECF318E2A7; Wed,  4 Jun 2008 23:20:05 +0200 (CEST)
X-Mailer: git-send-email 1.5.6.rc0.dirty
In-Reply-To: <7vzlq1y77h.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83829>

All functions in strbuf.h are documented, except launch_editor().

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Wed, Jun 04, 2008 at 12:45:06AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > +An strbuf is NUL terminated for convenience, but no function in the
> > +strbuf API actually relies on the string being free of NULs.
> >
> > +strbuf's are meant to be used with all the usual C string and
> > memory
> > +APIs. Given that the length of the buffer is known, it's often
> > better to
> > +use the mem* functions than a str* one (memchr vs. strchr e.g.).
> > +Though, one has to be careful about the fact that str* functions
> > often
> > +stop on NULs and that strbufs may have embedded NULs.
>
> I think these two paragraphs should be swapped.  The first two lines
> are
> only interesting after you establish what it is and what it is used
> for
> with the second paragraph.

Changed.

>
> > +However, it is totally safe to touch anything in the buffer pointed
> > by
> > +the `buf` member between the index `0` and `len` excluded.
>
> Somehow this "excluded" feels not quite right wording.
> Also "touch" is a fuzzy word.  I think.
>
>  - "sb->buf[i] = x" is Ok if and only if "0 <= i < sb->len";
>    col. "sb->buf[0] = 'x'" is a no-no if !sb->len.
>
>  - "if (!sb->buf[0])" is Ok even if !sb->len.

OK, reworded.

> > +NOTE: It is OK to "play" with the buffer directly if you work it
> > that
> > +      way:
>
> If you are refering to the example you talk next, s/that way/this
> way/.

Changed.

> > +strbuf_grow(sb, SOME_SIZE); <1>
> > +strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
> > +----
> > +<1> Here, the memory array starting at `buf`, and of length
>
> Here you should say `sb->buf` not just `buf`, as you are explaining
> this
> specific example that uses a concrete instance of strbuf `sb`.

Ah yes, fixed.

>
> > +`strbuf_avail(sb)` is all yours, and you can be sure that
> > +`strbuf_avail(sb)` is at least `SOME_SIZE`.
> > ++
> > +Of course, `SOME_OTHER_SIZE` must be smaller or equal to
> > `strbuf_avail(sb)`.
>
> It is not clear why this is "Of course" here in this document, because
> you
> haven't talked about what "setlen" is.  It is "Of course" only because
> setlen's sole purpose is to truncate and it cannot be used to extend
> the
> buffer (I won't discuss if that is a good API here).

Ok, changed it to a note.

> > +Doing so is safe, though if it has to be done in many places,
> > adding the
> > +missing API to the strbuf module is the way to go.
> > ++
> > +WARNING: Do _not_ assume that the area that is yours is of size
> > `alloc
> > +- 1` even if it's true in the current implementation. Alloc is
> > somehow a
> > +"private" member that should not be messed with.
>
> Talking about "don't" is important, but without guiding the reader
> with
> "instead of that, do this", the document becomes a frustrating read.

I added a sentence to use strbuf_avail() instead.

> > +This is string buffer structure. The `len` variable can be used to
> > +determine the current length of the string, and `buf` provides
> > access
> > +to the string itself.
>
> Call both consistently "member".  I.e. The `len` member can be ....

Ok, replaced.

> > +`strbuf_init`::
> > +
> > +   Initializes the structure. The second parameter can be zero or a
> > bigger
> > +   number to allocate memory, in case you want to prevent further
> > reallocs.
>
> When you start the sentence without a subject, use imperative mood,
> not
> third person singular, for consistency.  I.e. "Initialize the
> structure".
> This comment applies everywhere (you have mixed style).

Hm yes, fixed.

> > +`strbuf_detach`::
> > +
> > +   Detaches the string from the string buffer. The function returns
> > a
> > +   pointer to the old string and releases a buffer, so that if you
> > want to
> > +   use it again, you should initialize it before doing so.
>
> "Detaches the string from the strbuf and returns it; you now own the
> storage the string occupies and it is your responsibility from then on
> to
> release it with free(3) when you are done with it."
>
> The strbuf is reinitialized by detach, so there shouldn't be need for
> re-initializing it.

OK, changed.

> > +`strbuf_avail`::
> > +
> > +   Determines the amount of allocated but not used memory.
>
> s/not used/unused/;

Changed.

> > +`strbuf_grow`::
> > +
> > +   Ensure that at least this amount of available memory is
> > available. This
>
> "available memory is available"?  "Ensure that at least this amount of
> unused memory is available after `len`", perhaps.

Oh, yes. I wanted to say "this amount of memory is available".

> > +   is used when you know a typical size for what you will do and
> > want to
>
> s/you will do/you will add/;

Fixed.

> > +   avoid repetitive automatic resize of the underlying buffer. This
> > is
>
> s/resize/resizing/;

Replaced.

> > +* Adding data to the buffer
>
> You need a blanket comment to say "All of these functions will grow
> the
> buffer as necessary".

Right, added one.

> > +`strbuf_splice`::
> > +
> > +   Splice pos..pos+len with given data.
>
> Define "splice".  "Remove the bytes between pos..pos+len and replace
> it
> with the given data".

Changed.

>
> > +`strbuf_addbuf`::
> > +
> > +   Add an other buffer to the current one.
>
> Makes the reader wonder what happens to that other buffer after this
> operation.  "Copy the contents of the second buffer at the end of the
> first buffer", perhaps?

Yes, I improved the description to mention this.

 Documentation/technical/api-strbuf.txt |  239 +++++++++++++++++++++++++++++++-
 1 files changed, 237 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index a52e4f3..5e3d205 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -1,6 +1,241 @@
 strbuf API
 ==========
 
-Talk about <strbuf.h>
+strbuf's are meant to be used with all the usual C string and memory
+APIs. Given that the length of the buffer is known, it's often better to
+use the mem* functions than a str* one (memchr vs. strchr e.g.).
+Though, one has to be careful about the fact that str* functions often
+stop on NULs and that strbufs may have embedded NULs.
 
-(Pierre, JC)
+An strbuf is NUL terminated for convenience, but no function in the
+strbuf API actually relies on the string being free of NULs.
+
+strbufs has some invariants that are very important to keep in mind:
+
+. The `buf` member is never NULL, so you it can be used in any usual C
+string operations safely. strbuf's _have_ to be initialized either by
+`strbuf_init()` or by `= STRBUF_INIT` before the invariants, though.
++
+Do *not* assume anything on what `buf` really is (e.g. if it is
+allocated memory or not), use `strbuf_detach()` to unwrap a memory
+buffer from its strbuf shell in a safe way. That is the sole supported
+way. This will give you a malloced buffer that you can later `free()`.
++
+However, it it totally safe to modify anything in the string pointed by
+the `buf` member, between (including) the indexes `0` and `len -1`.
+
+. The `buf` member is a byte array that has at least `len + 1` bytes
+  allocated. The extra byte is used to store a `'\0'`, allowing the
+  `buf` member to be a valid C-string. Every strbuf function ensure this
+  invariant is preserved.
++
+NOTE: It is OK to "play" with the buffer directly if you work it this
+      way:
++
+----
+strbuf_grow(sb, SOME_SIZE); <1>
+strbuf_setlen(sb, sb->len + SOME_OTHER_SIZE);
+----
+<1> Here, the memory array starting at `sb->buf`, and of length
+`strbuf_avail(sb)` is all yours, and you can be sure that
+`strbuf_avail(sb)` is at least `SOME_SIZE`.
++
+NOTE: `SOME_OTHER_SIZE` must be smaller or equal to `strbuf_avail(sb)`.
++
+Doing so is safe, though if it has to be done in many places, adding the
+missing API to the strbuf module is the way to go.
++
+WARNING: Do _not_ assume that the area that is yours is of size `alloc
+- 1` even if it's true in the current implementation. Alloc is somehow a
+"private" member that should not be messed with. Use `strbuf_avail()`
+instead.
+
+Data structures
+---------------
+
+* `struct strbuf`
+
+This is string buffer structure. The `len` member can be used to
+determine the current length of the string, and `buf` provides access to
+the string itself.
+
+Functions
+---------
+
+* Life cycle
+
+`strbuf_init`::
+
+	Initialize the structure. The second parameter can be zero or a bigger
+	number to allocate memory, in case you want to prevent further reallocs.
+
+`strbuf_release`::
+
+	Release a string buffer and the memory it used. You should not use the
+	string buffer after using this function, unless you initialize it again.
+
+`strbuf_detach`::
+
+	Detaches the string from the strbuf and returns it; you now own the
+	storage the string occupies and it is your responsibility from then on
+	to release it with `free(3)` when you are done with it.
+
+`strbuf_attach`::
+
+	Attach a string to a buffer. You should specify the string to attach,
+	the current length of the string and the amount of allocated memory.
+	The amount must be larger than the string length, because the string you
+	pass is supposed to be a NUL-terminated string.  This string _must_ be
+	malloc()ed, and after attaching, the pointer cannot be relied upon
+	anymore, and neither be free()d directly.
+
+`strbuf_swap`::
+
+	Swap the contents of two string buffers.
+
+* Related to the size of the buffer
+
+`strbuf_avail`::
+
+	Determine the amount of allocated but unused memory.
+
+`strbuf_grow`::
+
+	Ensure that at least this amount of unused memory is available after
+	`len`. This is used when you know a typical size for what you will add
+	and want to avoid repetitive automatic resizing of the underlying buffer.
+	This is never a needed operation, but can be critical for performance in
+	some cases.
+
+`strbuf_setlen`::
+
+	Set the length of the buffer to a given value. This function does *not*
+	allocate new memory, so you should not perform a `strbuf_setlen()` to a
+	length that is larger than `len + strbuf_avail()`. `strbuf_setlen()` is
+	just meant as a 'please fix invariants from this strbuf I just messed
+	with'.
+
+`strbuf_reset`::
+
+	Empty the buffer by setting the size of it to zero.
+
+* Related to the contents of the buffer
+
+`strbuf_rtrim`::
+
+	Strip whitespace from the end of a string.
+
+`strbuf_cmp`::
+
+	Compare two buffers. Returns an integer less than, equal to, or greater
+	than zero if the first buffer is found, respectively, to be less than,
+	to match, or be greater than the second buffer.
+
+* Adding data to the buffer
+
+NOTE: All of these functions in this section will grow the buffer as
+      necessary.
+
+`strbuf_addch`::
+
+	Add a single character to the buffer.
+
+`strbuf_insert`::
+
+	Insert data to the given position of the buffer. The remaining contents
+	will be shifted, not overwritten.
+
+`strbuf_remove`::
+
+	Remove given amount of data from a given position of the buffer.
+
+`strbuf_splice`::
+
+	Remove the bytes between pos..pos+len and replace it with the given
+	data.
+
+`strbuf_add`::
+
+	Add data of given length to the buffer.
+
+`strbuf_addstr`::
+
+Add a NUL-terminated string to the buffer.
++
+NOTE: This function will *always* be implemented as an inline or a macro
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
+	Copy the contents of an other buffer at the end of the current one.
+
+`strbuf_adddup`::
+
+	Copy part of the buffer from a given position till a given length to the
+	end of the buffer.
+
+`strbuf_expand`::
+
+	This function can be used to expand a format string containing
+	placeholders. To that end, it parses the string and calls the specified
+	function for every percent sign found.
++
+The callback function is given a pointer to the character after the `%`
+and a pointer to the struct strbuf.  It is expected to add the expanded
+version of the placeholder to the strbuf, e.g. to add a newline
+character if the letter `n` appears after a `%`.  The function returns
+the length of the placeholder recognized and `strbuf_expand()` skips
+over it.
++
+All other characters (non-percent and not skipped ones) are copied
+verbatim to the strbuf.  If the callback returned zero, meaning that the
+placeholder is unknown, then the percent sign is copied, too.
++
+In order to facilitate caching and to make it possible to give
+parameters to the callback, `strbuf_expand()` passes a context pointer,
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
+	Read the contents of a given file descriptor. The third argument can be
+	used to give a hint about the file size, to avoid reallocs.
+
+`strbuf_read_file`::
+
+	Read the contents of a file, specified by its path. The third argument
+	can be used to give a hint about the file size, to avoid reallocs.
+
+`strbuf_getline`::
+
+	Read a line from a FILE* pointer. The second argument specifies the line
+	terminator character, typically `'\n'`.
+
+`stripspace`::
+
+	Strip whitespace from a buffer. The second parameter controls if
+	comments are considered contents to be removed or not.
+
+`launch_editor`::
-- 
1.5.6.rc0.dirty
